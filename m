Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8FBC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7p-0005cz-FY; Fri, 18 Sep 2026 03:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7m-0005aN-IX
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:10 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7k-00071A-2N
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:10 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so2300105e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716904; x=1790321704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0+l4O0wrIcvpyykuq1KsiocN+EMCJ67yV+f1GHJxf7w=;
 b=F0NH+PCLnj4A3tmF2yeW6nUxfbKX4NpLcSKwCgNwe5C+As99IYx2W/40ZXGedpW/DT
 w2insHfQBpyMNBngnTZvRJAMCJlH+WmRxGLXlf8KDORkEaGYi8Z60dTVzo3p4fHyKk6J
 y7/Vcw7jidgwph2R7t8eLUQqbMksDPOvBNe7iTYAGwjcSpKVao8Mh081cFuAierQHeba
 TW9R8kZop0+dddetqZ2GB+wOj2lZ0xnmhcHJYJRswSqQNG2WhJipn101MY/gBxgvVPl8
 dGs6iBDHi5PNngcmeKdUdOnHeY9SItJXHlcDDIsAB7ot4ymhs7YnTaSuC1Bu3bbWecYL
 1bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716904; x=1790321704;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+l4O0wrIcvpyykuq1KsiocN+EMCJ67yV+f1GHJxf7w=;
 b=TsZVTP7zf7YRfszIi2zqnPDzWA1XcvxFh7/mCyyYUOage9tmP7s3uEd3otapwyv8LX
 jHhsSnoFl4URXST6pLzxPc4nbsc41NIgaJyxnnknR7uIISG2KBWr1wchaW8G7zKYSIWR
 En9JoerZrbRTtLdP/Tf3wA0Y3kCflYuywi5o3sh81hkIJzRUxPL85sBVo9TeDuphNqZ8
 /KXRfRXZf+xpXTFgYMdLeD8I83o/WnX8KNWUPuQksP5oR2gOAdpvXf/3/ExHuFriVZn/
 Jrcm6AVyN7NyWz/4YW9Oy0C/jlyONZaf0kLAJRre12al7vsgcSDLE0kUieu4qiOCfhcH
 UhhA==
X-Gm-Message-State: AFuF++kZKaaTOQyGoBjsJ7wSBDe+rQvjgmomwQcH71cCSt5HA30kTGxR
 f3lwbWE9JgqpgUwJEo1m5lR2YBEQ2ZfEeWbNpk/rv7+d28ejUer+SshaclU+HdErvEOHtqEe6JG
 OFOlHWFU=
X-Gm-Gg: AYBFou2pr1Ech3J6rSrDtzQiJsJO8fEBhP6tpAh3wut3hqsC4gLb/zGUfOMVtZiiDQ7
 hkrYR6MVM/qupyw2Yi4k3lQFFEO+2DlQW+rhn0El8nZJOw/Un638UuqOVZyiu5ga8uDaDVz9Rqx
 WAEDLo6yvAZfef84wSqVXDzxX3PBST5tWRSZGwtW5BvTtImbRYvqA697v7i5sJGLcfxGry09tYQ
 FFoZZ0og1u5rhlraCKmRom23TuFKFK2oPLm7CspxQs96VtueImhjOKNEVt5HsfxfXqyU3TqjWAz
 OlP532mW5CNy0ewjSQaPJoy3YCPQexjmqRXoQKVias2xU2BJlsF+layZl8DMtcZX7hwGtWqmkSj
 8YYxGBm9bUMidLd3qYlOuTDy+kpPvzCp39dGN/69z95PM61OI2FBXOjz/ruS5DU7Y6lW77PZ251
 vHyGzN0ADJzLpfnYqORe/xVkGso/tu/9xC+UteS1hJFb2G6uOeRSkOtXb9Fx2VWx7+J6MTSdbK4
 iGlC4zNzrpjHg9sUGuJyy830gJiVkSI0NUcxreigKAYbhdoPyY5Xjfm/BWgpNXPzxniOwwSiDzf
 dXCX/csO0Gz9RKyN9LJkJ8CGSKaDcWxFbRXHFutLf74/2mSuL6QRX4W3fz43Uc5ySsSBj8tdD4m
 A8w2uwZuulY2ixmJh8VrYzMchNoeij+GfSA==
X-Received: by 2002:a05:600c:1391:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49fc574114fmr16310275e9.19.1789716904243; 
 Fri, 18 Sep 2026 00:35:04 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:03 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] virtio-sound migration
Date: Fri, 18 Sep 2026 10:34:43 +0300
Message-ID: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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

The following changes since commit b36ad6a0510aee81ecf6087b59f412b9bccaa369:

  hw/audio/virtio-sound: add missing vmstate fields (2026-09-18 10:20:20 +0300)

are available in the Git repository at:

  https://gitlab.com/epilys/qemu.git virtio-snd-migrate

for you to fetch changes up to b36ad6a0510aee81ecf6087b59f412b9bccaa369:

  hw/audio/virtio-sound: add missing vmstate fields (2026-09-18 10:20:20 +0300)

----------------------------------------------------------------

Alexander Mikhalitsyn (2):
  hw/audio/virtio-sound: remove channel positions field from
    VirtIOSoundPCMStream
  hw/audio/virtio-sound: drop unused struct
    VirtIOSoundPCMStream.flushing field

Volker Rümelin (8):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields

 include/hw/audio/virtio-snd.h |  26 +-
 hw/audio/virtio-snd.c         | 716 ++++++++++++++++++++--------------
 2 files changed, 424 insertions(+), 318 deletions(-)

-- 
γαῖα πυρί μιχθήτω


