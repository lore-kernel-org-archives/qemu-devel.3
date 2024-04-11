Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AA4CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruqtZ-00043h-O7; Thu, 11 Apr 2024 05:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruqtT-00043G-V0
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:38:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruqtP-0001gl-MF
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:38:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-343b92e54f5so5541869f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712828325; x=1713433125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fM9cGvwNHjTApymx2jsNglNkNKdGfduqVDjhU9Bvhw=;
 b=ZlkoOL0li5nw+9MLSWDiMjpD2wDm0fr3gYhN9G69pgb9jOqvCp0QdbD/cEo86f+vc4
 /TOo2oNp479yxjcCC+YOyyGvnemT2C4DndlHsubQLGZ3bpEgUSJst49rL6Ue8N36XlzS
 GdsFK0eTCkIoX5xvJuWintmm+tY0dywY6eSAuoatvmTxmYKMomyYgWhhwa0hMffqn9Cw
 cY8LC0/mzhADHw5fsLUaWHuV/Sww6NS0ZMYBaXIOCbE7r1gs57P/Wu3cq81ZVfeA8+qC
 xO9CXAg0ZpGwDMye0qrt76c8Hi4t+cOGI7vpoBnx7Hxc4loqQEvheNlHvnRSSmLOe45E
 b9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712828325; x=1713433125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fM9cGvwNHjTApymx2jsNglNkNKdGfduqVDjhU9Bvhw=;
 b=UOyYRuqWZHV4+LQvjcWMjllOOkKnUkEFPb9STZ/0BBNiOPVmxj5q9/yUOZrvVZISoo
 mOrQ/pl20qywmzWyVbrNdDclqAH2kS4iFMjnrsgiYkuAKnZSUpex4VZzIyZZcNc24Inv
 1B3BqBtF6W9L5elM0d6ejBAbnlVH631oi5V9Pm/LqUXkvNc0VEvvvkHEeXcXeIT2t/T0
 uYQW8W0CTcFVlHjfxNS4mdPvxR90R4Z7VPJit5QcCYvHudNk13Q/59LoaweU8007eW2T
 WnyVdp8ThcujyWwxmTcoq36EaAKPVYM0ZYe1U9dPu0UFpLiEhmph2JUx5iywiwpwTmTi
 NqNg==
X-Gm-Message-State: AOJu0YybNknYVafdrx6jN5OI68EaFfoa5CWqreEBkNSZ6ZeUg+assCoC
 h4OqHa5bG8W9I5SwGvFPaMMT4pK7baM/shS8kcsKjnVpihblKwPXTymU10EjuZ8=
X-Google-Smtp-Source: AGHT+IGmgXHhfflvf0dubM3y4Nv+twYLjm6a5XwL5rW7Zuc9wvRyiAcb9ryQprRl55G+uECrJQTGZQ==
X-Received: by 2002:adf:fe44:0:b0:33e:6f9b:7abc with SMTP id
 m4-20020adffe44000000b0033e6f9b7abcmr3072525wrs.65.1712828325341; 
 Thu, 11 Apr 2024 02:38:45 -0700 (PDT)
Received: from [192.168.202.175] (137.red-88-29-174.dynamicip.rima-tde.net.
 [88.29.174.137]) by smtp.gmail.com with ESMTPSA id
 h18-20020a5d4312000000b003455e5d2569sm1395827wrq.0.2024.04.11.02.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 02:38:44 -0700 (PDT)
Message-ID: <1c6cc7f0-a0c7-43c1-aadd-d4c8d76354d2@linaro.org>
Date: Thu, 11 Apr 2024 11:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] misc: Remove sprintf() due to macOS deprecation
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
References: <20240410160614.90627-1-philmd@linaro.org>
 <c4c8f2b8-7ef2-4b2f-a9d4-8c1e64668570@linaro.org>
 <220fddca-0017-79c9-ec1f-23bb8a68728c@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <220fddca-0017-79c9-ec1f-23bb8a68728c@eik.bme.hu>
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

On 11/4/24 00:27, BALATON Zoltan wrote:
> On Wed, 10 Apr 2024, Richard Henderson wrote:
>> On 4/10/24 06:06, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
>>> resulting in painful developper experience.
>>
>> Is snprintf also deprecated?
>> It might be easier to convert some of these fixed buffer cases that 
>> way, if allowed.
> 
> I had the same thought as some of these might also have performance 
> implications (although most of them are in rarely called places).

I thought GLib/GString was recommended for formatting (IIRC some
previous discussion with Alex / Daniel), so I switched to this
API for style, rather than thinking of performance. Anyway, I'll
respin using sprintf() when the buffer size maths are already done.

> 
> Regards,
> BALATON Zoltan


