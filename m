Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D449EC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5T-0002W8-FU; Fri, 10 Jul 2026 17:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5Q-0002FV-NM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5N-0004kv-0P
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Fhi1621016
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o0R4hv5/zKp
 gL9fcw1LgUfWeYGP7sRAI0Ua+7Q7lPdg=; b=MMMPprQfe0Sxu/nTbp64b8GYaW/
 5XVFdBvHlreN84g0J7Gxqdw12Nn+VHBbwAt4F3h0Agzj9coGOJBG/4i+3+81LJey
 MB/G9qfYeUwQByVZbpP2MYQqphGSwHJB6Z57g/+kYI1MNTX7Z2U9EdcEIddOgELN
 dUexBiMTmj3zNlmCRz5c+XoZpPipiUkzU7+th6Lo7V3gIUiPfBdiXrZhizwUyBAX
 bq0MfZ1KWYfZkyRVjGRkUWaH4muNpYgdXzpDuN9PTql56nj5SG4My1l5S4kLwehR
 gQGzPozm26+nHzjYK6SsMQVOyW4aRu7gnB2JZoiVAv0C3d29j/rAAHFfN8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8v40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381abcccbf4so1250577a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720108; x=1784324908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o0R4hv5/zKpgL9fcw1LgUfWeYGP7sRAI0Ua+7Q7lPdg=;
 b=TxRUZb1SN1O8Z6/+cGaJ1pjq9KfiehPu62/3B2Gu6j6K6fOUljj9GcV41sm4+xzQiT
 yUmoBGwRj6RgSjR7IAvv1Xv7kNN/XvGAeeLqzhrfgwXb1xpYZCsNXyPobVhfr20RbR2Z
 WWWhQHeAttz+TYeGKRGCviheka3AwnA7WlA/7qo9V+dJEYEZ9N+g1Jl8g4eLPS27OGbG
 Mh/6ZH0X23iJU3c68plhR5zH2CiFglDK5dBp+mNb2HrtFzG+hfiaMZE732/gyFkSoOEF
 psVe6fV0TE2VTG0BcLWPhg8KbYXIV/ctKFKSWZC+j/Vk3h7EtlcacrDIuHm37bdCbUnz
 +uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720108; x=1784324908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o0R4hv5/zKpgL9fcw1LgUfWeYGP7sRAI0Ua+7Q7lPdg=;
 b=UkbfDW9rn6W/kN7z+9ZeokLqI5hQTs+j7ghf3kntR4xcjy473c1mcRIeD+/CjO71KM
 oQ+KQtkytMBj0+OFQSBeZxHSFwQEc5Y6vZfgbA4beIhSBlenhK/E2nfRC+7trW6STtld
 OO6gkypi47oW0oUXHej3nnycYy3QWn4df6X8x2/ZQa1gmyVEiE+NxfEQaz/dAOe/5Bif
 aoPD0liSiSN1RcXOqRPHVGp5rddrv1qr9QKFAHW3LGEn1G+LhSBrzTielmUsnH/3mLZ0
 xmMReEogh3Ptsl0WiecJhF/zlmsPW2t5R6jw12F/GM8WxSkVqlGEIKqvE32yldBPa/S0
 yEOg==
X-Gm-Message-State: AOJu0YxcOJjkRk8Hs9DY/aAqTzGsRwM6abhDpBQwZeDvGizt13ftOJpG
 5otp4da5OxmaEg385hcb7Vwdp3vkR1aWxOVBnQ9P5ME5dCfFkOHDYkQL9mYKdB20vLSReh2uZhK
 oCu8zXNZyk2LMuFGCmd/HofkymB8kKXRD7kPm9wH4eoMQbiQM3Nl0jQVHJZOxM21/Uw==
