Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA37EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKRc-0006fK-Ka; Tue, 20 Feb 2024 02:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKRb-0006fB-Ty
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:21:35 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKRa-0001S1-9W
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:21:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so1807313f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708413691; x=1709018491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tu6RZcNt5ObmPXePVEytT9pQJIWKovTC0PE5W/fiYq0=;
 b=Af42XXe4a9dh9lIHjwK2bONBwQ5tNxfGwSK7/CyTtLoIBDHPtzOZl/4WbPs1TtmERQ
 THZVjBn4H+CqiW5AEPtnklp/RtET/GqugEjcQrqBemeCauMRLFM3Pdf51hS2rViBldxh
 oxy7xwPsVzNojY2PNNahx8CUIH/roeH4elwhV3IXdrxwVaP745ZpMV61gFkPOKLE0bCf
 4sL1+FidSvZYwXQaoWBjkAUIcMCP/Z5l8pLDVcOOKQ560+jHOloh5C+Ii78RcYzgBmMo
 Q6jTA2ayEpc5GoslVMHUodiHFqlJAlFkT09ukzxBqlwaZsL4aUPFjoanyguubH3xwt7S
 V1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708413691; x=1709018491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tu6RZcNt5ObmPXePVEytT9pQJIWKovTC0PE5W/fiYq0=;
 b=BxzJ5xnBWEHrpBXUyOJabeuzIeUx8xQOjXpwxyHKqO9Xw53E1lbkhBbC3BXPtgoov9
 FW67PYpkXp8rpAIfPioIZupFezSEzt6R2erb/B47N8HBf6sY7v+mBCm148wFP88OAuB7
 qlgdSoinEgWleb3RpJS4kwvU643oye5P/CGuBcfNmAWGutqwosJO+HyvWGV0vG7PXVQH
 rIVQ+2mO9jq23ZACW2pvS5BU47AR47h68tmbX3868J8mr6Y2aPF1ZZ6Tf5tzF3RBqI5Q
 NTD0NMkj2M0SyU6jC77SjbZV5+m/B0pyTe0dulUmaHWOHr0fiNyOkl+WuS7XC2EqCV44
 6+5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzLF2fj4f0uL4Vs1pl528zX24qwlFKe/+2r58G+eneXftZuzS1LVcKaaO15Vrvdh0LOAszozLdE0fq0+UrkK9v9NJqd4o=
X-Gm-Message-State: AOJu0YwZfNYe/jyBbLlM/Z4yXn0xVmBM3GKwR81nI3r9gmQsQbLASYKL
 f0UFO7ahH1ZQ0iww6nrsrH2AXaOtpKV8AT1NgIvCDu1mi3XUGgIV6MwxO6kbR6k=
X-Google-Smtp-Source: AGHT+IF6iPxRrjAgt/Wy3fE3qhvuoYEtM20B76dR3D4bmrOIOYdCp6i2jREOXpyIOEY9qG/LnI5e1Q==
X-Received: by 2002:a5d:5748:0:b0:33d:32f2:dcac with SMTP id
 q8-20020a5d5748000000b0033d32f2dcacmr6149201wrw.33.1708413690035; 
 Mon, 19 Feb 2024 23:21:30 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 z2-20020a5d4c82000000b0033d07edbaa6sm12508752wrs.110.2024.02.19.23.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 23:21:29 -0800 (PST)
Message-ID: <530ac857-19a7-40fa-87c0-049696cb3714@linaro.org>
Date: Tue, 20 Feb 2024 08:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/isa/meson.build: Sort alphabetically
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240218131701.91132-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 18/2/24 14:16, Bernhard Beschow wrote:
> Fixes: fbd758008f0f "hw/isa: extract FDC37M81X to a separate file"
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/isa/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

$ git grep -i alphab docs/devel/build-system.rst
$

Should we document this?

