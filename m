Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E437CED63A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKmE-0007YE-T7; Tue, 18 Nov 2025 07:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vLKm5-0007XM-3G; Tue, 18 Nov 2025 07:25:33 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vLKm3-0006HT-Bg; Tue, 18 Nov 2025 07:25:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45DF15969F6;
 Tue, 18 Nov 2025 13:25:25 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id sKG9FCTcYWUt; Tue, 18 Nov 2025 13:25:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 368C05969F9; Tue, 18 Nov 2025 13:25:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 343F65969F6;
 Tue, 18 Nov 2025 13:25:23 +0100 (CET)
Date: Tue, 18 Nov 2025 13:25:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Bernhard Beschow <shentey@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 1/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <8a86dfaf-eba5-4348-8885-58c520355e47@linaro.org>
Message-ID: <6e77db29-fb0a-7beb-3cb6-5ab14b3a86cf@eik.bme.hu>
References: <20251101120130.236721-1-shentey@gmail.com>
 <20251101120130.236721-2-shentey@gmail.com> <87v7j8r399.fsf@redhat.com>
 <CAFEAcA_XORdwONC2YbVKPois6BLPEr0dFt_QjTHE=UWmiCiv-g@mail.gmail.com>
 <2EAC1B70-89DE-4694-A4E8-350DC6F9C343@gmail.com>
 <8a86dfaf-eba5-4348-8885-58c520355e47@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1635749800-1763468723=:81993"
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

--3866299591-1635749800-1763468723=:81993
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 18 Nov 2025, Philippe Mathieu-Daudé wrote:
> On 18/11/25 10:49, Bernhard Beschow wrote:
>> Am 17. November 2025 17:38:03 UTC schrieb Peter Maydell 
>> <peter.maydell@linaro.org>:
>>> On Mon, 17 Nov 2025 at 17:13, Cornelia Huck <cohuck@redhat.com> wrote:
>>>> Running current master (resp. with this patch applied), I'm getting make
>>>> check failures on an aarch64 (Mt. Snow) host ("qemu-system-aarch64:
>>>> unknown type 'arm-gicv3'" while using this machine); going back right
>>>> before this patch, everything works fine. Haven't tried to debug this
>>>> yet (maybe I'm the one with the weird config again...)
>>> 
>>> Is this a KVM-only config (no TCG) ?
>>> 
>>> I think this happens because the KConfig now says
>>> +    depends on TCG || KVM
>>> 
>>> but because the machine by default doesn't use KVM then
>>> trying to run the machine with no extra arguments falls
>>> over if TCG isn't present.
>>> 
>>> This thing we put in to handle "creation of the SoC object
>>> via device introspection means it doesn't have an ms->cpu_type
>>> to look at":
>>> 
>>> +    const char *cpu_type = ms->cpu_type ?: 
>>> ARM_CPU_TYPE_NAME("cortex-a53");
>>> 
>>> also probably won't do anything useful under a KVM-only config.
>>> 
>>> I think the simplest thing here is to put the KConfig back to:
>>>
>>>   depends on TCG && AARCH64
>>> 
>>> People building a KVM-only config almost certainly do not
>>> want this machine type and its devices, because the main
>>> reason to build KVM-only is because you're in the
>>> "virtualization use case" and want to not build in a
>>> load of not-security-supported machine types.
>> 
>> Do we need this treatment for further machines, e.g. isapc, e500, mips? Or 
>> shall the CPU type handling in the SoC consider kvm_enabled()?
>
> Good point. My understanding is only virt x86/arm/ppc64/s390x are
> "security covered", but there is no explicit mention of that in
> our doc. (btw why not include isapc? as it is a subset of other
> covered x86 machines?)

Maybe because you can't run isapc with KVM because it's limited to Pentium 
but 32bit host support is removed? Or should we keep the ability to run it 
with newer CPUs for KVM?

Regards,
BALATON Zoltan
--3866299591-1635749800-1763468723=:81993--

