Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CC9C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Guj-0001hP-CF; Tue, 22 Apr 2025 12:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7GuR-0001eV-3p
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7GuN-0002au-Of
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745340941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iURUQv7H6hz4ggViQJxP8Cv7CjZ32OCnzmploO088ec=;
 b=Lv6kg2AbTg65L0AUh213JG8s5ZHrjT9UPqUZjBLkq465lkgzPnnhZkQYLAcVkhJ8pEsxN6
 EynEJDQTHTHoz6KA6FtJ9UVigvcjR6RCC3E/KaZIU14/KteYw2hapI0kUbeQrfiIr6NqPb
 VSFeuxYNP3Sm3MdQ644Pxhly8CPauHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-m51n9V53NIuFi0tGlfKL3A-1; Tue, 22 Apr 2025 12:55:40 -0400
X-MC-Unique: m51n9V53NIuFi0tGlfKL3A-1
X-Mimecast-MFC-AGG-ID: m51n9V53NIuFi0tGlfKL3A_1745340939
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso34930125e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745340938; x=1745945738;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iURUQv7H6hz4ggViQJxP8Cv7CjZ32OCnzmploO088ec=;
 b=E+D8WSGQZMrVdpiNk9Pbk9gv4dSu5TWAz1okLb/loqkMrbH/01/Pqo2JVJLk5s6TCb
 bZsMSw2CcEnIgKFwXq6cE9L4ANC9i80sr25ORCKUbJZFUlIy0rmHrYccsIo5L6at0xO2
 0bo5aoPcmw+2TUaCk9yHZP5zC9OYvkjSN0a53QFhYlITdelFdZgrLG2SlP/NSVgeBUNw
 a4uAOJF/yERXBZ9tLS48TGRSM3KFPkwkL47KjjxoRtckOwgzW9ke1tqBtwWZUSDISgkW
 olAAc7Vc9oG90tIOcEr82e+6txfCBPCRVFb7hU3CW1CJq/jrcJmf3sBdrghf0pLvXqjW
 CjeA==
X-Gm-Message-State: AOJu0YzCNapAKVR4boxPrX8JootGCk4BqjYf+uczi+8VgscCUaFbpome
 TSUc9pDN1CPByEPV1u75E2nPVC1RVJY8bkd9SDVDF2GpRK7WWhkB+6bMWjtr8MgpXJr7T44//n2
 s1Lu+1OryM4XGJ8nHmOEo8e5amWrtQ3eDza/ssG5hMCk9SB0vFwpZcibmeMIrWem8/8ngDTUp2H
 y005BTv4txejN+ZjleR6AfVXwlQrBeuQ==
X-Gm-Gg: ASbGncszxqIxjiC3ddiYlSZ5AJUfSyP26gmtA6tzIBzIV34N1VNSODuwZaR4EKvd3ZN
 k1pPh18wxubX8oh8pvnj3U3WUPF24xSkhnutmO793L2pNZfJ863oFMBe0bcBLASATZd6kQJ122W
 KwdVoTOaE+wZIIVF54Xkr7aXutaQVgxwuivX+8JI3Rqct3kQG21w9mGECUp2A6N98Kekh7SSCyw
 fGY2tBOs4fSxLVqgjPO/zL2tQt7jZ5WW5uCLMOWZsFAdsWiN7kwR7Rb0xDSBgXE1/b0s6EGeIy4
 jQ55txRodFC1f/v1f08VVinmMzdJm9dQi4ZGoHkdOmS3KXs=
X-Received: by 2002:a5d:584a:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-39efbad398fmr12701515f8f.45.1745340938501; 
 Tue, 22 Apr 2025 09:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr+poq8Q+PpWMs1QiRawv9sDXLrNdzPauMw7zSNGbRm3xkfO5vmvT0J25soJBHDLxF6cW9bQ==
X-Received: by 2002:a5d:584a:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-39efbad398fmr12701489f8f.45.1745340938037; 
 Tue, 22 Apr 2025 09:55:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4206fasm15586506f8f.2.2025.04.22.09.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:55:37 -0700 (PDT)
