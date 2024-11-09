Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2357D5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gn6-0007vk-J5; Sat, 09 Nov 2024 03:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gn4-0007uD-Lk
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:25:54 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gn3-0003z5-75
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:25:54 -0500
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso6964338a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140751; x=1731745551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLlu2fRFj6Xoz6V+VkJ6zam5L2rugl9ncgg/e+hQSL0=;
 b=khK8Wmtrn70tbIK9PHP4avMUoCvX2x6euadLkSJu+w//GGH5lEZ8ifMidPpvwrt2Np
 BkvmlhdUH8tR6C9OjPneZA18yj/JIMok4u+fftJZyLYWsOMPsqC5lg0ZXygAoSilsX5P
 Q/BwUvQ9L1OAwypOJGIATQRYKQuH2MlEwjoQgC3kGWA3IJ0eCJ4gfKdfh3EB89og7ZzR
 wuALYXcnRMvwpfTgKFh7dg3xqNXxyiRsrpEypWv6FMFrsQbgQE7ldg/GtoUrxdZXmEs2
 eg1cbhe13zEbgl26LwdR1pMgc8u7aVcXF5Vo+GRz330kN1D7DcIMjqq8Uu4JUzskvFTm
 tkrA==
X-Gm-Message-State: AOJu0Ywc9y2ebrhGCzqapEMW7eeQGIBcw0kKc61SzuxntPAZARkNWJ0I
 tpGEy1eAWFWL0NrSYAYyFzRCsssHiSsiihLD7tbdggDZRK+aQ/5VZ9aSexsc
X-Google-Smtp-Source: AGHT+IHmoAcGaqjD25bue16VMESFlsuCWNzI1OEyjyda91C0juSDNu08nV7ILh5IlcJCCsyKY12N5A==
X-Received: by 2002:a17:907:7e83:b0:a9a:170d:67b2 with SMTP id
 a640c23a62f3a-a9eeffe72a4mr516207566b.29.1731140751360; 
 Sat, 09 Nov 2024 00:25:51 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a18ca5sm336840366b.35.2024.11.09.00.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:25:51 -0800 (PST)
Date: Sat, 9 Nov 2024 09:25:48 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 34/36] next-cube: rename old_scr2 and scr2_2 in
 next_scr2_rtc_update()
Message-ID: <20241109092548.427fb94a@tpx1>
In-Reply-To: <20241023085852.1061031-35-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-35-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Wed, 23 Oct 2024 09:58:50 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Rename them to old_scr2_rtc and scr2_rtc to reflect that they contain the previous
> and current values of the SCR2 RTC bits.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 076c9d1f3a..ece63f20b1 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -177,17 +177,17 @@ static void next_scr2_led_update(NeXTPC *s)
>  
>  static void next_scr2_rtc_update(NeXTPC *s)
>  {
> -    uint8_t old_scr2, scr2_2;
> +    uint8_t old_scr2_rtc, scr2_rtc;
>  
> -    old_scr2 = extract32(s->old_scr2, 8, 8);
> -    scr2_2 = extract32(s->scr2, 8, 8);
> +    old_scr2_rtc = extract32(s->old_scr2, 8, 8);
> +    scr2_rtc = extract32(s->scr2, 8, 8);
>  
> -    if (scr2_2 & 0x1) {
> +    if (scr2_rtc & 0x1) {
>          /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
>          /* If we are in going down clock... do something */
> -        if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
> -                ((scr2_2 & SCR2_RTCLK) == 0)) {
> -            if (scr2_2 & SCR2_RTDATA) {
> +        if (((old_scr2_rtc & SCR2_RTCLK) != (scr2_rtc & SCR2_RTCLK)) &&
> +                ((scr2_rtc & SCR2_RTCLK) == 0)) {
> +            if (scr2_rtc & SCR2_RTDATA) {
>                  qemu_irq_raise(s->rtc_data_irq);
>              } else {
>                  qemu_irq_lower(s->rtc_data_irq);

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


