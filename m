Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E693606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XhAoBIsR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iuMPamV2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3t-0004j8-Vq; Sat, 24 Oct 2026 02:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3f-0004c7-JE
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3d-0004aP-Vr
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2Y7Cr060701
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZUbkbl+4kfV
 1ycuYauypPXSIimhUKi/MnZ4x2Trw1rU=; b=XhAoBIsR8mN98Dccf3VJe00UBGM
 Lex06Lmhid7v7A7RJ+TRLkO5pt/BruGzh5sKQdlgDbaApqQ8gzAaYT3oOWpMRbPC
 5SQaE0gw/ySl3tOQHlVjKQ94bs81RFgdhW3WlfKnI6j/kK2R1arSTCfThv3kb4Tt
 2IrTGWo18tOW3bylbeZsyEirkSRpRDW+3NFLZc72Gv6WQXQRaOOjzMYkZyZ/ezjQ
 /CVSc2FplStiHzrhW6wwr0G5LJ1vSMBAo2QjTabhsLXsmkkt0R0rEZaMn45f+GNb
 DvkQlsjFarTSwcOR1heXiF2A2XoKKRfPHK5byvBtL8r0wxbp75PxM/+EHqA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0ggd5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso1510383a91.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822604; x=1793427404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZUbkbl+4kfV1ycuYauypPXSIimhUKi/MnZ4x2Trw1rU=;
 b=iuMPamV2EvRM90OW4y6Dzy02pl8ZO6g3gEhLOlS+Yh+NtEB8AZL2GpdOaeF7F6+57S
 ahZ0Asu5EEuRjISEDWvqOvjwBXfWmFU1qLin0VWubnoJhJKiEA+MiXTMn4/ChQ3MEga/
 G6tkEdNw/j3effd8QgFXBXgKJQAtshwb8r/GZkpYX3+MYBnTXr+USsZM1E9q6jIrKryV
 rYtGETwxlBJ9mXBcW2gGo4sDkn2vhtZt17yFEZmo70jawuWfNFUO4Dar6GslNfZWl4j2
 IZIZWMBnJFtxvWFghX9GjaVY9zhTStJEiYnK5g9Wz1We3Qju/Ttvt6iD6aZV6/0c5/r2
 S4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822604; x=1793427404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZUbkbl+4kfV1ycuYauypPXSIimhUKi/MnZ4x2Trw1rU=;
 b=SAsQQwyvDjgVBzVsidMPt3uBeVNJANmGq3cf4Kfylotklp3gzQdkxTrzPzb2cTdq+1
 jIPO5CFpYv+EGitFq3RYY5hBJC9jgnAJiVGWYLyF0sViIbJn7iiSyN64hPc9/pX4cdgi
 j/1xndEHxqivPqKILzZHn0lLskASM/Ff9nVYh6+9gpfiFamgBNWnIq4CHecOwBkWbmhr
 ESxAY08O+jJ9gvh4CT+79q8UfGamADlySUU2Vq9by8FsbHwYeJeID7GJbLQogLVyzNLl
 w3qBRWpeNGjvOnNbBMqxM7dkZavlullJPkxvAr89B/F0aSqjjBoa5c4GyF1jsH6qiaJr
 tnkQ==
X-Gm-Message-State: AFq9FYLtt6Wq4QKl9P8+frPKRZ0RePVgvNcpJemYrMMbZem+AbxZ6b0J
 csGEhjcVAGymyLXiqTB6Q5fcn1fApYm71HDKVBkxFmOrXN7jOK2td/wf3sQrQdCdCjxW0QEAgln
 ag5upFRpDYqccRqiQwhLlEbw9rR8MslpOtIQGfE4V+UvCVedfaWpqC73zlSA4SQniCA==
