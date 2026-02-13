Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA8EF99C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy7D-00052t-1h; Fri, 13 Feb 2026 13:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy7B-00051h-JR
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:42:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy7A-00038v-8d
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:42:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a9057b2ec3so6050015ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008122; x=1771612922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e4zr91gKAiqEpioA8CmVpzflDEZzXrizHVZVzLXa9uM=;
 b=lSFWkLA2VYN91h0ehZx6+VPf/f/Xi5u9OC0mLdH8goswcFer4ia2BCzeniXWp5ZX/3
 HfJeEnhkK1jCa2qPyBu5SZ3dp01X2vfUjf1pZxcxVCQd9Ebh65DGBbF97OWo9pB6F8w1
 rBNW6Yt/g//BWBp16sW5+w8E+qvPwqpR4UhFhJDNsMPRjmnuVh0aMMSDkIh+xkPcUZqd
 vlBPVJ3BySJ4zK+ZTIeZl8QMOTzYjupCLDI+RMyhAUBsGv3N50hpOy8CFoaCLRhrxTvQ
 rCBZfG0Nm5vTVo2F9kBD6/LGJiWm4ZH+nvcyvm/Blgw3REQ+qhXVSmSNjNmtjxifVoBb
 nAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008122; x=1771612922;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e4zr91gKAiqEpioA8CmVpzflDEZzXrizHVZVzLXa9uM=;
 b=mVzuCUsLeJrKaD54WWWCPI7B82QXS1oM99ENa1z6iai4hbOFlC61mp24uB612MhHTY
 cwouJ/gqqtfvYfer6k6gsm5h+xr4qjQy3Z7vjgvmRfWo2eIaqEsjIt+WTrMbWIKoUX5O
 83D9QhrX61OIX89AhFmgdir+Jpt9QyvOW+JajI3uD300CATewC1dOM1DPYYsySepHowk
 tesra2NohwkzOWWJkmhQaC45jb1LCN0K+UM5jnZQx5xO7GYqFc9k+VyjOzyN99fjFi9L
 fD14LIJ2UaWUhj0RlntMgtyC40vBawv0nxsF8JmaURCn+cuyKooHFfZQ2y81Jdq5ykzd
 2+aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlX1UnVgLWH76MRRfQt43zvJyhqkvAGzuRxC6Enha6sSi+bEK/A9x+BIVG1ZiLyYTm7Sd6KBFf0+yZ@nongnu.org
X-Gm-Message-State: AOJu0Yzxa8ArtGJIIcAfE5+NcUR2aGybCyq4zKFAoeBU6vp6I0QR6g83
 Bc3n+jDvuRkh5d7lNlGiT1LKQ0vrNuAB4I2uf9gposk90hcoZyAfOYwXpx8HuBi9wMQ=
X-Gm-Gg: AZuq6aKi5kOZgCRHJSCkpthXwr6PE6JrhyBzXLJP5D0F/QGj4bJJj3uQE+7TYHa0rlI
 QyGVrBatqsN0fm6tRvUdLN7yDWMGHuTcfHZe2u6qJ7MCBMiGlswAJDBrWefojZGICk9USOQWPrV
 49GkquhdmHjkb7zVJR5yhK7YMVwdEutXrfW1anX7hLeOF9YA09/v+Y0lgXcy34koqgrtvjb5Dto
 YoSY0vOFE+Tq+BVa3E7r2jkxIOqdELNBSUTVuRkpqqxXh05DEiEAEDK7X3ULsIkt3uSaPd/jD/p
 TcXXvXKd3KmFixyQTvz/T/D8dPD452TaYLV90QQkNIsfnQpKNiP/NSG+YExR18BUnHIOJ+10wlg
 9Ui8oRA27IXqQBvXXGthkwj7mHyEmgBFiA2TEBN5psJTzC1Li0vo1PvtJzpUulmc2p4V0yAHQyv
 qjHMISDor5OUvhsoUqpUZY9jwiebZBCSMR1AkwEy3KRDdEiHoIq2kR4NWpu8gj2/UuoSbQ
X-Received: by 2002:a17:902:f788:b0:2a5:8c1c:744f with SMTP id
 d9443c01a7336-2ab505a3194mr33273005ad.40.1771008122164; 
 Fri, 13 Feb 2026 10:42:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2984c07bsm90760035ad.7.2026.02.13.10.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:42:01 -0800 (PST)
Message-ID: <c5b23db4-dcb3-44b5-bd19-4718ee6a00a4@linaro.org>
Date: Fri, 13 Feb 2026 10:42:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tests/vm: bump OpenBSD to the current 7.8 release
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260213154859.1551283-1-alex.bennee@linaro.org>
 <20260213154859.1551283-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213154859.1551283-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/13/26 7:48 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/openbsd | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

