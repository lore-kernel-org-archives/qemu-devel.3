Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CCDCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx9-0005Dp-Pi; Sun, 10 May 2026 16:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwq-000570-Pv
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:25 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwo-00040w-5j
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:23 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479d593a0c3so3146463b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445621; x=1779050421; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5utbP++/Tj8it9tIefxmV3U3878OfBYKOWJ/cCzeD7k=;
 b=DbKwst0DwCf9sg2rcs8WYmGFz2hVMrK2+P8E5Z6lX+Zxnz6s78NKDUPtVYPB74mcjG
 /jULPwNBHEIkZTsImWN1lP/8Bnpw+7UfwTxikps6vZ1tG9A46fu30xCs37R3ymV7Fysj
 /NsjiuM57ePdEcdKYkUqfoxlIndDek6inf2ZGgPb2HCPwnNBCR7rmrVbgJqTBYyHMzjM
 JshwXi78W7Z6YZDWnMQ06nZHbZlODEuG9tsyNlh2mQ3VzNAACA/4r3CtUrptYUoGPqGn
 JHyYbzx4cKbLKmgQahaGuKT+FhL3MIBuLU2C0GenFyeHJAiM8+ZUencUCw9I15XdxZna
 kmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445621; x=1779050421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5utbP++/Tj8it9tIefxmV3U3878OfBYKOWJ/cCzeD7k=;
 b=j4g83IZFCih/A8mWxBU+l3e81xN4u2X4nvTwJHn4TVeLojlCTz2KSeeS3Lky729/TE
 lCVeAx1t9HMVg9xAwxHSjE/Y7hfEXf+8dFNPXfKHMhgaf5YSj9YqjNgpBfkHxeA6xbmn
 7WfDr2ohoPSR3/PTX/ovtkkwUwuDj6qGLhwnGIlCsnNdgkZAGcnC7DekM6zt4gBE3No5
 ntYmSeVFzJ+yK8B7s9Fy+HWWi+zescUjlzgQaFefi8u5vVSkF1vqPTWl9bz2gQvf85AE
 h3K2KQeufnssXE20S420vt7YYVCpbXOawRqPfO6vaCnJWLk0aMZQwG3jP+pM8BNNjScG
 Ntxg==
X-Gm-Message-State: AOJu0Yy0L6YnLaf+nM2B8knt1tE6hCnUbOdoO53lRjzHvsQEhRhuoKOg
 IDmHw3cWdwjRe6nmo/xBfJpAi01SDW3qYg4ayN7vsgewwvMOgstKEoDkxyqQa3Av
X-Gm-Gg: Acq92OF8KIFRlzwUQgRq75O1qyUTTGwLR80xDD73+Cee9kBBWMJTDr1VTUyZjJvzxud
 Bu57HXisgRDZlfhA5WAY9lqxca/9eAgKnChuLtnEucPxjmbBcEdaV3S0sAA24TTDQHWgnzsTIId
 auOjTXU8FzQLvfqgnkgsXOgD0T3N1bMkuNyi0TrkuVMmfrEQCwuII2Q73oPXRe0Co/F2L4k9Yt5
 tkuTDaXne3K1ENzQ2mctLu4z7YcLcn6u/5Fzr6O6um3prulTqFL2mg3AcLBWvZh5eFYHUAIQAUm
 tqj4MOoi+a3qeDq3XEmdn0T/eatU2lEXWeLG1jpVcNSxaDkK7u+wNACJVRwLtutm4ECI03zz4Ew
 POswZeqCOySLI1qXHyZBpdzcwIXUvrmkP0Yx7+ZjlGoRbJ7K3apoDpXoe1j1D5WjK5P02yf84jH
 g32tVDLRCqZr6uIJZnwa87lxSTd/SwB/GjZqwaeFghBbT063lw8cF9C7ECRb7m28skTfuqcbNgn
 yeWppkQqYmJ7twnzedvOXfjGlpzz9BrUwSKksrbR8bYJg4mwh4ndj9nkfqo5Hwo
X-Received: by 2002:a05:6808:159c:b0:47c:7407:c0a7 with SMTP id
 5614622812f47-480617e7f56mr8479609b6e.0.1778445621201; 
 Sun, 10 May 2026 13:40:21 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:47 -0600
Subject: [PATCH v5 17/32] target/mips: add Octeon MTP1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-17-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

MTP1 loads the middle Octeon3 partial-product pair from rs/rt into P[1]
and P[4].

This completes the second guest-visible partial-product slot used by the
Octeon multiplier helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt P[1]/P[4] pair handled by the shared MTP
    translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 59ab7401ab..670a12a956 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -46,6 +46,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
+MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 3df46c3c03..1a6a07c9ee 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -276,3 +276,4 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);

-- 
2.54.0


