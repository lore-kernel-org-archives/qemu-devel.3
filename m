Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F69BCD5BBF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 01:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQb1g-0007QS-Ed; Fri, 22 May 2026 21:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQb1T-0007Nn-Do
 for qemu-devel@nongnu.org; Fri, 22 May 2026 21:19:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQb1Q-0000Jo-5v
 for qemu-devel@nongnu.org; Fri, 22 May 2026 21:19:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64N0JbSj4002400
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 01:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0pxQnGstIrV5X6rWBBq43CJ0i59LkddCRdaCc2rdy7U=; b=p1HK1/sw9CPTC1nH
 GnUUE9IQj4oGV6+kwvTIJKkjOfpKmBopdHECjOvMrPBwzgfAKy9gBMyGn/5WxCtt
 RfL5eE3SsEOokTKyWawA7A3erJg6hEMH70zxC+d2uWqhuj/j25gnelUQHOHF4eeB
 6zlltlyBVD+Ou3I0u9l1dnAMmM/qdAWh+MdFVrfZg71NkLT6JoMRpK1Q58Ea9LaG
 DQVrWZbfJ38c0M/hwVbZTZtlqvBcAgt+oPW6Ze8iZ5sOOEZ4+oOTmHLCYIfJSZKW
 69gktd0JzU/Th+bY7mhP+f5NgB4JRNwq9V1NqvBNmJHXjQUL/cFXqx7pSVG6aECk
 +i/mIg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmg3p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 01:19:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdd327d970so4428024eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779499160; x=1780103960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0pxQnGstIrV5X6rWBBq43CJ0i59LkddCRdaCc2rdy7U=;
 b=DwMD1YMcgE3WmervQuOUKKywEInTzlguab1tt7VxHEoKYkTCfpmJ+yj/RraH3F3a8b
 BzNOTn3jhcuQpR2HsV9Z7guMrpxrY51G1yEFogDUMtLuz2qTBi0EiNsrBhndqeeC7FiS
 KLFbZEAvtwjbNCngYDNFRgzqXxdf5lGC5kC2PQL0AhZ00bs1qLvhaeIUdMYe7ZYsMnBH
 puskWBnDlcjnvhqa5DPwBjrrqDJnSsROF5V4l++ja3GAJlekS/Rd0faawr+9+XRtmgn9
 +fmwLNMUOYzQqT+WU7T9fZeIANVI1DUVHYpxhS8Y2eWSSlHBskNZhEjnDytod9Rj+wrf
 yUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779499160; x=1780103960;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0pxQnGstIrV5X6rWBBq43CJ0i59LkddCRdaCc2rdy7U=;
 b=pg8zJ1S/XLC/+WTxUXZUf+rtBFx1z3mqGRgYBHjRxCMDXx9mBpKa/fYVBIGFOOEiFM
 EOEkxwmYnEBdVxYqKRy+QBZ/in2NHi2P57m/IwkSh2/k5KPhPcdO6BHej/Zda2EvIJIl
 Bq8PxVppjhem62g/NfUYBoatZ6js3b+CP33A4ijRhL/RTzkOA2HT6OHec+D/+YS+nRtg
 Eyuj34P9QzreXPO1sLB8hKIQpeIq6JyjMCy5mjnesV4y9auYgabyntljkLiIPPUL3qqV
 kOQ5DVw4y8H9n7MCdUeEiOHT5uPqh09iAq8deo+ia+SXXb1gDGiNt1q4thlwUvGoPmjW
 93UQ==
X-Gm-Message-State: AOJu0YwQhF2AjZb0DqqfcBerMgBxVOh3repNfGsQC4pl/jCCDo0oKBwz
 /g4DTKifrsGamdsv+TVw1YhdvADEqHCGqu5+BsBE+JJ3lcDImq5Lc7/wLh4kS+VW34HllIidWn1
 ZuOIML9H6fnPOh8dBdzmA5UtQdrqVSVhelZ69m0AZ8lujoEeNaSq7wsJP1g==
