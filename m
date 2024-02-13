Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5CBC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxmk-00087Y-BL; Tue, 13 Feb 2024 13:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxmi-00086r-8P
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:45:36 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxmg-00053i-Kt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:45:35 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso34005575ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707849933; x=1708454733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AKcI9SfCDunuisuuDL2pJCXNZ+XASKc8YuFE6sJtU9s=;
 b=HHFNPkkO9SgAFNFzzN3IkyYEgo8S8YKQqlvyyqU8dsXQr8AEzWG1A8BQqGajdvwzaj
 Lg8xdqmn/9qRD7pt07s23hWF/MpV5rPteOrBDcQ/YBjMpZ884yemDYqGuTzCzOoToKVl
 OicSQ8O0urfKz2tSgNsl5+WXFd7AmjwacQZg7/3NhqmTxBqcGyYl6L//9re3zYlA3lmj
 6pmk37cDmX0hZujvtvfil8717VfNPqkrS6e8WmEUQX1IA9vdMQ/fqlv/xb30zAVfS14i
 jHZ+4BXiRkQ0kv5enUYVy9gkiAtqPyNDF21yGPELuMBJPCbODGwWLE+gSwsU1wyJIMB9
 rqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707849933; x=1708454733;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKcI9SfCDunuisuuDL2pJCXNZ+XASKc8YuFE6sJtU9s=;
 b=QzIP4ivBHO0uXubltuuiECTecFLs870sa6MaziyXHf9IGwR7VMeBKaEBjcmIWSEisj
 TlY5ch2iFDsSvF9yTstJWDOlX8Yu8MCDVe/u5j+IcxYCV9LP/DmhB/+tIMOwjSlJpwDL
 oiURctqouPhS7rOw0WEeOBUZZfjIze55dJv6NoSQI/r6Zq9iMLZsMOoSmVuC5i6ajz5C
 JsYiY4pn+9XhCsokT1V1qIi8GloRpLxHLdrO7zvSLJ6arPq8BMCAZw0BKbmaHKFmC6zp
 eMUs/mHyKzztmO6MPOt33opvjvXWp3b/+z33vArsC3Zxt9Aysn8DDsg3RmUwjM7DqB8D
 n3HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7FmasyESgFufpCTy3gAgBKQ6ZlYQa5jdYEyH7jwIU9KO6gQPVAfURHZfedJKL2fELT6HDXbOAI/Y5N8fcQoaXREq4XLM=
X-Gm-Message-State: AOJu0YxgRoXL7klgPd/OB8FM+iAds26yGbsJ4ppGnc5RoSc49KTR98QH
 AEhvEl+KeEBOVjLwZTFao1V8Fm5pcJVHVpzhqgiEIiLzUUljj+ONQ5k71+RCouPLCZQL1huWjL/
 p
X-Google-Smtp-Source: AGHT+IEWlQW1WcqVOGheO5/xK2tfeinSjn1EEJIqYs//FmhD+5WhMGkio+58ooarbKMdAIuaXlQw3Q==
X-Received: by 2002:a17:902:da92:b0:1db:3592:a68d with SMTP id
 j18-20020a170902da9200b001db3592a68dmr547126plx.15.1707849933195; 
 Tue, 13 Feb 2024 10:45:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVNm00o28xpwHRlDsF+IXmrabAdo+IZR1ZOL50Q7WzE9HS0+Q3WxEmw/8OPiy6LOgV3yX9WmCTWq8SvvcwtXh8L9K88+tg=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jj19-20020a170903049300b001db5079b705sm233013plb.36.2024.02.13.10.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:45:32 -0800 (PST)
Message-ID: <82a9e1a6-116d-48f2-a760-b5213d1a39ce@linaro.org>
Date: Tue, 13 Feb 2024 08:45:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] MAINTAINERS: Add myself as reviewer for TCG
 Plugins
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-19-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-19-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/12/24 23:40, Pierrick Bouvier wrote:
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

