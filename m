Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF66CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2T8-0002sG-2B; Mon, 01 Sep 2025 07:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2T4-0002rv-My
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2T2-0003tG-1P
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pcd7Ab4Q0fR7CCAR5PtAw1rhmm+ePvj+0bmN/rCZLdA=;
 b=JyJE7H/BDCgoIlm2gbo6LcPvzTJSkrkhUBqzluhWtQ1f7dd+/ukdxlC36YCXs6LsaZSVP4
 v9a1ShDUn8996jNWYzrKRAsNCEMHbQxUDikzLcbAvxdGToZizRn6Lee94hVKqOTRG+TNnW
 OXC7rw+iYIqvEYc1qyvQ3fM4e0pH7nk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-bizPadgoNUm1CLtW-7lqtw-1; Mon, 01 Sep 2025 07:12:50 -0400
X-MC-Unique: bizPadgoNUm1CLtW-7lqtw-1
X-Mimecast-MFC-AGG-ID: bizPadgoNUm1CLtW-7lqtw_1756725169
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b7bb85e90so32744545e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725169; x=1757329969;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pcd7Ab4Q0fR7CCAR5PtAw1rhmm+ePvj+0bmN/rCZLdA=;
 b=swwX7nXmykKY6MTOgD1BUDrtjE0QUWKGmH/JltotBln1ozb8ke3y1NH/6MIBt2dRoS
 BVyjlwq79lqviNhxAOJWnp6MzvWB+xoB90mrBjVDpOssy0jqzp0hfsE7rDi3CBDftaAN
 At1ycm+rrkf6XpDDzqHS2LMq/l7W0AMORgFWUAF2JOpZ2ZUV2fRo/jgknGKUDB9JXvwu
 3th/HeSJQpuzI7f4FB21q7XxXHu18PrAS6AYZS/uT7kn0THOAZ5o3OpkGhfUGn8tuTBg
 S0vCyTcpp6gYQ7QaIP9WWBhixwCQJQQLyfvVtx/B6cdA0KARvKn1AkYuUoIcJ0mvVfYh
 Klxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvvvtGSxLS0z9Sph7b6Qni7KPRGIwWP2rKhSamLpeevutn6X+/7m9ZbQRz2HiTVxzLOgeSjacl+FjT@nongnu.org
X-Gm-Message-State: AOJu0YwAMHwQkxKvlD3xWGq1kuvbZkW3jhRB8dqzP1T7hWcrD5NJWjhz
 dPIXxaSjI1QUoG50tKpKd7V+g709daC9n3vE9dvxdkwRTRJRXuHArjI47zukCCyZc9BV9RxjS3L
 4hal/6VtNaRBTH9D03xCuukeYRCt1mvFMBHp8e0t2JutaCMODCh/ViGpv
X-Gm-Gg: ASbGncut27F5hKVkdVRnDxp1s/ioo4GH0MVadZFQSCu6zNqaNOMh6xtjYgfJknHpcUt
 k+qXT6ASYBAVa1xzX4enHSH+E176mZ+Ss2XvtTAzAIThSQn2BmtbVEPUP11iFw8pnAT/Rtehv6x
 RwSNTY/1VDylP3ns8ej/nB7q7xnEGEUoRgFydm7nm2w1wpg0MjKhCg0CAFMfnTMYWGL3LiSLcCg
 16Zn15ECd68FmocwLIJH1fc/6eI+lqk8pRVSUFXlQMCml7p+DpSF7hwnPAP5FSjR3EupjKJioxK
 p0vYkpWC9hgR3Z/NhpQ4t9gQFvuqoOushdnVzofWbmZLVOO5z4lH/lqTNUGSRRgfRiBVntss+Bn
 0M5w=
X-Received: by 2002:a05:600c:5247:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-45b910c0ba0mr4087645e9.12.1756725169011; 
 Mon, 01 Sep 2025 04:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgvJT/khQU8fFBb3ijJVmT6vnFdzxfoSJg59hEvm6dpRHBhnF9JDl62Pxlos6qchbPfjXwoQ==
X-Received: by 2002:a05:600c:5247:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-45b910c0ba0mr4087445e9.12.1756725168496; 
 Mon, 01 Sep 2025 04:12:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d60d93b949sm4902864f8f.2.2025.09.01.04.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:12:47 -0700 (PDT)
