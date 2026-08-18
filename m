Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DDEC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9TQ-0007Bx-Hd; Mon, 17 Aug 2026 22:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9TO-0007At-HA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:22:42 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9TM-0008IF-Si
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:22:42 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cbedf318752so2820693a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019759; x=1787624559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cX5rASESAh7WiDgjwmE7cChbypZGLRPxPYngvELopw=;
 b=GgH0bqDeqI/tgrejMdu90pC1cc739Rzny+HDBxBzC7hJxraSwXybAzZY/S7B9K/mFR
 gpOdlT6ySE/Rmp+aQv1iCptIzhq5uG5eacFyR1j+kvJJOsYIMbiDe5HjA1/lysVXIElU
 YtGHjze2D2rDMHjynKhUOo0SSqYTIaZGW4sDtGkg8/mLLj1kMAlEAv3c3VeCyeDCNWxU
 W4iu6pqZRJP+wLEuB+nJAXfLKQ30bAv6fpvv/XrEFAfiRlzeRvXWfzLf9XP9N3AsCaW9
 EjV6dZj4D9iuy5MPYMqMHVbQZyDR7YMWDlBBMp2rrQ8BWhfSDIhQyJpiUuskvt1daxqR
 3Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019759; x=1787624559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cX5rASESAh7WiDgjwmE7cChbypZGLRPxPYngvELopw=;
 b=YHYsJteIe5x0R57ozkJfVl+FTqkor/n0nMmTPGgThUWTWdtWrIWaRMGLIl2jcWJ7iD
 A0i2k1aGGtvG44XyQJboISDOX1AVZ90seMkO2gFW+Zl0I9IGFfB3AJSj4zh1C+te2eIf
 RU9eTLFEjP5sHpaVzb8wbz3iKwCSTSp+tfltyDeceGW4QIYyykrbVzK255RLFMMrWOnO
 25l7FaDBEMdjjaxaKnIpkLajYWgKs1HwQtNgWLiGpNHkOR7iEtR6GuEtOg+114ixX5yJ
 /phYCBBo0K5dNiviOPcbOnmAqqFZqpI/373qUsUsatJFKQXscTRoQBELl8ykd+8vu7fn
 w/cg==
X-Gm-Message-State: AOJu0Yy1FgPPyKYnwLKoQwOPCk4MAXKj7FbjELt530vGDulakR7sjaDU
 DRMdqlctMUh47PUZNFqXNi9dQUoU108Qr2XUZfQnRVO5A7bqimzYs0ksjA9LLQ==
X-Gm-Gg: AR+sD132MqgQppST/1+marfPn0Jd+gUYbltDEzv8Om4tlY+vyCtseze/hKD+bTP36FC
 ch1/Zhoin5U+4XEs+r5sguLknGwwUiCtSffvpM1HWpzxawNMDN8LJgTFq8wu5lA9L/E5o5sTrai
 gA2FGh61BcxhY6w3ssGDwjd0X/UDSkrQEvJddPVHgFHpBPagIFp8XMor3oD6cwBQ4xkoHspQSkb
 0oFgAcdm4o4b8MBq99dTevhPQHfPrOsL5CwSTr2Jmc/GoH5TMzPpiZnuI6Nql1IezbwocpqVALl
 x+XfPYh2iswH8HJyfsfJGsy8Ewk1ywdx7NWDxOTT0fJRSY8lcQDbTfCWMvPyql8sZXXc68kAZqR
 6C5a387DBkzIxc0qGKjkPKihoOzdD84RIUKtcmn0sdWZHXtRj2o1Y2Fd1o/LFXw0Q4AFcGx+U6g
 Gv6X5mOqsKL91h/B0fSuSSEcxWv/WpYSE7ldDnIBA2lTIGnZz6CXceaDyaNiWewZy+04SjmG3u/
 xSv
X-Received: by 2002:a05:6a20:7f88:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cc719fe40fmr31489786637.5.1787019758578; 
 Mon, 17 Aug 2026 19:22:38 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:22:38 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 0/6] Implement missing functionality and hooks in mk68k to
 support upcoming sun3 impl
Date: Mon, 17 Aug 2026 19:22:16 -0700
Message-ID: <20260818022225.31801-1-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=54weasels@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Extends the 68020 implementation to support the requirements of a sun3 machine.
This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into smaller parts.

54weasels (6):
  target/m68k: Add dummy CAAR register
  target/m68k: Fix fsave/frestore for 68881 FPU
  target/m68k: Fix NMI pending for Level 7 interrupts
  target/m68k: Extract Function Codes during TLB fills
  target/m68k: Implement custom MMU intercept hook
  target/m68k: Implement Physical Bus Error and Stack

 target/m68k/cpu.c       |   4 +-
 target/m68k/cpu.h       |  18 ++++-
 target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
 target/m68k/op_helper.c | 175 ++++++++++++++++++++++++++--------------
 target/m68k/translate.c |  30 +++++--
 5 files changed, 280 insertions(+), 77 deletions(-)

-- 
2.50.1 (Apple Git-155)


