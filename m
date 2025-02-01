Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A282C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 12:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teD4a-0006uK-A6; Sat, 01 Feb 2025 07:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1teD4X-0006tN-Vy; Sat, 01 Feb 2025 07:58:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1teD4W-0006jl-7U; Sat, 01 Feb 2025 07:58:05 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1CB194E6005;
 Sat, 01 Feb 2025 13:57:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NbOq-EX56cOw; Sat,  1 Feb 2025 13:57:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2CC544E6019; Sat, 01 Feb 2025 13:57:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2ABEA74577C;
 Sat, 01 Feb 2025 13:57:56 +0100 (CET)
Date: Sat, 1 Feb 2025 13:57:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 devel@lists.libvirt.org
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of
 DRAM
In-Reply-To: <20250201091528.1177-1-philmd@linaro.org>
Message-ID: <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
References: <20250201091528.1177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-595375333-1738414184=:33237"
Content-ID: <41e0dd69-157e-7e24-7b0f-bec2d0eef23c@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-595375333-1738414184=:33237
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <1d22ae7b-5e8f-9543-38b8-cba62d89b36e@eik.bme.hu>

On Sat, 1 Feb 2025, Philippe Mathieu-Daudé wrote:
> - Deprecate the 'raspi4b' machine name, renaming it as
>  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
> - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
>  respectively 4GB and 8GB of DRAM.

IMHO (meaning you can ignore it, just my opinion) if the only difference 
is the memory size -machine raspi4b -memory 4g would be better user 
experience than having a lot of different machines. Or if you want to 
emphasize these are tied to revisions maybe -machine raspi4b,revision=1.4 
could be used. You can say that -machine help listing different versions 
is easier to find but if it's the same machine with different options then 
this should be a machine option, then you can use -machine raspi4b,help to 
find the options specific to the machine. Memory size is normally set with 
-memory so that could also select the revision as a convenience if this 
is tied to a specific revision.

Regards,
BALATON Zoltan

> Philippe Mathieu-Daudé (7):
>  hw/arm/raspi4b: Declare machine types using DEFINE_TYPES() macro
>  hw/arm/raspi4b: Introduce abstract raspi4-base machine type
>  hw/arm/raspi4b: Split raspi4b_machine_class_init() in two (1g and 2g)
>  hw/arm/raspi4b: Rename as raspi4b-1g / raspi4b-2g, deprecating old
>    name
>  hw/arm/raspi4b: Expose the raspi4b-1g machine on 64-bit hosts
>  hw/arm/raspi4b: Add the raspi4b-4g machine
>  hw/arm/raspi4b: Add the raspi4b-8g machine
>
> docs/about/deprecated.rst |  6 +++
> hw/arm/raspi4b.c          | 91 +++++++++++++++++++++++++++++++--------
> 2 files changed, 79 insertions(+), 18 deletions(-)
>
>
--3866299591-595375333-1738414184=:33237--

