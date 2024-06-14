Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A28C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHvNQ-0005Ly-R6; Thu, 13 Jun 2024 21:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHvND-0005G5-T6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 21:05:01 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHvN2-0002CH-3C
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 21:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718327088; x=1749863088;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D53EUNtisD/7B6C3C/nJAv5wz7xFtVP26feE2TvDBds=;
 b=SlNfTSKJMifkGqqmkAAJvP3xdpYjfD9v/CQ0CCB1RPmGvZse9vtv+ouk
 4tDaY4mHvWNw7QfI4liyIYpL85mMGJtO7obZSFIfkCXVDiDKtZK0UQoXV
 gKgYo5F04W21eKlDN2f4e1vukLWEnN/yapai3l4u2dnUuxZXdb+aT25BD
 tGMHrfCAS6/XTG5XHpSA+wFfmQrNZZ3kGTat2NHafoqHJGBOxVBWMxSnw
 6pXVIAA9bpR7LpA/lBN0JARHIRqmsBFw5LREEcVZQ7Bnd42XxHQu5lOJ8
 lfIctdTWISK8QwOx53GYQ5KyqdjJJ+oWm/x4pMJ4ku/ApZw7ofgukkF1n g==;
X-CSE-ConnectionGUID: OgrrC7DIQmS5ELLeT6Pqbw==
X-CSE-MsgGUID: 6BbKmeCBQuShu2dsw0rPUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32672788"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; d="scan'208";a="32672788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 18:04:47 -0700
X-CSE-ConnectionGUID: +I0WkiJ3R+GhmvqUMIPdUA==
X-CSE-MsgGUID: BEMWjHzIRbaZx8vlix0PJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; d="scan'208";a="71547836"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.51])
 ([10.124.227.51])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 18:04:35 -0700
