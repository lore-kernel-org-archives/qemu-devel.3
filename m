Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2024ACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqIS-0004GP-Hs; Mon, 20 Oct 2025 09:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqIK-00049j-Fu
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:51:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqIC-0004Kv-Ep
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:51:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b60971c17acso3540791a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760968274; x=1761573074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FLRcPYHUX1H3kceekwGVJLdRpYa9rDD2yTovwxh3vAI=;
 b=eDvsDgRP2e37XgjrLrSsY6+tXhVwgWhuVV2hZwoBWZAPv3281i8WdIN7fF3DHlB3oM
 xyuqMvDhuE3YjGe7K1y7vwmb4MBeyrZjzyCs+XWlIE3jmRpsE5mVgc/YGvkvbJAIMZEa
 ysoFCJepJUcrhaPjyahq+AwV7/38q/jVU+LG4U1hOqoXAE/zzJltR0Y1qvy336MUh8tB
 EnBJqGA2IVRp+pUs83+WaZhKOEcx7o1wh/GPgu/xj8G3ULNA//+XgzyCUBJ6/SR6nkfT
 RWXVKPkowD14kquKDKuo1i+syEXqSffjSSM0Mn6DoHCbKJQSjGa+/IwzArboHRq+U8yi
 XlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968274; x=1761573074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLRcPYHUX1H3kceekwGVJLdRpYa9rDD2yTovwxh3vAI=;
 b=GYtE5guoj4hU9bl+/6m/BV7U0FI3p8urgy6uS/WHOftA26k+LRrhj45XrjlzhdC4If
 oPynHAmwODM2Zh8RwFaEtnJ02y5JB1yCrdBs2rVwGz3IPrTEtJhXOi8zlab0MTf0PgdV
 RvThPMu3m/1lF07dq1bA0dSN/N7mvGdtlWNyErxIwj1a0iBLt8vVBfNXRWYOwn33cnEn
 milwYM40Gu5F2fjflxzvUk9SNvghmiGKRqTXzrfWqseJUqbSTjnVYs/1iQqff3GtpIuc
 gOLeCrst5msKerXyfynXl5k2oBIwamwbgWeEocC70OjKW1xu4hVBBbhBSYbWRg3HaDF6
 7Wyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0k5zRNLpJodKOBbuH383WcVwkQXtrLQDjKUuMrimUtg9X7KYzFYUkMa3cFP0X5AZQg8RLMxXibmJa@nongnu.org
X-Gm-Message-State: AOJu0YwB3yYTJwkrnbCer2vgP2XOgLk8EVCXmYGoP29B//rNrBHDpbl7
 DoeNzSxU97+1kfO2XqDQ+FlW3AMldeUXjQk85oBYhM23x6QHMSDJrjZjfxVY4wy4QNg=
X-Gm-Gg: ASbGnctE1DJ+vVZeEcw0j7JMJexlMW30ASshHH7eUsptoTD+tdm/q/p7CKRDEAJWk+6
 i00xPzyszjaAumkzthBMlu3TIp+1SenMN+AumWKJ5CQca+CO7I85hsK5lfcyK5Cp4/E1Ltgdul2
 q7UtgjB6Os+P+OkAexMo9i+nJD0vjxwISicMpc/uG+y88bfg0fEVJZqqy1jSqua7+fvB7IH8927
 wncSjf7nrc9oEuAPMUld0Cq3K0TUCkcg3nf//k96vH3InVfBtjTAZJtbEpnV00/FpCebn6ZYuiZ
 142uHTEgO7BmX/bGl4VCNX4qOJjiek9gTpOymYw4ovn9d6ilrYLEzhfOxh1YGqjW5fh+UE8SSdq
 +JF587y3mPy3Zh1+MZq5EsHE731fplFRFO+CfM2XxhNGL3UgKIo/UclWFhFE2wccA31pdkg8oHS
 1YHODRPDdqmFuiFRlO2HoMoK2rv6YKIpCMsWOsAAGVDJpYJrDE2bdG5Eyl5tVlmIju
