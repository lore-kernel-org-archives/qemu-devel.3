Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAE7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOyik-0001IP-9U; Wed, 03 Jul 2024 08:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOyig-0001EC-SK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:04:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOyic-0003J4-C3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:04:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso41127495e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720008252; x=1720613052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IwSf5w3ADdSD4VscFWnyBIyjkosnmLgPTrA/nYHBqk8=;
 b=zg4HbLW/bYXV4Ci1VQ+DRMjaaQlJIxOME6tCN4nBRkpGLftPgMVDLZaMgsTO9Slt2+
 RkzwCrGZab3+Me8R9p08yzYd6cTuMGJc9CL2PMM+L6J1bQMq3WQuUrAuftOVtoGM/6U/
 ZH5spNLahzJ8by54hZ33V0AYHyLNL7UpyewLibgcCsNM2PDgJq03GaVHcUz9c1TldT6u
 MypsBUSbBg8WaoWhmcj6KXXjWd1Dfs5rmqSA3/yOAirxozbVjHcI0kY8RE1HAnkMvyPu
 rXzk4G2STg05HjK9qqtdsYCXQaXOSIHMN+u4i6UyHeVRafVEvL19GfAeBUGGU5zKqrDZ
 s1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720008252; x=1720613052;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwSf5w3ADdSD4VscFWnyBIyjkosnmLgPTrA/nYHBqk8=;
 b=C85x+A9juDQbX4++es6agbWUUiwDiSPGBsNTDFlOZ/vfm7h6nwA1mY913RJfRya+YT
 4e/gy2ddsSzoJ0EbHEDXmMURZZKq3NxakD0h1hfXRw4awkD7MJ13W54GqHE6/1M3GTTK
 /ccxxNQdkN3VbJeME22gSNGli+ytkuns5ZjY0D4848TnHkT5ZwAfYl2+yGBi/GiEgQL0
 /cUv6uAL2VqytHzrYjq1XvnpxZf7HMakC2pDQ/LE48SipF2DgErqaYGKhAgMrwry4rYy
 IKJlqmanQL67A5rvbyZU9qCzEQnbXYa0RQwZ13NbgGWpVChlR2TZtVxy6+13wZLrMPds
 L2Qw==
X-Gm-Message-State: AOJu0YxbdTn4y4YttnVYQ84wCD3/2hOAPOl3jWnwmLetqKkrLFAbnfEn
 xq+U2tMzs3TdrorbkLnc3Tpl9JUJrZWsW+hr0yUwT60/z8cWN/+DAfP6dSFxZgksLYdUv/Olmo9
 nVJo=
X-Google-Smtp-Source: AGHT+IGXOGNjFy2rH3cq4Q2tsNTrViO24E98G/hb8mM+HOSA5J3+f1aDIzGC6qJ/Mr8TdRvcnTtbvA==
X-Received: by 2002:a05:600c:3542:b0:425:65fd:449 with SMTP id
 5b1f17b1804b1-4257a05c08dmr69751975e9.28.1720008251986; 
 Wed, 03 Jul 2024 05:04:11 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e13d4sm16004968f8f.56.2024.07.03.05.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 05:04:11 -0700 (PDT)
Date: Wed, 03 Jul 2024 15:03:57 +0300
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
Subject: Re: [PATCH v45 1/3] hw/sd/sdcard: Remove leftover comment about
 removed 'spi' Property
User-Agent: meli 0.8.6
References: <20240703085907.66775-1-philmd@linaro.org>
 <20240703085907.66775-2-philmd@linaro.org>
In-Reply-To: <20240703085907.66775-2-philmd@linaro.org>
Message-ID: <g1quy.grldmsci80ps@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

On Wed, 03 Jul 2024 11:59, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Commit c3287c0f70 ("hw/sd: Introduce a "sd-card" SPI variant
>model") removed the 'spi' property. Remove the comment left
>over.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/sd/sd.c | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>index b158402704..53767beaf8 100644
>--- a/hw/sd/sd.c
>+++ b/hw/sd/sd.c
>@@ -2473,10 +2473,6 @@ static Property sd_properties[] = {
>     DEFINE_PROP_UINT8("spec_version", SDState,
>                       spec_version, SD_PHY_SPECv2_00_VERS),
>     DEFINE_PROP_DRIVE("drive", SDState, blk),
>-    /* We do not model the chip select pin, so allow the board to select
>-     * whether card should be in SSI or MMC/SD mode.  It is also up to the
>-     * board to ensure that ssi transfers only occur when the chip select
>-     * is asserted.  */
>     DEFINE_PROP_END_OF_LIST()
> };
> 
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

