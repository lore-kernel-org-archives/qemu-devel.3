Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A69AC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFs9-0002PU-PF; Mon, 01 Jul 2024 08:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOFs7-0002Oh-Tq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:11:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOFs3-0003GZ-Ir
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:11:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424ad289949so21683525e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719835857; x=1720440657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZttrhoNCNlakmyB385PnUFz1M0dX0swYIZLIKEfToBw=;
 b=UonvxiZqNaHT8O13fYiHyJROt+olvTuDd608V5tXEvIG6n6rLIuJcSkjGP17BuzoSY
 28U3l7AVclhhnL+cZ5Ggyh6Nb/i5hplR1IDOLck/fd/sZmVoPr2XOXtuDD9rOypsUfOy
 whLEUhDgr1pHW+jeYEbsa4+9xKS6aPutATMQel2xiUWA7hlt7ssHpUg60RrTQDiPBdWP
 1csCYJ56euOpr9m353UZTOq6ICf4pR/UvrF67yLHTW4wjLHbu9PgACmxVe+uhIenBvmP
 wKeg+9b9B742sukjTrasW6jURtW7r7g2yAzHxWz2HGZQHUWZpvH8+owKlPmmZYGE4cTx
 DweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719835857; x=1720440657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZttrhoNCNlakmyB385PnUFz1M0dX0swYIZLIKEfToBw=;
 b=mms09jx9Tvz+nPpjEci4nl72KPIlCzPjzaJNQ36LkfbSYgKEzlAWTaBnpbWEQVI99G
 QqsmeNiLriX968t6SS2Y49v0edu+wx77vhqz6jrVPrITsg9nPrBcHPhTgd8u7f+Jrcaq
 GuAcVA6H2VRtBvyVhufIP2/NBvQZ3riXs348ch7y5pH0Xl+draRf8OSl2jVBN+NlhcC2
 syRusxSWEZM4e+wtBOCa25Ofa+h6FnTiw+j/rtV+zXvENVAncLxl7lJNUFd6E4b7ZMIO
 /yVWSA+q6+6LJQLxSsTvBpjyJcZngcvaUTT49d+EAML2G390vSakRutksagjZMQQIvCI
 qd5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTpwbcfscNmA0hWeUmn4TR+RJfD4yPMi28sEALLTAL+kyBzNxFbIw5xz3G6vQilgsvv1RPchhCiFo7eQsxJ5fHzbr/gyM=
X-Gm-Message-State: AOJu0YzpipO4WNE8A4URUpVWzB1OFUg4iS8wTLlYkbaM9Nd3/nDuGfDh
 4ffOYEkONDUb/jDt7c+qr8/y32f0wQ5U9nIKUOhKAHbhYGpDhnk5RnLpCy2MgAw=
X-Google-Smtp-Source: AGHT+IHUaZ8mHX6jMu1b/sTOc7LuNFNjagB4aNHutN1ZgNgxAoXTptuoy/MGqaxBljH9wi3O+N5irg==
X-Received: by 2002:a05:600c:4205:b0:424:ac9c:71f9 with SMTP id
 5b1f17b1804b1-4257a0282eemr31560755e9.39.1719835856986; 
 Mon, 01 Jul 2024 05:10:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b068e93sm151981965e9.24.2024.07.01.05.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:10:56 -0700 (PDT)
Message-ID: <ae8a75ab-1250-4ac3-ac34-00121f6421e2@linaro.org>
Date: Mon, 1 Jul 2024 14:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] tests/tcg/minilib: Constify digits in print_num
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, alex.bennee@linaro.org, qemu-arm@nongnu.org
References: <20240630190050.160642-1-richard.henderson@linaro.org>
 <20240630190050.160642-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240630190050.160642-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 30/6/24 21:00, Richard Henderson wrote:
> This avoids a memcpy to the stack when compiled with clang.
> Since we don't enable optimization, nor provide memcpy,
> this results in an undefined symbol error at link time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/minilib/printf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



