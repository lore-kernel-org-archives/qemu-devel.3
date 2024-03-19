Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEB5C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 09:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmVhr-0000a0-1P; Tue, 19 Mar 2024 05:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmVhq-0000ZS-0r
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 05:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmVhn-0004v9-P7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 05:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710840262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7GSp6UqM6cddHswubyUHHGm1W1p6YffXI6TbOu7lS4s=;
 b=fBF+oe1HUbipFxLdeH4fNedP/OMGJNXAfMfNjJ2eCOj/5rfhaKHLzWwlY6JiR65+NBpJqI
 gYc2PHbgAW9E6IJaH1hIddXfWSYcDqzqPfzjoZGhmh8s3XPNmXfg6wW+bNF7X7o98OvRi7
 edqjvwB0FgntThu/hFnzi59Eo1/DE7A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-pOYvwvsMPt2_5Ltv0gVvRw-1; Tue, 19 Mar 2024 05:24:18 -0400
X-MC-Unique: pOYvwvsMPt2_5Ltv0gVvRw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-515297de3fdso617796e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 02:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710840257; x=1711445057;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GSp6UqM6cddHswubyUHHGm1W1p6YffXI6TbOu7lS4s=;
 b=Aly1KCObelitT1IFV25PPMg/snV/fy92fi7e6HWA0Esj3By8QO9zlJQtqx2p5ycpEY
 B34ys4cSrqbK5GbtteWchAFBrlWNGMwRQSpTFnWWJ7KcGao+gbFPHozmvihYL/WmqzHd
 lWqyBMkg/AQ8I0B/AkbekYUldZH7CGJmI7F5hftfw4qPfiPiqu7vMOEwM6szprrDFmLz
 A8h/WCdiOxaFUofs3KgVynTXJ2LqCncbvVXD0jRlZjAXq+9vZ4Tk6k63YYMhZam4MaJW
 hDmSe8prue7kz/aOwW6T2ck82sDZxcS+h1tVG4oS1OnIt63m2DbuFrXuVunga+r0AIR/
 xa0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh5UaijbXhqmTTXJWwZo7sD+vm4K3TgNw0uJ2GiiJ8nhlSPs3VGaJURAKf0zOKIJmuKLhaDKiZ8w06XtjdYPEeeBSHcA0=
X-Gm-Message-State: AOJu0YxD7IojLm+TsH25oSPIdkupS0Oyr43G7VBnFj1BwmHkuRGvkuvL
 hMAmBMeYMDfDKuP8bQW5b0DLxpcjVp8z3LO/l4jMvNRRGDV4t2WcZIkL69afbFIlt1+A/ycLZgM
 VuIf1zTAjkKEA4j1o8qGFtQjy+cb6gpH2fR40jR17GS2A26gR6jBx
X-Received: by 2002:a05:6512:310a:b0:513:c4b8:388b with SMTP id
 n10-20020a056512310a00b00513c4b8388bmr9134990lfb.27.1710840256979; 
 Tue, 19 Mar 2024 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrhRVmjfnLYiKuZFdhh+8s+w+XnVZp4jL9kPig4PGWvQi5SZ6DkUxL8Zrv4pwr6mdIVx7UGA==
