Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0599CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZRi-0004GM-Hv; Fri, 22 May 2026 19:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZRg-0004GE-0c
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:38:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZRd-0001pZ-Cr
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:38:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHfbVZ3601155
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 He4jJFaHUShYA6a/q23jjEEIsPcpJUUyd5aAAH2IdlA=; b=HUD+lnFisp0M7hkn
 O70R4tc8J9gcVm4yjkQyXJABNTRF1HJg0CA309USt35X6WswovXuEwhEMVEE9ziD
 WTbmtL70vTsVXx8GRodUMbc43mqt26ojdryzOLeGnRArHXBfIfqCjngWEo8wjLqn
 ZFKNmhApi1GwjysFANpRc2gW0/+aKyjp5UCE0JqvYQqrZ3CKxoJfxQCbA8xwyAZa
 dhzLQQAvU6t3S4eR0VDmm0GKWoks5PeIBTXKBmDaM70h0t+B7b4t4JQRDmY4qvww
 3VGfiBmPOXyXOdA6jik7N57/ykOWahjbNRTBaPaEZJeT9dow58rHR8FLomqwvM1t
 tDnBMA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury0yq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:38:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2efc342ef15so9692600eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493098; x=1780097898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=He4jJFaHUShYA6a/q23jjEEIsPcpJUUyd5aAAH2IdlA=;
 b=DYwHKB2QfrpV32wYz1BTR77zs7Xh7BNZ0Xsn2l9iPDlYU0gKj0GeStvrOS6bbvj0V0
 cVfDn/WZZI1LR/8F5L43VPL7GkqcMmNz1xmIu4k3uMSNbSlJcRjKtKpe7Atr/GZezeWF
 goMOmCCWzJzw9mY098fUh1D/B9ZDoId+wAL5j+Gq2JltHptA8YaTBCK8Dbp3i7PkCCA7
 xdBbmiBzijWdBdRLbnrffN0ONw2CrlHxgisJxZsvIXP5SXWjP7juZhhXq1ttU3u0SXoX
 Y6bOY2nXgTFWaSvX2nyaa+EmCDIP8qWaHg5ItBSbUOg5x6CKRHk9V16GBnIeGbHPrSst
 Bz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493098; x=1780097898;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=He4jJFaHUShYA6a/q23jjEEIsPcpJUUyd5aAAH2IdlA=;
 b=hAgD3hPmHCVB85YW3WgACJqq+oVGPTWoS5cbv6XrYMdNFbXGJRuIFfyyyVicSSNau0
 oJnmUKwa0ddYu0egAbYTowJqSPkcxcUo9kMLTZLGgqQZGZeVbJyI+nI8YlvK4VNzjL7M
 E6grgBMwQASwjCqJMOAOukp4BBTD7Tiiz0YhsO57TtFRUf3/QKvEMsFtbB7B08kpMbcK
 a72w5Opi/S11sJCTkasaQ3clo0OafdtjhoH6D5VaLSzNgMNc1hR9ZMktcoPLa2npcBcq
 RBJg+tK1DqkRU0/CvoGyjD8+N/+cnnvLSbradP6LHtQHBu7qGv/X7bjYYXNQHg4HyLNc
 TmyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uB8p1+TNedpi59FnoOfWg+Ju8Fz4nitUz9gB+1D5QFTgHy1Af7Tyrq9mMD8CU7l/JJCm7/gE5Evuh@nongnu.org
X-Gm-Message-State: AOJu0YxdyhSJDVu62d3RSFUIEwdKmQsPuXNYZxJf0yCGFOuSmgAPZewH
 mM6EgHVaDhlrZYFSKk7QAgAbEwBO9+D2U97YXOgAaa4gjFNQFG4uAfS8JnqZ50yiOmDtNo4aAev
 1NDypWOXI/oJ8ApFxEvEEqCLK2iNJbhyAo/HLYWSPBoF8zN1zCUXBVP0hNg==
X-Gm-Gg: Acq92OH+xev9A+rK6kH3i2So8rjrZV4KqNqHbu49i6Mr2vF0Du4ugPNxTVuw2qBir6q
 iY7cUPeW7epWXJCG9i7LXN8wf+sMGqJulcmyYo4T2FJOBSQs9MZC8nwM70TiR+VG/KIaiqi8EU/
 F96hh7rNHLeeGDzzTWUL3ZrF7I93VuHJwOZYOXHu1uPqD4JSPJZS8/z/sClKPSzh0BLhM+g/+cJ
 33jVTgSeAGPRsrLPJljKI1DQo7EQwZbxGIToWY9khsHzxbERu9YuMaEPdMndCMu8Jb6WAL9SutU
 grMKJqMSlYKJ+jXk6PaD0uQqgU4g8tEDMc9et5qsuyx5pE2Jjsbucq2dTTOc2oY0ciM47/bav2b
 ZnJMYhKdImKKUxKViG7DZDqpiF0GmS+U4fXkJ6NEjfNhZSdgGGRiLIUWXSEK7jbWoaCeE70ko83
 YK4q300pQpoLvCCw==
