Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B842C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 11:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLJx-0000Jt-Ag; Fri, 08 Aug 2025 07:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukLIy-0008L7-Rb
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:30:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukLIw-0002yj-Lv
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:30:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso1273571f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754652632; x=1755257432; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+wacFuJvSwCjdGK+yHs0J/J5a0AOT1HDGQitNzCH8BM=;
 b=iI1aKK16JmS5vGwDTTYZ3IplbFMPjf+qZK4uMsv14amhl5zQ19aFNfjIKf7jirhYbr
 FFUoP4OKgNfLmhMPoupxJVOvCNloSvgkua2Kqr5y7sBKzud+0xdaJLwfLvJ+e9msZeww
 eTdLlpaD5ucu8cgW3lD2O71Nmav4Lpr2GApzKStrapg5r3qJ6c/lYsiYJnihCQ9aN6+7
 WjWLG0b9A76u7wqrJqRmqG1MfbYFD7AVDL29l7yT08AR6JkYEEJ8TpfnCxmqx4qodjYZ
 X51w1Gigf0pZBFdzi3oXFqnM1j1GBpyN0jfKSJPBhQ7E+SKH5ryXSkYyqdzCvqg5x57P
 Vgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754652632; x=1755257432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wacFuJvSwCjdGK+yHs0J/J5a0AOT1HDGQitNzCH8BM=;
 b=Ys23b01J/Mbpfuq5l+gEm5KPaxQ5ynLPJ2r88Ju13WvisDUHJIag+7za+NQEvPUP/t
 VWCCroyRnGgBl3utZoXtpmNi2yGSBh0X2Y0TMIl+iCajRb034D1Shn+mtdboEAULJkp1
 758YT1+oPOGex70/WCqn3BaAPDMAZJ44RFxK1plQdXHOO1foTmEwgJQ8eG+JfkrQFnQX
 3XVSQhB3JVKE/oF1TnKe8ZolCky8DH9rLdRWU1WRw2CbE7hp4r2PQsy+d0J1kQMRyP3J
 iN8Hfy6l3Us/tbM9E+Ior4Cs+6Yck7SY7xqsd3OT9ti4bTcBuXO8/hpMHuCu4pt8f674
 x95g==
X-Gm-Message-State: AOJu0YxYK4KwZvyLVZ5f6LauLnZgoPCeZYZMUw1saSc7zShbci43HsAl
 /xCxpKWYdIX7xHLoHeM2e620NL6JjaPOFAQAXjRt6PdwpvB0uW9R7f58aj0PonU9WHs=
X-Gm-Gg: ASbGncumEhuS6H14f9kcld8qEHjlPrgbQ8DJPNdj1wG8tJl8GL64hZVl6hFwh1VAyvE
 R5N0bX7ARWGQZV6zHT5382XeELmuYi8iywIf1yniQr40yr1qdz8PybVUlskTx0meZjcF27MBfY6
 1sPeJnubPxHLIvUuOu4JAoVnTnELUH9rnnMG7W+Y8I0uvj/oHaiDgTqSEygXomS3wDcwX3CTixF
 muOx2BtB+XWDcCVUBhGgf/MjSXQI+GdTBb/6FIC4H1eZUSBTj6RoIyz7iyeHCafqGLHKEvojx6u
 huzgJv8rmF9i3zxnPyQzzrgAGzXjBZL9pk3zmOFSA4x5yAinH5tItP5WNwBwRpqtYwTaYv+8jzv
 h6sEBUn2WaNq44vZrTnrDddNLB1g0CI/gX+5WuZJJT8Hw4BszqyutTv2TERnrK7fhnS4c
X-Google-Smtp-Source: AGHT+IFeJ8yRkBe3aeVWRlJSj7l0WY3ou+kv2a1em8V/MmfBMa1mOfVdSINeuxXWNj9CiylFHFCe/g==
X-Received: by 2002:a5d:5f8b:0:b0:3b7:8f3b:1726 with SMTP id
 ffacd0b85a97d-3b900fc84camr2130737f8f.7.1754652631914; 
 Fri, 08 Aug 2025 04:30:31 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9386sm30034248f8f.18.2025.08.08.04.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 04:30:31 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 08 Aug 2025 14:30:15 +0300
