Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D81606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i5IoLLtb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nflsb9QZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRvw-00086Z-KE; Thu, 29 Oct 2026 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvn-00084M-D5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvf-0003eD-Qe
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeUjE2762043
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hoI2Ke5TM6U40sOFeiH8bHAtoIqzzOJYsZdPn6zQ0f0=; b=i5IoLLtb+rnx0E2i
 Y7GgQWcz/gnXmfRv2Dmkvd79CqiHLbP185k15AKlwYyJDYvEzn6FOILQqzDzg/0F
 iCVIxN1bNEMjDQs4YJAyo6+TnudYPTLsyABDuzhGRGDgL5UiI1KipWWDrCPZA56g
 nZiaAZOYPM5OG8lpBkQmQu4gavufP6bLiXmWX5icgZD7DKjSWhp97I3sTYvhiCVk
 Vzwwq/0Qz3Tt8jTwmhCKyIYagp8XPMpGG6ltJ/cyyr4U8kmyyiB4NpQ2NdB6+mRh
 iOLnp8xYwgkmPirUxSlTwocAPFcmLFykBviuuMxB2qFeLaE2yeD4tlM/hRJ7+9BC
 R/yCBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b1fb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9441113670dso258114585a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793287227; x=1793892027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hoI2Ke5TM6U40sOFeiH8bHAtoIqzzOJYsZdPn6zQ0f0=;
 b=Nflsb9QZq72qR+uz+y9aEEt4snj547CHVnRBcV1TU/GVH+MyQApV13zvIgb9GeNJBt
 pOsAuOnT37Bi7+88Jr5lOihngeX1hMl4edg7RH00c/iS/TalkuZz7FzVO/5TOdxi1IoQ
 2vcDizqYYkUwgGOHXGz12CTsZ0gqATC90x8NLxaApY4Loo6TEcmc55a8LyDlayZ+nyJK
 /RSr6H/6XqXNTJpy4xmA1Sqabe/789yPh5J+z11bh8683ng62xB7G40kBx+5qkHTjA3Q
 5yG6g1ymZ4YOnQIJObSQ2iYEnb0754ti216Ioj8RuUyR9xsP9Vdu6dymjrn9htEu21q4
 WEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287227; x=1793892027;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hoI2Ke5TM6U40sOFeiH8bHAtoIqzzOJYsZdPn6zQ0f0=;
 b=qcvb6cXmuAL8hjsYpEjAMYgsVpWAFZVTxsZ0xpTe9bU1ePw2IIhoQSRJsb9B5ziUBV
 s54x/VRYhkeejpPjd2pDwuTeG3exTfO+g6C3fioDG/3UnWNHbQO9hgJ+6gX14uLv0H38
 2lSOSIszyu1FZJw6p7fR5IxloJbsMfkm9Yb5dVgjl62s0zOvNZVePXvRgyN6cVUwIN/B
 ohZ0wWdfx0sWyKJP8TpsCGqohEnvNFMKGWB6O4yRlKknhE8NI6cpBLsNzeWUUJSyiNNW
 Ase9TVNNu4iYtT3nYw0iDwU0Ek4GQ30V7NnmRvDYI1h+cC7+noLJ/BLP8rgO4momPvoi
 jajQ==
X-Gm-Message-State: AFq9FYLVsdUE5KLkh3UQg3vkuz47JS1BwdgKlMDPBdA0vC67U7kNgkBE
 gyAj9B094YICunj6ApvYv/LgDDVKEMDv/+Q8UxJ9FczfSABrHhAJ8AidCQj6l4lpxjQlEBS3vV6
 btCBHSMAQZ4irQxzAbE7GBbdFTBCjQ1jou9o9026Xz8Cv0ptWn8nYKTVG3snvkwwCDg62
X-Gm-Gg: AYBFou22AQA3NOZynYrYGPmAy4Pz25LfziBwhT3v06bDqxk1IdI+1ZjUGS/FZv0MSFN
 QIMkui3XJcV4qUyG9ff9NyVlGi7uQEo3wI+Poq5Mc3hcpwHnHe16HjoPtT7ls3wsmArbYHT3719
 hFc2TJx2Qk8N7i5ZgoXjchDWmzRquDtooBV6boIUfWqo82AfgtjBuuaR3XsgA9dGrsoYqDnvBgQ
 aIhmxUL5PB3atgc+68uMyBEKxfBiIQDn7ZneGWP31FKX3xeVn3NzzSV+33SNLjdwdffyp2Rw4QE
 r7QE+F76FGGPrLCE7EqKJ67mHJ9OFL0qHj8pd6HTimaOlWpK1QX254iPgi56XN6rvdIw1c7pVO+
 XwzRpM4p4vDv71i4y8Y/Yk5SXUEzr0s0uDcS/JfBjksgJ0uLA98QIfkuRqD+mzwTYhtUQ+g+oHs
 ImPtpAd8t2q6VXHdo=
