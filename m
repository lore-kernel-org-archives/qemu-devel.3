Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843CCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZfY-00071f-V7; Fri, 22 May 2026 19:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZfP-00070z-1z
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:52:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZfM-00069e-4Z
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:52:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGbf7W1734554
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DjSE9lLW0bdJpzbxgzxwNgsuZ2yoJMzQesjSOW7J/sQ=; b=ZJYSOi8fo1dtgunV
 7zDXoUlBm9g5s7fwSeIH8H1QrBZwG0AH9kLjR3H65MeL6Nsnogms5Wn8IGHyZSE2
 ADtOR/+KgGO55uf+c16DXGUnxFfY8izeX3sZxsI+LN4HNmu9pKnyBPIk330eEyQf
 tm5fKldhfjQh+y6YfaKzlkNkTAA6ybsQrEAlSokyjI3UNgj/GmFnSnRpLViS0g3B
 W6lLS7l56+4Va/uH9aJnkdZ2Mx4L3B0tvwD4hJOMKDshjnv8BvIMSu5d5nurHMfK
 qPyc/Qp7jIIp65NbRSVGUbBaP2Qx2Y8OkxqXdNNUwRsRG3IJuDx13MnZvYCww5cw
 xAbpGw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq99b6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:52:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso28937725eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493949; x=1780098749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjSE9lLW0bdJpzbxgzxwNgsuZ2yoJMzQesjSOW7J/sQ=;
 b=VyTe2iU4lJtVpAXd1otAksVLiW+XI+oiQAlsRxAWbT+GHG6U8nvLih45l5PfkC/ZiG
 KDOpvQ6J7bqwb2QDDJne16YymOnmHd0Gdv9M4TRFnMfkfNqIIpDwWqdcRFk9a7V/uLMo
 PD9+2aRecq1ZuFte/ffoeI6JYMjRBi+y+RqY075dHMC6o8hI/Goy6VPGJ+G7adY00jWw
 5vYI5XT/kW52PKRdt7tqVx9jM76zsizjXPvJ7geVQDsfw7KMzWbF6ELsmnDUrLKHSclF
 kFl9OLr2DfQCz1JV1VmlGIXFDlgUlPRtGTHBi89jYTBifs3d/cIn5imAL5PJUvT70RAG
 c8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493949; x=1780098749;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjSE9lLW0bdJpzbxgzxwNgsuZ2yoJMzQesjSOW7J/sQ=;
 b=MFEdH165huMNWwZDeXbCEIFlRLlHfIqyyW87+JUkrIsrcojKLfS1BPq/Ts/bkFL8eh
 AEbBM4F8xe9ojREAiVtbdZnqQpAhfwOUeEnrCyAuHJMUFkHBThYkKsV7aS29tflR6mgG
 XGIMLRuauQM0NHJhQzVtnZ5KHJD8YRj1EcubGP/nOzCvNEepuqtCLwQyjwyDwudCLMya
 DenIUxLhh/DyHF9SPZqwFvoJR38tEIyIViWW70ean4yYbY126/g9vPzf+kb6AAWBq7TU
 DMc8R+JTOOE51msRybgg+5vVorayX0vy0Wrm26O90uylKRzmV2Nw+OqsLJBOQk4Q/wKt
 QRJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fkC2laLMN+oX7Z697EBeFwCEAYDCgNrZzcKqpzicpHzvlx1h1Zso4n8PqNmDztZK/HT4SBgzvffRW@nongnu.org
X-Gm-Message-State: AOJu0Ywewo4wzt1bpRLSJHxxOv/0dOmlaGNA7ZFrB5HwliEVhuZNRHpE
 AAIbn7RMBsytsmo8lmGlWPcC1jo9Od3409MufFsIPKj4pSxlaxV1JM08fjh8rNSqqk3dBxVQmmL
 p+QsiSyEhZgVvRg8ARSnWxWHZVMxzcwSYj/I65QSB+m9KNVHOjRZ1Gj6QZg==
