Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD0C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 07:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWA7N-0007Hc-Bv; Sat, 03 Feb 2024 02:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7J-0007GE-F3
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:10 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7H-0002Z7-Qj
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:09 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d746856d85so22079465ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 23:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706944026; x=1707548826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lmpwsvp9czCO9AH20iwRSLsPYqByt2xj1o0sfwNIkQ=;
 b=II7WZVTUxglZ2iEnxkUmK5wYcqm4PibI4aQL6+bKqDzrNmNT1ZleyJ/zp0rH4kzTwT
 w/bKz+Fz1sSb/IFJXU14PqqVM8N6MDkEhy1nF95KTDaEjL7w0rOp5imLiDKeW4x3/uih
 2+NBRqPsUtgtC5RU9PQnrVW0Pl0oLVvdnw2wgLRahYmv9hIRvj7PI8Xo4O/O9/Q5xnXW
 jenD67hf5bG8wmydPVYkMN+CQrlKjVJe1FOfEDhYzGdbFpGEEWF1duU2PvBufjKoT6D0
 qNJsFOtzEdAPLSWLw/XLVvKAf1fnbaqbgumzGc6BUCRKIv/y0LWKgA6KkVpGU+rzPA0D
 3uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706944026; x=1707548826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lmpwsvp9czCO9AH20iwRSLsPYqByt2xj1o0sfwNIkQ=;
 b=vm6nZFISnl4oixKFwQuUsmy2KsUmKjuxS5IXfkqnQiWqkFvIWkZGKRMPl4MuOO7/Rk
 nDXQBsRPsTiUCvM8u0+GW/fIybyWwHrODXABxgGF3q+3DLMMsOcUt/rQZ2nNeLR65EQO
 WYhS+/vFuBj1AzkXjzq07SDKXghVf3ho9Q0sxzKbCEFSuL11KiBWFlnY/riETOoxid0u
 aS3kq8KH4h/7FhM4FbDa6MQdJ7+kYHFFNsm9pc9cWS4hRHtcOMt2ondBHnq3o77vYvRk
 JR6i+8vsNfgiUXOv2f5/UjzwlF9UBXprHQDE8Tax5Z8A0nR9aPXinBC+k0lXC9CXoeIN
 hO7A==
X-Gm-Message-State: AOJu0YyFnVQCQPUUi8LcYl/ZDPpjZS/gdCT8uvSAm2FYFCs0a+qjQaQL
 FHlfbeJ6LFJInGFGRYEmGaZZI8ZzudYqLLgXry6YyfuaLFJ41tSG56Zhg1INbWI8Re8EI6F1IL7
 qgYM=
X-Google-Smtp-Source: AGHT+IF1SkVdT3DGG7oOQ4PXnlWMYmB3c6Zcg8Khjgf3tYhHht8roGJuCKbQICUSDl6yey6kyJsbIg==
X-Received: by 2002:a17:903:186:b0:1d9:dce:d4d1 with SMTP id
 z6-20020a170903018600b001d90dced4d1mr4760152plg.30.1706944026151; 
 Fri, 02 Feb 2024 23:07:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU0RH793cUVewNaX/haCV2NzK6xlxYnPO7eqN6kj3jXAekCHO6s4CbP3uw8rUcWbcqPbiRPLYVRaI29Cjx3F8EOZieyNTbY
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d08b00b001d94665e9d3sm2658034plv.45.2024.02.02.23.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 23:07:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 58/58] linux-user/aarch64: Add padding before
 __kernel_rt_sigreturn
Date: Sat,  3 Feb 2024 17:06:54 +1000
Message-Id: <20240203070654.982407-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203070654.982407-1-richard.henderson@linaro.org>
References: <20240203070654.982407-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Without this padding, an unwind through the signal handler
will pick up the unwind info for the preceding syscall.

This fixes gcc's 30_threads/thread/native_handle/cancel.cc.

Cc: qemu-stable@nongnu.org
Fixes: ee95fae075c6 ("linux-user/aarch64: Add vdso")
Resolves: https://linaro.atlassian.net/browse/GNU-974
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240202034427.504686-1-richard.henderson@linaro.org>
---
 linux-user/aarch64/vdso-be.so | Bin 3216 -> 3224 bytes
 linux-user/aarch64/vdso-le.so | Bin 3216 -> 3224 bytes
 linux-user/aarch64/vdso.S     |   4 ++++
 3 files changed, 4 insertions(+)

diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
index 6084f3d1a701316004894fcdd739c4e1e0463b68..808206ade824b09d786f6cc34f7cddf80b63130e 100755
GIT binary patch
delta 121
zcmbOrIYV-SKI4pu2Kk&{7{Gw#%fuBAMC1c?^>~k}v|avdxNjSSLfftVb3bgJ!|2S&
z_-6A1CJrVZc?IUH8G;R$7#SF@Om<{a*v!K!&BXX-vIe^~TWO|cva$K*Om;sOMw`hy
ZxXl@VO#Z-a&zLdUfXALuXmSCM0s#EKC)of1

delta 116
zcmbOsIYDxQKI4Rm2Kk&H7{Gw#!^9O2L>8U?-5V_M@!kH(Sx4vJn|*ujLPgija~Pc&
z8DDIEz{J5c`3;N8W)W6tCdL<&4cM*OEF8_<v%@zRviq?xT1-B`ZO-^%@(*r%#)Qch
RJocPi5ThAdCO2?N002V6C;<Qf

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
index 947d534ec1899740edbd6921da6bc6e70e2ecd09..941aaf29931193300de1f62097867c282a7e0c74 100755
GIT binary patch
delta 129
zcmbOrIYV-S2IGv0n)#exSQx<I%fyAxMZTVBQ(04AP_*V|Vxp|@=@;x8zb9;-!)U|E
z_-6A>CVnO!c?IUH8G;R$7#SF@Om<{a*v!K!!o>JyvLd?^n`3BUW_royOm=q`Mw`hS
dxy>1WOn%92&zLb;lgFM@hy!9z%j7~Xc>tTxDQW-!

delta 108
zcmbOsIYDxQ2IGW@n)#d`SQx<I!^DNpMK&+G&+g_}w9WI@dn@@euKVesZ-h6`VYFdn
ze6jf^6F<}BH!LcfMOa0c7+*}*WOrgKEO1Fl%G+GX?#{w!F?lDqIpc@PAGz%r6DAw-
M*fVlXF62=M06owo?*IS*

diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
index 34d3a9ebd2..a0ac1487b0 100644
--- a/linux-user/aarch64/vdso.S
+++ b/linux-user/aarch64/vdso.S
@@ -63,7 +63,11 @@ vdso_syscall __kernel_clock_getres, __NR_clock_getres
  * For now, elide the unwind info for __kernel_rt_sigreturn and rely on
  * the libgcc fallback routine as we have always done.  This requires
  * that the code sequence used be exact.
+ *
+ * Add a nop as a spacer to ensure that unwind does not pick up the
+ * unwind info from the preceding syscall.
  */
+	nop
 __kernel_rt_sigreturn:
 	/* No BTI C insn here -- we arrive via RET. */
 	mov	x8, #__NR_rt_sigreturn
-- 
2.34.1


