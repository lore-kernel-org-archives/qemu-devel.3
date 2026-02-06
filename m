Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D08ECD9AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 00:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo9Y5-0007VY-KR; Thu, 05 Feb 2026 19:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9Y4-0007V0-Bq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:18:12 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9Y2-00043I-Sw
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:18:12 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso115410b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 16:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770337089; x=1770941889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0aSkFa+VAu6/lbANQzGBoudOeNbbgwGDwd/1BAMW++s=;
 b=pPQCjlAbrhneQHzrhNHtiCM+gmAAw7w/OZN7UR5A4xJ0rpYNEKUGdCWIKCdS4ejaln
 FynBLCHZEHpedkYFzff8moLatzCTF2Qi9/zm6cYoMsJgqg93jexv7bw58EfuDoVxP8Eb
 2yOBZ2sNFtsCnSEaQjf0aS/eMhgbd5zYjHjGprXip0YFIIRzoJm5fW4I6fruB/hjZb9X
 WEGZkhg4uqlmFfPIr/G27EVqqw1D9q70ILRjp79U86w7MWUDTTUoI+pReCoj1Y/4FvdA
 IaSfVYY1hnX+rPoMcrRma6jErAqqV68sf55ch9QdVjxynwzYFXVxS+9q2FgMhRo4FgMj
 FmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770337089; x=1770941889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0aSkFa+VAu6/lbANQzGBoudOeNbbgwGDwd/1BAMW++s=;
 b=ALE0BtEzNaANrPwOcp7rpuNJ39ch2dxtHAK1x0gZwpouSIt8ZJXIYdixy6oLwHraNa
 jyoL98yk75Cany7sN1UyCbGezDHDp23zSgj3Fhq9lkR9aTD7yCZV1UkBrxFSMQrNfrFG
 4mgGmQZoJkcljySnoo2LmqJ/Z0QZYIom5k2L/d2fcWCjj9YXyPabWcxy4wnyPEegj24J
 Lyn+b00tAhQmcI7kEwVJ6rIANMa3ZQ9nFo86C6asd5lyX3uyzuseS0BhuKthAZu5/i7V
 9LsoVXdTmw9l0cuK0y4t3bfKcqK3kcnXIX+QwAva02Ar8hoJWPx7W7wUC6LJb0+RaJa5
 I9Vg==
X-Gm-Message-State: AOJu0Yyj8i2CNcf6PzycYq/p2V1pkP3zvU8w3nJGF5UKO26QNtBJweVu
 72y3Ll+/Left7bkCPjg1SSQF3v0uC6dr9ZNaVVeuPz4SzzKT5p2c0k/fp25B5t8mZmHPrex1s3X
 ZK6npX+QRVg==
X-Gm-Gg: AZuq6aKnopARWqIUkPbtgUK8vuHz4yplCfNkFwTHxyhz5Ck3risokTNibA27rvZ6tnG
 jO38Caz+2VOWGd5LAAHynfRBOxzN281S+yUQRCxozAuUfeZHhZPjdtwaneBryjPFnerZA4igrXT
 8AIL6olVNsrtH1R7cbxmjOgLLl6THdXNcjgEaZFesf89mopTxlcjlCeSNFAqnXMfdPnNQEsYE8r
 inePtf617aIrkt0frj+3vZz3+hFxqMEZ/bv05aFAixixukVV0KkaU5+SwNgZ5FUfhg3vciWshSK
 VoZijqQrXmlw1HEcjU8EWX15rkB9Lz5DNYNp1gy4krPjOjgOmw5Bjeck+HKdyN17snEThRJ9qUU
 1HFNdvF2A8M/W1YLJ9T5Nge8q7fSWdBvpL+NLZhzqRkobNVqqNlEXiIl4lYir1xICZSUO13pn83
 HI0k+esBjzlE0oj3jSXmdkwYy3IaRbBTCxJcQB/ngp+HPtpIHbZQOsPnytE4yG6S9jLJ+duoc+m
 dFhXjSo7UBpqDa0fE85kotrixJfc3hC8yLAMAiDsQ==
X-Received: by 2002:a05:6a00:8c9:b0:81d:a1b1:731b with SMTP id
 d2e1a72fcca58-824416213aamr783988b3a.19.1770337089450; 
 Thu, 05 Feb 2026 16:18:09 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 (bg30dhzs8j4dh00m37sw.ip6.superloop.au.
 [2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441882499sm397671b3a.36.2026.02.05.16.18.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 16:18:09 -0800 (PST)
Message-ID: <fd2895d9-436d-499d-8abb-94bba27548c1@linaro.org>
Date: Fri, 6 Feb 2026 10:18:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] bsd-user: Add host_to_target_uuid for uuidgen(2)
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-6-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-6-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Add host_to_target_uuid() to convert host struct uuid to target ABI
> for the uuidgen(2) syscall.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

