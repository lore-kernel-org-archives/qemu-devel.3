Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720DBCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZLN-0002CS-3J; Fri, 22 May 2026 19:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZLF-0002BZ-OY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:31:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZLD-0006gt-C5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:31:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIOnu64007769
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PrL8wQ7ru07ff8BsOiqmuU8qItgRElFe9arRqq1QGzY=; b=KAP5wssP8rZ+AFMc
 ZzKlO2dywO/9fWSzItkUBvukIeh849EVI6L40yldAcH6aLxuOQMsLfdviDNbszu7
 mAVT+dr2GB8F5xQJQoqDGThHrJU2TBJOVuLsh8egh36WnsFvs4Z01ooBV6F+nMEj
 UzaHkmZ355GAKi94yOqW90n2rDnkbVzQjhsV39HdBNAj9RQ64hHrtEJNbbOUOFvw
 Pi/xYGMZFNhpR/bwwb+LfrkHoNWQf+iO1iDCB1e8IlNaVpCpin6qeSyQA2Ckrx6p
 VHIvk+bku9AbAjDmNOdvFTsvUyorbeK4y6+nVde8De1afbCprpTvSx7SJlspSo3O
 Byeeuw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eavd98tph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:31:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso28897080eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779492701; x=1780097501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PrL8wQ7ru07ff8BsOiqmuU8qItgRElFe9arRqq1QGzY=;
 b=X0BkN77py2KzeGMd8B4QMoyOyKoZzi0NqAn2EFJUZWQWQDCOk66lTI+NR+SFT8d8vr
 5ac+Mb+TKtESYt9TGIIUjwfTUk6r9zzPRorv0DW9T3uih6s3Mzaey+EGkCBMexDhKh3P
 7T6p84fZ7hdU2tUPn9PeADaF8ZJbiZuzWM601pxUVL1/VghHaYok5LoC0V3i0ov9sTGg
 gEO2JuDbK34mt0xxy9Dy6ORl6xXfWRK9SkAnOoyfBCV2JwqMCYMJxWwRfqVn0hmC9LtR
 lknV/eQdqJrfw2QsIitGYSiOHFuTr5pwKubzkrnpYGddy0A98IDKpIVEuAn7Uwf4IojC
 qVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779492701; x=1780097501;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PrL8wQ7ru07ff8BsOiqmuU8qItgRElFe9arRqq1QGzY=;
 b=ljK2NxA4wUqLNjof1/yFgfNocByO3NUBGC/6NqVuYDekYfr5FecTTDSEZh/iFygZsq
 cuwmhhX5SnDVbKeNq7s8GcbH8lhCkvnRJAii4g/UIhAOF4ka0Adwef8AOvbFb7eV+AOI
 O5bxZOoX1Gn9i5lM90tqmo4TWf2qWFMDJKMt3b26/zpEkOLpP3pMdevEQuqi7dxA7b8P
 t0xWR+nvDh7GmUFix5GPKOiBn7uVds2K0TLzBmvh4Zdm3TmV3jmI3piRdfm00sKlZPtU
 gFhpuA8JFA7U2BiZ83LP67OKGLhQYRiyerJfcEpeq5qmL3nAh2sHX3k7My7TYToRcuYI
 E5Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Sci+NNGy+GX4rC4hbJIkFoRLhxEqEY8V9yUpjEe2lNpg0NttuJ57W7bcDroaFN5MYa5Y/zu5r/wp/@nongnu.org
X-Gm-Message-State: AOJu0YyKpmXpp5Je7rQJJ41mDTaFHcj9SX/c4pyqBl9Ia455510fSxR7
 6QSkQ0QRKR83Xq+PPg/GvYe/7PDEwleEkVKYnJCWGOizuSBK+aB9m0l93CV+2n1DLszcTMIpwHY
 7xg8k4ukbDWue33c/xYKvxlMml9PojV+EihPa8RlkGx+HnZjJDZtqopYJKA==
