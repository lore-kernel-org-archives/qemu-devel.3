Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D2C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woiF5-0007jA-SA; Tue, 28 Jul 2026 09:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woiF3-0007if-JZ; Tue, 28 Jul 2026 09:53:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woiF0-0001F4-A4; Tue, 28 Jul 2026 09:53:09 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66SDqp8l070066
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 22:52:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nQHW/sr4AZIMKp0yFNZIgwtSy/2mIDNrqiKgqm/oifQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785246771; v=1;
 b=JV5usYJ+cIS9xfS3Uopr7sJZgwcv3jmYmmKR1eDqQCMB6U9jBR8xpAPnS4x3UU07
 J8Le8smdus3mn6VFycUCEOa6mkG5dswIfPRkre1P7/PO09FG30JR1ktNsdBncOib
 Nb5ICY/nbg4X+7Muoy7dM9UktteNBAumBptiXpNNr0/KuBgSMQ44GjS45mLaRrHR
 UDdiXEjVuKPSBWhYeDyTGE9N++fk6lWnFQ8a4onja3HIVUhS9d8S+1OLAOvf551x
 vdMMZ/n1VtMgCp48ldlVOmzLf2TMExAuFjiF+AjXlWEoTMG+WQmIFLQvl/wQ9ybN
 VKxKedYY3+t9UUXupGnvrQ==
Message-ID: <78b94211-72ee-481f-8809-ee786e3389c1@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 22:52:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v7] target/arm: Always add pmu property for host and max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 devel@daynix.com
References: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA-=u3ZgiAXRNWM1VCMv7FYG2YP=oirf40yGo--p0BSfbg@mail.gmail.com>
 <39e270ed-1667-4bbf-8732-913e8b1f87e8@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA-_mSr0e8yePxoxW2wS7xAHtTzd8S5MfLWwr_BPkAD+Rg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-_mSr0e8yePxoxW2wS7xAHtTzd8S5MfLWwr_BPkAD+Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/28 18:40, Peter Maydell wrote:
> On Tue, 28 Jul 2026 at 10:33, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/07/28 1:10, Peter Maydell wrote:
>>> On Mon, 29 Jun 2026 at 09:10, Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>
>>>> kvm-steal-time and sve properties are added for KVM even if the
>>>> corresponding features are not available. Always add pmu property for
>>>> "host" and "max".
>>>>
>>>> Note that we still don't add the property for other CPUs that lack PMU.
>>>> This is because we do not know what a PMU version should be enabled
>>>> when the user sets the property to true while it is defined as an error
>>>> for the "host" or "max" CPU when the hardware accelerator is enabled and
>>>> the host doesn't have a PMU.
>>>>
>>>> This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
>>>> KVM but doesn't support PMU emulation.
>>>
>>> No, we should not special case "host" and "max" like this.
>>> The "pmu" property exists only if the CPU has a PMU and it can
>>> be turned off. If The arm-cpu-features test assumes that the
>>> host CPU always has a PMU and so always has the property, then
>>> that's a bug in the test, not in the code handling the property.
>>
>> The test correctly avoids assuming that the host always has a PMU. It
>> expects that the run-time-derived "host" CPU has a stable "pmu"
>> property, with its value reporting whether PMU is available.
> 
> That is not a valid expectation currently, because that's not
> how the property behaves (and is not how many of the Arm CPU
> properties behave). If we (as has been proposed) refactor Arm CPU
> properties so that they're class properties rather than object
> properties then we will have a property that is present always.
> I don't inherently object to doing that.
> 
>> That is already how Arm handles SVE. Commit d25293068b03 ("target/arm:
>> Move kvm test out of cpu_arm_set_sve") added a false SVE property when
>> KVM lacks SVE. PAuth and kvm-steal-time use the same general model.
>> Other architectures do the similar; for example LoongArch KVM does
>> exactly this for "pmu". So we are avoiding special-casing the Arm pmu
>> property here.
>>
>> The comment in aarch64_add_sve_properties() gives the rationale
>> explicitly: "to allow -cpu max,sve=off to always be valid." sve=on still
>> fails in that case. Keeping the property stable prevents -cpu
>> host,pmu=off from becoming invalid on hosts where the PMU cannot be
>> enabled. This also matters outside the test: libvirt emits pmu=off when
>> the PMU is explicitly disabled. This design is intended to follow the
>> alternative you described previously [1].
>>
>> "host" and "max" are special-cased for a different reason. For fixed Arm
>> CPU models, the property is omitted because its semantics is not defined
>> when they don't have PMUs. "host" and "max" are different: "host" and
>> "max" enable whatever PMU available, and fail otherwise.
> 
> We should not special case "host" and "max". If we want an "always present"
> property then its semantics should be:
>   - always exists for all CPUs
>   - if the CPU can't support a PMU then you can't set it to "on"

This patch follows the behavior of the sve property. Although sve is 
registered with object_property_add_bool(), the presence of the property 
is determined per class basis: the arm-cpu-host and arm-cpu-max classes 
always expose it, while the other arm-cpu subclasses expose it only when 
they support SVE.

As I quoted earlier, the SVE code explicitly documents why the property 
should be always present for the host and max CPUs, and 
qtest-aarch64/arm-cpu-features tests that along with the pmu property, 
so I would prefer to maintain consistency here unless there is a reason 
to do otherwise.

That said, the SVE code does not explain why the property must be 
*absent* for fixed CPU models that lack the feature, so there is 
certainly room to refine that design uniformly. Please note that the 
current test case contains dead code asserting that the property is 
absent on AArch32 CPUs when running KVM, which might need to be updated.

Regards,
Akihiko Odaki

