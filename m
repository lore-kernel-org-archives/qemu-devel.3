Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8849DFEC0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56kG-0001Tu-FQ; Tue, 24 Mar 2026 14:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w56k8-0001TX-Bh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:44:45 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w56k4-0004nz-4F
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:44:41 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35a211df8e3so1079464a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774377878; x=1774982678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flO5NXJZbfmHSirVfrTOnM5aQhcD/11RQKhDORtzBsc=;
 b=wzgDyF1r5nDOBfuBnDwhDzpEe2NZtILXNbi+Kb8DjqUmSe+M1dSiWSLAvxdhLUpWzH
 NxRAaBtLwhfipoWJZbHsfbT5r7aUEizQd0n0SwtJhWt+CyFuY8lYiiCCDGvn2zVsYxjh
 AxinCAArUIK/eL6UMbGE+VdFv0NHbTj9OQ5fDzAlYVsFEX5ct9NFOTQ/nV2tgEcmevzx
 BEMOfBE84YHy3/CDLnF4M5LoevNR6V8x6BLoMM7PCCUCawHOmRkZeFnKZlElJOGaQVJY
 q4fVqInEOlYqaKiPOdjTG3VSQUgub3Y+imvpMhLv6enyPfuLPvumTGTjRlYU7sBgl69Z
 hEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377878; x=1774982678;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=flO5NXJZbfmHSirVfrTOnM5aQhcD/11RQKhDORtzBsc=;
 b=iKi4yOKNWNJktmgzbsywr7yRzv7aEC5Xuw3IVagZC34EP6vPV/k1LvgVdacGgQdRhC
 9moWzovNPBLX0OOr3LkJ384JJP3+9ocOjToZmUH0aYVMVX3OHj/KPtTWLKP7vmtQ4jHZ
 SSODA6w4KtORLcTzGJqbVnj5PwjoAsPoTkzZrH9D1Ii/lACqbR4qKRK6bqbYkOUq3UCj
 cBnkqs0BQ7qpnB/j1jE7RGADRchDhAjlVIRgTfl57cqyB98uuzgyqBqUtDutP7kOSUBG
 2RhbRZ8Dgy8TfEY/32M2BdwwZw2xho0Nd7ilBhEi1kaMKHwj0xYVRV8qbzuj1UzXzEzo
 Iv9Q==
X-Gm-Message-State: AOJu0YzTbECB762T7SIwLuti6YF98oTB7k2cYpRJXMXaYfCqbcle21H4
 SW8QPlASct7CTPGExGjqe5hwAZh6xqqWico5KQ/fA8V6tmrw0zcamxPOuixPxQuI0Cc=
X-Gm-Gg: ATEYQzy1T62m8qD6YxEOFimXcjvbmI9GZV/djOvyJjadDbH+c56UQcLf71Fpcn4pcvD
 3tjvSDQDulcOymnuWjTYnw1SmYwH1VqHSaU2v9SgLe0DiPlSGo3K1NhHw5JKEPGvjeK7QDe70SP
 jzoecMVTR/p/ajj/5RK5bPuHIBtIfvlIZzCYLqS0a1scun/Lq8tlKOXetAAN5GSEZG7GAEzh1H7
 /mUmcYBsTCsb9puQPeh9xVREzw3QuxJPsFbh2lUWzu9y1abaLQcpOezkN+0enUKCjPuc+chKYW1
 b5DujqcL7m7vnV7nPVtF6ZmUsWmIdWEucOp+F13cVd4Qye5s/pWGs7PbOSc3UTRGsHY5bIKN8eK
 mGuRrkWCCqHbApwhpFSrz0H9DNsUon8fm5r377uYKMguqCebh62MWYLNLFskAdASuLnKsfqUbhO
 wWNML3MUctQ6CO/w9XSUy4HgBtvhWa874fCrsje81RZoZxZbZBKR6HrRbH0MzS9Axn2kWVuNAmC
 DlfqYQ=
X-Received: by 2002:a17:90b:530d:b0:359:974a:3d65 with SMTP id
 98e67ed59e1d1-35c0ddadf71mr400385a91.16.1774377878316; 
 Tue, 24 Mar 2026 11:44:38 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c087cd95bsm1935470a91.13.2026.03.24.11.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 11:44:37 -0700 (PDT)
Message-ID: <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
Date: Tue, 24 Mar 2026 11:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cleaning up contrib/ and tools/
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
 <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/24/26 11:33 AM, Peter Maydell wrote:
> On Tue, 24 Mar 2026 at 18:28, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/24/26 10:09 AM, Peter Maydell wrote:
>>> And for contrib/, easy ones first:
>>>    * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>>>    * contrib/elf2dmp moves to tools/
>>>    * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>>>    * contrib/plugins moves to plugins/plugins (or a different subdir
>>>      name of your choice)
>>>
>>
>> I would suggest plugins/contrib or plugins/community, to make clear they
>> are the community contributed ones.
>> @Alex, do you have a different suggestion/preference?
> 
> I firmly do not want us to have anything that claims to be
> "contrib" or "community" or similar. Everything in QEMU is
> community contributed in some sense. Either we care about
> and maintain these plugins, in which case call them "plugins",
> or we do not in fact care about and maintain them, in which
> case delete them. "In the tree but not maintained" is not
> a category I think we should have, and that is what "contrib"
> generally implies.
>

We make sure they build, and test them (manually) on changes. The only 
difference with tests/tcg/plugins is that those are used for make 
check-tcg. I personnally consider both of them as properly maintained.

>> Moving those sources will break build folder hierarchy also, which is an
>> issue for all existing binaries built from contrib anyway.
>> I'm not sure there is anything sane to do to fix that except accepting
>> the breaking change.
> 
> What are we breaking here ? Nothing outside QEMU ought to be
> depending on the layout of our source tree. When we move things
> around we'll update the meson.build and the documentation.
> I don't think we have 'contrib' in our installed-locations
> layout (tools get installed into the bin/ dir, for instance),
> but I might have missed something.
>

I was thinking more about users that might have custom scripts using 
various contrib plugins, or using vhost-* binaries or ivshmem-server or 
elf2dmp. They will be relocated because meson automatically uses layout 
of sources in build folder.
It's not a big deal anyway.

> -- PMM

Regards,
Pierrick