X-Google-Smtp-Source: AGHT+IGpWHkCTvRx5UrFZo4Wrnv0DENiYoWfJQgWepF+PAl/JEQqJLTNKeaeYSFxOUkgy6h03RcqhA==
X-Received: by 2002:a17:903:15ce:b0:290:b53b:7456 with SMTP id
 d9443c01a7336-290c9c93d46mr153277185ad.5.1760968274357; 
 Mon, 20 Oct 2025 06:51:14 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:1d95:5a7c:524e:bcac:abea?
 ([2804:7f0:b401:1d95:5a7c:524e:bcac:abea])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de30555sm8105183a91.12.2025.10.20.06.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 06:51:14 -0700 (PDT)
Message-ID: <41ac930f-2288-434d-af47-6ed82781727e@linaro.org>
Date: Mon, 20 Oct 2025 10:51:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/8] Specifying cache topology on ARM
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mst@redhat.com,
 mtosatti@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
References: <20250827142152.206-1-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250827142152.206-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alireza,

I've started to review your series and have some questions/comments on it,
please see them inline in the patches.


On 8/27/25 11:21, Alireza Sanaee wrote:
> Specifying the cache layout in virtual machines is useful for
> applications and operating systems to fetch accurate information about
> the cache structure and make appropriate adjustments. Enforcing correct

Since this series applies only to TCG and all cache management
instruction are modeled as NOPs I'm wondering what would be a use case
for being able to specify the cache layout. I'm not saying I'm against it,
specially because it's for the virt machine and we have sort of freedom to
"customize" it in general.


Cheers,
Gustavo

