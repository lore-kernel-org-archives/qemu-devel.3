Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F21CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4Fm-0006ch-RL; Wed, 13 May 2026 03:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Fd-0006c9-US
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:43:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Fc-0001Qm-2N
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:43:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso73491225e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778658206; x=1779263006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MTOcwSsn/cKIY3aptbGYmJ2IDLg8xfNiWjFyxhUzJ0o=;
 b=frVFkoZooq2tfKF3Q0XPeHTjdS4IFhlieKqdY2oKvmy2dpDG3pnwYk6RNA3mfLh/q+
 jZ2R2NgKtSeD1KhwSD0KrmTGfzU1ZPimr0AsC3zJhjOTx3pYtbl8sVpuomX/SSQWHw4z
 rK2nPg/S8NLEThch8FyfOVNRHoIwgV1gkUT3iu5YkjnF3qyb51JiwqxzDEPoYdqPY4Wt
 YOGtIvkpZvwEIgRlvKpUlI9jmOiZ8PlzNOFJb0DTSa14wMdnralgaQlLQTLr6ZkOIC5x
 3M1No7lp9xj//GRaoPGHMhkkM35qilvRBh+CFshcoGpBIzrbNbmYujKpbngXkOzaoOjb
 Rgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658206; x=1779263006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTOcwSsn/cKIY3aptbGYmJ2IDLg8xfNiWjFyxhUzJ0o=;
 b=seYrLBx4r8LgmSpOx+SxFLa7SrFAecnsYqiSVTayZW9CMwjSk/d2AgLXYa2w2Oiche
 /IHvoRmmoitv7TGGmS0YG+b/rWZcOEpXuR5cRtFT8RcIzdurl5i9zvF0C3nlc44nDuVk
 CA0DXmCYtWnJ2PSk9RfCIp9PK/n5AouCr+eu3DLC1QMCrmaKmGAa/xtIwRwOBLvuS1JP
 I0h6/Kkl366viHBln61knOnAWLYSHxwPI4oXM7Ek5VK9tvj59KvEUxWt9tt9Jg5x68J7
 kgRYkUDYomlmqIcNfDZEqAAkXUGpc6CNWAA/kxlgi4sNNLYhUBk9Wn9nAjOCGKzwq9uo
 K1oQ==
X-Gm-Message-State: AOJu0YywEHKB7eJ1r2PnUDs0TlFghc+xgEgO9wuRsIryMNC4ktVjb6PK
 n/zNRT+X1LH9dUKw68eim/uCuo+vvKzSL1Viq9NJfCGBaY5kPW+oqjNYoHqlmKNwwc8Nmk8VQsd
 3ImRsLpg=
X-Gm-Gg: Acq92OGEXgSSn47KwJTaIECF1zykV+ybggoNmsplFutaN6+NdO2u3jzEPmpWMpwvL1V
 P0rUDTg8oOpQuOwWWZGCBnStFNo5tXvjb4NwUK1Rk8pVWdRD+3zhwNi2TYhz4zaK9fpGJ7wh8zr
 TTxBMv2w8tag4awFch6TXwwWJ/CBdEodtIugLIkT/RHZ8ZPj5cIHH4w7ifgEzr/rWA8quzKYYYO
 rwnxJd1WsLugzv2e+X0zSKf8JHfbFec0OdJZiYBoVQpS8gBAGtVnKp621Tz3sPZ7mY9FFXlbYNb
 CR//v2EEjUZQ1aKecldE2po6YxZpvC66iYvpOfDngpsY+4bRK/zdL3T5mFA8GSI3rCUTZFQA0Jh
 n8I48NpFET2NxmfOk0dOU112QAYkW4e1HtxpqFBhXWUI1pI8CzCtKySfn/R5Ge8l7cnILjiitS1
 ofWJC3K5LzI4PgnQ9ZgD4d/Nv6U//ZXLCN5DvEDTuFaR1/RbRYdk2yUtxIK+lWKxMEZT4FDSqx
X-Received: by 2002:a05:600c:1792:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48fcff534edmr8919495e9.25.1778658205351; 
 Wed, 13 May 2026 00:43:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fce066eeasm26789295e9.7.2026.05.13.00.43.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:43:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/hppa: Inline UNALIGN() macro
Date: Wed, 13 May 2026 09:43:21 +0200
Message-ID: <20260513074323.10616-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Philippe Mathieu-Daudé (2):
  target/hppa: Use DisasContext::mo_align in system emulation
  target/hppa: Inline UNALIGN() macro

 target/hppa/translate.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.53.0


