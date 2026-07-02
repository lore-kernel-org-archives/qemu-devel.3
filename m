Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHU3-00034U-Hp; Thu, 02 Jul 2026 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHU0-000341-6L
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:29:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHTr-0005jt-SV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:29:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0YNX417152
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kZvB4X0WKu7tiZAk1lOiP1hGXgIflisFTH8tg/nIc6w=; b=D4OwpK9QAd9TACc3
 y8YyLk4hFZaKC4iTmJHmrqA0cy4hOpxZm1rxNoyRx/vkix4Kaile+aAAkm+LnI3L
 nukrnIkJ9eJU7HTcq8JvY7nBOE/0YsrvPotktl1fg5HC2Q0TmSsyhVi8AVc7a40J
 HVxz9YizzlGEo+U2uR2F7j4gUsrH5ypINT/DQgc0raAR601FuoEWhniZnSCUUWPF
 BcF8DTFG4JXADL8mPO74/BKrV6E8Jj7hYceAodGan4d8Fkk1AxZ8enjUavSh/79L
 C6cNlFvBPmREfdnyRwV1lhImUqX/olBoOLCwsABduk7f6sMuHo/Gd36QceXcUizQ
 oemhRw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgxk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:29:22 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9694e84752eso1470641241.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998961; x=1783603761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kZvB4X0WKu7tiZAk1lOiP1hGXgIflisFTH8tg/nIc6w=;
 b=JOWi3R9+NuXmbwkvTnbTKAdgUpjPuIFuLrnH5f3CYWoavOjd7v+zws0b225IWfR50s
 AfvqUy8HsGOjaG9w/HnJZndL+ojytwDjtTqD5GFasAul0YANmv5KMVxW+HT7Fh+kD3ex
 CB5WXPAx8wHdzZikgX9ubgEWZfTsrlDdKrmda4qbWFZKixS9ZNuXXK063O0XTOZqMOVB
 y+wc8v7EebBFQgEBJuvudXeOMHTlbWX1hozCLVFhKgsnREO8c+Z18kib822RL4LEl1TH
 MSfuW6CNn2TJ1r/2mz3QrOZRCSCnNvjBapJ8nAbRNysRAyQH583e8XFWfvfHPAevSYxP
 P9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998961; x=1783603761;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kZvB4X0WKu7tiZAk1lOiP1hGXgIflisFTH8tg/nIc6w=;
 b=l4Gw85EqNnCgBMI8edfqi0+/ta7KNZgkStILlIwIVZfPSseYwsjhu2CwD5BJDW8nxh
 dsE7gN+ZEk7hr7jOTEhtyh810RJ9vg86UiNHbk24iLGubo3xxwKKNNPMurFAzL0okN9P
 wP1piEtLJGjZH/3hZtDfUnAqBs9Jj3oyvfXAW0xvoVzGHMZCM8L9EiMfGTBDTFlepVO1
 C5ypBHgN5B7dqJrP+8AOmyczn/a9aOc2L0VMsPolyf5+WKyue81EtUEY6Fw1MKbMwK4Y
 1MtjCUgr0l+m09IJPZvh02Fsf+yk0vG5UWSD+VKS41uQ7yAqjz4LSFtvQWAMrnAZWuwF
 bd7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/N8hlIkVXHVcbeLEur9xEnWLBpduJ8+dAPGlOLHSYzkazoj9R206G5uVmDgkUIa24C/hHiqEewEyH@nongnu.org
X-Gm-Message-State: AOJu0YzfWFfA+ore5UJImfaVJ51NTuBHNklhdfmDxTElTP5WJdCDmck/
 qHVoOqZoqbO4teaJb4Vg83hoO0O8Itti0YC/8FzN/lKcjJZKEl1j9m8uHw16Z2KyismAg0t4/bI
 D2y2GiXcgAQy/ZZtIHLmbJECVMpsQSog+hUf1YBdGgr2EKu82CVqWYpLMjg==
X-Gm-Gg: AfdE7ckswLpjn4jR+TUynDoClw8mytIgAfUK4OdeZWWdbiKZzNnz4l4awCyTBqMqLzj
 ixVIr6CGfKSbJrb5cVdGZ8xkPTGD0Lo/Y6dOOOLvHC2tPPerLBQxEVTwtnpw2dIZ0c9RRHbC8l2
 BTWqmcTO0wp/QqxN+uv1yNIK8Wl3QdG119KlDpZpj+o/hsbcehPTqiIbVuEw9J1Qj2qn+sbKPda
 vpCjach9SGwR8XVyvmpD8KH7y0sPQz4t5LFIgbFJOUBPBmocq7A3fAW7nDd3OE6m5jcMIh98TJF
 sFOq8FZRDHVzCl9oDzvznsZG1iMEM2JB5qXG0fYnOsQLtczklf9c2lY5V3CWZYTZWzb78xpu4NG
 Dmix74guTpjAad6gTUpSObm95z249AlSx8XpcXNwo11vZ
X-Received: by 2002:a05:6102:2c0d:b0:631:37cb:1e64 with SMTP id
 ada2fe7eead31-73dbd5fca0bmr2538503137.4.1782998961465; 
 Thu, 02 Jul 2026 06:29:21 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0d:b0:631:37cb:1e64 with SMTP id
 ada2fe7eead31-73dbd5fca0bmr2538488137.4.1782998961023; 
 Thu, 02 Jul 2026 06:29:21 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-969839dc372sm952383241.9.2026.07.02.06.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:29:20 -0700 (PDT)
