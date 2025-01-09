Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BDAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 02:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tViMo-0003x4-71; Wed, 08 Jan 2025 21:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tViMl-0003wp-Ke
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 21:33:47 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tViMj-0001CW-8d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 21:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736390022; x=1736994822; i=deller@gmx.de;
 bh=+c11MutoioLJIU53EujqyA3HIiIifyAllMe42d7vQ0U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fRcKhEjdZi/Kzkx6THVLBrMVKKtV1aZkYDHqtdaiw1e8BcKNVZAXq76gpem1LFqt
 X3Y+m+ktkx9akHm2koNMOrMpITXpjlG/WGjgqST51exn9rFimmLR7SNbJtEvuHNY8
 T6dEbzsLi4wZAUJQzCI4RZ5jxqPZnGhXtHKqZYVET5UfJEw5izGTQg+0FBGdYLfBO
 sQPUnWZ0PsUk1rKUqaQoeUcntyCO2ShfjNHy1N/HsvQacZi10b4A+Pl6lRQpAzG4B
 AY5Mf5ordAUXeuuKv9MImIqa3jA+nGUPKk9PIV6WXUz6mdnc6Og+WWeLQn6rh6CgB
 vVxpYLKrZNPMiFRAMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([83.135.220.169]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1u1TgG3ovF-00lr4z; Thu, 09
 Jan 2025 03:33:41 +0100
Message-ID: <c76fa107-1ed5-4247-9745-65c7ae5d6061@gmx.de>
Date: Thu, 9 Jan 2025 03:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing /proc/cpuinfo fields for sparc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <Z37rL5jVYpOk6ufc@p100>
 <f36ec87d-d384-4671-a80e-27d4ad4fe7b3@linaro.org>
 <b8ce1a5e-d239-4c4d-8515-171312ebdffb@gmx.de>
 <787ed640-60eb-4466-ba11-0ac9c9cca3c0@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <787ed640-60eb-4466-ba11-0ac9c9cca3c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gKJ9CO0As+fZfV4CDMhciKfcaYpnuZJhtxd7W0qOWwkECeVXKTE
 unPj4yolB3YOnCpKQ2GEjB6ChzR6yvTCTQ/ZAYRcOxDNKfVDtnqVD0m3HJJuQqGtrdSz4nE
 /G/OTOIx8BXXstcVMQCIz5ZFmdLLH0whyJ5UW4BSIcu4PhF2iCxEBidQtw66hUmyGdYZUNG
 +mYxeDCVpxlotWI6a2jVg==
UI-OutboundReport: notjunk:1;M01:P0:2Kugm3mLYDM=;tZgCpZ6bMGAvdP/Hf/5DTN1k5PP
 +IgVzmEqYXI74/51km1hTTWZBrY8wafkijU0CG0HyfKIEdnZRk5iAxb6jZTvdHxZsmzFntFHY
 5yhgtR8HcrQU770DyULN/11dG3fS4rTaKUAJGd0YFb4hFzhG54R0JhO0w9f+XR0l8fvjO9GWc
 oeEDAb+ZK6RCibXyeyfQgw0qs63Ru9rxJn+gw+c30/ExIuYGjwqHzoQ0CC1kCCAUnv66eU2jv
 4JTXO0Fzww1BmIPzaMXTjEh1iNiAHN6PzNl4oiILxAbkG+s9aeaNYRN5dsjK1nPYD/yZDAaMz
 NpZGlPfLRiDOEESNJJhGowzadRvxXZmZQqaNvBedCffvVxEJwVQzi4PBxcQvNAzhrQwvFGYRt
 5aVyBlPsavcP8Z53/B98RSSnwqs2VyI719Gfas09Lr/Mpo9PrtWByzXdZt1KdU7kdCmBPj0WE
 h98OPbBRA2wecKME2Or78uh9T/3AHBZ2dh2lVoSFOS+oqm9Pm9bYhKzhstQkExl45hkNmCeCq
 UDsSNb3NynAtqatSkcvd97DI/c+5vpKkTYCe//AxJkTO9oTTi5ut72IDLNQ1tii11KCND7WOs
 /+05hD4/HboyV8hLvWALfKHFx4Puog6klSvEXLaui6qf4w1F0qBWvTrWbcGXUzbByeh1uB2l1
 RgsHFn+jBqOJ0zYqeDttTru8/Hcunm/aPaVVMSqt/dnIkiiTv3Pev480XD4LXaNCkt/PDPvRV
 QMxNdr6Jxl3/bjRfMVtmFhDn3Lls9mEvnzBpBL4m+Cte7b5qurrpOIjjERw9p9Et+NxtBglrl
 kiPCkf/VCLSDXmNAgn+/31FrkvHvhqGdKheZg+Y7aB8Xl6yyRb8Tna9HEmb07jOl7GLQowOLZ
 dPcBLU6a4Ly2ulz1cHHXFKKiOrYyOUPdz7cP0rLMnZ1FtvGJxYQMFxmEQS13C3tTxPFgbhHkI
 wZKVl2UsXIlqsG8ersqboZXbjGjVqCyH6RMwpTV35xFAk85+7WUKbVWsuY40Cn2D/3vHOYMlG
 +RmRTD62ztBhgLcClj/rAU7ZiruvW+n/Pl9Ca+OxgfUV1Wkbc2nadPuOp3UF1rYiiuZs3423S
 evdb9hKZaG9EnGhWSqesoqoFVzBIAy
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/9/25 01:40, Richard Henderson wrote:
> On 1/8/25 15:21, Helge Deller wrote:
>> My suggestion:
>> I change my patch to just add:
>>
>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "ncpus active\t: %d\n", num_cpus);
>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "State:\n");
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_cpus; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dprintf(fd, "CPU%d:\t\t: on=
line\n", i);
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Those were the lines which I was mostly interested in since
>> I found one application which wants to parse /proc/cpuinfo
>> to get number of CPUs in system.
>> Would that be acceptable (for now) ?
>
> Yes, thanks.=C2=A0 If only linux had added a prctl or something to not r=
equire parsing...

True, but most people forget about glibc providing sysconf(_SC_NPROCESSORS=
_ONLN)
as portable function so that people do not need to implement parsing
/proc/cpuinfo for each architecture themselves.

I'll respin the patch.

Helge

