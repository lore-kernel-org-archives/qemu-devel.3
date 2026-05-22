Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C32CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYlf-0000kk-7L; Fri, 22 May 2026 18:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYlc-0000kc-Ru
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:54:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYla-0004Sz-Sa
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:54:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MKLpe54014295
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vv1aZcznjJQuJpj3IoRs4h6xqAAJ2WTLnBXl/NzWjI4=; b=YBaMZmayOFC35bgo
 bK8E5Xt5jCIhlWmPxs39iTKaP5JaoTazW26FHlaRtUNEaQWtbbz3ZmCtCz4OBD3V
 JNeVfkj/OXXaSc4GUtsvqX1sm7Xr9HjGfCg2p+BOo0I5Q0fGvB5TDsG7L1VSieOj
 uyThj+oPEaQyeYmkDcXKXtZw7UQ4LBOfjxT0YmLUq9+NMi1m1n0VpbO0aCGFimxB
 JZt10HK7IJ+z7atFdV5kiAlcnm1Exwfqc4HCAUgxJzsL32Fq0COt+7kfONCvz9q3
 DzP0OnPitxcAJtxzhYub5GaC62lVnt2Hua3bGC78T6UbOYguGH1V1FK4YusxfZQ6
 UE58wA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eax46rcc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:54:50 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1353bfdbf99so10633604c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779490490; x=1780095290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vv1aZcznjJQuJpj3IoRs4h6xqAAJ2WTLnBXl/NzWjI4=;
 b=FJZt4YeOohUj4+PB/I3XW8N8aKv6fzH2GdVoGgBO4aMVrSj/mwC1dqkePPa8leOKC0
 3g5X8cIk+KojwWTtK+f/gpScylZR6SHke0q+IbfRlGElU1GlhLyhsI6FgYv+Q/+PxT1x
 b7vT0LydTXxqHUnbnKYpujG3WW796uKbr/GlWPK0V/LWFJFhCbqq6Vdybdq//2uAPNMu
 DaZ4TKP9Imfaz+jT+ijG1GmlNzEbvJ9ghFD+d2F/3/qj0foqH8dbilf5haSxob4ZCcjT
 s0en6zUQ09ijFOqtE7GYhU4CZe75FJNGKBeUFXNZm4ic1FU2Duahxfv3DbLbYmJQUcyR
 Bnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779490490; x=1780095290;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vv1aZcznjJQuJpj3IoRs4h6xqAAJ2WTLnBXl/NzWjI4=;
 b=cLPtWOXIAopEQ5rzDjm/3yMmTda/YBW4fJc7H5HR6AH43gWYHv1XBv72DhuBB2Opt+
 l1ve4Jp7llYQ+yuMw7mecyBKa4b5l8b86lkoaXrMTyreZFQHi1LCPbbKb/grBbmq79vu
 UvJ0jkx5/gpK7nAgjUg9D0BDZaq+rskz2YsBLnqMu2tfVJqbcPqiPhzPihFrqY85Y5tf
 /+j9ysjGCrjPprIcU1dgflFkshaV6Ht/OMm9iKn2zokOUL9IZxOwdBbSPpkpCdpLBefN
 Zh6z8if+5z3bvxHvI8USlKsh/63Dm2LAfAbfsluhZFBCYiU5DwJF9KFNCAwdQjOugVq/
 MP1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zxeytTTcfJWD/8twhGX9bIzYXNbyIUa70hXkzgrZWzkOCa6PY2oIHxml/HrrGlTthaTjWxPzwc6jO@nongnu.org
X-Gm-Message-State: AOJu0YzXRK/xwgCV2eQtTAA/C80qt2TocNgc/lCMf6HImXK7bTjHY8jM
 MdQewM6yVMd68wbdH0kcipO92o6QBa4V91AAm8/lH8weuVTIdVqCHJs+GERe8ErC9F79Sz7bTI0
 HEcBfEmTWRNlAc9atE4wK9NKXrB8pH8/KLAUiavPiaJg7wap66PXVfIu2hw==