Message-ID: <6594f37b-e10e-4252-b5ac-fbf5023335f7@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:29:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] gdbstub: Introduce GdbBreakpointType enumerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-23-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-23-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wzYyY16V_MMgtkIJ9TdT5bjfiyXX0Ewc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MSBTYWx0ZWRfX27WAQwL8ZqRl
 E9HzHU+JGmaxq+8S5xMjJDgLrX0s/8Lrea0FFYLmEZyNEIBWio4/mq6hWaiWySpI2x8xkfYeYNE
 QPx1jy3rEfYUvbNH7yhbVSglzmHiS/c=
X-Proofpoint-GUID: wzYyY16V_MMgtkIJ9TdT5bjfiyXX0Ewc
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a4667b2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fdDmnclW7C0WC3SqdIgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MSBTYWx0ZWRfX6vn0BKnHP792
 GNfS+zZUksDyi9GrfrIuRlbNR4bmUduOG4q7k2ZgEorECRpDGeV48I3n2WepVguecwA6dvidGoW
 +F1oyLZ86gO8Hyar3pYyjT8lp8pRvoRKpMl+IO7y4PSAJNbCdMSVRHyAkwfzznx3dboNbvfSJd7
 qF37/hjXSQKdvR7p1lr6NT2rKtlCgEjzeOH1e3IWFseYmhHSdTw3i1kbmYBU5kHsRQweTJUYDXR
 rTQA96cgVSSsQ4CYYstS8R840gY3KN/ethhKshuQmKrn/IcYHI5nfv4wjzxs9zYobNa1f55AqOd
 uV2J91uQYDbr/v0cTqX8yCWKil7Kh/WUhf0GqtrlPpXS9ags3VZ1zT6FmVnXsZUfMl1frPOt2pm
 P0SJmmUE6fPQuUD+GvhESq99Lc+0wev57qHANEREdDp2PCusxj7Hykie9XDOvx5aPLKeTYN9XK8
 8MeXTemAofFze8SerlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Introduce the GdbBreakpointType enumerator to better follow
> code related to GDB protocol handling.

I've been thinking about using enums a lot more lately ... not only
because it's more idiomatic but it's also a built-in guard for allowed
values.


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   gdbstub/internals.h     |  7 +++++--
>   include/gdbstub/enums.h | 12 +++++++-----
>   gdbstub/system.c        |  6 ++++--
>   gdbstub/user.c          |  6 ++++--
>   4 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index dbae07d2577..32f2520d2ea 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -10,6 +10,7 @@
>   #define GDBSTUB_INTERNALS_H
>   
>   #include "exec/cpu-common.h"
> +#include "gdbstub/enums.h"
>   
>   /*
>    * Most "large" transfers (e.g. memory reads, feature XML
> @@ -217,8 +218,10 @@ void gdb_syscall_handling(const char *syscall_packet);
>    * Break/Watch point support - there is an implementation for system
>    * and user mode.
>    */
> -int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len);
> -int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len);
> +int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
> +                          vaddr addr, vaddr len);
> +int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
> +                          vaddr addr, vaddr len);
>   void gdb_breakpoint_remove_all(CPUState *cs);
>   
>   /**
> diff --git a/include/gdbstub/enums.h b/include/gdbstub/enums.h
> index c4d54a1d083..e4e2043d92c 100644
> --- a/include/gdbstub/enums.h
> +++ b/include/gdbstub/enums.h
> @@ -12,10 +12,12 @@
>   #define DEFAULT_GDBSTUB_PORT "1234"
>   
>   /* GDB breakpoint/watchpoint types */
> -#define GDB_BREAKPOINT_SW        0
> -#define GDB_BREAKPOINT_HW        1
> -#define GDB_WATCHPOINT_WRITE     2
> -#define GDB_WATCHPOINT_READ      3
> -#define GDB_WATCHPOINT_ACCESS    4
> +typedef enum GdbBreakpointType {
> +    GDB_BREAKPOINT_SW       = 0,
> +    GDB_BREAKPOINT_HW       = 1,
> +    GDB_WATCHPOINT_WRITE    = 2,
> +    GDB_WATCHPOINT_READ     = 3,
> +    GDB_WATCHPOINT_ACCESS   = 4,
> +} GdbBreakpointType;
>   
>   #endif /* GDBSTUB_ENUMS_H */
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index d5e09802323..abeeebea8e2 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -624,7 +624,8 @@ int gdb_signal_to_target(int sig)
>    * Break/Watch point helpers
>    */
>   
> -int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
> +int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
> +                          vaddr addr, vaddr len)
>   {
>       const AccelOpsClass *ops = cpus_get_accel();
>       if (ops->insert_breakpoint) {
> @@ -633,7 +634,8 @@ int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
>       return -ENOSYS;
>   }
>   
> -int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len)
> +int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
> +                          vaddr addr, vaddr len)
>   {
>       const AccelOpsClass *ops = cpus_get_accel();
>       if (ops->remove_breakpoint) {
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 90d6ee49fb5..9e6f9a6f376 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -790,7 +790,8 @@ unsigned int gdb_get_max_cpus(void)
>    * Break/Watch point helpers
>    */
>   
> -int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
> +int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
> +                          vaddr addr, vaddr len)
>   {
>       CPUState *cpu;
>       int err = 0;
> @@ -811,7 +812,8 @@ int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
>       }
>   }
>   
> -int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len)
> +int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
> +                          vaddr addr, vaddr len)
>   {
>       CPUState *cpu;
>       int err = 0;