X-Gm-Gg: AfdE7clEr6cllMn905AoueRDNMc6OnZ1jAQlgPZszUyrettQZPPhq0NWp9fLy1U+WsL
 44/XOaum9OTCLdX0+18fzo/dFBu9ag6EvEyBzV5Bp5LRX7JrrrTDC98t61uAiGkXsJRZ4yAx+kj
 YF9j8OaClToauXvMy+knFpf0/Qi6cjmuKAO5VVHA7BxLqXw2VCmBMf4vb0ZKvOpjbQhfH4pak8L
 cwTU7+2JurQ0d7OTSewWTZxkrEV1UE5qqVf1nND18jwhzXYt7ckqMpmTrmswNIBc0HU1c32iHls
 2OGG+QWqjng7X2+szewoYPlzM0B3Nlb0ahwNY1WWNnDqyPP9n76YOa8wP3NVq4nsl+v1Ytm9qTP
 4lFPxUTRaEDUC09IWTaZClVbj+vl/znyw4Vq8t8Xc4DEZ0kHAOtDvwBfIEYPDU19QDJwcax1eqP
 1sfMcDNw==
X-Received: by 2002:a17:90b:4c92:b0:387:e0db:bc25 with SMTP id
 98e67ed59e1d1-38dc77c71ddmr632289a91.37.1783720107557; 
 Fri, 10 Jul 2026 14:48:27 -0700 (PDT)
X-Received: by 2002:a17:90b:4c92:b0:387:e0db:bc25 with SMTP id
 98e67ed59e1d1-38dc77c71ddmr632262a91.37.1783720107107; 
 Fri, 10 Jul 2026 14:48:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 44/98] tests/tcg/alpha: system tests
Date: Fri, 10 Jul 2026 14:42:48 -0700
Message-ID: <20260710214343.2065491-45-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ajZ18WCA31yxsPgLjcn1cuU07NFrQwSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4PET/qt3B7J3
 T1cXA8WQH3vCiPsw8wGqcj8X3sKjru+nuOAV4s07gMMeAfBAq4gZfHXMKeRuazulwjqQ+5Shk2I
 NM0w7xjNpeFCtsm0FCuSHTsjdsWkk2cwJ6vd8jb+coJSvS9rRjS43vhc2ByxeFxz4RRoEUqrP7n
 mdI7VuRHOxlZyUSdBm8zsj9BAUO6F0jRVJf7NRZ9rF5kzOdRq5GL4JiOYxQbARvGyEnUGVw2yXu
 PQkcwj2pLtMR/RAG3VCC0dfgIB9XSstMVuuPoHkTet3harPJi5HgrW7WtngvEa4ZwgMVz9zEiUT
 KN9gkMmO8x6WY4xAWzM5SSaLxlsdxlQ64BYqir8rjVAdR9lQW2m8rgMaJA2WLJmD0gSLmuaUPCA
 eFHvP3ndyaBLU+e3aqoY9sY5fIbIV4ssnonWbU7dhyPDkSjDW2D8gSLAD6LIpfaQlTbOO3XVSXE
 wEHAXT4+KTZkxX7oqNg==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5168ac cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=04VGBHJcbsNav9IjXu4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: ajZ18WCA31yxsPgLjcn1cuU07NFrQwSX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXwT1w110jgxjL
 1ZUt67Z3FHMRCIhangmoHnRo84IZzYk+NJsculQWX+IOrejlOb0Z10OCTlhpzwRR1I3n62HyHTo
 9nRonIeiVR2RrYuSqmawUcpe2bI6TnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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
 tests/tcg/alpha/Makefile.softmmu-target | 34 ------------------
 tests/tcg/alpha/meson.build             |  2 ++
 tests/tcg/alpha/system/meson.build      | 46 +++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 34 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 create mode 100644 tests/tcg/alpha/system/meson.build

diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
deleted file mode 100644
index a944102a3ce..00000000000
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Alpha system tests
-#
-
-ALPHA_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/alpha/system
-VPATH+=$(ALPHA_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ALPHA_TEST_SRCS=$(wildcard $(ALPHA_SYSTEM_SRC)/*.c)
-ALPHA_TESTS = $(patsubst $(ALPHA_SYSTEM_SRC)/%.c, %, $(ALPHA_TEST_SRCS))
-
-CRT_PATH=$(ALPHA_SYSTEM_SRC)
-LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0 -mbwx
-
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index 08e371116c3..fe60ce2496a 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -2,6 +2,8 @@ cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
new file mode 100644
index 00000000000..06558e4a9f6
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,46 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-mcpu=ev6',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += ['-DCHECK_UNALIGNED=0', '-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-alpha' in emulators
+  tcg_tests += {
+    'alpha-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha/system',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-system-alpha'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