> sharing information can lead to better optimizations. Patches that allow
> for an interface to express caches was landed in the prior cycles. This
> patchset uses the interface as a foundation.  Thus, the device tree and
> ACPI/PPTT table, and device tree are populated based on
> user-provided information and CPU topology.
> 
> Example:
> 
> +----------------+                         +----------------+
> |    Socket 0    |                         |    Socket 1    |
> |    (L3 Cache)  |                         |    (L3 Cache)  |
> +--------+-------+                         +--------+-------+
>           |                                          |
> +--------+--------+                        +--------+--------+
> |   Cluster 0     |                        |   Cluster 0     |
> |   (L2 Cache)    |                        |   (L2 Cache)    |
> +--------+--------+                        +--------+--------+
>           |                                          |
> +--------+--------+  +--------+--------+   +--------+--------+  +--------+----+
> |   Core 0         | |   Core 1        |   |   Core 0        |  |   Core 1    |
> |   (L1i, L1d)     | |   (L1i, L1d)    |   |   (L1i, L1d)    |  |   (L1i, L1d)|
> +--------+--------+  +--------+--------+   +--------+--------+  +--------+----+
>           |                    |                     |                    |
> +--------+              +--------+             +--------+           +--------+
> |Thread 0|              |Thread 1|             |Thread 1|           |Thread 0|
> +--------+              +--------+             +--------+           +--------+
> |Thread 1|              |Thread 0|             |Thread 0|           |Thread 1|
> +--------+              +--------+             +--------+           +--------+
> 
> 
> The following command will represent the system relying on **ACPI PPTT tables**.
> 
> ./qemu-system-aarch64 \
>   -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>   -cpu max \
>   -m 2048 \
>   -smp sockets=2,clusters=1,cores=2,threads=2 \
>   -kernel ./Image.gz \
>   -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>   -initrd rootfs.cpio.gz \
>   -bios ./edk2-aarch64-code.fd \
>   -nographic
> 
> The following command will represent the system relying on **the device tree**.
> 
> ./qemu-system-aarch64 \
>   -machine virt,acpi=off,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>   -cpu max \
>   -m 2048 \
>   -smp sockets=2,clusters=1,cores=2,threads=2 \
>   -kernel ./Image.gz \
>   -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=off" \
>   -initrd rootfs.cpio.gz \
>   -nographic
> 
> Failure cases:
>      1) There are scenarios where caches exist in systems' registers but
>      left unspecified by users. In this case qemu returns failure.
> 
>      2) SMT threads cannot share caches which is not very common. More
>      discussions here [1].
> 
> Currently only three levels of caches are supported to be specified from
> the command line. However, increasing the value does not require
> significant changes. Further, this patch assumes l2 and l3 unified
> caches and does not allow l(2/3)(i/d). The level terminology is
> thread/core/cluster/socket. Hierarchy assumed in this patch:
> Socket level = Cluster level + 1 = Core level + 2 = Thread level + 3;
> 
> Possible future enhancements:
>    1) Separated data and instruction cache at L2 and L3.
>    2) Additional cache controls.  e.g. size of L3 may not want to just
>    match the underlying system, because only some of the associated host
>    CPUs may be bound to this VM.
> 
> [1] https://lore.kernel.org/devicetree-spec/20250203120527.3534-1-alireza.sanaee@huawei.com/
> 
> Change Log:
>    v15->v16:
>      * Rebase to e771ba98de25c9f43959f79fc7099cf7fbba44cc (Open 10.2 development tree)
>      * v15: https://lore.kernel.org/qemu-devel/20250812122829.204-1-alireza.sanaee@huawei.com/
> 
>    v14->v15:
>     * Introduced a separate patch for loongarch64 build_pptt function.
>     * Made sure loongarch64 tests pass.
>     * Downgraded to V2 for ACPI PPTT. Removed PPTT IDs as was not necessary.
>     * Removed dependency as it's been merged in the recent cycle.
>       -- 20250604115233.1234-1-alireza.sanaee@huawei.com
>     * Fixed styling issues and removed irrelevant changes.
>     * Moved cache headers to core/cpu.h to be used in both acpi and virt.
>     * v14: https://lore.kernel.org/qemu-devel/20250707121908.155-1-alireza.sanaee@huawei.com/
>     # Thanks to Jonathan and Zhao for their comments.
> 
>    v13->v14:
>     * Rebased on latest staging.
>     * Made some naming changes to machine-smp.c, addd docs added to the
>          same file.
> 
>    v12->v13:
>     * Applied comments from Zhao.
>     * Introduced a new patch for machine specific cache topology functions.
>     * Base: bc98ffdc7577e55ab8373c579c28fe24d600c40f.
> 
>    v11->v12:
>     * Patch #4 couldn't not merge properly as the main file diverged. Now it is fixed (hopefully).
>     * Loonarch build_pptt function updated.
>     * Rebased on 09be8a511a2e278b45729d7b065d30c68dd699d0.
> 
>    v10->v11:
>     * Fix some coding style issues.
>     * Rename some variables.
> 
>    v9->v10:
>     * PPTT rev down to 2.
> 
>    v8->v9:
>     * rebase to 10
>     * Fixed a bug in device-tree generation related to a scenario when
>          caches are shared at core in higher levels than 1.
>    v7->v8:
>     * rebase: Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging
>     * I mis-included a file in patch #4 and I removed it in this one.
> 
>    v6->v7:
>     * Intel stuff got pulled up, so rebase.
>     * added some discussions on device tree.
> 
>    v5->v6:
>     * Minor bug fix.
>     * rebase based on new Intel patchset.
>       - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> 
>    v4->v5:
>      * Added Reviewed-by tags.
>      * Applied some comments.
> 
>    v3->v4:
>      * Device tree added.
> 
> Alireza Sanaee (8):
>    target/arm/tcg: increase cache level for cpu=max
>    hw/core/machine: topology functions capabilities added
>    hw/arm/virt: add cache hierarchy to device tree
>    bios-tables-test: prepare to change ARM ACPI virt PPTT
>    acpi: add caches to ACPI build_pptt table function
>    hw/acpi: add cache hierarchy to pptt table
>    tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
>    Update the ACPI tables based on new aml-build.c
> 
>   hw/acpi/aml-build.c                        | 203 +++++++++-
>   hw/arm/virt-acpi-build.c                   |   8 +-
>   hw/arm/virt.c                              | 412 ++++++++++++++++++++-
>   hw/core/machine-smp.c                      |  56 +++
>   hw/loongarch/virt-acpi-build.c             |   4 +-
>   include/hw/acpi/aml-build.h                |   4 +-
>   include/hw/acpi/cpu.h                      |  10 +
>   include/hw/arm/virt.h                      |   7 +-
>   include/hw/boards.h                        |   5 +
>   include/hw/core/cpu.h                      |  12 +
>   target/arm/tcg/cpu64.c                     |  13 +
>   tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 516 bytes
>   tests/qtest/bios-tables-test.c             |   4 +
>   13 files changed, 723 insertions(+), 15 deletions(-)
> 


