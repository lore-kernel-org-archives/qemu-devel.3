Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7224DC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8DwM-0001UY-9L; Fri, 25 Apr 2025 03:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8DwL-0001UQ-DP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8DwJ-0005s8-AZ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745567858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CMXLemnwYOaw/VdViz5ruCmFeImMEmRxYXYXuz8QaYo=;
 b=RO3XPBSqVGg8rZwsFellIEjILLwcR7NuG3vnkQ/jDB2G9XrEmnlolrsA3Pch4hnVHHc5kN
 shcXgOwVjFKnJH+oChYWgucHQTx207pImiZ3US7hEReSpNwZyu1fh1xd5bPTV1lKIqLM7C
 ttlEkX2nSChQvl1QUdRQT0lP0KUr3z4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-u35V1NCDNhi-FzTpmnV6cw-1; Fri, 25 Apr 2025 03:57:35 -0400
X-MC-Unique: u35V1NCDNhi-FzTpmnV6cw-1
X-Mimecast-MFC-AGG-ID: u35V1NCDNhi-FzTpmnV6cw_1745567854
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so9863595e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 00:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745567854; x=1746172654;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMXLemnwYOaw/VdViz5ruCmFeImMEmRxYXYXuz8QaYo=;
 b=fQdzE/8yL2xe4Sc+2/WsbQPrxYehLMNMt3oLBU1ihQGdr4DRO+PIEiiNi48OrRKbc9
 HobgTFm6ULtN32UcCPH4R/QWEp249d0OEQmk3HxyIt61R131Peaz3/pavFa5aX7/Yh2Q
 de+PqH6/3cmvHCgrlbPCkCWH2HQGuI6LKnryRXgjNXL5l6iACq2EkcuyvKvXFy9vD8iK
 E7WsJFlkhkDotWjeFTh0RzV7v/YcDSfken3ENhuP7Ccpz428vcsMERx+uZFgcROVpdp2
 3Y/sNOjSULwnx/VYINCEKa9JhR0FiolVIQnn/3kMuXoTPVgwNrDbBkyM8rX5zVaUfvwq
 xmUQ==
X-Gm-Message-State: AOJu0YzY14f1V/kcDKZA7z0obp8cQCi8m/J2dmaMJqwGUcfZPrm9je9d
 YgnwHfJ3KLaXGpCu0CUy7HJ8QX+0S4/UTA237KjaCAoGKdRGJs4WvvRhCxkAC+bTvHLTQ+AcSIK
 upfVSonA7MrWCoKICe9j5qRtmOfvvfY3qAzQ6Vf3Sc7KloGUibtuNdb0zY//3vCtkmhaEwQHn2W
 PGqEtpp0y4sSYbFTE1olvMZfn7yBAURw==
X-Gm-Gg: ASbGnctabvz8+Fhi2xixl2CaKV64sSRr4dklVoOlygp9K58PGWkH9bLRzUOpieii+eK
 pPd8Svss66PokPftROfZWrbseFgHURDwKJ9lY19Xi4c8o2vv1I6FCOvOP2u0e/vMfFup2zpeG7x
 ve18NKat/GU4RRBllNu3XORBR3e6YnOdzNUSbSIwR4hVaffnR99YOHmAABPGH1TV4l+qGlThh1o
 ToQ2kxNpp0urHCxENkbZ2ymSIvnpkdqi9XK0eJtpQ6mkB+T8SH3JGW6Hq1iwECnVjYqOsAmuxc2
 bJmqE89+YMaI/HDHWHzJ1dwVr8rq58AfpalPXBqDOZK06D8=
X-Received: by 2002:a05:600c:35d3:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-440a66019a9mr10055175e9.17.1745567853915; 
 Fri, 25 Apr 2025 00:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV8XY++m13T0eBOFa8C5W7iyjAmasjyU3kcBjVUbiD1dgfOENZF8c0lP4AJuYlY+mbUEhfxA==
X-Received: by 2002:a05:600c:35d3:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-440a66019a9mr10054875e9.17.1745567853399; 
 Fri, 25 Apr 2025 00:57:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b9c4sm50340585e9.3.2025.04.25.00.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 00:57:32 -0700 (PDT)
