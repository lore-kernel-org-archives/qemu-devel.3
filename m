Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B522DE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 00:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsVCQ-0001dm-LB; Tue, 17 Feb 2026 19:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsVCP-0001d3-0Y
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 19:13:49 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsVCN-0002Fi-IA
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 19:13:48 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-824b05d2786so942977b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771373625; x=1771978425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rsTkX+FwNdIMnxruRaGxsM2913OYRhly0ixznogOn4I=;
 b=jo+v/IvoG4+xWFE/wf0peh2TOzWl/SFH2SstvAPsvVDwqDs5MEGhSd99eSkAMPqQ9A
 utSWK+L9gjCXRbbK1ik5sIBfc23wkikWhM4bBnalFjwA6iGHekb5cKKdB2uwRRCENc0u
 InM8S8rW8w3t5TV1tzfHjGZRrKVOXMWKQgw/7MRW/RtGeMv9D+MQ2iLCwKxCrrY34X+S
 SjTCC0QFtmkAhqMypzpza+nNzfX8+NWhCOePYdZ8o31bbZDtuL2BY7Y7RuZxPZ1cAozi
 piiZ0jUVDuUViI1Lehl3D0HWraOXEyCpofPbUWF5a2ReC76qUlr7eopExaO1fqWLTYnS
 4luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771373625; x=1771978425;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rsTkX+FwNdIMnxruRaGxsM2913OYRhly0ixznogOn4I=;
 b=s8yoT5K7dQPltLloe5HO1E6/UaRGYp3zHKYbrN/hsnwHaG9sKjGX30Q5MnsaD0f6ED
 KMTjZfoksPHWFvYgMAKqYaxLwwBds7czP3yivdp4g1EXbL52Z5DSrnZokR31KTp4/5Ed
 VG54Se94RllLFUG+Umkjn0/TpxMml7QSR0Ljumpj/SbNgAKH27rRN2NPfI46cC8sJlhA
 VfstMh+Orocf2d4tu/FHgaxQpxFNQmgKY2bV8hP9ieVPb1kcBU1ulMMK7qL7pXO/jXI/
 A98nGGpsuwF2egAQFH0mbW4u28RoDw7W2m6qcT6oRbP1jdFJgYzgKC0reRecP7L0cAua
 LWOw==
X-Gm-Message-State: AOJu0Ywhd1wE+wm521YdLmRQ/FERD3lZszAfBukagB8HID+WdAt1K/FS
 Lut6x2qddEjbFX6MArAMglNpXZIYefXnYWIuFlgxkJSTQwrZ9WF8JFN6AH0pq3Jy0rpdY7E993u
 62pC79UI=
X-Gm-Gg: AZuq6aIVONOxQopHT9VnmG7s5Ft4xQyWvuegDr8esvklL8VHl594lVvmA7dE+PUYFdw
 /jnXQUsONLgs/cxtpXvqlXwQg7qmnXbBT8udPPArnlTAD6qRy552JgSsaMo6svc5cOgLD2dJ+bZ
 Y3ASdz+y1Pgw5VnE8Xnx0+m78vKlA7JthlbfRDPZ7/4qB13mteewe5YkC9stsmHgkJDq7batxZP
 N55LyzBvrYyMCYqk3VaVdxGVQCR2tlau6D52Q8SRVS1DFOMg8oqTMLzFmwebCvPEmFA29A8AkTy
 2iijYn/9K0TFbzf8oWDrxLr62MPldjm8kRzUEiyYCpQy6r8PmtsJnmuHqQg/ACK0uk4Oy3LvPLx
 LSnWhqdv+wMulbjrc0u/Ykjc51Jn4iCFyMfT2TZdIm9vpZkHPrEFIHseVaQUMfY3YbJOBVnaoSN
 1KoZoGkF2tHeCExpeh/8Pnw0oKpdi3y9V+R41xTFyD/KT3oKxcegOjLc147/pVjz7t31CfuCmIQ
 BeMGQe/Py6JD4S01dY54t1gTOOLVaR1aUNWsqTOu6RSPrdgbfTaNKDUo8sulkHFOtUl
X-Received: by 2002:a05:6a00:170d:b0:824:a182:1dd4 with SMTP id
 d2e1a72fcca58-825275ef38fmr295387b3a.54.1771373625461; 
 Tue, 17 Feb 2026 16:13:45 -0800 (PST)
Received: from ?IPV6:2403:580b:742d:0:9dae:4750:549a:793d?
 (2403-580b-742d-0-9dae-4750-549a-793d.ip6.aussiebb.net.
 [2403:580b:742d:0:9dae:4750:549a:793d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a42688sm14608479b3a.21.2026.02.17.16.13.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 16:13:44 -0800 (PST)
Message-ID: <66d38781-24e6-4bed-9846-8dd389e4c5b5@linaro.org>
Date: Wed, 18 Feb 2026 10:13:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/display/macfb: Constify macfb_mode_table[] array
To: qemu-devel@nongnu.org
References: <20260216213121.47122-1-philmd@linaro.org>
 <20260216213121.47122-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216213121.47122-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 2/17/26 07:31, Philippe Mathieu-Daudé wrote:
> macfb_mode_table[] is only read, never updated, so can be const.
> 
> Update the call sites accordingly.
> Make theMacfbState::mode pointer to const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Reviewed-by: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> ---
>   include/hw/display/macfb.h |  2 +-
>   hw/display/macfb.c         | 10 +++++-----
>   hw/m68k/q800.c             |  2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