X-Gm-Gg: Acq92OGE+zMvgbRy17XcHQtYUAgzYYTnBgRnlBMos/XJHjriN/xzuVLL+1t1+j/8pcF
 HEFbCO8FY35k44v64vcgBLuJIBZzR+BqjnBmTq8HLRHwCDoNQpqw0Q9YPpU8CloJzPIj2TkqWb5
 /w0yuvIzv33+2KOqtrg16itONHR4igMTgCNal2V/iWWbedXpx+xA995cPAL8THIfxqh4JwEnk5s
 JPZK1bRGr2LrzKkXvIDWxCUriNEMPKd/txhnui8/jdWouryuL1Wf63M21KxCqNuk76/A0qH4MDH
 7zBY3wNiSjiuW+iNikhJHrDV66WUnYcg1wEvVMt571Gaoq+gcoZ4LsGQisLR0Sk12GrKVJ2JoI6
 /HqfccQD+Eum66dT7PHqw+3FQZ7jSijv7f1O3CDa3SM7pfp7ZF+jHtOaiyJ55nSI0HlilkIfTgr
 e0U9svYeGxJ03kXg==
X-Received: by 2002:a05:7300:ec11:b0:2da:44ac:6d0d with SMTP id
 5a478bee46e88-30449101b3emr2829570eec.20.1779490489920; 
 Fri, 22 May 2026 15:54:49 -0700 (PDT)
X-Received: by 2002:a05:7300:ec11:b0:2da:44ac:6d0d with SMTP id
 5a478bee46e88-30449101b3emr2829554eec.20.1779490489351; 
 Fri, 22 May 2026 15:54:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f1fe3esm3365719eec.7.2026.05.22.15.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:54:48 -0700 (PDT)
Message-ID: <8de010be-b2be-4e05-a748-2f9336eacade@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:54:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/37] bsd-user: Add os-file.h with pipe2, chflagsat,
 close_range, and more
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-7-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-7-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sKgaz2jYh8RXR9iApihSXG07wBnhLh5I
X-Proofpoint-GUID: sKgaz2jYh8RXR9iApihSXG07wBnhLh5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyOCBTYWx0ZWRfX2C9nCwmESUAK
 zN6dPe1eCzFYKilrFBmVmWC7dwa17rhv/yJEg4dcYClKzAsjPj/Gyfqkv52SYXFva6Bdgk/RNlJ
 G+syIj4OagY6YG2wryxwn7ig3olGNpz4cydUDepPDLXtKfKUEmOHbg12y+lK3V2b/GDk59k4biu
 1fWDSHTrWmQw9Perv2NAOp5p7R0MbiMNUNS3KLQNjSCEIq+bkiYgFTpa1s95CoUVAJMfClHShK0
 gh5DAF9N0zmrjPVSc0RZ0MAJ/5jRNNJ3norB/OB+NLmdYmXCNl0e575cV/SSfxUM0THgGkVPTCt
 H8Z7XXvzIYW7WyCG+WRTVQcItus+YG+9ssAs08lu0faQ9oHcVo+Lg9qcygmX7ed1GnxTf1E1w4O
 qQae2/96m2+afi86518g2O4w1m1l09vc5bTAr8QOp1MhB11l2RK0ntbnlnLC8x2Sg9wxDp7ugAM
 k3jfRUfP1fXC9+7+7zw==
