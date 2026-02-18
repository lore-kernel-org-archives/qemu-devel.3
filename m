Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF5E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnwQ-0003dU-0N; Wed, 18 Feb 2026 15:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vsnwN-0003Yx-L4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:14:32 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vsnwL-0003Ke-Lk
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771445667; x=1772050467; i=deller@gmx.de;
 bh=OFPilNUOjaDHEebfl8aQB4Wm2mQXd9vIitVKCIdjuvY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lBCqDqnLzWWAzRmkPUJ5Llxzt/E+C3SmIYkdd9CmkBHy9SKeUMq95txL/vcxxpYJ
 8jFEu8B7O1//LElHFAY6IKqWpiuUVAbLqjEicihVULFCz73OCCs9hRm80LCD0BWpf
 8iBsFyaZ+H6BNVzs9mua1R4v53JpNwvf3h9oZAEfA2XeDZ0VzwDVZINC/k7qzRMNM
 bbtUZyrAnqrRiyNnZ/+RmbSwsYp6+U5ydwkSx3BrHOlCoaoz/xjPM1kDEU7VYPj31
 dq3x9mLvwanAFdHO5PPDGROq6cda+zW2aJ7ZLhB4PtmrrkLuiHMBfEJHstYFbM1nn
 G1I0x9a9A6kc57FVCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.198]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1vyaAJ41UL-00GBTV; Wed, 18
 Feb 2026 21:14:27 +0100
Message-ID: <6b1b9515-09e6-4ae8-b752-56069e3aed16@gmx.de>
Date: Wed, 18 Feb 2026 21:14:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
 <5ba38c75-e1c6-41cc-9a5d-b81c22527993@gmx.de>
 <aZYYIfiomDjmB-zn@hive.localdomain>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aZYYIfiomDjmB-zn@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:si2RQOtBTLj5zeWLUhrU6R4/ruU50XvLPqnr/tcYabxpOpLQmr4
 U1IXB6UAgXbgOK//Nle8eeezHRTi7ABUtb1+FdiUfadFAYUiNafONp2Vtk9VzXgSioSTcnq
 bub7IekEYZn8NPYB//ZRvqfDG7IFNzNwmEZrL7/g8RlnB4lSj58ciNsbCI/hjtcG5YAVjG9
 VlwllTnJWkFD219PAQGcw==
UI-OutboundReport: notjunk:1;M01:P0:FIwelfrm9h4=;9hjdYAWC5YZrYRfIsXov7MQETzX
 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
 wQrLTqos=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/18/26 20:55, Anton Johansson wrote:
> On 10/02/26, Helge Deller wrote:
>> On 2/10/26 17:37, Anton Johansson via qemu development wrote:
>>> This patchset tries to address a discrepancy between the C3700 machine
>>> in QEMU/SeaBIOS and the documentation (chapter 5)
>>>
>>>     http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf
>>>
>>> where 40 bits of physical address space are used in SeaBISO compared
>>
>> SeaBIOS (typo)
>>
>>> to the 44 bits specified in the documentation.
>>>
>>> A PA-8600 CPU with 40 bits of physical address space is added along wi=
th
>>> a C3600 machine using it by default.  AFAICT there are no major
>>> differences from QEMUs side between the PA-8600 and 8700 aside from th=
e
>>> physical address space size.  The PA-8700 machine can then be
>>> moved to using 44 bits.  To account for the discrepancy with SeaBIOS, =
the
>>> functional tests now run a C3700 but with a PA-8600 CPU.
>>>
>>> CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
>>> use a HPPACPUDef sturct to provide model specifics, similar to the SPA=
RC
>>> and RISCV targets.  This hopefully makes it easier to add other models=
,
>>> such as the 8800/8900.
>>>
>>> Based on:
>>>     PATCH v4 0/8] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
>>>     (20260210-phys_addr-v4-0-725a589e83c8@rev.ng)
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>
>> I like your patchset.
>> I'm just wondering if we should merge it with my upcoming new SeaBIOS,
>> which adds support for an A400 machine (with a PA8500 CPU).
>> So, instead of adding a C3600 machine, we could add the A400 which
>> has 40-bit physical addresss space too.
>> See:
>> https://github.com/hdeller/seabios-hppa/branches -> devel-v22 branch
>> and
>> https://github.com/hdeller/qemu-hppa/commit/1c969c925fb76236e76b09e011f=
07766ab4441cb
>>
>> In addition, I wonder what's necessary to change in SeaBIOS to fully
>> support the 40 and/or 44-bit case. It's easy to hand over the bits to
>> SeaBIOS, so SeaBIOS could do the right thing.
>>
>> Helge
>>
>=20
> Hi Helge,
>=20
> I submitted a rebased v3 with some minor spelling fixes.  If you want
> you can pick up the series, otherwise I'll swap out the C3600/PA-8600
> for a A400/PA-8500 and keep pushing it, whatever is easier for you.
>=20
> I need to look into the A400, is there some other change from the C3600
> I should be aware of?

I just sent out the patches. The qemu patches are trivial, and maybe
if you could review them they could go in fast.
IMHO it should be trivial to adjust your series to use the A400 instead.

Helge