X-Received: by 2002:a05:6512:310a:b0:513:c4b8:388b with SMTP id
 n10-20020a056512310a00b00513c4b8388bmr9134967lfb.27.1710840256515; 
 Tue, 19 Mar 2024 02:24:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f?
 (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de.
 [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b0041409db0349sm9396242wmo.48.2024.03.19.02.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 02:24:16 -0700 (PDT)
Message-ID: <7cc3c19c-00f0-4ad2-b0de-ba42e9b20c2a@redhat.com>
Date: Tue, 19 Mar 2024 10:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYxIDEvMl0gc3lzdGVtL2NwdXM6IEZp?=
 =?UTF-8?Q?x_pause=5Fall=5Fvcpus=28=29_under_concurrent_environment?=
Content-Language: en-US
To: zhukeqian <zhukeqian1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
 yuzenghui <yuzenghui@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-2-zhukeqian1@huawei.com>
 <4d7795bb-1dfa-40e7-a98e-4c0bafdf3db0@redhat.com>
 <7387988008764735b2f1dd5f2c83a45a@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7387988008764735b2f1dd5f2c83a45a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19.03.24 06:06, zhukeqian wrote:
> Hi David,
> 
> Thanks for reviewing.
> 
> On 17.03.24 09:37, Keqian Zhu via wrote:
>>> Both main loop thread and vCPU thread are allowed to call
>>> pause_all_vcpus(), and in general resume_all_vcpus() is called after
>>> it. Two issues live in pause_all_vcpus():
>>
>> In general, calling pause_all_vcpus() from VCPU threads is quite dangerous.
>>
>> Do we have reproducers for the cases below?
>>
> 
> I produce the issues by testing ARM vCPU hotplug feature:
> QEMU changes for vCPU hotplug could be cloned from below site,
>       https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
> Guest Kernel changes (by James Morse, ARM) are available here:
>       https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtual_cpu_hotplug/rfc/v2
> 

Thanks for these infos (would be reasonable to include that in the cover letter).

Okay, so likely this is not actually a "fix" for upstream as it is. Understood.

> The procedure to produce problems:
> 1. Startup a Linux VM (e.g., called OS-vcpuhotplug) with 32 possible vCPUs and 16 current vCPUs.
> 2. Log in guestOS and run script[1] to continuously online/offline CPU.
> 3. At host side, run script[2] to continuously hotplug/unhotplug vCPU.
> After several minutes, we can hit these problems.
> 
> Script[1] to online/offline CPU:
> for ((time=1;time<10000000;time++));
> do
>          for ((cpu=16;cpu<32;cpu++));
>          do
>                  echo 1 > /sys/devices/system/cpu/cpu$cpu/online
>          done
> 
>          for ((cpu=16;cpu<32;cpu++));
>          do
>                  echo 0 > /sys/devices/system/cpu/cpu$cpu/online
>          done
> done
> 
> Script[2] to hotplug/unhotplug vCPU:
> for ((time=1;time<1000000;time++));
> do
>          echo $time
>          for ((cpu=16;cpu<=32;cpu++));
>          do
>                  echo "virsh setvcpus OS-vcpuhotplug --count  $cpu --live"
>                  virsh setvcpus OS-vcpuhotplug --count  $cpu --live
>                  sleep 2
>          done
> 
>          for ((cpu=32;cpu>=16;cpu--));
>          do
>                  echo "virsh setvcpus OS-vcpuhotplug --count  $cpu --live"
>                  virsh setvcpus OS-vcpuhotplug --count  $cpu --live
>                  sleep 2
>          done
> 
>          for ((cpu=16;cpu<=32;cpu+=2));
>          do
>                  echo "virsh setvcpus OS-vcpuhotplug --count  $cpu --live"
>                  virsh setvcpus OS-vcpuhotplug --count  $cpu --live
>                  sleep 2
>          done
> 
>          for ((cpu=32;cpu>=16;cpu-=2));
>          do
>                  echo "virsh setvcpus OS-vcpuhotplug --count  $cpu --live"
>                  virsh setvcpus OS-vcpuhotplug --count  $cpu --live
>                  sleep 2
>          done
> done
> 
> The script[1] will call PSCI CPU_ON which emulated by QEMU, which result in calling cpu_reset() on vCPU thread.

I spotted new pause_all_vcpus() / resume_all_vcpus() calls in hw/intc/arm_gicv3_kvm.c and
thought they would be the problematic bit.

Yeah, that's going to be problematic. Further note that a lot of code does not expect
that the BQL is suddenly dropped.

We had issues with that in different context where we ended up wanting to use pause/resume from VCPU context:

https://lore.kernel.org/all/294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com/

This sounds like a bad idea. Read below.

> For ARM architecture, it needs to reset GICC registers, which is only possible when all vcpus paused. So script[1]
> will call pause_all_vcpus() in vCPU thread.
> The script[2] also calls cpu_reset() for newly hotplugged vCPU, which is done in main loop thread.
> So this scenario causes problems as I state in commit message.
> 
>>>
>>> 1. There is possibility that during thread T1 waits on qemu_pause_cond
>>> with bql unlocked, other thread has called
>>> pause_all_vcpus() and resume_all_vcpus(), then thread T1 will stuck,
>>> because the condition all_vcpus_paused() is always false.
>>
>> How can this happen?
>>
>> Two threads calling pause_all_vcpus() is borderline broken, as you note.
>>
>> IIRC, we should call pause_all_vcpus() only if some other mechanism prevents these races. For example, based on runstate changes.
>>
> 
> We already has bql to prevent concurrent calling of pause_all_vcpus() and resume_all_vcpus(). But pause_all_vcpus() will
> unlock bql in the half way, which gives change for other thread to call pause and resume. In the  past, code does not consider
> this problem, now I add retry mechanism to fix it.

Note that BQL did not prevent concurrent calling of pause_all_vcpus(). There had to be something else. Likely that was runstate transitions.

> 
>>
>> Just imagine one thread calling pause_all_vcpus() while another one
>> calls resume_all_vcpus(). It cannot possibly work.
> 
> With bql, we can make sure all vcpus are paused after pause_all_vcpus() finish,  and all vcpus are resumed after resume_all_vcpus() finish.
> 
> For example, the following situation may occur:
> Thread T1:     lock bql  ->    pause_all_vcpus ->   wait on cond and unlock bql  ->   wait T2 unlock bql to lock bql                                            -> lock bql  &&  all_vcpu_paused ->   success and do other work -> unlock bql
> Thread T2:                             wait T1 unlock bql to lock bql            ->   lock bql    ->      resume_all_vcpus   ->   success  and do other work   -> unlock bql


Now trow in another thread and it all gets really complicated :)

Finding ways to avoid pause_all_vcpus() on the ARM reset code would be preferable.

I guess you simply want to do something similar to what KVM does to avoid messing
with pause_all_vcpus(): inhibiting certain IOCTLs.


commit f39b7d2b96e3e73c01bb678cd096f7baf0b9ab39
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Nov 11 10:47:58 2022 -0500

     kvm: Atomic memslot updates
     
     If we update an existing memslot (e.g., resize, split), we temporarily
     remove the memslot to re-add it immediately afterwards. These updates
     are not atomic, especially not for KVM VCPU threads, such that we can
     get spurious faults.
     
     Let's inhibit most KVM ioctls while performing relevant updates, such
     that we can perform the update just as if it would happen atomically
     without additional kernel support.
     
     We capture the add/del changes and apply them in the notifier commit
     stage instead. There, we can check for overlaps and perform the ioctl
     inhibiting only if really required (-> overlap).
     
     To keep things simple we don't perform additional checks that wouldn't
     actually result in an overlap -- such as !RAM memory regions in some
     cases (see kvm_set_phys_mem()).
     
     To minimize cache-line bouncing, use a separate indicator
     (in_ioctl_lock) per CPU.  Also, make sure to hold the kvm_slots_lock
     while performing both actions (removing+re-adding).
     
     We have to wait until all IOCTLs were exited and block new ones from
     getting executed.
     
     This approach cannot result in a deadlock as long as the inhibitor does
     not hold any locks that might hinder an IOCTL from getting finished and
     exited - something fairly unusual. The inhibitor will always hold the BQL.
     
     AFAIKs, one possible candidate would be userfaultfd. If a page cannot be
     placed (e.g., during postcopy), because we're waiting for a lock, or if the
     userfaultfd thread cannot process a fault, because it is waiting for a
     lock, there could be a deadlock. However, the BQL is not applicable here,
     because any other guest memory access while holding the BQL would already
     result in a deadlock.
     
     Nothing else in the kernel should block forever and wait for userspace
     intervention.
     
     Note: pause_all_vcpus()/resume_all_vcpus() or
     start_exclusive()/end_exclusive() cannot be used, as they either drop
     the BQL or require to be called without the BQL - something inhibitors
     cannot handle. We need a low-level locking mechanism that is
     deadlock-free even when not releasing the BQL.

-- 
Cheers,

David / dhildenb


