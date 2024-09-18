Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB77DCDD541
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqwoR-0007v5-I8; Wed, 18 Sep 2024 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqwoP-0007uF-2G
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:41:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqwoL-00070Y-D2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:41:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IA4O6u024611;
 Wed, 18 Sep 2024 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SV7JuGRTfet6CFFRNH+BKDceTI8X94GwlrJEKQBYCyg=; b=JU7deBYe6RmeOn2o
 hO3KSpHhunLfxcqdcRX1IVjlD9HayhdpmKcP0QyeF6SqT+kR802oFk/IIMW2zeGz
 FT0b9hBcP2Zins3X4Gz8o8xMEo4FvJEeiYGM3bEtraQAvBf6EtOh2zsIfGFf0NMi
 M3g2qEb+u/ytf0bvOw+/o7fd3TTp2LTvoY31KyYC+i9t0JgubzO947b3v7eQo+KJ
 v0zM77uXz9zNq/8qc4AiRvsxCMbwK9FBOqZDS48mS0dpJDLG6yXsPRUrQ+c83F5V
 YD0Q//19+SfiUSG4/tb6xf4YfLYP9V+vtDRb7oblnonFpF34P1Yrz480/Y2TnFjq
 8+Ve3w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gd2dnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 15:41:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48IFfZuB016869
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 15:41:35 GMT
Received: from [10.110.61.117] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 08:41:34 -0700
Message-ID: <bab6e4f3-e3a2-4cf7-866e-4e70a3cd41c7@quicinc.com>
Date: Wed, 18 Sep 2024 10:41:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: update syscall_nr.h to Linux v6.10
To: Laurent Vivier <laurent@vivier.eu>, <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <20240918074256.720617-1-laurent@vivier.eu>
 <20240918074256.720617-2-laurent@vivier.eu>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240918074256.720617-2-laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: Z8zjNE9_Ai4UgHcZV20pNzJFWL93OO4D
X-Proofpoint-GUID: Z8zjNE9_Ai4UgHcZV20pNzJFWL93OO4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=949 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 9/18/2024 2:42 AM, Laurent Vivier wrote:
> Automatically generated using scripts/gensyscalls.sh
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/aarch64/syscall_nr.h     | 19 ++++++++++++++++++-
>   linux-user/hexagon/syscall_nr.h     | 20 ++++++++++++++++++--
>   linux-user/loongarch64/syscall_nr.h | 14 +++++++++++++-
>   linux-user/openrisc/syscall_nr.h    | 18 +++++++++++++++++-
>   linux-user/riscv/syscall32_nr.h     | 23 ++++++++++++++++++++---
>   linux-user/riscv/syscall64_nr.h     | 23 ++++++++++++++++++++---
>   6 files changed, 106 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
> index 12ef002d60f9..c2e09ed5c50c 100644
> --- a/linux-user/aarch64/syscall_nr.h
> +++ b/linux-user/aarch64/syscall_nr.h
> @@ -305,9 +305,26 @@
>   #define TARGET_NR_process_madvise 440
>   #define TARGET_NR_epoll_pwait2 441
>   #define TARGET_NR_mount_setattr 442
> +#define TARGET_NR_quotactl_fd 443
>   #define TARGET_NR_landlock_create_ruleset 444
>   #define TARGET_NR_landlock_add_rule 445
>   #define TARGET_NR_landlock_restrict_self 446
> -#define TARGET_NR_syscalls 447
> +#define TARGET_NR_memfd_secret 447
> +#define TARGET_NR_process_mrelease 448
> +#define TARGET_NR_futex_waitv 449
> +#define TARGET_NR_set_mempolicy_home_node 450
> +#define TARGET_NR_cachestat 451
> +#define TARGET_NR_fchmodat2 452
> +#define TARGET_NR_map_shadow_stack 453
> +#define TARGET_NR_futex_wake 454
> +#define TARGET_NR_futex_wait 455
> +#define TARGET_NR_futex_requeue 456
> +#define TARGET_NR_statmount 457
> +#define TARGET_NR_listmount 458
> +#define TARGET_NR_lsm_get_self_attr 459
> +#define TARGET_NR_lsm_set_self_attr 460
> +#define TARGET_NR_lsm_list_modules 461
> +#define TARGET_NR_mseal 462
> +#define TARGET_NR_syscalls 463
>   
>   #endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
> diff --git a/linux-user/hexagon/syscall_nr.h b/linux-user/hexagon/syscall_nr.h
> index b047dbbf6df3..f3220b74f7c3 100644
> --- a/linux-user/hexagon/syscall_nr.h
> +++ b/linux-user/hexagon/syscall_nr.h
> @@ -90,7 +90,7 @@
>   #define TARGET_NR_sync 81
>   #define TARGET_NR_fsync 82
>   #define TARGET_NR_fdatasync 83
> -#define TARGET_NR_sync_file_range 84
> +#define TARGET_NR_sync_file_range2 84
>   #define TARGET_NR_timerfd_create 85
>   #define TARGET_NR_timerfd_settime 86
>   #define TARGET_NR_timerfd_gettime 87
> @@ -324,9 +324,25 @@
>   #define TARGET_NR_process_madvise 440
>   #define TARGET_NR_epoll_pwait2 441
>   #define TARGET_NR_mount_setattr 442
> +#define TARGET_NR_quotactl_fd 443
>   #define TARGET_NR_landlock_create_ruleset 444
>   #define TARGET_NR_landlock_add_rule 445
>   #define TARGET_NR_landlock_restrict_self 446
> -#define TARGET_NR_syscalls 447
> +#define TARGET_NR_process_mrelease 448
> +#define TARGET_NR_futex_waitv 449
> +#define TARGET_NR_set_mempolicy_home_node 450
> +#define TARGET_NR_cachestat 451
> +#define TARGET_NR_fchmodat2 452
> +#define TARGET_NR_map_shadow_stack 453
> +#define TARGET_NR_futex_wake 454
> +#define TARGET_NR_futex_wait 455
> +#define TARGET_NR_futex_requeue 456
> +#define TARGET_NR_statmount 457
> +#define TARGET_NR_listmount 458
> +#define TARGET_NR_lsm_get_self_attr 459
> +#define TARGET_NR_lsm_set_self_attr 460
> +#define TARGET_NR_lsm_list_modules 461
> +#define TARGET_NR_mseal 462
> +#define TARGET_NR_syscalls 463