X-Gm-Gg: Acq92OEs3Zd12LYLToIbcSJZMm8lE+aAp8hwOdkUlyDs0AKlzifHejKyXl0FR+b+Jf6
 QJvSpCiTnWAptJIESvFMu5bx8eRrfMjZaqZeDgZZ1ngvbJdnQ5E7GwCjgP3KrVCQJErm9yqcysz
 WIWF87TUAXV3TTlPb0/5WsoaLxnhC1RShKPEnZxOfDWCK+IDKVHpqVxvsBRYqMzdrhBx+GGPTWq
 +gs8nK2pnackTbIxRK28MZ0JyqDZbSMOoQcGMz6AyYvoL+nhzZbrvmG8bf79WMXN8r6ED+tKmFB
 IhaEbSHPXyw//QymMt2EbLHMAqaY89pjINo01VtXD0FTyFR2NbDQmNV4GDm8TilKpiMPnOchSAt
 LTf99c0PXu5D6rMI1/WVb/ewto+b9/z6TVsxSVmy1vZyBZYj8CAAqG1q2KBqtLCO7VaT2MiqQRn
 tpzJezhyHF9HHK5ZFq6OwY7zPF
X-Received: by 2002:a05:693c:68cc:b0:304:641b:12fd with SMTP id
 5a478bee46e88-304641b14d2mr142426eec.27.1779493949429; 
 Fri, 22 May 2026 16:52:29 -0700 (PDT)
X-Received: by 2002:a05:693c:68cc:b0:304:641b:12fd with SMTP id
 5a478bee46e88-304641b14d2mr142414eec.27.1779493948794; 
 Fri, 22 May 2026 16:52:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4af0sm2134428eec.3.2026.05.22.16.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:52:28 -0700 (PDT)
Message-ID: <177adfe7-714f-4570-982f-85e70a28a5be@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:52:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/37] bsd-user: Add os-time.c and time-related type
 definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-22-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-22-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfX+J/0XlLE0IEm
 t7lQ6JnsJbv0CHkrLXFEnMq/eflW0eIyw8kSQRa3+KwmwEEJmb/ucYfOw5EgRp/MjgwcdpdVb6U
 T84+ckmTWGCtnntYVDAjR46/c/j7CEEp15t6o5GE7JNE/s62Ypp1wOrLGQxpsw2P475ko+4elt/
 3dEaHr80gPQkGwv747Y0nCwhwGKV8MBERbbBEE0Z3P83I4GOTzboBdHTyMmynUvZxlNhkK0zrcd
 J9uLk/FJxPzlax9lXZBawQ9hpbwhlPO4Jc+QA9+qH4X1X+W7DiBp2ilJhX9n7euIVie7y8EiXPN
 6fwm5TC41SoAmrcNfGUkl5+xO0peqixRkPJyHBEIw4xYWalkuU7oXxuSWetJOYIEd/hJlXJhkjC
 ZotBBNbK+L7r/Nk/6MaLoJvSIabK8MDVUaTaCzRrF74xWJMLH0EFoD5wDkJhJCPEoWbt+Xl8FNO
 iRrMVEsG6YYG0xnp5Cw==
