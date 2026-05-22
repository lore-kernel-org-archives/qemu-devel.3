Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993FFCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZFT-0008Q8-Ki; Fri, 22 May 2026 19:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZFR-0008Pq-UP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:25:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZFP-0003co-IV
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:25:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHfhEE3601580
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k4MtD+FC+QUAy+Pu/qZ05/STwLuWfIePEwlFmMb2pKU=; b=QIOm4kgRH/G+Y5R0
 zOBCQ+x6Q7Y9g7hGadmSbtFwzj6cR5464XG0hVFejKaMjM4d0kVYLDYbrSlP6EX4
 VCdVfNp0snim1Nc2zNpExf2U0PXhVZ+Y1AuV7WNZJahmHjjC5HiyNo5yARKMO2JR
 w9V6zfMivSZU8xPpN35L3QlkapIfW9oLIfgt5h+QGHPP3p5fN/ZKC8JtnAjhEqW1
 +pKemRRzDLIiBBgdHRPmU0nnbyeQbqxVmFnS8XvwPYbP+cM6EN9ShoE9k1pNwYxv
 UAP7nfi+43vIxDigkYoQnct0THLDeqg5IrlA+HSE8J4Xtog23g6dczykYeMb8s93
 cKro8Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury0wdm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:04:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so8904506eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779491067; x=1780095867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k4MtD+FC+QUAy+Pu/qZ05/STwLuWfIePEwlFmMb2pKU=;
 b=N06wkccIYTxkaC6+HlU9alxgBxX8qz0Dp+WWXbP5aCeCpKOzTlqqgWmn2SzWUSz1uK
 gNfoaF4QdSjLv6OmvsUMGtq+5bS3sKsmjFdXhXldBm5WZSkdva85ycrItL3gkL/F80DZ
 6eKrQWRdWiftgCwQAwfujj5odGcMLqwG/wrRKAxA7nSBNsBQ7IUD+/68RlcIMQ2DiUWF
 /duGPIpIKOv3lJaE99bsbanrgFSpPs1afZHLx8v3AbUlL++yberFyskCvXIu7hAkFytL
 xXOkVaHrjxkhnLxkGY39ydDYiN54C9tUQxBr3Ay5OIskxwRzKlDS8pgAroCy5LNlI7L7
 Aeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779491067; x=1780095867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4MtD+FC+QUAy+Pu/qZ05/STwLuWfIePEwlFmMb2pKU=;
 b=Nb3uAImiu4M3r+2TJnT0tklppLo4muLzszaf2fjJ5slK2v3LJTliEGOZrh/NiT/yab
 FF7eGTNqHOJNrBsH7W/NP2SQWWewLMTWCSo6L93Z505nXdEzdRDz+tCKgarvYVIx+wAP
 WKJqSVJIAGVqd0I42Pw19kGc3RJnrwW6VfT5latZsKhi4MReD6TyKlE7wXgSGetWvIGb
 7zYAcesuI94Dn0qg+YMiJX73o4nujjpW7PBMMxufIAUJxUujaKX4JK97hL5Bs6KHjJkO
 x3wblP3gqbY6nhcLFmZlJGTjxBGwSl2OJnXvbaGDUI7OYSAGOuF3wF8dFtLAEB339WZg
 3Cdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VPqbw/CuejUaXAt7DjAvhlVyhB8FMhgaRCiJVLkSfZdSORBtug2p5lrML/Yt6fzSpRpnYx7VjR9Nd@nongnu.org
X-Gm-Message-State: AOJu0YxDgu8lO3rjg5CeH0EN8k/FXYJ2WiW5mV+OG+Exc9W+b8XnNY5f
 K3PC2a/YBqzkRUWZwz48NaTY69l/AnA9voxYrum5Ed4spyc4P38l3TCbOdVahF0mAO5N9QyrF+6
 I8/9j3iTZnYXx2tmoeKKdx+YbWO4ZAMHSda6Af6BJvykBmlcwS8IgFFgYWg==
X-Gm-Gg: Acq92OE1M2cUvMa+YKaxHJxEc/rMcHGgTeFuV6uOzD/lBVdBjd3ZN7jREJ45+DgttOE
 LBUs614GHdM7nb2xtLPL7F03Ee0xqC7Vhrl47n5PupM4sxKzEHbIpEYKe4i4g+8SI5JEldO6PIe
 XbCMBkHWsnqxsdgHfQVVhSxTtYhND7UEVV9ZDc4w9aI1zMyImGmfEhr6I0081NFmzqEoluSVuWZ
 0VabD84QwIi2fyblT4EWcOGLhj467IllDoPWD4EiFPFp5WQDPfF+CHEdN/C/SLp5I0AqOD3TnhI
 ehyCyvJZXC80wP6gJmskJ/B8lAFDqC8onfVC+fnRv+I/w4IMD7j1L8VO2n4RM6M9ysJHCxXVLrb
 5RGI+A3neABzXD6YN62sWDQuyOyZaOagemejjNrfdYNJtW6m745Of9uoYBsuSuX+GgVZgi+R0P4
 X8JJqpS3y/GUCYhw==
