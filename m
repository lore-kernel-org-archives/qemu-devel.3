Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC86F4181C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vze50-0000Ly-6R; Mon, 09 Mar 2026 13:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vze4u-0000Fr-Pn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:07:37 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vze4r-000414-Ja
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:07:36 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-89a133cdd4aso79687376d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773076052; x=1773680852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RKo/OjPFfQ2pV72Jjnhy5gOqQvdOMi1qM3ExL7IT5BQ=;
 b=FRsfYprSEeWX6QVqHKtVRpteKhSwJexwttvf7L0CB+ymlLoumO301AyxpxoTCHkMZx
 XCVFUCMiJpT/FD+bsmjepcF52v/Pjl0nhGAeYlzlzy+EyntzQqp63x9DkAtTgsP3mqBB
 C6t0q2QGGCnBOnnan3hyrmpeE2Z2KHYxh1WU23QSVd8yjMP2qRpXLfQfz+ei96mIqa8B
 LfNX7Xjnr2z/FZztXLcvIlvMz/wQ/LFH015KHwBLokSIWtLbV5wKs/hbc0x8PszPvkiL
 eQzIlzXtuVsvSI3PVTBVvOiJjpBYsGgYXFYG/WUoiV3XOh1AQ2pu+XxFwFns/XVu/zxs
 elNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076052; x=1773680852;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKo/OjPFfQ2pV72Jjnhy5gOqQvdOMi1qM3ExL7IT5BQ=;
 b=C+2Mzbzn2wcraJZlJbAviNTyKZNkERpJhPkUPlYWA6QUkZ+DYloAin33gcOJQP1qnr
 48LdjzgwaNJ157Imoe01hWss8GKLklNvu6OEAKWCpsr3yyw7+Vl5U4a8YXfsd1ySNrB6
 aR58I7hirGI+gczrzZO/SIBERxgp4UP/Lx7iv7NI6/MDYdcSqYshoam/yi1up+MorCZ5
 wOclK0WV9GAWSYHhluK9yZhX6ly2Oke7+07CzT1GBXPGfGyIu5i4k5PsZAwAmhyG0X9Q
 HQMXmew0jpbM58PqYlJ3v1kAbDxI37btk7nxNJ7Z4+MTjbXC0nVzSVTH4PwVcRjd7vSm
 y/vw==
X-Gm-Message-State: AOJu0YyMPJH8rDj7IzyXVvzK7bP9ax2BhNIR5hvgdtv5Nu1ApemEW+eZ
 yXwtxjt43orFuGUco/kHVahEHJrpJFQFhn6FDJrLJsrEy5CEo6+CLi1dqkl5e4lDk8wk6mnUxRm
 NgOwC
X-Gm-Gg: ATEYQzyLh9mvD+qCM+mJ0llO+tcq9SkjJ918fOflkZ5QKwlzMOA8IAuUuAWQeI060vr
 1nBIeAKqZy62CZPV2JlVwjqGQfb2f49vc4H2e43igft3rbUC8D38X69Fc3egqUNrkT49HEVvVfI
 N/9Jbw7NGYZxeh/qsvpj3nGYEzWOCxSE6epGQVAkch3AaGsWNniDO4yPjCYV5RiTupueO06+y5D
 bmFMX2bqiJ/baxxoHGICIIYhTUBRqllgovwacVdPPG2CpLfmwxvttS/e6Wxv55Y7NoTLmWvERhu
 PfVbYSIMfWxYnm6v2g/rFkFcDIJrL25cWRU4fyacQPaGqkjAvKs7tH2ITnOZkLqBCaromYZh0YT
 5FjNr5DjJkWEI3UtzNUvko8RSvXeURbM1lPeVJGLNvcCgnQzqnDUzf1hzIU/SOOvbMDNAvYFG1B
 yo6R6R4IM3mJlinf6DfAeoG6bi86UViHTUelvqSBbebceOks+3XB8GPn1YTfFtvEBIIxOG
X-Received: by 2002:ad4:5d6c:0:b0:899:fd8c:55ca with SMTP id
 6a1803df08f44-89a30a7f9eamr179960986d6.29.1773076051708; 
 Mon, 09 Mar 2026 10:07:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57c2c482sm1663466d6.42.2026.03.09.10.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 10:07:31 -0700 (PDT)
Message-ID: <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
Date: Mon, 9 Mar 2026 10:07:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
 <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf31.google.com
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

On 3/9/26 9:38 AM, BALATON Zoltan wrote:
> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>> On 3/5/26 9:15 PM, Pierrick Bouvier wrote:
>>> When using llvm-addr2line in replacement of addr2line, it will output
>>> zero sized symbols, which can shadow other binaries depending on where
>>> there location is (happens with arm-trusted-firmware and its different
>>> binaries). Thus, those symbols.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    contrib/plugins/uftrace_symbols.py | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>
>> This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).
> 
> I doubt the usefulness of such messages. People will know when pulling
> from git and this list already has high enough volume. If you think this
> is useful for contributors could you please send such mails off list only
> to involved parties?
>

 From what I understand, since you were not directly CC on this series, 
your problem is not especially with the message in itself, but with the 
fact that "this list already has high enough volume". I personally don't 
suffer from that, even though being CC on all patches touching docs/, 
because my email workflow allows me to follow threads I have specific 
interest with, and ignore the rest.

In general, a mailing list is not something you are supposed to read 
exhaustively. Instead, you're supposed to track your personal interests 
out of it. For an analogy: When you go to your local supermarket, will 
you try to follow every conversation happening there?

If you feel it's too much for you, then maybe there is something to look 
into how you track the mailing list, and my advice would be to use a 
threaded view, with tags and mail filters to reduce the high volume you 
seem to receive on a daily basis. If you're interested, I can share my 
(simple) setup, and maybe you can get inspiration from it for your 
personal usage.

To be honest, I was thinking to organize a small BoF on next KVM Forum 
to allow people to share their personal tips with handling emails.
It seems to be a common issue, and some maintainers even missed some 
series they were supposed to review, or to pull them. For myself as 
well, it took quite some time before having a correct workflow. I even 
went through the idea of "reading everything" and quickly dropped it as 
it was unbearable.

> Getting messages about patches being queued is useful for other
> maintainers and contributors to know the patches are picked up and then
> they will also see the pull request on the list and when the pull request
> got merged. Getting separate messages for each patch in a pull request
> does not add more info to that for people already following the list.
>

Except that some maintainers, including me, don't cc original authors 
when sending a PR (that's a deliberate decision). As well, some top 
maintainers don't always send back a message once the PR is done. Or 
they don't include all authors on individual patches.

So for consistency and the series I personnally track, yes, I believe 
there is a value in notifiying original series and author.

It's totally right for you to mention you don't like it, feel free to 
ignore the message. However, I feel it's a bit beyond your rights to 
decide what people can or can't send on mailing list when you are not in 
CC on the concerned thread, don't you think?

Regards,
Pierrick

