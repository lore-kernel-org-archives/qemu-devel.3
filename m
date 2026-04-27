Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A4DFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHQPU-0001wf-85; Mon, 27 Apr 2026 14:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHQPQ-0001w3-PK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:10:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHQPO-0007SI-QP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:10:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCp8DL2382817
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 18:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1//yClIwEzDnYJEqNqcwQWi1yc1hpW4awUIQoT1n9DI=; b=FxEEMf3c+QrtDe1g
 3S8J5HuStQm+TJDB/Pty5Sw7E/l5GED6+uxU7wB89hthgXhOkPVmMJ77b21MK+CO
 /zqnv3oabjAhZJ2kvbMdhWGIef5nDC4hPDJNhXS9JHppIm2GCrwkKq9vbSInjsgh
 +azKD+CZ9aMutMuAnMzvPMus6J9ZzaH+retWdMUJ6yUz3pu1r+GT01uzAvZl8sy6
 4+WJSe2nAs/RoSvsFjxgnDpBfSKRt1WUAAo3JZmcTG023AOAq1xeVxGaUYN1ioL3
 qEqCnLHgwUoAUxNYeLqWUmtyJo6wtA1lmHhWS1h5tVkFEMgOy+8yt+nNIXVnxXlC
 1xnP3A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xs8jb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 18:10:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2d93379001eso24527698eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777313410; x=1777918210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1//yClIwEzDnYJEqNqcwQWi1yc1hpW4awUIQoT1n9DI=;
 b=FkRSgVt6tBW7eUg27NTSfXmQZQQar8mVqY0a8jjhgZipggnMRZv6SsHqhsUtB4u9Vz
 9kFxacQlDozthZ970yYanUkttqK8IOO6li8q05thFFJrNsQj8VA0/WvOf9WA3E63Oxd4
 msgD6zx4UVdUYLvH8dQ61W0pjZ6CJQ4QPIBxQjhe/314h1ctRuISzV69buSUwiQgXwTu
 ByUgFUkM6MiwvBLrx867HcRgidlKfkZynS/oJaZZIecSphZ6wd+QHHElJkCEgdf5N968
 nwhV3vGlsCyIrggbehAFaI0sd+nSFXu0CNRfGPOiSzqZ2HlCqZyKTDgYs6IjRoL1V8ci
 MwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777313410; x=1777918210;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1//yClIwEzDnYJEqNqcwQWi1yc1hpW4awUIQoT1n9DI=;
 b=hqnj4MYlZUBHeNzK4cOoS/j0biLd2HNc0mw3HPUDX3xW5R/QCnweQ2V+56pBBlp/jn
 rOH8R+XgmWYf4zFAth9Csxn741TimAozYPsVYFKSHBTcIFT/msXcoX5eH3I6ax+A2+5f
 hC7gkt/8MRQN2A+5mnGUFuXb1N90UkFg6lBxJef/4Wqz5WzDxehLWCu1xRnN1AZsa+HC
 uoXj2LjRIHPlNOeCJpb8osjuzrX2PcpJTSYmu0Tc3CxrNg7XsLpoRjY4NOpaBENhFS+K
 HuMvnm+H25fxD0tjLRE2kyooqjT4Zsf11FjOTc9fFw6akhhko/biwbkeJIRsZPEmIfRs
 iiyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8exUHRqEvsb5JHXLlJnJdWzVScMtccn6vJy669KssWUBlxXlGbk8LtX8mG1nquhX2dW6Sc5nx8OP1U@nongnu.org
X-Gm-Message-State: AOJu0Yw2GMcaja9Q6OFMr61/0JqwtCnSF2sEcBIkbnwpspI7Pv2Sp4UB
 hM7Qmr/UIvo8tpBtJvMxytyfzhMq835bjA43snjhANLrOWOM+eDSltnJpiUD1CnBs/S9t4Pk60F
 YoTBeAiWixrF0ZLKQ5WhThBYlXZgw548LHR8QRsb/ZhOQ/O5/q5VzDpDrhg==
