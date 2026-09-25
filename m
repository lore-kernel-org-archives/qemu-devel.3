Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0BCC98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7u-00089x-Cq; Fri, 25 Sep 2026 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7r-00087a-5r
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7n-0000ds-Np
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0KYh1363024
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GUM3e6wkEz9
 r1z5IYI8Mt+VLI8pvIq1l7lXGzBmHbnA=; b=QQqe1bMofrG18SlaZcAHpc6Lk5i
 AaKGQ5G4hSHvYPjC0reiwtwqa6jsXKEJYfXqiIYlWeyzFAQchZC/Fx/98VnWWyQi
 C8FyfzEMdCsfPsuubFP+Ta8pk3Yvpzd+524FUVu+pQQohs1SXm2lHJnxFMUKVpAJ
 jLX45Q1iqHXg6s2SVMLHLXuFTFrI1te9GY6GhH93XIXe09fH3cr8wsA3T/Fu74fD
 COYoTvAFaWUrLOOrisfAU6VM+BL9ELj9uuF9J3tEeQ1Jg5IIIYC0KlLH66kyAzRa
 nx8cYCmpFbKqK9FoGeSVgXawwYaeeJDy0Y7yUrfGj3xqnDYGa14ZoLdlniw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-333543ac378so1525230eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358858; x=1790963658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GUM3e6wkEz9r1z5IYI8Mt+VLI8pvIq1l7lXGzBmHbnA=;
 b=Gv4yZjNEGVOu2lBhikezxwBllcze50YsxNKyoBuRg3pDIHRtCScCgGA17GDXZZZYGE
 a1K15TEDRytZ9qSHSVHgKLuIEA2evUB+FCJFl5+HwkoEg2hyEY6EyJwSIdIGuLvkQBWg
 4p0i81p0VG1uvN79K+CVannuvxEl9FjSloFbwjSnT1LVXkwhuICBT0tYV9cfHsUDkNPo
 mossfl65+EV3XKpb+GaHJtGQfsWy34MVSyYMjsZLcxUx+whMWYIc1o3RmyvZ2OfmVQJL
 +Ne3cHj/YOcS0+cZ9DX6D7+lb3sSd/By/erYzMLffK8GBy/nXHB1qDGvv1IZaY8m5krg
 eLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358858; x=1790963658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GUM3e6wkEz9r1z5IYI8Mt+VLI8pvIq1l7lXGzBmHbnA=;
 b=cpJj7oCIkszunvrtPDbrI8wPvG75mXXvr5kxA8Dzl54mRYHhdPCrT0l/YjL2AAHI8M
 NITbDpn1uN/fqL8mgr9DDWoFiiWWqO745/NpwyVPKroJiN1CgZm5P+V8sDzq6MTGZiEy
 2fCylUEPrulTYo7utAGKMKzmQXNW+dJ2xToifAdPq65392PcBHVym16YC50fb8F+Ct+I
 CLcSpQUQwydilcezcbHUg5uwCwfis0+mukPGV/WUDTqiXRSICDxVQQaqEjhAhpEPWZbA
 txYFSDNX8FJGU32yJgnwwKubyoXD99VbxCwoADdhRjBYxcq8JkRfaDPZFsuTXqB4gS/V
 875w==
X-Gm-Message-State: AFuF++k2Dfnrq7rnQKuoHOamgThl28iRxc3NDtuR1yReuwKIFDgxLBlE
 Db0NRVgnLZeajHJw4zXv1txCkNMwlJ2V/piDKKPRMrtfyld3Zcs+NSVt2UtkzG06PRD+YlEh72G
 HO0WOOZtKtXk6mjcOffYs9kRiCf4/sssmv0vj2Gh5EeRKUz6XazOUOKr96vI2oTSUww==