X-Proofpoint-GUID: FwyL44ne1N9SviooQ77QnWgLn9pTCy1_
X-Proofpoint-ORIG-GUID: FwyL44ne1N9SviooQ77QnWgLn9pTCy1_
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10ec3e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=3IGaLVvHnWHdxMMJGZIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220239
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add os-time.c with time conversion helpers (t2h/h2t functions for
> timespec, timeval, timex, ntptimeval, itimerspec) and POSIX timer
> helper functions. Also add target_freebsd_timex, target_freebsd_ntptimeval,
> target_freebsd_itimerspec, kevent structures, and timer definitions
> to syscall_defs.h.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-syscall.c |   2 +
>  bsd-user/freebsd/os-time.c    | 346 ++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-time.h    |   3 +
>  3 files changed, 351 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index 6fbd2da261..020d16fda3 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -98,6 +98,8 @@ safe_syscall6(int, kevent, int, kq, const struct kevent *, changelist,
>      int, nchanges, struct kevent *, eventlist, int, nevents,
>      const struct timespec *, timeout);
>  
> +int g_posix_timers[32] = { 0, } ;
> +
>  /* used in os-proc */
>  safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
>      struct rusage *, rusage);
> diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
> new file mode 100644
> index 0000000000..f1c1cc2c1a
> --- /dev/null
> +++ b/bsd-user/freebsd/os-time.c
> @@ -0,0 +1,346 @@
> +/*
> + * FreeBSD time related system call helpers
> + *
> + * Copyright (c) 2013-2015 Stacey D. Son
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +
> +#include <errno.h>
> +#include <time.h>
> +#include <sys/timex.h>
> +#include <sys/types.h>
> +#include <sys/select.h>
> +#include <sys/umtx.h>
> +
> +#include "qemu.h"
> +#include "qemu-os.h"
> +
> +/*
> + * FreeBSD time conversion functions
> + */
> +abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
> +{
> +    struct target_freebsd_timeval *target_tv;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(tv->tv_sec, &target_tv->tv_sec);
> +    __get_user(tv->tv_usec, &target_tv->tv_usec);
> +    unlock_user_struct(target_tv, target_tv_addr, 0);
> +
> +    return 0;
> +}
> +
> +abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
> +{
> +    struct target_freebsd_timeval *target_tv;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(tv->tv_sec, &target_tv->tv_sec);
> +    __put_user(tv->tv_usec, &target_tv->tv_usec);
> +    unlock_user_struct(target_tv, target_tv_addr, 1);
> +
> +    return 0;
> +}
> +
> +abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr)
> +{
> +    struct target_freebsd_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ts, target_ts_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(ts->tv_sec, &target_ts->tv_sec);
> +    __get_user(ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_ts_addr, 0);
> +
> +    return 0;
> +}
> +
> +abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespec *ts)
> +{
> +    struct target_freebsd_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_ts_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(ts->tv_sec, &target_ts->tv_sec);
> +    __put_user(ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_ts_addr, 1);
> +
> +    return 0;
> +}
> +
> +abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
> +        abi_ulong target_ut_size, void *host_t, size_t *host_tsz)
> +{
> +    abi_long ret;
> +
> +    if (target_ut_size <= sizeof(struct target_freebsd_timespec)) {
> +        ret = t2h_freebsd_timespec((struct timespec *)host_t, target_ut_addr);
> +        if (ret == 0) {
> +            *host_tsz = sizeof(struct timespec);
> +        }
> +        return ret;
> +    } else {
> +        struct target_freebsd__umtx_time *target_ut;
> +        struct _umtx_time *ut = (struct _umtx_time *)host_t;
> +
> +        if (!lock_user_struct(VERIFY_READ, target_ut, target_ut_addr, 1)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (t2h_freebsd_timespec(&ut->_timeout, h2g(&target_ut->_timeout))) {
> +            return -TARGET_EFAULT;
> +        }
> +        __get_user(ut->_flags, &target_ut->_flags);
> +        __get_user(ut->_clockid, &target_ut->_clockid);
> +        unlock_user_struct(target_ut, target_ut_addr, 0);
> +
> +        if (target_ut_size > sizeof(struct target_freebsd__umtx_time)) {
> +            *host_tsz = sizeof(struct _umtx_time) + sizeof(struct timespec);
> +        } else {
> +            *host_tsz = sizeof(struct _umtx_time);
> +        }
> +
> +        return 0;
> +    }
> +}
> +
> +abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr)
> +{
> +    struct target_freebsd_timex *target_tx;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_tx, target_tx_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_tx->modes, &target_tx->modes);
> +    __get_user(host_tx->offset, &target_tx->offset);
> +    __get_user(host_tx->freq, &target_tx->freq);
> +    __get_user(host_tx->maxerror, &target_tx->maxerror);
> +    __get_user(host_tx->esterror, &target_tx->esterror);
> +    __get_user(host_tx->status, &target_tx->status);
> +    __get_user(host_tx->constant, &target_tx->constant);
> +    __get_user(host_tx->precision, &target_tx->precision);
> +    __get_user(host_tx->tolerance, &target_tx->tolerance);
> +    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
> +    __get_user(host_tx->jitter, &target_tx->jitter);
> +    __get_user(host_tx->shift, &target_tx->shift);
> +    __get_user(host_tx->stabil, &target_tx->stabil);
> +    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
> +    __get_user(host_tx->calcnt, &target_tx->calcnt);
> +    __get_user(host_tx->errcnt, &target_tx->errcnt);
> +    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
> +    unlock_user_struct(target_tx, target_tx_addr, 0);
> +
> +    return 0;
> +}
> +
> +abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex *host_tx)
> +{
> +    struct target_freebsd_timex *target_tx;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_tx_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_tx->modes, &target_tx->modes);
> +    __put_user(host_tx->offset, &target_tx->offset);
> +    __put_user(host_tx->freq, &target_tx->freq);
> +    __put_user(host_tx->maxerror, &target_tx->maxerror);
> +    __put_user(host_tx->esterror, &target_tx->esterror);
> +    __put_user(host_tx->status, &target_tx->status);
> +    __put_user(host_tx->constant, &target_tx->constant);
> +    __put_user(host_tx->precision, &target_tx->precision);
> +    __put_user(host_tx->tolerance, &target_tx->tolerance);
> +    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
> +    __put_user(host_tx->jitter, &target_tx->jitter);
> +    __put_user(host_tx->shift, &target_tx->shift);
> +    __put_user(host_tx->stabil, &target_tx->stabil);
> +    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
> +    __put_user(host_tx->calcnt, &target_tx->calcnt);
> +    __put_user(host_tx->errcnt, &target_tx->errcnt);
> +    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
> +    unlock_user_struct(target_tx, target_tx_addr, 1);
> +
> +    return 0;
> +}
> +
> +abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
> +        struct ntptimeval *ntv)
> +{
> +    struct target_freebsd_ntptimeval *target_ntv;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ntv, target_ntv_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(ntv->time.tv_sec, &target_ntv->time.tv_sec);
> +    __put_user(ntv->time.tv_nsec, &target_ntv->time.tv_nsec);
> +    __put_user(ntv->maxerror, &target_ntv->maxerror);
> +    __put_user(ntv->esterror, &target_ntv->esterror);
> +    __put_user(ntv->tai, &target_ntv->tai);
> +    __put_user(ntv->time_state, &target_ntv->time_state);
> +    unlock_user_struct(target_ntv, target_ntv_addr, 1);
> +
> +    return 0;
> +}
> +
> +/*
> + * select(2) fdset copy functions
> + */
> +abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr, int n)
> +{
> +    int i, nw, j, k;
> +    abi_ulong b, *target_fds;
> +
> +    nw = (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
> +    target_fds = lock_user(VERIFY_READ, target_fds_addr,
> +            sizeof(abi_ulong) * nw, 1);
> +    if (target_fds == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    FD_ZERO(fds);
> +    k = 0;
> +    for (i = 0; i < nw; i++) {
> +        /* grab the abi_ulong */
> +        __get_user(b, &target_fds[i]);
> +        for (j = 0; j < TARGET_ABI_BITS; j++) {
> +            /* check the bit inside the abi_ulong */
> +            if ((b >> j) & 1) {
> +                FD_SET(k, fds);
> +            }
> +            k++;
> +        }
> +    }
> +    unlock_user(target_fds, target_fds_addr, 0);
> +
> +    return 0;
> +}
> +
> +abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
> +        abi_ulong target_fds_addr, int n)
> +{
> +
> +    if (target_fds_addr) {
> +        if (copy_from_user_fdset(fds, target_fds_addr, n)) {
> +            return -TARGET_EFAULT;
> +        }
> +        *fds_ptr = fds;
> +    } else {
> +        *fds_ptr = NULL;
> +    }
> +
> +    return 0;
> +}
> +
> +abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *fds, int n)
> +{
> +    int i, nw, j, k;
> +    abi_long v;
> +    abi_ulong *target_fds;
> +
> +    nw = (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
> +    target_fds = lock_user(VERIFY_WRITE, target_fds_addr,
> +            sizeof(abi_ulong) * nw, 0);
> +    if (target_fds == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    k = 0;
> +    for (i = 0; i < nw; i++) {
> +        v = 0;
> +        for (j = 0; j < TARGET_ABI_BITS; j++) {
> +            v |= ((FD_ISSET(k, fds) != 0) << j);
> +            k++;
> +        }
> +        __put_user(v, &target_fds[i]);
> +    }
> +    unlock_user(target_fds, target_fds_addr, sizeof(abi_ulong) * nw);
> +
> +    return 0;
> +}

It seems the two functions above do not belong to current patch, but
should be present in N-2 patch at least (ideally, in a third one, before
os-time part of the series)

> +
> +abi_int next_free_host_timer(void)
> +{
> +    int k ;
> +    /* FIXME: Does finding the next free slot require a lock? */
> +    for (k = 0; k < ARRAY_SIZE(g_posix_timers); k++) {
> +        if (g_posix_timers[k] == 0) {
> +            g_posix_timers[k] = 1;
> +            return k;
> +        }
> +    }
> +    return -1;
> +}
> +
> +int host_to_target_timerid(int timerid)
> +{
> +    int k;
> +
> +    for (k = 0; k < ARRAY_SIZE(g_posix_timers); k++) {
> +        if (g_posix_timers[k] == timerid) {
> +            return TIMER_MAGIC | k;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
> +                                                 abi_ulong target_addr)
> +{
> +    struct target_freebsd_itimerspec *target_itspec;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    host_itspec->it_interval.tv_sec =
> +                            tswapal(target_itspec->it_interval.tv_sec);
> +    host_itspec->it_interval.tv_nsec =
> +                            tswapal(target_itspec->it_interval.tv_nsec);
> +    host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
> +    host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
> +
> +    unlock_user_struct(target_itspec, target_addr, 0);
> +    return 0;
> +}
> +
> +abi_long host_to_target_itimerspec(abi_ulong target_addr,
> +                                               struct itimerspec *host_its)
> +{
> +    struct target_freebsd_itimerspec *target_itspec;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    target_itspec->it_interval.tv_sec = tswapal(host_its->it_interval.tv_sec);
> +    target_itspec->it_interval.tv_nsec = tswapal(host_its->it_interval.tv_nsec);
> +
> +    target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
> +    target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
> +
> +    unlock_user_struct(target_itspec, target_addr, 1);
> +    return 0;
> +}
> +
> +/* Convert QEMU provided timer ID back to internal 16bit index format */
> +int get_timer_id(abi_long arg)
> +{
> +    int timerid = arg;
> +
> +    if ((timerid & TIMER_MAGIC_MASK) != TIMER_MAGIC) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    timerid &= 0xffff;
> +
> +    if (timerid >= ARRAY_SIZE(g_posix_timers)) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    return timerid;
> +}
> diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> index f24b6f35db..e91a3f9bcf 100644
> --- a/bsd-user/freebsd/os-time.h
> +++ b/bsd-user/freebsd/os-time.h
> @@ -198,6 +198,9 @@ static inline abi_long do_freebsd_ntp_adjtime(abi_ulong target_tx_addr)
>      if (ret == 0) {
>          ret = get_errno(ntp_adjtime(&host_tx));
>      }
> +    if (!is_error(ret)) {
> +        h2t_freebsd_timex(target_tx_addr, &host_tx);
> +    }
>  
>      return ret;
>  }
> 


