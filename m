Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F76AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTu0-0006BF-Dr; Wed, 26 Jun 2024 10:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sMTtf-0006AP-Rp
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:45:20 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sMTtc-0004HO-Bx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719413116; x=1750949116;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=F4Ti3nNp3iJGwKep6rqtMs+vDgXDQ5iV9R2dUH2838U=;
 b=fTW3wLYl7FV9Eo7JHafZd+oiPEdnBTJo6qkBJNyd+75RvYNutac8hSwt
 z1s5RFTgCFHO8DUcZoXpIzqK7pj2Y0Wc3KQJNdlEQ57X+NLh6ixWVOVee
 Cs9Ee3021tNCf0l3h4P0er6hiv1/gG8LObe+pcsyZxyFLKIJISTe80AkG
 6DULh4eOZxyO5Anl5ksn7UjsM4tzaBpKXRxebV74RQNLrChULned7pqK/
 fEhT65ZAzshh/DsMEjljdQIdXdjC8iS46Dn7HEb9uHWOpfiSQHdDtQYI/
 ofyvSHuBkVkRMT/NjVRMWDcO6fLCD8flgLC6QlQV3sCw2rkRg1lODzXbf A==;
X-CSE-ConnectionGUID: EX1Jmiu2Rn6tihMCvlVpcA==
X-CSE-MsgGUID: VSCpRt3yRDOazE3vwFXNyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16170472"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; d="scan'208";a="16170472"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 07:45:13 -0700
X-CSE-ConnectionGUID: blcJLqYrSlSELIZ/MnBaRA==
X-CSE-MsgGUID: 9HdHO5K0S2KeOIa/520u2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; d="scan'208";a="74796260"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.51])
 ([10.124.227.51])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 07:45:07 -0700
Message-ID: <73cd4590-19c1-43e6-b861-c6ef9abb0f95@intel.com>
Date: Wed, 26 Jun 2024 22:45:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-26-xiaoyao.li@intel.com> <ZmGTXP36B76IRalJ@redhat.com>
 <90739246-f008-4cf2-bcf5-8a243e2b13d4@intel.com>
 <SJ0PR11MB674430CD121A9F91D818A67092C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a5d434b5-c1c2-451c-9181-3c9eacbc2999@intel.com>
 <Zmv2DQQMndYq4LmY@redhat.com> <ZnmKQeMtOq8dyWjC@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZnmKQeMtOq8dyWjC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.525, HK_RANDOM_FROM=0.467, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/24/2024 11:01 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 14, 2024 at 08:49:57AM +0100, Daniel P. Berrangé wrote:
>> On Fri, Jun 14, 2024 at 09:04:33AM +0800, Xiaoyao Li wrote:
>>> On 6/13/2024 4:35 PM, Duan, Zhenzhong wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Li, Xiaoyao <xiaoyao.li@intel.com>
>>>>> Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
>>>>> tdx-guest object
>>>>>
>>>>> On 6/6/2024 6:45 PM, Daniel P. Berrangé wrote:
>>>>>> Copying  Zhenzhong Duan as my point relates to the proposed libvirt
>>>>>> TDX patches.
>>>>>>
>>>>>> On Thu, Feb 29, 2024 at 01:36:46AM -0500, Xiaoyao Li wrote:
>>>>>>> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it
>>>>> disables
>>>>>>> EPT violation conversion to #VE on guest TD access of PENDING pages.
>>>>>>>
>>>>>>> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
>>>>>>> Otherwise refuse to boot.
>>>>>>>
>>>>>>> Add sept-ve-disable property for tdx-guest object, for user to configure
>>>>>>> this bit.
>>>>>>>
>>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>> ---
>>>>>>> Changes in v4:
>>>>>>> - collect Acked-by from Markus
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>> - update the comment of property @sept-ve-disable to make it more
>>>>>>>      descriptive and use new format. (Daniel and Markus)
>>>>>>> ---
>>>>>>>     qapi/qom.json         |  7 ++++++-
>>>>>>>     target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>>>>>>>     2 files changed, 30 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>>>> index 220cc6c98d4b..89ed89b9b46e 100644
>>>>>>> --- a/qapi/qom.json
>>>>>>> +++ b/qapi/qom.json
>>>>>>> @@ -900,10 +900,15 @@
>>>>>>>     #
>>>>>>>     # Properties for tdx-guest objects.
>>>>>>>     #
>>>>>>> +# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
>>>>>>> +#     of EPT violation conversion to #VE on guest TD access of PENDING
>>>>>>> +#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>>>>>> +#     be set, otherwise they refuse to boot.
>>>>>>> +#
>>>>>>>     # Since: 9.0
>>>>>>>     ##
>>>>>>>     { 'struct': 'TdxGuestProperties',
>>>>>>> -  'data': { }}
>>>>>>> +  'data': { '*sept-ve-disable': 'bool' } }
>>>>>>
>>>>>> So this exposes a single boolean property that gets mapped into one
>>>>>> specific bit in the TD attributes:
>>>>>>
>>>>>>> +
>>>>>>> +static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error
>>>>> **errp)
>>>>>>> +{
>>>>>>> +    TdxGuest *tdx = TDX_GUEST(obj);
>>>>>>> +
>>>>>>> +    if (value) {
>>>>>>> +        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
>>>>>>> +    } else {
>>>>>>> +        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
>>>>>>> +    }
>>>>>>> +}
>>>>>>
>>>>>> If I look at the documentation for TD attributes
>>>>>>
>>>>>>      https://download.01.org/intel-sgx/latest/dcap-
>>>>> latest/linux/docs/Intel_TDX_DCAP_Quoting_Library_API.pdf
>>>>>>
>>>>>> Section "A.3.4. TD Attributes"
>>>>>>
>>>>>> I see "TD attributes" is a 64-bit int, with 5 bits currently
>>>>>> defined "DEBUG", "SEPT_VE_DISABLE", "PKS", "PL", "PERFMON",
>>>>>> and the rest currently reserved for future use. This makes me
>>>>>> wonder about our modelling approach into the future ?
>>>>>>
>>>>>> For the AMD SEV equivalent we've just directly exposed the whole
>>>>>> field as an int:
>>>>>>
>>>>>>         'policy' : 'uint32',
>>>>>>
>>>>>> For the proposed SEV-SNP patches, the same has been done again
>>>>>>
>>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2024-
>>>>> 06/msg00536.html
>>>>>>
>>>>>>         '*policy': 'uint64',
>>>>>>
>>>>>>
>>>>>> The advantage of exposing individual booleans is that it is
>>>>>> self-documenting at the QAPI level, but the disadvantage is
>>>>>> that every time we want to expose ability to control a new
>>>>>> bit in the policy we have to modify QEMU, libvirt, the mgmt
>>>>>> app above libvirt, and whatever tools the end user has to
>>>>>> talk to the mgmt app.
>>>>>>
>>>>>> If we expose a policy int, then newly defined bits only require
>>>>>> a change in QEMU, and everything above QEMU will already be
>>>>>> capable of setting it.
>>>>>>
>>>>>> In fact if I look at the proposed libvirt patches, they have
>>>>>> proposed just exposing a policy "int" field in the XML, which
>>>>>> then has to be unpacked to set the individual QAPI booleans
>>>>>>
>>>>>>
>>>>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/WXWX
>>>>> EESYUA77DP7YIBP55T2OPSVKV5QW/
>>>>>>
>>>>>> On balance, I think it would be better if QEMU just exposed
>>>>>> the raw TD attributes policy as an uint64 at QAPI, instead
>>>>>> of trying to unpack it to discrete bool fields. This gives
>>>>>> consistency with SEV and SEV-SNP, and with what's proposed
>>>>>> at the libvirt level, and minimizes future changes when
>>>>>> more policy bits are defined.
>>>>>
>>>>> The reasons why introducing individual bit of sept-ve-disable instead of
>>>>> a raw TD attribute as a whole are that
>>>>>
>>>>> 1. other bits like perfmon, PKS, KL are associated with cpu properties,
>>>>> e.g.,
>>>>>
>>>>> 	perfmon -> pmu,
>>>>> 	pks -> pks,
>>>>> 	kl -> keylokcer feature that QEMU currently doesn't support
>>>>>
>>>>> If allowing configuring attribute directly, we need to deal with the
>>>>> inconsistence between attribute vs cpu property.
>>>>
>>>> What about defining those bits associated with cpu properties reserved
>>>> But other bits work as Daniel suggested way.
>>>
>>> I don't understand. Do you mean we provide the interface to configure raw 64
>>> bit attributes while some bits of it are reserved?
>>
>> Just have a mask of what bits are permitted to be set, and report an
>> error if the user sets non-permitted bits.
> 
> Looking at the IGVM patches, the CnofidentialGuestSupport class is
> gaining a "set_guest_policy" method, which takes a "uint64_t policy".
> 
> If (when) IGVM support is extended to cover TDX too, then we're
> going to need to accept the user providing the policy in integer
> format via the IGVM file metadata. This will require adding code
> to check for any inconsistency between the policy bitmask, and
> the CPU flags.
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg04037.html

Just have a glance at the IGVM series (which is a news to me). The IGVM 
series looks specific to SEV-*. Though some of the callbacks introduced 
in ConfidentialGuestSupportClass can be tweaked for TDX, but the 
arguments introduced are specific to SEV-*.

Aside from above, are you going to map (sev-*)'s policy to TDX's 
attributes? I don't think it is a good idea. It mixes up things with 
limited benefit. To me, the common of them is only they are both  64-bit 
field.

> so to me this is another reason to just expose the policy as an
> integer in the QAPI/QOM structure too. Everywhere just wants to
> be working with policy in integer format.

I'm not reluctant to expose TD's attribute as a raw 64-bit data in QAPI 
structure. I just don't like the idea of the permitted mask, which makes 
the 64-bit field incomplete, and makes things complicated. People need 
to learn that some bits are configured in attribute directly while other 
bits are configured via cpu properties indirectly.

Maybe we can allow the direct configurability of raw 64-bit attribute 
and give it highest priority. If inconsistent value is provided via cpu 
properties, warn it and let the attribute value overwrite CPU properties?

> With regards,
> Daniel