X-Received: by 2002:a05:7300:ad02:b0:2d8:71c2:255d with SMTP id
 5a478bee46e88-30448fbdddcmr3261886eec.14.1779493098142; 
 Fri, 22 May 2026 16:38:18 -0700 (PDT)
X-Received: by 2002:a05:7300:ad02:b0:2d8:71c2:255d with SMTP id
 5a478bee46e88-30448fbdddcmr3261873eec.14.1779493097561; 
 Fri, 22 May 2026 16:38:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304524610f7sm2081660eec.29.2026.05.22.16.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:38:17 -0700 (PDT)
Message-ID: <efaa34ff-ffc2-4c70-b435-bd5d3d041b5c@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:38:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/37] bsd-user: Add utimes, futimes, and ktimer
 functions to os-time.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-18-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-18-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNiBTYWx0ZWRfX21U66ocrwDrU
 gxauuBRieoHu0V2chMQcATASD4n2TXFlOeM/st6s98STbc+jBwcgI8q5V+GMDR2F00ZLUcGML4b
 0dPTBQyOWng19V/kOQpDzmstsSkVPXMu9XDiLNLRLG1rFhMk1ZpSL3iLRzgMDa5kaBtAS7gGdv9
 FFCBt7G/80m/E//hymoFZKCVDblmJpRhUxQYBa7SbALceYvFasxt5Li7+fCp8WBbR0VT5RAGLsV
 kKlSJji4IbeI8Wrd5h2i0ToSowL/9PYf3QOy6Rkd3owWvT28BEFbSsKh3wR6VIMU673sDxPB5TM
 2ibs52PnCiw0Cg1USuhd0cL8S1WmY4900gajV/5hWRFvFRuTZ/z8lGZKIM3A/uU0rLXynoWNYCI
 b5miZX0zReF/azrG6LO1DdlEDyHCLAlwDxmdFwEZyQGOlkBnOLOT0GGr6o76LmV1PDPXwgyJJGh
 ElN/fxGBAO+Ui99qz/A==
