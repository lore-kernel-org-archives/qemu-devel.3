Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5Ar-00083y-FC; Wed, 31 Jul 2024 04:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sZ5Aq-00082i-2m
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sZ5Ao-0006T6-19
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722416342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B00dqsZl93ZOFg9XX3JQkvApGdHnk7JHXvr6uS0+a2E=;
 b=Nnp99fJTw1BZxm8Iiz6F+sQvbXXZux4G5h3VXe4mkT24+XxtX8S8ZAa43hZ06WY2BE4lXI
 x935W8LibbUv2XyUNtmKGR93szsREDIGDE5B5FDxDdVvFHqtiV0QEmw3UbvNrSCIri6cBm
 a5IGGYLFVdfkhwCExFcM6KBr8oWMV+s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-2J0tSMBqMgSePs7rvU5sgQ-1; Wed, 31 Jul 2024 04:59:00 -0400
X-MC-Unique: 2J0tSMBqMgSePs7rvU5sgQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2f01b9ae749so51642691fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722416339; x=1723021139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B00dqsZl93ZOFg9XX3JQkvApGdHnk7JHXvr6uS0+a2E=;
 b=q7NwspmSHzASha+CCndnVlWFETz44l9ao4ggX1Js+QDTpbMfy63DAEwfppjwGMTjQg
 kUVsJTF28cTG3aT8mPgTxowLqK7Loh0rRvy5nvpo68lZoNa03mKJk854RY7lw62tdtF4
 AWOSVsxhe7qCrotIR0N99sWwMY08i9sb+/H/pDFQpUb0Mjev7kA5UKuUEHsg/6oBL07Q
 kKgNxgRfQF9ImmWZwnpwYdgwfscAEYNYvtayXS0MQZyMBacT6RebT3AjWUHq0Q9RYfty
 sQ15R3nEs1wU3bwN2YxBGafOppnQnll+PsK8GDS7Pj6bhXGHwh1I4O31ryOlH4LLC4Xe
 ukEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjDMOjJ/es/0f4y+pUNyzOHalNZrxidv9TyxmzURL2T0KtwaX2p/57NgHHYLfddoefzGnQv+lbP/DVfmiX7wmITPUGmPo=
X-Gm-Message-State: AOJu0Yww49OlMhn7xEOZg5CyTNT/O7ieEu7JqCa47ESqSYbIMd9iluEF
 y7emQPtlD4SCi5JKQMmgoU9W4u4/gghNAgyn69VO7AQyijyxb34DP+bfxmhXFLARzy5CHARPnsA
 swFnznbg4rSjLcdZz/ipWyjCsj3Auc/G9RGmsXoaRbjaMvDO1IIpv
X-Received: by 2002:a2e:988f:0:b0:2ef:2eb9:5e55 with SMTP id
 38308e7fff4ca-2f12ecd2b00mr87278851fa.13.1722416339345; 
 Wed, 31 Jul 2024 01:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfNL/bM1TsiZtwmtuJrb+45zwLHzO7277P8Z1FocWZwXISesfwIUUXTfk8fp5vrwx+RjrGfw==
X-Received: by 2002:a2e:988f:0:b0:2ef:2eb9:5e55 with SMTP id
 38308e7fff4ca-2f12ecd2b00mr87278661fa.13.1722416338893; 
 Wed, 31 Jul 2024 01:58:58 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-tou-1-3-122.w86-201.abo.wanadoo.fr.
 [86.201.10.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8ada7esm13723515e9.15.2024.07.31.01.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 01:58:58 -0700 (PDT)
Message-ID: <1dd86a97-f81b-41aa-b7f7-8a31fe7849b5@redhat.com>
Date: Wed, 31 Jul 2024 10:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
 <20240730073712-mutt-send-email-mst@kernel.org>
 <125b333d-36a3-49d2-84e5-76a5f9d23a48@daynix.com>
 <20240730135602-mutt-send-email-mst@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240730135602-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/30/24 19:56, Michael S. Tsirkin wrote:
> On Tue, Jul 30, 2024 at 09:26:20PM +0900, Akihiko Odaki wrote:
>> On 2024/07/30 20:37, Michael S. Tsirkin wrote:
>>> On Mon, Jul 15, 2024 at 02:19:06PM +0900, Akihiko Odaki wrote:
>>>> Based-on: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>>>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>>
>>> OK I will revert this for now. We'll try again after the release,
>>> there will be time to address s390.
>>>
>>
>> I'd like to know if anybody wants to use igb on a s390x machine configured
>> with libvirt. Such a configuration is already kind of broken, and it is
>> likely to require significant effort on both side of libvirt and QEMU to fix
>> it.
> 
> 
> I assume Cédric wouldn't report it if was unused.
> 
> 
>> As an alternative, I'm also introducing SR-IOV support to virtio-net-pci. It
>> does not suffer the same problem with igb thanks to its flexible
>> configuration mechanism.
>>
>> Regards,
>> Akihiko Odaki
> 
> Sounds like this needs more review time, anyway.
> 
> 

Using an emulated IGB device in a s390x VM is not a common scenario.
The IGB device is not supported downstream (RHEL on Z). However, the
change broke the s390x machines I use for upstream QEMU development,
I removed the IGB device as a fix for now.

The Z PCI device model has 'uid' and 'fid' properties which are set
by the VMM, and in this case, they are auto-generated, hence the
conflicting ids with libvirt. This is Z specific but, possibly there
are subtle use cases on other platforms which could have similar
consequences. Something to be aware of.


Also, and this is why I thought it was important to report. Creating
PCI devices at machine init time (with -nodefaults) in the back of the
management layer is a no-no. libvirt requests to have full control
on the machine topology and this change seems like a violation of
this rule, even if VFs are kind of special.

Daniel, did I understand correctly the above constraint on the machine
definition ?


I can't say if we should revert for 9.1. Again, this Z is specific.
The changes were introduced to catch errors early when the PF device
is realized. There is no doubt they are useful. Some rework is needed
to avoid the conflicting id issue though.


Thanks,

C.




