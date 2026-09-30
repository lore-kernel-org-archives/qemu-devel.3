Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1EDCA5FA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdo-0007Ui-TD; Tue, 29 Sep 2026 22:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdn-0007U4-Gc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdl-00035I-35
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQZn72012852
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kFxhLIz8DpH
 FzFUVkMX+17fNHrBjwfoo/xj72InGkjU=; b=lWleJD+n5gSg4NRbQC1FVGjClS1
 WZ9PsYI7IlBE1QUiA13hKD53xCxo8rdp524W8kw0Wgnn1FvgmF99tVBJOHc18/+d
 s7MQBXP11uFJL3uJSGPUejARyfOH95uZW2n7eeFOWByOpBnf3swNZY6AuOJMofMB
 wSKeWSdLxg6YwhMPRNhVkEsfJcoCl6phz0wYsqSNau+aJ+2Y1crNJ8RbEIU8UTk0
 ARp8bOSKzre5xqaHZtDqAgjoEUjm0kAJRkQdmLOAxK7sVuB6uqG+fOMnhvN4yGYF
 DR3mxM4gVY+/CcoGlyyqU5Kucmk9M05Z7Qtj+4IXbCXeG6dA+OEIZY3DP4Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j0ehq4b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-342b66c0b06so1664892eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733707; x=1791338507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFxhLIz8DpHFzFUVkMX+17fNHrBjwfoo/xj72InGkjU=;
 b=Vz2k56BkU7STibRtjW29aAPeWEvq7Kzu9T8Q+UkPC5N69/vPCBa77YvsOL1WQIOW05
 Z65ersu1LOdLrej6VlefTXo4yN72rfIBJzNErrKPA+htEVPzAwiNLitU5jJnQsHUBxrf
 JOSk7zFn8rQ05emrqVCwoytXZLOPwP/+br1/thauwkZyH2nhuNXlW8I5pt4GGzYmFX8j
 0ugIOJiQuPWP2LfBXfZzkhqvF4XfCQvWIMqQqmA7qjMPyeip/9/nTbayFylCG24azu3Y
 K35K+8cHd/4i83an2X/ouVVjOyHV+fCTNxS+p3f/gCP032rC/UvntC2OpWyV61+AQaXx
 AP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733707; x=1791338507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFxhLIz8DpHFzFUVkMX+17fNHrBjwfoo/xj72InGkjU=;
 b=oguUBeMQFe4JTcO9+8X7MU0G2Zvj/na9c8ZLqUZLkScQq1qLfXi0cdxTQhMtBuAp3N
 SDRlWKO6tHXbQSuAxuKfhyptZtvO9kAK6ik5cFhoFUv9m0yng6MvC3KAf76PYSfJ70CS
 VYDre1Vd0VnsxnyeqtziqsHqAXv1GUmiEJWI6jS6knxnjJJM50zIZF7SOUyw6SOhrHR8
 r0z0EcyqxKhtp9ZgCgi0cbJ77hChMrANiXYCzpMUPwdOjY/p8OASFOc+55n69Ck/wXBr
 0uZTJ1tN2Nk2ZbQh4EJibwMZBiNCR4oO0VmLrGTeMNZjxOty/0Ya5cutjO24/xEoef+I
 tqWw==
X-Gm-Message-State: AFq9FYLaaoOYyGufDgUfwXrFZtAr4eAygIrUlSsJHuVteLybL8MaGJQZ
 r41Ru4OVww/FrtZNN+9YEn0mY09OmzAxyZH7f80s/soXyq01CC5dUP6tVfjmR6/fv0moIGlJ6Ef
 s1lqq5wMddQd9R2TdMoCsaicwqrfUFM7ApIs+2I7D3T/WjsZ5QI7UxnNPiKDiSYNm4g==
