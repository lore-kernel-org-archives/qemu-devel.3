Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DD6CD5BB0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 00:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZqk-0002py-Hm; Fri, 22 May 2026 20:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZqa-0002pC-AY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 20:04:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZqX-0003Ah-Rs
 for qemu-devel@nongnu.org; Fri, 22 May 2026 20:04:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIOg4n4007090
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 00:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Grq4yo+CI4StWr1Ahk4EAEhLWVi2qMYpnlmynnRVOno=; b=LQt5Lwcq9Tsxx61q
 p/7xcnyxnCynF+QES0y5IjzPPLZ8SFzckJ8UAqRPV7W21z5Emrhbf/DWtY+MMGC8
 WjMShFNEopXAuYxrw5QH9TxGBRvz+zKBpHi9v9r+xVOIoGsRXbZKRCQaBJJ/i4hX
 lHNn1Q+GaIHltEVYQyNe1xAJikJlF3lXOlLjNKdPPELkM/Mz/TEsW5YuFAChIhJn
 vtJxwFOJO1qWnfvrzbOLZbo58E3hNGukwXbsmc8VMV8lPs5h8atsX50KYsOCXE3Z
 6k047EB6EWgp65qJRfMcXSkQ1L6LynCiorZJBYnXcsvTJ/gjL5OaHEduvsU0U1hk
 0Cohyw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eavd98w39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 00:04:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so13014124eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779494642; x=1780099442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Grq4yo+CI4StWr1Ahk4EAEhLWVi2qMYpnlmynnRVOno=;
 b=Bv2BbavVVKQ4zx4pqJWOht/OfmenrF0PPADe3qAelwU4Lr286LNXFbBEV19zL9qpOv
 aLPSeUSn0SHy3Qa0xyFsvMtttx1P7by+8v8TPrlvdr1my9J6EEWRAdjRtREOv+hrjmTV
 ziHxlMFcGU08GqE0MRHl9t7tZTpMC7I0fkTHqgOdj5U7pOrqrgNmWLJWpD1mqrZV1Tf+
 wfKhTyF4gs3alnzYL9SL1NI1QoqQY0el2qkpt2zEGdimg3WfY2OJW7lSkOWE5sKpB6S7
 Z9NBBniHnrErYkjfdxRT2naQ8vm7iSAiBEReMftn/lDULFvGmw1w6dK/ql7U8pUVS2Ci
 KacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494642; x=1780099442;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Grq4yo+CI4StWr1Ahk4EAEhLWVi2qMYpnlmynnRVOno=;
 b=geF362Em7EzdFU6if36hle0DJV4tjScWDlN2eXs5g+uT1GvaeUJjf2U3K/F86WzeRS
 Ek+0/1yoAsX/fxTWV0UlZG/V0RefUqQExJwPcTYOAc0MflTkIj/vMD26IFu7W7xT4fKb
 Ul0xBGxWD4eLaNTNqh3+q8c6pzixirCog0usp/jH031se9fJY1KIB8jokqy0NgMdoqRN
 UiR7OdT6PMo0tJ7+JiieSwKw5bFTWf6j49ULfFMvbsei9QEONgTe2YcJ/iadDU+8we1E
 Mu5NM6sJKq0YutcDOWVN9aAALsN8CiSLcjUn4Jx+XfXbrc+Pw7tPDGUW+6cpU22hF/rE
 1SOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lLrT6q/Fd5rYwxgQnMZj2/xynwX1s/VG1KAzqjpC0kw1D9d2us6et0hOMF/ViZslTPw7z/pSLCUTU@nongnu.org
X-Gm-Message-State: AOJu0Yybu6WGkjvdn1wY8dECX6vsN2e4D6oQ3/b6Lqx0dXSDAY7oJgsl
 JUNxdAT49MJNeEVh4Y7cp5+VpGfZuhL+9vJzI0xGOTEBdESSk094mmegWHnj1uBbdl32Ge99MRd
 1YdlHQbSTwhmdOjNLkNLJe3wbWxw3u6udDXinMVVQwMcBw6EI3vadzKljew==