X-Received: by 2002:a05:693c:2c0c:b0:303:a1af:5042 with SMTP id
 5a478bee46e88-30448d51723mr3031662eec.0.1779491066519; 
 Fri, 22 May 2026 16:04:26 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0c:b0:303:a1af:5042 with SMTP id
 5a478bee46e88-30448d51723mr3031641eec.0.1779491065956; 
 Fri, 22 May 2026 16:04:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304535ae870sm1985460eec.19.2026.05.22.16.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:04:25 -0700 (PDT)
Message-ID: <32d52b2b-8a2a-40d2-b69c-0ce5a286dc50@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:04:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/37] bsd-user: Add bsd-socket.h with bind through
 getsockname
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-9-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-9-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzMCBTYWx0ZWRfX6AkmDP+tki/c
 tSSpn/gnBvKIXc7tNFlFNiVdqpoLpKZ4DxNTuReETXKb9SSXZm8WX/dzWNo2WrjSOnZDfXpyGn+
 cOMVU8zsXGqhUCTngjSyPqg8ZiLh4di3+BP6g0TA4hEWA5uPezVj0XzlaPW1hAvxozuxNOLY8kL
 1o7sCp8bLqeusltmGncKH0aV3JkTxyP94UkVEje0u6Ux0ERm4tKbDlbB6RoQ7QoR8sBOsElofKA
 nfxhu4AkRXaBY10PnETlGezBsS7mHmK0yzCOPKjZPeNreenC5hSDrWRbBhtto1587bax4QeiFXC
 GXL2xknj9Vo6U36mV/IakgmyJArLyO5ANfCTlXfUPosm4SfFDsdUgb22PRDt/hjX3lcWwJMBF40
 +gMLFfAIVhNXEI4bKxlnMB5WRX9zM9QXDEbI+rjfklmV4ppUT9XOBstsXwJtfMXU8kjokPjlLIH
 H2eocb8ic5Jt5gkLJAA==