X-Gm-Gg: AeBDievHxkOY47+9pen9e3T4tUtB5QeJ47aDoKyiOMPgP1zlFFbhp0vEUEIRMJD34E4
 i4moxof79Bp+s6kK+dQuIL5PnYmfhFXHglNc28AXNhVRg45c1FZLI/fpBNh2gzUg7mavdut12d+
 ksYf/X/FZd+LFdRxA5CoRqzzhSHgQe0+K8/wOMxSoWsuJGXqIYc4AUrwR7UO0jk6vxSM6be52Rt
 bTwWncXvQiRLTbAN8EmJ/rE3UXdTBTB/pXDJsr1fxKlyawZ/Rjj6SgjsNSANW7g7TQ82neyiH5q
 WBfRVMvW+7bQVc5p2sSZZjr2Juqu/Pnh0fxtwD6VLCpIm0YiFSYR8LqVlZptEa5W3KHgt0HRzoJ
 dqVgbaUdmO0D7y0tpug7TnLBX+wOWWzieQX6DvFFyt+d+tQiXAvaZkEmBfl09K9jJpmxA1shSmS
 k+gO/q8y28hECDubW8+rnN47R6
X-Received: by 2002:a05:7300:72c9:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-2ed09ad6689mr41376eec.4.1777313410049; 
 Mon, 27 Apr 2026 11:10:10 -0700 (PDT)
X-Received: by 2002:a05:7300:72c9:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-2ed09ad6689mr41351eec.4.1777313409477; 
 Mon, 27 Apr 2026 11:10:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a80c7sm55076052eec.10.2026.04.27.11.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 11:10:08 -0700 (PDT)
Message-ID: <1fcf3763-ea2b-4d58-a82e-0608377135c5@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] linux-user: Validate tkill/tgkill targets are
 guest threads
To: Ali Raza <elirazamumtaz@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
 <20260424-master-v2-2-8b50b5c063ed@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424-master-v2-2-8b50b5c063ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69efa683 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EKgyEONzLrvFGP0n7U8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: qF5ujG2ZENGUS5U4EyuqghUypXyYdnPN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE5MyBTYWx0ZWRfX1SbUP4rccBlj
 jo8bcRwHMSGber83bSy6U7wYgku4e0l0v9ChiQPYx1qDPhHNO2sDdWu01KIOKjGUbxD8GzQc/+S
 RUk9v3NxUT+rYzrWsRR/W7SakICNVKy/5FKQUhQj0CA3aPfq0ugY3DsFLGuwwIz/oYdz633XwRI
 6GIu0Z9oL+5Iw+xkb2cns2kIcdlYDL8A+Kn3138ag5itSWOKlg7ihFo+eUWvnfqvrka8BstYvc8
 frch7xocYsR0ZuGECTuZgDG2afP893VAEdKjCdcYNaQI1IVc25Ydp3fwxELrbpK7LH0INNK5BmZ
 TnAo1b+Nx1dxmm0FoinrgCFOzAPMZL62MWQIeBPLC//GBTeXtuQPnJ8YB3XDXSjT+9JZc3Vu10c
 rcOdVbF+gGqjnmaX4wxBWgJv2RDG4FBfaj/HBoXiIzlpqS4qwBqCqe5PjkoGObpNPcGjQ5wTTC8
 SY2G+iQv4U3iu+xzM4A==
