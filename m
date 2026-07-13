Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A38C44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCFw-0004PQ-HW; Mon, 13 Jul 2026 04:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFv-0004Ot-0o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFs-0003BD-Te
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so23711885e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932191; x=1784536991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RQcfPLP+WmCrV3chpWc0PkIedqlYZbmbzhMvhOR7Jag=;
 b=KTXCOH7uGeDCAftQn2eIMEKvcftE+SlKHa6kBxMTc2gbhvxPj7epl5KOdgW00DwD8G
 PZ5XJQyqwS5X4t7+nUbdYpeSXKH4QmQrB8TsYBWggWJGBqx8OnG+Zdj97eXx1l5yMEKX
 rFKyqdQr0d+lW/VvOJnL8S+6T+BW79RP9wLm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932191; x=1784536991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RQcfPLP+WmCrV3chpWc0PkIedqlYZbmbzhMvhOR7Jag=;
 b=P2X6lVuiOlee07uWV3w2qM7GoNtZLLGRdyQz4g9GdUy/6l1XV/ScbONSnjtFmDXU77
 YlfGP61yatfXWxAxZxD+VALznf3WIlMfzxr9283APbLfLz3C/FnkVkYwzs5HHdeVdDbG
 ql2hd9Id2iwQ72F/TlPVlwUIyyKfuIWGOd02xKVpy0M7eOA2Sl2+qTUfxfWdnmAmIdXF
 +J3DI3gue5VOtVrROUm3ZTo71u4HozNgrTqKaV5HQ/A4SONcGYR8kwccTUgmjlULnM0s
 LVyl3etEeMGkUnAOVhueCeXMML8OOz3e3LVWS3QxaoCtzFYBMWyMGX0Nf9vHf4JabVvd
 TcjA==
X-Gm-Message-State: AOJu0YyDvoOw1FAHuQkSzsQ3i+WSktdgKvmyg0ZYSTJnUCE2KGNG3wIj
 uZ9JlZO/nXS6UDSISmZPAIZybVzHwTXzB43IocGuhN2w4gUoTdiq7ZSPIqbBFVZaYSyl1SdnL0W
 /+4u2dzTdKQ==
X-Gm-Gg: AfdE7cnjzvqDWz3+zTDA1HWez0SSILdi4G9FSCHdKlnb58GXQVcuZkgh3QiFq4ygIA8
 paOmu6x3qS8BxEt80d4zBjVFJWpEp2aT3mRNWt8Up+QrgJfVjME8f9fz5yBoBlDbL0GtMPxb65d
 1n6Imm7UPwTFZGlCrB2ZUOA7KVc+LvW6VH7hj1X+ztemsQln6keX1M4SNGivnXNEwRGnLJIwlZm
 3stwed8CMXJxD+fGngGDutGaDqevMnWUttnk4JlR4uTg0/nWsahcinzsmzC4zOMC7BgK+My9Hbt
 XXDiC/NFyRq182D/e/+g4M05VNdw4dTFguCGUMCrDgZFA+EvYndT58IcBgNLZ7IP9NtfA3Icpm9
 sy4vodtYSOgEk8LcxkeEPbQ7IN6BefIH14Ey5mJeDHZzzbbFCYo0oeVRPdo+7x0G99sE5UVgw/h
 zZ7UvP8K1zXZLl08Zhu8MGPjE8G3e04TvNvhl9tbloErVDidXK5HqGErOSV9KCx7/VXHBvFR2tF
 aHIXxaDPkfs
X-Received: by 2002:a05:600c:4ece:b0:493:f8b8:7ebf with SMTP id
 5b1f17b1804b1-493f8b880d5mr77695705e9.32.1783932191166; 
 Mon, 13 Jul 2026 01:43:11 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:10 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 02/10] hw/audio/virtio-sound: drop unused struct
 VirtIOSoundPCMStream.flushing field
Date: Mon, 13 Jul 2026 10:42:59 +0200
Message-ID: <20260713084307.79593-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713084307.79593-1-alexander@mihalicyn.com>
References: <20260713084307.79593-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32c.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v4:
	- this commit was split from
	  "hw/audio/virtio-sound: add stream state variable"
	  (suggested by Manos Pitsidianakis)
---
 include/hw/audio/virtio-snd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index f8bb5c95b97..b60b098ccd8 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -138,7 +138,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     VirtIOSound *s;
-    bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
-- 
2.47.3