Subject: [PATCH 3/4] gdbstub/aarch64: add DAIF register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-gdbstub-aarch64-pstate-regs-v1-3-14ba70be1b3d@linaro.org>
References: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
In-Reply-To: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=pdsXwnZTWgdqtptBVXPmXR1JF3tTkJfujnXQK7E62KQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9sZC9TYkl4eWdRNDJOaEdZNFF4a2Z1M3ZBMmhxCmFmVHZSNVI0eTZ0cStXcGtJ
 clNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpYZjBnQUt
 DUkIzS2Nkd2YzNEowS1RpRC80cVJXbVZ3ZFp1ckk2bmhRSXBYV0d4U2tnU21wdGhNeXRLUlVKVA
 pDcDdVVk80SFFoNjVHNElqVVRvMkt2dmdJdjhqOGJMd2tKS2hwZ2MxTGlYMTZVbVh5VTQvUnROa
 Gd2blVXbCtFClN5SmlZZWtNVnY3TjhnSFRsU3ZUNXN1MEczN1RSRjZZRkdFTjNicE5wVnF2VHpX
 TnJyR0VWWFlZeFA5c3pCR3QKQTN1Z0IzVWJFZDcwT3VvTndGak05ZUkyTEg4UmFiaUM2ek1DUVp
 ocXdlT2tDVGZ1R3B5ZytoZzhITXpxc2g1TAo3ZkxvNURiK1AvTms5M0hOY0VLeGh5TnBjQW03Yk
 FlNklsVkowTXN4cWtJVHNSd2Z4dnZGeEFmQTFNZGcxUmg3CjBWOEhXTnVsc0E1VWtxOUtrUGhxM
 GZueDRoTEdxbjJhbVMxaE55R3JyRXhBa3VBa2FIWVVXRXR5SE5CaWhYeEUKM1lzeDEzMkIxRDRk
 dU4xTXdNRzZpTnJUeFpMRlE4ZGlsNHRRWTJHdlVmTnpwSisycFNnWVBwUUh4aVZ0Vm0vbwpCd2J
 nWFowd3RWclZsVzYwcE0zUXhrbDBBZFNWeWI3M3BhRGZvWGFFejJoQzJXYTloNkNzci9jVHFhel
 VLaG9qClNuR1A4RkNPamVUbWM1TndiR2JOVGpiNFJZRU02c2QxRXV3dGdnYXNDYW5VanFxQVdZV
 Dk3VUJZNlJnQW1NYk8KWlpGcnlENlphSnZScHJVUmlFL3hhQlMrWG9Sb1Y0U2k1YmJxU05PYWt4
 MUNpKytSRVFFMWNnU25HTG5KNWZORAo0ZGxHWWxHdGpPRHFvbWNEVmNWdzBSSVQyM0piMWxuZ1l
 mMXRLam41UlFaUEdkaUhSYy9KVEt3U3VGWE0rUjljCjlJaERWUT09Cj1YZEhXCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 gdb-xml/aarch64-core.xml | 12 ++++++++++++
 target/arm/gdbstub64.c   |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/gdb-xml/aarch64-core.xml b/gdb-xml/aarch64-core.xml
index 2b74b87f908f792c24f76f212e4f7eaf335ddbc2..dffc92303fc7b7e8221cf6afd6009101f34352ed 100644
--- a/gdb-xml/aarch64-core.xml
+++ b/gdb-xml/aarch64-core.xml
@@ -108,4 +108,16 @@
     <field name="N" start="31" end="31"/>
   </flags>
   <reg name="NZCV" bitsize="64" type="nzcv_flags"/>
+
+  <flags id="daif_flags" size="8">
+    <!-- FIQ interrupt mask.  -->
+    <field name="F" start="6" end="6"/>
+    <!-- IRQ interrupt mask.  -->
+    <field name="I" start="7" end="7"/>
+    <!-- SError interrupt mask.  -->
+    <field name="A" start="8" end="8"/>
+    <!-- Debug exception mask.  -->
+    <field name="D" start="9" end="9"/>
+  </flags>
+  <reg name="DAIF" bitsize="64" type="daif_flags"/>
 </feature>
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index dd3c6222a577efa03753cf07371afdedeefdb771..6c424ed361e32e12836c6ef00a06397bd684bac4 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -54,6 +54,9 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 35:
         /* NZCV */
         return gdb_get_reg64(mem_buf, pstate_read(env) & PSTATE_NZCV);
+    case 36:
+        /* DAIF */
+        return gdb_get_reg64(mem_buf, env->daif);
     }
     /* Unknown register.  */
     return 0;
@@ -91,6 +94,10 @@ int aarch64_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         tmp = (pstate_read(env) & ~PSTATE_NZCV) | (tmp & PSTATE_NZCV);
         pstate_write(env, tmp);
         return 8;
+    case 36:
+        /* DAIF */
+        env->daif = tmp & PSTATE_DAIF;
+        return 8;
     }
     /* Unknown register.  */
     return 0;

-- 
2.47.2