X-Proofpoint-GUID: qF5ujG2ZENGUS5U4EyuqghUypXyYdnPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/2026 2:36 PM, Ali Raza wrote:
> The tkill and tgkill syscall handlers pass the guest-supplied TID
> directly to the host kernel without checking whether it belongs to a
> guest thread.  This allows a guest to send signals to QEMU-internal
> host threads (RCU, TCG workers) that have no CPUState and no guest
> signal handlers, which can cause hangs or disrupt QEMU operation.
> 
> Add validation that checks the target TID against the guest CPU list
> before forwarding the signal to the host.  For tgkill, also verify
> that the tgid matches the current process.  Return -ESRCH for TIDs
> that do not correspond to any guest thread, matching the behavior a
> real kernel would return for a nonexistent thread.
> 
> This complements the /proc/*/task/ filtering in the previous commit
> to provide defense-in-depth: even if a guest discovers or guesses a
> QEMU-internal thread TID, it cannot send signals to it.
> 
> Signed-off-by: Ali Raza (@locus-x64)
> 
> ---
> Changes in v2:
> - Range-check tid/tgid before narrowing from abi_long to pid_t.
> - do_tkill: only reject signals whose target lives in our own host
>   process and is not a guest thread; cross-process tkill is passed
>   through to the kernel unchanged.
> - do_tgkill: drop the previous tgid==getpid() blanket rejection and
>   apply the same in-our-process-only filter, so legitimate
>   cross-process tgkill keeps working.
> - New tid_is_qemu_internal() helper based on the CPU list and
>   /proc/self/task/<tid> presence.
> ---
>  linux-user/syscall.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 44f2cd851f..c7dea1086c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9161,6 +9161,27 @@ static bool is_guest_tid(pid_t tid)
>      return false;
>  }
>  
> +/*
> + * Return true iff @tid identifies a thread inside our own host process
> + * that is not one of the guest threads -- i.e. a QEMU-internal helper
> + * thread (RCU, TCG worker, ...).  Cross-process tids and unknown tids
> + * are not classified here and the caller should pass the syscall
> + * through to the kernel unchanged.
> + */
> +static bool tid_is_qemu_internal(pid_t tid)
> +{
> +    char path[64];
> +
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        if (is_guest_tid(tid)) {
> +            return false;
> +        }
> +    }
> +
> +    snprintf(path, sizeof(path), "/proc/self/task/%d", (int)tid);
> +    return access(path, F_OK) == 0;
> +}
> +
>  #ifdef TARGET_NR_getdents
>  static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
>  {
> @@ -13511,11 +13532,41 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>  #endif
>  
>      case TARGET_NR_tkill:
> -        return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
> +    {
> +        pid_t tid = (pid_t)arg1;
> +        if ((abi_long)tid != arg1) {
> +            return -TARGET_ESRCH;
> +        }
> +        /*
> +         * Reject signals that target one of our own QEMU-internal
> +         * helper threads (RCU, TCG worker, ...) which share our
> +         * host PID but have no guest CPUState.  Cross-process tids
> +         * are passed through unchanged.
> +         */
> +        if (tid_is_qemu_internal(tid)) {
> +            return -TARGET_ESRCH;
> +        }
> +        return get_errno(safe_tkill(tid, target_to_host_signal(arg2)));
> +    }
>  
>      case TARGET_NR_tgkill:
> -        return get_errno(safe_tgkill((int)arg1, (int)arg2,
> +    {
> +        pid_t tgid = (pid_t)arg1;
> +        pid_t tid = (pid_t)arg2;
> +        if ((abi_long)tgid != arg1 || (abi_long)tid != arg2) {
> +            return -TARGET_ESRCH;
> +        }
> +        /*
> +         * Only screen targets in our own process; for cross-process
> +         * tgkill we have no way to know which TIDs are guest threads
> +         * in another QEMU instance, so the call is passed through.
> +         */
> +        if (tgid == getpid() && tid_is_qemu_internal(tid)) {
> +            return -TARGET_ESRCH;
> +        }

I was wondering why getpid() is used and not getgid(), but the comment
just above made it clear.

> +        return get_errno(safe_tgkill(tgid, tid,
>                           target_to_host_signal(arg3)));
> +    }
>  
>  #ifdef TARGET_NR_set_robust_list
>      case TARGET_NR_set_robust_list:
> 

Overall looks good to me.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


