Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C154FC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryM-0004pd-Cu; Mon, 06 Jul 2026 18:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryK-0004an-LC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryI-0007FK-U8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE8nh1654907
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oj0hP2r8afR
 H97pvLHInBZwezH3fseuhDc5l7BzXDWU=; b=Q0qaJbslH3j4FJJB9gQqT0Gcnns
 0oRc3hfaaU+D7fEbZa9s6U2qhtTrMz8ngpmsaP6QMYAoFCZRe8DHihnyuSwDURu5
 csTXhfMZ2WxAXB0XCJiFXgQFIuzDo1j404vebVLJIFDLbptT4FoFiHHiw3m3ZxdF
 Jy9PIWdCWu+tjw/fanJUj8LYA2y6fnBeQQzv2s1qLUK5mcCTgKNxdx73/r+inYG/
 n+d6qdWlTji4/SU9CLDFw1233Svmaintxr/U0G9w7bYv2pgro5nBiw0ttAEczMrx
 koFBXAL/uTKy3cPoq5U/Te/1eMuxbMxJmDgtjSiJnInvLZIjgF1lQVc5dqw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk95f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so3017909a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377555; x=1783982355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oj0hP2r8afRH97pvLHInBZwezH3fseuhDc5l7BzXDWU=;
 b=BVoka6WkYnoCJg691RIdtffZ69hlqKc4fLF5JcsqoqkprWJinl7B5H8rt8syFzP2iE
 oSbjwLTyDicLu5qE02uJWXURJtQHF/NdplX5I0aBZ3Tz2kqwpqt/g4kTb+GCY+HxEETl
 UEMTE1f1tvh2UTWZPner5aL3rKyYlyniQ3iU0GOEdR5egj0LQvZSuO8rjea7gLemVnKi
 v3Zyp5DIqb24Mip6Nu/G9/0qvXC98oR4ViQqo8aF5r6CVFDQqrXoo9y4elb1PRLivXz7
 kObNuDlOexDJrS3t++CI1UDZ5yV2nDoPRaQZut+2b+6RjgK6mVpovAxhI93pte+qvBYY
 XdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377555; x=1783982355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oj0hP2r8afRH97pvLHInBZwezH3fseuhDc5l7BzXDWU=;
 b=D22QsUOJux1n1qDjO+qz5uGsSFo+hUUeZeyDYNqYmVBG2CFaB3Wf/7oMDfSZPs3chA
 /lp5RQTWpYPnlpKoHfm1rLas6B9cguy8I4JGsqIMjf37wA9EH2y0IpVmLVnW/YtDe69D
 pcnDJf4lhswfayFWuWnTbIOnV2fgZ4fCp+2bSfaMDARL0d3L03dgNQMnDXtcN0L/zZPZ
 9N1iZwMT1ed8uqeSvEjKE2RwZ50FOcofzY19l7NE1cj9XAyQSHXFXpI8302LCuF7MVHs
 NS/XR90e0FP0mSpOWImscmO6N+uDGuYRvgOng3MY8whtNlj5KnzDDk+jeiUNbWl+3DgL
 cBOw==
X-Gm-Message-State: AOJu0YyGrbiVTpeHOczm0oo6A2WviwYsayJxlJnuZvrEpG+BQCCgNXo3
 rpeQpwsFCqd/rAAByXDEu1egmyFwxyirDyRjlCcIzc2/p200VbqG4SX4n0RjNhnHhJoT45WO5RL
 gZPA4KoMMlXjvd0PDYJ1p3kWJsGCiKZK+fzeW8y2jBmkh8S7vHhLMSGq9Z5pli92oVw==