X-Gm-Gg: Acq92OFe7RWAEFWIOFV7N5iEbrXZLCe3I/mrbgD54G5f+JrNT5aKGNpW4TTTM6Q/8pD
 mNM7MX9f1p3vGuN/x6RxxQSA7DYl3mQpi4iW2yxEra/2FpGajlgEKdCLfx190uqntfLynIZrNfd
 Tm8ls0MEek/mW+ODwXCjaEONDBDYQorMmcY1HeWxtjlL/Pep0lKo1hzoKoIhccKpDqjWol8GM9S
 SxVP0IA79ECfvjiN72Y/W3WVYta0K+DibgaT7OG3PyT2OQpNRcxD9nKx1CuE3g9cpiHwhPYxHma
 yKYTk5knKqljMiJN3PNce0aSETVksET6KdktmjyWlT0s3N8+lLzYOEimxWcKScgFEiszSvlMXWR
 F4l50W+qxSV95JPKOxkxKBqshyU29Sr+RCcdmSi9dkmoyz0UlxnZ3arWrfhsP3TcrBIPWYxoObZ
 3amWBzE+IKq9z4wg==
X-Received: by 2002:a05:693c:3945:b0:2ef:1d11:18b0 with SMTP id
 5a478bee46e88-30431053f3fmr4151397eec.17.1779499159621; 
 Fri, 22 May 2026 18:19:19 -0700 (PDT)
X-Received: by 2002:a05:693c:3945:b0:2ef:1d11:18b0 with SMTP id
 5a478bee46e88-30431053f3fmr4151384eec.17.1779499158951; 
 Fri, 22 May 2026 18:19:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4af0sm2271692eec.3.2026.05.22.18.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 18:19:17 -0700 (PDT)
Message-ID: <586de8e4-428c-4e05-99d1-574f09b89f15@oss.qualcomm.com>
Date: Fri, 22 May 2026 18:19:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@freebsd.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
 <CANCZdfqoPUt1Dd55FAZOnxoe1wUSxQGzP1Rp=zRZkY6vC6iOfg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CANCZdfqoPUt1Dd55FAZOnxoe1wUSxQGzP1Rp=zRZkY6vC6iOfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAxMCBTYWx0ZWRfX8zCRfhf+p5io
 ZWK54r6R9fBdSEpv7mcXVCKAcBQDgcH8q5rZdIRIRAc3WBBdfVyLvZgqonx+BASBVTL1N42As8K
 ZzAboJRePSNqZnbBn+A6Q9m5VGTIeX4/cQCLvRXF+3PboSWg3j/l5FnJf3560sSEVr2CjvwHY01
 KFB9bgh+9HFNyEgpf/BtJOar7j9VmxpnBkBDPwxNEc84sL5Yaw4hsMPxk8xFQ8TbCQxxEIzaWuX
 CvboktPd0mK1QQHTDqFhFg65c/JwXkpPuP1zsCMm+FchWu4CE/wbqI4/eaY/iZaMjEoAHLBAJL0
 WHzHsdO+H1JWb+hoIuVIDWJ70S/xXlDvjhILouLGcbe65UYF8Mfsy8uKQ2bS7mIwmrNYXQtByeE
 zI5Ta5dm8aCHuIBpe/Z20q6qHKXzKdL3MfVuyQGKKknFGTa/t6g271u80X/DIdrqV9PeHqQ4Phj
 wP0WovGd3vQqOvcAFPg==
X-Proofpoint-ORIG-GUID: bipL2CFwMjSl3OJBzsuYLOIQqclrvwyk
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a110098 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7Qk2ozbKAAAA:8 a=VwQbUJbxAAAA:8 a=Hu34EndxONP1dDleGk4A:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: bipL2CFwMjSl3OJBzsuYLOIQqclrvwyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230010
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

