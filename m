Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6CBC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 09:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1iN5-0004VS-5U; Mon, 07 Apr 2025 05:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1iM0-0004P2-LN
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1iLr-0007rb-9r
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744016463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TG+17J6OnNrFFS2Zs93svwe09bzy5yMs7ywNL5E/mDY=;
 b=XGo81AZRjMa/KvIsDmwS5sprk0UdswM6tWNB+IWlnPjRw1EQGc3YlxwIPQSxV64jQb6l83
 JZFuIyKPJIskcK4elyXDAkxMPudnE6CduZ6yG3eiao7SBTIKGVijZ85p54OV+830YUS2Mt
 l36mHlmJSXEPdJ7khYWuzqClS7po7vo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-TUrH8XYWNCqyTBvppyOETA-1; Mon, 07 Apr 2025 05:01:01 -0400
X-MC-Unique: TUrH8XYWNCqyTBvppyOETA-1
X-Mimecast-MFC-AGG-ID: TUrH8XYWNCqyTBvppyOETA_1744016461
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39c184b20a2so2131270f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 02:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016460; x=1744621260;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG+17J6OnNrFFS2Zs93svwe09bzy5yMs7ywNL5E/mDY=;
 b=WaPfvpIsMX/IbcPngZKvGMfz1QVkUjb8hWa4Pv+JQP4LagbU/qNMeCIiS6JWtsp/fO
 vqK4SGbogkBsbGJ8HLl/FzXe3dQNhxCS5fODA1RWv34UWvgiCyUldh1ls9nQlQHbJvXp
 ipGK8Y3EEsFmtwIHe7WYwr7aZd1anvyAZiElnYSZbL3EM+qBAqkhUm+CgU44/Tt8+Qor
 MfqJQhVu7AE+wvPsR8UJ4K4laAU2NgoF1MnmsneQ7pqqhVNVqlGDb7TtpuQqCmu14qbH
 zrISHxkIOsHZ9nFKHJs6RbdUawXQQYVUjncbdasjQwa+qz4RuhBcqQEJZlohZlJ/9WmQ
 x4rw==
X-Gm-Message-State: AOJu0YybYRec6uOde2JPh3N76TRfnnTIWv7VeYWSpKl12Gs27EsUImUs
 /ZUqNCkRM3KB4WMQCj853SsCB1Tm1qNi+OvLQZ7FeNNBuLcFCNADppyF0o7mkONKqbvS9ZkngNQ
 0ls8TNALReBOaBHUCEQvyuSV/KJurB54vUrfAlKzDrXqPH0ey5i+Hul0i68tK+rDO690YJrwKXl
 xEaKYvo3x+5srOIH5V+eaxtekMkRCraQ==
X-Gm-Gg: ASbGncs8oosXFM6Pk88IbBOKJwGoT9ngJSBOwUmIG5VPOpoCpk/+Jf7bDfPKpPQkSFJ
 8deQBuTBgvbbIEZ+w6z947dp3I/cdaiGooi/a4/ATwcXACW9VmqMpIiAtUwvnTR3/sVBwvRBxZK
 r0fLtQBvft5i/scgjwA8+11aIR2BKjIRrS5VpsVlgPm6psp8AsEErrIbDhdXtVspz4UDbgSqHdC
 SFeVW3DqmTSLB+pMOsLgCLVgn50+b7583OmaBE25cNxdqet7ykHggoVmmiEGbWbSpI86qF2IWvS
 bvvlWOK3CRj/cLO9Mt08W94cv2VKncSSo83f8dzIzsrrA3XffqhLWg==
X-Received: by 2002:a05:6000:4203:b0:391:3998:2660 with SMTP id
 ffacd0b85a97d-39cb35759c8mr9284109f8f.7.1744016459950; 
 Mon, 07 Apr 2025 02:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXHNAY/DK+44G9QZllGvrAuneBO9NbTOGU+ctnX7u3D8I2cSl9MnNqi2VfguONty2uD/8D8w==
X-Received: by 2002:a05:6000:4203:b0:391:3998:2660 with SMTP id
 ffacd0b85a97d-39cb35759c8mr9284050f8f.7.1744016459289; 
 Mon, 07 Apr 2025 02:00:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968a1sm11605630f8f.11.2025.04.07.02.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:00:58 -0700 (PDT)
Message-ID: <df132244-3e44-4001-b161-d935c7b5ffbb@redhat.com>
Date: Mon, 7 Apr 2025 11:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 00/37] vfio: Spring cleanup
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/26/25 08:50, Cédric Le Goater wrote:
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
>    * hw/vfio/vfio-cpr.h
>      Steve Sistare, Oracle
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
>     too would be great
>   - isolate all the low level routines (kvm ioctls) into helpers.c
>     to improve build ?
>   - improve build to reduce the number of files built per target
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
> 
> Thanks,
> 
> C.
> 
> 
> Changes in v2:
> 
>   - Dropped vfio_migration_set_error()
>     https://lore.kernel.org/qemu-devel/20250324123315.637827-1-clg@redhat.com/
>   - Dropped R-b trailers on patches which were modified too much
>     (context changes are ok)
>   - Improved commit logs of patches adding new files
>   - Fixed top comment in header files
>   - Used a 'vfio_migration_' prefix instead of 'vfio_mig_'
>   - Made vfio_migration_add_bytes_transferred() internal
>   - Added extra patch for vfio_device_state_is_running/precopy()
>   - Moved vfio_reset_handler() in device.c
>   - Moved "dirty tracking" related services into container-base.c and
>     improved naming
>   - Introduced listener.* files instead of dirty-tracking.*
>   - Introduced vfio_listener_un/register() routines
I pushed the changes I made to v2 to this branch:

   https://github.com/legoater/qemu/commits/vfio-10.1

I've added manually Avihai's R-bs which didn't reach lore for some
reason. Please check.

v3 should be after QEMU 10.0 is released, possibly next week.

Thanks,

C.





