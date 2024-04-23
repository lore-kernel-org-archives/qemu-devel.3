Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A001C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzLDx-0003Xc-9a; Tue, 23 Apr 2024 14:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rzLDt-0003XP-Br
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:50:33 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rzLDr-0000yt-4o
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713898225; x=1714503025; i=deller@gmx.de;
 bh=cMdWBvGyYuzWM1qLq5FZHBHlDKjdEw5tP7K87TtHNHk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Vs3NGsbmRDvPKezKzzfUz01VRZAq6CHgslxBE9+eXHKjUqO1wsM0yxV8OjgMnMo4
 KZPgGhHCtLeWs6XCh2xT4KDGCHlPY0U2q03LTbl2RuDEPcZyn1VZ8CeOJLoHopzkh
 YNr8s7KQjH5D5uWyYYPEa2FwE/gBvjAhtuBkehnFV7pAu70CsmibiZdLU2CrcOoxI
 R+upPnjk4mSJl6oNcBBwSmI1xgeL3RgkLFPyaZc17UAgzNG2sCztbyL8KkP/AJC4A
 9uX7FY/6z7BWUlXrzbLdUVdLj0fyM1z7IK0oUph0ObV0/UW7NSOzPnMHdedfu9SJn
 5ZqCakoLur+h5sDsLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.177.27]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1s4a942zD9-005t4m; Tue, 23
 Apr 2024 20:50:25 +0200
Message-ID: <238753eb-ac96-4699-8bf5-5864182f9fa2@gmx.de>
Date: Tue, 23 Apr 2024 20:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hppa-firmware.img missing build-id
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Richard W.M. Jones"
 <rjones@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <6c469c05-1bc5-4fd8-89f1-130f5aba5ff8@redhat.com>
 <d0e87002-ee5e-4a80-b850-1660bc5f2c80@redhat.com>
 <96f04d1a-2470-4118-8e07-b864f58f241e@gmx.de> <ZifPYEXIsELVWmgo@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZifPYEXIsELVWmgo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vUCqgnz+EmXQhw81iXeGJ9xiG+4dq9+h5nE1LkOONf0Ji6NfgtP
 dzsvneRDdcNx4DZ2XgqqtG42OSNmCs5DN0Y2KKcYQE1A+AyM1HXpKWEd08rmyXsGstkRNwK
 f+k/WTUY82XhPiGYRlDNxMFmi02UQapzZTGRi95lbVE5+mpH2L47PZuQ8b8zWGiCLchH+sI
 95tEwTMTO88fI1qz/eCgw==
UI-OutboundReport: notjunk:1;M01:P0:inGJG9w4ILU=;akLVN7T1o3FnYPQU4okZYErjiwV
 82ZzeSQg9nBjy7lIU3t5tOkJW3eJfRLod8JGducrrybr+qE+WpILsq2wnH0h1X/TRdF/Fy8lL
 JUibiVLdn7mRsdJTJb7r1zmvh9CSWofXGKofOdy8zWbgpzqblmReS/luCf/BozzfFIE18nNUx
 T9eFyZt5wKloJDstmcpJ1egKkO/BEdxbhWir3Cs+ESHdNcd7mS7YjHOLX5NyPC1qqDg+wTpQV
 4awW2VWl8QVSD4MMwS195wfQt2JU9Bg8pfuEMMKhsvQSE3lC4XcFnK7E2qWBq6X3vUGweZUUP
 fvmuMSvEgq3Li8JQyro1AaG7UPiWboZHjDnF1uh25s5cYe2PV6HIDQfVEeWA3O8UJJYk8HGuq
 qnC0SLvkbqWt72/FwlT5NOdc/aTTPPeYOwvULhHp9MoMmwX4UTiZevIsSPrbQLu5b/n8XZ/hj
 /EpmCluUP9f/3RHpGuSiZc+CpSmo3kP6hx9XjLXs/4QY8V56b7CjVlwZIcfe7ATTVaAGvLKOh
 I3lV/KovN1/xx1W6lJdEr8mLgWrKw3t6k65VanBMnUr1K9abpSlHKg6IAz3Mc/VMyl54ES9u5
 X+AbCEa3ftj9AUGa+WHE0zJQWQsTBR3vgfh6Kyk+klFpoE7seCBxVmz5X0CMMjvfzORha77Me
 U/D5G3eY2HTkpe8g1DzDiXxCa/WGJpBpuVKHyFAb/oKQ7g7wPcfPGMx9GnRLjMwSE1hPiPmpm
 DP+JzXTpvzY2DKqGT4B/pfJ7M3j/H70KjoDFB2Vhv3Zc7QSGk8BKPZiNkT/2J0A3mVnaQ/0mk
 Rfu4SCjNTjr1KFxPsvdtycDJuBaUgFWKPUurE3fFOyVuo=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL=1.31,
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

On 4/23/24 17:10, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 23, 2024 at 05:07:17PM +0200, Helge Deller wrote:
>> On 4/23/24 16:58, Cole Robinson wrote:
>>> On 4/23/24 10:11 AM, Cole Robinson wrote:
>>>> Hi,
>>>>
>>>> hppa-firmware.img and hppa-firmware64.img in qemu.git are missing ELF
>>>> build-id annotations. rpm builds on Fedora will error if an ELF binar=
y
>>>> doesn't have build-id:
>>>>
>>>> RPM build errors:
>>>>       Missing build-id in
>>>> /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/h=
ppa-firmware.img
>>>>       Missing build-id in
>>>> /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/h=
ppa-firmware64.img
>>>>       Generating build-id links failed
>>>>
>>>> I didn't hit this with qemu 8.2.* builds FWIW
>>>>
>>>
>>> Though checking older bundled hppa-firmware binaries with `readelf` I
>>> don't see build-id either, so now I'm not sure why those RPM builds we=
re
>>> passing.
>>>
>>> FWIW the RPM check is deep in RPM code:
>>> https://github.com/rpm-software-management/rpm/blob/68d0f3119c3d46b618=
4f4704edb51749ce9f819e/build/files.c#L1976
>>>
>>> Maybe something else in hppa-firmware ELF headers caused this check to
>>> be skipped in the past
>>
>> Maybe Fedora ignores binaries which don't have the executable flag set?
>
> Yes, that's probably it. qemu 9.0.0 has +x set on the hppa-firmware
> images, while qemu 8.2.0 does not have +x set.

I just added a patch to the seabios-hppa Makefile
to drop the +x flag with upcoming hppa-firmware builds.

Helge

