Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F8C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjv6-0000Ip-Dd; Wed, 07 May 2025 14:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCjv4-0000Ic-Lm
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:55:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCjv2-0005t0-Vq
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:55:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so409578b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746644099; x=1747248899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IacWndUOkI5TB6QaH0d6nRN/cvG4xaq881JfTh/w1bE=;
 b=fZiFFXmOpmLhSa6kdnxoTQfGxGUScHOdxTTOySMQCRGdRGzgm2qP71MrjYC0viVYxp
 8M479fdW87U8f5ELKG54JyRdyZZTXXOOKvpXHX3NwIPrpVrLBpIXhXCCJRTuGpKy2wFh
 WykAVpHNlRt5RmcHqAgnm6VghABDfl+fk4OfPbIA/lGSeMP3KBd+yw+9ixCcSgUJhIs9
 GAG4VCN7ZXQ/3vGZtQrpZC/UWhO+U6xRN8HRoUA7nBHR30Kwxl8duLaWVrkRd2FlSikO
 1L1pymX64B1BYztz4JpQtmii3sU7Xr4EmLU+3zkksM4f21gZ94iLBzXNhObxwr4swKpR
 XaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746644099; x=1747248899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IacWndUOkI5TB6QaH0d6nRN/cvG4xaq881JfTh/w1bE=;
 b=Gw7JZGCTssl3ggerbz/6l2kxY6PDiVXLPd7uMpMWwi/ZldFEIO7+ei9Ad+gy+zyho4
 WkK4VB2u4sWzIz3aip7cr6AeUYyNdKu6EyPe6X45k6c4tEuEv8batIqA6yv/N5mPSYW6
 h683hp9Dzp4Jx0H1ZbABef7ehETYZFcJX9keC5yY0UQi1f9XbEb1RBwn3Y+/eN/0VVkH
 5FRgGmB9kW/L0D3m3BV7i8yZB2VVuC3HDsQE8UPXYGskkFFYxOYio5c86SAB1u3ZPTdY
 d1Ex87COFcb+/tpT6lX4+dV4Cn2k9rmt0/vv8XsP3R0pqE4hPI1l4r4kjtQkhvEoOcrH
 6q1A==
X-Gm-Message-State: AOJu0YxhgUCnJfqc5FroRCn0Dgtc+i0BD4zenA+O2Raxb18j3lQI7mlk
 UEY2mm9dzv9ucs0jEA+tIieB86Je+C/1Hp9poFJEOhiGiUoswd98+RiZxF/J008=
X-Gm-Gg: ASbGncsnK5AWaumzQUgBbAaoOdLMZA5qBCcgrnFL8AxvYjRjaTq2c3zAbXCbh8qD3Lt
 uMrW+QICV1NvQuFTgWVRlLhMvmCqtth/3jacIak4rNYM3oXep0vtnMJUOJw3Tlr9v2FO8nvR5pW
 A1LgGaBotIHWEvVM3EXuC3ET0ri1KyNtE5pbV+z7MU69Dwnsav/Okf+PBfrBpjkMcH0eB93ZMF2
 E0Gw+0VUAa0RYKiKogpd7Ee5OSctfXNBB3ZQNP2NN2xgwXirucfAdc7eB9pF3DkND7bLEpaPwnu
 nmjkn6iYzumxElhEkIDpXRQA1APlIIxEv4aDEBDLntjjsBMmRTgixA==
X-Google-Smtp-Source: AGHT+IFU/LqN5lKQiutif7QZsj2f39F/UO2YyyPfZKyWFzuN6xvsjQ1aJhpUwpUNgH3Nsbe/iLHBEQ==
X-Received: by 2002:a05:6a00:e84:b0:736:5664:53f3 with SMTP id
 d2e1a72fcca58-7409cfd500amr5378762b3a.15.1746644099436; 
 Wed, 07 May 2025 11:54:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920e67sm9930552a12.7.2025.05.07.11.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 11:54:58 -0700 (PDT)
Message-ID: <273a6cc7-9123-4b9a-8934-ed9b668bf130@linaro.org>
Date: Wed, 7 May 2025 11:54:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, devel@lists.libvirt.org,
 Victor Toso <victortoso@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org>
 <f2972cb4-4266-4835-9548-706983dc611f@linaro.org>
 <87msbokg7y.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87msbokg7y.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/7/25 12:55 AM, Markus Armbruster wrote:

[...]

>> - First, it's already broken because we rely on ifdef that won't be
>> there in Rust or Go.
> 
> I don't think it's broken.  QAPI 'if' translates straightforwardly to C
> #if, but that doesn't mean it cannot be translated to conditional
> compilation / metaprogramming in other languages.
> 
> In fact, the value of 'if' used to be C constant expressions suitable
> for use with #if, and we changed it to its current form specifically to
> enable Rust work, in merge commit c83fcfaf8a5.  Marc-André's was trying
> to develop Rust bindings back then, and if I remember correctly this
> change was enough to let him implement 'if' with Rust.
>

Sure, I didn't mean "this approach is doomed", simply that it needs 
changes, the same way code doing a runtime check would need changes as well.

>> - Second, it's code, we can just change it later if needed.
> 
> True!
> 
>> - Third, those json are consumed only by QEMU (right?), so we are free
>> to write/modify them as we want.
> 
> Also true.
> 
>> The only thing that must stay the same is what we expose to the consumer
>> in the schema, and which commands we expose in qemu.
> 
> We may evolve the external interface as long as we honor our
> compatibility promise.
> 
> You're aiming for "no change at all" there.  I understand why that's
> desirable.  But if it should turn out that a bit of compatible change
> simplifies the job, we can take the simpler route.
>

I have a local prototype doing what was described: introduce a 
runtime_if, additional to if (no worries, the name can be changed 
later), exposing schema parts conditionnally, and same for visiting 
types and registering commands.
It's not too ugly, and easy to combine compilation if and runtime if 
together.

I should be able to post it next week.

> [...]
> 

Regards,
Pierrick.

