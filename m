Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B19C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzeTI-00027I-JP; Wed, 24 Apr 2024 11:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzeTG-000278-KC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:23:42 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzeTE-0003Ii-Dz
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:23:42 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c844b6edbbso17407b6e.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713972219; x=1714577019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=/2cC6DzRzgBjH4Px9PozCQEgy3u7XZ3utspb0XVYfN0=;
 b=lQUGBPgzWSE+vlZglYbseyeuGlRrwRiTe5d5qHAKcCK/LdMMV1pHGsvy4+GV7UJ87O
 x0vdPEy8vgPYGrRdUCN/Hk8tDuu1d+J9e5mOhRzw3aAV7jVJmE4ReZFMl6BBguTrif9J
 FcZdyxwCcPC4KBIivvxFuUPa+8qpZPOj1VEmOpJVzDUcUTvPbQguFKNBfqEUv//nm6RS
 mYytqWTL6I6bSxcYOf287ze25khKpLSzrS21qiU6fP575+poan03q4hoNkvI0aOu8N7V
 OsPVi0jliVd/zZHSlgm5SphmTcHgwBreMWIzqTtlEGkD1PS9JR4zOj/Q30v1kfI4ZlUa
 PPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713972219; x=1714577019;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2cC6DzRzgBjH4Px9PozCQEgy3u7XZ3utspb0XVYfN0=;
 b=lVFzO4bnB2pglSJKS9nbbHbXp1eJS02v396wuMQ2EAer6NhzYY9st4Q8qqXfIcjQiY
 3Hfq1EbZlKFNyChBeOCyR3SlyVAfupvAPVni//ZVyTyH4OajmVTQkqNbkOBzuDEyHkE2
 sSDJAC4iK/xDgPM2OMo8Rda9vn7BGQwcYd14i5Ws3W37W+yLMl+wAUJRxViQVX/J+PHA
 EZ9DWQXu3FfVjHAlsUnaRl5AqgUZOooT9MGLeuItNOZdtZknfCTeJEKR/P8Tx4mWTUJJ
 Q9oUufxplUaMVWbru1/vDFNkmlw3fefMN6yWzTShD/xzyBsyJ3WuVVeLan21wmDmCpTm
 xzAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhh/4paBtZk5yYC5jxZdG+ycnWrp+9EY7REgoTBLvJA9pAKJMIb+kBTeyH2fbWPb2FptTHPCRaCwmAMpea+tL7d18rA+w=
X-Gm-Message-State: AOJu0YyDexSFaRES3mgiCeDhJCEVdPhLeLv7Yvyi8PwfvCCHbJQIyf4N
 QreWwiv2WbVmflZYteuC2JZLRBihARoJNXSfPXnQL6E1KelovToj
X-Google-Smtp-Source: AGHT+IFVPV1iR2LhAVfCMQQInXysIkKQV9dpnfivNpOKqBpaOh70aoFAwNjNId8gXMdYbqulzBJOjg==
X-Received: by 2002:a05:6870:3052:b0:22e:cdf5:40b6 with SMTP id
 u18-20020a056870305200b0022ecdf540b6mr2886834oau.14.1713972218990; 
 Wed, 24 Apr 2024 08:23:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 gx9-20020a056a001e0900b006eb3c2bde43sm11519540pfb.205.2024.04.24.08.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 08:23:38 -0700 (PDT)
Message-ID: <b815670f-fea4-4ab5-bf67-671c8395bfa6@roeck-us.net>
Date: Wed, 24 Apr 2024 08:23:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems (timeouts) when testing usb-ohci with qemu
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 qemu-devel@nongnu.org
References: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
 <edfmff7qm46edap6nz2ppvfhcw4jp6ahjltrv76jsiq5rhz5hw@v2lcbclpdsjt>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <edfmff7qm46edap6nz2ppvfhcw4jp6ahjltrv76jsiq5rhz5hw@v2lcbclpdsjt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=groeck7@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/24/24 04:16, Gerd Hoffmann wrote:
>> qemu hack:
>>
>>   hw/usb/hcd-ohci.c | 11 +++++++++++
>>   hw/usb/hcd-ohci.h |  1 +
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
>> index fc8fc91a1d..99e52ad13a 100644
>> --- a/hw/usb/hcd-ohci.c
>> +++ b/hw/usb/hcd-ohci.c
>> @@ -267,6 +267,10 @@ static inline void ohci_intr_update(OHCIState *ohci)
>>           (ohci->intr_status & ohci->intr))
>>           level = 1;
>>   
>> +    if (level && ohci->level)
>> +        qemu_set_irq(ohci->irq, 0);
>> +
>> +    ohci->level = level;
>>       qemu_set_irq(ohci->irq, level);
>>   }
>>   
>> diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
>> index e1827227ac..6f82e72bd9 100644
>> --- a/hw/usb/hcd-ohci.h
>> +++ b/hw/usb/hcd-ohci.h
>> @@ -52,6 +52,7 @@ struct OHCIState {
>>       uint32_t ctl, status;
>>       uint32_t intr_status;
>>       uint32_t intr;
>> +    int level;
>>   
>>       /* memory pointer partition */
>>       uint32_t hcca;
> 
> Phew.  Disclaimer: Havn't looked at the ohci emulation code for years.
> 
> It should not be needed to store the interrupt level that way.  It is
> possible to calculate what the interrupt level should be, based on the
> interrupt status register and the interrupt mask register, and the code
> above seems to do exactly that (the "ohci->intr_status & ohci->intr"
> bit).
> 

You are correct. For the purpose of this kludge a simpler
+	qemu_set_irq(ohci->irq, 0);
	qemu_set_irq(ohci->irq, level);

would have been sufficient. My original code added tracing,
where this generated a lot of noise. I didn't completely simplify
the kludge. Sorry for that and for any confusion it may have caused.

> ohci_intr_update() must be called if one of these two registers changes,
> i.e. if the guest changes the mask, if the guest acks an IRQ by clearing
> an status bit, if the device raises an IRQ by setting an status bit.
> Might be the ohci emulation has a bug here.
> 
> Another possible trouble spot is that the timing behavior is different
> on virtual vs. physical hardware.  Specifically with the emulated
> hardware some actions appear to complete instantly (when the vmexit to
> handle the mmio register write returns it's finished already), which
> will never complete that quickly on physical hardware.  So drivers can
> have race conditions which only trigger on virtual hardware.  The error
> pattern you are describing sounds like this could be the case here.
> 

I think the underlying problem is that both the qemu emulation and
the Linux kernel driver expect that the interrupt is level triggered.
It looks like some entity in between handles the interrupts as edge
triggered. This makes the kludge necessary: All it does is to generate
an artificial interrupt edge.

This can be worked around in the Linux interrupt handler by checking
if another interrupt arrived while the original interrupt was handled.
This will ensure that all interrupts are handled and cleared when the
handler exits, and that a later arriving interrupt will generate the
necessary edge and thus another interrupt. That doesn't fix the
edge<->level triggered interrupt confusion (if that is indeed the root
cause of the problem), but it does address its consequences.

If anyone has an idea how to find out where the interrupt confusion
happens, please let me know, and I'll be happy to do some more testing.
I am quite curious myself, and it would make sense to solve the problem
at its root.

Thanks,
Guenter


