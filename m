Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B143C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr8fH-0001He-LK; Tue, 04 Aug 2026 02:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wr8fG-0001HV-Uk
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:30:15 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wr8fF-0004pt-3U
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785825004; x=1786429804; i=deller@gmx.de;
 bh=yUU1nrEzQ4XJwohZgnSdc8cTKn/hqdjdJS6rpBRLjfE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YqYPOspwRIEV5U6E9vNdIittaWC+MW9W6vzgBpxvGqp2ieBhxsRBuoxcUlVLBK/V
 kCXYyIQh7zlgbFSzdW9oJahG9GUJGsHT4/y2oZ35Yoreoz34dT7nMJn2K8HbiNAXt
 UIiE8vfW39QeCFqm17bgxYZq0Y71TrsgIltC7+08UMNWtg35tDsG0KYUTRu+1b9xk
 oLBW+xW38XzYY3smsVYWIy79krBm2VGYFlx91zvAD7LlkT2P7F6PHJ+lEnmc6l+oB
 0NcUj2OCzJth4jsEj1sQO7v0d7gm0/lU0xZ/W0t8BCfKIowBzAg3RqwU7lEbC/m9h
 owdF6cQxxRx02TVBug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1wQZLx1eqn-00IKf1; Tue, 04
 Aug 2026 08:30:04 +0200
Message-ID: <b1fbcbb6-2e04-42e4-80ad-f9b4907676ba@gmx.de>
Date: Tue, 4 Aug 2026 08:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Andreas Schwab <schwab@linux-m68k.org>, Helge Deller <deller@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de> <87ecgfkrg9.fsf@igel.home>
 <anEBr8nK-4nKmuXj@p100> <87y0emkhjo.fsf@igel.home>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87y0emkhjo.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AMDb3mwCRXsZe1tepnKV1ntJN1ijful/pukqJI3gSxwZ6jgvUaE
 R7Fjn1tLexbT3YiE1FwdygAJqLp7G2f2+9OePXs1r/2vffdHJ4sQx6F8RLbfRKmPKSzJL2B
 57ykgKzvDkHJMyolWIGoQKnKtid3ABnlBCoB8tzCLUkGiDdz65UKSGDTk8lP+/irADEJYYS
 4P/GlZDToGOD1w8DZMZIQ==
UI-OutboundReport: notjunk:1;M01:P0:stA9rKcmv+8=;Lvpj9vhAaCy2UZngx4yscF/8xbC
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On 8/3/26 23:42, Andreas Schwab wrote:
> On Aug 03 2026, Helge Deller wrote:
>=20
>> * Andreas Schwab <schwab@linux-m68k.org>:
>>> On Aug 01 2026, Helge Deller wrote:
>>>
>>>> m68k could be a problem.
>>>> The other big-arches seem to be handled correctly by the kernel:
>>>> arch/sparc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/parisc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/xtensa/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/x86/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/powerpc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>> arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>>>
>>> glibc commit 9f9feb6d5d says:
>>>
>>>      * Some older 32-bit big-endian architectures have padding before
>>>        rather than after time fields, although the preferred generic
>>>        approach is padding after the time fields independent of endian=
ness.
>>>
>>> and m68k uses the "preferred" approach.
>>
>> Thanks for the info, Andreas!
>> The msgctl01 LTP testcase does work correctly on a physical m68k
>> machine for me, so glibc/kernel seems ok, esp. regarding msqid64_ds.
>=20
> Which glibc version did you test?=20

(m68k-chroot)root@p100:/# cat /etc/debian_version
forky/sid

(m68k-chroot)root@p100:/# dpkg -l | grep libc6
ii  libc6:m68k                    2.42-17                   m68k         G=
NU C Library: Shared libraries
ii  libc6-dev:m68k                2.42-17                   m68k         G=
NU C Library: Development Libraries and Header Files

> Did you test _TIME_BITS=3D64?

Yes, because on Debian this is the default for all 32-bit architectures no=
w
(with exception of 32-bit x86).

>  This "preferred" approach does not really make any sense at all.

Right. IMHO this "preferred" (aka padding behind 32-bit time value even on=
 big-endian)
doesn't make any sense for big-endian. The lower 32-bit value then ends up=
 in the upper
32-bits of a 64-bit time_t value and thus you have problems when mixing 32=
- and 64-bit
time_t applications.
I think m68k needs to follow the other 32-bit big-endian arches I mentione=
d above
and provide an own uapi/asm/msgbuf.h:struct msqid64_ds file/struct.
And this stupid "preferred" sentence in the kernel should be dropped.

Helge

