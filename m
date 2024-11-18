Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B59D4921D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 14:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD2vR-0007Nd-H5; Mon, 18 Nov 2024 09:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD2vP-0007NQ-UC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:40:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD2vO-0005x5-1B
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:40:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3823cae4be1so1251551f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 06:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940820; x=1732545620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNC6wZ5Nr5C7+3a+WXbJMNymIZufbd5J9IyOeYxpTFk=;
 b=rHJI3FfHPM4qyaJ8027zzlqY5+FjpiA6qTM6k0BQ3+i1Z2sKNjk6Kdzh+SnVmArJX4
 B1z1QvhRbWsQRiN56npgHG1mvKWcgwxGQ+rFYkdMQJANj4n3I+aHVP9TuzIu/F6tbHR+
 bjwpKOVIdtZjW7AcKaiQc9rLhXxLoqc8scEw3GlN8ghWUmGP55Dh3DLfhunaOwWD7hDl
 837g988FBGLT4rIg8UkM6rS1Yz8+V/j+rh/E9Fms0ccFl6gWjzRqzfAEdn7i8FQ2Ms2b
 LfQ9LNCuIZxSeXT2OCtTkcBFKdSb5rZRklz1kKvPBPN4A0v9KXx2ZymWoOugINniXWNw
 87mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940820; x=1732545620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNC6wZ5Nr5C7+3a+WXbJMNymIZufbd5J9IyOeYxpTFk=;
 b=IZNfkSv+kLV+4iCELQpm29V1GxqBTWZ9RH6z6fodiaElnPEVyOcbQ5inwzzyzJEDpk
 vLOtAIlnCR8VAaf2OeZXyFjjMn30bn0aPElBpnAoOgjiwDxIAtZz9bjCQOdz0SSE2sSh
 cwy2iXHKUCnXZ4ZVJjNNt/4CpoL5rGw56WkjRpU7WEZ/ax+C22wo4PNqSeE0qFEB08OE
 NNq3tITcFcppaiFXNRJQaaCkbL/2Ltqp4ecYvj6mR7cIn3LVVLu7VkyYlgGzM5F+Bs0S
 8OpnRTUCzSbLY7wca9G/T2zlNP0RJBAH59JvLLtZ/aA0EoaSPFeyvEtas+SOneOzAx9c
 3E0A==
X-Gm-Message-State: AOJu0YxnbUIFQGWwatq0gZP+CUqdEdG+0GHfZgeNv3tizopMAaz2HycN
 8LjeS4q2BSiy1DicSlJPMjNPjn5KVm0aquByd1m9CmwTGBxas/YWpJFcdzO3xU432cr9e0Kwewr
 o
X-Google-Smtp-Source: AGHT+IGfMEtXK9hHqUraRysMmq8R/OdaCwQnzzGKTQ+naqmQz7/q4DaRPDmsr7VJ2z73HXbzpjZPmA==
X-Received: by 2002:a5d:5f81:0:b0:382:4378:462a with SMTP id
 ffacd0b85a97d-382437849famr3920182f8f.24.1731940820201; 
 Mon, 18 Nov 2024 06:40:20 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38245e95925sm3782919f8f.111.2024.11.18.06.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 06:40:19 -0800 (PST)
Message-ID: <dfe2511b-6486-4ffe-aca2-3810ce758dd3@linaro.org>
Date: Mon, 18 Nov 2024 15:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2] hw/avr/arduino: Check for CPU types in
 machine_run_board_init()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Iris Artin <iris@artins.org>
References: <20241118130109.7838-1-philmd@linaro.org>
 <CAFEAcA9YQcseyQ3Csf3T99xRfbmvgetkTPZYO22_QE4SZpis-w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9YQcseyQ3Csf3T99xRfbmvgetkTPZYO22_QE4SZpis-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/11/24 13:07, Peter Maydell wrote:
> On Mon, 18 Nov 2024 at 13:02, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Leverage the common code introduced in commit c9cf636d48 ("machine:
>> Add a valid_cpu_types property") to check for the single valid CPU
>> type. This allows reporting an error for invalid CPUs:
>>
>>    $ qemu-system-avr -M 2009 -cpu avr51-avr-cpu
>>    qemu-system-avr: Invalid CPU model: avr51
>>    The only valid type is: avr5
> 
> This is a nice user-convenience feature, but why for 9.2?
> We haven't bothered to error-check the user specified CPU
> before, and we still don't on many (non-avr) board types.

OK to postpone for 10.0 then.