On 5/22/2026 5:40 PM, Warner Losh wrote:
> 
> 
> On Fri, May 22, 2026 at 6:04 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> 
>     On 5/18/2026 2:27 PM, Warner Losh wrote:
>     > Upstream the file, thread, socket and remaining signal system
>     calls (too
>     > numerous to list here).
>     >
>     > This series is an ambitous use of claude to help me upstream all the
>     > remaining system calls. I've batched them together in what I think are
>     > reasonable chunks, and had claude do the grunt work of copying the
>     code
>     > over and attributing the commits from our complex branching
>     history. The
>     > chopping up was a bit arbitrary, but I think it's good. The commit
>     > messages may be a little weak, but may also be OK. I've also double
>     > checked the style and made fixes upstream for them as well. Claude
>     also
>     > reviewed all these changes and found a few bugs that I've fixed. I've
>     > personally read through them all and haven't found anything glaring. I
>     > fixed all the bugs that were found, in most cases differently than
>     > claude's suggestions.
>     >
>     > I've added 'Assisted-by: Claude...' to all these commits to reflect my
>     > leaning on Claude so hard. This use falls within the 'non-
>     creative' use
>     > that the Qemu project has said is OK. If that's not the right thing to
>     > do, I can remove them.
>     >
>     > This leaves sysctl translation, the powerpc architecture support,
>     > coredumps and a transition to 'truss' based system call tracing. With
>     > these changes applied we'er down from a high of about 30k lines of
>     diffs
>     > to only 5k (not counting genereted, but checked in files in
>     blitz). The
>     > changes are 8k, so maybe a bit ambitious from that perspective as
>     well.
>     >
>     > There's a few lines over 80 that I've not cleaned up. Let me know if
>     > that's a problem. The other warnings are about adding files, and
>     there's
>     > no new MAINTAINERS entry needed. And the 'arch dependent defines
>     should
>     > be avoided' are needed to cope with different FreeBSD build systems
>     > having different system calls.
>     >
>     > Note, this is called out below too, but in v2 I've folded back all the
>     > fixes based on some out-of-band feedback I recieved to do this the
>     > normal way and the qemu project isn't interested in the fixes to
>     fixes.
>     >
>     > This is a big experiment, in many ways, for me, so I'm interested in
>     > whatever feedback you may have to make things better in the future.
>     >
>     > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>     > ---
>     > Changes in v2:
>     > - don't write offsets on errors for copy_file_range
>     > - pipe2: Check the raw system call value directly
>     > - setsockopt: Check target_to_host_ip_mreq return value
>     > - <several places>: Check return value of host_to_target_sockaddr
>     > - do_bsd_setsockopt: Read in the socket option
>     > - ntp_gettime: write back time on non-errors, not just 0
>     > - do_freebsd_sigtimedwait check t2h_freebsd_timespec return
>     > - do_freebsd_swapcontext writing incorrectly, readonly data (0 to
>     user_unlock)
>     > - do_thr_set_name needs get_errno()
>     > - Have ntp_adjtime write back the structure
>     > - kevent_freebsd11 no need to explicitly mask, datatypes do this
>     for us
>     > - do_freebsd_setcontext just reads the mcontext, 0 in unlock_user
>     > - target_to_host_sigevent is read-only, so pass 0 in unlock_user
>     > - target_to_host_ip_mreq needs tswap32 for int32_t
>     > - use get_errno on kenv return values to report errors better
>     > - kevent: only copy the number of events returns, not whole buffer
>     > - Copy tolerance field of timex
>     > - freebsd_umtx_sem_wake use VERIFY_READ instead of write to read
>     struct
>     > - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
>     > - Fixed additional missing unlock in freebsd_rw_rdlock and
>     freebsd_rw_wrlock in !_UMTX_OPTIMIZED
>     > - Squashed all the bug commit back to the appropriate earleir patch
>     > - Link to v1: https://lore.kernel.org/qemu-devel/20260515-
>     misc-2026q2-v1-0-5438ca41b27a@bsdimp.com <https://lore.kernel.org/
>     qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
>     >
>     > ---
>     > Warner Losh (37):
>     >       bsd-user: catchup to locking / mapping routines in bsd-misc.
>     >       bsd-user: Rename cpu_env to env throughout bsd-user
>     >       bsd-user: Add bsd-signal.h with sigaction through sigreturn
>     >       bsd-user: Add signal shims sigwait through kill and os-signal.h
>     >       bsd-user: Add signal system call dispatch
>     >       bsd-user: Add poll, lseek, pipe, and swap system call shims
>     >       bsd-user: Add os-file.h with pipe2, chflagsat, close_range,
>     and more
>     >       bsd-user: Add file operation system call dispatch
>     >       bsd-user: Add bsd-socket.h with bind through getsockname
>     >       bsd-user: Add socket shims socketpair through shutdown
>     >       bsd-user: Add os-socket.h with sendrecvmsg and message
>     structures
>     >       bsd-user: Add do_bsd_setsockopt and socket option definitions
>     >       bsd-user: Add do_bsd_getsockopt
>     >       bsd-user: Add FreeBSD socket helpers and sockaddr conversion
>     >       bsd-user: Add os-socket.c with cmsg conversion functions
>     >       bsd-user: Add socket system call dispatch
>     >       bsd-user: Add os-time.h with clock and time-of-day functions
>     >       bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
>     >       bsd-user: Add select, pselect, and ppoll to os-time.h
>     >       bsd-user: Add kqueue and kevent functions to os-time.h
>     >       bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
>     >       bsd-user: Add os-time.c and time-related type definitions
>     >       bsd-user: Add time system call dispatch
>     >       bsd-user: Add thread, umtx, and ACL type definitions
>     >       bsd-user: Add cpu_copy and make init_task_state non-static
>     >       bsd-user: Add os-thread.h with thr and context functions
>     >       bsd-user: Add do_freebsd__umtx_op to os-thread.h
>     >       bsd-user: Add os-thread.c with umtx, mutex, and thread creation
>     >       bsd-user: Add thread system call dispatch
>     >       bsd-user: Add os-extattr.h with file and fd extattr functions
>     >       bsd-user: Add link and list extattr functions to os-extattr.h
>     >       bsd-user: Add ACL system call shims to os-extattr.h
>     >       bsd-user: Add os-extattr.c with ACL conversion functions
>     >       bsd-user: Add extended attribute and ACL system call dispatch
>     >       bsd-user: Add scheduler and cpuset functions to os-misc.h
>     >       bsd-user: Add kmod, posix, and misc functions to os-misc.h
>     >       bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
>     >
>     >  bsd-user/aarch64/target.h     |    2 +-
>     >  bsd-user/arm/target.h         |    2 +-
>     >  bsd-user/bsd-file.h           |  164 +++-
>     >  bsd-user/bsd-mem.h            |    4 +-
>     >  bsd-user/bsd-proc.h           |   24 +-
>     >  bsd-user/bsd-signal.h         |  231 ++++++
>     >  bsd-user/bsd-socket.c         |   98 +++
>     >  bsd-user/bsd-socket.h         |  283 +++++++
>     >  bsd-user/freebsd/meson.build  |    8 +-
>     >  bsd-user/freebsd/os-extattr.c |  116 +++
>     >  bsd-user/freebsd/os-extattr.h |  662 ++++++++++++++++
>     >  bsd-user/freebsd/os-file.h    |  129 ++++
>     >  bsd-user/freebsd/os-misc.h    |  470 +++++++++++-
>     >  bsd-user/freebsd/os-proc.c    |    4 +-
>     >  bsd-user/freebsd/os-proc.h    |   26 +-
>     >  bsd-user/freebsd/os-signal.h  |   20 +
>     >  bsd-user/freebsd/os-socket.c  |  234 ++++++
>     >  bsd-user/freebsd/os-socket.h  |  770 +++++++++++++++++++
>     >  bsd-user/freebsd/os-stat.h    |    8 +-
>     >  bsd-user/freebsd/os-sys.c     |    4 +-
>     >  bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
>     >  bsd-user/freebsd/os-thread.c  | 1682 ++++++++++++++++++++++++++++
>     +++++++++++++
>     >  bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
>     >  bsd-user/freebsd/os-time.c    |  346 +++++++++
>     >  bsd-user/freebsd/os-time.h    |  983 ++++++++++++++++++++++++
>     >  bsd-user/freebsd/qemu-os.h    |   48 ++
>     >  bsd-user/i386/target.h        |    2 +-
>     >  bsd-user/main.c               |   32 +-
>     >  bsd-user/meson.build          |    1 +
>     >  bsd-user/qemu-bsd.h           |   26 +
>     >  bsd-user/qemu.h               |   48 +-
>     >  bsd-user/riscv/target.h       |    2 +-
>     >  bsd-user/signal-common.h      |    4 +
>     >  bsd-user/signal.c             |   67 ++
>     >  bsd-user/syscall_defs.h       |  458 +++++++++--
>     >  bsd-user/x86_64/target.h      |    2 +-
>     >  36 files changed, 8150 insertions(+), 196 deletions(-)
>     > ---
>     > base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
>     > change-id: 20260504-misc-2026q2-a5af31ac032a
>     >
>     > Best regards,
> 
>     After reviewing (what I can) two thirds of the series, I don't feel very
>     at ease with validating the rest. Not that there is problem in itself,
>     but it's a massive add, and I'm not sure how we can ensure it's
>     implemented correctly without any test exercising it.
>     It's not particular to bsd-user, linux-user does not have test for all
>     syscalls implemented neither.
> 
> 
> Yes. I'd like a low-level test like that. The upstream bsd-user has been too
> incomplete to run real programs prior to this series. And there's still some
> issues that remain after these system calls (which is next up on my list: I
> think elfload needs some patches for PIE).
>  
> 
>     However, because we are adding most of it at once, it's a bit different.
>     Dropping 8150 new lines at once without any test looks a bit complicated
>     to me.
> 
>     A few questions about the series in itself:
>     - Where does most of the implementation comes from? Was it downstream on
>     FreeBSD side, or written from scratch for this series?
> 
> 
> We've had almost all of this code, modulo some big fixes I've added,  in
> blitz branch
> for years. Stacey Son implemented most of this a decade ago now and had some
> issue upstream at the time, IIRC, but I have only sketchy details of the
> project then.
> 
> We use it inside our poudriere jails to build thousands of ports to test
> it. Though there
> are issues with many ports, enough work to keep going.
> 
> I also run a number of random commands in the jail that's nothing but
> cross-arch binaries
> as well.
>

