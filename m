Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB6FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B50-0002ff-4c; Wed, 15 May 2024 05:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7B4l-0002eR-LK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:37:32 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7B4j-00012W-A7
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:37:31 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2dcc8d10d39so77335541fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715765847; x=1716370647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu7UI2y+DuzvA5UUbvJosbvF4bMbzVHfB/vhHP9duRk=;
 b=fu0vnrZCSVeYROM36Y/p3s/8Wfo8gRbRkjybG6cTHDV9PBoA6e7JdlpgzpJnlLnqru
 6oeUmgMMaHlaIP+TomOTw+X5aNvijxJqjVjKQ/8caZQehKjFapBk7H4w74nKBvNIjf7V
 XdJ4X5Y89NwQvSS1De0+N/BXGOWX6gq8pXOo7uUwGkNhJ8l0PIAAdizbzHe6R4TRAmaV
 HZM6cRsr6E1MEYe0IQhh7Sdnbp/H8RVI/FnntLQu50Ru2qJYE+eg7RsTnlNzGXMkATmn
 Q1n5S1XgKfurGzsYM9160upsSVGuJS1oM1eou73F+uWO3xxNL0BawXBTOS5DJMuOcnDJ
 UAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715765847; x=1716370647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gu7UI2y+DuzvA5UUbvJosbvF4bMbzVHfB/vhHP9duRk=;
 b=rAFEnBQLxTYyK/bQKsKh5ht0CjLRNy4z9htFeUWKP0xGxyOUNKPBWVGkN4GhcWuk6A
 zcg/qFoEAKPAWZ4n4J2f6APknYw0SJ6SvWNx1T662sIHUyaqwF3DMpBH0O198PVCV+26
 H/w8b1KgVYgbSyl9K9rx18fm2NatJ72fRzAbkWJ5velrOvdRll1/X0bmDbqiayYL6x35
 67ibVEAutSYebab0g627RRJtlqJImtPZ6BBZhO9pgFr5Yz+8TXGq8u3zWwxknO+blOpn
 75L5VKF++X5h4/7GN7Trd+uzx2d6R4C4ZoK4rB8yFzq7ZROJ7gzlrxVBDT6Lx4/95WgU
 KmcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRgRAGtTgVitFdHX45C2FOdhmpQbxzx4g0a8bodONAvaUOKASNGEhJxgANQIpvJOeiv6fLH4BISPbIhCu/2/hO7AigLPM=
X-Gm-Message-State: AOJu0Yz496YJ3pAStTlIEDcbZU8/zi2+1boMgECb2+rqmiQmyUw8hmUk
 rK0KIhSqOniUzXP30FGSfgb+7DenMr4tOuEkqexJq+go99nJ0QvRNdtqDBvi3nQ=
X-Google-Smtp-Source: AGHT+IEh1X07+PFik/njuRQ3bzLytxeik9QOQoFxHz8w4bwlVW+jcZJzDwSlJ4yR8d5/rEaCZouLcA==
X-Received: by 2002:a2e:a7c5:0:b0:2e6:f4c1:31e5 with SMTP id
 38308e7fff4ca-2e6f4c13875mr14309621fa.23.1715765846949; 
 Wed, 15 May 2024 02:37:26 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d0bbc6e5sm20467771fa.18.2024.05.15.02.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:37:26 -0700 (PDT)
Message-ID: <0b2ebf0e-edd1-4832-9e86-3a46bf6602d3@linaro.org>
Date: Wed, 15 May 2024 11:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/pflash: fix block write start
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20240515084340.113670-1-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515084340.113670-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 15/5/24 10:43, Gerd Hoffmann wrote:
> Move the pflash_blk_write_start() call.  We need the offset of the
> first data write, not the offset for the setup (number-of-bytes)
> write.  Without this fix u-boot can do block writes to the first
> flash block only.

Wow, that is a fast fix :) Thanks!

> While being at it drop a leftover FIXME.
> 
> Resolves: #2343
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2343

I suppose we also need:
Cc: qemu-stable@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: fcc79f2e0955 ("hw/pflash: implement update buffer for block writes")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/block/pflash_cfi01.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)


