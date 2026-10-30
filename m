Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A4606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bEW0zQi0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ENVwVqdM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqjk-000240-Ab; Fri, 30 Oct 2026 13:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqjg-0001xk-Sa
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqje-0007Rg-KZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDAS2494773
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DrvbrroqJX/oVgULtQ/+7xV2g4vDHKVCIXFqCiwOHpQ=; b=bEW0zQi0NfGfM6tG
 CG2oJ/SWJth5UDGJcbzikDABZuwcz/IzsKLUkVRDdoXft3641Zr4qyBrNQrcD466
 p4vqgCr83dwCKw/KLcgyKstPCJ2z0qjUKAZofdpPdwcSI2mo9cyohXAV9rQ5JDfx
 6ZTEZAS5RYXtqU8IFfbzgg+j5zIGjp0vcuXIVIGTwc9NFTke93GLmUe29FHH2Zmx
 OzfzOMmm4UhBQ5K76bqWSS4LPFhBTm4F4XMYblkv3Lbk24GdSQ0396OVuKwNCONP
 a4rXNIXkGO5eN/OyJOtglh++eaLr9Pn/iM4OfREZjV44E5D2xQMg3NQUxRAzv60f
 Tktt1g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4b8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:49 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf634a101fso739931137.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382589; x=1793987389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrvbrroqJX/oVgULtQ/+7xV2g4vDHKVCIXFqCiwOHpQ=;
 b=ENVwVqdMRobKm1d8DsVBkrrThvlnsFeGsN/GdBZfRJm6vQflpEGgUWBIARWaEgGH+F
 2GNymJW1HVf1pp8WQLxdWx7oNdK6cOQHLFYaib2WlDGsOx1re/k2I/giwVGHy6YZ2MeR
 77XtRPtpJcTyhVyxF/Utp+phicaqQ+cTOZmVGlOcF+nYsjD3DLVwO+ceAu1VDb7mQp2N
 UtdWBBHaYEHyH+S8fFMGsHvoiPBdRXP5wj5Q+RALwSqTmGXsw13wTaTwl01zHslpkBzK
 0MZyaw/qFdImxUIhxDzZ8Z/Z6+aagRbxdx55PGa4tCxSfCpFZzp7wkShpBfPMNvjSqFv
 yr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382589; x=1793987389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrvbrroqJX/oVgULtQ/+7xV2g4vDHKVCIXFqCiwOHpQ=;
 b=Y8NeAA7UmRPKUgcULj0+8H1CoSsrW+HTjIPJ3n6d1lFA0bnfkQ73vTnkJmHI5BDohv
 eQrqkEYG1pRgJ2Ki/OUZ1uy+B4QvhDcrNUt40n+15mBqNtpFjRrx11+FoGm6/KZ8Z+ZT
 cvNk0hVOLVcNARtvZ93W5BjM8FhmwpMX4Di97IqKB/t1BTs1JvWlLpsfqgJwTp7Or1CJ
 m5lWiRJsFRvBBVUIPTGSIY4J9a/RBEG1UNNJo+TuPiuMZTyiOpeJotkOEqyU4AUFILYw
 Cjow7mtOTBMkUAp7d4U89mKT015s/d8RsHic08C7Ffk9tZ800u5VDbY5Vvwzq20KdmkN
 8ntw==
X-Gm-Message-State: AFq9FYL2TOPgnpY9y9V6xiXF5a3yx4GdbS3RSYoi9x+8EO+X3R+veSGa
 1Z//nDlp5SoDM9Ptu+maWMJrVGTvKlm13lHR7G9qfvX96ECXwNoyByA8YhGMT6PKpUXFcL0+BD3
 TPsw6OoZS1VA8RJRjtHzQIu5eYyz6JHqEE1l56OBvEmmNBWZvA9kDd2NlQytMrmdrqBKR