That's good to hear this has been used downstream for a long time. That
was my feeling after our conversation, but just wanted to double check this.

> Sometimes I run the Kyua tests, but it's a bit hard to read the output
> because many are broken,
> many can't work in qemu or in a jail, and there's some that are broken
> for a given arch. We don't
> have good baselines to compare against and I've not spent the time to
> get this into good shape.
> 
> Not the most formal set of things we do, but it works.
>  
> 
>     - How did you validate it works, beyond it compiles?
> 
> 
> Generally on the blitz side, all of the above. On the qemu-project side,
> I usually just do the bit
> about messing around in the jail to test the basics.
> 
> I'm happy cleaving this massive set into some smaller sets if that would
> help, but that still wouldn't
> answer the 'how the heck do we test it'.
>

It would require a massive effort for no benefit, since it doesn't
increase testability of the whole.

> I've also had claude do code reviews of this branch. It's found maybe
> 100 bugs that I've fixed
> (maybe 25 more between v2 and v3). The vast majority of the bugs are
> lock/unlock issues. Either
> leaks on error paths, failure to check for TARGET_EFAULT in places or
> passing args that don't
> matter unless you compile CONFIG_DEBUG_REMAP to indicate copying, etc.
> Some real bugs
> have been found, including one that might lead to a multi-threaded hang.
>

This is better than nothing, and it's a common usage I have with Claude
too. I just hope the industry does not settle on "let the AI review"
instead of test/cover approach.

> I have been putting off dealing with the PIE issue which blocks building
> most ports at the moment,
> but there's two pull requests to address it in blitz. When I tried them
> I hit some problems, but
> maybe I've fixed those in other ways. If I fixed that, I'd know that the
> base code works, but
> maybe all the pieces aren't in qemu-project yet.
> 
> Based on all that, what's your advice?
>

In an ideal world, I would advise to upstream the minimum to be able to
run hello-world. Once done, add tests for all existing syscalls.
Then add new syscalls with their tests. I tend to think that good code
is not the one being the most elegant/performant, but the one that you
can modify with trust in what you did, which means covered by a test.

In the real world, seems like we don't really have another option than
taking it, except if you're ready to spend 6 months to add tests for
this series. I'll let other reviewers finish the work for this series.

I'm not against the pragmatic approach of taking it, and let it be
tested on the field. It would be unfair considering how the rest of QEMU
is not always tested.

Sorry, I don't have any magic advice that allows to workaround the cost
- time - quality triangle.

> Warner
> 
>  
> 
>     Regards,
>     Pierrick
> 


