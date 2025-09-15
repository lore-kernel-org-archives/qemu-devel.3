Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DED4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyAC3-0004fH-1f; Mon, 15 Sep 2025 10:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyABh-0004aJ-6Z
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyABV-0000YD-V4
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757946473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DaWnetI23W4THYRTKmVh3EPkDflAL+qXV7SNqCc6wnc=;
 b=iK0rHuKVcpcpU3qbRVRe4ZX6tgqOB9z6Ccn9U2FUdkBSmJz+7++AWcP1fq59i9JiMTIcAK
 45Ys23aHcvr76zjUU9yswPJMpxlf2sYqH8vYdw9bBUPpstRcpdeDB7J0ahLfFed2R53fv/
 gc+oTCW9Mx6zy7fHmwLbEkgugaITJtE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-aKNSk1oiNOWl1d7xZLYxeA-1; Mon, 15 Sep 2025 10:27:52 -0400
X-MC-Unique: aKNSk1oiNOWl1d7xZLYxeA-1
X-Mimecast-MFC-AGG-ID: aKNSk1oiNOWl1d7xZLYxeA_1757946471
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3eb72c3e669so445597f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 07:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757946470; x=1758551270;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DaWnetI23W4THYRTKmVh3EPkDflAL+qXV7SNqCc6wnc=;
 b=aYUWwcY0wiTIPumtJxcPZxTlZlHx+B8bU0HUHvOUKpo3R+oOEuujVE4BvJ/Dzgzsg/
 i/t8HVLxZIqYIGZhYy04mIZ6rbnEESBzhfvfoaUruC7EdSJh/4fqPlpUHis0eodPQ5Vq
 i79RJCkzszFk/VBA7SvnwQfdWaGIjtEsMnHWnrGqUXjji7BhUJp2+PxWkayC1N7JfF+p
 Dal5CXu5rJ0UkfjCWnDbwIVGQf5vwhYfjIJ0QazPqbUXL6BICZKC8kDO5/GtkZP4FheR
 vZ+ZuWptCmrz9chYuvYVBjNuOcf/1veKxIslT2kk1PMVljLh/GXNqBmssBNxPtPyNQQ1
 JetQ==
X-Gm-Message-State: AOJu0YxEoeBttB1z5FHyidcIvOXWC5/BZ0tUw+sv9oC4Q+QbeR08VSXt
 cpIxLB0RT2PrpqHT2hem2weGHJksvTQCwPH1MkRnoa6LLTsO2LG+8BnWOc4jLmc4unDTvYjqksZ
 xg425aNytl3nPj1mbUPlnKgTIlJokD7La95t22KZYAH98bWDO5pxwtBL1E6ExdR2P
X-Gm-Gg: ASbGncubOmYkM/TGg3zfKizslOrT3+S/Mdzpd5uPod6F3IdAcMr2+zXJFbjcy+hSyJf
 Hw0ug9CRZEc5WSTKnLBBSQ3G40hXJFvT1w7smQz0Z/GjBHWGjfkCOIewCj54BnV3mnE10F0hEb6
 elHs1MJvuFP/nEYTBzS+3aT/sML0VoOdAt7U4Je0Atzf0/mesU1yZJ3Jyww4NCC2eG77cmkv9kk
 MMJrxqv7Y2HcWxFdWCQcu2+HGcQW/zWMe3da3fYrLOiVH0lDzf5PU4nsr4GgY/HT3MkyP7DoELE
 JHi2EllvBjSNUVoAL+3kmJOniFIJjWqlxHsnpG/EbjUizsnhIeARiWnk1Y9194fwpPEc2S0sWRE
 j0Fe8fFyhB2XrBah3c7+tsABDR5iI+3xdIIrjur4/NhHtdp6D40FoKZyH9EowN+gLicwO
X-Received: by 2002:a05:6000:420f:b0:3cd:edee:c7f1 with SMTP id
 ffacd0b85a97d-3e765a3d7d3mr12074125f8f.56.1757946469585; 
 Mon, 15 Sep 2025 07:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE10oQAdnffpZhEmAkNpPuX9V2GZwn2a6QuItkp2gD0Eilc2O0FaEfY8XeoxYZND8BP1usyAQ==
X-Received: by 2002:a05:6000:420f:b0:3cd:edee:c7f1 with SMTP id
 ffacd0b85a97d-3e765a3d7d3mr12074092f8f.56.1757946469032; 
 Mon, 15 Sep 2025 07:27:49 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3e7d9844d24sm12353268f8f.46.2025.09.15.07.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 07:27:48 -0700 (PDT)
Message-ID: <0c35eccb-890a-47d1-8c54-9945519f6164@redhat.com>
Date: Mon, 15 Sep 2025 16:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/11/25 12:04, Peter Maydell wrote:
> On Mon, 8 Sept 2025 at 11:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> This includes:
>> - bumping MSRV to 1.83.0 to support const_refs_to_static
>> - Zhao's safe, builder-based implementation of migration callbacks
>> - Manos's qdev properties macro.  While bit-based properties are
>>    not yet supported, that's a small change overall.
>> - the Rust crate split from Marc-André
>> - adding proc macro aliases in individual crates, also from Marc-André
>>
>> I'm still not convinced about having "bql" depend on "migration",
>> but I am convinced by the crate split between "util" and "bql",
>> so we can move the implementation of VMState from "bql" to
>> "migration" later if needed.
>>
>> For the purpose of getting this in as an easy-to-use base for future
>> development, I'm disabling CI from Debian and Ubuntu.  The plan is:
>> - that Debian will require trixie to enable Rust usage
>> - that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
>>    (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)
>> - that Marc-André or someone else will add Rust to other CI jobs
> 
> How far into the future does moving to 1.83.0 push our
> "we can enable rust and make it mandatory" point? I was
> hoping we would be able to do that sometime soon but this
> sounds like we're going to be still a long way out from that :-(
Sorry for not seeing the question, the good news is that it doesn't push 
it by much, if at all.  Debian bookworm has even updated rustc-web last 
month to 1.85.0 (say thanks to Firefox), so the only remaining straggler 
is Ubuntu and they're working on it.

As far as technical blockers go, Marc-André has a couple fixes pending 
in Meson, and of course tracing support is still in flight.  But we 
could enable it for 10.2 in CI and 11.0 in configure.

The bad news is that enabling Rust by default is a bit like a point of 
no return and, in that respect, other factors may matter more than 
distro support:

* Community support: it's a lot of new code to deal with, and we're not 
Linux.

* What's the killer app: DMA support may take a bit longer, so right now 
Rust is limited to very simple devices for which memory safety is not a 
primary issue.  Could it be BQL-free interrupts, where even simpler 
devices like interrupt controllers could benefit from a more picky compiler?

* Dependency on Meson work: this is something that Zhao and I didn't 
have time to go through, but right now adding a Rust device is *a lot* 
more verbose than adding the corresponding Rust device.  For day to day 
work it's not a huge deal, as the verbosity is a minor issue while we 
have a handful of Rust devices.  Furthermore, I have plans to improve 
Meson in that respect, so that it understands more of the Rust 
conventions, and we've already structured a lot of the Rust code with an 
eye towards those future versions of Meson.  The problem is that for the 
most part of 2026 we'll be bumping the minimum supported *Meson* version 
relatively quickly.  Right now we only bump it for --enable-rust, but 
the picture changes if Rust is enabled by default or even hard-required.

Let's talk about it on the community call, since we didn't make it at 
QEMU Summit.

Paolo