X-Authority-Analysis: v=2.4 cv=TtvWQjXh c=1 sm=1 tr=0 ts=6a10debb cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=lOo56UqbS7XheI_2CYQA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220228
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
> Add FreeBSD-specific file operation shims: pipe2, chflagsat,
> close_range, copy_file_range, and __specialfd. Also add the
> safe_copy_file_range and safe_ppoll syscall wrappers and the
> target_specialfd_eventfd type definitions.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-file.h    | 129 ++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |   7 +++
>  2 files changed, 136 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
> new file mode 100644
> index 0000000000..c1da52789a
> --- /dev/null
> +++ b/bsd-user/freebsd/os-file.h
> @@ -0,0 +1,129 @@
> +/*
> + * FreeBSD file related system call shims and definitions
> + *
> + * Copyright (c) 2014 Stacey D. Son
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef FREEBSD_OS_FILE_H
> +#define FREEBSD_OS_FILE_H
> +
> +#include <sys/specialfd.h>
> +
> +/*
> + * Asynchronous I/O.
> + */
> +
> +/* pipe2(2) */
> +static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, int flags)
> +{
> +    int host_pipe[2];
> +    int host_ret = pipe2(host_pipe, flags);
> +    /* XXXss - flags should be translated from target to host. */
> +
> +    if (host_ret == -1) {
> +        return get_errno(host_ret);
> +    }
> +
> +    /*
> +     * pipe2() returns it's second FD by copying it back to userspace and not in
> +     * a second register like pipe(2): set_second_rval(env, host_pipe[1]);
> +     *
> +     * Copy the FD's back to userspace:
> +     */
> +    if (put_user_s32(host_pipe[0], pipedes) ||
> +        put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
> +        close(host_pipe[0]);
> +        close(host_pipe[1]);
> +        return -TARGET_EFAULT;
> +    }
> +    return 0;
> +}
> +
> +/* chflagsat(2) */
> +static inline abi_long do_bsd_chflagsat(int fd, abi_ulong path,
> +        abi_ulong flags, int atflags)
> +{
> +    abi_long ret;
> +    void *p;
> +
> +    LOCK_PATH(p, path);
> +    ret = get_errno(chflagsat(fd, p, flags, atflags)); /* XXX path(p)? */
> +    UNLOCK_PATH(p, path);
> +
> +    return ret;
> +}
> +
> +/* close_range(2) */
> +static inline abi_long do_freebsd_close_range(unsigned int lowfd,
> +    unsigned int highfd, int flags)
> +{
> +
> +    return get_errno(close_range(lowfd, highfd, flags));
> +}
> +
> +ssize_t safe_copy_file_range(int, off_t *, int, off_t *, size_t, unsigned int);
> +
> +/* copy_file_range(2) */
> +static inline abi_long do_freebsd_copy_file_range(int infd,
> +    abi_ulong inofftp, int outfd, abi_ulong outofftp, size_t len,
> +    unsigned int flags)
> +{
> +    off_t inoff, outoff, *inp, *outp;
> +    abi_long ret;
> +
> +    inp = outp = NULL;
> +    if (inofftp != 0 && !access_ok(VERIFY_WRITE, inofftp, sizeof(off_t))) {
> +        return -TARGET_EFAULT;
> +    } else if (inofftp != 0) {
> +        inoff = tswap64(*(off_t *)g2h_untagged(inofftp));
> +        inp = &inoff;
> +    }
> +    if (outofftp != 0 && !access_ok(VERIFY_WRITE, outofftp, sizeof(off_t))) {
> +        return -TARGET_EFAULT;
> +    } else if (outofftp != 0) {
> +        outoff = tswap64(*(off_t *)g2h_untagged(outofftp));
> +        outp = &outoff;
> +    }
> +

Very small nit, but this pattern is a bit weird to read:

Would be better with:

if (inofftp != 0) {
  if (!access_ok(VERIFY_WRITE, inofftp, sizeof(off_t))) {
    return -TARGET_EFAULT;
  }
  inoff = tswap64(*(off_t *)g2h_untagged(inofftp));
  inp = &inoff;
}

> +    ret = get_errno(safe_copy_file_range(infd, inp, outfd, outp, len,
> +        flags));
> +
> +    if (!is_error(ret)) {
> +        if (inofftp != 0) {
> +            *(off_t *)g2h_untagged(inofftp) = tswap64(inoff);
> +        }
> +        if (outofftp != 0) {
> +            *(off_t *)g2h_untagged(outofftp) = tswap64(outoff);
> +        }
> +    }
> +    return ret;
> +}
> +
> +static inline abi_long do_freebsd___specialfd(int type, abi_ulong req,
> +    size_t len)
> +{
> +    abi_long ret;
> +
> +    ret = -TARGET_EINVAL;
> +    switch (type) {
> +    case TARGET_SPECIALFD_EVENT: {
> +        struct specialfd_eventfd evfd;
> +        struct target_specialfd_eventfd *target_eventfd;
> +
> +        if (!lock_user_struct(VERIFY_READ, target_eventfd, req, 1)) {
> +            return -TARGET_EFAULT;
> +        }
> +
> +        evfd.initval = tswap32(target_eventfd->initval);
> +        evfd.flags = tswap32(target_eventfd->flags);
> +        ret = get_errno(syscall(SYS___specialfd, type, &evfd, sizeof(evfd)));
> +        unlock_user_struct(target_eventfd, req, 0);
> +        break;
> +    }
> +    }
> +
> +    return ret;
> +}
> +
> +#endif /* FREEBSD_OS_FILE_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index fc6273a780..8a25be4ac7 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -45,6 +45,7 @@
>  #include "os-stat.h"
>  #include "os-proc.h"
>  #include "os-signal.h"
> +#include "os-file.h"
>  #include "os-misc.h"
>  
>  /* I/O */
> @@ -66,6 +67,12 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
>  safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
>      off_t, offset);
>  
> +safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
> +    const struct timespec *, restrict_timeout, const sigset_t *,
> +    restrict_newsigmask);
> +safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
> +    off_t *, outoffp, size_t, len, unsigned int, flags);
> +
>  /* used in os-proc */
>  safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
>      struct rusage *, rusage);
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


