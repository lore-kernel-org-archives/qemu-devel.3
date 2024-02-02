Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3272AC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 03:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVkTm-0004XX-6m; Thu, 01 Feb 2024 22:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVkTl-0004XG-0e
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 22:44:37 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVkTj-0001D4-6d
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 22:44:36 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6da6b0eb2d4so1265643b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 19:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706845473; x=1707450273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kq0J8Afnqo7enZSunt87RCQsJ4GxKCY2HEoeL1qsLBQ=;
 b=rA++wZmcDGCVx60hP5NTjvUBo3qyAmXjS9dENJsb62+wlwV6uKxWqajT3P+PUu2ZhX
 2xNnkRQK3qk7Jxzpykn029xUcujOKGP29H6RjrE2UixYtcLu0FgmjUZ8rPonR8/O6Yjj
 niqiAeaFnrPcaXXudhQTgAbBrbnKEMjGTWeAWpCsllrgzSG8OJjD5D/WJP0AZ0X8oW3x
 xICC4LvaB5m0G9pGcRn9gF3QcCI3t4CsIow3ljjShcJNBnID0nSC0QJHtJ8nwjXg2C6N
 r7h1lociETSkVuxj55ZxHSTmGGs9MLG3alZMturTM3wdp9yc08+nBO2fc/CTuQl4vdlP
 TZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706845473; x=1707450273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kq0J8Afnqo7enZSunt87RCQsJ4GxKCY2HEoeL1qsLBQ=;
 b=iRhF6ob8OpmV4Np/xowwKJeDGg5YUrKgOgLZjnFtov6PWQzgwY9g2A5A1Z7bLNGtGZ
 vCJ/TdjU6kR5nMhHm3cBl2us6fz5+BhbtGL8SGEsKg0GNKfp3/z594vyG2LfR0EzdLqi
 5VfJ4PTFiKcEfEKRG46FfZxkO3i++0Tdrmckl3Bom0K78RnPhEV3APCbQFnaygn6gzZj
 fJN8QgnjlYmwK5mRntaX0Gf3lCoczlp7gMwrYnJdtccFScoVl/BxrRViiU6Lixsy2gWs
 /7Z6DrCFDc94RCfgSw/K3b7EjygAV5MUb0XK4R/7dkJOiFekVXe3LttAx4LiZlQ0nk32
 69iQ==
X-Gm-Message-State: AOJu0YzluLIPDVTWLrdxsykZGSl29gLOORp2IiTVyFLHJzeuwie2s7C2
 BBpKIo74QLQHmg7HBVVqHVAmT7EhphwTtslHgu5lzIltIw8yPIKIZTX+x5LIM5QztRWoS2qIV+Z
 JP4k=
X-Google-Smtp-Source: AGHT+IG4uVDUWVvNE3f+hTpEKX2IASd+vz1eP7ZxOFz2czGgn0o9/rjD5/x2gMvet/y5jGY1eQoNKQ==
X-Received: by 2002:a62:aa0f:0:b0:6de:1da4:ca99 with SMTP id
 e15-20020a62aa0f000000b006de1da4ca99mr6748162pff.18.1706845473413; 
 Thu, 01 Feb 2024 19:44:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU11tzfGrnWBIP9q0pwgG6TV8kJCzOOS2igQDou961oxeHLoI68plkJzhjIJSOblfhYKoxVKYPIDSVBxr0AMpb/gZnob7T3vJosgX/OTewA6EtHnj+KM+j6EIATW8MP9uwvIA==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 o3-20020a056a001b4300b006d9be279432sm525757pfv.2.2024.02.01.19.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 19:44:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH] linux-user/aarch64: Add padding before __kernel_rt_sigreturn
Date: Fri,  2 Feb 2024 13:44:27 +1000
Message-Id: <20240202034427.504686-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


