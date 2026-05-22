Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E142BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZd0-0005rH-6F; Fri, 22 May 2026 19:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZcy-0005qy-9J
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:50:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZcv-0004gy-RY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:50:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGFkve3005223
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mBGu/knl6SAU0302s9TzYWOUrjLVESxiEOj5j6m1QiI=; b=E2TfmSF0rzhLnY4w
 QgDldKhhRvswSq9bAdgivxMLIHq/l7wr38aHfo+eEHKT+PJwKMxvlDq3zta+28bo
 NikzPd1Zo49Z03rvrRaNsgx6U1P1sy50i4KrnUpoXU2fkVfNwTbeBDF+2l1jIL3+
 CaUzWT2HAHhMZdhV9bklXkgFavOgzMUP48aTkLiiIvIzDq6T8qUiDgAGj8JbCb0Q
 BFSsz8H+/GP0De+VXlrlFw+ERUMieXscHhLRCYnLgYgUqj26s24kGZtFqGKJKsWq
 XxRjulsjr5faqjTvdYGiUyQGqQJxXLRomCsCwsfeVgxl3NjvfG3nS3833CB0xKZz
 QBIT2A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrtc9vy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:49:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-303b38ec2f6so11557462eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493797; x=1780098597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mBGu/knl6SAU0302s9TzYWOUrjLVESxiEOj5j6m1QiI=;
 b=Fthji+UUjZhyptZb2v1HmJMNGd6GGtHHVFiaEzcrM8TiU7tsVQYDKaI7ZEVM9Als1f
 pdZwuGiEWfaYTzIEiOwMF4/dMIrQ2FsrUuQSRmGaBj8DvM7HiR3hQGK2o0xDTxkWR+Hg
 8maSXKnaUcRBjIt8oM/wJwys0NQlV3svSdrqimuZROD/B5JYLc0FFFiBlsEd/hxTNAqO
 t2+bp0puDNHaCHlgDTkQZZVUoRntXwfkggOpYAOz5i/1Xcwtc1z1SQ4NExXmxbcyn62Z
 y9fr1LTA/IOOF3veEbpl1rH9fNGXCZz6IaLRVhYl0l9AOPx5oIJsmsrYKZRbHKUtlVzM
 YA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493797; x=1780098597;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBGu/knl6SAU0302s9TzYWOUrjLVESxiEOj5j6m1QiI=;
 b=AzTQHaVvj3VrpQYywwJhMcRXlQriTdZe5vztxBUEmJ0GfBqsb4lC0JUGd6VLIUDg/d
 fbV3Zb/eDdLAOSTyb/57XN1WMsFPJw4ei5pYo6+wajQPfGV/SKJ9KvqVN8L6ndzqQvGo
 2w2E5Yh50+qTf5ycR3evyOd7If956un29fA0D68scMHG55YNHyv1kAAoIwOFbE0SjAWV
 VTcPr5q491GYKoo8XmK9Kqm/ugYsFpuoMFLLClHn/nNaRDA0PzMJlQdvwfiZT2Px6zlh
 XCyGlHTtPLmpVIky5f73zKeJ9WebtfaTQ49XgWhLhVXFrOOChPVzmBHyMyjrf2sTCxb7
 WePA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e6CBkpOcPqM3AumA+HNqosnFIc7MuPHBU4+t0ftY1XMW1Q3ceJ/yAGwntTRMYt6qvtnmXW2x0fWAF@nongnu.org
X-Gm-Message-State: AOJu0YzPVQDlm1Cojrq4ZVNs3WU8seyDi1L/sFRI+iaJvnfy9PTgkUom
 MZxQM8jZbajEVpKpWkOKvENkZIp9nq2L0p7ZhoZSJ+TCaKIchcMPUk2q96WiiqwfUmsf8tDbCiB
 WlOQmF9A/9IKdKTwquXV/4c82FduxUj2EuLy/8I7RZOteFwPlqBwLg8aaUA==
X-Gm-Gg: Acq92OGWVecMBq8lvUnDH52V/Uw9OHMB43cBbD29+qrOlCFSamO4kmf/Clhc4djHZmx
 CNNMRP/ZIhLSUGRCN84frlt5CExP3yRg0ylUmpszvglOn2TQ8M+VxxUx49NofKncK4gVOZIOsXH
 olIfI6AWWrW4O2rwDCzip3Q+oiMm5ZEizl5QzCFY/fgWRFIixXHvZP/sHIg349++yX/M75ZeCbC
 yr6SvgHQ0uHaU+/osQ0rqeMELt8jAceqtHEK3LoEtLpgiqtezFsIMHDYomLz+E+DG+daNBsiPoF
 LgNUnM+/ZQdwfHafNoQ+Xp0+AtUSbU9J18IE8cpEoq9EESoleDruUR7TMQVh251CCnR3RtU1G9Z
 VbaeF8hjJFjTAZh5mv2qM7UkUbg/L0RZneik1ori9ygE9S26N94ynsdHoPRmZI5qSWzynH1EaQk
 Dlz/x5+ndbewZfCA==
