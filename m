Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3628C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOz5g-0002mw-JY; Wed, 03 Jul 2024 08:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOz5f-0002m9-2i
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:28:03 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOz5Q-0006HK-Uf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:28:02 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so63020151fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720009665; x=1720614465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ou97b5eQ3z5f0zCAlKQch1OR3bH8r64PaQ2pqkjZeJI=;
 b=I73XDNnpkeMGmeMuFwRjXuwiXFgj+3+YqMOOqYTLdX1T8gtVBEQF/XMNYQbK4oQOuF
 NSqKzeXJO3ggsvJggbepOJNWeDZiI26+Ja49hYGbEGvBdHBr7KbbV8OxCrwcmtbvA4AF
 Yn1g7QuYyhGYDJBJAqvtaudIRbfXG4l7yju0xPQ0CsJr1hqTPenaltaSpnaXL57/334p
 Qocju05Y5VU7jHBzcqgghGiuX4oL+d9+e5H5iDxEGoVYDbGwPhZe5z0xLCbCAICyYDKA
 x0gxbKDI7Z4tpU2dKeE9hMf1LvlFInx7TtEfIH9iAaCTaOj4xemKXHT1CqehThDvLaP8
 q1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720009665; x=1720614465;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ou97b5eQ3z5f0zCAlKQch1OR3bH8r64PaQ2pqkjZeJI=;
 b=hU5SF+Ja2YKtRgttJ0n87nMOfxPaGGEm3OrNFagK/OiQEG6HcabDJzLHp7emSqFudU
 iddlWibZ8Bcnq4R3tRSIO6qWUsfPWpz+gUpMvBemgU6RlqM7/SDYHSJpr/l/x6i9FQvu
 68pfuMvPhqOqEuQAagTB5LvKTuJXXZO/Hz3bsarG1GRHIEmzxldCKQWP+8uLZhr1bBQy
 Em+iHpQfasnqNefyTPTBh7xPGPrmf81v2O3oCc9ns3mQDOlG4PFvfEJW8O5jH5bw9ufg
 fq43gNP2Dm192Loej6abQnwbMjyLuZDOO+Jlve6p7VIEUqow/yhagbRtwYDE+0CRL/6+
 +ZSQ==
X-Gm-Message-State: AOJu0Yxoe0llj8cVcNLKVcnieky68PvEgx9ZGEmPXgXepNabPXAUdQx8
 P1zDo3ypjl6hU8s1egL0MH9TPqWqg3+LRKUwlLmftAe0IwKeXn9+EDeou6TSBIxeqg1e7wFyGsJ
 p3cs=
X-Google-Smtp-Source: AGHT+IH+p98yy2tAh+ql3RLPZTJrFB2HSZlK8LVNW7PckDevmJxuO5nSMPJ5e4H35VOyK6KNU0O/5w==
X-Received: by 2002:a05:651c:1694:b0:2ee:4a67:3d88 with SMTP id
 38308e7fff4ca-2ee5e6e01c1mr71014331fa.41.1720009664744; 
 Wed, 03 Jul 2024 05:27:44 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc41esm15952375f8f.78.2024.07.03.05.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 05:27:44 -0700 (PDT)
Date: Wed, 03 Jul 2024 15:24:05 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 "Daniel P . Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v45 3/3] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
User-Agent: meli 0.8.6
References: <20240703085907.66775-1-philmd@linaro.org>
 <20240703085907.66775-4-philmd@linaro.org>
In-Reply-To: <20240703085907.66775-4-philmd@linaro.org>
Message-ID: <g1ry6.dru2gk6m73t@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 03 Jul 2024 11:59, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>"General command" (GEN_CMD, CMD56) is described as:
>
>  GEN_CMD is the same as the single block read or write
>  commands (CMD24 or CMD17). The difference is that [...]
>  the data block is not a memory payload data but has a
>  vendor specific format and meaning.
>
>Thus this block must not be stored overwriting data block
>on underlying storage drive. Keep it in a dedicated
>'vendor_data[]' array.
>


I am reading the 4.3 spec, and it says:

  The bus transaction of the GEN_CMD is the same as the single block 
  read or write commands (CMD24 or CMD17). The difference is that the 
  argument denotes the direction of the data transfer (rather than the 
  address) and the data block is not a memory payload data but has a 
  vendor specific format and meaning.

The vendor here (qemu) does not support any functionality with CMD56. I 
think the correct approach would be to read zeros and discard writes, 
without storing anything and without changing data_offset (which is for 
`data` buffer)

What do you think?


>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
>v43: Do not re-use VMSTATE_UNUSED_V (danpb)
>v44: Use subsection (Luc)
>v45: Remove APP_READ_BLOCK/APP_WRITE_BLOCK macros
>---
> hw/sd/sd.c | 29 +++++++++++++++++++----------
> 1 file changed, 19 insertions(+), 10 deletions(-)
>
>diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>index a08a452d81..5d58937dd4 100644
>--- a/hw/sd/sd.c
>+++ b/hw/sd/sd.c
>@@ -153,6 +153,8 @@ struct SDState {
>     uint32_t data_offset;
>     size_t data_size;
>     uint8_t data[512];
>+    uint8_t vendor_data[512];
>+
>     qemu_irq readonly_cb;
>     qemu_irq inserted_cb;
>     QEMUTimer *ocr_power_timer;
>@@ -719,6 +721,7 @@ static void sd_reset(DeviceState *dev)
>     sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
>     sd->wp_group_bits = sect;
>     sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
>+    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
>     memset(sd->function_group, 0, sizeof(sd->function_group));
>     sd->erase_start = INVALID_ADDRESS;
>     sd->erase_end = INVALID_ADDRESS;
>@@ -793,6 +796,16 @@ static const VMStateDescription sd_ocr_vmstate = {
>     },
> };
> 
>+static const VMStateDescription sd_vendordata_vmstate = {
>+    .name = "sd-card/vendor_data-state",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
> static int sd_vmstate_pre_load(void *opaque)
> {
>     SDState *sd = opaque;
>@@ -840,6 +853,7 @@ static const VMStateDescription sd_vmstate = {
>     },
>     .subsections = (const VMStateDescription * const []) {
>         &sd_ocr_vmstate,
>+        &sd_vendordata_vmstate,
>         NULL
>     },
> };
>@@ -902,9 +916,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>     }
> }
> 
>-#define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
>-#define APP_WRITE_BLOCK(a, len)
>-
> static void sd_erase(SDState *sd)
> {
>     uint64_t erase_start = sd->erase_start;
>@@ -2187,9 +2198,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
>         break;
> 
>     case 56:  /* CMD56:  GEN_CMD */
>-        sd->data[sd->data_offset ++] = value;
>-        if (sd->data_offset >= sd->blk_len) {
>-            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
>+        sd->vendor_data[sd->data_offset++] = value;
>+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
>             sd->state = sd_transfer_state;
>         }
>         break;
>@@ -2261,12 +2271,11 @@ uint8_t sd_read_byte(SDState *sd)
>         break;
> 
>     case 56:  /* CMD56:  GEN_CMD */
>-        if (sd->data_offset == 0)
>-            APP_READ_BLOCK(sd->data_start, sd->blk_len);
>-        ret = sd->data[sd->data_offset ++];
>+        ret = sd->vendor_data[sd->data_offset++];
> 
>-        if (sd->data_offset >= sd->blk_len)
>+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
>             sd->state = sd_transfer_state;
>+        }
>         break;
> 
>     default:
>-- 
>2.41.0
>
>

