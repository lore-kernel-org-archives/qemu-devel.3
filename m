Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7BD29C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuIA-0008SH-6M; Mon, 19 Jan 2026 13:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhuI7-0008NR-8U
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:47:55 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhuI5-00056C-4S
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:47:54 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so28126765ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768848471; x=1769453271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=G4Z0lqQqCG6tHaLjRbjX21l1TMmH8spZYbY3FxOPm5Y=;
 b=PEd/wVyuY9/2PKRUcfwF8vQ6Tf5nSdHu+YhNtteY61Stcweib7kyth4CA6oExMu0q0
 Fb0h0VWHSbB23/KA7zw2WE6dCRPsy8MV+SafPMNYJ/IhyzTtw/6Qbs9YgQs7zUA7KTHU
 ZbPY2cz4k88UXSWxL4SuQsCdvuD9rcyUM2zEhFlajZcWWTxAmdlo30fkdHF5pgFPdeuh
 spkBPOPbLY6Q97b4cz8kiRw/gRaORkbyDJPCQPFgqp/A8n2fKGuX64wWpDeVaWArKh6P
 LNSY1pOSn+79vQA1H+Gp3eJTAXrjJMgMPirsTGiU750KVgNRfXXhtsjM5bMH4YY203ph
 iTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768848471; x=1769453271;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4Z0lqQqCG6tHaLjRbjX21l1TMmH8spZYbY3FxOPm5Y=;
 b=RDZC4jr6dAswjz21wiaVdDtkUEZ53eCQvIJSl0y/N/6H8XsTAImcpg7cZmuUIrs5Nv
 sbi6ypi5lCHJjROoX/JKYcfA9VtXJwR0Ru2WWQLIauV76FkU6bjuogvmXstn4mhR5acV
 toOFzZ5cgYYIC77aEZAce/oZN6HA5K7JZOMrk1+NFB9YwDV6hktrVsvr3w9I9MpkUePQ
 fXvTqasnEEE3YgCRpD+EiQ2OdZ5xhvSCST86z/7efObstkGPhIKivn5EK66LjD3wSTlM
 yKGdRHe9YrZT5sPwmBO9uNDMAUWcRH5FxEFaW9ZOIzf7DaKLRJQS4hBq0yh/igx7vB8A
 pODw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDyULac/1Ac0+uW5zK+N3OYGMCTzUddtwXZ7mYZBWqYzFptwr8haR09O9bTCKypAHr6myQeRDviaiQ@nongnu.org
X-Gm-Message-State: AOJu0Yz4hzHCGY0k8kqRn6KYBnSH9EfJAViJONGn51jNaiV47So/KCxr
 99GVyekhF+FNhiqk8ex8+xQNfoKfNNubKYi3WRGRYbnd3ZM+lxD59GuZN2Lys0RaSXk=
X-Gm-Gg: AZuq6aK+pU3fBsl12xUYJZ6FXYcF5Ir6bR4F5tUVFzLMGaxZOrowKKdSvZqIdKnFQxL
 13RPJOMZnSaM/ddoolv3lQYQUWh4LH4yejpDpC1soXsUnXB2weCUDkEx3dTNuOUWZCTpKWRyaup
 RD0khlCzo9FFb94LdhTre291aVG7zs6ZhAEmur0zQUzDuE8/lH+SimC2M9g+Rbmk1ZEcf7KNcc6
 EONo0VilBYOjdXhvX3GQH3PmVDI0hSyEnZ8WEQKdoP9WSNT9v9Ak8mDuzqurCF//NSK/qoA7Z3u
 9I5v6eZFVWLWPxTOFOyj1EMPrMQDv9+9hBbgXgx9BmTPZn0SrHxp7HAKx4G0TFu/nbavSRhc1bB
 hTC5DvvFLSiyaC6tpAw7vY6igp7LpoadbiPuZh1IH71SF2RrQvvT2qV4X2ZenOEHzv1hCx+Wm0E
 ttAd0PELz6cUZcqkLSypp76KORrRGMc4nsAqF81WKc4ZCnM/x76UEB7xh4znMBoUkrKx4=
X-Received: by 2002:a17:902:ef0a:b0:298:639b:a64f with SMTP id
 d9443c01a7336-2a71754671fmr122722105ad.6.1768848470618; 
 Mon, 19 Jan 2026 10:47:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm46702005ad.89.2026.01.19.10.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 10:47:49 -0800 (PST)
