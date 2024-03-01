Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2b-0005Ia-2s; Fri, 01 Mar 2024 18:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1M-0003eU-SH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:31 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1H-0005c5-8H
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:28 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bb9b28acb4so1913228b6e.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334622; x=1709939422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMAzWUeeNJh47c4bkyOP/O/3UzvTHZWrc2G+MJg3FB0=;
 b=R29xo8072fvODYHj6CO3zejN6mxhmTEJ0HQshz1Lf8k/VLxRtv5g45pI8ai+KVX7Rn
 +NRgpwSq9CUhLSpgYQCpZjvgumr+D/snm9+1UOEGGEd4S42ijuqsHCOdsKRIRAZwGG3E
 GnvuRkT+8D5O3OmfsfyxYkywCh+uGpJfm4gxYdkYgbhLReRseBHfaaaZFd5BjSQ0Uo4Q
 Chcfr7Hu9KPvSyoxr9ej4CcC5OmT2q4Cyf1AeE8sE+tcaHgA4eonHUMzrfHndiVqM37p
 AksAe78DIn1v0D5W5KEx3PwCdD505sdDHFmtpeopby3wFK6z4eld4pdWulur69iH6QhI
 8yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334622; x=1709939422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMAzWUeeNJh47c4bkyOP/O/3UzvTHZWrc2G+MJg3FB0=;
 b=uuq9ucBd0ssyoUOGYErc7H+vGdl2R8t0QqAO9hB0KCV0UGHQPo+s1TLNdJM2rYPY0L
 ibVDpxaDLMI4Awhc/aFlXAW+mrFk17qy1Hagt/CF/srdnSzHx5RF5ztiND+hHVV1HH5B
 DgQpW0e263So9qtAlf0Pw2ZF2iBtB5x1LvqUOPiRiah0C1zvRYhVSiSNNVe75X9a3U6S
 entMt2bYPndE1hdaxYCHhRFg91wz0rAH48Rlu0arV8htDSUO8Z+f3RsvMf6oZOwjupg8
 Ss5VYd1JzJ/lcvkeCjUFDDb/OmBA4dH+HFb4C2m6tDu0vkazEMGZYOwSXd2S7IQBVzcB
 l8RQ==
X-Gm-Message-State: AOJu0YwA4pEM0/2w7cxvdME/ojmeIhy7HyhGNYKql9Ezk5/kjSVcyIp5
 X/iXky02imUCuo4rO3bcdjtRscd4A41swjiouBD5KqHbBFTChvVV7fpBMNwkHK8GNZOXc3DvI8E
 o
X-Google-Smtp-Source: AGHT+IH0VAyCH8v5SKh9FbISVc7ayTx9AbwyJZ7K87ludJFWUPFfxWKTvl7kVIlvlR2gLInLNTMcpg==
X-Received: by 2002:a05:6808:3c8d:b0:3c1:8066:7531 with SMTP id
 gs13-20020a0568083c8d00b003c180667531mr4725912oib.26.1709334621827; 
 Fri, 01 Mar 2024 15:10:21 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 40/60] linux-user: Use do_munmap for target_mmap failure
Date: Fri,  1 Mar 2024 13:05:59 -1000
Message-Id: <20240301230619.661008-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For the cases for which the host mmap succeeds, but does
not yield the desired address, use do_munmap to restore
the reserved_va memory reservation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8ebcca4444..cbcd31e941 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -326,7 +326,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p != host_start) {
             if (p != MAP_FAILED) {
-                munmap(p, host_page_size);
+                do_munmap(p, host_page_size);
                 errno = EEXIST;
             }
             return false;
@@ -622,7 +622,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             p = mmap(g2h_untagged(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
-                munmap(g2h_untagged(start), host_len);
+                do_munmap(g2h_untagged(start), host_len);
                 return -1;
             }
             host_start += offset - host_offset;
@@ -735,7 +735,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                      flags, fd, offset1);
             if (p != want_p) {
                 if (p != MAP_FAILED) {
-                    munmap(p, len1);
+                    do_munmap(p, len1);
                     errno = EEXIST;
                 }
                 return -1;
-- 
2.34.1