Message-ID: <0c20fd70-ff7d-4378-85ef-7f90b9fc64fd@redhat.com>
Date: Tue, 22 Apr 2025 18:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/37] vfio: Spring cleanup
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250422160224.199714-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/22/25 18:01, Cédric Le Goater wrote:
> Hello,
> 
> Several large extensions were merged in VFIO recently: migration
> support with dirty tracking, support for different host IOMMU backend
> devices, multifd support, etc. This adds up to the previous
> extensions: vfio-platform, AP, CCW. The result is that VFIO is now a
> subsystem of over +16,000 lines of code :
> 
>    QEMU 2.0  :   3988 total
>                   ...
>    QEMU 10.0 :  16607 total
> 
> Organization is weak, naming inconsistent, the vfio-common.h header
> file and common.c are quite messy. It's time to address the technical
> debt before adding new features.
> 
> This proposal reorganizes some of the VFIO files to isolate features,
> introduces new files and renames services to better reflect the
> namespace they belong to. This is code reshuffling and there are no
> intentional functional changes. If more could be done, please propose !
> Timing seems right.
> 
> 
> I have taken care to preserve all existing copyright notices in the
> file headers. I have added one on behalf of my current employer for
> newly created files. However, original authors may wish to include
> their own notices as well. If so, please respond to the patch, and I
> will update the patch in the next spin or before applying.
> 
> Here is a (short) list requiring your attention :
>    
>    * include/hw/vfio/vfio-migration.h
>    * hw/vfio/vfio-migration-internal.h
>      Kirti Wankhede and Avihai Horon, NVIDIA
>    
>    * hw/vfio/vfio-iommufd.h
>      Joao Martins and Yi Liu, Oracle and Intel
>    
>    * include/hw/vfio/vfio-region.h
>    * hw/vfio/region.c
>      Eric Auger, may be we could reduce the list ?
> 
> I think the remaining new files are correctly covered but I am human,
> so please review and let me know.
> 
> I hope we can merge this when the QEMU 10.1 cycle starts and then
> address the two large series waiting : live update and vfio-user.
> 
> 
> What next in terms of cleanups :
> 
>   - container.c is quite messy
>   - the pci* files need some love too (add vfio- prefix ?)
>   - improve overall documentation, structs and routines documentation
>     would be great
>   - isolate all the low level routines (kvm ioctls) into helpers.c
>     to improve build ?
>   - improve build to reduce the number of files built per target
>     https://lore.kernel.org/qemu-devel/20250308230917.18907-1-philmd@linaro.org
>   - continue the never ending quest of adding 'Error **' parameters,
>     Look for migration_file_set_error, in MemoryListener handlers :
>        vfio_listener_region_add
>        vfio_listener_log_global_stop
>        vfio_listener_log_sync
>     and in callback routines for IOMMU notifiers :
>        vfio_iommu_map_notify
>        vfio_iommu_map_dirty_notify
>     memory_region_iommu_replay() would be a start.
>   - remove vfio-platform (start of QEMU 10.2 cycle ~ September 2025)
> 
> Thanks,
> 
> C.
> 
> 
> Changes in v3:
> 
>   - Fixed commit log typos
>   - Removed hw/vfio/vfio-migration.h include from
>     hw/vfio/migration-multifd.c
>   - Added hw/vfio/vfio-region.h include in hw/vfio/pci.h
>   - Adjusted Copyright in hw/vfio/vfio-cpr.h
>   - Renamed vfio_container_vioc_query_dirty_bitmap() to
>     vfio_container_iommu_query_dirty_bitmap()
>   - Improved hw/vfio/vfio-device.h header description
>   - Fixed code alignment when renaming VFIODevice related services

I plan to send a PR soon after 10.0 is released (this week) and
then start working on merging the vfio-user proposal, at least
on the prereq patches.


Thanks,

C.



