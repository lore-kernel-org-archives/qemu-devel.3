Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C789CE8D5F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 08:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srCks-0003B4-9w; Thu, 19 Sep 2024 04:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1srCkq-0003AO-MZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 04:43:12 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1srCko-0001Kn-Ui
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 04:43:12 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MplHR-1sC5FQ1Roz-00oGhA; Thu, 19 Sep 2024 10:42:53 +0200
Message-ID: <869328cc-1a6d-44ca-b54f-35714c0c21b0@vivier.eu>
Date: Thu, 19 Sep 2024 10:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: update syscall_nr.h to Linux v6.10
To: Brian Cain <quic_bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 sidneym@quicinc.com, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <20240918074256.720617-1-laurent@vivier.eu>
 <20240918074256.720617-2-laurent@vivier.eu>
 <bab6e4f3-e3a2-4cf7-866e-4e70a3cd41c7@quicinc.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <bab6e4f3-e3a2-4cf7-866e-4e70a3cd41c7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:llzedFUEZ5yshlMJFQ+MsGNvSPU9ozmTSDHkfoq5ZtSt33rWrnc
 pEafawQczRv8k8m91oc3t8mpyxzmunqwG0obm8d7jxfjlOmA3YeWvtBDmKB7dJBUeLFS6k4
 alvz25HcinJqodiCerQxFGe9hGfCvWRa+s7w0Gy+tPtEtyJffFkwD8h45HcgJIcmUv0VlSA
 JOLLt7Svet4dENc3RS7fA==
UI-OutboundReport: notjunk:1;M01:P0:TkhG/H//dHw=;m6/X0/DInILX2zKSJXTfa8Vofoj
 zGV6bGZ0lE0VkTCiIuA4yRzfoCmsyx3DcUtVfZOdazn1DmHwrV5nRAnVI4OmhS+JwpeUUfWdX
 XEo5iRPNC5tfUpcFxFW5lGqAA5DvzcjqRSXjvpn/P0L3uKQWluiaGo9jQ8uOJEraNPPQVSKiP
 2qswjeoskPLWGJ+YCoHSb6XaTVJkbVSONMaOBZNO7jQc7Mhj3moQe8FVAdFXxXQs4oBcyQ1vD
 2ClMrVZRDBbyxxwVt6bbIKRFM3GdK/5FCgfxYVJv5KfKGd9JwStOKDIMMsjzzIo6sUS2Tlqku
 cUjOEC+cbmx/Q3pxmkGxGCDOEhF0KPutxZCiLBodhKho35rEbvXhj+S5jJLQfLsOHc3ekoSyl
 JWTcADWPVKDLLk9z4d4MBbbu0H+U4g85yTsumLyWaNV9/Wm0Oycz76/R56uRhQuIV+tjW1DD3
 CBIMq3YLVOh+d4iGPydPTQ1O0JL4UymgbXimQw6fCH0h2dI/fJ0eB+EiDToJUNLSeqmPLvJ/y
 Hp07g0/NpzNbcmpeMgoHG7BFxVBDPFHYBr7HZKZCyNADlZuk6XKXQb9y0TqRvFii62n8h9YM7
 pA8R0faCB8IOdGwh+uKcU0bOBJDVBp+hVGCT3cFj2SZak3GKwSvLioZVB65j0c1WIeTVnj6ng
 OseRdRlhE3kRr708ZYKQ2O34DRwMqU+jBDkG0ELIRPM3InawgN6t6IHBqqYaH9f4ldP9JVw0N
 Siqn6wp1uyo0ErBtKYiF8meiTYUxv/Vcg==
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Le 18/09/2024 à 17:41, Brian Cain a écrit :
> 
> On 9/18/2024 2:42 AM, Laurent Vivier wrote:
>> Automatically generated using scripts/gensyscalls.sh
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   linux-user/aarch64/syscall_nr.h     | 19 ++++++++++++++++++-
>>   linux-user/hexagon/syscall_nr.h     | 20 ++++++++++++++++++--
>>   linux-user/loongarch64/syscall_nr.h | 14 +++++++++++++-
>>   linux-user/openrisc/syscall_nr.h    | 18 +++++++++++++++++-
>>   linux-user/riscv/syscall32_nr.h     | 23 ++++++++++++++++++++---
>>   linux-user/riscv/syscall64_nr.h     | 23 ++++++++++++++++++++---
>>   6 files changed, 106 insertions(+), 11 deletions(-)
>>
...
>> diff --git a/linux-user/hexagon/syscall_nr.h b/linux-user/hexagon/syscall_nr.h
>> index b047dbbf6df3..f3220b74f7c3 100644
>> --- a/linux-user/hexagon/syscall_nr.h
>> +++ b/linux-user/hexagon/syscall_nr.h
>> @@ -90,7 +90,7 @@
>>   #define TARGET_NR_sync 81
>>   #define TARGET_NR_fsync 82
>>   #define TARGET_NR_fdatasync 83
>> -#define TARGET_NR_sync_file_range 84
>> +#define TARGET_NR_sync_file_range2 84
>>   #define TARGET_NR_timerfd_create 85
>>   #define TARGET_NR_timerfd_settime 86
>>   #define TARGET_NR_timerfd_gettime 87
>> @@ -324,9 +324,25 @@
>>   #define TARGET_NR_process_madvise 440
>>   #define TARGET_NR_epoll_pwait2 441
>>   #define TARGET_NR_mount_setattr 442
>> +#define TARGET_NR_quotactl_fd 443
>>   #define TARGET_NR_landlock_create_ruleset 444
>>   #define TARGET_NR_landlock_add_rule 445
>>   #define TARGET_NR_landlock_restrict_self 446
>> -#define TARGET_NR_syscalls 447
>> +#define TARGET_NR_process_mrelease 448
>> +#define TARGET_NR_futex_waitv 449
>> +#define TARGET_NR_set_mempolicy_home_node 450
>> +#define TARGET_NR_cachestat 451
>> +#define TARGET_NR_fchmodat2 452
>> +#define TARGET_NR_map_shadow_stack 453
>> +#define TARGET_NR_futex_wake 454
>> +#define TARGET_NR_futex_wait 455
>> +#define TARGET_NR_futex_requeue 456
>> +#define TARGET_NR_statmount 457
>> +#define TARGET_NR_listmount 458
>> +#define TARGET_NR_lsm_get_self_attr 459
>> +#define TARGET_NR_lsm_set_self_attr 460
>> +#define TARGET_NR_lsm_list_modules 461
>> +#define TARGET_NR_mseal 462
>> +#define TARGET_NR_syscalls 463
> 
> For hexagon system calls:
> 
> Reviewed-by: Brian Cain <bcain@quicinc.com>
> 
> 
> Note for future updates that as of v6.11 hexagon has switched to the new system call table.
> 

Yes, I've already a series that manages that for hexagon, arm64, loongarch, riscv and openrisc.
I will send it soon.

Thanks,
Laurent


