Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA32C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPZa-0006IY-Nn; Thu, 16 Jul 2026 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkPZY-0006Hz-Nd; Thu, 16 Jul 2026 13:08:32 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkPZW-0007Lh-A6; Thu, 16 Jul 2026 13:08:32 -0400
Received: from [192.168.75.54] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id F201F2003F3;
 Thu, 16 Jul 2026 19:08:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784221707;
 bh=v1TOwzHVscYDnAB5cWc4UY32DTpJ2EEd66DlKvgJj7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=owfmr+3xHxtSj0HiAsV/3LIRml3s8AlBQLtZVG+shN0imqgnzAFHKnHR5D8O986Mx
 HDz2pPbfstjky4Tq1oDvvMy7qdLuF+PdZxhk1gEO7qeLwwX9Ipd4JBUPhBTgo8xqht
 +qaSKBnWUVT16fk/igKypG3tQbafo86PVzv47fmqgPAmsMJiQodcTk3s9417PKnh/+
 Tcwca6aREMJKzbm1GYOwYVzrq97L2pCG44+lH/MJK/PYhwwdO0SAdPu4v06ahZRjlq
 ztMwwVCdlK3+t0GLPj9xUP5FEmZaptLnoKI3R5582Xlk/X8RZs3kSogiD81xoB8qIV
 UFFyJGKrUvZfw==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
Date: Thu, 16 Jul 2026 19:08:04 +0200
X-Mailer: MailMate (3.0r7020)
Message-ID: <D5F0871C-4AC1-43D6-9BCD-C59A07236A1F@free.fr>
In-Reply-To: <CAFEAcA8mygA035i3VSEGzQWppCDaUz0HM5mNU9DvTsOjei1F8Q@mail.gmail.com>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 <CAFEAcA8mygA035i3VSEGzQWppCDaUz0HM5mNU9DvTsOjei1F8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10 Jul 2026, at 18:05, Peter Maydell wrote:

> On Wed, 1 Jul 2026 at 18:31, Emmanuel Blot <emmanuel.blot@free.fr> wrot=
e:
>>
>> Slaves created with i2c_slave_create_simple() were left unparented and=

>> showed up under /machine/unattached with no stable QOM path. Add each
>> slave as a QOM child of its bus, named after its I2C address, so it ha=
s
>> a deterministic and addressable QOM path.
>
> Should devices on a bus be QOM children of the bus, though?
> I would expect that they ought to be QOM children of e.g.
> the SoC or machine that created them.
>
> Do we do this for other bus types, e.g. PCI ?

If we do not want a I2C device to be a child of its bus, an alternative p=
arent could be the master/controller of the bus. However as a controller =
may manage several buses, we need to add bus differentiator in the child =
name, such as bus_num:address.

I do not think it makes more sense to have the I2C device to be a child o=
f the SoC rather than its dedicated controller.

On machines that are statically defined rather than composed from the com=
mand line (BMCs, complex SoC-based machines, =E2=80=A6), all the I2C devi=
ces would appear as a =E2=80=9Cflat=E2=80=9D list of devices, with someti=
mes many instances of the same I2C device type belonging to very differen=
t sub-domains of the machine they instrument and/or drive.

I tend to think that using a flat schema would likely make use of QOM pat=
hs more difficult to observe and reach a device at run time: one would ha=
ve to iterate the device and bus hierarchy rather than to use QOM path to=
 access a device, or special care would be required for naming device ins=
tances. I was viewing the role of the QOM paths as a way to expose the ma=
chine device hierarchy as a comprehensive and non-ambiguous representatio=
n.

What are the cons for using the device/bus hierarchy for simple buses suc=
h as SPI & I2C?
Is there any drawback to use the device & bus hierarchy to assign a defau=
lt/fallback QOM path to a device?

Maybe it=E2=80=99s a matter of ownership? Neither the I2C. bus nor the I2=
C controller owns the device for sure.

Emmanuel.

