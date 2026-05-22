Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6791DCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZbi-0005GV-KM; Fri, 22 May 2026 19:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZbW-0005Ci-D2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:48:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZat-0003Ir-6J
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:48:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MG0fDw3477008
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fr0Ghq9/rZTFcVv943im/tUrVPJHB6iZj9VXn+3OeQY=; b=LdjNkE0LKFGxlDMB
 aej5sndjQy6sZmbAJjRyUUfGx4IG2EXm8gRaNw3/9VzSGeW8VIJtQn3sDpCWtA5D
 ndNDFEPYGTKAn14lx6+MJYFkKGdNd+c80lvhS5TYTMX8In0D4KhYikV/YE32TDp1
 CJPvqRkkoFwDzqbyTUBA0TE63FGPasPbOfQLKwkshvGhDkvyDQoMLsmOKYZ8cFUH
 RIFzenzIf+Sfi5PA4qXETth886AqWMgokH5pALNuS0NFk7Ura0U1bQ92NRYyFa/i
 or/YJs9YtzgNCBquNO8ui0SKnOX6TCeH+pVMNoSnemK39W0FgisgO5Wl8eZ9NcR6
 aPbYxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eat9r9cq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:46:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso9425811eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493583; x=1780098383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fr0Ghq9/rZTFcVv943im/tUrVPJHB6iZj9VXn+3OeQY=;
 b=gfQWndk69lVw0w3UDVH8xWVGfDNgC19NXXx68i8odD7HAlIebTjE6+HHTHvnwevng1
 qORPb7cRUG09bW4l56lv7vI47qMxBe92pP/pWcr0GRuo03LCEJT3fwElgZnYHQEWSpBS
 vndcZRDh9SBOmeWAeKTPu0YWnJPHZx2w6qhPv5LMtnS99Ntus4+sGyOyI6l+VD5sex9p
 rXRxwNIrOowI5QuJNxOW4TfEx/DIT2BWWhPUWiWGhLRvpGsM6LKR1R2k+FzA8598sQU6
 NUc/qO9XLw/l1S4KA/QodoCo5scn0hQ4caPRugARcogJ9CDfgRPlhcqh/9uordMZ+/xG
 aHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493583; x=1780098383;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fr0Ghq9/rZTFcVv943im/tUrVPJHB6iZj9VXn+3OeQY=;
 b=k3QYJgbt8IfSpSpDnxX4tE2iMb/XinlbaPDhKNgWpFSz6uxBbNT58qnBNzcEU/FD3y
 Iw2RgrUNEzppjdvfkPoiQ8zu0gYp/oS4NIUbveUhyRKQYXTtrkKERMicWUSAMWsNr4UH
 x5wrEKRu7MfHs0m+QzLrK8WpceJnKPuBUW0p8vPhbTciZ/gBGio5aBEaFFDjr6h+93QX
 8QjBqLa146qY241fBH5nXNS/eXaJf8B89Ds1uKE1hJF3nx5e7kfgXTyznKYAVbIvABeE
 OiibYGLzEjzKqzd1FI4il2ySK/BBpc/XF7BDoYsjx5aYUMH+QeKk6JclLC/dWi41D79k
 SoDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+p9va93lQcK/Wh7gVCULOZWWmx3IybemmvWCPQaV0clJoQJo8s7IsI/cG279FvuqDo8AMhBVOig47d@nongnu.org
X-Gm-Message-State: AOJu0YxtlK7qQaX7C3N0AWsiEJ5dMcEqMKAopYon2SKDsBwvrgNVzxhN
 Timj0y4CL7FXFQPpomstFuBLOtNro31wwz1KqlJBy8sVvs4XE933/t60pxDskjWKuacT6KsDc2x
 OjxlyOKD8wXp3S9HogZhJBWTeMoOtz4j8CbOYi1fm/15mEqNSHyetztSp+A==
X-Gm-Gg: Acq92OGBe+OHb4Net5pvkx9vU1ACdbHwRgcAf0JFEokvzsnAL9EM/DLUWIMBK8w6VTG
 HZMRxvInvaSUmD+9BKUG23bA1QsTjRoLrTDLEbusrvgWW6xq0WdSiX2GWsPjMCkNmR6txpjJkEb
 a/6VoWWs1wyvBjuHwIZbS97HR2jJojBV7vmtHS8p0Opat7Cnzwjd7vf2GHp1WpNuuSA6KzLm6j3
 5XVjd4GAJNkQPbjdasshhdyl1XdJFiw23pvoCRxU3+w9x/CJ+P02vDV6SRwWpNxbRSLm6ZtjkKL
 5XLWY4nCJvaOlz8Iq4FMyvoW8fy3wVR7OW2GBupBkpMJErobYAsuKRqCU0jKRn6U8qVhTopasRc
 1sKROJzOVLzzAhMQnPnR1splz9+dDNKqidBdTmuAqawdfrenTO+J9+N5vpskZE+pIfhoIYRBdSr
 ljQkcgy2lRiZeVNg==
