Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AFDC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GaA-0002Gn-6L; Wed, 15 May 2024 11:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7Ga9-0002GN-4m
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:30:17 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7Ga7-0001Tf-8w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:30:16 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e1fa824504so91397931fa.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715787013; x=1716391813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XeRyaC35rN+aSApFftub8hTUeY0GoC5FABRRnw9bRXk=;
 b=BjDXekpSbsnGjH1w5zmxfyn6KxQOJ/kHBkCUkqxSEBPwWzPrrh+SjYpkSLxIz9CqND
 b2FDQWBI97xUSCdLQxUNW2w3lx62maRyxCGhCnN4Ah4fkU4+MrSx6FQeAyBjK8US8eH0
 kNU3QdT3u9BwrbqcKepSZo1e+pFE9NqQNljhbHZp5yoYL6uyJCYROLdbIDQ/OKYFpP66
 ouyRPjB8ZyJroQIjbHmJlES2A3NsEBznNWgkX7yig12Ad9Y8BHCvu+4gNSq1YBKlr5zx
 GPMTHSeop5TxCiM2EBWSNwRdSZIfatsaLoIqUCR47Po2DufBVL1izojCPHpBosnpkwVN
 G+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715787013; x=1716391813;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XeRyaC35rN+aSApFftub8hTUeY0GoC5FABRRnw9bRXk=;
 b=c1d5j3LSL4gwFccVIyQ8mTziYUbcHKv7wGBX8OVGzaPP11c/n1aTOnNOy5EYRkrdo2
 PZHLroJsTddOgONAZZtHtgxf85HVPd4RnoXOUQOi4gfUoceT6S8a6GYUMaR1sPDTPyGo
 Z7W99pP285lp8KLtGJo5u3yXbQ5r9TIusyLXslNOJh309KDEUAmzaGowd/83Ug37nB/i
 FCsseetkydl1xuX9YJVhSiAuiOuMffJHCWR0r/KobY2rMoZZz/nPS9ecqbZoh9KOu/c7
 c7Bm+3dcn62pTX+hS7tZUTUHNr6nvKK3ojvHhG81Z2CzUEL9lwE3SaHhvD26SRrdXJ4h
 ROYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6813IAZzxuWeKoxeCNkPpN+HYnWB4RlhMLQ/S/mdLkH1r91dgX1uIGCNLlij8Vi6/E7i54q0odz4xgIy9Gaqx9a6mC8=
X-Gm-Message-State: AOJu0YxyoLDx0CYOb1JKoaLtsFFINTRV4WtsBHn2oF6OvNHlJOVYHFWM
 zjnLDrtGOhySmlRfJMF3E+kdb4Awwyj7sV2KXx5z14zt9z9veCrZWkaChSdJQcM=
X-Google-Smtp-Source: AGHT+IFjRzBDlUOaICTee6IwcoCjMwWmwxTGBxBHl4Sy5pRLmkxIJwJfPcJDiPRalXyWhhaDw3pn7g==
X-Received: by 2002:a2e:9e48:0:b0:2e5:67bc:6f2 with SMTP id
 38308e7fff4ca-2e567bc07c3mr74236711fa.44.1715787013108; 
 Wed, 15 May 2024 08:30:13 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f9bc3b12fsm139098245e9.0.2024.05.15.08.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 08:30:12 -0700 (PDT)
Message-ID: <3048a39d-9d14-46f3-9672-317a034fa5b5@linaro.org>
Date: Wed, 15 May 2024 17:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/41] target/sparc: Implement VIS4
From: Richard Henderson <richard.henderson@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <7b5e744c-7fc5-4bf2-9602-1d2cc97913be@ilande.co.uk>
 <f38d59f4-3cf9-470e-962a-c888970b5a21@linaro.org>
Content-Language: en-US
In-Reply-To: <f38d59f4-3cf9-470e-962a-c888970b5a21@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

On 4/29/24 23:02, Richard Henderson wrote:
> On 4/29/24 13:52, Mark Cave-Ayland wrote:
>> No objections here about the remainder of the series, other than that I don't have an 
>> easy/obvious way to test the new instructions...
> 
> I was thinking about adding support to RISU, but the gcc compile farm sparc machines have 
> been down for ages, so no way to generate the reference traces.

Update: I have successfully ported RISU to Sparc64, Solaris and Linux.  There is a 
limitation in that I cannot find how to extract %gsr from the signal frame, which is 
unfortunate, but I can work around that for now.

I have added descriptions of VIS1 instructions to RISU, and it turns out we have failures 
relative to a Sparc M8.  I have not yet analyzed these failures, but it proves the effort 
was not wasted.  :-)

I'll clean up these patches and post them here when I next get some downtime.


r~

