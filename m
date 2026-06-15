Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C40CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7t-0004cU-6a; Mon, 15 Jun 2026 15:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6O-0002W1-7J
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6L-0001Wu-2o
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxEKU861125
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r75MAyRnptz
 wlKMRhw+iLcm+hN2cLebwsJwt/8PzSTU=; b=AQj4lrw85CBX/iKfprtOOjuPEFM
 KGvfoZuz93RC4U3WMf6Err1a17SQ8TcJlyWV30Ae4mNszklbpJ/kke6em0qB9n2v
 oUIRj4RcWFxkM7q4jktZf46yWSLxpAzUIFNu6H+pVG+grqHcTCVb+9spE5I9e84J
 WiYlX13uaSI4BYqpMRM8FETeE2sHIOWE0jwDCsxrCyOdtzSmxkQ8ock9+OhflsWE
 OG9Qr3LxWPvQLP7IdBu0mA2a+DS3O6V++9GZ0T8b9MF5nnjpTBhbxZK95skFBVUD
 mF6b5U1nLQLTG/MHoUvv5HIZUgz6KzMmNq1BRBWrmsWbb6kq7mdModNvO8w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydam1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:03 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1370417c0bfso2581816c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552162; x=1782156962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r75MAyRnptzwlKMRhw+iLcm+hN2cLebwsJwt/8PzSTU=;
 b=Dm2fdGLYMfXJegMFJHrJTl+V2XAMfcwy+47Duc+3DqKOSxRiU1tjHymVnGyATTg7jf
 q52y5R0vodjrQwlOY+D9OEATTUZB7CnuiPdKRAvoH4FEqeVb+gd11GP0N+BmlA3qMeYh
 m5YftZE9e8YcDx69ZfDA0NRiu9HtYuTWSmG0qk7CJnbfiEveDR4a0GBq66kbq9ysao3V
 /qtCze9slJPHadapDVJmUuVUPwZFaLjzPwE3c5UhenM5H9efFlIj8LDXNM7HvUDsIUiY
 0JNitB/v2O6wV9fElbnjml+hAVu0DhKY+hHaySlaZSb2RTLF63xZAUGsZheOr0oGrKnw
 pFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552162; x=1782156962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r75MAyRnptzwlKMRhw+iLcm+hN2cLebwsJwt/8PzSTU=;
 b=Co+hmknXjeVTSTL3VEJAZs3AhBd3CXxFck/8el7ypJb36Z3ib+XTI1rG+CLpbJTRsb
 ESFqNuEjdG3GziuSoyaEoIMm48M5birmSj4Zj0ixeNH7VDHamO4BNuK06di5V3NnZ9ak
 mP7TvWe7k3wl9dw9qaCOFIk/miAxlkps8S4A9R4b+wElUI1hxuf3my1LqgQmGZPD3QHa
 lI67fueIiT7nMpQ8vXT6XoeRuUBLo1iQ6qh8eegB6I8OcYVt9YoXTm+RFfl1vBP1TMbg
 LILxq3KtE/p55n0+loEz/jb06hwDfR2EYZYN2BANYghdzPRi4P6zFWhpD6yhhTFnqUox
 Jm9g==
X-Gm-Message-State: AOJu0YzL+tV/L276Tc8aB0kDrTSrUpn2DpVCvzZlgzJ5Y0FGo2XSfje+
 x/1Yr1j89Le4sUgWWm4sswNBh1oEaNs//eswkI89W5fAbNTaKnmwrHE7mccrinzx4Cupz5OkjqR
 KGkJx279H+MoEqv2x2KueQRr3oAYZPU7t2PMxPwJkLccUXZDXLdj3S39HJgoJn0xabE50
X-Gm-Gg: Acq92OEMDdmKhbeyjUpv7TVWbDYd2mkY6Xzau1NPjyvh4GAJsOCife4nnhBt/vQ017r
 vEyslObvs5NEXHalUvB0TC2C+r7hYUS/yPEr1R2lEvzuPxaUgxO3bKNe5tJ2atiZrEA4yx5DcX6
 05PqhPTfAcJys0uFWiiNDEwBH65cQf1rSbB+spny7pRBabIHjkKysWkWZg65gjy70yCFGlHVDUj
 kgQhIHPxXis7yoYGTRNEfstu3mqIBmUUXh06Ar8wA3CmIfpnCC7EI6cZd8a/LttPl39wPEcSjwU
 e9JDxKpjVWO7M+RXcBS20NlOsLT7ZWn5u1+ieXMXeeR1EcRN4b3tI08cXcu1L5xIMYaia0bejf3
 9sESiWV0MO0lTkkWnOiRfC6rbAawPTwwJmi15AJXacj8Es4KUfCaRwjOBsggjZHOBK25qo7lHGi
 DCe0bYwQ==
