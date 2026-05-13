Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F746CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4Kl-0000yK-Qs; Wed, 13 May 2026 03:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Kk-0000yB-KE
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:48:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Kj-0003bC-41
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:48:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so62049985e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778658523; x=1779263323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6dXY+gbSoUgZi27t3mSmDJWweTy4cmaLlRxPCqpCU10=;
 b=ycpLAi40XgriJfuz+CfRt/en3zqZOlpzRuf2gREWX8JsFqwlGK/CuD9DJ9qI5y31W7
 g0u+6BIIZ29R24n9cQUlH/Q0Q8+clAqPrgyVNhKj6O+vqYFAdcxmettWqQwRhAaz7C7t
 4DYdNt+F1S4F6MwMlKRf7mkV+FVP5Z2SG3QvlvOog/9+TXeu+4ZKMj/iNavRWZrpee4t
 H9i5wOvgcBpL2LLe24jOBu84aD0pUiJU8ud1R6F9LwwuPalVCp8qUGXXJ+RyQT0eVnej
 NQQOD9YoXGAHvXdkZbfn8xZlbbX/gbmNw/drmpDwot3qZSvhj9AF4oFuaQuqEtQSACVo
 gj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658523; x=1779263323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dXY+gbSoUgZi27t3mSmDJWweTy4cmaLlRxPCqpCU10=;
 b=tIfnBSPcdKVz/GIVW8nc7Ao0k6Tq57h/+BvNbuOYXqT/R6+PLd6LL9gjEVmc9lPdMJ
 CGlPBosRhyUcVHblWs/+g+Yyf+oZtNKzhurnYqm49GC0+RRMkfh1+mgjX+kUVczKu43W
 pShRaZ18RDoyEZvk9uzFMB9kO9i2/eiKGW7Xn93X62WAxubLu/Pvk91G8QG28r7CDEJ/
 ARBoxEZGLPYt4ke0g9ag87DuV3G8cHQKyntijHYD3SvnpEC4ZRwdXSH38ixM4YtPvTsn
 ldlSpsjsgtRYwI5UIZFn2lgTVuq1O+wY2jkohx/DRvpn5lT5lMBimcj/xYj+QIY+2x6G
 PjVQ==
X-Gm-Message-State: AOJu0YyZNDNh6MDKzTNwP3ymsDE/CbtgYNkIrqS/oul4SOeurOoRldUu
 AuhD/MthQUCFEZV0WBx9F65iPXw289yD4SJ0qd3mFWXs+4+rN8Y5FHOPc/dGsZlXT6Exfy7YdsG
 OUypIPzs=
X-Gm-Gg: Acq92OHUJ248KXZfYLLSgTYdyJ/tLZ4JNBF0VGh8AHugRLdbeAebgFtkd5hY20mXdqi
 sjmuLzNcAoMxNPspK0R+dqHt0yl4Bm5gaIKomwrZF28q55LjC9TEXpSDdV8d8/oV+yz0qmjVx2M
 pkU1PcC2YXLGzHLrvTAc5DeX/h0annuMFm0n2Ncvmi5L1/CiTa3uuqgcsMG+xdIQF4j6NWnbvUs
 18X8oc04c31BIIaEzMA5jgO9vYaP68GW8aT90R060KxT1OMixKaugb1SEC200CZCIQ6/O2kSl7I
 SHZO0hdvuDAyZZV0viFyHF+pezSltlnwB19m4rNqPG5BrdDwZX2x3QBCG4Jb3VB5XxHrktfFThq
 jcGemObOj27KrshB9aFX4adyV46g8kaqWMQe6IXV03K94H0BJQxW2C0VIlGEd7ySNfJShbazXiT
 SXuiDPGiQ7tA6mpHDz8Ki17E9s7aWTfiMcGc6NDWnTJdpckLSKEVw6qjn9EwhMyB5Q4Z/D/q26
X-Received: by 2002:a05:600c:c4ab:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fc9a3c1ffmr32778835e9.21.1778658522731; 
 Wed, 13 May 2026 00:48:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fcdf6408bsm33124995e9.3.2026.05.13.00.48.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:48:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/alpha: Inline UNALIGN() macro
Date: Wed, 13 May 2026 09:48:37 +0200
Message-ID: <20260513074840.11398-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Rename 'unalign' as 'mo_align' and use it in system
emulation too, allowing to remove the UNALIGN() macro.
(No logical change, 'aligning' with other targets)

Philippe Mathieu-Daudé (2):
  target/alpha: Use DisasContext::mo_align in system emulation
  target/alpha: Inline UNALIGN() macro

 target/alpha/translate.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
2.53.0


