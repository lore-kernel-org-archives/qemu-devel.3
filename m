Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFC9C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gM-0000JC-Dd; Fri, 10 Jul 2026 02:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gL-0000Gg-84
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gJ-0005ru-Jz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3pllJ3856872
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=; b=h2rJQBGDTPAxl6kw
 myDMBNRwusL4oP9Tas6AyDpoRqrMKEum9Wc9rfMvcDkiA5hvQ0vhs47hAPKENlqn
 a+zw2sD6Is3EwFAt7IjPdXLEaIicLQW+rqMVM5RdYadrDGGB1O1fci26x8abIC9W
 9L4DRrAUrA4WSHfbWVvl2H3+JjLFsMBfjTXG8Ijm6oP2yWruVdR2574mhuQZDb33
 sDenZ2zD+Hb83mdJbwvuH1ovRQOHjJwGueJLflDRT77bXsxf3dpyupt6syiDuA7x
 hB7UquwKxp8Mhj7FIHysbt+kTZh2KsZ1zVERdOWOBEy+dvhiFWyJzWeCgdc3tqs5
 bVsC3Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0hv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so1042912a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664740; x=1784269540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=;
 b=JaGHZWdWX7ZfOuOv8vkfo0+WMwiSbbhuAwFkGz3IeDz1PQ5wTXG65xrG+Hy2ErSGge
 01DYvbivJ0udHHEXFh4muO83GISBe86FkiASACfdk8aLizDC6qboHajLRftzhPSYryd+
 sVrXJHxcCQDHK7Ubj4LKnLPelnFKupe2htNMEMgiaEX8P+PQvWkEgLGwJF6EvUuSt4CM
 5fiAhptTWrUuHGkyUtO3tJM4C807f4K0wDd2dCn3I5PiUShIUH4HQHWM2ysdXcSs3Eft
 x8NX5XGHmCgbZRuAgQEbk+pWpUYnDPmbXjL1SEPTzH+cOZZFdaTHZSEyxA2j/2b4S91Y
 cBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664740; x=1784269540;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=;
 b=GDtfvdCiH0Igg4No/e3apJr7bcqYAllZdgRqpYrzPRBNSARSgjuBxYKIxoOtuau6SP
 ERsKhesfMmKRS60hdoKcurIiFUv9O9MeUtO9q2Rd9v7fp9aNNDfeKmPoFA0LJ4D+8ESv
 ksVX2dun4ScVBQSaU/BKll1OJhYO9x3plF22lXOXm2VFJ+Tv04hoURDqYBb3Xty+KBa4
 IEWrPGYPyS5swsIhCn4orYtXcYtCxFpj0CFvVdLSy/jlJ0nMUePqMRN1vD0qWM+b9EHp
 BNv+U1wJSOHWaiw2+B68rRP2pyjqtryLxrWnV0tdL/XTFbGBryFmjmc1X6m1pXc2jC1j
 JhhA==
X-Gm-Message-State: AOJu0Yw7Tox+mzTSPvbuKm+ETjVYkODonIWWJgsGRWlh2qRRVC4dBuLZ
 a8WwzMLERBgZi5CEF26CkXe+Niue2lauZ4FE3ab9ey8V0I9VI9UoqGUWU4Mn8STsi2eTTa+F5n/
 2si5XHjrTB3k4TSqYka6AfCdjKMPZpODjUeeIJJwvKLAiYPwyhbbbfeDxweEd/O9miw==
X-Gm-Gg: AfdE7cnFy9gf1LNccUhqzX8Ym29d68pR5yMkeycccJl5EPVwL3fJJ9PUvs9V6X8CmEI
 gLAnJyGLcha5f+aBTmzKqPF5+FHHA4U5Q8ItLt9fg0ebHh8Kh4qUBuAGQcWAR0aXb07dNOjhJGG
 iDNWXTzpG2gpw/YLFe50FyFiwLLTMDt4gZBbnHL5OnLhPqIW3zD8WVk/OsOT3vGcMwJNVqsRCiN
 45CZ1N/4H+Orfxm9qU0v1l0P7DPJq0gDOfx378sQSHT1EDKPWk7xZu2DPuYy1WvHLDzTvN2FwT6
 IC45jCTRpH2fc+NPEG6vlDbKEfYzWJrftZmsO7kMonfs8i3h/uUm+dFGJ0pXzaPIBIeee29/KT/
 rMVlrjKwGAWk3TU8ShFBvOS9sCQa7gR+RREth+BHLMfbI5Q3ERiYB+dJ2zbWeviRSdXddLdmeSm
 8oYykZsw==
X-Received: by 2002:a05:6a20:b78a:b0:3c0:9c19:65bc with SMTP id
 adf61e73a8af0-3c0bccde08bmr13134505637.68.1783664739702; 
 Thu, 09 Jul 2026 23:25:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:b78a:b0:3c0:9c19:65bc with SMTP id
 adf61e73a8af0-3c0bccde08bmr13134475637.68.1783664739260; 
 Thu, 09 Jul 2026 23:25:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 58/97] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Thu,  9 Jul 2026 23:19:36 -0700
Message-ID: <20260710062016.1818125-59-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX/ABNQemb79bz
 cGcAbXB3MxyV0tdpZXUfgkVzTbit6LVlSWWYQOER5QT/XyoBoLyq9YaxUp5Lx9FCb/3XTP0I31b
 ZYrDkgP6OdbZa9wQnEX9QW0TJkMcK6Y=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a509064 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=plJD_5OMxHvttXuW0nUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: keGaRYvhzRTtLDh-QlWcF9aIvuSI7ALC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX7oRj+i+BKnmX
 dBOP59WJlV4R1uSNTtxNVhreC4ZoY50k21llyMjcaRgHM5JwcC8Uj1NMFp/e/UkvK56kBwwvZ8y
 GLpjk3ExHRLmxsU3R5a323yeTpCPMw/0Z1GsEwzTABsskCn3LIM4Ux/cHMOmskHeKCdc+u5uPJQ
 KJ/e/UYQya59D0fZ/w5nb1nHkcr54m4U2xOYYzUHeXdlBglmzfOUgVWBgsLIM6s9Upjv7BPAUnG
 frb76r/0HDKefElrTwb23jMtYz3QEhG4NBTjBPqdAr/PkLTUMbEjvX6NZdrOkDGJRDai4bH6rRX
 mtKViSqIChTTsktfWIOx3JC5yeSFmUFpBfBbKhrSIHnpmaekg0u+7qW7U/c5bTvMOrzNGTaYRON
 MEIdY5HaY4W+LnI2dM5DNr9cCNR+df4q4zaUMs078cUW+uDjDidnvfWqgrF7rVVPxeu2g3I9DOZ
 lYev8xK2iCb93qcTTaQ==
X-Proofpoint-GUID: keGaRYvhzRTtLDh-QlWcF9aIvuSI7ALC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/probe-gdb-support.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..6e3b2579770 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.47.3


