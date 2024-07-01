Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69754C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOKK3-0004OP-Ou; Mon, 01 Jul 2024 12:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOKK2-0004Mn-G5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:56:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOKJy-0004Vv-Eh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:56:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3629c517da9so2635985f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719852964; x=1720457764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZojCX/M8iEGUl41QWmDniRskrkbd5b/r5DSD8KpT4M=;
 b=LszwQ5A3GP+NDAD4H/evlHNlLDSa6KpbYApbUBFtaZGLpGVbMe0ONbFurBcWLEdzV/
 PwyuGoRhkJXghdBPbwB7pEe0mRLvGCNKow+/zvJuEOYJVnQEkYtU8P5ky4iN8l8j414u
 07JQRe5PbE3oMiuFqLLZcwpOh/cEiqRYVX77YaAerGAmwytz63+JtyVpkL+VS/x6Lzaa
 mWn9QK7S52o++0Z+ItaLgSKu9RH3xAZx3vhK+0Kfp08cj6o7McHvATua3wj9fhwF4Ekw
 7ZwzhhKMoU3NCYVPVsKpLw3v2hd+rA4H0GprZKYm+sh8ZU0yGKQ7YL84ZwGwsYA3nRnW
 rwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719852964; x=1720457764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZojCX/M8iEGUl41QWmDniRskrkbd5b/r5DSD8KpT4M=;
 b=gyeLpClH+Fo4p+ruxHtIC3/DzKwHFoNlreQd5kB4O/mtSqGkS/9GuyLjukvbhPXH2c
 I0Nm+Y6A4tncBId3h3rb4u3T26Jz3OExMu6Q0oRUffL6pC5Y+fpbPmQ8+oanyue3Ywoa
 Zd2y12+L1ApLGu/ZW5JYRrEEgtVvXYhK29/O+JWkhscPKkRrIRTeAnl4D/t/hSktZMD3
 b36E/zVhFapPt0AzF+hJMVZMu6Vdc1Uds1bVC1ptHGRwlAS+BGYa9DgZNKJOgwDqSlja
 FpKZF+lS4sjsTsWDsiJgEf+YHDjnRGMLbOqYYGW8JSnftr7t8SYwfqKW+2LGe25HlCn1
 jn8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYBMROi+iwCO1dbHoqxbOm6ht9t5I9AGoEYCKXSBgILy4iHCSbhWx7q8EOXwFnOqsRS8zwend4+BrQOHIp9OB2WiIwho=
X-Gm-Message-State: AOJu0Yz6IJKClnLNSmny6wiMEvmmPIKWbpictskmb4h2PqJv3FCjeVZ7
 onQscVCNkB2LBuyxhN584VtWtUsPsgMb7HxI8BDyum1YjlIvWXzGR3IX3/kjBenR/RhAfWdTDWb
 2
X-Google-Smtp-Source: AGHT+IEN/qAAQMBm6Pc6lpO8RJk/5IVX7+vYL2S0N7eea/f8azsThOoJNiLL/+GWK+KltIUW2eAMPA==
X-Received: by 2002:a5d:648c:0:b0:367:4ddc:fc40 with SMTP id
 ffacd0b85a97d-36775699458mr5443837f8f.6.1719852964048; 
 Mon, 01 Jul 2024 09:56:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd778sm10731646f8f.5.2024.07.01.09.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 09:56:03 -0700 (PDT)
Message-ID: <0bb8926e-65cb-4a64-b792-96bc5544b965@linaro.org>
Date: Mon, 1 Jul 2024 18:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/loader: gunzip(): fix memory leak on error path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240627162507.598352-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627162507.598352-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 27/6/24 18:25, Vladimir Sementsov-Ogievskiy wrote:
> We should call inflateEnd() like on success path to cleanup state in s
> variable.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/core/loader.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