Message-ID: <0342e4c4-d40e-4daa-b96d-a0af66534429@redhat.com>
Date: Fri, 25 Apr 2025 09:57:31 +0200
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
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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
> 
> 
> Cédric Le Goater (37):
>    vfio: Move vfio_mig_active() into migration.c
>    vfio: Rename vfio_reset_bytes_transferred()
>    vfio: Introduce a new header file for external migration services
>    vfio: Make vfio_un/block_multiple_devices_migration() static
>    vfio: Make vfio_viommu_preset() static
>    vfio: Introduce a new header file for internal migration services
>    vfio: Move vfio_device_state_is_running/precopy() into migration.c
>    vfio: Introduce a new header file for VFIOdisplay declarations
>    vfio: Move VFIOHostDMAWindow definition into spapr.c
>    vfio: Introduce a new header file for VFIOIOMMUFD declarations
>    vfio: Introduce new files for VFIORegion definitions and declarations
>    vfio: Introduce a new header file for VFIOcontainer declarations
>    vfio: Make vfio_group_list static
>    vfio: Move VFIOAddressSpace helpers into container-base.c
>    vfio: Move Host IOMMU type declarations into their respective files
>    vfio: Introduce a new header file for helper services
>    vfio: Move vfio_get_info_dma_avail() into helpers.c
>    vfio: Move vfio_kvm_device_add/del_fd() to helpers.c
>    vfio: Move vfio_get_device_info() to helpers.c
>    vfio: Introduce a new file for VFIODevice definitions
>    vfio: Introduce new files for CPR definitions and declarations
>    vfio: Move vfio_kvm_device_fd() into helpers.c
>    vfio: Move vfio_device_list into device.c
>    vfio: Move vfio_de/attach_device() into device.c
>    vfio: Move vfio_reset_handler() into device.c
>    vfio: Move dirty tracking related services into container-base.c
>    vfio: Make vfio_devices_query_dirty_bitmap() static
>    vfio: Make vfio_container_query_dirty_bitmap() static
>    vfio: Rename vfio_devices_all_dirty_tracking_started()
>    vfio: Rename vfio_devices_all_device_dirty_tracking()
>    vfio: Rename vfio_get_dirty_bitmap()
>    vfio: Introduce new files for VFIO MemoryListener
>    vfio: Rename RAM discard related services
>    vfio: Introduce vfio_listener_un/register() routines
>    vfio: Rename vfio-common.h to vfio-device.h
>    vfio: Rename VFIODevice related services
>    vfio: Rename VFIOContainer related services
> 
>   hw/vfio/migration-multifd.h           |   2 +-
>   hw/vfio/pci.h                         |   4 +-
>   hw/vfio/vfio-cpr.h                    |  15 +
>   hw/vfio/vfio-display.h                |  42 ++
>   hw/vfio/vfio-helpers.h                |  35 ++
>   hw/vfio/vfio-iommufd.h                |  34 ++
>   hw/vfio/vfio-listener.h               |  15 +
>   hw/vfio/vfio-migration-internal.h     |  74 +++
>   include/hw/s390x/vfio-ccw.h           |   2 +-
>   include/hw/vfio/vfio-common.h         | 346 -------------
>   include/hw/vfio/vfio-container-base.h |  12 +-
>   include/hw/vfio/vfio-container.h      |  36 ++
>   include/hw/vfio/vfio-device.h         | 149 ++++++
>   include/hw/vfio/vfio-migration.h      |  16 +
>   include/hw/vfio/vfio-platform.h       |   4 +-
>   include/hw/vfio/vfio-region.h         |  47 ++
>   backends/iommufd.c                    |   2 +-
>   hw/core/sysbus-fdt.c                  |   1 +
>   hw/ppc/spapr_pci_vfio.c               |   6 +-
>   hw/s390x/s390-pci-vfio.c              |   3 +-
>   hw/vfio/ap.c                          |  14 +-
>   hw/vfio/ccw.c                         |  30 +-
>   hw/vfio/container-base.c              | 192 ++++++-
>   hw/vfio/container.c                   | 123 ++---
>   hw/vfio/cpr.c                         |   3 +-
>   hw/vfio/device.c                      | 405 +++++++++++++++
>   hw/vfio/display.c                     |  10 +-
>   hw/vfio/helpers.c                     | 702 +++-----------------------
>   hw/vfio/igd.c                         |  10 +-
>   hw/vfio/iommufd.c                     |  24 +-
>   hw/vfio/{common.c => listener.c}      | 455 +----------------
>   hw/vfio/migration-multifd.c           |   7 +-
>   hw/vfio/migration.c                   | 111 +++-
>   hw/vfio/pci.c                         |  70 +--
>   hw/vfio/platform.c                    |  15 +-
>   hw/vfio/region.c                      | 395 +++++++++++++++
>   hw/vfio/spapr.c                       |  10 +-
>   migration/target.c                    |   8 +-
>   hw/vfio/meson.build                   |  10 +-
>   hw/vfio/trace-events                  |  36 +-
>   40 files changed, 1875 insertions(+), 1600 deletions(-)
>   create mode 100644 hw/vfio/vfio-cpr.h
>   create mode 100644 hw/vfio/vfio-display.h
>   create mode 100644 hw/vfio/vfio-helpers.h
>   create mode 100644 hw/vfio/vfio-iommufd.h
>   create mode 100644 hw/vfio/vfio-listener.h
>   create mode 100644 hw/vfio/vfio-migration-internal.h
>   delete mode 100644 include/hw/vfio/vfio-common.h
>   create mode 100644 include/hw/vfio/vfio-container.h
>   create mode 100644 include/hw/vfio/vfio-device.h
>   create mode 100644 include/hw/vfio/vfio-migration.h
>   create mode 100644 include/hw/vfio/vfio-region.h
>   create mode 100644 hw/vfio/device.c
>   rename hw/vfio/{common.c => listener.c} (76%)
>   create mode 100644 hw/vfio/region.c
> 

Rebased on HEAD and applied to vfio-next.

Thanks,

C.



