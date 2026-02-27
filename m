Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A895D10398B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5Jq-000414-SR; Fri, 27 Feb 2026 16:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5Jp-00040Z-CS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:24:17 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5Jn-00073u-O4
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:24:17 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c6e1e748dc1so1201651a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772227454; x=1772832254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yf6zK1qt5v9qIyrH5dx5UVgqipetRXuJiuPqiu0u3yI=;
 b=KN00LPtM72eS0VGdTkmSR+jSJ7Wf6ZbLZV1G9lsq/HYevv3PrXwmORdiaQf3unQ+Ph
 j8Kt5FLGjw+ZpQFEdB1xGHzNybSPELSyCX/gkGL7ZygS48+zhhGt3WRL/IdM3Dg9/72f
 ROxbFHN06aHAFoooZqzMj47H0fWH10hjaBelT03Yhe9yKuNUshs1IqXcLjSoeC6rG9oS
 2SsSwqXnzt3fh9kkpgDy5tnetYTQO9hP/yL6LjZPi6gBah5JZdRWIpHk28+Uu7dq7yOM
 iK8hgU6kEK74W2dZhByQzM/hirPVtSOWSEORpZpH/CRl7Yzl+QFzocc5HnSf/+0+n55f
 TtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772227454; x=1772832254;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yf6zK1qt5v9qIyrH5dx5UVgqipetRXuJiuPqiu0u3yI=;
 b=aq2yo8bYfFrktZsnsosEBGlWr+Cx/QdHbo0Vw6/cOIexW+Px76bA1lOHX2pzRXs0da
 xg1Yc2OTQWONWkyREtcBMxpfQxYM3BaajAJbgfu6vQZ3bJegTfgn1AGkMluZRUvqzXxU
 UA4sLYvKOSFb6xYDiQos0k7JeDvQcrCjp5P5F1v91+Bd4Kqn/WsYAAFwzZs5HIIm68ei
 p0J/gJga82XFiF6kvaW56U/3wP12IE5RBAVeo4SkozQdi9AXxuxj5jBEA8zwErwf2m/U
 RQZvv8fYnWZwEzwqb0U/XGw/RX9lqLqlqNv0e5MmFM+tkX6uN7iA5Do1ta2VdsGfr2Sx
 v/Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpRU7ZwBr5cjCYlXArb1S1YlbI/5v18RbwLR6B6y83dhDskknc9ELX6ZOaYlRu6nmt8QYCxKvt35DY@nongnu.org
X-Gm-Message-State: AOJu0Yy2+crNnbzCoIXeqWyI+MeZKrBiIxQ4tGgP2X9rfmFKzUzoE7+k
 Xyc4xelPylBSCzU4oWGu3BF0AmDF9rUEyS+VJ8Fj6Eh7IcWkur5pS6tNrnydWKnqzvo=
X-Gm-Gg: ATEYQzzlII+0XzEM2BoXDpSqITlKbb8uVlRcWQxERES0BmAUkuGdKZ/aLWunTl7CtZO
 /EgjzX0/UVBPhqHCNCtIw4rPLpSXD2K5ufcWMRbpJCBXvWcYBsO8Uh8xPpV7/VVqgUQVBXHOpXv
 lXT53iF/9zhsmVLG5YYGkdO1mx4V3v9J78pRlAkp78MakJWv9z2U7wIp7y1bJt3OipOdzjc94cS
 OyzxLROAOfv5zfu3a2P+JYOYHdfyod10p1Yn4BUTrp+Jtqex8NVGboVYAz6j2w2ptFKRO7762L1
 R5JDFS2udyNmud1MZoYOUMDsqgZJTAaZ7toSr7byYzSbaRbIQdWtrh9SHVq60bN0xQ7vk9im2N/
 4dCp/ry30XZbg5ExddC6u2Y5hv2aKL6bpns+JrP0noUoHqw4MBH88LLPqkAd+QrvwyHkhX9OkjW
 mQmjYb9JTAA2vBXBzOveH/HoNV746Fx+nsbgPgMrdoVctbABSMlnMcIaL7jolGsIrHZ3LeyaTrM
 zW6EwU=
X-Received: by 2002:a17:902:ea08:b0:2aa:e9f0:146c with SMTP id
 d9443c01a7336-2adf79cd7d5mr88533625ad.29.1772227453686; 
 Fri, 27 Feb 2026 13:24:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6ba5eesm67097325ad.68.2026.02.27.13.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:24:13 -0800 (PST)
Message-ID: <f331c8ab-e99a-410f-a1a8-1cd28250d516@linaro.org>
Date: Fri, 27 Feb 2026 13:24:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc-linux-user GDB stub broken
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <5e99783f-6e0b-46f5-80e0-ca5036544a63@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <5e99783f-6e0b-46f5-80e0-ca5036544a63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 2/27/26 9:21 AM, Pierrick Bouvier wrote:
> On 2/27/26 1:58 AM, Philippe Mathieu-Daudé wrote:
>>> The error message is as follows:
>>>         TEST    basic gdbstub support on ppc
>>>       Python Exception <class 'gdb.error'>: Could not fetch register "fpscr"; remote failure reply '14'
>>>       Error occurred in Python: Could not fetch register "fpscr"; remote failure reply '14'
>>>       qemu-ppc: QEMU: Terminated via GDBstub
>>> I've tested from a clean checkout with the following commands:
>>>       ./configure --target-list=ppc-linux-user
>>>       make -j$(nproc) all
>>>       make check-tcg
>>
>> It's odd this config isn't caught by our CI.
>>
> 
> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/multiarch/Makefile.target#L153
> 
> ```
> ifneq ($(GDB),)
> ...
> # gdbstub tests
> ...
> else
> run-gdbstub-%:
> 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst
> -%,,$(TARGET_NAME)) support")
> ```
> 
> Unfortunately, gdb is not installed in any container.
> 
> At least we caught something with this bug, which is great :).
> 
> Regards,
> Pierrick

Alex, is it something you could see to add to existing Dockerfiles?

Thanks,
Pierrick