X-Received: by 2002:a05:7300:134a:b0:2ed:a64:a457 with SMTP id
 5a478bee46e88-30449184cbcmr2974405eec.20.1779493797340; 
 Fri, 22 May 2026 16:49:57 -0700 (PDT)
X-Received: by 2002:a05:7300:134a:b0:2ed:a64:a457 with SMTP id
 5a478bee46e88-30449184cbcmr2974386eec.20.1779493796797; 
 Fri, 22 May 2026 16:49:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245fac4sm2038344eec.27.2026.05.22.16.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:49:56 -0700 (PDT)
Message-ID: <422b450f-2a19-4bd6-b4b5-25e554b75e8b@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:49:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/37] bsd-user: Add kqueue and kevent functions to
 os-time.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Sean Bruno <sbruno@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-20-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-20-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a10eba6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=SCSqCZmV6E_sHHQnEb4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOCBTYWx0ZWRfX2Yh1MLGS2IhN
 1sfD6GEtSwyduVRnhT0vHf66ZeQqScwHr/mNvlv6tbd9ZZmMN4Pcdf7BQEnVAwKRlyUuwCpIz70
 BQ30WitHOl/rW08gErO8TMPeZZvXfO28RWZIIU+AxFvmXQ7DqdI5oVDdzPg8ObBnpBTPmCoIhEB
 L4LVWQ2x2nXxGKNyHWYeGOHfigCo+nQx2WRDPW+00RU34LwY0Ssksl8XhDD3glWO7mZCB9k0K1b
 DQ16/546Eg3GAE+ji+Db9oj9Ed5BtjyoszsjBOnkTPprprec/Pcix6lrwDt7LRYuTC0orkTK3IO
 vIIWx/0waP6HPToPFlBkOOXG5TyNV0rc7Ons/dAY/Y1ACUVAbDSdeKY4zicxtuZ7sK8xbMN8UxN
 kTY6uix6faR4/NPS7woPWbfn8Zt4JXi4IbZuS0hQhfrAJnfGTye4RK4hD1dD27a02/cmZXPSVag
 Xh8WLhwVMXzNkmFiiOQ==