Message-ID: <b33bfa26-5f41-4bad-9911-37d0b58618dd@linaro.org>
Date: Mon, 19 Jan 2026 10:47:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
 <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
 <467c2bca-af39-4e00-b8ea-9e38c1f16e54@linaro.org>
 <dce4a763-d64a-4ef3-be05-9c24080c8003@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <dce4a763-d64a-4ef3-be05-9c24080c8003@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/19/26 12:19 AM, Thomas Huth wrote:
> On 16/01/2026 19.31, Pierrick Bouvier wrote:
>> On 1/15/26 11:17 PM, Thomas Huth wrote:
>>> On 15/01/2026 21.35, Pierrick Bouvier wrote:
>>>> I would like to help maintaining qemu documentation and I've been
>>>> invited by Alex to apply as maintainer.
>>>>
>>>> Files in docs/ that are already maintained will continue to be under
>>>> their respective maintainer. The goal here is to have someone that can
>>>> help on all other files that don't have an official maintainer.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     MAINTAINERS | 5 +++++
>>>>     1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 4ddbfba9f01..786f3b3a456 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -4505,6 +4505,11 @@ Incompatible changes
>>>>     R: devel@lists.libvirt.org
>>>>     F: docs/about/deprecated.rst
>>>> +General Documentation
>>>> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> +S: Maintained
>>>> +F: docs/
>>>
>>> You might trigger a lot of traffic to your inbox that way ... but if you
>>> don't mind:
>>>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>>
>>
>> Reading about your answer, I was thinking it would be nice one day to
>> organize a BoF about everyone personal email workflow.
>> I feel like every dev has a different way to deal with this, and even though
>> it seems basic ("Who would seriously ask advice about how to deal with
>> emails?"), it's much more complex than what you can expect in the beginning.
>>
>> Hopefully, my workflow and my email client are ready to take it now.
> 
> Since you've asked for it, here are some of my thoughts:
> 
> I don't think it is e.g. hard to filter for e-mails that have "docs/" in the
> subject, so that's certainly not a problem. It's getting tricky for huge
> series that e.g. have just one little change to the docs folder in between.
> Some people will CC: the whole big series to you for that little change in
> one of the patches - how do you filter for such series?
> 
> Having maintained a generic subsystem with a catch-all entry in the past (I
> used to be the maintainer of the qtests, and we had a "F: tests/qtest/"
> entry in MAINTAINERS for this), I often got CC:-ed on big patch series that
> should rather go through the architecture maintainer's tree, and since only
> single patches affected the qtest subsystem, this was hard to filter, so I
> always got lots of unrelated patches in my Inbox in which I was not really
> interested in.
> 
> My mitigation was to add some "X:" lines to the qtest section in MAINTAINERS
> ... but if someone has some better ideas how to deal with such situations
> (e.g. if there are some clever ways to filter such series out of your
> Inbox), I'd be grateful to hear about them!
> 
> FWIW, for the functional testing framework, I organized the entry in
> MAINTAINERS differently, there is no generic "F: tests/functional/" line in
> the section, but rather only coverage for the shared files of the framework
> ... the tests themselves should be covered by the individual maintainers
> instead. This works much better for me there.
> 
> So I'm interested to know how the generic "F: docs/" entry will work out for
> you once this patch got merged and some weeks have passed. Having a BoF at
> the next KVM forum about this email workflow topic might be a good idea, indeed.
> 
>    Thomas
> 

I really appreciate you took the time to share that and your experience 
on the topic. The "exclusion" based approach you use is definitely a 
good option in case I get notified with too many series.

I tend to see series as an atomic change, expecting them to be pulled as 
a whole. Thus, I expect, maybe wrongly, that isolated doc patches will 
be pulled with the concerned series.

For my workflow, I use a single qemu-devel folder, with a few additional 
mechanics to follow threads:
- emails where I'm a direct cc/to are starred (Imap \Flagged keyword)
- use tags (imap keywords) for series: to review, personal, to follow up
- keep cover letter unread as long as there is an action to do on this 
thread
- mark as read all the rest so it can disappear quickly

Order of series in my client are:
[tag - to review]
[tag - personal (my series)]
[tag - follow up (was reviewed or is interesting)]
[untagged series where I'm a direct cc/to]
[all the rest]

This way, top series are the one followed, and all the bottom ones are 
the new ones, and I can focus on the "starred" ones to identify quickly 
content that concerns me.

 From this, I just expect to see more starred threads, and I can easily 
see what concerns me (doc oriented series) or not (partial doc as part 
of the series), and tag the series accordingly.

We'll see in two months how this opinion changed :)

Thanks,
Pierrick

