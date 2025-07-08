Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCE8C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 23:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZHfm-0004o4-Rm; Tue, 08 Jul 2025 19:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZHen-0004IV-Hj
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 19:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZHeh-0004Qh-Mf
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 19:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752016997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z9F+zA17KjOztVwM+STZDTwHKQo5BJ+yaSAuEaA27rI=;
 b=aPdyMm7ilvRzc2rOYw03OHTq3UXRDDalHBoauphwnmjfSwkVQI5JjIQh74NvUJfMXbT1cY
 f4Brne9/anHdS/qYN+2YO4KNJArCOMBlG7UmmV733sjYqMJ2zwmbvCmmy5OeYpX3wmFriW
 3XJuCjS30N8RtbC44/Vhwjan4CdSRj8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-51vgKGatO0ee4g627IrVaA-1; Tue, 08 Jul 2025 19:23:15 -0400
X-MC-Unique: 51vgKGatO0ee4g627IrVaA-1
X-Mimecast-MFC-AGG-ID: 51vgKGatO0ee4g627IrVaA_1752016994
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4532ff43376so40304075e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 16:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752016994; x=1752621794;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z9F+zA17KjOztVwM+STZDTwHKQo5BJ+yaSAuEaA27rI=;
 b=ij6pJbl/7k66pRtIRu5e/TJomfLgboyAi06vXfye6/fM5877bfNqtUZvwprgRXb/rN
 A4uggSiGnpryu2EFv/Au6HVtzChpJX1Vq7kpmV1nLtHvASLdWUuTVuZfeYPh2EAdYo30
 GgzjID7TDMikxLxYOK/Q29NKm6BmctgVK8h4i6cHyMzBH2YfqJStJflKhQtjsjfJIogn
 4GaQ3CF7vpyDqqdfulxSraCNGVxG+EEnoQGrryavj3PoYJQc++nI1eJ4jhcgqLgR7XFI
 d/dj/R7H2ADHhEg4e5qBXVv3LOpWFSqfU4QFTlHu3hllh49k/qPh52NjeihNPriVtq2k
 AgBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrD25mQiokSovFw+bwZ5oC9cl5NQGmmzbacqQTOwcTGJNOQLDDQkLf4DakIn3PmDUvXWWQfcjcDRWR@nongnu.org
X-Gm-Message-State: AOJu0YzLtzQQS8BgE50ZFf2txArgPuJMAFBoqI3lYKl67mGcNdep/4s+
 ELlzmy+g0K2/JpYwdyZaeexn/PacJLCZdhgEeXdGW/i4Xf1DKxg6CFqRW9MRtBquIULZnAvAFaa
 xjB/nOc0avuLO25AdzdYSae5cuVZFJpGH6zVWRjlJWphihtfs962OYM7g
X-Gm-Gg: ASbGncvKJ4vS8lwtcdm0FLsKBr0IEORxnkKlJ+ttYjnEVIdcP1V7AmHcelWIRHNmgK8
 K+v+l70mlmka2WTl7bC+O1R9bGareova7NzXKf4OB9UKRLzfbI5wrq9zC/sKVZBU7ToY5e+9E9Y
 hFLmOpmWPSIlytUiJnYBmukpcwSWXdwSiCHQL2jeNYNlRsIwcEVWUfVySNBK6EpUHN/G1eQBH24
 RXLtSJWT3JAs2453mCvO1mLuoufjuThVBY+nKjmf5g7QUhMol/Y6TAQATOlUYyTnQ4u/9LvE2PS
 HPfA2udkPKMqaDe/lNTjUgV78Fw=
X-Received: by 2002:a05:6000:4a07:b0:3a4:f8e9:cef2 with SMTP id
 ffacd0b85a97d-3b5e4537e57mr91559f8f.36.1752016994282; 
 Tue, 08 Jul 2025 16:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ0rnXKMTvXczzj6v7lSMcbj4fGBars5349CSPw1T0l24AVvM3+efhyo6euS9JDOZ0YN0xwQ==
