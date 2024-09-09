Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2A3ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniRt-0002EO-LU; Mon, 09 Sep 2024 13:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniRs-000280-25
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:45:12 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniRq-0007mP-D3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:45:11 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so451797766b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725903909; x=1726508709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AvJFSaTZgEUEMLMFKbXBwC0knEh7XuShP5nbpvHxE7s=;
 b=yZIyKn3XaEh8maI3vYprjFN7dyY6CE74zk/xSpMZormj81B91TBzJ1gzrCD7Z+AwIm
 Q/HKLTCA7Rtd5CHEgMca4xHNDLg44zPFNLp9RrxpRFHcp3fl33xqVAdIj08SAs1QSGAR
 Ke5WqtAafmlOXsjYuk2Y4ZX1ZMG0eT+GsKjcKpLi5AAQ4Q1H0PEpEN1eWSoLRZo4cWK0
 taufCmIiWeoFkVUA854LL6wnSTkFRk7/BdyVMdqPHrzNddHsAYv+NFLrjZRLbTCeF50a
 OIDSbcXR2AQZYZNtTaP3McAcazxYflGSpi+FgMEAsDJ6RHhRfW+SLy/oALLEOuDK1k9g
 Jing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725903909; x=1726508709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AvJFSaTZgEUEMLMFKbXBwC0knEh7XuShP5nbpvHxE7s=;
 b=IF9NXxBn6NXSyKYMBl8BmMbPnHeOS0m1MdGQAN4etWkv8sLr5IC7QJSVi+jFviQRNR
 wcSUYoQ7R9mSQPanBWselStNgCCQk07ceTSY/PmaCMKLedDPl7+JP1t2B7ogO6BNDJ2q
 qfPLiLC0hHjQxf89tiN+kkjkmtIbY97isLmkxwSsXolJze5dLg/JmlnAHUnk1ELbyUzU
 ewm63xe4oR1+sAeDg0XQfzu4ANKzrzMJE6EPpyxnzHnecXlU4VPcZfhSM+xVVcr0wwn3
 VGSSgGzW9qGi77KmQKM50PMlIDMSjcNl3qz4pPW+jZgorH2ATS+sdJSImQDmGkF12VrC
 FPBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzwvh25CO+mNvIgFQGPQZMbtKqTinByiql0Ce6CuAQp29j09tt6Am0x/2PyfbsqBBuPpnKr4UeCXsu@nongnu.org
X-Gm-Message-State: AOJu0YwgbQ01CE0+f1ILbVLLGeNLC9LJTk3PW1MZaPOxYcfwTvI/DSTM
 BXji6FEwvpjFrZSi5dI4Euf2mHmUw+2FPzwB5mdnVaqAj1gti+eFlOhFW3ecUA5ECwNNbGVqhbq
 M
X-Google-Smtp-Source: AGHT+IEQwM0AxjVOGIg1qnpBhVgqlkb1VDUlR0W6mxxwxa+L1UrGb3jdt8GzsVVIj8fdrrkXEH2XUQ==
X-Received: by 2002:a17:907:c89e:b0:a86:8a18:1da0 with SMTP id
 a640c23a62f3a-a8d24513591mr553520866b.5.1725903908918; 
 Mon, 09 Sep 2024 10:45:08 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm373814166b.173.2024.09.09.10.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:45:08 -0700 (PDT)
Message-ID: <02571b1f-a61f-4d57-ab8c-c2b2f9ba85f2@linaro.org>
Date: Mon, 9 Sep 2024 19:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 15/53] hw/arm: Remove pxa2xx.c
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-16-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> All the callers of pxa270_init() and pxa255_init() have now been removed,
> so we can remove pxa2xx.c. This also removes the only uses of a lot of
> pxa2xx specific devices, which will be removed in subsequent commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/pxa.h |   78 --
>   hw/arm/pxa2xx.c      | 2393 ------------------------------------------
>   hw/arm/meson.build   |    2 +-
>   3 files changed, 1 insertion(+), 2472 deletions(-)
>   delete mode 100644 hw/arm/pxa2xx.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


