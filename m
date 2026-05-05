Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94E1FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHor-0004IG-V4; Tue, 05 May 2026 11:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKHog-0004Gt-VJ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:36:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKHod-0000K0-NJ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:36:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44a14580111so3440501f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777995364; x=1778600164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WajLR6UrgdjH8ERiG1O9W1KQb4mcMLxFzsK84CfLCOg=;
 b=M1Ll3vrjWzvvaBzWK5VHkQU6AL/soKhP40VynoyzOL+qIVlKLR+cdVawgIm4OEBKtM
 ouNGAB65P2VQIV4yzm+gPN28PbBXoNZCl26DqEoxVWwjZnjWVk8Ch12EianteND00TMb
 EkhC7umvYCK67aMd9KAtHiDoXsFDc+so5x87s1up9FhA9jUfki5gUlai9SB+stPeE2dU
 hkrRzm4MlUyzknqRg3hrzyWPw/a7QEcq90e5i0R1iVTMpJPp4/YgUMcVIecjWGZXWTov
 psXQfESzmAFUZ0GWBwTptgj4A/gtmxEn/3SfEVq4jBA76wr6S8TLdDbSj0I5bxZi7Mje
 qUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777995364; x=1778600164;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WajLR6UrgdjH8ERiG1O9W1KQb4mcMLxFzsK84CfLCOg=;
 b=O1QY/ZVCjt5Iyap1O+hSEsuI3ZBFyzPtwb++nGrynObz/WQ2wWVqzTns/px/FbNcdi
 NbFPhyIWCVvODCF3bRlpDLQPgDmnRpAsvvNZzBcx4zv6RaTMgs3su+4gqjFUqtFxPS+G
 356QGOrxdmmuj6oBfjDGI4vTi2mIfVaADOQHGWXgsK16rYzRv10YTnO0Umoi/wIvmn/E
 hpyxuOcCux0gVD4FS1bF4P4Q0wQVRYeYqlc59JsqqtEQgVY4z8OzVWFRTK3z4n2HrtIb
 jNAjCEt80Iu/VvJuwcGV42jXX8JP/YVaRFB9/lkBfCFLjHRShKVSIGG1znN7xYO0E7zF
 YO1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ocrNhGj3VpJELHgGcfK7rZaMkbb4HsFM0EzTe96ZJfiXP/UculQTiH6IljO0mm6pWALGetqbP1CnU@nongnu.org
X-Gm-Message-State: AOJu0YyIhiY4KJVf8Xr/y6FSvvkwvLC+Ns8C0xawrrkGYZgdczdD5tBm
 hV5rm/PK8s6wXq9SI7jmGnvOrXBxt2HMl9va8mzVDuNc8BQfTidgz5RBbedrIfeJnyA=
X-Gm-Gg: AeBDieuVEn7/f8T8HbAXl0BhNGTw71z/V0AwFOPJSHrgNTcyLpf9+s62ds5yi1SZakB
 vb+/RyJ3b9ldC48dxrAwbPx6TDztOMyYeE7HNjTuw56qQXGJpuIA/axB0EjWGa7rPT/koCpZvz0
 RQkz5BYU5q0WL7NBLio5ml/CZAo7qp6WzAETeaB8Fkb1ero2X/pKZlYlnDrR8jLe7qqrjey4c7H
 9wAkcpqOEwCeqmKpYaZV+vz7CX9suZNPaV5+4RNf9823ORiF9TQJD7FWYeuwM0zm+HlEqdxGptX
 u768XYvAqEVEc1qN4oHR9TNkDH9lIg9bj0otgit8y6vzasKdnClbacY3nUegpozvbY67PMnkDzK
 NbJjBiyeEK0uUNbbJrbHma/HfZ8wCQv8CESg6Tz1pdw/sIWru0lwR5K25jiXiNvjT4thPRngliH
 OkGZhwmVUzzrfpmCvmCNYJZcdLeivtw3nrzJAWyD9ePmmSpBKXA5gYwVbmIUDUazrUk4djldK0F
 cFC
X-Received: by 2002:a05:600c:c088:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48a9866e90dmr215100375e9.20.1777995364141; 
 Tue, 05 May 2026 08:36:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb75fc1sm367601615e9.7.2026.05.05.08.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 08:36:03 -0700 (PDT)
Message-ID: <4bf4ce0a-e518-4f3b-a12a-a5e327bbfd1a@linaro.org>
Date: Tue, 5 May 2026 17:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/65] hw/intc/arm_gicv5: Implement
 gicv5_request_config()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-26-peter.maydell@linaro.org>
 <a69b335b-03f5-4a25-89cf-13e185eb2c4b@linaro.org>
In-Reply-To: <a69b335b-03f5-4a25-89cf-13e185eb2c4b@linaro.org>
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

On 30/4/26 17:34, Philippe Mathieu-Daudé wrote:
> Hi Gustavo, could you review this single patch?

Not anymore needed ;)

> 
> On 27/3/26 12:16, Peter Maydell wrote:
>> Implement the gicv5_request_config() function, which corresponds to
>> the RequestConfig command and its RequestConfigAck reply.
>>
>> We provide read_l2_iste() as a separate function to keep the "access
>> the in-guest-memory data structure" layer separate from the "operate
>> on the L2_ISTE values" layer.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/intc/arm_gicv5.c                | 102 +++++++++++++++++++++++++++++
>>   hw/intc/trace-events               |   1 +
>>   include/hw/intc/arm_gicv5_stream.h |  24 +++++++
>>   3 files changed, 127 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

