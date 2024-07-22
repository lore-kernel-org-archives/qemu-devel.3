Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A01C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtul-0005mU-5m; Mon, 22 Jul 2024 10:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sVtui-0005hj-JS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:21:20 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sVtuf-0003bn-Ir
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:21:20 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7a130ae7126so1079978a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721658076; x=1722262876;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpWze73RUXirZK3Pxt4gP365mHpbUPhnTipc7ueTttA=;
 b=XNhK7GMxbXHb/wPORfhxCty6hyp1FcwG+y1A/xyATcH279xPltLg+YtzNX3VC3IVFw
 HlqukWHU6iDCeoJpys9wXoOH1NQZJd+6561ffTP+zulyUxN1w3lw1M+KOZniRCT0k2A9
 /AffQ5ZnDuMPJ89GEp3XVfKJndhO/clvt2k+Ap6MQaSLinFbiFtf1wRYoxn19U0tzBIX
 aqJ4xfrGGJWQOvHaaIMiZxvo44+I1SDkCzhrowFEae15kouq97D+usBAGdeLrPJEc3dG
 kM174G+dfKqrIpQI2VPWTzFJ7cWLMbdn0aQf80YqTIe3+BTaKEEWoR2z+YFhT3GZKGzO
 A0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658076; x=1722262876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpWze73RUXirZK3Pxt4gP365mHpbUPhnTipc7ueTttA=;
 b=REPnvaiUKXUIiod11SPWaIKRpFCjmZZgJQRSlHiQTj1aOd9Vh8UUKROkc/Lny2MQS7
 Z/b5CAlSmsCE083JecL2GOIFMt3ar2NZqtlLr7KuS/ZuMCcgZ/Kpk/WXUKLsm8a8dKL+
 4uCj3X1eNBi+dzG077qUxD3dLkrsAEFoigSy6mvKCubY5idWw9p/zF4LWyPjcjhVjheP
 5NX4hl4nasZ8SCaPZhfrbZHhN25YbPfpMzWIIuW3PxP/g7bonHCEsw8fa+sP8tDV79HL
 4MA+8cStmxR/ktadTBpVDu2Z4ZltKoZKOjYYVUVesmiDKrMnCCINBAPWk8aydxDidwR2
 aeKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS9WbT8C8WSNGjoTcKojDfGea/tzRmcKfoeQhlwpmBwTCpghYlRM81gms+Oi2LlBwODBA3+JLZ55jXs/JVhhzkUmbUIGI=
X-Gm-Message-State: AOJu0YyyQCD6EPrEZsIOB2HrifdPaVw35eqJbpeSWQXaO8iGFt3eJ/2f
 0irpdPD3v13OZJlT5RyFmwA9i38NLytgcDvG4/y+uQT7ZQsOk3i5uGy1uZaJM9s=
X-Google-Smtp-Source: AGHT+IGK8+fHA52D3eFVCmIZMkDWRpJXkztmgS4xWd0O40tu5BmUfUqbmi4fJnjpmiTBAEMonJI7ZA==
X-Received: by 2002:a05:6a21:39a:b0:1be:e1e1:d5de with SMTP id
 adf61e73a8af0-1c4285f0d94mr8529764637.30.1721658075775; 
 Mon, 22 Jul 2024 07:21:15 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f436c6asm56443405ad.206.2024.07.22.07.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:21:15 -0700 (PDT)
Message-ID: <943d2a14-f4cb-4169-a7ac-bbe38a0e9abd@daynix.com>
Date: Mon, 22 Jul 2024 23:21:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 29/63] hw/pci: Do not add ROM BAR for SR-IOV VF
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yui Washizu <yui.washidu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <cover.1721607331.git.mst@redhat.com>
 <54f3a29f08900bef796953971d2482d64ddf9969.1721607331.git.mst@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <54f3a29f08900bef796953971d2482d64ddf9969.1721607331.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024/07/22 9:17, Michael S. Tsirkin wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> A SR-IOV VF cannot have a ROM BAR.
> 
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20240715-sriov-v5-1-3f5539093ffc@daynix.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/pci/pci.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4c7be52951..bd956637bc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>           return;
>       }
>   
> +    if (pci_is_vf(pdev)) {
> +        if (pdev->rom_bar == ON_OFF_AUTO_ON) {

This requires:
https://lore.kernel.org/r/20240714-rombar-v2-0-af1504ef55de@daynix.com
("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")

However it does not seem included in this pull request.

Regards,
Akihiko Odaki