X-Gm-Gg: Acq92OELr5fDZEOBJH0Tq+4l05f1Pv4IAqqqJ+pMg/J15oTcgeAH4tpvSjXvn963HT2
 YetmrlSmEESO+WpQeBAXXH8syezxZN8q9rHtSxtbmgeTzERVDtT1bciqCUqcLYbPgpk6NfzcI7q
 JvlSpKvEXwcgur/PyUT6H6ffWOiG0YBKrZAqbhObtgeVRQTZY0awBLnDjkh3/0FN/7MyoBL1KdQ
 XBbJonj7ZXNL+VDtB3kc16/TkHGh583fgRdgZMOL0zI8WPbOrjezBNsW1Q2HvH0eounIUlBgqbu
 TehD2O1l2oKZyEYofwaBPUiTqBxV0vx7F6ZJ4bdo3z7wGmQfhlVMcrldn/CEq6WZZe3QX3WGydv
 4Fpl1Xd6YTH3WmcbachaMfqSgG3EdVw1f7rZ9rLHlfaiWVP8pFXBX0Afg4Pv0WXc066TPJOAIyt
 aYRz2co6DsFMNurg==
X-Received: by 2002:a05:7300:7c13:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-3044904e126mr2979814eec.4.1779494641433; 
 Fri, 22 May 2026 17:04:01 -0700 (PDT)
X-Received: by 2002:a05:7300:7c13:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-3044904e126mr2979795eec.4.1779494640782; 
 Fri, 22 May 2026 17:04:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef5492sm2143841eec.6.2026.05.22.17.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 17:04:00 -0700 (PDT)
Message-ID: <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
Date: Fri, 22 May 2026 17:03:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>, =?UTF-8?Q?Mika=C3=ABl_Urankar?=
 <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDI0MCBTYWx0ZWRfXyipF2gcfRUbb
 Nto3RqEl7oD9x4tphCwVo3FEpfgPfE6guMLafRyD0Tg9F3waQ+nyVKnFxVfSOJYWZSJh2GE4nuf
 dkoZQtpb5/QR2XkZFI3cSnzjBJgdjzDfmjPLhUTsvC+6fbbSkMMt1KNmVoaPoS8V/dSHvJwj5FB
 V6Jz/LZbvYeGgh9hRwH2eYvh2BgV5NGAWSLnKyK84uhOHkgkUj6fZLA16m8y9VDh0eipkVdYLUT
 CIK2j/6sUrCrlr++2YZz1+t9Ck1BcIqnsSZmzkAAagOvvsxGJwK5KYSG172VwcAkyzCc+nB3XQz
 Bzit/56AMVVwnsifb9YlgixmmSkxlm43u2+KgK7mCgYbBkgAwPpXUNJS1bTjWF6erAZ2ykQxfxY
 7693szPl54BSegTzYsbtHSEXgTWPaCRUhMm/kbBjlYs0nWDk6tMA3AvVpwg27QzUXyNCeYao9UH
 6Ldu3bWpG0MninPoxgg==