X-Gm-Gg: AYBFou0MyJhk5M5bHmNb82r/5lzHT06PrapMGTXHXWWbzTPZcI7b7SB2frx+O7oLRwI
 t3PA9KwbNRaZXC1S6uhmnZdOcNASOfGsxB+ZFYK+ipjdSQGIKkgnMXc9lDdaR0mwe0i2UaI2UYu
 cFV+v4iEsXoK5kikWO/Y8D/fL1juKdrX42ImOzYZUw3nQ31NPIVXfMQ8TigXZXRFiRl7jr2//Lj
 0pu7sHdkIf1ZAjm1w4iNMl3wNOtr1kDByJL6vV22HbE5iNZx6pfhFVmHVvdnxiIyr/9RCy/lCxk
 bkkT5bfcQfk9wOHNqJkHk3OBfl5nqWmQG4NQR7sxOx83hU3888HtmxzCefkIVDrHpR2z1FMrWzI
 eguRTalK/MGF7AtqLyUrnPO8vwrEb7/XywstpWTVANse+gbGCERYWW5k1fw==
X-Received: by 2002:a05:693c:2a08:b0:33b:7fff:dfea with SMTP id
 5a478bee46e88-342700bf366mr846802eec.2.1790358857502; 
 Fri, 25 Sep 2026 10:54:17 -0700 (PDT)
X-Received: by 2002:a05:693c:2a08:b0:33b:7fff:dfea with SMTP id
 5a478bee46e88-342700bf366mr846777eec.2.1790358856726; 
 Fri, 25 Sep 2026 10:54:16 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/13] tests/tcg/loongarch64/system: deactivate
 loongarch64-softmmu-memory (hang on aarch64 host)
Date: Fri, 25 Sep 2026 10:53:55 -0700
Message-ID: <20260925175400.1897574-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nGYTYe42niR5FMhNcn1iw0fjbelf9gSW
X-Proofpoint-GUID: nGYTYe42niR5FMhNcn1iw0fjbelf9gSW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX2jnDZZtKHCGE
 ttDXp87YxLq94ef4csOsSNOJ9uXAtVnWkHTJoYuak4+pZ35FXLMfM29dOmcgBXn+9JJSW0WbO+V
 FrEY9DLLjcjIw2FuwO7excdggUObSWg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXwK5fveJPgbSV
 KxBwDQg6ZjAbwgUZwzjV0L4kyDJuoDgvezu1PPZkbv/NDDuX1Mk93St9YJBzJOsmYdNVMlWUjn5
 JD4bPaF5GpErxznV9f1Yqv4I7u1L3ZiyEpXGBNWDP97csmdMcFUApn4tyaCcQZXdZS2pGVgqynw
 GoNe1ZVRZD/E5Y5ulGGk9ahGnP61P4mhNsWAsJdCp09V1zqj2JYECy5jSBkgrvbBVPI8Gl1/rgU
 N6AQSbT3QgK24pEiXMBfhY17O5AcCK4BYZkOdfGyNm+i3u1FhqbV9rqgCHfFiXXEukU/dXLcbrl
 7JZSfjH+it5n9bvB3vhge2ZFiuxOPlefNktg33gv9I8+9WvS0K3cpy4nVqxuXmZRoxBYI2qi4Lb
 sFYNt9jOfa9MKJQhxlIZSSQvhjn+Q/DkOe97hmduO83Wue7eWTIvYJ3hLmdnuUiSbB/49Xn111E
 vGzBSXAtpkcbDQYxx8A==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b54a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zDihhlDB1GNUnh0DM1cA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

Created associated issue:
https://gitlab.com/qemu-project/qemu/-/work_items/4567

Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/system/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 035dd5f85fb..d1ee3986b62 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -24,6 +24,11 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
     new_cflags = cflags
     if fs.stem(src) == 'memory'
       new_cflags += '-DCHECK_UNALIGNED=0'
+      # TODO: memory test hangs on aarch64 host
+      # https://gitlab.com/qemu-project/qemu/-/work_items/4567
+      if host_machine.cpu_family() == 'aarch64' and 'gdb_test' in setup
+        continue
+      endif
     endif
     if src not in multi_src
       setup += {'cflags': [new_cflags]}
-- 
2.47.3


