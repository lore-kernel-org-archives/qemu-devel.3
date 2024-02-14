Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B44C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHNC-0008JO-IF; Wed, 14 Feb 2024 10:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1raHNB-0008IX-BB
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1raHN9-0005zB-Eg
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707925229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmcNr6q+Rab2etzNgyUsclL5Xh5cujIF5uPU/yqcsBE=;
 b=cnbVIz5nxyesE5JWfB24gSsYcIUnnPJ/iRngx6fmcaA9AXdBgdGPKmTKVSDtycK3vropdN
 t58Ccxd3FFr10PR+dDSWsPJWt4HwikCzLVkCU1F7B7C9P0jANXd7UtTGmTb1mj16DhubhE
 RUi1fbVtjSnZpW3YvnRYmUVG6XeT+88=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-VuCFhK-yNS2tDobs-GJeBQ-1; Wed, 14 Feb 2024 10:40:26 -0500
X-MC-Unique: VuCFhK-yNS2tDobs-GJeBQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7816bea8d28so173083185a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707925226; x=1708530026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rmcNr6q+Rab2etzNgyUsclL5Xh5cujIF5uPU/yqcsBE=;
 b=vwinRzKrcYumsfmlFbwNTXeyDgIzz/STwxcVvsYPttVr03c2/Or7E3h768oVEenlbP
 VE+lG6BnX2n48tc9Z/QMSSnWOBgQmbEogpjdrHRH0Ub4bvJYNZ/TGEV2MbwyXX1/LSm0
 Eaf1P5n0+AD96eRS5iJgk7V8elUsrle4uAti+pHB/wN40pCwBU3afmuUT4ylMwZY0sxk
 i3DEolb6lhvM5LJwbIaQ74JnrfcfNbugmdgbhP0wthQO8FofkUyOad3xLr2Gp2bZ0AjQ
 Ha4CFmNX5j05y4tLX1fG8H6lurNsht8SYZtXqSINZDeel6Yy2kjvgFNj0uWYoGSdiAzd
 apBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULSqTmUWRC3HclibfH7BMl+cSuNHB22igVdOP2SCVhdcntn4eUVY9+8HdGLoPBdT8FQ/6aBRv77qHbt8pRQiJ+bZq0b84=
X-Gm-Message-State: AOJu0YzkZzmu08t5LFePL03i/NdJJMzKgUv3JUrVMkvX/AOvzBEROiMi
 eRHFPJ8zrrH35al++GJP+IMmuemenazXTmuItJRV0zZNDiBXLEUXfxvgxVHXGoRCc/APgzgexwL
 rt7H6vnBpWjxumS0j1HJK9Uh7WRq7+iNS/toyXX6hLY1JkGbLDkZu
X-Received: by 2002:a05:620a:951:b0:787:2ed3:6bc2 with SMTP id
 w17-20020a05620a095100b007872ed36bc2mr1993359qkw.11.1707925226325; 
 Wed, 14 Feb 2024 07:40:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/tITX3by7dycfSEMhbkYutR9NBYHR8azz9JOY1eby3NLFEWODqKu8m8PQCavZXfcECRVyEg==
X-Received: by 2002:a05:620a:951:b0:787:2ed3:6bc2 with SMTP id
 w17-20020a05620a095100b007872ed36bc2mr1993326qkw.11.1707925226012; 
 Wed, 14 Feb 2024 07:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWb1P8XN+NE14rJw2w/uAiJLmrH2iuDK9Q9+cFPa9q71Kir6b8zKKYvNHYs12SjDnNvDlQx7Ks2th8yRQ1Af+XuhjBD0i30hwEJlQbV9y3kHVpNF+408lq/6ktHAoIpVK4yj4HnWqjT7NcV8LPT95btZD3YTTGFGTK/05AF3XD8xZAgQeWVgf8h7guC3DlgJ81nwpLj0FqGjeS8FZr9+W5JZZv3RDlZQE4I0EhppgHXW91+bVFLV/s49Wc5Wh7/7/g8adlPXWKJeyovze2rpIopXwq/mZfHd7cYsW9RZ/fDSPRpZjils/GUzygjp63ItrC7H1V0J8/ImmFDSauRxEWSH/Q4Xk9Wk9zuaiLMoIoDrd/0WA==
