Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71740CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jr-0005vW-BR; Wed, 14 Oct 2026 20:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jq-0005vM-19
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jo-0002st-Gn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMHQta4167548
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aeFvF1sxVZV
 i5cTmwn8G4g36ygtIjCdU/WXzNjPAWF8=; b=pwI0qup8qJwG4tcuGjVZL0xnnLr
 mbX7VHggfd8pWPV9ktumiWH4w/bUoP2gfws0S+xconNp1guBXoMLpnMhL3xpEm+N
 zAoEtw0NB4hSKkryyOGWkjBGNYn6qcTRAePerUR3ltktUhKo8g94P87BDj6SrHT4
 FXZbMJQ+5BgNhWMpeMe6MJILlUpiRNm2u/+3sHgjkmqZ37Dtr9lhv74XdgkrrT2J
 +NbOFkGcn9whiu9/2lD+iP7kZ8Z63Oah1CgXVyBe7vtPdK2zb/Qvk9Eo+kdwxFUI
 yPM/jYVeM3ubxhiq+J+2b4/EpMKpKyNUlEeVTcrQLp+WfWmWE0n40NWTnSg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac232112-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so9088749eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025666; x=1792630466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aeFvF1sxVZVi5cTmwn8G4g36ygtIjCdU/WXzNjPAWF8=;
 b=Ta32rYiXKxcwmGjHuVCwvzo/Y/9F+jEAgbeMS9DP2Il0qWbytPXsTCDIyzuGMSFY60
 VAkglWV90HfBJuQHbiZQX7NT0DzGrBWdc/fkvUFMFOWXNP8cTssvysE2w9XfXQ7fVH+D
 f9HyXVFyJ+0KMnRzr4UMKvauS8cutyvke1LAujQjSSdu1vfREajazBhUAH3ppJ9z7ngM
 VNG0hyid1EjXkgo4K1dXhA35OMCXlLEuF6znoHqZd7f4Vhx/MvoKqMtrAC9Gv/tfuQJe
 j17Dn7cT8GE1Aj7Y5aZQRCXzhekibtBi3U25Ef5c2psesQdGikYZJ80fikuIpaJT1NW2
 fzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025666; x=1792630466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aeFvF1sxVZVi5cTmwn8G4g36ygtIjCdU/WXzNjPAWF8=;
 b=stFfwwd5l8kw0sUzwArwvKol4E/Fa4EuM0hJdeYGzxS51leWDtX/6DQN2D4IA74vVW
 qHeF/ZmDTkoyrR+fO/dHMzPlS8hgtVZddh7IJErERPQxE+7LL9ZqHF6obJ125Gkkkwto
 tEtqbIS4qvY6ROiCLrUYfeKO77hFGw9Qcw3jb5mVsb7WphbSAWaE48hfeb2um0aXtnsk
 v5bRRuyMEyylsHyeQh16ZbTf+HAT1IMXB+NXCy/kBDy5guG1PZnYJ5STOjZ/bxQgu/xj
 AGkRtOue9hDi9s+Co9VJ6YggEJXFcv62IhmibAaaigh73CCGVXiYO+/BArTlO2zDgas/
 5JHQ==
X-Gm-Message-State: AFq9FYI9gOI1Wc/wqgO6Q+wCPaP7kbOsBkyMwskZc1GFzhHoqAaHCZFM
 XOyGFtb7iHvd1V5aVCLh2Fw/6tXQWVY5xs7VH4DhTQzSZJQXBv+7sQFqreMPRaW4fTLEtO+G35+
 9HSE0cO2KiGqKLHOJkrKwftLzOCjQ2pz8UOycUiu4n4eHEs+Kg1yPj4l5E86QOvqT7A==
X-Gm-Gg: AYBFou0NXw7kykvm7Rl7KsnidOPO/F2Bb5DOPrJeksiTvsae+bf5XSpW0JJHjwPx80C
 m1aUs6b1H/gio/OwsR+0wNx1zglyPHGB66ghNq3I9NwFF387NKozg2cveT/wcgjxO6QLpLfxDBC
 +tUZM+aUkRu5TzLC/HlNtutoS+yfhzXQge7ZU+07MJrpCbGLc1y/a7yyx9saqI4X+gJOLtbVzBl
 QFp/7A33aRUKRBwdU46DRMOCtGo42PHWFDb6RKmfnR1Ijt2xxPTlDuP2L2D1qRK2ZwM7JKu0+v0
 eSfkyP92GyCJhMGDv4TpabLQTSUcEkoc/EhdrwQk+/SQa7vNNZp0TuPwOa1LzgtmzUgh2A06zKj
 2zKNID63kHE8hLqM87OIPrUpTpfj2sKB5FlRwg/6yrf0bEGHEytqaLHfBuZPc
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id
 5a478bee46e88-3537db99e8amr32425918eec.0.1792025666237; 
 Wed, 14 Oct 2026 17:54:26 -0700 (PDT)
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id
 5a478bee46e88-3537db99e8amr32425881eec.0.1792025665657; 
 Wed, 14 Oct 2026 17:54:25 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 7/8] target/s390x: rename qmp_query_cpu_definitions to
 qmp_query_s390x_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:54 +0000
Message-ID: <20261015005355.62406-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6ad02443 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=TFVjfJh_qMAxUqWwv-MA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX+8STEBf8bvbJ
 l0vn7Bx09V4/FKajWJ/305G8n22znwuLTO0EDVxRQfrTLgK0fGi1kKhb7X3ZF86P3QNFpwD0u03
 bM+DC1Sz5nQEp+j+4rwtJcPKYrPXxuw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX+w9blzQeRRW0
 EzYoqPO3FCrY8BO0qtHDpBmHs+ozssQ2cp01+MnYuEAF4Oyk6BpdSMSrja7MnAujdJ/uKqXxHGQ
 gt2rfzM985jd8WK1f4Lf44FFh9Me08KuEnkypQrNXGiMcIUOwe6uZUVk2IGFOMY2tSOhn0TVT/O
 2K3Fc0CEeLdcs91hSWo1pG7+hgq6gWg8kP7ypoi/DyP2R2freaCsBjrJ9rgleeKtpHJ6lf1nHBp
 Y6l/2qhas6RDjl64tZ994fz+7HU6rZVz1S+QtMw8qEg2RIc8gRsnQcuDSroGxflOiGNGv0qZbWl
 rAYMRO+wxXHLe1MDAkPZYE9GWtZnyeLDgIeGitBPm0p79WOR+FsA26k/Jen6lXLnjxB9mQDs5BL
 roy41FxupoZ0VK5sdbFr4BzRt2qXvNq/5LdIREiTAuzaTYv4k8T/WRu0baswsLkiHUO0le+buGI
 KNQCL0xOYVBwgz5KcuQ==
X-Proofpoint-GUID: 5EX-N78ZKHzG6Cr9DttLc-3DJXbtU0wo
X-Proofpoint-ORIG-GUID: 5EX-N78ZKHzG6Cr9DttLc-3DJXbtU0wo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h         | 1 +
 target/s390x/cpu_models_system.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index c1bfdd679e2..f0e0d427e3b 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -15,5 +15,6 @@ CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 5b846048675..f963ca5248a 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -20,6 +20,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 
 static void list_add_feat(const char *name, void *opaque);
 
@@ -82,7 +83,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
 {
     struct CpuDefinitionInfoListData list_data = {
         .list = NULL,
@@ -96,6 +97,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return list_data.list;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_s390x_cpu_definitions(errp);
+}
+
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
                                 const char *info_arg_name, Error **errp)
 {
-- 
2.43.0