X-Gm-Gg: Acq92OG58TKUiMWiXnhiEYv1xpWXbfqF7zp5kVZ8n+wMmBVRp7zQfatHUq67/5HFGyy
 5ZRarsC6qs1h/C4J6o/KTt1prerNRDAwB+4uDbYGI9Td8qm8BqUAnuEZhvQpzxymykUqsUx1kI0
 uLpseO63n8NNPmQJVerZJ+KvnvCuzhqhKaRIYFlmN7/pfwTBmeCLh6sREVTfPXQknrqJLPBBkog
 dDPDnjMGEALe5JcryFbPH/ufT4nihl4F/we1l1gOZ6VmJxshTsUtbigZvwubIIvHp9WCxxWzT8e
 nX95oiLep4ZV2cO7uolxQrIELvQIYxBlKgPU8VWeBTfj/cRmyMsp3ic7da9pDHh2SBKDK2YzAqA
 /AiTGGZvefNkRtPUxwaZUJSB2Bh0kM3If+NIN8lsfAX8XpvdNHuELUrhpRKP8+YHDiPoTr1XOlS
 PksGCd7WVEtx2P5w==
X-Received: by 2002:a05:7300:730f:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-3044919da81mr3034038eec.24.1779492700569; 
 Fri, 22 May 2026 16:31:40 -0700 (PDT)
X-Received: by 2002:a05:7300:730f:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-3044919da81mr3034018eec.24.1779492699885; 
 Fri, 22 May 2026 16:31:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f1fd1csm2063340eec.8.2026.05.22.16.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:31:39 -0700 (PDT)
Message-ID: <00cd8976-321a-409a-bea0-d790ed91866b@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:31:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/37] bsd-user: Add os-socket.c with cmsg conversion
 functions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-15-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-15-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNSBTYWx0ZWRfX1CpkEH/UqbBe
 I3RIPDg4seXClw7wvnGHErjeyB1v1EeacEZ+Y29Ppn1Q6yE8j3hTdPA5XQeTnno9/fn6n4VGJVW
 cdsdqvtKLC85M/w54tBkWEI89YkNxB1z/fy7bmqyDh52twhb6K3dFcTrVQwBY0IH87Qui3arP8s
 wn8S7wL3bXfKajCSbQwA82Ll8VLfpHX7Sk4QZPMvXWd8qsKb7oIlGhzmwSqHKqqvLHErbiR7hcb
 bPspIQQPK42psoSRvy+xHkybHQJ6zId4hxx1j1Ykfl21Lh85LcpQ4vJOm97906x78GzSkicW6pG
 I/1RKEAfF1vzixeTafyqGDaO60nnQPRubgPIVF9siF/RRrxlrHLp9IURWChlnL79DpB4DMhrSyt
 VgwCnnYQjQ08YvSEKIN/RgyK1gwLtlHAQ3ufWtqmTq/E+YHur5VU4UvAA5XUkL9N3nNnjy5/5hg
 Vy6butjlU4a0D6O3V+Q==
X-Proofpoint-GUID: H6Gt89a5BneNA6j6uBHFoCbcKXNkhONn
X-Proofpoint-ORIG-GUID: H6Gt89a5BneNA6j6uBHFoCbcKXNkhONn
X-Authority-Analysis: v=2.4 cv=F+dnsKhN c=1 sm=1 tr=0 ts=6a10e75d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=reB_f6KLoqRrtQvU6U8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220235
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
> Add target-to-host and host-to-target control message conversion
> functions (t2h_freebsd_cmsg and h2t_freebsd_cmsg) for sendmsg/recvmsg
> support, and add os-socket.c to the FreeBSD build.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/meson.build |   8 +-
>  bsd-user/freebsd/os-socket.c | 234 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 240 insertions(+), 2 deletions(-)
> 
> diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
> index 38f2debf7e..0fc779749d 100644
> --- a/bsd-user/freebsd/meson.build
> +++ b/bsd-user/freebsd/meson.build
> @@ -4,9 +4,13 @@ bsd_syscall_nr = custom_target('bsd-syscall-h',
>      command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
>  
>  bsd_user_ss.add(files(
> -  'os-stat.c',
> +  'os-extattr.c',
>    'os-proc.c',
> +  'os-socket.c',
> +  'os-stat.c',
>    'os-sys.c',
> -  'os-syscall.c'),
> +  'os-syscall.c',
> +  'os-thread.c',
> +  'os-time.c'),
>    bsd_syscall_nr
>  )

Most of additions here seem to belong to previous patches.

> diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.c
> new file mode 100644
> index 0000000000..8eb728240d
> --- /dev/null
> +++ b/bsd-user/freebsd/os-socket.c
> @@ -0,0 +1,234 @@
> +/*
> + * FreeBSD socket related system call helpers
> + *
> + * Copyright (c) 2013 Stacey D. Son
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "qemu.h"
> +#include "qemu-os.h"
> +
> +abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
> +        struct target_msghdr *target_msgh)
> +{
> +    struct cmsghdr *cmsg = CMSG_FIRSTHDR(msgh);
> +    socklen_t msg_controllen;
> +    abi_ulong target_cmsg_addr;
> +    struct target_cmsghdr *target_cmsg, *target_cmsg_start;
> +    socklen_t space = 0;
> +
> +    msg_controllen = tswap32(target_msgh->msg_controllen);
> +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
> +        goto the_end;
> +    }
> +    target_cmsg_addr = tswapal(target_msgh->msg_control);
> +    target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr, msg_controllen, 1);
> +    target_cmsg_start = target_cmsg;
> +    if (!target_cmsg) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    while (cmsg && target_cmsg) {
> +        void *data = CMSG_DATA(cmsg);
> +        void *target_data = TARGET_CMSG_DATA(target_cmsg);
> +        int len = (unsigned char *)(target_cmsg) +
> +            tswap32(target_cmsg->cmsg_len) - (unsigned char *)target_data;
> +
> +        space += CMSG_SPACE(len);
> +        if (space > msgh->msg_controllen) {
> +            space -= CMSG_SPACE(len);
> +            /*
> +             * This is a QEMU bug, since we allocated the payload area ourselves
> +             * (unlike overflow in host-to-target conversion, which is just the
> +             * guest giving us a buffer that's too small). It can't happen for
> +             * the payload types we currently support; if it becomes an issue in
> +             * future we would need to improve our allocation strategy to
> +             * something more intelligent than "twice the size of the target
> +             * buffer we're reading from".
> +             */
> +            gemu_log("Host cmsg overflow\n");
> +            break;
> +        }
> +
> +        if (tswap32(target_cmsg->cmsg_level) == TARGET_SOL_SOCKET) {
> +            cmsg->cmsg_level = SOL_SOCKET;
> +        } else {
> +            cmsg->cmsg_level = tswap32(target_cmsg->cmsg_level);
> +        }
> +        cmsg->cmsg_type = tswap32(target_cmsg->cmsg_type);
> +        cmsg->cmsg_len = CMSG_LEN(len);
> +
> +        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
> +            int *fd = (int *)data;
> +            int *target_fd = (int *)target_data;
> +            int i, numfds = len / sizeof(int);
> +
> +            for (i = 0; i < numfds; i++) {
> +                __get_user(fd[i], target_fd + i);
> +            }
> +        } else if ((cmsg->cmsg_level == SOL_SOCKET) &&
> +            (cmsg->cmsg_type == SCM_TIMESTAMP) &&
> +            (len == sizeof(struct target_freebsd_timeval)))  {
> +            /* copy struct timeval to host */
> +            struct timeval *tv = (struct timeval *)data;
> +            struct target_freebsd_timeval *target_tv =
> +                (struct target_freebsd_timeval *)target_data;
> +            __get_user(tv->tv_sec, &target_tv->tv_sec);
> +            __get_user(tv->tv_usec, &target_tv->tv_usec);
> +        } else {
> +            gemu_log("Unsupported target ancillary data: %d/%d\n",
> +                     cmsg->cmsg_level, cmsg->cmsg_type);
> +            memcpy(data, target_data, len);
> +        }
> +
> +        cmsg = CMSG_NXTHDR(msgh, cmsg);
> +        target_cmsg = TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
> +                                         target_cmsg_start);
> +    }
> +    unlock_user(target_cmsg_start, target_cmsg_addr, 0);
> +the_end:
> +    msgh->msg_controllen = space;
> +    return 0;
> +}
> +
> +abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
> +        struct msghdr *msgh)
> +{
> +    struct cmsghdr *cmsg = CMSG_FIRSTHDR(msgh);
> +    socklen_t msg_controllen;
> +    abi_ulong target_cmsg_addr;
> +    struct target_cmsghdr *target_cmsg, *target_cmsg_start;
> +    socklen_t space = 0;
> +
> +    msg_controllen = tswap32(target_msgh->msg_controllen);
> +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
> +        goto the_end;
> +    }
> +    target_cmsg_addr = tswapal(target_msgh->msg_control);
> +    target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr, msg_controllen, 0);
> +    target_cmsg_start = target_cmsg;
> +    if (!target_cmsg) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    while (cmsg && target_cmsg) {
> +        void *data = CMSG_DATA(cmsg);
> +        void *target_data = TARGET_CMSG_DATA(target_cmsg);
> +        int len = (unsigned char *)(cmsg) + cmsg->cmsg_len -
> +            (unsigned char *)data;
> +
> +        int tgt_len, tgt_space;
> +
> +        /*
> +         * We never copy a half-header but may copy half-data; this is Linux's
> +         * behaviour in put_cmsg(). Note that truncation here is a guest problem
> +         * (which we report to the guest via the CTRUNC bit), unlike truncation
> +         * in target_to_host_cmsg, which is a QEMU bug.
> +         */
> +        if (msg_controllen < sizeof(struct target_cmsghdr)) {
> +            target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
> +            break;
> +        }
> +
> +        if (cmsg->cmsg_level == SOL_SOCKET) {
> +            target_cmsg->cmsg_level = tswap32(TARGET_SOL_SOCKET);
> +        } else {
> +            target_cmsg->cmsg_level = tswap32(cmsg->cmsg_level);
> +        }
> +        target_cmsg->cmsg_type = tswap32(cmsg->cmsg_type);
> +
> +        /*
> +         * Payload types which need a different size of payload on the target
> +         * must adjust tgt_len here.
> +         */
> +        tgt_len = len;
> +        switch (cmsg->cmsg_level) {
> +        case SOL_SOCKET:
> +            switch (cmsg->cmsg_type) {
> +            case SCM_TIMESTAMP:
> +                tgt_len = sizeof(struct target_freebsd_timeval);
> +                break;
> +            default:
> +                break;
> +            }
> +            break;
> +        default:
> +            break;
> +        }
> +
> +        if (msg_controllen < TARGET_CMSG_LEN(tgt_len)) {
> +            target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
> +            tgt_len = msg_controllen - sizeof(struct target_cmsghdr);
> +        }
> +
> +        /*
> +         * We must now copy-and-convert len bytes of payload into tgt_len bytes
> +         * of destination space. Bear in mind that in both source and
> +         * destination we may be dealing with a truncated value!
> +         */
> +        switch (cmsg->cmsg_level) {
> +        case SOL_SOCKET:
> +            switch (cmsg->cmsg_type) {
> +            case SCM_RIGHTS:
> +            {
> +                int *fd = (int *)data;
> +                int *target_fd = (int *)target_data;
> +                int i, numfds = tgt_len / sizeof(int);
> +
> +                for (i = 0; i < numfds; i++) {
> +                    __put_user(fd[i], target_fd + i);
> +                }
> +                break;
> +            }
> +            case SCM_TIMESTAMP:
> +            {
> +                struct timeval *tv = (struct timeval *)data;
> +                struct target_freebsd_timeval *target_tv =
> +                    (struct target_freebsd_timeval *)target_data;
> +
> +                if (len != sizeof(struct timeval) ||
> +                    tgt_len != sizeof(struct target_freebsd_timeval)) {
> +                    goto unimplemented;
> +                }
> +
> +                /* copy struct timeval to target */
> +                __put_user(tv->tv_sec, &target_tv->tv_sec);
> +                __put_user(tv->tv_usec, &target_tv->tv_usec);
> +                break;
> +            }
> +            default:
> +                goto unimplemented;
> +            }
> +            break;
> +        default:
> +        unimplemented:
> +            gemu_log("Unsupported host ancillary data: %d/%d\n",
> +                     cmsg->cmsg_level, cmsg->cmsg_type);
> +            memcpy(target_data, data, MIN(len, tgt_len));
> +            if (tgt_len > len) {
> +                memset(target_data + len, 0, tgt_len - len);
> +            }
> +        }
> +
> +        target_cmsg->cmsg_len = tswap32(TARGET_CMSG_LEN(tgt_len));
> +        tgt_space = TARGET_CMSG_SPACE(tgt_len);
> +        if (msg_controllen < tgt_space) {
> +            tgt_space = msg_controllen;
> +        }
> +        msg_controllen -= tgt_space;
> +        space += tgt_space;
> +        cmsg = CMSG_NXTHDR(msgh, cmsg);
> +        target_cmsg = TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
> +                                         target_cmsg_start);
> +    }
> +    unlock_user(target_cmsg_start, target_cmsg_addr, space);
> +the_end:
> +    target_msgh->msg_controllen = tswap32(space);
> +    return 0;
> +}
> 


