Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2FDC3ABAC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYno-0002PQ-20; Thu, 01 May 2025 14:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnP-0000QD-0q
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:07 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnN-0008BQ-7H
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:06 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d5e2606a1bso11381145ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124684; x=1746729484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGZ2h0bYEkKLAAI47CZVdSqBou71xk/HAQM6xphmlJ4=;
 b=FwmkcGDd+e4oChMZjyc6hhXdyxOi9qT6Lf7DTt7CFPyu66zn9M7FI6iCCyJgakVvxZ
 uxisEFkmAmBTikjCzzr8K3QxWSb0Y+NA7Ug3H34FyI90h7QBC9e4yDHeGw4WileWn5fs
 4DKJnxE85cgfyi+Fs3828S1DIP4pEw7au/yOavwNvLNTUFSBtsjIn+s1aEBGRPPxLxsD
 GI49wk1+z0xhHgvz5ghW07dDfY3iBLawqTZOkEQ7bhIq0W0sOwH41ny1a9j6r9LbJEiF
 pSAnuKIy2XWElkMSU9uGtO5I0rlj0f7j/SmEcpqTTSQSkouYB2Pmx9JGOE1rHr2ANzFr
 c3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124684; x=1746729484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGZ2h0bYEkKLAAI47CZVdSqBou71xk/HAQM6xphmlJ4=;
 b=CfdVnop9nrR+NPZ3vSl4lpqG5FsJ9lDBRQ2O1DEyEeLcfAw8GFObO5CjqU+X92ynGJ
 IdIaY1e2Wb56O+w9rWjHQuyknBNQ7oW+N6zBSq1Y36aANC+W4WGwQgprbMMbusE7ci/e
 eWaYoGq19nAnhOKWRAj0qBPaUqvwJFgJocd3kdNS8XK2KwUGEsd9ppRxI4PdmHBYuU9C
 vV0VJh6e4Dgpxkz61tupz0GEi1miF4D75qxLJSxpx+lTwNmGx+4LbIv5ymjndjpNlieP
 I79JdAdh5SMRl3be53OFQZjMX161raEtQkeeO/xuHwyAqUM9v61yw5Xp3zI9lxV6tejw
 D1ng==
X-Gm-Message-State: AOJu0YwmzZRIcx7ys7ONph5mHDYZPLAEqx7XM1bVd1bFY/2dZW4sAMHw
 ApB+tGRqe7zbIEsW8HkahxJ+MRg1bg5pY5Ff/FYeUPqJf2OHYCLKYSaOOwmM2P+MXhX8+IjpSG8
 q
X-Gm-Gg: ASbGncsiBG6Hr+h+h2uX+flm77egllwaTq/yodevp6FTh6O3wUshbJhOlg8g+YWt5GQ
 UDo1rs3uVydEAc4wqJAgrW575+jMvNtbwvL29j8zGtZkMIeQTRRIcNWewofCPF8PDS8GTHa1fzT
 K9Bi5zVnoFvoY/G8xoGmqrEr0d0pPvBnWpSJsu5NikTfHmx1JST9SHMVFiOhFBTTfm64Kw4QPuf
 WEpPWIOMX96DYt5Gozn3upQd+SjMMjVdT5vX3k9U4WFqPG8GNM4E0699F08pxPxe0Wg5sa2v+iF
 YYXq+Ca5gzfY7dXlIcYYr00YoIGivS2zF+nj5lpr2suivUcFAfpAsj1LhGAXmnumhEnmlGnQMDV
 H4Pjz+4Net3ra5B96PPG6
X-Google-Smtp-Source: AGHT+IHzWQcUIIfinKC7rxFeaw7Hlp6emFIZMh+YmdO1P8v1kjaU/e8pW4GvF74ErXVmB8i2FdAzPg==
X-Received: by 2002:a05:6e02:2511:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d97022692cmr43020525ab.11.1746124683890; 
 Thu, 01 May 2025 11:38:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882f06d40sm306171173.72.2025.05.01.11.38.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 10/16] hw/audio/pcspk: Remove PCSpkState::migrate field
Date: Thu,  1 May 2025 20:36:22 +0200
Message-ID: <20250501183628.87479-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-il1-x130.google.com
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

The PCSpkState::migrate boolean was only set in the
pc_compat_2_7[] array, via the 'migrate=off' property.
We removed all machines using that array, lets remove
that property, simplifying vmstate_spk[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/pcspk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a419161b5b1..0e83ba0bf73 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -56,7 +56,6 @@ struct PCSpkState {
     unsigned int play_pos;
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
-    bool migrate;
 };
 
 static const char *s_spk = "pcspk";
@@ -196,18 +195,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     pcspk_state = s;
 }
 
-static bool migrate_needed(void *opaque)
-{
-    PCSpkState *s = opaque;
-
-    return s->migrate;
-}
-
 static const VMStateDescription vmstate_spk = {
     .name = "pcspk",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = migrate_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(data_on, PCSpkState),
         VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
@@ -218,7 +209,6 @@ static const VMStateDescription vmstate_spk = {
 static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
-    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
 };
 
 static void pcspk_class_initfn(ObjectClass *klass, const void *data)
-- 
2.47.1