X-Proofpoint-ORIG-GUID: nRgQ79sIcQFCKj1lZYWZduolDlexqWQc
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a10e0fb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=JFj-TQ9_vy8ndR87m1cA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: nRgQ79sIcQFCKj1lZYWZduolDlexqWQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220230
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
> Add the first set of socket system call shims: bind, connect,
> accept, getpeername, and getsockname. Also add safe_syscall wrappers
> for sendto, recvfrom, select, pselect, recvmsg, and sendmsg.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/bsd-socket.h         | 167 ++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  15 ++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
> new file mode 100644
> index 0000000000..c786d6717a
> --- /dev/null
> +++ b/bsd-user/bsd-socket.h
> @@ -0,0 +1,167 @@
> +/*
> + * socket related system call shims
> + *
> + * Copyright (c) 2013 Stacey D. Son
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef BSD_SOCKET_H
> +#define BSD_SOCKET_H
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <netinet/in.h>
> +
> +#include "qemu-bsd.h"
> +
> +ssize_t safe_recvfrom(int s, void *buf, size_t len, int flags,
> +    struct sockaddr *restrict from, socklen_t *restrict fromlen);
> +ssize_t safe_sendto(int s, const void *buf, size_t len, int flags,
> +    const struct sockaddr *to, socklen_t tolen);
> +int safe_select(int nfds, fd_set *readfs, fd_set *writefds, fd_set *exceptfds,
> +    struct timeval *timeout);
> +int safe_pselect(int nfds, fd_set *restrict readfds,
> +    fd_set *restrict writefds, fd_set *restrict exceptfds,
> +    const struct timespec *restrict timeout,
> +    const sigset_t *restrict newsigmask);
> +
> +/* bind(2) */
> +static inline abi_long do_bsd_bind(int sockfd, abi_ulong target_addr,
> +                                   socklen_t addrlen)
> +{
> +    abi_long ret;
> +    void *addr;
> +
> +    if ((int)addrlen < 0) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    addr = alloca(addrlen + 1);
> +    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +
> +    return get_errno(bind(sockfd, addr, addrlen));
> +}
> +
> +/* connect(2) */
> +static inline abi_long do_bsd_connect(int sockfd, abi_ulong target_addr,
> +                                      socklen_t addrlen)
> +{
> +    abi_long ret;
> +    void *addr;
> +
> +    if ((int)addrlen < 0) {
> +        return -TARGET_EINVAL;
> +    }
> +    addr = alloca(addrlen + 1);
> +
> +    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
> +
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +
> +    return get_errno(connect(sockfd, addr, addrlen));
> +}
> +
> +/* accept(2) */
> +static inline abi_long do_bsd_accept(int fd, abi_ulong target_addr,
> +                                     abi_ulong target_addrlen_addr)
> +{
> +    socklen_t addrlen;
> +    void *addr;
> +    abi_long ret;
> +
> +    if (target_addr == 0) {
> +        return get_errno(accept(fd, NULL, NULL));
> +    }
> +    /* return EINVAL if addrlen pointer is invalid */
> +    if (get_user_u32(addrlen, target_addrlen_addr)) {
> +        return -TARGET_EINVAL;
> +    }
> +    if ((int)addrlen < 0) {
> +        return -TARGET_EINVAL;
> +    }
> +    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
> +        return -TARGET_EINVAL;
> +    }
> +    addr = alloca(addrlen);
> +
> +    ret = get_errno(accept(fd, addr, &addrlen));
> +    if (!is_error(ret)) {
> +        if (is_error(host_to_target_sockaddr(target_addr, addr, addrlen))) {
> +            close(ret);
> +            ret = -TARGET_EFAULT;
> +        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
> +            close(ret);
> +            ret = -TARGET_EFAULT;
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* getpeername(2) */
> +static inline abi_long do_bsd_getpeername(int fd, abi_ulong target_addr,
> +                                          abi_ulong target_addrlen_addr)
> +{
> +    socklen_t addrlen;
> +    void *addr;
> +    abi_long ret;
> +
> +    if (get_user_u32(addrlen, target_addrlen_addr)) {
> +        return -TARGET_EFAULT;
> +    }
> +    if ((int)addrlen < 0) {
> +        return -TARGET_EINVAL;
> +    }
> +    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
> +        return -TARGET_EFAULT;
> +    }
> +    addr = alloca(addrlen);
> +    ret = get_errno(getpeername(fd, addr, &addrlen));
> +    if (!is_error(ret)) {
> +        ret = host_to_target_sockaddr(target_addr, addr, addrlen);
> +        if (is_error(ret)) {
> +            ret = -TARGET_EFAULT;
> +        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
> +            ret = -TARGET_EFAULT;
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* getsockname(2) */
> +static inline abi_long do_bsd_getsockname(int fd, abi_ulong target_addr,
> +                                          abi_ulong target_addrlen_addr)
> +{
> +    socklen_t addrlen;
> +    void *addr;
> +    abi_long ret;
> +
> +    if (get_user_u32(addrlen, target_addrlen_addr)) {
> +        return -TARGET_EFAULT;
> +    }
> +    if ((int)addrlen < 0) {
> +        return -TARGET_EINVAL;
> +    }
> +    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
> +        return -TARGET_EFAULT;
> +    }
> +    addr = alloca(addrlen);
> +
> +    ret = get_errno(getsockname(fd, addr, &addrlen));
> +    if (!is_error(ret)) {
> +        ret = host_to_target_sockaddr(target_addr, addr, addrlen);
> +        if (is_error(ret)) {
> +            ret = -TARGET_EFAULT;
> +        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
> +            ret = -TARGET_EFAULT;
> +        }
> +    }
> +    return ret;
> +}
> +
> +#endif /* BSD_SOCKET_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index 228daed4c4..737de36514 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -40,6 +40,7 @@
>  #include "bsd-proc.h"
>  #include "bsd-misc.h"
>  #include "bsd-signal.h"
> +#include "bsd-socket.h"
>  
>  /* BSD dependent syscall shims */
>  #include "os-stat.h"
> @@ -73,6 +74,20 @@ safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
>  safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
>      off_t *, outoffp, size_t, len, unsigned int, flags);
>  
> +/* used in bsd-socket */
> +safe_syscall5(int, select, int, nfds, fd_set *, readfs, fd_set *, writefds,
> +    fd_set *, exceptfds, struct timeval *, timeout);
> +safe_syscall6(int, pselect, int, nfds, fd_set *restrict, readfs,
> +    fd_set *restrict, writefds, fd_set *restrict, exceptfds,
> +    const struct timespec *restrict, timeout, const sigset_t *restrict,
> +    newsigmask);
> +safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len, int, flags,
> +    struct sockaddr *restrict, from, socklen_t *restrict, fromlen);
> +safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
> +    flags, const struct sockaddr *, to, socklen_t, tolen);
> +safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
> +safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
> +
>  /* used in os-proc */
>  safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
>      struct rusage *, rusage);
> 

I'm really not fond of seeing alloca, especially used with a random
parameter for the size. Seems like linux-user uses it to implement those
functions though.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