X-Gm-Gg: AYBFou29gwr6l+vfkEBE8tmPa7HEzBFt9jQTvn+aXjahLzchxLSTEEiP7Te40qFlE8R
 5Js/uZsR56ToPh3e8HFUYlRo9syV8ddmdDfkqvByyVNrLXtuS4VdrrjsHmVUeEt3JZfVoBs3HXq
 e+03LMjyCrR5Hwo0XhTvX81wJqvUpUsZGucdyjsZNudRhFWKkSv6b4Ke9KvmqPXzOdB6pQP57O6
 mCFagVek50RjwyrBdQ87UIVTA91XWimL3S7l+GYbeRW9v8tByBJT5qrt44ZNdqvo6M1m9OALzuX
 /aa/0t2qw92Oahs2ndv3JMtCGbtv4iHNn5MKvNHP+aO1pYO5dp1bViXPDe3TNtUsugoLZSEMIwx
 7g5Ko3SUNjchn1dtwZwU+QQJvZvV4rPIgsAvWWbBMRKUq380BM25pftU8fmKrsgM=
X-Received: by 2002:a17:90b:4d02:b0:3aa:fdad:7d6c with SMTP id
 98e67ed59e1d1-3adeb106447mr1171509a91.58.1792822603894; 
 Fri, 23 Oct 2026 23:16:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4d02:b0:3aa:fdad:7d6c with SMTP id
 98e67ed59e1d1-3adeb106447mr1171497a91.58.1792822603419; 
 Fri, 23 Oct 2026 23:16:43 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/9] hw/riscv/virt: restrict scope of virt_is_acpi_enabled
 to this file
Date: Sat, 24 Oct 2026 06:16:10 +0000
Message-ID: <20261024061616.27381-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oNi1nR4pudZ7c5CealP1MsO6-p4QlDxk
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adc4d4c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=1naKx9kII0DkZoFY_HMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: oNi1nR4pudZ7c5CealP1MsO6-p4QlDxk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX3BeTR2kVUr7p
 bc2tFtpZ/j/3oEkwNHINV0atWIXc/Be8XMgEevit+Vzuwqbra9maOjyeI4/ERsu0zONfIOQB6hu
 pf6S3/hZHMOeAn4lcutwPzzo56COUbs65cgL/Cvneg48lfZwZ1ZG0rJm2PYO8SmtgobxZelXbwb
 TzVvcoe2A/9dQhzjzIMHJMfBbYMzU8JfQnC6jVV1nowBi4stxF13KAR0bz1Au6trfdAQTrksqpV
 oA6ni00HaAfMtWWz1nrh98dPKAbifaTOVcd+5DZd/AS0TI7xaxaF3iL9vIEyiwAV6tVxbYBWykD
 4c5zpEJe2aYpKWcWkIuKKSxud4RXalrOHgJ67Qlo2cAyr6DpH4YxhFe1q7bmHufZ7eZFt0PfDWp
 czfX6A9kzF8VjF/oMfXEunPgJFHqiWFjblHH6m5KTyf/0QbYIu94uVm5wOTV/B1kJCrVwNytatq
 bOhmIGhYE0jPlx83WHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX/jBjAX7SIyXe
 jNAwI1sGzOcF6Ypcx/dRuIR7j8P/JU+RVzYGBSKob65legWwNFa13/A+FqOQM8ZeAd3/g/4fgQL
 EY4/eO9hunbAbStRYnrFEoGNaDklHRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This removes conflict with the same function from target/arm. To the
opposite of arm target, there is no external caller for this function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt.c         | 10 +++++-----
 include/hw/riscv/virt.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 894cdd97976..2c6f983f83f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -72,6 +72,11 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
     return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
+static bool virt_is_acpi_enabled(RISCVVirtState *s)
+{
+    return s->acpi != ON_OFF_AUTO_OFF;
+}
+
 static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
 {
     bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
@@ -1067,11 +1072,6 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
-{
-    return s->acpi != ON_OFF_AUTO_OFF;
-}
-
 static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..16d86edfcfc 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,7 +121,6 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 
-- 
2.43.0


