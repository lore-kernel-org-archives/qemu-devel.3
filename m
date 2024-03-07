Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3759C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKXR-0001j8-9S; Thu, 07 Mar 2024 15:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riKXP-0001im-JJ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:40:23 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riKXN-0001YO-HP
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:40:23 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-413173ecf09so832385e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709844019; x=1710448819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=myBJXvsKFSUWDHpkE6ryVViGfGHyK3bmjpa2zaU/Jzk=;
 b=RBxMmfW69Kkl9QKWMD9gPFY/xBa1W2oVfPnkFloF0KDsXV6ce2fsWJV66dw+j3OWWb
 aga5tJqNpAbP6J01MEC3rZA8fwEZWiiK7lhi/mzT8x8AohJpNoI4wcJoj7KSKkHpEQF8
 Rj3Kc6TsPBpx8KRp/MDxxNF/vJUNnzevr3BRbeAUMnO4EG3TNJ3YSJF9v6kioOWJcYX3
 4/BngG2t0YLlD5aoQ55jpiGhYF8bWDp0XTzI8U8VR7wlNzfyHjo005RGoekgqpgzNF5Z
 fnYLIpf2sDqB/eaQllqdW2EWZ/PHlOo1E/6/Tk1WacCBD84pSDISQLipIMIi8z4qyoXN
 0Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709844019; x=1710448819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=myBJXvsKFSUWDHpkE6ryVViGfGHyK3bmjpa2zaU/Jzk=;
 b=TllDHrkH6DwCm1PZ/bfk1OqZdqb8sbWpnlT8VQBGTfVIcZPxfAHU/VHE38pkzYzT1D
 hvRHvKN9X0TNEshZmDZPwM+CEseFT9WMAfK7Qs3QKREfr7+ojQ/ikNRZ/xU54R90AOZT
 q0+gr1qOvsQUay6XPM5j2rGAR8S93nQcEbyyuPDczzmGNVvL9LdDegagO0s6RMidt71d
 bYx01uTpl0gl9adCPD02+midOYDhCw8BVXi4aZsoKMuVI/v3gWngFWgtahuhsSZYyPEN
 RJIGD4mm2y0Qs1gTHa1KR1xqXpYquePMLXr8HntHEe1ocLzVeztTRMPasoakGNYjH/5z
 Auvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJk7n1pFYNE4yjAB9XiYwXKOSsZhw6l7DotIzFQKAXL3/5hR5P4UzUzD/XsZMAsU47c/F0wkYn4vJBUxtMgcqs0DilJ1I=
X-Gm-Message-State: AOJu0YykLxoxL6hylzjlzc/HpR9npLH5vtgfn+aa5vxeIJ7u1t/9XBxD
 mfMoJtFep14VV7zzmeMSupExz8lx1RsmOsf2AQgZ3pMhYM6ic12+gm9VM67AuDs=
X-Google-Smtp-Source: AGHT+IGk4YQL58F/h050Qh+xYid6FnaUa6IkegaDowRXpYesKPY9tTelkZlm5Xw/8l5+uRbS9+t4yA==
X-Received: by 2002:adf:fc8e:0:b0:33e:fd3:8f4e with SMTP id
 g14-20020adffc8e000000b0033e0fd38f4emr16292962wrr.14.1709844019557; 
 Thu, 07 Mar 2024 12:40:19 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 bv16-20020a0560001f1000b0033e0523b829sm21685902wrb.13.2024.03.07.12.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:40:19 -0800 (PST)
Message-ID: <0b5fc0d3-7ca4-4ae1-a50d-348b8c591943@linaro.org>
Date: Thu, 7 Mar 2024 21:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] include/exec: remove warning_printed from MemoryRegion
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307181105.4081793-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/3/24 19:11, Alex Bennée wrote:
> Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
> field is unused.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/exec/memory.h | 1 -
>   1 file changed, 1 deletion(-)

10+ years ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