Message-ID: <155de6b2-4780-4c96-824b-593b4f784e83@redhat.com>
Date: Mon, 1 Sep 2025 13:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Remap only populated parts in a section
To: Steven Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
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
In-Reply-To: <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/28/25 14:28, Steven Sistare wrote:
> On 8/13/2025 11:24 PM, Zhenzhong Duan wrote:
>> If there are multiple containers and unmap-all fails for some container, we
>> need to remap vaddr for the other containers for which unmap-all succeeded.
>> When ram discard is enabled, we should only remap populated parts in a
>> section instead of the whole section.
>>
>> Export vfio_ram_discard_notify_populate() and use it to do population.
>>
>> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> btw: I didn't find easy to test this corner case, only code inspecting
> 
> Thanks Zhenzhong, this looks correct.
> 
> However, I never liked patch
>    eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> 
> I think it adds too much complexity for a rare case.  In fact, if we
> examine all the possible error return codes, I believe they all would
> be caused by other qemu application bugs, or kernel bugs:
> 
> vfio_dma_do_unmap()
>    returns -EBUSY if an mdev exists.  qemu blocks live update blocker
>      when mdev is present.  If this occurs, the blocker has a bug.
>    returns -EINVAL if the vaddr was already invalidated.  qemu already
>      invalidated it, or never remapped the vaddr after a previous live
>      update.  Both are qemu bugs.
> 
> iopt_unmap_all
>    iopt_unmap_iova_range
>      -EBUSY - qemu is concurrently performing other dma map or unmap
>               operations.  a bug.
> 
>      -EDEADLOCK - Something is not responding to unmap requests.
> 
> Therefore, I think we should just revert eba1f657cbb1, and assert that
> the qemu vfio_dma_unmap_vaddr_all() call succeeds.


vfio_dma_unmap_vaddr_all() is called in the .pre_save handler. This is
pretty deep in the callstack and errors should be handled by the callers.
Quitting QEMU in that case would be brutal and it would confuse the
sysmgmt layers.

Improving error reporting of the .pre_save handler would be a nice
addition though.


Thanks,

C.




> 
> Thoughts?
> 
> - Steve
> 
>>   include/hw/vfio/vfio-container-base.h |  3 +++
>>   include/hw/vfio/vfio-cpr.h            |  2 +-
>>   hw/vfio/cpr-legacy.c                  | 19 ++++++++++++++-----
>>   hw/vfio/listener.c                    |  8 ++++----
>>   4 files changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index bded6e993f..3f0c085143 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -269,6 +269,9 @@ struct VFIOIOMMUClass {
>>       void (*release)(VFIOContainerBase *bcontainer);
>>   };
>> +int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>> +                                     MemoryRegionSection *section);
>> +
>>   VFIORamDiscardListener *vfio_find_ram_discard_listener(
>>       VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index d37daffbc5..fb32a5f873 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -67,7 +67,7 @@ bool vfio_cpr_container_match(struct VFIOContainer *container,
>>   void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>>                              MemoryRegionSection *section);
>> -bool vfio_cpr_ram_discard_register_listener(
>> +bool vfio_cpr_ram_discard_replay_populated(
>>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>>   void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index 553b203e9b..6909c0a616 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -224,22 +224,31 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
>>       memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>>   }
>> +static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
>> +{
>> +    RamDiscardListener *rdl = opaque;
>> +    return vfio_ram_discard_notify_populate(rdl, section);
>> +}
>> +
>>   /*
>>    * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
>>    * succeeding for others, so the latter have lost their vaddr.  Call this
>> - * to restore vaddr for a section with a RamDiscardManager.
>> + * to restore vaddr for populated parts in a section with a RamDiscardManager.
>>    *
>> - * The ram discard listener already exists.  Call its populate function
>> + * The ram discard listener already exists.  Call its replay_populated function
>>    * directly, which calls vfio_legacy_cpr_dma_map.
>>    */
>> -bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
>> -                                            MemoryRegionSection *section)
>> +bool vfio_cpr_ram_discard_replay_populated(VFIOContainerBase *bcontainer,
>> +                                           MemoryRegionSection *section)
>>   {
>> +    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>>       VFIORamDiscardListener *vrdl =
>>           vfio_find_ram_discard_listener(bcontainer, section);
>>       g_assert(vrdl);
>> -    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
>> +    return ram_discard_manager_replay_populated(rdm, section,
>> +                                                vfio_cpr_rdm_remap,
>> +                                                &vrdl->listener) == 0;
>>   }
>>   int vfio_cpr_group_get_device_fd(int d, const char *name)
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index f498e23a93..74837c1122 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -215,8 +215,8 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>>       }
>>   }
>> -static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>> -                                            MemoryRegionSection *section)
>> +int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>> +                                     MemoryRegionSection *section)
>>   {
>>       VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
>>                                                   listener);
>> @@ -572,8 +572,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>>       if (memory_region_has_ram_discard_manager(section->mr)) {
>>           if (!cpr_remap) {
>>               vfio_ram_discard_register_listener(bcontainer, section);
>> -        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
>> -                                                           section)) {
>> +        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
>> +                                                          section)) {
>>               goto fail;
>>           }
>>           return;
> 


