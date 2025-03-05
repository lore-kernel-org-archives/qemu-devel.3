Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CEEC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 13:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpohN-0006dm-6X; Wed, 05 Mar 2025 08:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpohD-0006ci-7c
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:22:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpohA-0002Up-Sx
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:21:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A08704E6010;
 Wed, 05 Mar 2025 14:21:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Iw_l0mHm6OO4; Wed,  5 Mar 2025 14:21:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5E5174E6004; Wed, 05 Mar 2025 14:21:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5BC2874577C;
 Wed, 05 Mar 2025 14:21:50 +0100 (CET)
Date: Wed, 5 Mar 2025 14:21:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Eric Auger <eric.auger@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host platforms
 only
In-Reply-To: <c37bff90-72f2-4f82-94b0-e2ea63684b35@redhat.com>
Message-ID: <c51cd207-d206-5f35-f140-b58dc88c0a91@eik.bme.hu>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
 <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
 <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
 <2ccd4a87-68f3-4eb1-bc2a-dbc424bc8d34@linaro.org>
 <c37bff90-72f2-4f82-94b0-e2ea63684b35@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2081135561-1741180910=:99649"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2081135561-1741180910=:99649
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 5 Mar 2025, Thomas Huth wrote:
> On 03/03/2025 18.32, Philippe Mathieu-Daudé wrote:
>> On 3/3/25 17:57, Peter Maydell wrote:
>>> On Mon, 3 Mar 2025 at 15:49, Cédric Le Goater <clg@redhat.com> wrote:
>>>> Why are we keeping qemu-system-ppc and qemu-system-i386, and arm,
>>>> since qemu-system-ppc64 and qemu-system-x86_64 should be able to
>>>> run the same machines ?
>>> 
>>> They're not identical -- for example "-cpu max" on
>>> qemu-system-arm is a 32-bit CPU but on qemu-system-aarch64
>>> it is a 64-bit CPU.
>>> 
>>> There's definitely a lot of overlap but we can't just drop
>>> the -arm executable until/unless we figure out what to do
>>> about the corner cases where they are different. Plus there's
>>> a lot of users out there with existing command lines and
>>> configs that assume the existence of a qemu-system-arm
>>> executable.
>> 
>> Thomas and myself have been trying to sort that out. Now with the
>> single-binary effort, it gained new interest. This hasn't be a trivial
>> task so far, due to as you mentioned the legacy CLI uses and migration.
>
> FWIW, here's my former attempt to see whether we could move into that 
> direction:
>
> https://lore.kernel.org/qemu-devel/20230425133851.489283-1-thuth@redhat.com/

This mentions KVM compatibility. KVM now works at least on PowerPC G4 host 
with qemu-system-ppc (as I've heard, did not try it myself). Would that 
stop working with qemu-system-ppc64? As people still use old 32bit PPC 
OSes such as MacOS with qemu it's still wanted to keep it working. 
(Although most people use TCG on other hosts and maybe a few on actual PPC 
host but it's still nice to keep this feature until such hosts still 
exist.)

Regards,
BALATON Zoltan

> In the end, it was too frustrating to struggle with the 
> backwards-compatibility questions (do we really need to keep qemu-system-i386 
> around forever?), so I pretty much gave up on that patch series.

--3866299591-2081135561-1741180910=:99649--

