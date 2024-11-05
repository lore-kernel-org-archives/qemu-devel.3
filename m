Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A31D40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SgN-0000b4-2V; Tue, 05 Nov 2024 18:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SgL-0000Xi-Eg; Tue, 05 Nov 2024 18:09:53 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SgJ-0000YS-Tk; Tue, 05 Nov 2024 18:09:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so51385215e9.3; 
 Tue, 05 Nov 2024 15:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730848190; x=1731452990; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rS6l/h5zgIbhbMj1a2F8waQ/i8QRTdR9HZsmWuK9NRA=;
 b=XNlhMdQKagnghi3+8overXLYPVZoqNYU9E4E77ISXzy2OkPSoVnuoPoT2CkH910K5Y
 XSF4SBUZBJenkNvg4QczVjjgWdi55WFnGEx9/uoHKwetDryVNZKyUobw8Qh7CFMSWkJ8
 pjiG6M4QFRZtrxZihdpZLXaF+q/V30gYIy+j13ASkVVdU/KXTTByOlk9pVY4p13XwyGS
 wpcpFF+ZPm3ukkHmfHVVN3eM+Dx24p9CYmWhVLZpW0TBQrXW0SQgCqrJcDHzc+iUkmIS
 rCvSdYuy/mh3Plk0l8oMC8glg4F4UHQ2NO+sYdqZLboesSDS/Edp1xRdniV/rBVd7Siv
 ptiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730848190; x=1731452990;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rS6l/h5zgIbhbMj1a2F8waQ/i8QRTdR9HZsmWuK9NRA=;
 b=Rk9Lr/ClDSPLWLjatK1qH0l/eZrBbs3s11z0dYjxrgotYtVqouDPHPNQq2hQp/4/aF
 bOTxLdwYEGj5g5Zju+sWdmLFpPyV/Nvijab44VO3PEF4SL+VfJcj3rGW0EBLFGqYnW87
 2Xl8TGGUUdOcxLjWUTZFhzk3csSfxxgrSK/cXOB56X9T+k6TOMFEOOPSr23+S/Rc+v8l
 ngf5zUx3kO0RnNQ+tWGytfcEVUNPsIr9t/sDCOlF4J3sRN7kMv4s58dk2OC4MCKQJOxE
 ffJE/tlYJdJbFttkmmrhs+ysKvrD0L7oUezyWnZieoo5ERyshV7M4BxFs6XSENH5bzaB
 nUpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGlypo8QZXGbNrzi7R+ijRWqOnzKjJfMWSeXrV+MiC+wBPOeA0mmPj2jSIV88xwepqK+p3grMIpQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxjy7vQMhC2jzcl7kN+KHn/ZlPo3zPjfDyXk2fltu5XaK7G4IkS
 aeSURpeeUlSz2ZFByQJddERyu5K7+gRagKUDFLYH6Tqcl6mPSfMV
X-Google-Smtp-Source: AGHT+IFURNMdPHApY3zmcUg8w1BghW+P/8/Dq9QztBmm8ZZGJCqu0JyZLfUCHyuO/PAkU0XLLxOd5A==
X-Received: by 2002:a05:600c:1c91:b0:431:5f55:28ad with SMTP id
 5b1f17b1804b1-4319ad07fd6mr335942405e9.22.1730848189964; 
 Tue, 05 Nov 2024 15:09:49 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c6569sm1478585e9.21.2024.11.05.15.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:09:49 -0800 (PST)
Date: Wed, 6 Nov 2024 00:09:49 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 11/19] hw/timer/xilinx_timer: Allow down to 8-bit memory
 access
Message-ID: <Zyqlvdl6YCrWx170@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-12-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 05, 2024 at 02:04:23PM +0100, Philippe Mathieu-Daudé wrote:
> Allow down to 8-bit access, per the datasheet (reference added
> in previous commit):
> 
>  "Timer Counter registers are accessed as one of the following types:
>   • Byte (8 bits)
>   • Half word (2 bytes)
>   • Word (4 bytes)"

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/timer/xilinx_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 3e272c8bb39..e9498fc7eec 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -201,7 +201,7 @@ static const MemoryRegionOps timer_ops = {
>          .max_access_size = 4,
>      },
>      .valid = {
> -        .min_access_size = 4,
> +        .min_access_size = 1,
>          .max_access_size = 4,
>      },
>  };
> -- 
> 2.45.2
> 