X-Gm-Gg: AYBFou0M6IPisgosjBx8Yg+lbP+vZncipbQ+1TL1vaJekADkM+sC7QJbIAxVxbavNy5
 UuJcvbyEtnOKQT65sPA7ZvpWFibIAM5/1X6FZjhD6gvkWBxNEpiSha/cpfJ/NSNVWKs3RXQ9akG
 NslNzFljZ95zFMsHfNeDsO9aUI/YtnnLaIXSJKjlBsxQbh4+YlKwtShg0va7fEcT2ntljdo58w1
 C4NFxWseTNZwoywcjgGz9lKKU/NLAiRI9deu+zS+o5PajK+642tmzM0r07mmxVpK4u/CRE5UYrF
 7yypADjBiBo7v2H8KqypAYeaqqtmVpbEGjShi7oOLNaoej8i9YZZ4dxE02HlF3IUItSig0WfQId
 zebWavjdX1OgxKlh6Dcvrtc0E7fGSeRoTEjZWXCWVG98YgSYyr+ImMEv7Mi3c9BOr4m9sFs0Z5E
 uToffnRAIBwtkBI8JyJ4JFukToMoPO+w==
X-Received: by 2002:a05:6102:e10:b0:7cc:26e4:193e with SMTP id
 ada2fe7eead31-7d07274b90amr1681376137.29.1793382588724; 
 Fri, 30 Oct 2026 10:49:48 -0700 (PDT)
X-Received: by 2002:a05:6102:e10:b0:7cc:26e4:193e with SMTP id
 ada2fe7eead31-7d07274b90amr1681362137.29.1793382588191; 
 Fri, 30 Oct 2026 10:49:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9eaeesm4513439f8f.49.2026.10.30.10.49.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:49:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 3/4] tests/tcg/mips64: Report Octeon test results with TAP
Date: Fri, 30 Oct 2026 18:48:54 +0100
Message-ID: <20261030174856.98759-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030174856.98759-1-philmd@oss.qualcomm.com>
References: <20261030174856.98759-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX9Pg6b4sXKt7f
 icO6Pmftj+DHXvW53q2uOt4v2EZY+hn57/JaCvOm0lqIG8brTkpdt6NxLOhk68S6rpNg6plrgMn
 Kj1XdwX6LDSVzW5yuHjzV6UKDbOtAbONs9NofQ+h6R4WoavS/dnhUQDp2/3EI+EghpIkDmsBZYd
 lWBi4QA6QFpAhrRIQMIgF3xslRrBH40ZpiJ9cDOZJ25k3X411Jl2fMgoY5/lPIWD6RsLC/1WKe6
 yF+xI0bNWoYmKiZuc/6rDaAkV9fGi9QXBGgHmNxEDoVpx6/5JiduLcKvKVu6v+XM6rFcT8Uy7YY
 hSW86XEZJWdPEfhCAXUVofcui2/KnyVY3B4YtoeQAoU7+qMous42XiNYKpaSSDhEMT4XSuYAZ2m
 jtaqj8WGQuV3e0ul6zR9NRhXvz4q084fTYw6feacJpNpPag01rAXxctXOAxotx8lWGgLoCW2/zO
 rQ7mNujw58KiHtzbZ+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX55nq5YVLuPEL
 n+IbqqMcVQuVfXoVe9/hNF7duOVnuqxoOe82cgUzxGuxOKkCVv1gKz7N1i7KK014T85Wdmjolo4
 quHuEPOz0Jrzs29bML8kt5Mo7eWXoXE=
X-Proofpoint-ORIG-GUID: L2rQbczyp0_Yquj9oFbwWGuj_Q_8Nb9l
X-Proofpoint-GUID: L2rQbczyp0_Yquj9oFbwWGuj_Q_8Nb9l
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d8bd cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=24OdzgigavIs_6l_i50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Replace assert() by TAP_CHECK(): one TAP line per check, so a
failure no longer aborts the remaining ones. Call TAP_START()
and return tap_done() from main(). Select the TAP protocol in
the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/octeon-insns.c | 65 +++++++++++++++++----------------
 tests/tcg/mips64/meson.build    |  1 +
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
index 6fffc8201034..208002c711a2 100644
--- a/tests/tcg/mips64/octeon-insns.c
+++ b/tests/tcg/mips64/octeon-insns.c
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <assert.h>
 #include <stdint.h>