Received: from ?IPV6:2a01:cb19:853d:fa00:f59e:918a:6675:6332?
 ([2a01:cb19:853d:fa00:f59e:918a:6675:6332])
 by smtp.gmail.com with ESMTPSA id
 ay8-20020a05622a228800b0042da7117b8dsm2065754qtb.26.2024.02.14.07.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 07:40:25 -0800 (PST)
Message-ID: <a2ec891e-76fb-4985-a63d-b6609100af3c@redhat.com>
Date: Wed, 14 Feb 2024 16:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 0/8] vfio/iommufd: IOMMUFD Dirty Tracking
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <2540a4d3-c370-407f-8b97-9100615d2920@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <2540a4d3-c370-407f-8b97-9100615d2920@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Joao,

On 2/13/24 12:59, Joao Martins wrote:
> On 12/02/2024 13:56, Joao Martins wrote:
>> This small series adds support for Dirty Tracking in IOMMUFD backend.
>> The sole reason I still made it RFC is because of the second patch,
>> where we are implementing user-managed auto domains.
>>
>> In essence it is quite similar to the original IOMMUFD series where we
>> would allocate a HWPT, until we switched later on into a IOAS attach.
>> Patch 2 goes into more detail, but the gist is that there's two modes of
>> using IOMMUFD and by keep using kernel managed auto domains we would end
>> up duplicating the same flags we have in HWPT but into the VFIO IOAS
>> attach. While it is true that just adding a flag is simpler, it also
>> creates duplication and motivates duplicate what hwpt-alloc already has.
>> But there's a chance I have the wrong expectation here, so any feedback
>> welcome.
>>
>> The series is divided into:
>>
>> * Patch 1: Adds a simple helper to get device capabilities;
>>
>> * Patches 2 - 5: IOMMUFD backend support for dirty tracking;
>>
>> The workflow is relatively simple:
>>
>> 1) Probe device and allow dirty tracking in the HWPT
>> 2) Toggling dirty tracking on/off
>> 3) Read-and-clear of Dirty IOVAs
>>
>> The heuristics selected for (1) were to enable it *if* device supports
>> migration but doesn't support VF dirty tracking or IOMMU dirty tracking
>> is supported. The latter is for the hotplug case where we can add a device
>> without a tracker and thus still support migration.
>>
>> The unmap case is deferred until further vIOMMU support with migration
>> is added[3] which will then introduce the usage of
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>> dma unmap bitmap flow.
>>
>> * Patches 6-8: Add disabling of hugepages to allow tracking at base
>> page; avoid blocking live migration where there's no VF dirty
>> tracker, considering that we have IOMMU dirty tracking. And allow
>> disabling VF dirty tracker via qemu command line.
>>
>> This series builds on top of Zhengzhong series[0], but only requires the
>> first 9 patches i.e. up to ("vfio/pci: Initialize host iommu device
>> instance after attachment")[1] that are more generic IOMMUFD device
>> plumbing, and doesn't require the nesting counterpart.
>>
> I need to add that this series doesn't *need* to be based on Zhengzhong series.
> Though given that he is consolidating how an IOMMUFD device info is represented
> it felt the correct thing to do. For dirty tracking we mainly need the
> dev_id/iommufd available when we are going to attach, that's it.
> 
> I've pushed this series version that doesn't have such dependency, let me know
> if you want me to pursue this version instead going forward:
> 
> https://github.com/jpemartins/qemu/commits/iommufd-v5.nodeps

I feel I have lost track of all the different patchsets.

To recap, there is yours :

* vfio/iommufd: IOMMUFD Dirty Tracking
   https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/

Zhengzhong's :

* [PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU
   https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/

Eric's :

* [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
   https://lore.kernel.org/qemu-devel/20240117080414.316890-1-eric.auger@redhat.com/

Steve's:

* [PATCH V3 00/13] allow cpr-reboot for vfio
   https://lore.kernel.org/qemu-devel/1707418446-134863-1-git-send-email-steven.sistare@oracle.com/

Mine, which should be an RFC :

* [PATCH 00/14] migration: Improve error reporting
   https://lore.kernel.org/qemu-devel/20240207133347.1115903-1-clg@redhat.com/

Anything else ?

Thanks,

C.


