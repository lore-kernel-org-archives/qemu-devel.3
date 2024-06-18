Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3FCC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQRJ-0000pO-Pl; Tue, 18 Jun 2024 00:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJQRG-0000iy-Gt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:27:23 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJQRE-0006cP-Vq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:27:22 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f7b785a01so252373766b.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718684838; x=1719289638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTGODV3+yRls22goSd91+IiHWYwjEOFEtZ/PJYrDvZA=;
 b=XMJNZdh6JY36cJXaTH3qymEkySkW3Hz6im5zCIug6CohzQNgvtmo0VKaSnjGncrLlN
 7wGbuum0lOdiik+7qJrMO+OlJ5a4DdZ4ucHtF7IYuxF2zk1mcD2IumeMKd/QJN07nJsC
 Kp/Wqpq5Z7mHTpkK/XRyEOke+0La/OsZCDC7GuKtm7kqt767tXbqL0CG3X+iHoiz++Yh
 FAGNCVRAxz4usvNTDVOnOTHAbbiJvANZf4TY6Ob3uzrKgM9ozM97mHoaGz7HETHLv8h0
 cUDdbI9o2h6RJ2qnkb6bSBJTU77U46qI65ylFi1e3jIQ9XHaG+94B49MLAqrwMcf+xqR
 /JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718684838; x=1719289638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTGODV3+yRls22goSd91+IiHWYwjEOFEtZ/PJYrDvZA=;
 b=l9Y+imIGaQeAad4lHyzxXuzkaxCbJt3yO6851fcVSPEpJ27lwdbq7P6fYwLpDOguh/
 dfAEB4WqnsbSGVdczW5zdX8xjyB56mIVSw6cMZ2B7L1GexPgHssNx96y6q3LwirEL1Wp
 yzRH8XX3erVufKheHQM8S9T4V/Ep3ptfbWRVB4GH01Wrwe0HphcaByL/MjkTCGjA7L2R
 3h6YeplM3AV4AZrXOm/EjK5hcRd4ucg3uhADRe+8njvXLqZz53/pRA1B5yb4pNiyBFht
 qFzIpb4oHnnQwW43bsqyUZQAE1deinQFb6h/lnXDHl+hJprVFqREWVDM7j4Ls8SJCk6x
 QEhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv1e5vCRoQrzJ25RaS+FbhsdjEazYbAM+fhfYourn6fShUFcYqYMtGmAjALCI8d6W+vHdYUBhXCi6RZXUfMDXYx3Asgv4=
X-Gm-Message-State: AOJu0YxpOi6chjD22OMARwfC1v91mO5XrzvAP9vebfkWB31Z9WRHIfqj
 +Xh96NuOBgJ05kbLVKqfiXKP/fROFgcXgK3xfsMhnxDxxybdvMf6xnG2WFTHKQc=
X-Google-Smtp-Source: AGHT+IGcBIzoOy83C1jboUM39mEz9xWtVjpCqOsyq/GbtOD7RmdjBmAe+YTKwJOjlgDI5VyCgzwoNw==
X-Received: by 2002:a17:906:99d2:b0:a6f:9843:a955 with SMTP id
 a640c23a62f3a-a6f9843ab01mr52271866b.1.1718684837881; 
 Mon, 17 Jun 2024 21:27:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db67e5sm579408266b.66.2024.06.17.21.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:27:17 -0700 (PDT)
Message-ID: <8afcbe55-f9d9-47d7-8173-53e688d05120@linaro.org>
Date: Tue, 18 Jun 2024 06:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-mtp: Correctly report free space
To: Fabio D'Urso <fdurso@google.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20240618003657.3344685-1-fdurso@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618003657.3344685-1-fdurso@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18/6/24 02:36, Fabio D'Urso wrote:
> In order to compute the amount of free space (in bytes), the number
> of available blocks (f_bavail) should be multiplied by the block
> size (f_frsize) instead of the total number of blocks (f_blocks).
> 
> Signed-off-by: Fabio D'Urso <fdurso@google.com>
> ---
>   hw/usb/dev-mtp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 7e4a0765ae..554b397e88 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -886,7 +886,7 @@ static MTPData *usb_mtp_get_storage_info(MTPState *s, MTPControl *c)
>       rc = statvfs(s->root, &buf);
>       if (rc == 0) {
>           usb_mtp_add_u64(d, (uint64_t)buf.f_frsize * buf.f_blocks);
> -        usb_mtp_add_u64(d, (uint64_t)buf.f_bavail * buf.f_blocks);
> +        usb_mtp_add_u64(d, (uint64_t)buf.f_frsize * buf.f_bavail);

Indeed (USB MTP Spec v1.1, 5.2.2.5 "Free Space In Bytes").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           usb_mtp_add_u32(d, buf.f_ffree);
>       } else {
>           usb_mtp_add_u64(d, 0xffffffff);