+#include "../include/tap.h"
 
 static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
 {
@@ -385,36 +385,37 @@ static uint64_t octeon_rdhwr31_non_decreasing(void)
 
 int main(void)
 {
-    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
-    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
-    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
-    assert(octeon_seq(0xabc, 0xabc) == 1);
-    assert(octeon_seq(0xabc, 0xdef) == 0);
-    assert(octeon_sne(0xabc, 0xabc) == 0);
-    assert(octeon_sne(0xabc, 0xdef) == 1);
-    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
-    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
-    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
-    assert(octeon_vmulu(5, 7, 11) == 46);
-    assert(octeon_vmm0(5, 13, 7, 11) == 59);
-    assert(octeon_vmm0_zeroes_mpl1() == 0);
-    assert(octeon_mtp0_zeroes_p1() == 0);
-    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
-           0x1122334455667788ULL);
-    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
-           0x8877665544332211ULL);
-    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
-           0x0102030405060708ULL);
-    assert(octeon_cop2_keylength_readback(0xa5) == 1);
-    assert(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
-           0x0102030405060708ULL);
-    assert(octeon_cop2_crc_len_readback(0xb5) == 5);
-    assert(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
-    assert(octeon_cop2_gfm_mul_reflect_write_readback(
-               0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
-    assert(octeon_cop2_gfm_mul_reflect_readback(
-               0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
-    assert(octeon_rdhwr31_non_decreasing());
+    TAP_START();
+    TAP_CHECK(octeon_baddu(0x123, 0x0f0) == 0x13);
+    TAP_CHECK(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    TAP_CHECK(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    TAP_CHECK(octeon_seq(0xabc, 0xabc) == 1);
+    TAP_CHECK(octeon_seq(0xabc, 0xdef) == 0);
+    TAP_CHECK(octeon_sne(0xabc, 0xabc) == 0);
+    TAP_CHECK(octeon_sne(0xabc, 0xdef) == 1);
+    TAP_CHECK(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    TAP_CHECK(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    TAP_CHECK(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
+    TAP_CHECK(octeon_vmulu(5, 7, 11) == 46);
+    TAP_CHECK(octeon_vmm0(5, 13, 7, 11) == 59);
+    TAP_CHECK(octeon_vmm0_zeroes_mpl1() == 0);
+    TAP_CHECK(octeon_mtp0_zeroes_p1() == 0);
+    TAP_CHECK(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+              0x1122334455667788ULL);
+    TAP_CHECK(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+              0x8877665544332211ULL);
+    TAP_CHECK(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+              0x0102030405060708ULL);
+    TAP_CHECK(octeon_cop2_keylength_readback(0xa5) == 1);
+    TAP_CHECK(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
+              0x0102030405060708ULL);
+    TAP_CHECK(octeon_cop2_crc_len_readback(0xb5) == 5);
+    TAP_CHECK(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
+    TAP_CHECK(octeon_cop2_gfm_mul_reflect_write_readback(
+                  0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
+    TAP_CHECK(octeon_cop2_gfm_mul_reflect_readback(
+                  0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    TAP_CHECK(octeon_rdhwr31_non_decreasing());
 
-    return 0;
+    return tap_done();
 }
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index c80a3716f559..3b895a169758 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -5,6 +5,7 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 tests += {
   '../mips64/octeon-insns.c': {
     'qemu_args': ['-cpu', 'Octeon68XX'],
+    'protocol': 'tap',
   },
 }
 
-- 
2.55.0


