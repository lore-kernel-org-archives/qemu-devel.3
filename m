Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD55D5C0CF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PuF-0004IY-Bx; Fri, 08 Nov 2024 09:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t9PuD-0004IC-Dg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:24:09 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t9PuB-0001ty-N1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:24:09 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2887326be3dso1154328fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1731075845; x=1731680645;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+tUMkjdrwLZ0bqPC4ZvTSYSeqboyLwMPPT4K7e2QoAs=;
 b=wmvBFUh5sCrqYzs12XiLDXmEnvRUkmGrcz9xnWN60ICqcgoH+590NT0s9oS0qnyYLz
 s1kXtlDya/P+DJG01qEzrM48T1Iy6asT7toQbgWqWSYd4tHfi2l9QV6Pr2vTCs3KgCSt
 SBI7jyIi+OkvxyZVTpldPkCU+n74iK31CU2P3w1/ptLk1EDuhaXsnjwCpKRNXBMaY6BA
 Baozbnh2Z85HDhGOujBvxqJmnWJG8HBfbw/T2VDm7CnXlwjvsjR+EOzkHPVANpzBQ7HS
 qtJ+LblhKtXlXkVMCKWmvyWb0iPYmPhU9QOmSrU0Za69uzXUdv+r21xmG4xZrM2jK/eL
 KvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731075845; x=1731680645;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+tUMkjdrwLZ0bqPC4ZvTSYSeqboyLwMPPT4K7e2QoAs=;
 b=C0ZuZyVJ7312MUszVMpwmtjO3TDyXvNpjLxeMFheaCoj1ZDGrU34uyMt8eO8IDTnxr
 2nu/b+g3QMrtTS+0ns2WERMJQITV2xJkRP7oXKDSAOw13H9LSelJ8qB0ZBtfJNYm1QYD
 ZDE1xIrYMVEYR3G89zBeJ/rLRLkS/VFGciCWaBIGBUepWw5YpSgzieqs+3VPMxbqVm5O
 30BwQZURLZVV0+ymBq3/jxitB9mMYXBe5B2O4dTDy2U2fl8zjxW0GjmY/bpu0UFyiJ9f
 WbfSpykoBvWZeZ9xFbC9GobxFQEZH1hPGhMTBMuXj6eWBL9Ov2iy1WwW0HJ3/9kwThz8
 yNnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaX37wkkDcNmvIVjQ0XPhNYJYUAk+qBv/0gmJKpFmPOekSwhBMQ9JABP3upyaSyIcbcnR0Rv9quIn0@nongnu.org
X-Gm-Message-State: AOJu0YyOTuSR/gcui2Ye6U1gHYXfhsgfOMzmzai2x+8tvtk9kOzaNCVt
 1oMFyyKTwognvKaireyw/5vCT0gQ/AwHMIYvBXmfuMqX66BgREyaigXZe9SCu5I=
X-Google-Smtp-Source: AGHT+IFaN5UiWktJPk9pTAun7xomriaMOM2YzPb0NVbOryD3luxnIA53nKbGunAlOy9eAAb1hmFO0A==
X-Received: by 2002:a05:6870:56a0:b0:287:32f7:ef42 with SMTP id
 586e51a60fabf-2956009917fmr3238060fac.16.1731075845319; 
 Fri, 08 Nov 2024 06:24:05 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:44bd:cb9b:52b3:1883])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29546f48400sm981515fac.48.2024.11.08.06.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 06:24:03 -0800 (PST)
Date: Fri, 8 Nov 2024 08:23:58 -0600
From: Corey Minyard <corey@minyard.net>
To: Titus Rwantare <titusr@google.com>
Cc: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org,
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com
Subject: Re: [PATCH 4/6] hw/i2c: add canonical path to i2c event traces
Message-ID: <Zy4e_glcDMZ1f7FJ@mail.minyard.net>
References: <20241107195453.2684138-1-titusr@google.com>
 <20241107195453.2684138-5-titusr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107195453.2684138-5-titusr@google.com>
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=corey@minyard.net; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 07, 2024 at 07:54:51PM +0000, Titus Rwantare wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Titus Rwantare <titusr@google.com>

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/core.c       | 8 +++++---
>  hw/i2c/trace-events | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 4cf30b2c86..d238311776 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -161,7 +161,8 @@ static int i2c_do_start_transfer(I2CBus *bus, uint8_t address,
>             start condition.  */
>  
>          if (sc->event) {
> -            trace_i2c_event(event == I2C_START_SEND ? "start" : "start_async",
> +            trace_i2c_event(DEVICE(s)->canonical_path,
> +                            event == I2C_START_SEND ? "start" : "start_async",
>                              s->address);
>              rv = sc->event(s, event);
>              if (rv && !bus->broadcast) {
> @@ -244,7 +245,7 @@ void i2c_end_transfer(I2CBus *bus)
>          I2CSlave *s = node->elt;
>          sc = I2C_SLAVE_GET_CLASS(s);
>          if (sc->event) {
> -            trace_i2c_event("finish", s->address);
> +            trace_i2c_event(DEVICE(s)->canonical_path, "finish", s->address);
>              sc->event(s, I2C_FINISH);
>          }
>          QLIST_REMOVE(node, next);
> @@ -321,7 +322,8 @@ void i2c_nack(I2CBus *bus)
>      QLIST_FOREACH(node, &bus->current_devs, next) {
>          sc = I2C_SLAVE_GET_CLASS(node->elt);
>          if (sc->event) {
> -            trace_i2c_event("nack", node->elt->address);
> +            trace_i2c_event(DEVICE(node->elt)->canonical_path,
> +                            "nack", node->elt->address);
>              sc->event(node->elt, I2C_NACK);
>          }
>      }
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index f708a7ace1..e5f2dc643e 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -9,7 +9,7 @@ bitbang_i2c_data(unsigned clk, unsigned dat, unsigned old_out, unsigned new_out)
>  
>  # core.c
>  
> -i2c_event(const char *event, uint8_t address) "%s(addr:0x%02x)"
> +i2c_event(const char *id, const char *event, uint8_t address) "%s: %s(addr:0x%02x)"
>  i2c_send(uint8_t address, uint8_t data) "send(addr:0x%02x) data:0x%02x"
>  i2c_send_async(uint8_t address, uint8_t data) "send_async(addr:0x%02x) data:0x%02x"
>  i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
> -- 
> 2.47.0.277.g8800431eea-goog
> 