X-Proofpoint-ORIG-GUID: ki-AzGnDXfRnOdMKEEhoBSew99BVvIaP
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a10e8eb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=7LLsGnCZspnmUa1a5d4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: ki-AzGnDXfRnOdMKEEhoBSew99BVvIaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220236
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
> Add time-related system call shims: utimes, lutimes, futimes,
> futimesat, ktimer_create, ktimer_delete, ktimer_settime, and
> ktimer_gettime.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-time.h | 210 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 210 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> index 16b71e6234..05fa043442 100644
> --- a/bsd-user/freebsd/os-time.h
> +++ b/bsd-user/freebsd/os-time.h
> @@ -217,5 +217,215 @@ static inline abi_long do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
>  }
>  
>  
> +/* utimes(2) */
> +static inline abi_long do_freebsd_utimes(abi_long arg1, abi_long arg2)
> +{
> +    abi_long ret;
> +    void *p;
> +    struct timeval *tvp, tv[2];
> +
> +    if (arg2 != 0) {
> +        if (t2h_freebsd_timeval(&tv[0], arg2) ||
> +                t2h_freebsd_timeval(&tv[1], arg2 +
> +                        sizeof(struct target_freebsd_timeval))) {
> +            return -TARGET_EFAULT;
> +        }
> +        tvp = tv;
> +    } else {
> +        tvp = NULL;
> +    }
> +    p = lock_user_string(arg1);
> +    if (p == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret = get_errno(utimes(p, tvp));
> +    unlock_user(p, arg1, 0);
> +
> +    return ret;
> +}
> +
> +/* lutimes(2) */
> +static inline abi_long do_freebsd_lutimes(abi_long arg1, abi_long arg2)
> +{
> +    abi_long ret;
> +    void *p;
> +    struct timeval *tvp, tv[2];
> +
> +    if (arg2 != 0) {
> +        if (t2h_freebsd_timeval(&tv[0], arg2) ||
> +                t2h_freebsd_timeval(&tv[1], arg2 +
> +                        sizeof(struct target_freebsd_timeval))) {
> +            return -TARGET_EFAULT;
> +        }
> +        tvp = tv;
> +    } else {
> +        tvp = NULL;
> +    }
> +    p = lock_user_string(arg1);
> +    if (p == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret = get_errno(lutimes(p, tvp));
> +    unlock_user(p, arg1, 0);
> +
> +    return ret;
> +}
> +
> +/* futimes(2) */
> +static inline abi_long do_freebsd_futimes(abi_long arg1, abi_long arg2)
> +{
> +    struct timeval *tvp, tv[2];
> +
> +    if (arg2 != 0) {
> +        if (t2h_freebsd_timeval(&tv[0], arg2) ||
> +                t2h_freebsd_timeval(&tv[1], arg2 +
> +                        sizeof(struct target_freebsd_timeval))) {
> +            return -TARGET_EFAULT;
> +        }
> +        tvp = tv;
> +    } else {
> +        tvp = NULL;
> +    }
> +
> +    return get_errno(futimes(arg1, tvp));
> +}
> +
> +/* futimesat(2) */
> +static inline abi_long do_freebsd_futimesat(abi_long arg1, abi_long arg2,
> +        abi_long arg3)
> +{
> +    abi_long ret;
> +    void *p;
> +    struct timeval *tvp, tv[2];
> +
> +    if (arg3 != 0) {
> +        if (t2h_freebsd_timeval(&tv[0], arg3) ||
> +                t2h_freebsd_timeval(&tv[1], arg3 +
> +                        sizeof(struct target_freebsd_timeval))) {
> +            return -TARGET_EFAULT;
> +        }
> +        tvp = tv;
> +    } else {
> +        tvp = NULL;
> +    }
> +
> +    p = lock_user_string(arg2);
> +    if (p == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret = get_errno(futimesat(arg1, p, tvp));
> +    unlock_user(p, arg2, 0);
> +
> +    return ret;
> +}
> +

The functions above are quite duplicated.
We could factor the first part at least, setting tvp.
The lock_user_string part can be replaced with LOCK_PATH.

> +/* timer_create(2) */
> +static inline abi_long do_freebsd_ktimer_create(abi_long arg1, abi_long arg2,
> +        abi_long arg3)
> +{
> +    /* args: clockid_t clockid, struct sigevent *sevp, int *timerid */
> +    abi_long ret;
> +
> +    struct sigevent host_sevp = { 0 }, *phost_sevp = NULL;
> +
> +    int clkid = arg1;
> +    int timer_index = next_free_host_timer();
> +
> +    if (timer_index < 0) {
> +        ret = -TARGET_EAGAIN;
> +    } else {
> +        int *phtimer = g_posix_timers  + timer_index;
> +
> +        if (arg2) {
> +            phost_sevp = &host_sevp;
> +            ret = target_to_host_sigevent(phost_sevp, arg2);
> +            if (ret != 0) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +
> +        ret = get_errno(__sys_ktimer_create(clkid, phost_sevp, phtimer));
> +        if (ret) {
> +            phtimer = NULL;
> +        } else {
> +            if (put_user(TIMER_MAGIC | timer_index, arg3, int)) {
> +                ret = -TARGET_EFAULT;
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* timer_delete(2) */
> +static inline abi_long do_freebsd_ktimer_delete(abi_long arg1)
> +{
> +    /* args: int timerid */
> +    abi_long ret;
> +    int timerid = get_timer_id(arg1);
> +
> +    if (timerid < 0) {
> +        ret = timerid;
> +    } else {
> +        int htimer = g_posix_timers[timerid];
> +        ret = get_errno(__sys_ktimer_delete(htimer));
> +        g_posix_timers[timerid] = 0;
> +    }
> +    return ret;
> +}
> +
> +/* timer_settime(2) */
> +static inline abi_long do_freebsd_ktimer_settime(abi_long arg1, abi_long arg2,
> +        abi_long arg3, abi_long arg4)
> +{
> +    /*
> +     * args: int timerid, int flags, const struct itimerspec *new_value,
> +     * struct itimerspec * old_value
> +     */
> +    abi_long ret;
> +    int timerid = get_timer_id(arg1);
> +
> +    if (timerid < 0) {
> +        ret = timerid;
> +    } else if (arg3 == 0) {
> +        ret = -TARGET_EINVAL;
> +    } else {
> +        int htimer = g_posix_timers[timerid];
> +        struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
> +
> +        if (target_to_host_itimerspec(&hspec_new, arg3)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(
> +            __sys_ktimer_settime(htimer, arg2, &hspec_new, &hspec_old));
> +        if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* timer_gettime(2) */
> +static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
> +{
> +    /* args: int timerid, struct itimerspec *curr_value */
> +    abi_long ret;
> +    int timerid = get_timer_id(arg1);
> +
> +    if (timerid < 0) {
> +        ret = timerid;
> +    } else if (!arg2) {
> +        ret = -TARGET_EFAULT;
> +    } else {
> +        int htimer = g_posix_timers[timerid];
> +        struct itimerspec hspec;
> +        ret = get_errno(__sys_ktimer_gettime(htimer, &hspec));
> +
> +        if (host_to_target_itimerspec(arg2, &hspec)) {
> +            ret = -TARGET_EFAULT;
> +        }
> +    }
> +    return ret;
> +}
> +
>  
>  #endif /* FREEBSD_OS_TIME_H */
> 