Message-ID: <a5d434b5-c1c2-451c-9181-3c9eacbc2999@intel.com>
Date: Fri, 14 Jun 2024 09:04:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <SJ0PR11MB674430CD121A9F91D818A67092C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/2024 4:35 PM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Li, Xiaoyao <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
>> tdx-guest object
>>
>> On 6/6/2024 6:45 PM, Daniel P. Berrangé wrote:
>>> Copying  Zhenzhong Duan as my point relates to the proposed libvirt
>>> TDX patches.
>>>
>>> On Thu, Feb 29, 2024 at 01:36:46AM -0500, Xiaoyao Li wrote:
>>>> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it
>> disables
>>>> EPT violation conversion to #VE on guest TD access of PENDING pages.
>>>>
>>>> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
>>>> Otherwise refuse to boot.
>>>>
>>>> Add sept-ve-disable property for tdx-guest object, for user to configure
>>>> this bit.
>>>>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>> Changes in v4:
>>>> - collect Acked-by from Markus
>>>>
>>>> Changes in v3:
>>>> - update the comment of property @sept-ve-disable to make it more
>>>>     descriptive and use new format. (Daniel and Markus)
>>>> ---
>>>>    qapi/qom.json         |  7 ++++++-
>>>>    target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>>>>    2 files changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index 220cc6c98d4b..89ed89b9b46e 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -900,10 +900,15 @@
>>>>    #
>>>>    # Properties for tdx-guest objects.
>>>>    #
>>>> +# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
>>>> +#     of EPT violation conversion to #VE on guest TD access of PENDING
>>>> +#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>>> +#     be set, otherwise they refuse to boot.
>>>> +#
>>>>    # Since: 9.0
>>>>    ##
>>>>    { 'struct': 'TdxGuestProperties',
>>>> -  'data': { }}
>>>> +  'data': { '*sept-ve-disable': 'bool' } }
>>>
>>> So this exposes a single boolean property that gets mapped into one
>>> specific bit in the TD attributes:
>>>
>>>> +
>>>> +static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error
>> **errp)
>>>> +{
>>>> +    TdxGuest *tdx = TDX_GUEST(obj);
>>>> +
>>>> +    if (value) {
>>>> +        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
>>>> +    } else {
>>>> +        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
>>>> +    }
>>>> +}
>>>
>>> If I look at the documentation for TD attributes
>>>
>>>     https://download.01.org/intel-sgx/latest/dcap-
>> latest/linux/docs/Intel_TDX_DCAP_Quoting_Library_API.pdf
>>>
>>> Section "A.3.4. TD Attributes"
>>>
>>> I see "TD attributes" is a 64-bit int, with 5 bits currently
>>> defined "DEBUG", "SEPT_VE_DISABLE", "PKS", "PL", "PERFMON",
>>> and the rest currently reserved for future use. This makes me
>>> wonder about our modelling approach into the future ?
>>>
>>> For the AMD SEV equivalent we've just directly exposed the whole
>>> field as an int:
>>>
>>>        'policy' : 'uint32',
>>>
>>> For the proposed SEV-SNP patches, the same has been done again
>>>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2024-
>> 06/msg00536.html
>>>
>>>        '*policy': 'uint64',
>>>
>>>
>>> The advantage of exposing individual booleans is that it is
>>> self-documenting at the QAPI level, but the disadvantage is
>>> that every time we want to expose ability to control a new
>>> bit in the policy we have to modify QEMU, libvirt, the mgmt
>>> app above libvirt, and whatever tools the end user has to
>>> talk to the mgmt app.
>>>
>>> If we expose a policy int, then newly defined bits only require
>>> a change in QEMU, and everything above QEMU will already be
>>> capable of setting it.
>>>
>>> In fact if I look at the proposed libvirt patches, they have
>>> proposed just exposing a policy "int" field in the XML, which
>>> then has to be unpacked to set the individual QAPI booleans
>>>
>>>
>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/WXWX
>> EESYUA77DP7YIBP55T2OPSVKV5QW/
>>>
>>> On balance, I think it would be better if QEMU just exposed
>>> the raw TD attributes policy as an uint64 at QAPI, instead
>>> of trying to unpack it to discrete bool fields. This gives
>>> consistency with SEV and SEV-SNP, and with what's proposed
>>> at the libvirt level, and minimizes future changes when
>>> more policy bits are defined.
>>
>> The reasons why introducing individual bit of sept-ve-disable instead of
>> a raw TD attribute as a whole are that
>>
>> 1. other bits like perfmon, PKS, KL are associated with cpu properties,
>> e.g.,
>>
>> 	perfmon -> pmu,
>> 	pks -> pks,
>> 	kl -> keylokcer feature that QEMU currently doesn't support
>>
>> If allowing configuring attribute directly, we need to deal with the
>> inconsistence between attribute vs cpu property.
> 
> What about defining those bits associated with cpu properties reserved
> But other bits work as Daniel suggested way.

I don't understand. Do you mean we provide the interface to configure 
raw 64 bit attributes while some bits of it are reserved?

> Thanks
> Zhenzhong
> 
>>
>> 2. people need to know the exact bit position of each attribute. I don't
>> think it is a user-friendly interface to require user to be aware of
>> such details.
>>
>> For example, if user wants to create a Debug TD, user just needs to set
>> 'debug=on' for tdx-guest object. It's much more friendly than that user
>> needs to set the bit 0 of the attribute.
>>
>>
>>>> +
>>>>    /* tdx guest */
>>>>    OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>>>>                                       tdx_guest,
>>>> @@ -529,6 +549,10 @@ static void tdx_guest_init(Object *obj)
>>>>        qemu_mutex_init(&tdx->lock);
>>>>
>>>>        tdx->attributes = 0;
>>>> +
>>>> +    object_property_add_bool(obj, "sept-ve-disable",
>>>> +                             tdx_guest_get_sept_ve_disable,
>>>> +                             tdx_guest_set_sept_ve_disable);
>>>>    }
>>>>
>>>>    static void tdx_guest_finalize(Object *obj)
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> With regards,
>>> Daniel
> 