X-Received: by 2002:a05:7022:48f:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-139857bc219mr440107c88.11.1781552162033; 
 Mon, 15 Jun 2026 12:36:02 -0700 (PDT)
X-Received: by 2002:a05:7022:48f:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-139857bc219mr440090c88.11.1781552161515; 
 Mon, 15 Jun 2026 12:36:01 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:36:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/26] scripts/checkpatch: ignore spaces required around
 some operators in C++
Date: Mon, 15 Jun 2026 12:35:23 -0700
Message-ID: <20260615193526.2883349-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LDhEAjtQn2gNczyy-mqNfMump9IJ8ZC2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX0wMv02cfz6+k
 Lr0Q6+/XXer5ILldgjGWkJ9VO6pMEW6avrLwB5bu1Q7RGImfL9KDox4lXnGWKrCXkVstU5Lst/y
 sp4z9ij+5bYB3iukn4wUC+Nyb7mudsk=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a305423 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=nUVG7euvARLiU1CHTZIA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: LDhEAjtQn2gNczyy-mqNfMump9IJ8ZC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXwuFDesLfPby7
 6NPRw92O4xrirtPTguyGfoTHHnfSxoBuMYCGQAXsRGU++dNhJKQG31T8+z+O/ufL4pgHiwWlCtV
 38+4PVsZdK2e0111qshYhs0GcEH6laifms5OitnY8qjwQMOEzr5QEm5GjsSA5BUE3nXWWZRlNzK
 EnY4PsEjnLwH+VrI72Cn4tnEPQrYNFQjTkfIFmi+dB+hVMKWCUqAGLKGZkeyNlv/1Goj3cchhS1
 W2Ymqt0PSNgKHELEeidQBS1vBQVhWJHCZ38zvE+PNL+RvJYO4rRu+gVm3zl0iKNIZlhT9fF/u8K
 vV9DMq7NjBTTgbIqLiS1KezIE9PZRiUdux7+LAqn74yKW9MAVdP8pP/8yaqmxcUL+hi38xSE5mw
 4g/BvhgDbrg/WYhfJrbidvqqJTN7E+49yzOm4MlxnNIy8y9gZ3wWc5hXBUBa4HDJCC5Vxs+SOfg
 WNjyjQVM34ybw/1v1VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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

C++ has a different style when it comes to space around references,
dereferences, so don't report it.
Also, closing templates with >> gets wrongly confused with >> operator,
so just relax this check.

Some examples:
ERROR: spaces required around that '&' (ctx:WxV)
+                auto &[counter, p] = *static_cast<TbData*>(udata);
                      ^

ERROR: spaces required around that '*' (ctx:VxO)
+                auto &[counter, p] = *static_cast<TbData*>(udata);
                                                         ^

ERROR: spaces required around that '>>' (ctx:VxW)
+        std::vector<std::pair<Vaddr, uint64_t>> v;                                              ^

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/checkpatch.pl | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2189db19f54..538e059e265 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2621,6 +2621,31 @@ sub process {
 						if ($op eq '::') {
 							$ok = 1;
 						}
+
+						# Ignore * in C++: templates and
+						# pointer types are incorrectly
+						# flagged. Example:
+						# static_cast<T*>
+						if ($op eq '*') {
+							$ok = 1;
+						}
+
+						# Ignore & in C++: & means a
+						# reference, and this create
+						# issues with some constructions.
+						# Example:
+						# auto &[first, second] = pair;
+						if ($op eq '&') {
+							$ok = 1;
+						}
+
+						# Ignore >> in C++
+						# checkpatch is confused by
+						# >> closing templates. Example:
+						# vector<pair<A, B>>
+						if ($op eq '>>') {
+							$ok = 1;
+						}
 					}
 
 					# Ignore email addresses <foo@bar>
-- 
2.43.0


