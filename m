Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A716C61CE7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTYE-0000jc-Ir; Tue, 03 Jun 2025 11:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMTYD-0000jA-1B
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMTY7-00084s-09
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A45TxYAStgpUEe6yfZgKoalp+idnXFIMQaSuiyiCRVs=;
 b=gmYoFBgRJn0gbI4ey3Vf0obijVaqGSWys+auEvLwlKcOyH1qCGwWo2bppVXdWpDq1TyCAl
 WTW9trBc8sl/r6icWib83SWFs6vj8wPJSt4KQZkQ0GztZom0VMWKLD/ZtuLRppQZOhzDLf
 pCpi38N52c55nca28IhI8LYa9O49Qcs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-SXnOdx6TNDmG-8G004qxXQ-1; Tue, 03 Jun 2025 11:27:31 -0400
X-MC-Unique: SXnOdx6TNDmG-8G004qxXQ-1
X-Mimecast-MFC-AGG-ID: SXnOdx6TNDmG-8G004qxXQ_1748964450
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so2108127f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964449; x=1749569249;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A45TxYAStgpUEe6yfZgKoalp+idnXFIMQaSuiyiCRVs=;
 b=k9QgsjKjx4ejeuRfGULR+ORlEmgg5pK9DijVfPAErmcAJIEd8zicAhSRNQP6StD1rW
 d953JeNJvIaZti/KmCsHtgISVG1DvHV3jqZxEtcBA52sD3xFd4UDroyLJjbWCIoahJJT
 6Jyj5SEAVLUFZrZqC7C7GwCWVjcv/pyBZvgxrfV9Rz8FyX2BFA62CfqcQvqbKOm8HKrH
 rzfhYl9evRwmVK5VjzXtyJ2WmWu0nRp0pIlI5ng+8y/72YJfSVYASop6i8q7sHfHIeJu
 3k9JaNcbawMHOMXB4KNxoKi7f20EUUxEHeuqP7KFIucNRTgBeiEg1Qcfizl0aw8v/YWV
 8fFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG0IQ26SdE+2b6w6OxdWE0k664HNiijmblwgK8kGSqcHS5/1CEXeA4/FzYAWSiOna4tpneZWpDBAp9@nongnu.org
X-Gm-Message-State: AOJu0YxuxwBBP65ZEDqUGbp7afluCuIsJVM1x9qaFrnaVEeZ0EKTniIA
 u8O3oB3TuzufuKCUAisKJZP2nP5PLhOGEWBgLrXa0L24C+YC/pij9c7S/RnoGFiJkXDFlRbkGMR
 0k2Icun8Ek3/sh0+3/xuw/aBGsP6VKHbiOlfMYnb9a+3o7Zbt1QL7Mx9incr8l5EHRgM=
X-Gm-Gg: ASbGncvQN5RuEBEe2HDEgql4VGmey5A93wck93IK/8SW8Yt8tDb6HLsmkBdImzX77jb
 DdjCtRBgy8rMbcHXEbRYXhU1IW6o7ZFC05QPWcAGFw2H5Pt0yRGoOeNZtQcoJ09R/L7S/f5KiUT
 z2vsYq215SIYYA9x9ZrYmKiEJdL66m+7liQvHGl5vcEvQ3d3tkjzs4Pm7tQMX2BSoDiiOnugI9h
 1rAWp2k5d6ktvniuXbf12tQuqhhTGKe42TWRqT2NFHx17sirfH+tiGF3tTNqT+HeB47SFJkNCOR
 yja7fnB9eJCAV8XOXJM9Aq4xdla/REHVy/Q2mFwr1F3f3ErdUM49ZitdHZiEOaAfoHDYwWlEtsU
 ETq6nwDOBfT4H7jCPX1Fjb6+GWTUvAzi6arwG
X-Received: by 2002:a05:6000:4023:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3a4f89a7defmr11817496f8f.6.1748964449374; 
 Tue, 03 Jun 2025 08:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7isN+dH6/+Or7OMFpfFeF9IPsjPVfatnfw92hrrCp9Iid0s6D/z3im4l+5A6fMA+NdeOOdQ==
X-Received: by 2002:a05:6000:4023:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3a4f89a7defmr11817471f8f.6.1748964448962; 
 Tue, 03 Jun 2025 08:27:28 -0700 (PDT)
Received: from ?IPV6:2a02:8428:527:dd01:97e1:f7ae:2e2c:ffab?
 (2a02-8428-0527-dd01-97e1-f7ae-2e2c-ffab.rev.sfr.net.
 [2a02:8428:527:dd01:97e1:f7ae:2e2c:ffab])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097539sm19039167f8f.63.2025.06.03.08.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 08:27:28 -0700 (PDT)
Message-ID: <a422bc17-1c0e-4896-b75e-0905c2383fc5@redhat.com>
Date: Tue, 3 Jun 2025 17:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/43] vfio/container: register container for cpr
To: Steven Sistare <steven.sistare@oracle.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136AF510081213140C10899926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <71730241-a6f4-47f5-b7d6-964412b4d0bd@oracle.com>
 <9dc27182-7b01-45de-9f37-6ca37cabff77@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9dc27182-7b01-45de-9f37-6ca37cabff77@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/3/25 16:17, Steven Sistare wrote:
> On 6/3/2025 10:09 AM, Steven Sistare wrote:
>> On 6/3/2025 7:57 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V4 09/43] vfio/container: register container for cpr
>>>>
>>>> Register a legacy container for cpr-transfer, replacing the generic CPR
>>>> register call with a more specific legacy container register call.  Add a
>>>> blocker if the kernel does not support VFIO_UPDATE_VADDR or
>>>> VFIO_UNMAP_ALL.
>>>>
>>>> This is mostly boiler plate.  The fields to to saved and restored are added
>>>> in subsequent patches.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> include/hw/vfio/vfio-container.h |  2 ++
>>>> include/hw/vfio/vfio-cpr.h       | 15 +++++++++
>>>> hw/vfio/container.c              |  6 ++--
>>>> hw/vfio/cpr-legacy.c             | 69
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>> hw/vfio/cpr.c                    |  5 ++-
>>>> hw/vfio/meson.build              |  1 +
>>>> 6 files changed, 92 insertions(+), 6 deletions(-)
>>>> create mode 100644 hw/vfio/cpr-legacy.c
>>>>
>>>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
>>>> index afc498d..21e5807 100644
>>>> --- a/include/hw/vfio/vfio-container.h
>>>> +++ b/include/hw/vfio/vfio-container.h
>>>> @@ -10,6 +10,7 @@
>>>> #define HW_VFIO_CONTAINER_H
>>>>
>>>> #include "hw/vfio/vfio-container-base.h"
>>>> +#include "hw/vfio/vfio-cpr.h"
>>>
>>> Now that we have this change, may we remove #include of vfio-cpr.h in hw/vfio/container.c?
>>> Maybe this belong to patch8?
>>
>> Yes, thanks.
>> Patch 8 should not add #include of vfio-cpr.h in hw/vfio/container.c
> 
> However, I see that Cedric has staged these patches in vfio-next.
> We can make these tweaks in a future patch.

It is fine. you can resend. Let's wait first for Michael's feedback on the
pci and vfio-pci reset handlers. This is what is blocking me from sending
a PR.

Thanks,

C.


