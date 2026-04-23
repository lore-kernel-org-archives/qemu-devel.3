Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A67FC0340
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvS8-0005c1-SE; Thu, 23 Apr 2026 10:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wFvS1-0005aK-UV; Thu, 23 Apr 2026 10:54:46 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wFvRy-0008My-VZ; Thu, 23 Apr 2026 10:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776956079; x=1777560879; i=deller@gmx.de;
 bh=RDueuBbNS4XMf2Tf8bB8v7HAEBzI3QS/6UQ3Ciqbd70=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DyjTHP5GfD2/6f7fnVit9HLNEdc/KOehq26OxXTEGHzyS8gELdBad7BqUmabEBXQ
 sqsENpi+K9UnDsT781w8EEeFjujuD66FbceA5cG8WTYPjet5/IIpO/IjeNprsfA4R
 a4IZ3on/l1AQwyNkn5NeEp+NbkXsz8fIRFhkMb+qos96ew8RcNFKHUZz0l5jAZ9QW
 X2nAoiyL33gtkwwmdOxzFcLx01/eFJrBdDSw/LSDh758wCaYT8VjOqHFJPRlqxhGU
 ROD5MMeOhRKXiCpq8+2qeb+Y+4oG3hVPok9jGYTqb7WCcgRS5ZdLAdQCcT+VM+HF9
 Br+kzOVSaQlwTLFohg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1w7MrO0e25-004wuj; Thu, 23
 Apr 2026 16:54:39 +0200
Message-ID: <3fe78350-3ca3-4bef-a1b1-ad5523295145@gmx.de>
Date: Thu, 23 Apr 2026 16:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Matt Turner <mattst88@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260414025335.2847358-1-mattst88@gmail.com>
 <20260416182527.3862296-1-mattst88@gmail.com>
 <CAFEAcA9jbwdo=a5cE7PD=YKiBv9qtCTwA=YaE6pbFf6xww0ZvA@mail.gmail.com>
 <CAEdQ38Feg8HE-1t-tgDWsvM4LqJvdcm2JMB75SGXVwTwPe-5iw@mail.gmail.com>
 <CAEdQ38Gq4gQE5LGRbAJzMATa_SCJO95-uMdvPNK2NW3=aW1BEA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAEdQ38Gq4gQE5LGRbAJzMATa_SCJO95-uMdvPNK2NW3=aW1BEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1hXwAnADB+3e9RVz63GqoP41LIKtw62XmOVjFyAqQowqNsCDUM4
 /+wBJtFa5hYyeS4tvkFkdfgWU1QC2Tttz7JcXThrW6QYMOO5sYsgWqF/jJ1U6mvj7ATMNrx
 J9VQw1kqBohDATnuzWWXV2zUtTnRpI9llajFEwn1ZbAE7OhUMc5xjxZHQmxktKKcyCD61nw
 KhrV3vwAqeuAo4JH+pJ0w==
UI-OutboundReport: notjunk:1;M01:P0:jSBtsm4d8+M=;cNM9PyYma4bYXvlHzk0d6QswjfQ
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi Matt,

On 4/23/26 14:02, Matt Turner wrote:
> On Mon, Apr 20, 2026 at 4:59=E2=80=AFPM Matt Turner <mattst88@gmail.com>=
 wrote:
>>
>> On Fri, Apr 17, 2026 at 4:41=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
>>>
>>> On Thu, 16 Apr 2026 at 19:25, Matt Turner <mattst88@gmail.com> wrote:
>>>>
>>>> The kernel's 64-bit signal delivery (signal_64.c) uses:
>>>>
>>>>      newsp =3D frame - __SIGNAL_FRAMESIZE
>>>>
>>>> while the 32-bit path (signal_32.c) uses:
>>>>
>>>>      newsp =3D frame - (__SIGNAL_FRAMESIZE + 16)
>>>>
>>>> The extra 16 bytes in the 32-bit case is to place siginfo and ucontex=
t
>>>> at the same offsets as older kernels (see the comment in signal_32.c)=
.
>>>> The 64-bit rt_sigframe starts with ucontext directly and does not nee=
d
>>>> this adjustment.
>>>>
>>>> QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
>>>> for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
>>>> on ppc64. Signal delivery and return still worked because do_rt_sigre=
turn
>>>> had the matching wrong offset, but the vDSO DWARF unwind info encodes
>>>> the correct kernel offset. This caused any DWARF unwinder (libunwind,
>>>> libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
>>>> register values from the signal frame.
>>>>
>>>> Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in bot=
h
>>>> setup_rt_frame and do_rt_sigreturn to match the kernel.
>>>>
>>>> This was verified by A/B testing with libunwind's test suite:
>>>>
>>>>    ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
>>>>             and Ltest-sig-context all change from FAIL to PASS.
>>>>    ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
>>>>             from FAIL to PASS.
>>>>
>>>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>>>> ---
>>>>   linux-user/ppc/signal.c | 16 ++++++++++++++--
>>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Thanks!
>>
>> I sent this to Laurent Vivier <laurent@vivier.eu> since that's what
>> `get_maintainer.pl` said, but I see that he hasn't committed this
>> year. Should I wait on him, or can you see that this gets in?
>>
>> Also, I think this is probably worth including in the stable
>> branch(es), so I've cc'd qemu-devel@nongnu.org.
>>
>> Matt
>=20
> Sorry to ping. Just trying to get clarity on what I need to do.

I've picked it up into my linux-user-next git tree and will push then
soon:

https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dheads

Helge

