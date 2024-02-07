Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FE5C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXnAj-0005fl-16; Wed, 07 Feb 2024 14:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXnAh-0005fH-DR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:01:23 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXnAg-0007rB-0A
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:01:23 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33b28aadb28so752984f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707332479; x=1707937279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wixonZyV5OoUUndRRPrkDq4cdseFQRGa3Rsi/kRysTM=;
 b=wtmjrePa8XMsx28pheNjkErBefrytlPceP9jj3fq/aeFRCamxiIpoCHT/gpDIoNMp4
 9Ic77SnO7vCUfFN7Nc1tOC1lWKclR+wrEdO1K0+BtfVOPVP7XvE5QU7jcOhZMQDcACx0
 kZU6gIiddiB0wODQ3RVLypCreF0etCyOu0weoitKrdMu/iUehRAj4FCNtenJ4NWPpWsQ
 IHfoS/SjI47pig26L3yOqhjBmY43733GgKa14skUUkIsU1yitb7Ri3PgmHhDM9s3H3qm
 Eu5AM3a0RywXeoYalpsncbl4VHb8Tywnye51z5YEmE1Z0YX2+asRMd8e/3u5FfFnhmbL
 G6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707332479; x=1707937279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wixonZyV5OoUUndRRPrkDq4cdseFQRGa3Rsi/kRysTM=;
 b=dm7w4zSsRudJ3rLcaHCQ+JonPOZ/Vgo5NrKMIfTsEKJ0iRTi4oWkgAK72ZkwYWP7wz
 OcU18kpqPhsV8DlllFkFbsKJPe+rnkeg47Desx3YjnnfJqPp49SdviI0bpvzCBDrBo/1
 i90ndNK0CajeCkVhbQxq0wR3777erQD3i9PoIv2bumWR7Do6lcK6CNiQ9G0qlp3OxHPK
 N1DLEXTusm+ISksvukCX7vGzzlDQvgtl8oVKDQatMDZhz1gTqKBEFRC1nw394m9r+AnV
 ocJHoVt8XO483hyBY/0E5S83FRneWRsMJC2/w5wIYHT9WcylQAbmoV6HTwpxEDQr9RvW
 Hiqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGMPnKS7PwISfEDaNUdA8XDwKMRU4WykIlEVmxatD089xOotYQvPkiplwqi5jKMIssHKdsZafsT+XfpOxOGCekSFXaHm0=
X-Gm-Message-State: AOJu0YyOdjWRTDnMC/Ts6x/8AZHC9DpLfPCKKBeD4FXUpEaj/4uMaH6q
 +zvJ1wX1rCR7s0wIUUYfX/ANlBCbZKEECSHWMtCVZnMdOPAtNTONlihBBoGFWms=
X-Google-Smtp-Source: AGHT+IEtt81Kg61jQVSlctjzDz6Xm1f6JoHwaUUK2zgnxZvMgsNgo6jgjTLfqs1Ls6cm34HzO/AlEQ==
X-Received: by 2002:a5d:4850:0:b0:33b:2fba:1ea7 with SMTP id
 n16-20020a5d4850000000b0033b2fba1ea7mr4443457wrs.67.1707332479052; 
 Wed, 07 Feb 2024 11:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVkbcX0XReudSQ++ZaSvnfPGlVrhtw8/5aXLAch/tvpa+ccbHWhCc3l7P7CdHSPEWn89LGz3z94bZuNm3U/NbrFOtquTvQ=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a5d4ed1000000b0033b17880eacsm2077822wrv.56.2024.02.07.11.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 11:01:18 -0800 (PST)
Message-ID: <895ad330-8e43-49bd-bd92-2a7077c04ef9@linaro.org>
Date: Wed, 7 Feb 2024 20:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] isa: fix ISA_SUPERIO dependencies
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207111411.115040-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/2/24 12:14, Paolo Bonzini wrote:
> ISA_SUPERIO does not provide an ISA bus, so it should not select the symbol:
> instead it requires one.  Among its users, VT82C686 is the only one that
> is a PCI-ISA bridge and does not already select ISA_BUS.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/isa/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