X-Proofpoint-GUID: s5HReYvtR5Su8pUtekvMaSxo3ER0DHDp
X-Proofpoint-ORIG-GUID: s5HReYvtR5Su8pUtekvMaSxo3ER0DHDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
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
> Add event notification system call shims: kqueue, freebsd11_kevent
> (legacy 32-bit data field), and kevent (with 64-bit ext fields).
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-time.h | 173 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> index 12c5ba02e8..078355392d 100644
> --- a/bsd-user/freebsd/os-time.h
> +++ b/bsd-user/freebsd/os-time.h
> @@ -629,5 +629,178 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
>  }
>  
>  /* kqueue(2) */
> +static inline abi_long do_freebsd_kqueue(void)
> +{
> +
> +    return get_errno(kqueue());
> +}
> +
> +/* kevent(2) */
> +/* XXX Maybe some day, consolidate these two... */
> +static inline abi_long do_freebsd_freebsd11_kevent(abi_long arg1,
> +    abi_ulong arg2, abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
> +{
> +    abi_long ret;
> +    struct kevent *changelist = NULL, *eventlist = NULL;
> +    struct target_freebsd11_kevent *target_changelist, *target_eventlist;
> +    struct timespec ts;
> +    int i;
> +
> +    if (arg3 != 0) {
> +        target_changelist = lock_user(VERIFY_READ, arg2,
> +                                      sizeof(*target_changelist) * arg3, 1);
> +        if (target_changelist == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +
> +        changelist = alloca(sizeof(struct kevent) * arg3);
> +        memset(changelist, '\0', sizeof(struct kevent) * arg3);
> +        for (i = 0; i < arg3; i++) {
> +            __get_user(changelist[i].ident, &target_changelist[i].ident);
> +            __get_user(changelist[i].filter, &target_changelist[i].filter);
> +            __get_user(changelist[i].flags, &target_changelist[i].flags);
> +            __get_user(changelist[i].fflags, &target_changelist[i].fflags);
> +            __get_user(changelist[i].data, &target_changelist[i].data);
> +            /* __get_user(changelist[i].udata, &target_changelist[i].udata); */
> +#if TARGET_ABI_BITS == 32
> +            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
> +            tswap32s((uint32_t *)&changelist[i].udata);
> +#else
> +            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
> +            tswap64s((uint64_t *)&changelist[i].udata);
> +#endif
> +        }
> +        unlock_user(target_changelist, arg2, sizeof(*target_changelist) * arg3);
> +    }
> +
> +    if (arg5 != 0) {
> +        eventlist = alloca(sizeof(struct kevent) * arg5);
> +    }
> +    if (arg6 != 0) {
> +        if (t2h_freebsd_timespec(&ts, arg6)) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    ret = get_errno(safe_kevent(arg1, changelist, arg3, eventlist, arg5,
> +                                arg6 != 0 ? &ts : NULL));
> +
> +    if (arg5 == 0) {
> +        return ret;
> +    }
> +
> +    if (!is_error(ret)) {
> +        target_eventlist = lock_user(VERIFY_WRITE, arg4,
> +                                     sizeof(*target_eventlist) * arg5, 0);
> +        if (target_eventlist == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +        for (i = 0; i < ret; i++) {
> +            __put_user(eventlist[i].ident, &target_eventlist[i].ident);
> +            __put_user(eventlist[i].filter, &target_eventlist[i].filter);
> +            __put_user(eventlist[i].flags, &target_eventlist[i].flags);
> +            __put_user(eventlist[i].fflags, &target_eventlist[i].fflags);
> +            __put_user(eventlist[i].data, &target_eventlist[i].data);
> +            /* __put_user(eventlist[i].udata, &target_eventlist[i].udata);*/
> +#if TARGET_ABI_BITS == 32
> +            tswap32s((uint32_t *)&eventlist[i].udata);
> +            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
> +#else
> +            tswap64s((uint64_t *)&eventlist[i].udata);
> +            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
> +#endif
> +        }
> +        unlock_user(target_eventlist, arg4,
> +                    sizeof(*target_eventlist) * ret);
> +    }
> +    return ret;
> +}
> +
> +/* kevent(2) */
> +static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg2,
> +        abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
> +{
> +    abi_long ret;
> +    struct kevent *changelist = NULL, *eventlist = NULL;
> +    struct target_freebsd_kevent *target_changelist, *target_eventlist;
> +    struct timespec ts;
> +    int i;
> +
> +    if (arg3 != 0) {
> +        target_changelist = lock_user(VERIFY_READ, arg2,
> +                sizeof(struct target_freebsd_kevent) * arg3, 1);
> +        if (target_changelist == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +
> +        changelist = alloca(sizeof(struct kevent) * arg3);
> +        for (i = 0; i < arg3; i++) {
> +            __get_user(changelist[i].ident, &target_changelist[i].ident);
> +            __get_user(changelist[i].filter, &target_changelist[i].filter);
> +            __get_user(changelist[i].flags, &target_changelist[i].flags);
> +            __get_user(changelist[i].fflags, &target_changelist[i].fflags);
> +            __get_user(changelist[i].data, &target_changelist[i].data);
> +            /* __get_user(changelist[i].udata, &target_changelist[i].udata); */
> +#if TARGET_ABI_BITS == 32
> +            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
> +            tswap32s((uint32_t *)&changelist[i].udata);
> +#else
> +            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
> +            tswap64s((uint64_t *)&changelist[i].udata);
> +#endif
> +            __get_user(changelist[i].ext[0], &target_changelist[i].ext[0]);
> +            __get_user(changelist[i].ext[1], &target_changelist[i].ext[1]);
> +            __get_user(changelist[i].ext[2], &target_changelist[i].ext[2]);
> +            __get_user(changelist[i].ext[3], &target_changelist[i].ext[3]);
> +        }
> +        unlock_user(target_changelist, arg2, 0);
> +    }
> +
> +    if (arg5 != 0) {
> +        eventlist = alloca(sizeof(struct kevent) * arg5);
> +    }
> +    if (arg6 != 0) {
> +        if (t2h_freebsd_timespec(&ts, arg6)) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    ret = get_errno(safe_kevent(arg1, changelist, arg3, eventlist, arg5,
> +                                arg6 != 0 ? &ts : NULL));
> +
> +    if (arg5 == 0) {
> +        return ret;
> +    }
> +
> +    if (!is_error(ret)) {
> +        target_eventlist = lock_user(VERIFY_WRITE, arg4,
> +            sizeof(struct target_freebsd_kevent) * arg5, 0);
> +        if (target_eventlist == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +        for (i = 0; i < ret; i++) {
> +            __put_user(eventlist[i].ident, &target_eventlist[i].ident);
> +            __put_user(eventlist[i].filter, &target_eventlist[i].filter);
> +            __put_user(eventlist[i].flags, &target_eventlist[i].flags);
> +            __put_user(eventlist[i].fflags, &target_eventlist[i].fflags);
> +            __put_user(eventlist[i].data, &target_eventlist[i].data);
> +            /* __put_user(eventlist[i].udata, &target_eventlist[i].udata);*/
> +#if TARGET_ABI_BITS == 32
> +            tswap32s((uint32_t *)&eventlist[i].udata);
> +            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
> +#else
> +            tswap64s((uint64_t *)&eventlist[i].udata);
> +            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
> +#endif
> +            __put_user(eventlist[i].ext[0], &target_eventlist[i].ext[0]);
> +            __put_user(eventlist[i].ext[1], &target_eventlist[i].ext[1]);
> +            __put_user(eventlist[i].ext[2], &target_eventlist[i].ext[2]);
> +            __put_user(eventlist[i].ext[3], &target_eventlist[i].ext[3]);
> +        }
> +        unlock_user(target_eventlist, arg4,
> +                sizeof(struct target_freebsd_kevent) * ret);
> +    }
> +    return ret;
> +}
> +
> +/* sigtimedwait(2) */
>  
>  #endif /* FREEBSD_OS_TIME_H */
> 

If I understand correctly, the difference between the two is only in
get/put user for eventlist[i].ext[*].
It seems worth to factorize the two and add a parameter to switch
between the two.

