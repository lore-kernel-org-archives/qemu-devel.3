Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666CE6E7EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDth-0002JU-5M; Tue, 03 Feb 2026 05:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDtf-0002J7-FU
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:44:39 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDtd-000189-Ru
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:44:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so5061913f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770115476; x=1770720276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uqHxjMKQFiFwAp+J9hLm6aYQUNltmNCjBpxKauKcqTA=;
 b=GjbywmL0Vd0/J9xqsoLWNuA3WrJrD0Jyz0/mDyiUpzylTChQCrTji5X5YXVrcTcDTn
 kJOaC6g6XpfeXHdPS5zvzEdvPF9ngrGNSW+kwxecdi7F9uu5mLq+Mn5e78xxnNlMCoin
 /SIkxwgOb+ot6JeWA/SZWLdcE1KPNkXy4RZeXZGmoAemjZBMlUqAUNeQJeX/fE2Z5lws
 r+tP7EbVXoP/heFWYITbq2glfCEfd9uq5ZUdvoxDvwtOBr5e/saPRh/t4IMPRK0mjel6
 LnFiC0LtkZyAyXi2pcYqheC8wPdJfH7wHKWJQ7f4NtqoblWjzBlwpetchVt5xzQFjEdW
 u3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770115476; x=1770720276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqHxjMKQFiFwAp+J9hLm6aYQUNltmNCjBpxKauKcqTA=;
 b=pX+PDAogPnBguAIx9pLZ0NGh2X3l17V7FhuP0VOE1naXgXECf8ddZjK+aU+v0zDOY5
 AJ+oRuwUNfhC3lO0+F64hxubkVgEuvLCOFCTVy5guwzBmVbiAa8RbiPvn0p89lBh5tVI
 qr3avEe/q68hKTUwuL+q66cFMxAGaaXOdr3nz2/qq5BatA+PON+OET7KClRsisXS+V93
 5iLIbHRhC17Gg4HMd/WrRmm8EiLN7K9NxTKA09vo0IVKD8GouCMSIKJD2Qu/ywmL19p6
 qkuHusJoirUnuYxc++4E5dhLDX3S7+GRi9wGwBNVTsqzcTEm79z6TQnZh1HxO5TJR51b
 TIrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZooPUmOBDuPhVtOYYgZkHm+NWfJQevOV1uZufeXOJHVvVWHv+4hImzo8zxYsjPd4T1MckjLf5rId@nongnu.org
X-Gm-Message-State: AOJu0YwiKIG/1pD6tIDozTAk+i7piMQ0Xcfhaei8ZvMvb8+k1bukrXMO
 AkCwEnkMbRdbiQTg38wPxLlitKL9B3pHL2FyJ3UUFRjrTDcVxBJbdShmNTY2qn0q9wc=
X-Gm-Gg: AZuq6aLMDq60i26MdFMfpEJHXranrwIpsyqFc6Vv6lsjUclMpVDjunBWILLoRkfLMva
 HXI+IWQFgCSAkcVduRPKb4DGV0a8rvF7brYz11bI9btpv15Vp2xb0YDy+3RulJu2W+gOsXFuRrs
 3/maxl2DzzLxm4mWt81qhuYAQld695o2bWBCYaivWHVUXD04N2JG30XqeWqe7qwoBsS5Z9f1vD7
 fk7sHXWZSetFEOzh4RDrAf5eSwIGFdc0oDQ3G+Q92IZmujyO+SAFaEKL/DSmJUhvQeAsNzHahza
 dqpnKVFzSGDWTee4Fo6+ouh+yL5Is1WOKlgjbWXjojkFAujomkAEQqX0Kpl+QrM6FskZgs8CUu1
 7KljCWliIXZwSOnSQCuPt3boNkToXbR0AAKoXBAB9+Ewr6JvvwKI5Vph4i0p/HLW7WCM1m3MKGl
 xvJ0yQUaHwlwi/geRSVeYhFFB9Yz47lyV5yllz33FPYp2OkvJid2FUWQ==
X-Received: by 2002:a05:6000:18a8:b0:435:9a50:bbb4 with SMTP id
 ffacd0b85a97d-435f3abb517mr19878391f8f.59.1770115475885; 
 Tue, 03 Feb 2026 02:44:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm51413156f8f.36.2026.02.03.02.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 02:44:35 -0800 (PST)
Message-ID: <92098ac5-9d77-4067-94fa-6395ef419925@linaro.org>
Date: Tue, 3 Feb 2026 11:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
 <20260202024316-mutt-send-email-mst@kernel.org>
 <87bji7pa2e.fsf@draig.linaro.org>
 <20260202105847-mutt-send-email-mst@kernel.org>
 <20260202185233.GC405548@fedora>
 <1c0fc67a-1ded-4200-b9d0-e20a06cb5b4b@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1c0fc67a-1ded-4200-b9d0-e20a06cb5b4b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 2/2/26 20:25, Pierrick Bouvier wrote:

> My initial testing showed a 50% slow down, which was more than 
> surprising. After profiling, the extra time is spent here:
> https://github.com/qemu/qemu/ 
> blob/587f4a1805c83a4e1d59dd43cb14e0a834843d1d/target-info.c#L30
> 
> When we merged target-info, there have been several versions over a long 
> time, and I was 100% sure we were updating the target_info structure, 
> instead of reparsing the target_name every time. Unfortunately, that's 
> not the case. I'll fix that.

We (Richard, you, myself) knew this patch was bad performance wise, but
back then it was decided to be good enough for the first conversion of
build-time target specific definitions to runtime methods.

As a second step, Richard asked for the target-info.c file to get
absorbed with page-vary-common.c, compiling it with CFLAG=-fno-lto.
This wasn't a priority until TargetInfo API got involved in hot path.

