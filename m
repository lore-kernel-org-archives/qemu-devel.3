Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E909AC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIb-00077C-Ao; Tue, 18 Jun 2024 12:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIZ-00072s-9D
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIX-00077Z-LQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6efacd25ecso350258366b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726584; x=1719331384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLAsEZ1WvZS0nMNIQBNTpRKUp/i555alHafKiDl+nF8=;
 b=LAU50MYf3XGGj339E4iXSrWXXpdCejEOlUAitjnh2pv+3RgekTuyKnC9OmvyOm0+xC
 3mlooR6sd+HgbbQh8gKZve7MbXTf/0n6MqxiM6/eluPpuNwHbDVoubO7+A4fO7O3CoQs
 +GvTPu4d1meWefqgJ5oN4aFI530j/eFiQ37d2GPOarvMBJ4ZSrFh58hBmI/baM1llpnb
 2b8XRHg25w/rHCM6hSTfmH+pw1QMal+PFGNw2K5yXAXUse2BySjrIgJYC4VRLe4f/yqk
 boJgCyftTWCyE1Flq/tBBSdx2uqXsfm9uVeAxtqcOdTpOdHqdYfMEKTnW4QnWN8HT8fH
 RY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726584; x=1719331384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLAsEZ1WvZS0nMNIQBNTpRKUp/i555alHafKiDl+nF8=;
 b=h1eEaR0Y/7uZrsH6nL7tYBC4CK614ZHdGA4q9e4tae/bwe/wo0ctHrI86HkNE4Z4la
 DmVu/+z3VMBC9DW77URMe0epKNfA/Nb+npGcfTS/3/wfoNp7tKoNS/e94E5mYJq0K8KN
 sqrOMTB/woM6TqfJiJY8Ze7DAAPJzpNK/YMs+/QF0N1ctkA7WW2ZIyUuozZ8tS/qC0Rr
 dhF1+v3U6nPQT+nLGHJ2IZtiYpaQvKTaoksly+V1iFZplaXvOwAq95q3BoLOhb6WbroF
 IVl5IBTn61kzAWfIfeygCGE/owFI6FrvUePw5n316j2Oxaqa8tOboEsfvMrgryVtR/Be
 DB0g==
X-Gm-Message-State: AOJu0Yxwhl3Gmtz3X+n/0k9bOw4MRxci9nC1cmlAQmwM7DcDtIlSAQMy
 hvkPBv2OZjcVGEZRKiGVEvUaYsa2Osw32oiffA77jqf0g1crd5CnFagNW66Ec0IgQftnzRLpfr3
 8
X-Google-Smtp-Source: AGHT+IG3RiFau78Mo8mE6dYmzum4/NrtfRiyfoQF7qv6p4mxHTS1Ww+VTqiku6RKguLU54fjIdqRJw==
X-Received: by 2002:a50:aa8a:0:b0:57c:6d89:eaef with SMTP id
 4fb4d7f45d1cf-57cbd68dbe7mr8665503a12.18.1718726583755; 
 Tue, 18 Jun 2024 09:03:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f8176eea5sm288091766b.88.2024.06.18.09.03.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 24/76] hw/audio/virtio-snd: Always use little endian audio
 format
Date: Tue, 18 Jun 2024 17:59:46 +0200
Message-ID: <20240618160039.36108-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

The VIRTIO Sound Device conforms with the Virtio spec v1.2,
thus only use little endianness.

Remove the suspicious target_words_bigendian() noticed during
code review.

Cc: qemu-stable@nongnu.org
Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240422211830.25606-1-philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 7d09800d1f..5993f4f040 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -401,7 +401,7 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     as->fmt = virtio_snd_get_qemu_format(params->format);
     as->freq = virtio_snd_get_qemu_freq(params->rate);
-    as->endianness = target_words_bigendian() ? 1 : 0;
+    as->endianness = 0; /* Conforming to VIRTIO 1.0: always little endian. */
 }
 
 /*
-- 
2.41.0