X-Gm-Gg: AYBFou1ay2jd1pxHoiqC38kUeiVFj9gpWQ+9MoqWdNPIYXXNqzy4NBfp3tDcSfHKLdW
 lV+y1rPAm1H0TD1dU3WrXopueRNx3O7hMrDI7tyg1djNl8ffGY+CgufTUa++l2G6R4NAi3mFEBQ
 Zp1x9X8t+oxDaVK5BGbfStyK5QCiXnHcKjJt1NxL8MoxcA3M2spYKy8C3neoNmPCly8CvUUPOUb
 jGjek5CPluLVNgltGuEmU1LOla/bv9iJEFe+QRbZ7+zT+iWQ7UdVuEBgZZu2nFdvXOpkEoc63el
 Dn5qo0gND2HtgYlkOkhNevSlJZI2A66j2Z26YCiruuVcmaJf1hlFcKFCwIrCO5T9sbFI0jgKRwI
 emkWhzr+6TTQE1Ehu56NYN7814VDuu6TOcMm0lkO7CkrgAri2vYAygXKPztOA
X-Received: by 2002:a05:7301:6195:10b0:342:890a:4088 with SMTP id
 5a478bee46e88-34cdb4010e0mr131934eec.2.1790733704071; 
 Tue, 29 Sep 2026 19:01:44 -0700 (PDT)
X-Received: by 2002:a05:7301:6195:10b0:342:890a:4088 with SMTP id
 5a478bee46e88-34cdb4010e0mr131775eec.2.1790733700625; 
 Tue, 29 Sep 2026 19:01:40 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 06/21] hw/m68k/virt: make machine available for m68k target
 only
Date: Wed, 30 Sep 2026 02:00:53 +0000
Message-ID: <20260930020108.217892-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cqgOAF4i c=1 sm=1 tr=0 ts=6abc6d8b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=2WjoNMVDNgbbyyqWIPAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: AkLymQMzpJakltCQ4mrcDOhcfGZztg9L
X-Proofpoint-ORIG-GUID: AkLymQMzpJakltCQ4mrcDOhcfGZztg9L
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX7IUI5PdAAB1U
 eVBswQpltR0ln9ukGaTV2W5jOm/xT0ZLwmES5Dp635Xq3YWPYzl7kVdJwYQnkdgIrbB6uGDKwlN
 0FOnDjvN6NZ/hNOasLwZvdcsh8ggrB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX4n9Vs7aixzPR
 pTyeA9FN40TOFjk85Ub9+o23Q3/oPc2s/plmY3oS3VTEGZXLa5Y6USXxiZEC/ltlH0ULNHtfB3E
 IDRHr7u+FQgtIbkb0aLYiXslwnJ6EniXEkocLr/67V1yD77LT3GSKSSjqQO03s2B3KG/j/qgaJ2
 z0bnaz4FDClxZnsNicD/+riGV3G54+LbgkH/9X3MelUDDLfxGeznCDYxl+wSpzW7kPNLLsVSsvJ
 kSLLHQ5ucrguf+y2msq8Y/iGKR/UCC1w1vZOlFbgrd34oF55XHYgMXqaIU2I2x81Hi6eD72WZeW
 KmhgaWWb/yDDnBwBs5xF4nPbM9DESfryhAXd4+EjADNgMpr//6fvCQyEI+bIL+tG+oUQJiYi77i
 T/cUAIy0mZAXyDNc7NPKoP8bluR1nMizNl9bsFTh6TTgjhkQ5ZfAnGLji8fgA6XR/GMm0SBy8pM
 x6r8HTEZbLTc8NPptAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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

The virt-machine type name is shared with other targets (arm, or1k,
riscv), which conflicts in a multi-target binary.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/m68k/virt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 274970978ff..e52546e4fab 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -323,10 +323,11 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo virt_machine_info = {
-    .name       = MACHINE_TYPE_NAME("virt"),
-    .parent     = TYPE_MACHINE,
-    .abstract   = true,
-    .class_init = virt_machine_class_init,
+    .name         = MACHINE_TYPE_NAME("virt"),
+    .parent       = TYPE_MACHINE,
+    .abstract     = true,
+    .class_init   = virt_machine_class_init,
+    .is_available = target_m68k,
 };
 
 static void virt_machine_register_types(void)
@@ -354,6 +355,7 @@ type_init(virt_machine_register_types)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = MACHINE_TYPE_NAME("virt"), \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_m68k, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-- 
2.43.0


