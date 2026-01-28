Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF257D35691
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 08:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0j0-00032U-L9; Wed, 28 Jan 2026 03:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0is-0002qI-LB
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:16:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0iq-000777-6f
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:16:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so1382405e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 00:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769588178; x=1770192978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HY7y1TSyrB7uZFLbLDeaz9R5jl+S9qI8IIAZ+EWZZGQ=;
 b=esgOtzuqHwlSiKL2uTI5DeoFSCWh/jg0nNhbtZ/joZk4vH/Vk7xClliqk5Q4xDQTIK
 FEvE0YL5lTJr81SvFFBRTMbdZI8j1tnTN8EzDQvBcA7fLzebpGMH0q1/EG+OzQB6d0l6
 MxWzlfe2Eh1a9YfxYbVORPwtDANzjgXk3NBRHB03OhghzLwvpwpsVKrscrLoOff7kAek
 +YMedFUGQ2Ke4PyaEleHN2J98sO14v/nYHDmYa6ypvgDr+xKs1e0XiQ0qN9iVHQp/k8c
 gxGfqGgT0HI1Pb0MtF6lm/behzmlfCtcuoh/QU7Keyl5YWMWZ+jsgDyIIDMTSrBG+9tR
 kdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769588178; x=1770192978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HY7y1TSyrB7uZFLbLDeaz9R5jl+S9qI8IIAZ+EWZZGQ=;
 b=GJUynqcXhlZCzddgn6S4weiXQd0UngzYX2RYh51ClRT3W7KZLMMrZeMo88pRg5L+ly
 q7FEDbkWzGoHmPqPAkb2wNFZgGAJ+dDyG8RDkRkKVyM7/6rtp1te0zsZCZjbGXE86oIl
 s7nMvZRMd+r6nZ+g5vHpWQP8RrxRSdAFdAJPLXNmKWSzVHepHZJT+6o/F1w2lEfriaLH
 4jyWT3i4f8K/E12hTW+v5uIcplw/GjK4RQagmwobEwqqtsOXUpzwSu1xhuTGxAH7W1qG
 GUP7qsr61qHuJrrcCnQPcgyROnEPvXIqNr7pLPxD1BHt+6GVIH5XRGV/UqzZ/KhpNA4z
 vMeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi7hyXfDmjp9Z5fQT/Ck5EOMt7GMuExDTCHM9YMYL80BETKTkPCKEFo9eGTVv0ylGlfx+FUz+NW+6n@nongnu.org
X-Gm-Message-State: AOJu0Yx9ozeu8kzqd26fCGpt1Zh1wpQfdQjD54aYL3JBoE6Ad9By7eVi
 Ls6HDtKsJ+MwS5fwJQzdRi5xZzolTItPHd3rDe7DISJoAlaNWV+SAsIaNHwkMW6jGw36uHCaYAA
 cl8/ChOU=
X-Gm-Gg: AZuq6aKise8jmsgRC8ERQyB1IQ+pZ1Z0a6vwDXi8So1PaaB5DIVoStm9clHy9NXbJFt
 33wagUcT5j0WTl4oU05aaR+Cu84kyFV7ET9/GoYcx+/sr4z4viAhnHIMil/nwd05D83ABbGOac5
 Oxk4zFUJVJD9HXEoQopsOF/7J58ZJiWK+f476aQEaVChcGFD6n5BdjL1oTz2lJb4XnvrZVAkkht
 zLjR6F+JBRpheDyRbIksiUsYEWF/wus+QCkj+eVfHKZ5fjUzN5/INRIDen3F5wFqJXxmOJH63F9
 IyttBHmxCWbYTAtko23ETkF9eQce1dtjXjLrp/c8yO/GkJ9V40bTqsci64xkKWCWNYz44rWt6S6
 bqOZ59Raqqlb1hb8GJNPmYGYqXa5mpg8yg4I4YJn+8QTO7RR/r5gPPPW6guBbUnHOVMU6AuNQtY
 qrxxMDZzK0hhVCD4p5hiIHcN1HHo/2xLw53sfgtKejloLbjIkBMjRlrA==
X-Received: by 2002:a05:600c:4746:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-48069c32541mr63465285e9.13.1769588178544; 
 Wed, 28 Jan 2026 00:16:18 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm112738765e9.13.2026.01.28.00.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 00:16:18 -0800 (PST)
Message-ID: <7a550ebd-bf5b-4e86-b2fd-5f13ddb156a4@linaro.org>
Date: Wed, 28 Jan 2026 09:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtl8139: Remove ineffective parameter
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260127173849.588F25969F0@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260127173849.588F25969F0@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/1/26 18:38, BALATON Zoltan wrote:
> The do_interrupt parameter for rtl8139_do_receive was originally added
> in commit 6cadb320c7 to avoid generating interrupt when receiving in
> loopback mode. Later commit 5311fb805a changed this so that this
> parameter became ineffective and now this parameter is unused and
> always 1. If this turns out to be a problem maybe there's a better way
> to fix this so remove the do_interrupt parameter for now to simplify
> code.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/net/rtl8139.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

