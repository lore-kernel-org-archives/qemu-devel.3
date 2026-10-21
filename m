Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADE606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hEgyFBgy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRG0-00026s-23; Wed, 21 Oct 2026 04:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJRFn-0001ua-08
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:01:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJRFl-00058l-9G
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:00:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso325489f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792569651; x=1793174451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FTpe9+5XGk0JbAssSLcRJeZtl87O0Lpx593oh2LJv9g=;
 b=hEgyFBgyLKSjTh1ay6+7pI+10YOZmZeZU7WZ5Gp65QfgecXWyjjuxsOURVviUoVI67
 BO63UXMv+PhiNdk70e8d+vgylRI+8XpQXGZCYt6QNlEbi+IjTUKGyi0d3Kq1iuoV+tot
 yIot8hP6VN5LnW9p+XMRKmcvt823Bj0RfzR0X0nEX0AbpsnDUif36TmsmGxyecoDVFMx
 wi2/S4Ui1qgMufbXX/jr41NZstRWNsKZywygwjDoc5cS3UfHaEoJprGAq+ppZbqkWYl9
 8xHDZ5TjoeK/+JYYOCZDPJhMK/2Q55auNiPS6v9qxyg86O4MTlxBAxWf0QKVWY56gOYu
 7WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792569651; x=1793174451;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FTpe9+5XGk0JbAssSLcRJeZtl87O0Lpx593oh2LJv9g=;
 b=Sa6pDhIamth2XzUCWEmF2A9MLR76l7oXHatHx43cLFQmDIn4JB6hQq8ZKnP+ti0Dnm
 aIgwPtAKcOluuXd0RykZYuKXkovtwv46hRUIDI8p8pFczzZ8C44EOfcq/h7MwgtcRK2F
 2m5+rEcTFZUNoqJCntLT2BbELvCbVE9eDEM18v/fJpa8X4KTV9ucX5YfM4Ett6bd5+sG
 acN8HxHzazYuSkN8kTNzy14o/zYajPEYSwzdsE7rYwofCe44+SiH1bD6E9YvR6DQbidN
 jWvUnp3A3vAHSBrnigeoZD4LL8Vuw8bHM5J18zesosXRKDqXNn3LyJAQKBG3y76Q74Qt
 lg/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6t/br21YOlYxMH9ydtk2wgTghvMuyjOsWF83k4di34hqwDOeHZZrYJkvkMvofs1eldONehlWCnjLU@nongnu.org
X-Gm-Message-State: AFq9FYIMkbioqXU3hAbU+H7LOtCC+ovjVP3gnzlavUsy9gRu8HFa1bYz
 Idjm03A40yyTtVBYPh9nbTHsQiffWmQYFv5zHai7Yf3H7hP2vVRT9TozJWi2OwwWTis=
X-Gm-Gg: AYBFou2qLWDHtnv3xQtYFOHOOx8syxuXuCiIv40gTArNcsJRFSfN53UPhq7XBuwpkWa
 t/icFjQkFEpmC708fiksUSopbSYCxAorjvPTwmzh3b9h5BANFM0bRoJWFzyn3Tar16ffBHX4Ocp
 aYVIoS+ZhGVIusBnFq8mNew+oJcqCcom3QIgt3+bFq7WQypwbrIC6l11hRZqHlZAXndFWfuBvCr
 m8omIIP038mICVm1+mLYN/cCOOCapQ7159QRkoE7Ozf7EReYz+6AWYjXk/hf6Oc7xSRF1EkykBt
 EI7CyhKFN/laqj7tgyclGNS3TCZV8ODWowWHFDG6ADzJVtOVyR8WOnZEG1SNMdY9ENHOnu5v6fH
 aMV63JUczfmXQqYKsUSpEKtVt5jkpGdvdxv3N92nINQ2oOfQct14k3HpXwiOGCikOS7knchWOiL
 8kVSLU8NRrgIerfGIIQf6TuN9Klx7ApAnd1+cIfpyoEDiD7ZpBsEe4PniU0fugxy5QyIsvK4zDX
 dc9d3ruz4pX/GIUD67Zn+bWvoe6CaBUsTvEEqZyNZigddBRlHcmUeQrHD0pqYDvCw5HJ74+NeaL
 Oc6F9lyc2e5DHmN25XlRg/AOg+Q=
X-Received: by 2002:adf:e00b:0:10b0:48d:ff06:c626 with SMTP id
 ffacd0b85a97d-48e264c8146mr1530507f8f.35.1792569649831; 
 Wed, 21 Oct 2026 01:00:49 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm3623097f8f.26.2026.10.21.01.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:00:49 -0700 (PDT)
Message-ID: <094ba078-4b30-47ed-8371-d1d5b505dc54@linaro.org>
Date: Wed, 21 Oct 2026 10:00:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/sparc: Add the SHA instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-7-stian@itx.no>
 <dcdb1452-5196-4edf-aaee-cb032f581526@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <dcdb1452-5196-4edf-aaee-cb032f581526@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 21:54, Philippe Mathieu-Daudé wrote:
>> +++ b/target/sparc/helper.h
>> @@ -134,6 +134,9 @@ DEF_HELPER_FLAGS_2(aes_kexpand0, 
>> TCG_CALL_NO_RWG_SE, i64, i64, i64)
>>   DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, 
>> i32)
>>   DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>>   DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>> +DEF_HELPER_FLAGS_1(sha1, TCG_CALL_NO_RWG, void, env)
>> +DEF_HELPER_FLAGS_1(sha256, TCG_CALL_NO_RWG, void, env)
>> +DEF_HELPER_FLAGS_1(sha512, TCG_CALL_NO_RWG, void, env)
> 
> Hmm you set TCG_CALL_NO_RWG but the helper do read env->fpr[].
> While benign in practice because fpr[] aren't tracked as global
> TCG regs, the correct declaration is using no flag at all:
> 
> DEF_HELPER_1(sha1, void, env)
> DEF_HELPER_1(sha256, void, env)
> DEF_HELPER_1(sha512, void, env)
Incorrect.

By marking TCG_CALL_NO_RWG, we indicate that all of the integer 
registers are still live.


r~

