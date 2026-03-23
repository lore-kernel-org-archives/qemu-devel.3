Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCAD58CC0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 02:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Ueg-0001b9-RO; Sun, 22 Mar 2026 22:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4Ued-0001aj-Tk
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 22:04:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4Uea-0007xo-6z
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 22:04:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b061b6cf36so17660775ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2026 19:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774231456; x=1774836256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZeCI6p1Rj/ifWOaQd0kSPn/flQUglTbsikVuvFRtAM=;
 b=AQvmEbBDOARbQFXSYSAUOJcuvaeyMmN617c2cz0sxHhYARP6cZViIWTEdVs+ZZqI4b
 n1Wkws6Ms87WeZjKdi6Hdmgsik37WNTKRhwApAgFpSLGd40MU2uOnH8M9UrVt2ITaGOG
 0vWn4iDdNWBY2Ok78crCJlMZqPWDs00C3yb5hmlbk2WwKusWRMxla3rsAJFY0bMom4PI
 o7DUIaw19bf0vAiw5cu6EZzLU/gG6Bno/NR8P3ov0dJ5ky6hZsgC1xxNEi61ifGWfi+F
 tghYf3mYvS3AR5aRyqw3Q8KjhVdYakHa134UNRtKQkBEssr+ueyagBbnL+HxR4/s8vZj
 UlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774231456; x=1774836256;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZeCI6p1Rj/ifWOaQd0kSPn/flQUglTbsikVuvFRtAM=;
 b=PK3VlQgGpKieg6Q+zAPUjzCuE0brTkDgsqvBxlTdyin8Am8gV2O34bal6gKqB6bzOb
 M/HS1o5HpSWs+kVfV5YQ0NdNDIx3Zg39+d012L1Vj1b9ZVuYEizyojYLHRKIfwmJCPvd
 heXTxF4QSyVWVbGLPqSHgmr3do4wAh03oQAB5CX31eZ64iQlVnAOaPyKWPIjirBBr/aa
 ZyK4cqOSRc+7tree/yYV7odfVa8SXtwA6/bcXdM07DdctfE55NEiBObyKhcHRgVl1ddr
 OECdVTGp0tzrovsDjsnxTZzLItXHbqFVy2LI/L5Nd28nMpq8Twt6taaFiMZHTZFZptW6
 tvMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5MCDWvBhezji895m2R+UBe9ciUj366m3Z3CqIxVLzl1d+aRvUC0VSeSRiINTws84j7rXTKg1Qx92o@nongnu.org
X-Gm-Message-State: AOJu0YyaZAUhe273/UTYO48sB2spAgrHKBzz8evoMu2IlGLzQ6oll4fL
 MoFFIrdWKoXtVC9AR43pjMQZra2X8TacuwLIJn32KHSzfidpc88hPwPHJzENDy8TJug=
X-Gm-Gg: ATEYQzx1y9I3m6DWy4Gw7qsfgbmNRD0gAc4wVUMsQRjOA+vo++CdqrzLUjuxufD9fvL
 VoZCQorNpYnu3Hgii05UFqQanngahiQ75kek038QGlvTnmHCTbQFKwHa3J9qoHT+LbN/edPVgv8
 3wgtR8SByBi3hAW26qKLXz5EmX+PLlvtOiDspqCr4RddvM9bLrwsxfusioxkNOKM92kF6P6dpo7
 R7wnNovExLqH11FES+TgnxwYyZvAc1s5cIp+dOAkTeDPS4WC7lHDkeydiN2ctuS6JMWEKkhrX1g
 wEkibhmspfUEwB9xGMYgBiRPsk5yYWi1RZLvznMjEGa5awdEijKOtN6LKroO3NuqmUQNM4EkUJK
 DKA/bz0j6Ac8GptS8HaxOA4pSxkexJvGhYQIxMlRf766o3uwDNAILulx5D8ForXigWfuqv84AD6
 GivBq+Jf6i6hyqXj5LVDAI8l/gizEmrijcR+a6jsTwd/4u6tkxHwr0mNAMHg8IMQYO5K0t
X-Received: by 2002:a17:903:191:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2b0826feb3dmr104925965ad.15.1774231456194; 
 Sun, 22 Mar 2026 19:04:16 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083688ca4sm116198715ad.67.2026.03.22.19.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2026 19:04:15 -0700 (PDT)
Message-ID: <c8536f00-efbc-441a-8725-bfe80aa8666c@linaro.org>
Date: Sun, 22 Mar 2026 19:04:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251112134143.27194-1-philmd@linaro.org>
 <0faef1dc-6fde-41b1-bf1e-8ecfe49033f7@tls.msk.ru>
 <a50b8ccb-4d13-431b-836e-b08e5add71bd@linaro.org>
 <95e61064-c8e8-4c36-9371-cbd28ab737c8@tls.msk.ru>
 <17f7b53d-dbb7-4090-a6ac-671c85dd611d@linaro.org>
 <8ca786b1-765b-4dc4-92fd-6ba6aeedf098@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <8ca786b1-765b-4dc4-92fd-6ba6aeedf098@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/21/26 11:15 PM, Michael Tokarev wrote:
> On 12.02.2026 23:13, Philippe Mathieu-Daudé wrote:
> 
>>>>>   From this patchset, 1 change has now found its way to the master
>>>>> branch:
>>>>>
>>>>>    chardev/char-pty: Do not ignore chr_write() failures
>>>>>
>>>>> Besides it, the following 2 changes were marked for-stable:
>>>>>
>>>>>    chardev/char: Allow partial writes in qemu_chr_write()
>>>>>    chardev/char: Preserve %errno in qemu_chr_write()
>>>>>
>>>>> Are other changes (including the above 2) not needed anymore?
>>>>
>>>> They are, I need to reply to Marc-André and respin a v4...
>>>>
>>>> Old bugs so can wait 11.0 :S
>>>
>>> Found an old(ish) thread...  ping? :))
>>
>> Cc'ing new docs/ maintainer :P
> 
> Ping *N?  11.0 is almost out already..
> 
> /mjt

I didn't answer previously, since it was touching code in addition to 
docs, and was expecting this to be picked up by chardev maintainer 
(Marc-André in this case if I'm right). So I assumed it fell back to a 
subsystem documentation change and not a general one I was supposed to take.

Regards,
Pierrick

