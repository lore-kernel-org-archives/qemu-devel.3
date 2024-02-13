Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D68C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZt8v-0008KB-FE; Tue, 13 Feb 2024 08:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZt8t-0008Jl-8E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:48:11 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZt8r-0006pA-Nh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:48:10 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-339289fead2so2818714f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707832088; x=1708436888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rYsPYkKtZKYw9paQeISojh5ULCuaCONtknUOQ8POPAw=;
 b=FA4wIeJWGFLWLYI+12PGlKZzA2KZmwXLbPnArReXKNtYdi6rrUizSMhWQKtymMwili
 yEHncXdDL7n1ycAwkQHGv6G1id4txsZDmkjOsvshPBBQ9HPLY+7dZg5RPCCbS4JXJsvF
 uyrx682m3aEjlMrm8XJcmpK5dg4qzuNmwYj57MCZatauMH5Mk8WptyxmPggToCrzbkc7
 gBfKVzpZx/G2gDgJvdpg73b1450/R/PWMZjBXM0NzbrwYJhHvVcZjHnf2GzDtF2Y6W5q
 hKb7DvHAlSzBEeo6mEGawSLiFD7IsH/UBxJ9KV2OrX+jK4+6kJ2CtMVFL7Xpxqya354i
 dhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707832088; x=1708436888;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rYsPYkKtZKYw9paQeISojh5ULCuaCONtknUOQ8POPAw=;
 b=MYZ/ulpIgbqkRl4cs5zsB+knNSJ+beBbdQ5zrrKvq9uk4KvTVovLv+GrZPhniojCII
 nSrxh21b7BoHyU6/kyfRfbfBb3Gsgd84N10vdgTS2DGzjJ5ibG4U6TcyGRAW7Xb126pl
 flwTzjCbECmekwCqIUSaeyObbfrDh6fScSNUCWEf4U8he56ZvWWpnYNJ3oTTdMmkc+oA
 jMVmfDIfYOXhXiX9FtFRq7qb7vghchs6yq/v/U/UDMqX0HFge/o6I/Jx/Vvgm4T+rxjf
 JrulN4bAVsARXa0fzhFA8LH4h6CkWH1kwtvrJz25b0U62zrBWndsntD55cxobXsRMlWf
 ERPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQjm+AvgZB//+MV4NHd88vGF6I0G/5EWnwulo6BmGqwVrM2825FsoN7GC6jDZGtaPsd7NOqRyio4ky1v1x/5ieimNby0=
X-Gm-Message-State: AOJu0YxmXX2XZvM/AhJEP9dqVUp3bZbTHmtghVa611nOIeW49tGmb7Am
 Jdruj5ulJHUYassJGLdyai6l63Z70/JT+u1pwYnMewhFhBR0+tWjgb8uhPAnSvQ=
X-Google-Smtp-Source: AGHT+IHJxmEU8B9mVysEGh+QiucP2DNw/wgNNvluISymIkguEQUEmxI1KyTKSrAW9K/CZEv41z/hlw==
X-Received: by 2002:a5d:47cb:0:b0:33b:636c:5073 with SMTP id
 o11-20020a5d47cb000000b0033b636c5073mr9433739wrc.23.1707832088019; 
 Tue, 13 Feb 2024 05:48:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXxyEFUuR8SXhKAXIWoVRZp0YxcTOhJhZ24C79mKVW7iBabv3cc73DfwAyKrLtX4Xz14oL6d/DYi0gBPfJ/EdR+zZ8OAU76GD23SkAYHrOSF+ZuUPNAmsmxUVjD5oH1qCJaTEMglD0sTgMmPWCzfCUZmiy95SegdG5JUvrOYQ3FPz1ygkgw6GR7JaTn9VU15VywEZtMIX7gXOpK/J9AqiLJ5NAj1rQ=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adfa410000000b0033ce1ff5915sm635544wra.89.2024.02.13.05.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 05:48:07 -0800 (PST)
Message-ID: <804cd023-fe52-48fb-b606-78ba509fb03b@linaro.org>
Date: Tue, 13 Feb 2024 14:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 87/88] esp.c: switch TypeInfo registration to use
 DEFINE_TYPES() macro
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, hpoussin@reactos.org, laurent@vivier.eu, thuth@redhat.com,
 qemu-devel@nongnu.org
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-88-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240112125420.514425-88-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/1/24 13:54, Mark Cave-Ayland wrote:
> The use of the DEFINE_TYPES() macro will soon be recommended over the use of
> calling type_init() directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


