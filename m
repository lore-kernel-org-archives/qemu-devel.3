Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B4ACC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gU-00074B-9V; Wed, 14 Oct 2026 19:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gP-00072W-C6
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gK-0006Sl-V3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENVBiU596302
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PzEvzjpfkfs
 QpL/7YFQrkEchoYkYion+QQHYEXunA3c=; b=dUERUkwAalULdVVcmWS1VEGxVqG
 fioEjVK9BMgtvNEcKwTwDZFrJlPNZZ/aC5wzYKH4hIakPQIf1W7khgV/g1e4kA2a
 sq4RP++DsNaLfyJ49zPlFL2W7YgTjOBvsRraxxo4UHwRKkHUmCiSVUiQLOQ50zhB
 Ql3xH9NLxFD1vLhOoNEq4UUeq6+849YtHmUcC5C+wb+e9RSDqV//vT7VXd5EavqV
 YYShkZjt72FAcotY0qGBZBE68nKskIEluZIzmqKTJN5DH3IiaOu3cAxykvmOkfez
 EU9DW10DrgpAovKN7I+pNhoxfJ8MdueZUqymB6+U9Rc8Xmar/N7/IGTSbgw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakder1xj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3592749a017so1467987eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021597; x=1792626397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PzEvzjpfkfsQpL/7YFQrkEchoYkYion+QQHYEXunA3c=;
 b=BW2cdLiah4ASFBf759WPZsRJuH8dgPaTmvwhEuZ6I+ifHRh/+z4gpiTdaQ33NYPGJH
 5V2L0jH/YYb1eB84i4qWB7+bvKYmEBQpnF+A9G44W5ALFllQrh5I4G4kRj31Nx263YQA
 TDM+XxluwMSNBciAH2g0c9npX6xipfo9gawrUTTjdXByVMzj/rw+6m8Rp96PA+81aY1u
 Op6otNGqAptflNpibG3ttuzCA3navmAOWApWpuMMhqz3ticeNFUGEcUVAtLnqJWYuKLG
 VPSaPs+GigKi8vGrcR7xTfmuFE7PTgG3DqNj1gxKsYsVDKvvAzhETLfQiyMnRTdbmS7U
 cJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021597; x=1792626397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PzEvzjpfkfsQpL/7YFQrkEchoYkYion+QQHYEXunA3c=;
 b=VEa83J0SHuZ2Av4fxU3yWWy9yWpag3731UyfW9y2rD8Yy3cDbU5hRuudS7KhVGCmA+
 ECZytv7N9LAdE5XygiiNTdPgXWx0M3/LFcdAQwKmaehJH9rQw2MLxcMGY9fmsgcKKQsL
 1dxJBBy+IhRNxif39Y7HdpsD2uZ1UNadBHlVgZeLK4saVWRJ4ypLICY3mo81ilrx7hJJ
 mpFXGMjIGi1yLOJUh2MXZOl6XMbbriTo5sAwLb3ncbgakJ8MMAn+F/SP4Mebe5VHuFKT
 5gPxX9BcwynLplNB7edbA80bXsxfftkHLLDovEQLeYTAm4BtcBOoEzyt4jqs2FnwVlcS
 M9yQ==
X-Gm-Message-State: AFq9FYKTqUlYqpblwyDn5V3FwS+JDX7ao36V/zmR5PDa7lYtC4u4Rc7B
 2sOddAATZZwH06/7SKa0sM5GoWWU7YcDiXR3JFfLWqQUiS0NnC7kiKG1EYKnbDtKMuYenUkRnBs
 y8Ogqg/t6m6+CaI1gsjEWSBX9GXEyJK8mEahK8sq5xEo+dUe3QPrBAu6NvM1icIbcAA==
X-Gm-Gg: AYBFou2E47xCKK3bH2Nxvb7UvJUbZOTg0DaGOH9kLszUGxlQUfZBrP3pHikgpvkjE65
 buAz5tenfq47NxUGFVODqjbGu45FruLouI3jLDmTDScY8cKTg+JiLjFyysBw6MNGM4KlNce91x/
 vkCoCtQaIYbiCYbBo+dlhrz2Z28/R3QtDurY5g86mIvnFyKggc1l7bm/GU/XoFnTQVOVUwIjExA
 lOANEHkLj4lo3txWx9CCQ/L4zyt49mEShtJrvuqX7NN0seVBT30wG0B2mlDECluKYDs5zcvKfhO
 e4rgL5ID++OO809m+UARYVy4jolE2fyPJHVYnVXVNA97XPrbGoAK/OJmN5qa7p+ctg1KxtiUizR
 VCBjg9SbvBk5umJPXnAqvNv8qjbxOt1DieYQNwwVJ5N94wku/g0I7XIhrUxJB
X-Received: by 2002:a05:693c:8347:b0:35c:49b9:3166 with SMTP id
 5a478bee46e88-35c49b93e3emr9357521eec.6.1792021597001; 
 Wed, 14 Oct 2026 16:46:37 -0700 (PDT)
X-Received: by 2002:a05:693c:8347:b0:35c:49b9:3166 with SMTP id
 5a478bee46e88-35c49b93e3emr9357487eec.6.1792021596411; 
 Wed, 14 Oct 2026 16:46:36 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 17/19] target/loongarch: implement get_note_size dump op
Date: Wed, 14 Oct 2026 23:46:03 +0000
Message-ID: <20261014234605.209084-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0145e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=PtlCrUUUHtpZVlCOPA8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: HRDPmzr6YM8XB3ScIvoWkMbaXKi1iX0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXzPorh+hGoFkH
 q3X/zFPQ73xLHltQygqg59jb0I73NWYYtofzbhdrhmHglc0HHWCDrdV62LinuyQ6swM51bAcrbV
 BtHlwpZD15AZH4Ny0ewW9Mhs7f7hHR73uF8x41aZy+ISpkPfJS1ZnBADdcEwx5w/Avxfn+LmgWx
 K9bG4b2i7FKKyXyYvPYi0GWP8kTzOgErOKAKRbv9oAuy3q0TTLXubARkuxwhjwkkMlaY6hgr3ap
 RvDseiLT6uXs550wCIO+BFrxgjujInuMHdQ9Fh+FcTCf9BCYfTzK3en3habe7reGkS21JXRadEs
 N3y11hAu0nR2XFIUlDVfWE2XjKur2DYlN/eFyrhuIomeCTgUqumdAdz7JLng+NP5XJDrsUdq7r8
 Ak4pErGUxFFhwnZh1yLx5LlVNraSxjiTAP/AbKI2a9rt4HF0uCxPd1fAIsB+piKb+dITNL0jb2f
 Dpg17rzbbgPEvMVfVhw==
X-Proofpoint-GUID: HRDPmzr6YM8XB3ScIvoWkMbaXKi1iX0l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX9kYu+9NMuE4F
 4iD0wxBRVu697ZISjKFSBCOU5XkPfOaGIPmveUd2cShTkC1GIMDLC44+CIIgFEWelbY1aPflKnc
 S7+obntfRWabuchpbt2uGW1P1NaWrG4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 6bd83b4be61..512f2d9f63b 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -153,11 +153,8 @@ static int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-const DumpCPUOps loongarch_dump_ops = {
-    .get_dump_info = loongarch_get_dump_info,
-};
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                       int machine, int nr_cpus)
 {
     size_t note_size = 0;
 
@@ -167,3 +164,13 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+const DumpCPUOps loongarch_dump_ops = {
+    .get_dump_info = loongarch_get_dump_info,
+    .get_note_size = loongarch_get_note_size,
+};
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
+}
-- 
2.43.0