For hexagon system calls:

Reviewed-by: Brian Cain <bcain@quicinc.com>


Note for future updates that as of v6.11 hexagon has switched to the new 
system call table.


>   
>   #endif /* LINUX_USER_HEXAGON_SYSCALL_NR_H */
> diff --git a/linux-user/loongarch64/syscall_nr.h b/linux-user/loongarch64/syscall_nr.h
> index be00915adf22..fefca6f5f6d3 100644
> --- a/linux-user/loongarch64/syscall_nr.h
> +++ b/linux-user/loongarch64/syscall_nr.h
> @@ -307,6 +307,18 @@
>   #define TARGET_NR_process_mrelease 448
>   #define TARGET_NR_futex_waitv 449
>   #define TARGET_NR_set_mempolicy_home_node 450
> -#define TARGET_NR_syscalls 451
> +#define TARGET_NR_cachestat 451
> +#define TARGET_NR_fchmodat2 452
> +#define TARGET_NR_map_shadow_stack 453
> +#define TARGET_NR_futex_wake 454
> +#define TARGET_NR_futex_wait 455
> +#define TARGET_NR_futex_requeue 456
> +#define TARGET_NR_statmount 457
> +#define TARGET_NR_listmount 458
> +#define TARGET_NR_lsm_get_self_attr 459
> +#define TARGET_NR_lsm_set_self_attr 460
> +#define TARGET_NR_lsm_list_modules 461
> +#define TARGET_NR_mseal 462
> +#define TARGET_NR_syscalls 463
>   
>   #endif /* LINUX_USER_LOONGARCH_SYSCALL_NR_H */
> diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/syscall_nr.h
> index f7faddb54c58..2b66f99ea66a 100644
> --- a/linux-user/openrisc/syscall_nr.h
> +++ b/linux-user/openrisc/syscall_nr.h
> @@ -326,9 +326,25 @@
>   #define TARGET_NR_process_madvise 440
>   #define TARGET_NR_epoll_pwait2 441
>   #define TARGET_NR_mount_setattr 442
> +#define TARGET_NR_quotactl_fd 443
>   #define TARGET_NR_landlock_create_ruleset 444
>   #define TARGET_NR_landlock_add_rule 445
>   #define TARGET_NR_landlock_restrict_self 446
> -#define TARGET_NR_syscalls 447
> +#define TARGET_NR_process_mrelease 448
> +#define TARGET_NR_futex_waitv 449
> +#define TARGET_NR_set_mempolicy_home_node 450
> +#define TARGET_NR_cachestat 451
> +#define TARGET_NR_fchmodat2 452
> +#define TARGET_NR_map_shadow_stack 453
> +#define TARGET_NR_futex_wake 454
> +#define TARGET_NR_futex_wait 455
> +#define TARGET_NR_futex_requeue 456
> +#define TARGET_NR_statmount 457
> +#define TARGET_NR_listmount 458
> +#define TARGET_NR_lsm_get_self_attr 459
> +#define TARGET_NR_lsm_set_self_attr 460
> +#define TARGET_NR_lsm_list_modules 461
> +#define TARGET_NR_mseal 462
> +#define TARGET_NR_syscalls 463
>   
>   #endif /* LINUX_USER_OPENRISC_SYSCALL_NR_H */
> diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
> index 412e58e5b2f2..42376ac8c7d2 100644
> --- a/linux-user/riscv/syscall32_nr.h
> +++ b/linux-user/riscv/syscall32_nr.h
> @@ -7,6 +7,8 @@
>   #define LINUX_USER_RISCV_SYSCALL32_NR_H
>   
>   #define TARGET_NR_io_setup 0
> +#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
> +#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
>   #define TARGET_NR_io_destroy 1
>   #define TARGET_NR_io_submit 2
>   #define TARGET_NR_io_cancel 3
> @@ -227,8 +229,6 @@
>   #define TARGET_NR_perf_event_open 241
>   #define TARGET_NR_accept4 242
>   #define TARGET_NR_arch_specific_syscall 244
> -#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
> -#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
>   #define TARGET_NR_prlimit64 261
>   #define TARGET_NR_fanotify_init 262
>   #define TARGET_NR_fanotify_mark 263
> @@ -300,9 +300,26 @@
>   #define TARGET_NR_process_madvise 440
>   #define TARGET_NR_epoll_pwait2 441
>   #define TARGET_NR_mount_setattr 442
> +#define TARGET_NR_quotactl_fd 443
>   #define TARGET_NR_landlock_create_ruleset 444
>   #define TARGET_NR_landlock_add_rule 445
>   #define TARGET_NR_landlock_restrict_self 446
> -#define TARGET_NR_syscalls 447
> +#define TARGET_NR_memfd_secret 447
> +#define TARGET_NR_process_mrelease 448
> +#define TARGET_NR_futex_waitv 449
> +#define TARGET_NR_set_mempolicy_home_node 450
> +#define TARGET_NR_cachestat 451
> +#define TARGET_NR_fchmodat2 452
> +#define TARGET_NR_map_shadow_stack 453
> +#define TARGET_NR_futex_wake 454
> +#define TARGET_NR_futex_wait 455
> +#define TARGET_NR_futex_requeue 456
> +#define TARGET_NR_statmount 457
> +#define TARGET_NR_listmount 458
> +#define TARGET_NR_lsm_get_self_attr 459
> +#define TARGET_NR_lsm_set_self_attr 460
> +#define TARGET_NR_lsm_list_modules 461
> +#define TARGET_NR_mseal 462
> +#define TARGET_NR_syscalls 463
>   
>   #endif /* LINUX_USER_RISCV_SYSCALL32_NR_H */
> diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
> index 29e1eb20753e..96ee92ec31f8 100644
> --- a/linux-user/riscv/syscall64_nr.h
> +++ b/linux-user/riscv/syscall64_nr.h
> @@ -7,6 +7,8 @@
>   #define LINUX_USER_RISCV_SYSCALL64_NR_H
>   
>   #define TARGET_NR_io_setup 0
> +#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
> +#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
>   #define TARGET_NR_io_destroy 1
>   #define TARGET_NR_io_submit 2
>   #define TARGET_NR_io_cancel 3
> @@ -250,8 +252,6 @@
>   #define TARGET_NR_accept4 242
>   #define TARGET_NR_recvmmsg 243
>   #define TARGET_NR_arch_specific_syscall 244
> -#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
> -#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
>   #define TARGET_NR_wait4 260
>   #define TARGET_NR_prlimit64 261
>   #define TARGET_NR_fanotify_init 262
> @@ -306,9 +306,26 @@
>   #define TARGET_NR_process_madvise 440
>   #define TARGET_NR_epoll_pwait2 441
>   #define TARGET_NR_mount_setattr 442
> +#define TARGET_NR_quotactl_fd 443
>   #define TARGET_NR_landlock_create_ruleset 444
>   #define TARGET_NR_landlock_add_rule 445
>   #define TARGET_NR_landlock_restrict_self 446
> -#define TARGET_NR_syscalls 447
> +#define TARGET_NR_memfd_secret 447
> +#define TARGET_NR_process_mrelease 448
> +#define TARGET_NR_futex_waitv 449
> +#define TARGET_NR_set_mempolicy_home_node 450
> +#define TARGET_NR_cachestat 451
> +#define TARGET_NR_fchmodat2 452
> +#define TARGET_NR_map_shadow_stack 453
> +#define TARGET_NR_futex_wake 454
> +#define TARGET_NR_futex_wait 455
> +#define TARGET_NR_futex_requeue 456
> +#define TARGET_NR_statmount 457
> +#define TARGET_NR_listmount 458
> +#define TARGET_NR_lsm_get_self_attr 459
> +#define TARGET_NR_lsm_set_self_attr 460
> +#define TARGET_NR_lsm_list_modules 461
> +#define TARGET_NR_mseal 462
> +#define TARGET_NR_syscalls 463
>   
>   #endif /* LINUX_USER_RISCV_SYSCALL64_NR_H */