X-Gm-Gg: AfdE7ckhoYIMXc/0DJWqUlKONtoih2TFGMn3iw/0QUcVcOTRL4AGOeZNVH596laLNyK
 KOzOgKfX8wqktAkhtmQ6hHEcxHIYolZwDTEb75A5AFxlh080DrsD3ghgeOh3oBphR7SiNzaX0wy
 kN9meJ3RGfGeCyzJiUHbjfnKwSsdYpI1yC8e6cv0ofBTeiXr1k9lAf8mcPEoO8Os96rjQp3/1n8
 EnxRlciBABXexLuRwq2wHpoUmO230MyrmUMQPOw0/l67RYINOu29NWkCxEc3mMusv9+Y6ABV+Na
 RTCGxuyGRXkyhAmTjwOh7hDxPmwRz1ZvdZ53biwe6tfcrJzOmFLdV1seOxLOupeV1qHqSdf9Vrk
 dcQ+bP0cpnIlsFbDeFMwwJzriABxqo5nhfHYhvJ/WlRKjNcHKg9ufBCUWuAtpcY/h2sAjyDItNr
 emJDdrYw==
X-Received: by 2002:a05:6a21:7a4a:b0:3b4:e4f6:4f15 with SMTP id
 adf61e73a8af0-3c08ec9114emr3005807637.5.1783377554970; 
 Mon, 06 Jul 2026 15:39:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a4a:b0:3b4:e4f6:4f15 with SMTP id
 adf61e73a8af0-3c08ec9114emr3005768637.5.1783377554442; 
 Mon, 06 Jul 2026 15:39:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 74/91] tests/tcg/riscv64: user tests
Date: Mon,  6 Jul 2026 15:33:26 -0700
Message-ID: <20260706223343.988769-75-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c2e93 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0lQ2x3kWAKX1MkdxVHwA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: tttbHMHF2cUqgqTlDJ6YSONxN3HlftPl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX/KTPeoxQnjAq
 bGNaV5M//RmZ/ozXxJpvvYMUr65xWUkQUYXcpiwH32qDDSm7iDc6dTPlUesAo1zfdRcEoVFLlaY
 TtxhKX28OmKjJvTx/rCtAmAvtA9clGcZEd6MFc4yVbO/YRv9IE6rHGZKfJZ20I/Im+1tsUfPCVE
 JEAqNR3u7GQJl/ia2CgWCjdLjY1kn8TaFiTAPzakvWPuKIqaydrLEB9jPw1QmQ1EMRJD8PTL5s+
 ECLwq8UTPgp8+BVjLeljkC/IZAXJghWm+BY+EmD3ZCAWjv7c0uh0M367oWHDEg/LAZSG3u8g8VY
 bMmR4jJIOZsvwo3D3yW9ZqnogiArxct9xDyXYlPgk//PAwaxBr4MPg3nra+omzG30tdNG/kRbib
 lLpFmxILk5OSIxkedq03VwsBD7JbzTeQBU9odwrG70EhbwyR2lWu6knFX0RBXirhbQf+mqSjizn
 ta0winEP89F4k9FYobg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX8bTeC4MUE2o5
 PQL2xVfw1zUtyyezRcMl7et+DvwDwQ3Zvm5NNfWSZyyGbu1/2d80H8+jJtO5WgQlQ6uz8cU425A
 EbTiC37keUd9oB/UpUB6/DtlCHDixZQ=
X-Proofpoint-GUID: tttbHMHF2cUqgqTlDJ6YSONxN3HlftPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/riscv64/meson.build | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tests/tcg/riscv64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 452af88f00b..5e82784d318 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -149,6 +149,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
new file mode 100644
index 00000000000..393cd51d71a
--- /dev/null
+++ b/tests/tcg/riscv64/meson.build
@@ -0,0 +1,36 @@
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'noexec.c': {},
+  'test-aes.c': {'qemu_args': ['-cpu', 'rv64,zk=on']},
+  'test-div.c': {},
+  'test-fcvtmod.c': {
+    'cflags': ['-march=rv64imafdc'],
+    'qemu_args': ['-cpu', 'rv64,d=true,zfa=true'],
+  },
+  'test-noc.S': {
+    'cflags': ['-nostdlib'],
+    'qemu_args': ['-cpu', 'rv64,c=false'],
+  },
+}
+
+if 'qemu-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