X-Received: by 2002:a05:620a:29c5:b0:93f:59b8:e28a with SMTP id
 af79cd13be357-94408cf4114mr873513285a.28.1793287226506; 
 Thu, 29 Oct 2026 08:20:26 -0700 (PDT)
X-Received: by 2002:a05:620a:29c5:b0:93f:59b8:e28a with SMTP id
 af79cd13be357-94408cf4114mr873504785a.28.1793287225661; 
 Thu, 29 Oct 2026 08:20:25 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80285b2dsm71533185e9.13.2026.10.29.08.20.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:20:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] tests/tcg/mips64: Report Octeon test results with TAP
Date: Thu, 29 Oct 2026 16:20:07 +0100
Message-ID: <20261029152009.19812-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029152009.19812-1-philmd@oss.qualcomm.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfXz/TH739x2rok
 zWNMICPLDl1evZ2NSfVtv4U1nSEq09rcH/vBsd1pgCHakeI2R4wqRRWJumasEuPSZmkdqsWAFkE
 Nw/+fREX7nUByZCxG4vlYCqr187qJbg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX/J906cdSj429
 GHLZSeXHob6OYETjdl8zHBPumFoLBsSPBEf7beEfct9p4vVRVH7ioLRpj+CkcZjs1zwmX86pwOz
 APUAP1vfhHrckDWlONq1yEu9ru/M9S4/NUkPrF9BMTOVvRoag5WvaQyW50tNcMRbvTOf6oA28XI
 ttHmQPh/Ay5epJrggUhO0JHU9GkqU0BJJz33R4gtlQcuxkEMPctdSX6eOxwKGtbURwOsiABNouR
 /pAFSUQcSMcJyaYYD5bWyhdNXYeUXZxgvYo91P5314AXaExjnGO98X7tb1RZp4cwdKp+yEitWMl
 0m9d0PzO1eLx48degRJmK4gXEHJqxchrYriMK6q9MncLNs8GfmsaTikTKz6wgxjDKxWHvvofoBd
 Jvku1xgIq8Z7X0EPU5NoBaVzb6+1y+nsKf/Qbsaz1UyaD6QZcFJWqv6Js0tSDNp0Xz1hajyxW3U
 esQvMGlKurwPuKGXhzA==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3643c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=24OdzgigavIs_6l_i50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: bSAVTJAcTp9MAvA7YC3DF8Y2OAAR3gjd
X-Proofpoint-ORIG-GUID: bSAVTJAcTp9MAvA7YC3DF8Y2OAAR3gjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Replace assert() by a CHECK() macro printing one TAP line per check,
so a failure no longer aborts the remaining ones. Select the TAP
protocol in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/octeon-insns.c | 76 +++++++++++++++++++--------------
 tests/tcg/mips64/meson.build    |  1 +
 2 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
index 6fffc8201034..2c4fe8f58875 100644
--- a/tests/tcg/mips64/octeon-insns.c
+++ b/tests/tcg/mips64/octeon-insns.c
@@ -4,8 +4,17 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <assert.h>
 #include <stdint.h>
+#include <stdio.h>
+
+static int tests, failures;
+
+#define CHECK(cond) \
+    do { \
+        int ok_ = !!(cond); \
+        printf("%s %d - %s\n", ok_ ? "ok" : "not ok", ++tests, #cond); \
+        failures += !ok_; \
+    } while (0)
 
 static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
 {
@@ -385,36 +394,39 @@ static uint64_t octeon_rdhwr31_non_decreasing(void)
 
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
+    printf("TAP version 14\n");
+    CHECK(octeon_baddu(0x123, 0x0f0) == 0x13);
+    CHECK(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    CHECK(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    CHECK(octeon_seq(0xabc, 0xabc) == 1);
+    CHECK(octeon_seq(0xabc, 0xdef) == 0);
+    CHECK(octeon_sne(0xabc, 0xabc) == 0);
+    CHECK(octeon_sne(0xabc, 0xdef) == 1);
+    CHECK(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    CHECK(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    CHECK(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
+    CHECK(octeon_vmulu(5, 7, 11) == 46);
+    CHECK(octeon_vmm0(5, 13, 7, 11) == 59);
+    CHECK(octeon_vmm0_zeroes_mpl1() == 0);
+    CHECK(octeon_mtp0_zeroes_p1() == 0);
+    CHECK(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+          0x1122334455667788ULL);
+    CHECK(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+          0x8877665544332211ULL);
+    CHECK(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+          0x0102030405060708ULL);
+    CHECK(octeon_cop2_keylength_readback(0xa5) == 1);
+    CHECK(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
+          0x0102030405060708ULL);
+    CHECK(octeon_cop2_crc_len_readback(0xb5) == 5);
+    CHECK(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
+    CHECK(octeon_cop2_gfm_mul_reflect_write_readback(
+              0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
+    CHECK(octeon_cop2_gfm_mul_reflect_readback(
+              0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    CHECK(octeon_rdhwr31_non_decreasing());
 
-    return 0;
+    printf("1..%d\n", tests);
+
+    return failures ? 1 : 0;
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


