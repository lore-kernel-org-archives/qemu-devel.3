Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA28CDE00D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmWp-0007LF-RE; Thu, 25 Jun 2026 12:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmWl-0007FQ-Ja
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:02:09 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmWi-0006WM-7d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:02:05 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c8b49639fbaso38656a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782403321; x=1783008121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tc/f91PWZlqsfBeEM3Km9wlL0qu0XJxsf8go0p8m1h4=;
 b=jh+Pm8vG3+PzbmISTYO+6336ESxgKBg7T7KGEaRdHsDXBufJ9ymtmcQ5dnURE/aXM5
 /+kFHx54aAGaP3UbWmKBmqHN5t0UhDnH0GdcmorZ30RNg6TelygR6sFXXOtvTZi92NFh
 Mqs5Troa4oS8OmyTiXXQ12S6vaxNqcEV6KxnQCye//Rem3qSDLq0OuLvAM/FmRmSBuQn
 CuQfxiz+9MFP8CY6iHicB0cXeJZnTxjE2ZE4haT6INNpCuEJTKnkrHR9cbQ3pNrByZln
 o+L+b4qHwf8WuyCe1r9pqXN85CBf+yyeTBLmCctGI3h2mYtBUuzS8HZ64z6H/3X1eImI
 u9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403321; x=1783008121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tc/f91PWZlqsfBeEM3Km9wlL0qu0XJxsf8go0p8m1h4=;
 b=Q9taACPvcFghaIHfb61ERye7jaKIJypjfOcQJQCSY7/pvcI6zxBxbCjA6iG/A/8hlj
 DyWARUqCO8hTzH5ID+yjQN9c2MJbFiACWlK8Iuv0j100cpsHnEaL/9SMrt6nYxV9mYjp
 hGkvSrnb0Vi7T3khuE3pbKc6mtQ0m7mSwECcgXKJ5VrTm0ounrdwuSZUTyPzyUG1HPoA
 SOWIJB5s+sIyEPUv9sFvrbkyAoGAP3t2+6OFyYr/+9vR3cGCfu9q2zyuH6aeA96XDI/R
 6+VGiUgnMQa4cvjcU1BbKswjRZc0mMYIhQr1SZcZi6IHw4AmVv5jHwfZ86o5x/MFSmz6
 XJfg==
X-Gm-Message-State: AOJu0Ywt57zg6XbinYS210CQ0srNZc7X4U5KJsurGQW3nppIE8yf/bkZ
 g+cj4kuFGxtyKgMQlQg474O0I+XZ/9E47nYHH9YimOTs6v6JGV+XqVinYrUH7+TFxYI=
X-Gm-Gg: AfdE7ck8pi0EBC0fh7/6CXI6q33G7Ew876G3KEj7FuQ0Shrn+VgLILNzr8gJdmZ0jKc
 mtwI7FQD6YMF2sh8ZF1YmqJx+1aO85yDBd4JT8r14fAPoz9mjfaU6nTobvS5rM5csptV1Czcoug
 sal5af6cMLfDOUSd+JPRBrbgvsHd9u13waTsqueiCPZvkixKOELCwcfsuymA0xlncPdWoV9PWU6
 Z6CHahoZKR3ekMFTfMFVa3vEnHnzl1mtDlulu7a+0ANEn+JnwB9CBw3QyX/A8C/AwhIv3r1C3WO
 T/VxQdL89LK01Y87lYRWCkPYVyuuKIIHNoZvM1w6EhFZCG26w4MTMtbYx2doy1qcIiMFrkY+w5U
 aESofAL6QRNN6LHGYRuwGAIeQcmwwAn1jsk+jG0xkyKifazrukwrHSFD7Lse/3cnRzXjqf2FgrT
 Xh9EVe9+jKpC99EjPZkWHPA3u3jKE=
X-Received: by 2002:a05:6a20:b786:b0:3b4:81b4:9b74 with SMTP id
 adf61e73a8af0-3bd4af8c67bmr3954626637.42.1782403320698; 
 Thu, 25 Jun 2026 09:02:00 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c92bcb9c14asm1924522a12.24.2026.06.25.09.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 09:02:00 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: jack wang <163wangjack@gmail.com>
Subject: [PATCH v2 0/3] hw/misc: Replace DPRINTF with trace events for imx_ccm
Date: Fri, 26 Jun 2026 00:01:41 +0800
Message-ID: <20260625160144.94565-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=163wangjack@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series replaces DPRINTF macros with trace events for imx_ccm, imx25_ccm and imx31_ccm.

v2 changes(based on feedback from v1 reviewer):
- Added missing Signed-off-by tags.
- Fixed code style space issue in imx_ccm.
- Dropped unnecessary uint32_t cast in imx25_ccm.


jack wang (3):
  hw/misc/imx_ccm: Replace DPRINTF with trace events
  hw/misc/imx25_ccm: Replace DPRINTF with trace events
  hw/misc/imx31_ccm: Replace DPRINTF with trace events

 hw/misc/imx25_ccm.c  | 36 +++++++++++-------------------------
 hw/misc/imx31_ccm.c  | 33 ++++++++++-----------------------
 hw/misc/imx_ccm.c    | 18 +++---------------
 hw/misc/trace-events | 23 +++++++++++++++++++++++
 4 files changed, 47 insertions(+), 63 deletions(-)

-- 
2.53.0


