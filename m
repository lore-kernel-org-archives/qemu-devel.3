Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF7FEC0F3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56UY-0004o7-Nb; Tue, 24 Mar 2026 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w56UW-0004nl-No
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:28:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w56UU-00013q-0G
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:28:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b07069e2efso10562165ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774376912; x=1774981712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gfYJ0/NFET7qzAnEVyjfuSbOkNV2PrvtGVK2ed0AlAg=;
 b=WK29TUa/4XTD7DN9/f3xOK+fM6BoUU/6aUFLjCESTST7zjlC72u1uxMfTaWOESERka
 JrTFtVg0ZQJup1nPK9uB7yJuh/cLf14WHbM3DZZcq+RONeuMoim24lpkaWOFs4U56OMt
 FRk/HNxttUkzR79BnDXhe3i7ziuQkmfYTkp0cAuyiAVz/bT6J2ZCwI8LhXM940rKygQ0
 bWxQB5jBalqAe+U6h56CR4+pWUw7XcVeEBbCOdnNWk1w8QSjwqIKBuum+qsJMgF3lReg
 j2oxp8wbgTDrjcVCpH7f8mtvKcW9usuqpAzBIFXR86qurBjcdCvOiMJ/lXYW/BOqwk7b
 ImkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774376912; x=1774981712;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfYJ0/NFET7qzAnEVyjfuSbOkNV2PrvtGVK2ed0AlAg=;
 b=K6ysA5ViiF+BjB/G0cL0dcfx7FR32La0U0keRa+QQgIUKYnFEJWxozkQs84QfToDaZ
 oGj4j+1+OuZ78rx3yIuAR+mF1qxzsIA2t03x+ouw7XdQbcsTBzvaIbMZiheDNP27HFY6
 D3W5l4Ut6iNhwSJblNvLAqZd0w9kY59ldYY+UgeMgIKftjc9SxJCAGrYUQRGRgj5Z1YM
 9c+ivTOXK/VR9Xg3Ldt1AVYM+a1gK1rxgGljPInc6T3J0X8Ap1WJJGuzRzmh9TvcOU1P
 iUd7Yzs1N5gabVHY86bQ254WZ6R0GtgSCvbFO3Sv/g7qvHlIjtdBZjw4BiQZutNpQ5OC
 8syQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ2aU4JPxp8tsIu8zN+g/p/iAv4QOncuQ3PiXh9pe3Z4MRK5tKYAsrUV2djcaVQoOr3kUTyr7EEhn7@nongnu.org
X-Gm-Message-State: AOJu0Ywb7iK9k8IYn2w8XzOG1ovuUG7Oeds8REXDYnglMWrHuhmcnpZr
 DqnJRlzIuBhUhjt/fXJoCKJHPg0qNnZtuY77oUM1XC7Uig+SvfCO2d2LlwsRXjx2Pds=
X-Gm-Gg: ATEYQzyQlK6b0ZCUwHDdVYesZc64gfcqog69uhD8uMXVgDG/sGF7w3Lj5FtIGOH5aUK
 75Ri1nc/8Uv75z7wvjg3iCl2t59ZfrnX0e/mx2OPfWDxiHzF69aKeu6CMJLl9w/yXT5qgdBMTMT
 +fXviA+plPXAypoozcOvtx32ikKJqFX3rsD60LqOGsVPom4Xkl5QOSKdDcDTYm1+fyjFy5JV731
 BwugMqq1WRRJw2HO7U+yXrTxBdBFjw8nBuLLN17XLLZMSdek4VdmVVcejAoY8cfPc63q53J/ZP8
 ycu2PTvqb14nTlT0H5yRKVPyEof511nWJ9+fRRCzZQSnmk+qfbXPG1/xUD27w13czzNXIXsI+n8
 SAHi03w93Lzcda/Bxc0TlPIVDlkIrfOcuZte1USEgLWX914enLnJJMa4vlQjHuuqycqKO3IwLK/
 Xpk7OKWtqUAI5vwJH5+HKhJ23mMJ4YAQV4aHVvimbFM3fd/KUqJnB7PErtDs2tTPhRpbB4
X-Received: by 2002:a17:902:da88:b0:2b0:5cb3:e4bc with SMTP id
 d9443c01a7336-2b0b09d25e9mr6911765ad.16.1774376911802; 
 Tue, 24 Mar 2026 11:28:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c56bsm218617875ad.57.2026.03.24.11.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 11:28:31 -0700 (PDT)
Message-ID: <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
Date: Tue, 24 Mar 2026 11:28:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cleaning up contrib/ and tools/
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/24/26 10:09 AM, Peter Maydell wrote:
> We have a couple of directories in our source tree which have
> accumulated things in them that don't really belong there; this is a
> proposal to clean up by moving things to more appropriate locations
> (as 11.1 work, obviously).
> 
> Firstly, contrib/ has a tendency to be a dumping ground for stuff that
> we didn't think hard enough about finding a good home for, and for
> things in a weird "not really maintained" state. We should either
> (a) care enough about something to give it a correct home and to
> maintain it, or (b) not care about it, and kick it out of our tree.
> 
> Secondly, tools/ exists but is very under-used. I think it should be
> for the set of standalone tools that we build if you configure
> --enable-tools and which we document in docs/tools.  Currently it
> contains two things, one of which doesn't match that idea...
> 
> So, starting with tools/:
> 
>   * tools/ebpf/ is the source for the pre-generated
>     ebpf/rss.bpf.skeleton.h ; it should move to ebpf/
>   * tools/i386/qemu-vmsr-helper.c is the source for the
>     qemu-vmsr-helper tool; it can stay (should it lose its
>     i386/ subdir ?)
>   * the tools which currently are in the top level directory
>     should move into tools/:
>      - qemu-bridge-helper.c
>      - qemu-edid.c
>      - qemu-img.c
>      - qemu-io.c
>      - qemu-keymap.c
>      - qemu-nbd.c
> 
> And for contrib/, easy ones first:
>   * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>   * contrib/elf2dmp moves to tools/
>   * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>   * contrib/plugins moves to plugins/plugins (or a different subdir
>     name of your choice)
>

I would suggest plugins/contrib or plugins/community, to make clear they 
are the community contributed ones.
@Alex, do you have a different suggestion/preference?

Moving those sources will break build folder hierarchy also, which is an 
issue for all existing binaries built from contrib anyway.
I'm not sure there is anything sane to do to fix that except accepting 
the breaking change.

> For contrib/, ones I'm less sure about:
> 
>   * contrib/vmapple/uuid.sh is a one-liner; we should either commit to
>     having this, by giving it a better name and documentation and
>     installing it in 'make install', or else junk it and have
>     docs/system/arm/vmapple.rst give you the plutil command and tell
>     you to run it directly.
>   * contrib/gitdm moves to scripts/ ? It's just config data for
>     generating statistics about patches, so with other
>     developer-related stuff makes sense.
>   * contrib/systemd -- we don't do anything with these (e.g.
>     'make install' ignores them), so I am sceptical about their
>     usefulness. We could drop them, or move them to scripts/, or put
>     them in tools/ and qga/ with the tools that they are systemd
>     scripts for.
> 
> Then we can delete contrib/ entirely.
> 
> (scripts/ is also in danger of being "miscellaneous dumping
> ground", of course. I have tried not to suggest it as the
> destination when I could think of an alternative.)
> 
> -- PMM

Regards,
Pierrick

