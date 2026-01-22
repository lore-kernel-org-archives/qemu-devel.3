Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F8BD3EE8A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwxt-0005hB-Cd; Thu, 22 Jan 2026 10:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1viwxm-0005YW-5C
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:51:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1viwxj-0006wx-KC
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:51:13 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8231061d234so370303b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 07:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769097070; x=1769701870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKWPP/4IjGgDhV888ZfsyVS+d1eV29rcL0kR8zkb/LE=;
 b=rFnnqHwz+azI82GnCT/CYY8AX1jeooMiWc150l8Iwho7fK6hDn09NjZ4bKZb2Z3wE/
 9zWIa0sUqIlVJd5hfTZbwKui51YDUeAz7A/izMzpaetgTpCOrKoROPiP0hMsKsnrFkRg
 aP6/quOT19IgJxm9dw5EsMBqH6SxoCiZNmFiz/58xXN3um0INs9v52zEug+aEgqpNM6S
 +mi33ORt8tD4fbJs6crd96IEWAlkpxg2iK1Ci9rQ3QRNAIy3R0Vf4lF6dehmFxJv6L5V
 HNrGQg37vaeS1qCNKZJdNRckn5P/gnnvVmv6FfzjtXzY3X6YPZbtjNQc1OqKhPcno/lo
 8i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769097070; x=1769701870;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CKWPP/4IjGgDhV888ZfsyVS+d1eV29rcL0kR8zkb/LE=;
 b=aNeKgoB41VOeShB5OBh7/bu/Qpo6BNlbegFib2WDxD88U4zCcchmM/6keoWVYU6pYv
 6yTsO0H1VP+El47jPnUzT86TN/YOQMKgn4NwtC211qUxI1Rv3PPB9PnlPhf9GEGxsLD2
 wmXWEz/IrgfMJiaPzNtlxkNTqWybZLcZ6FitenNWj3aWdavsHqKM8TN5hm+UKAH2sXok
 vvm2+NsgOveuq4jOhOziNBA8JmKqaUDf65d4hdya6uiJwfVZgAmBSCgbBXIuzZIKEOFx
 9TBsV+zV19LQDANeoNwwj2XKyPglo0geI38MLeIUDX0jGNrsKkotU5Zjlgwd3fF4+0aM
 YQeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCXsD7MwsnXupMQU7km4H4OMZW88QvIMunxyloTM6wdRjPaMUbEJPwFjJp6k4Yi+nCVhHF4pACnKAb@nongnu.org
X-Gm-Message-State: AOJu0Ywmke4IjMnbnunDBWceBNTtWvIP5hOSJUoqHGqTHUZahShME8lv
 1XwXx10bR2NjK0aha8IwZBMiaIcVNkcAUfpocgFcCMyem63GU0VYD7Zprj74sSIYpfs=
X-Gm-Gg: AZuq6aI6C4TRzSfiGFmHnF4bH6XrC0WhVGqqOgDEwOND3IVX9PcbcFt+UudS7kxuhVr
 6xUd4wOEu6YXEL3YXfM16JFR1c425CQbHbxFC90D+woyHB98e4NpwEdMn1Mj9s6SG47oXtj2n1F
 MG3NM1hs2+UFpI8U0+tWq7mKTCnBUn0iBoWumYcxugnAf8JJzjoJHFV9uS7xUMv0bjCMCPr1U5L
 QCL/o8Lgki/qWDcxBzggLWUMe72zRpHJuWYOhfTSPg5iknsevEusPIjgvH55WnMjkNZMmMf94Dx
 /0uvPnKJRAI6HcYy93Ogd02lcNYzlcFho2NRPb1xcAhyZSEV0/HCjytJJQAOkAILz3G2mgl9Vns
 Xkovp78kto0+D0Wr7cgl/ihyJ4E4/1gQDe6h+HmYWR1XEb6L6G+mYgUI+rr/rV3LXzxwmdKxR14
 XNW1tpAPhgPYx3JswVPU55M5nH5jHw4wD/hYt6U1E66eceoRAHAHo+c05E
X-Received: by 2002:a05:6a00:3491:b0:81f:9bf3:6deb with SMTP id
 d2e1a72fcca58-81fe87d8e3fmr9404252b3a.15.1769097069587; 
 Thu, 22 Jan 2026 07:51:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b2bb2sm18477429b3a.59.2026.01.22.07.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 07:51:09 -0800 (PST)
Message-ID: <c272a3dd-5f16-4821-bc38-5bd60369dfbf@linaro.org>
Date: Thu, 22 Jan 2026 07:51:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] hw/arm/virt: Deprecate 'its', introduce 'msi'
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260120180339.1416328-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/20/26 10:03 AM, Peter Maydell wrote:
> This patchset is an RFC sketch of cleaning up the logic that we
> have for selecting the MSI controller, so we can add the handling
> for "hvf and whpx give you a GICv3 without an ITS" in a
> hopefully clear manner.
> 
> thanks
> -- PMM
> 
> Peter Maydell (4):
>    hw/arm/virt: Clean up MSI controller selection logic
>    hw/arm/virt: Don't use vms->tcg_its in create_gic()
>    hw/arm/virt: Drop VirtMachineState::tcg_its
>    hw/arm/virt: new "msi" property
> 
>   docs/system/arm/virt.rst |  21 +++++++-
>   hw/arm/virt.c            | 108 +++++++++++++++++++++++++++++++++------
>   include/hw/arm/virt.h    |   2 +-
>   3 files changed, 114 insertions(+), 17 deletions(-)
> 

Maybe Mohamed could integrate this in his series, once you're happy with 
the result Peter.