X-Proofpoint-GUID: htpRhnws8aMX-UBwxHDLgmjioG-Aq47r
X-Proofpoint-ORIG-GUID: htpRhnws8aMX-UBwxHDLgmjioG-Aq47r
X-Authority-Analysis: v=2.4 cv=F+dnsKhN c=1 sm=1 tr=0 ts=6a10eef2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=7Qk2ozbKAAAA:8 a=NSby3TWSATn290ERE34A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220240
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
> Upstream the file, thread, socket and remaining signal system calls (too
> numerous to list here).
> 
> This series is an ambitous use of claude to help me upstream all the
> remaining system calls. I've batched them together in what I think are
> reasonable chunks, and had claude do the grunt work of copying the code
> over and attributing the commits from our complex branching history. The
> chopping up was a bit arbitrary, but I think it's good. The commit
> messages may be a little weak, but may also be OK. I've also double
> checked the style and made fixes upstream for them as well. Claude also
> reviewed all these changes and found a few bugs that I've fixed. I've
> personally read through them all and haven't found anything glaring. I
> fixed all the bugs that were found, in most cases differently than
> claude's suggestions.
> 
> I've added 'Assisted-by: Claude...' to all these commits to reflect my
> leaning on Claude so hard. This use falls within the 'non-creative' use
> that the Qemu project has said is OK. If that's not the right thing to
> do, I can remove them.
> 
> This leaves sysctl translation, the powerpc architecture support,
> coredumps and a transition to 'truss' based system call tracing. With
> these changes applied we'er down from a high of about 30k lines of diffs
> to only 5k (not counting genereted, but checked in files in blitz). The
> changes are 8k, so maybe a bit ambitious from that perspective as well.
> 
> There's a few lines over 80 that I've not cleaned up. Let me know if
> that's a problem. The other warnings are about adding files, and there's
> no new MAINTAINERS entry needed. And the 'arch dependent defines should
> be avoided' are needed to cope with different FreeBSD build systems
> having different system calls.
> 
> Note, this is called out below too, but in v2 I've folded back all the
> fixes based on some out-of-band feedback I recieved to do this the
> normal way and the qemu project isn't interested in the fixes to fixes.
> 
> This is a big experiment, in many ways, for me, so I'm interested in
> whatever feedback you may have to make things better in the future.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Changes in v2:
> - don't write offsets on errors for copy_file_range
> - pipe2: Check the raw system call value directly
> - setsockopt: Check target_to_host_ip_mreq return value
> - <several places>: Check return value of host_to_target_sockaddr
> - do_bsd_setsockopt: Read in the socket option
> - ntp_gettime: write back time on non-errors, not just 0
> - do_freebsd_sigtimedwait check t2h_freebsd_timespec return
> - do_freebsd_swapcontext writing incorrectly, readonly data (0 to user_unlock)
> - do_thr_set_name needs get_errno()
> - Have ntp_adjtime write back the structure
> - kevent_freebsd11 no need to explicitly mask, datatypes do this for us
> - do_freebsd_setcontext just reads the mcontext, 0 in unlock_user
> - target_to_host_sigevent is read-only, so pass 0 in unlock_user
> - target_to_host_ip_mreq needs tswap32 for int32_t
> - use get_errno on kenv return values to report errors better
> - kevent: only copy the number of events returns, not whole buffer
> - Copy tolerance field of timex
> - freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struct
> - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
> - Fixed additional missing unlock in freebsd_rw_rdlock and freebsd_rw_wrlock in !_UMTX_OPTIMIZED
> - Squashed all the bug commit back to the appropriate earleir patch
> - Link to v1: https://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com
> 
> ---
> Warner Losh (37):
>       bsd-user: catchup to locking / mapping routines in bsd-misc.
>       bsd-user: Rename cpu_env to env throughout bsd-user
>       bsd-user: Add bsd-signal.h with sigaction through sigreturn
>       bsd-user: Add signal shims sigwait through kill and os-signal.h
>       bsd-user: Add signal system call dispatch
>       bsd-user: Add poll, lseek, pipe, and swap system call shims
>       bsd-user: Add os-file.h with pipe2, chflagsat, close_range, and more
>       bsd-user: Add file operation system call dispatch
>       bsd-user: Add bsd-socket.h with bind through getsockname
>       bsd-user: Add socket shims socketpair through shutdown
>       bsd-user: Add os-socket.h with sendrecvmsg and message structures
>       bsd-user: Add do_bsd_setsockopt and socket option definitions
>       bsd-user: Add do_bsd_getsockopt
>       bsd-user: Add FreeBSD socket helpers and sockaddr conversion
>       bsd-user: Add os-socket.c with cmsg conversion functions
>       bsd-user: Add socket system call dispatch
>       bsd-user: Add os-time.h with clock and time-of-day functions
>       bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
>       bsd-user: Add select, pselect, and ppoll to os-time.h
>       bsd-user: Add kqueue and kevent functions to os-time.h
>       bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
>       bsd-user: Add os-time.c and time-related type definitions
>       bsd-user: Add time system call dispatch
>       bsd-user: Add thread, umtx, and ACL type definitions
>       bsd-user: Add cpu_copy and make init_task_state non-static
>       bsd-user: Add os-thread.h with thr and context functions
>       bsd-user: Add do_freebsd__umtx_op to os-thread.h
>       bsd-user: Add os-thread.c with umtx, mutex, and thread creation
>       bsd-user: Add thread system call dispatch
>       bsd-user: Add os-extattr.h with file and fd extattr functions
>       bsd-user: Add link and list extattr functions to os-extattr.h
>       bsd-user: Add ACL system call shims to os-extattr.h
>       bsd-user: Add os-extattr.c with ACL conversion functions
>       bsd-user: Add extended attribute and ACL system call dispatch
>       bsd-user: Add scheduler and cpuset functions to os-misc.h
>       bsd-user: Add kmod, posix, and misc functions to os-misc.h
>       bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
> 
>  bsd-user/aarch64/target.h     |    2 +-
>  bsd-user/arm/target.h         |    2 +-
>  bsd-user/bsd-file.h           |  164 +++-
>  bsd-user/bsd-mem.h            |    4 +-
>  bsd-user/bsd-proc.h           |   24 +-
>  bsd-user/bsd-signal.h         |  231 ++++++
>  bsd-user/bsd-socket.c         |   98 +++
>  bsd-user/bsd-socket.h         |  283 +++++++
>  bsd-user/freebsd/meson.build  |    8 +-
>  bsd-user/freebsd/os-extattr.c |  116 +++
>  bsd-user/freebsd/os-extattr.h |  662 ++++++++++++++++
>  bsd-user/freebsd/os-file.h    |  129 ++++
>  bsd-user/freebsd/os-misc.h    |  470 +++++++++++-
>  bsd-user/freebsd/os-proc.c    |    4 +-
>  bsd-user/freebsd/os-proc.h    |   26 +-
>  bsd-user/freebsd/os-signal.h  |   20 +
>  bsd-user/freebsd/os-socket.c  |  234 ++++++
>  bsd-user/freebsd/os-socket.h  |  770 +++++++++++++++++++
>  bsd-user/freebsd/os-stat.h    |    8 +-
>  bsd-user/freebsd/os-sys.c     |    4 +-
>  bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
>  bsd-user/freebsd/os-thread.c  | 1682 +++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
>  bsd-user/freebsd/os-time.c    |  346 +++++++++
>  bsd-user/freebsd/os-time.h    |  983 ++++++++++++++++++++++++
>  bsd-user/freebsd/qemu-os.h    |   48 ++
>  bsd-user/i386/target.h        |    2 +-
>  bsd-user/main.c               |   32 +-
>  bsd-user/meson.build          |    1 +
>  bsd-user/qemu-bsd.h           |   26 +
>  bsd-user/qemu.h               |   48 +-
>  bsd-user/riscv/target.h       |    2 +-
>  bsd-user/signal-common.h      |    4 +
>  bsd-user/signal.c             |   67 ++
>  bsd-user/syscall_defs.h       |  458 +++++++++--
>  bsd-user/x86_64/target.h      |    2 +-
>  36 files changed, 8150 insertions(+), 196 deletions(-)
> ---
> base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
> change-id: 20260504-misc-2026q2-a5af31ac032a
> 
> Best regards,

After reviewing (what I can) two thirds of the series, I don't feel very
at ease with validating the rest. Not that there is problem in itself,
but it's a massive add, and I'm not sure how we can ensure it's
implemented correctly without any test exercising it.
It's not particular to bsd-user, linux-user does not have test for all
syscalls implemented neither.

However, because we are adding most of it at once, it's a bit different.
Dropping 8150 new lines at once without any test looks a bit complicated
to me.

A few questions about the series in itself:
- Where does most of the implementation comes from? Was it downstream on
FreeBSD side, or written from scratch for this series?
- How did you validate it works, beyond it compiles?

Regards,
Pierrick

