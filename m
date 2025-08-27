Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C08ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEgO-0003lT-9J; Wed, 27 Aug 2025 07:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1urEgF-0003gx-Nh
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:51:09 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1urEg8-0006Ls-HY
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756295460; x=1787831460;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=4Tvv9/Ts6beT8qdTQx1aR0LLVxS52gR3r/GM8mf/5sA=;
 b=gjHJxpLY9Fxd2byFv0K4kzXoEkP3elnagLnRS5KxTMA/EoEIG5zOVChX
 JmT2i07vpaQehiyUvHqdRU3D/0R/CPVw/Y3b1xLiyCPXxqVSgW/7RvTuS
 Dtm/epkZAFNZeBcYPQgnODiBPu9D5f17A1w99IGqs+5sW6HjT/BfPJ7+r
 kfrq7Yf7WZCaCpDiCrT0pu42o0iW0g0Vp0PskGpnUJlCz3aZYVBL8wwB0
 tbN0+Fn9Rw46gjsBNJ3knulyyGqiIYZkn9w+OfFswM8mnErKdTPIK3ftx
 fgl0sOfCYIN/khtOjF2XlD8ITuNbr9SEEq0cf6csjReymfcTwF/MmkHs2 w==;
X-CSE-ConnectionGUID: 0D1LkQrSTbOwzbhKIgqCvQ==
X-CSE-MsgGUID: Qh3RjVRAQl+noWZDjap7KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69640688"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69640688"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:50:56 -0700
X-CSE-ConnectionGUID: CZEQewQRTg+VO4zBp0OV1g==
X-CSE-MsgGUID: wopZ3+N1T3WsY0y1yt1HzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169339877"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:50:53 -0700
Message-ID: <a37565e6-77fc-4bf2-8c6b-6f1b22f6c01f@intel.com>
Date: Wed, 27 Aug 2025 19:50:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.675, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/27/2025 7:10 PM, Mark Cave-Ayland wrote:
> On 26/08/2025 08:25, Xiaoyao Li wrote:
> 
>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst 
>>> it is
>>> possible to specify any CPU via -cpu on the command line, it makes no
>>> sense to allow modern 64-bit CPUs to be used.
>>>
>>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>> handle the case where if a user inadvertently uses -cpu max then the 
>>> "best"
>>> 32-bit CPU is used (in this case the pentium3).
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index c03324281b..5720b6b556 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, int 
>>> value, Error **errp)
>>>   #ifdef CONFIG_ISAPC
>>>   static void pc_init_isa(MachineState *machine)
>>>   {
>>> +    /*
>>> +     * There is a small chance that someone unintentionally passes 
>>> "- cpu max"
>>> +     * for the isapc machine, which will provide a much more modern 
>>> 32-bit
>>> +     * CPU than would be expected for an ISA-era PC. If the "max" 
>>> cpu type has
>>> +     * been specified, choose the "best" 32-bit cpu possible which 
>>> we consider
>>> +     * be the pentium3 (deliberately choosing an Intel CPU given 
>>> that the
>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>> +     */
>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>> +        warn_report("-cpu max is invalid for isapc machine, using 
>>> pentium3");
>>> +    }
>>
>> Do we need to handle the case of "-cpu host"?
> 
> I don't believe so. I wasn't originally planning to support "-cpu max" 
> for isapc, however Daniel mentioned that it could possibly be generated 
> from libvirt so it makes sense to add the above check to warn in this 
> case and then continue.

"host" cpu type is the child of "max", so "-cpu host" will pass in the 
is_cpu_type_supported(), the same as "max".

While we are changing "max" to "pentium3", I think it needs to do the 
same for "host". Otherwise, "-cpu host" won't get any warning and expose 
the native features to the VMs that are mostly not supposed to exist for 
isapc, e.g., the LM CUPID bit.