X-Received: by 2002:a05:7300:2313:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-30449119476mr2973500eec.35.1779493583286; 
 Fri, 22 May 2026 16:46:23 -0700 (PDT)
X-Received: by 2002:a05:7300:2313:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-30449119476mr2973486eec.35.1779493582685; 
 Fri, 22 May 2026 16:46:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452259de0sm2092599eec.22.2026.05.22.16.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:46:22 -0700 (PDT)
Message-ID: <c75ecfed-2dbf-4517-b240-7ca8a623e4a6@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:46:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] bsd-user: Add select, pselect, and ppoll to
 os-time.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-19-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-19-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dt/rzVg4 c=1 sm=1 tr=0 ts=6a10ead0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=WHfyLJU6nzq0w6_6LzYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: 5ZQVZdgOQHSYcRn08SoxeJvStl8JG5aE
X-Proofpoint-GUID: 5ZQVZdgOQHSYcRn08SoxeJvStl8JG5aE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOCBTYWx0ZWRfX+k7U8Z/cOMdT
 uZe5kBoJiaoyvYxdYK+v4naTrElbYb4AmiaSv3OURFsaKvRmpQDxm48W43Cg2etWimqdCQsMn+i
 FvtVM1KFgc+3x4hag+PBTBIpZ31bsGMGW6e3O2x81lQLrVa3xChKg8n3UL7vGCz3V/DPglWrem1
 fq1pEtun6RiKkDZMVvI+Up2TNY3t1IKMdgIutLfoZIIub+5ZnNL2bjv/EVEyiGcsBB1gustKx3P
 Gi//iIBkOOxZRncWXplkoJtY/Ce9vBTCk/oWxp//eMHl0T+GO+CdCKFxGy/0FfdN60QmuD+E68m
 wR6EnwYwPQ6k9dZESO9JawX+tlvHlqyp+zea4L1SE4JMWpzzgoHal+IjICv42fLlbUKLCRhOQtA
 8fUfJf0K2jxTwZZEdpAmZtD3pR+X6FBsapHfaYjOQqYyomsoyKlREM4F2SwPzrAHR7aCJC5/JhC
 0QuxW/5Gbp9jvPMN0Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220238
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add I/O multiplexing system call shims: select, pselect, and ppoll
> with proper fd_set, timespec/timeval, and signal mask conversion.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-time.h | 202 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> index 05fa043442..12c5ba02e8 100644
> --- a/bsd-user/freebsd/os-time.h
> +++ b/bsd-user/freebsd/os-time.h
> @@ -427,5 +427,207 @@ static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
>      return ret;
>  }
>  
> +/* select(2) */
> +static inline abi_long do_freebsd_select(CPUArchState *env, int n,
> +        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
> +        abi_ulong target_tv_addr)
> +{
> +    fd_set rfds, wfds, efds;
> +    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
> +    struct timeval tv, *tvp;
> +    abi_long ret, error;
> +
> +    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +

We can factor this with a macro

> +    if (target_tv_addr != 0) {
> +        if (t2h_freebsd_timeval(&tv, target_tv_addr)) {
> +            return -TARGET_EFAULT;
> +        }
> +        tvp = &tv;
> +    } else {
> +        tvp = NULL;
> +    }
> +
> +    ret = get_errno(safe_select(n, rfds_ptr, wfds_ptr, efds_ptr, tvp));
> +
> +    if (!is_error(ret)) {

We can simplify depth here by using an early return.
if (is_error(ret)) {
  return ret;
}

> +        if (rfd_addr != 0) {
> +            error = copy_to_user_fdset(rfd_addr, &rfds, n);
> +            if (error != 0) {
> +                return error;
> +            }
> +        }
> +        if (wfd_addr != 0) {
> +            error = copy_to_user_fdset(wfd_addr, &wfds, n);
> +            if (error != 0) {
> +                return error;
> +            }
> +        }
> +        if (efd_addr != 0) {
> +            error = copy_to_user_fdset(efd_addr, &efds, n);
> +            if (error != 0) {
> +                return error;
> +            }
> +        }

Same, reuse the macro defined above.

> +        if (target_tv_addr != 0) {
> +            error = h2t_freebsd_timeval(&tv, target_tv_addr);
> +            if (is_error(error)) {
> +                return error;
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* pselect(2) */
> +static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,
> +        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
> +        abi_ulong ts_addr, abi_ulong set_addr)
> +{
> +    CPUState *cpu = env_cpu(env);
> +    TaskState *tstate = cpu->opaque;
> +    fd_set rfds, wfds, efds;
> +    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
> +    sigset_t *set_ptr;
> +    struct timespec ts, *ts_ptr;
> +    void *p;
> +    abi_long ret, error;
> +
> +    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +

Same than above.

> +    /* Unlike select(), pselect() uses struct timespec instead of timeval */
> +    if (ts_addr) {
> +        if (t2h_freebsd_timespec(&ts, ts_addr)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ts_ptr = &ts;
> +    } else {
> +        ts_ptr = NULL;
> +    }
> +
> +    if (set_addr != 0) {
> +        p = lock_user(VERIFY_READ, set_addr, sizeof(target_sigset_t), 1);
> +        if (p == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +        target_to_host_sigset(&tstate->sigsuspend_mask, p);
> +        unlock_user(p, set_addr, 0);
> +        set_ptr = &tstate->sigsuspend_mask;
> +    } else {
> +        set_ptr = NULL;
> +    }
> +
> +    ret = get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, efds_ptr, ts_ptr,
> +        set_ptr));
> +    if (ret != -TARGET_ERESTART)  {
> +        tstate->in_sigsuspend = true;
> +    }
> +    if (!is_error(ret)) {
> +        if (rfd_addr != 0) {
> +            error = copy_to_user_fdset(rfd_addr, &rfds, n);
> +            if (is_error(error)) {
> +                return error;
> +            }
> +        }
> +        if (wfd_addr != 0) {
> +            error = copy_to_user_fdset(wfd_addr, &wfds, n);
> +            if (is_error(error)) {
> +                return error;
> +            }
> +        }
> +        if (efd_addr != 0) {
> +            error = copy_to_user_fdset(efd_addr, &efds, n);
> +            if (is_error(error)) {
> +                return error;
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* ppoll(2) */
> +static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
> +        abi_long arg2, abi_ulong arg3, abi_ulong arg4)
> +{
> +    CPUState *cpu = env_cpu(env);
> +    TaskState *tstate = cpu->opaque;
> +    abi_long ret;
> +    nfds_t i, nfds = arg2;
> +    struct pollfd *pfd;
> +    struct target_pollfd *target_pfd;
> +    struct timespec ts, *ts_ptr;
> +    sigset_t *set_ptr;
> +    void *p;
> +
> +    target_pfd = lock_user(VERIFY_WRITE, arg1,
> +                           sizeof(struct target_pollfd) * nfds, 1);
> +    if (!target_pfd) {
> +        return -TARGET_EFAULT;
> +    }
> +    pfd = alloca(sizeof(struct pollfd) * nfds);
> +    for (i = 0; i < nfds; i++) {
> +        pfd[i].fd = tswap32(target_pfd[i].fd);
> +        pfd[i].events = tswap16(target_pfd[i].events);
> +    }
> +
> +    /* Unlike poll(), ppoll() uses struct timespec. */
> +    if (arg3) {
> +        if (t2h_freebsd_timespec(&ts, arg3)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ts_ptr = &ts;
> +    } else {
> +        ts_ptr = NULL;
> +    }
> +
> +    if (arg4 != 0) {
> +        p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
> +        if (p == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +        target_to_host_sigset(&tstate->sigsuspend_mask, p);
> +        unlock_user(p, arg4, 0);
> +        set_ptr = &tstate->sigsuspend_mask;
> +    } else {
> +        set_ptr = NULL;
> +    }
> +
> +    ret = get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));
> +    if (ret != -TARGET_ERESTART) {
> +        tstate->in_sigsuspend = true;
> +    }
> +    if (!is_error(ret)) {
> +        for (i = 0; i < nfds; i++) {
> +            target_pfd[i].revents = tswap16(pfd[i].revents);
> +        }
> +    }
> +    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
> +
> +    return ret;
> +}
> +
> +/* kqueue(2) */
>  
>  #endif /* FREEBSD_OS_TIME_H */
> 


