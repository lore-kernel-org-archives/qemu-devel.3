Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE37ECCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBb8n-0005G1-Jd; Wed, 22 Oct 2025 11:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vBb8l-0005Fe-N6
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:52:43 -0400
Received: from sg-1-22.ptr.blmpb.com ([118.26.132.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vBb8e-0006Fv-Km
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761148273;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=glEZMjlrDHh1A2VIOT3Jr7WKbcgCkTHxQO6t8OtYs+w=;
 b=j3xxpFUr5L8EdgcquQmIBN/BFw5CEvSfG6ZGDvFsEPlXqJOUIhXmEtSGVM2B+UbKIiSU24
 xK2Fg7fQqjPAL5jT1PSaF/djhEzmeJX+DVifr5WCUg/P/jdwK9+wA8c1cxFH3R8VyvTUYC
 SR+qbtYwZzH+91FhVU4CVs0bk51oamtWpGS0ALwXXp8qhV/cFqQRDtzIxwqNmGzjM+Xf9F
 sYKdJ5MiGWxN6x95aXY07WW++x+rfBJzPY5bA2ASlQsW+tnV5479qmBn61yPYuAiDm3v0Q
 15KzLWDUNSimaSwdqKyAyDFK7b3R89VBRYPgIRoZT89RZYNm+lp7b5oLe1lFiw==
Message-Id: <e0f03fac-2a16-439f-9a22-2015c18ba739@openatom.club>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+268f8fd6f+5e3824+nongnu.org+chao.liu@openatom.club>
X-Original-From: "Chao Liu(openatom.club)" <chao.liu@openatom.club>
From: "Chao Liu(openatom.club)" <chao.liu@openatom.club>
Subject: Re: From HUST OpenAtom Club: Inquiry & Contribution Plan for Rust In
 QEMU
Content-Type: text/plain; charset=UTF-8
References: <822f8543-10d0-4669-b484-cbd9837e324c@openatom.club>
 <cc709134-2d28-4ac5-b7fe-c61bd1c5ccbf@redhat.com>
Received: from [192.168.71.4] ([114.88.97.170]) by smtp.feishu.cn with ESMTPS;
 Wed, 22 Oct 2025 23:51:11 +0800
To: "Paolo Bonzini" <pbonzini@redhat.com>, <zhao1.liu@intel.com>, 
 <manos.pitsidianakis@linaro.org>, <marcandre.lureau@redhat.com>, 
 <philmd@linaro.org>
Date: Wed, 22 Oct 2025 23:51:06 +0800
Content-Transfer-Encoding: quoted-printable
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, <dzm91@openatom.club>, 
 <luojia@openatom.club>
In-Reply-To: <cc709134-2d28-4ac5-b7fe-c61bd1c5ccbf@redhat.com>
Received-SPF: pass client-ip=118.26.132.22;
 envelope-from=chao.liu@openatom.club; helo=sg-1-22.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
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

On 10/20/2025 11:22 PM, Paolo Bonzini wrote:
> On 10/20/25 12:56, Chao Liu(openatom.club) wrote:
>> Our initial plan is to add Rust versions of peripheral models for some
>> simple peripherals, such as block devices or I2C devices.
>=20
> Yes, this is a good idea.=C2=A0 I2C would add a second bus in addition to=
 sysbus and could show the limitation of the existing bindings.
>=20
> Several simple devices in such hw/misc/i2c-echo.c, hw/gpio/pcf8574.c or h=
w/rtc/ds1338.c could be converted to Rust in the same way as pl011 or hpet.
>=20
> For now, avoid devices that have properties (e.g. hw/sensor/tmp105.c).
>=20
> Block devices are substantially more complex, so I'd stay with something =
simple for now.
>=20
> Paolo
>=20

Hi Paolo,

Thank you for your suggestions, which have been very helpful to us!

Currently, we are referring to the Rust implementation of sysbus to develop
the Rust version of I2CBus, and we have already made some phased progress.

Going forward, we will submit some RFC patches to the upstream for
everyone to discuss.

Thanks,
Chao

>> In addition, we hope to get some other suggestions on what other suitabl=
e
>> work we can do regarding Rust In QEMU.
>>
>> We look forward to your reply and hope to contribute to the Rust In QEMU=
~
>>
>>
>> Link:
>>
>> [1] HUST OpenAtom Open Source Club:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://hust.openatom.club/news/20250812_=
intro_to_club/
>> [2] RustSBI Github Repo:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/rustsbi/rustsbi
>> [3] Learning QEMU Camp:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://opencamp.cn/qemu/camp/2025
>>
>>
>> Thanks,
>> Chao
>>
>>
>