X-Received: by 2002:a05:6000:4a07:b0:3a4:f8e9:cef2 with SMTP id
 ffacd0b85a97d-3b5e4537e57mr91542f8f.36.1752016993815; 
 Tue, 08 Jul 2025 16:23:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b47030b4f6sm14443300f8f.10.2025.07.08.16.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 16:23:13 -0700 (PDT)
Message-ID: <d1c33e1e-8b26-4a75-8b1d-2ec6c54d72d0@redhat.com>
Date: Wed, 9 Jul 2025 01:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Python ecosystem versions overview
To: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <CAFn=p-bp_hFTu7yDGuQa-Eoctnpb_dd4_fgfhrC3umpX1EuvCA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-bp_hFTu7yDGuQa-Eoctnpb_dd4_fgfhrC3umpX1EuvCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/8/25 22:36, John Snow wrote:
> centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3   BaseOS, CRB

Ok, so the lowest version of Sphinx (3.4.3) is currently used for CentOS 
Stream 9.  It's supported for roughly 2 more years, until 12.0.

> opensuse_leap_15_6  3.6.15   20.0.2  44.1.1      2.3.1   updates/sle,

We use the 3.11 runtime in the dockerfile, see 
tests/lcitool/mappings.yml.  That is a bare minimum install, so 
configure won't use the distro sphinx and instead use 5.3.0 from 
pythondeps.toml.

> main/oss
> pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3   ---
> ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2
> jammy-updates/main, jammy/universe, jammy/main

This is the second oldest version of Sphinx.

> ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6   noble/main,
> noble/universe
> ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7
> oracular/main, oracular/universe
> ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3   plucky/main,
> plucky/universe
> 
> (3) CentOS stream does not ship "sphinx" except via "CRB", which I
> think may not be enabled by default.

It's not, but it's intended to be enabled when developing against the 
Red Hat packages.  We enable it in the dockerfile:

     dnf config-manager --set-enabled -y crb

> (4) OpenSUSE Leap 15.6 is egregiously old. 16.x is promised for later
> this year, but we are past the promised "five year" support window for
> this platform in some sense -- 15.0 released in 2018 -- so I believe
> it can actually be ignored.

As far as Python is concerned, OpenSUSE 15 doesn't cause trouble anyway, 
because we do not use the 3.6 interpreter and its very old distro packages.

So that's two reasons to ignore OpenSUSE.

> (5) Ubuntu only ships pip in "universe", but also ships some Python
> 3.x interpreter updates to that repository as well. I have filtered
> this list to only use Universe for pip packages, leaving Python the
> base version that ships with the platform in x/main or x-updates/main.

Yes, fair enough.  Ubuntu 22.04 came out more recently than CentOS 
Stream 9, after all, and its base distribution is more up to date than 
CS9 with respect to the Python ecosystem.  Rust is where Ubuntu (both 
22.04 and 24.04) is considerably less updated.

Paolo

> (6) "ports" collections (FreeBSD, NetBSD, OpenBSD/pkgsrc_current,
> Homebrew and MacPorts) do not necessarily have the concept of a
> platform default Python interpreter version, but other packages in the
> collection can be used as a heuristic to determine which one is best
> suited.
> 
> For instance, FreeBSD and NetBSD only ship pip et al for a single
> interpreter version.
> OpenBSD has a symbolic "python3" package that installs a specific
> version. Homebrew has a "python3" alias that chooses a specific Python
> interpreter version. MacPorts similarly has a symbolic "py-setuptools"
> package that will choose a specific interpreter version.
> 
> These are used as heuristics to determine a "de-facto" default for the
> ports collection platforms.
> 
> -
> 
> That's all for now. I will publish the script to the list later,
> though I have no intention of cleaning it up for inclusion in our
> tree. When I send it, bookmark the email if you'd like to try using
> this for other purposes or running it for yourself. Maybe I will throw
> it up on my personal GitLab in case it is useful to other subsystem
> maintainers in the future. The filtering code is a little messy, but
> it got the job done and should be reasonably straightforward to make
> sense of at a glance. It uses only the 'requests' library as a third
> party dependency.
> 
> Your humble Python sin-eater,
> --js
> 
> 
> 


