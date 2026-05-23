Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA25CD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 18:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQrXC-0002KP-1e; Sat, 23 May 2026 14:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wQrX8-0002K8-Fr
 for qemu-devel@nongnu.org; Sat, 23 May 2026 14:57:14 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wQrX5-0001x1-Jp
 for qemu-devel@nongnu.org; Sat, 23 May 2026 14:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779562624; x=1780167424; i=deller@gmx.de;
 bh=S79Qbcs7Wy5i4GzPZW2aKMpPRtIA+jxgbXjewJI7qX4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ce6adcLx3w/kPC3djg1J209LzvJJl4NOaYnHHbRtv+C8bJ5NJREGE93eYQQgDuys
 Y+nC6xqxZK1niCeRVnykz3jb6ix10JYMlEwwxC+WwMdQ9kOrplJFIH/Cngi1OJVLV
 4RShOeSGQoc+06aVsuWR55s3QMoDRlC4Uy1sd3CFYvBDAd8OBezMEKhJys8++OnZV
 vbloNGwQnk4zeVAMtHECoNAi7eZDwig8upoktq4feSrk5taDEK5KnJQ5Br1UpZGyj
 t0raHOzO3Geg0XzMrcKnBrRraCXANg0irdv+ychU/aBUt1EIy4gkldr8EZNQ/8Wji
 hE6+N/p08J5+/aq+zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1wzLzk3QgY-00c89V; Sat, 23
 May 2026 20:57:04 +0200
Message-ID: <730049c6-7de2-403d-a327-491d1cfc52fd@gmx.de>
Date: Sat, 23 May 2026 20:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@freebsd.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
 <CANCZdfqoPUt1Dd55FAZOnxoe1wUSxQGzP1Rp=zRZkY6vC6iOfg@mail.gmail.com>
 <586de8e4-428c-4e05-99d1-574f09b89f15@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <586de8e4-428c-4e05-99d1-574f09b89f15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8vfW1tKcGsKYpvmjzhTknUPMMFbiIPRilp8rk+kGyu0mNtIGe6m
 hl3sX0i0/fVZfuPtS4M2Zl5d5BGrKlTjKM0DjatyXX4YD00dA6BMfuAuDhmsL1lwV1lBfMb
 PtkZIExZC+/ebNFGl4Kak7wGHBYk+obQQGLYUjJdHcs0DXNnDZZxSXOin7nlq9nGyfwiXXR
 87qQGbVweTB3N0i07+8lg==
UI-OutboundReport: notjunk:1;M01:P0:4Iu7hqqsFf8=;mwr+AbjvKykHTsM+Sex9XFiCqcK
 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
 pgKtRNtnI4cwaUe5RRTLku6vz/et9+
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/23/26 03:19, Pierrick Bouvier wrote:
> On 5/22/2026 5:40 PM, Warner Losh wrote:
>>
>>
>> On Fri, May 22, 2026 at 6:04=E2=80=AFPM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com
>> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>>      On 5/18/2026 2:27 PM, Warner Losh wrote:
>>      > Upstream the file, thread, socket and remaining signal system
>>      calls (too
>>      > numerous to list here).
>>      >
>>      > This series is an ambitous use of claude to help me upstream all=
 the
>>      > remaining system calls. I've batched them together in what I thi=
nk are
>>      > reasonable chunks, and had claude do the grunt work of copying t=
he
>>      code
>>      > over and attributing the commits from our complex branching
>>      history. The
>>      > chopping up was a bit arbitrary, but I think it's good. The comm=
it
>>      > messages may be a little weak, but may also be OK. I've also dou=
ble
>>      > checked the style and made fixes upstream for them as well. Clau=
de
>>      also
>>      > reviewed all these changes and found a few bugs that I've fixed.=
 I've
>>      > personally read through them all and haven't found anything glar=
ing. I
>>      > fixed all the bugs that were found, in most cases differently th=
an
>>      > claude's suggestions.
>>      >
>>      > I've added 'Assisted-by: Claude...' to all these commits to refl=
ect my
>>      > leaning on Claude so hard. This use falls within the 'non-
>>      creative' use
>>      > that the Qemu project has said is OK. If that's not the right th=
ing to
>>      > do, I can remove them.
>>      >
>>      > This leaves sysctl translation, the powerpc architecture support=
,
>>      > coredumps and a transition to 'truss' based system call tracing.=
 With
>>      > these changes applied we'er down from a high of about 30k lines =
of
>>      diffs
>>      > to only 5k (not counting genereted, but checked in files in
>>      blitz). The
>>      > changes are 8k, so maybe a bit ambitious from that perspective a=
s
>>      well.
>>      >
>>      > There's a few lines over 80 that I've not cleaned up. Let me kno=
w if
>>      > that's a problem. The other warnings are about adding files, and
>>      there's
>>      > no new MAINTAINERS entry needed. And the 'arch dependent defines
>>      should
>>      > be avoided' are needed to cope with different FreeBSD build syst=
ems
>>      > having different system calls.
>>      >
>>      > Note, this is called out below too, but in v2 I've folded back a=
ll the
>>      > fixes based on some out-of-band feedback I recieved to do this t=
he
>>      > normal way and the qemu project isn't interested in the fixes to
>>      fixes.
>>      >
>>      > This is a big experiment, in many ways, for me, so I'm intereste=
d in
>>      > whatever feedback you may have to make things better in the futu=
re.
>>      >
>>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.co=
m>>
>>      > ---
>>      > Changes in v2:
>>      > - don't write offsets on errors for copy_file_range
>>      > - pipe2: Check the raw system call value directly
>>      > - setsockopt: Check target_to_host_ip_mreq return value
>>      > - <several places>: Check return value of host_to_target_sockadd=
r
>>      > - do_bsd_setsockopt: Read in the socket option
>>      > - ntp_gettime: write back time on non-errors, not just 0
>>      > - do_freebsd_sigtimedwait check t2h_freebsd_timespec return
>>      > - do_freebsd_swapcontext writing incorrectly, readonly data (0 t=
o
>>      user_unlock)
>>      > - do_thr_set_name needs get_errno()
>>      > - Have ntp_adjtime write back the structure
>>      > - kevent_freebsd11 no need to explicitly mask, datatypes do this
>>      for us
>>      > - do_freebsd_setcontext just reads the mcontext, 0 in unlock_use=
r
>>      > - target_to_host_sigevent is read-only, so pass 0 in unlock_user
>>      > - target_to_host_ip_mreq needs tswap32 for int32_t
>>      > - use get_errno on kenv return values to report errors better
>>      > - kevent: only copy the number of events returns, not whole buff=
er
>>      > - Copy tolerance field of timex
>>      > - freebsd_umtx_sem_wake use VERIFY_READ instead of write to read
>>      struct
>>      > - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
>>      > - Fixed additional missing unlock in freebsd_rw_rdlock and
>>      freebsd_rw_wrlock in !_UMTX_OPTIMIZED
>>      > - Squashed all the bug commit back to the appropriate earleir pa=
tch
>>      > - Link to v1: https://lore.kernel.org/qemu-devel/20260515-
>>      misc-2026q2-v1-0-5438ca41b27a@bsdimp.com <https://lore.kernel.org/
>>      qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
>>      >
>>      > ---
>>      > Warner Losh (37):
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: catchup to locking / mapping=
 routines in bsd-misc.
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Rename cpu_env to env throug=
hout bsd-user
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add bsd-signal.h with sigact=
ion through sigreturn
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add signal shims sigwait thr=
ough kill and os-signal.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add signal system call dispa=
tch
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add poll, lseek, pipe, and s=
wap system call shims
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-file.h with pipe2, ch=
flagsat, close_range,
>>      and more
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add file operation system ca=
ll dispatch
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add bsd-socket.h with bind t=
hrough getsockname
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add socket shims socketpair =
through shutdown
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-socket.h with sendrec=
vmsg and message
>>      structures
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_bsd_setsockopt and so=
cket option definitions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_bsd_getsockopt
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD socket helpers a=
nd sockaddr conversion
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-socket.c with cmsg co=
nversion functions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add socket system call dispa=
tch
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-time.h with clock and=
 time-of-day functions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add utimes, futimes, and kti=
mer functions to os-time.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add select, pselect, and ppo=
ll to os-time.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add kqueue and kevent functi=
ons to os-time.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add sigtimedwait, itimer, an=
d futimens to os-time.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-time.c and time-relat=
ed type definitions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add time system call dispatc=
h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add thread, umtx, and ACL ty=
pe definitions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add cpu_copy and make init_t=
ask_state non-static
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-thread.h with thr and=
 context functions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_freebsd__umtx_op to o=
s-thread.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-thread.c with umtx, m=
utex, and thread creation
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add thread system call dispa=
tch
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-extattr.h with file a=
nd fd extattr functions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add link and list extattr fu=
nctions to os-extattr.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add ACL system call shims to=
 os-extattr.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-extattr.c with ACL co=
nversion functions
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add extended attribute and A=
CL system call dispatch
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add scheduler and cpuset fun=
ctions to os-misc.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add kmod, posix, and misc fu=
nctions to os-misc.h
>>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add scheduler, cpuset, kmod,=
 and misc syscall dispatch
>>      >
>>      >=C2=A0 bsd-user/aarch64/target.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 2 +-
>>      >=C2=A0 bsd-user/arm/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 2 +-
>>      >=C2=A0 bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 164 +++-
>>      >=C2=A0 bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 4 +-
>>      >=C2=A0 bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A024 +-
>>      >=C2=A0 bsd-user/bsd-signal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 231 ++++++
>>      >=C2=A0 bsd-user/bsd-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A098 +++
>>      >=C2=A0 bsd-user/bsd-socket.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 283 +++++++
>>      >=C2=A0 bsd-user/freebsd/meson.build=C2=A0 |=C2=A0 =C2=A0 8 +-
>>      >=C2=A0 bsd-user/freebsd/os-extattr.c |=C2=A0 116 +++
>>      >=C2=A0 bsd-user/freebsd/os-extattr.h |=C2=A0 662 ++++++++++++++++
>>      >=C2=A0 bsd-user/freebsd/os-file.h=C2=A0 =C2=A0 |=C2=A0 129 ++++
>>      >=C2=A0 bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 |=C2=A0 470 ++++++=
+++++-
>>      >=C2=A0 bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +=
-
>>      >=C2=A0 bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 |=C2=A0 =C2=A026 +=
-
>>      >=C2=A0 bsd-user/freebsd/os-signal.h=C2=A0 |=C2=A0 =C2=A020 +
>>      >=C2=A0 bsd-user/freebsd/os-socket.c=C2=A0 |=C2=A0 234 ++++++
>>      >=C2=A0 bsd-user/freebsd/os-socket.h=C2=A0 |=C2=A0 770 +++++++++++=
++++++++
>>      >=C2=A0 bsd-user/freebsd/os-stat.h=C2=A0 =C2=A0 |=C2=A0 =C2=A0 8 +=
-
>>      >=C2=A0 bsd-user/freebsd/os-sys.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 4 +-
>>      >=C2=A0 bsd-user/freebsd/os-syscall.c |=C2=A0 790 ++++++++++++++++=
+--
>>      >=C2=A0 bsd-user/freebsd/os-thread.c=C2=A0 | 1682 ++++++++++++++++=
++++++++++++
>>      +++++++++++++
>>      >=C2=A0 bsd-user/freebsd/os-thread.h=C2=A0 |=C2=A0 596 +++++++++++=
++++
>>      >=C2=A0 bsd-user/freebsd/os-time.c=C2=A0 =C2=A0 |=C2=A0 346 ++++++=
+++
>>      >=C2=A0 bsd-user/freebsd/os-time.h=C2=A0 =C2=A0 |=C2=A0 983 ++++++=
++++++++++++++++++
>>      >=C2=A0 bsd-user/freebsd/qemu-os.h=C2=A0 =C2=A0 |=C2=A0 =C2=A048 +=
+
>>      >=C2=A0 bsd-user/i386/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 2 +-
>>      >=C2=A0 bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A032 +-
>>      >=C2=A0 bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 1 +
>>      >=C2=A0 bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A026 +
>>      >=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A048 +-
>>      >=C2=A0 bsd-user/riscv/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 2 +-
>>      >=C2=A0 bsd-user/signal-common.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 4 +
>>      >=C2=A0 bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A067 ++
>>      >=C2=A0 bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
458 +++++++++--
>>      >=C2=A0 bsd-user/x86_64/target.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 2 +-
>>      >=C2=A0 36 files changed, 8150 insertions(+), 196 deletions(-)
>>      > ---
>>      > base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
>>      > change-id: 20260504-misc-2026q2-a5af31ac032a
>>      >
>>      > Best regards,
>>
>>      After reviewing (what I can) two thirds of the series, I don't fee=
l very
>>      at ease with validating the rest. Not that there is problem in its=
elf,
>>      but it's a massive add, and I'm not sure how we can ensure it's
>>      implemented correctly without any test exercising it.
>>      It's not particular to bsd-user, linux-user does not have test for=
 all
>>      syscalls implemented neither.
>>
>>
>> Yes. I'd like a low-level test like that. The upstream bsd-user has bee=
n too
>> incomplete to run real programs prior to this series. And there's still=
 some
>> issues that remain after these system calls (which is next up on my lis=
t: I
>> think elfload needs some patches for PIE).
>>  =20
>>
>>      However, because we are adding most of it at once, it's a bit diff=
erent.
>>      Dropping 8150 new lines at once without any test looks a bit compl=
icated
>>      to me.
>>
>>      A few questions about the series in itself:
>>      - Where does most of the implementation comes from? Was it downstr=
eam on
>>      FreeBSD side, or written from scratch for this series?
>>
>>
>> We've had almost all of this code, modulo some big fixes I've added,=C2=
=A0 in
>> blitz branch
>> for years. Stacey Son implemented most of this a decade ago now and had=
 some
>> issue upstream at the time, IIRC, but I have only sketchy details of th=
e
>> project then.
>>
>> We use it inside our poudriere jails to build thousands of ports to tes=
t
>> it. Though there are issues with many ports, enough work to keep going.

So, this seems to be similar to what I do, and it's actually a good test c=
ase for linux-user.
I'm running some debian buildd servers which use qemu-hppa to build debian=
 packages
for the hppa architecture. With that setup I found quite some bugs in qemu=
-user
and now it's pretty stable.

>> I also run a number of random commands in the jail that's nothing but
>> cross-arch binaries
>> as well.
>>
>=20
> That's good to hear this has been used downstream for a long time. That
> was my feeling after our conversation, but just wanted to double check t=
his.
>=20
>> Sometimes I run the Kyua tests, but it's a bit hard to read the output
>> because many are broken,
>> many can't work in qemu or in a jail, and there's some that are broken
>> for a given arch. We don't
>> have good baselines to compare against and I've not spent the time to
>> get this into good shape.
>>
>> Not the most formal set of things we do, but it works.
>>  =20
>>
>>      - How did you validate it works, beyond it compiles?
>>
>>
>> Generally on the blitz side, all of the above. On the qemu-project side=
,
>> I usually just do the bit
>> about messing around in the jail to test the basics.
>>
>> I'm happy cleaving this massive set into some smaller sets if that woul=
d
>> help, but that still wouldn't
>> answer the 'how the heck do we test it'.
>>
>=20
> It would require a massive effort for no benefit, since it doesn't
> increase testability of the whole.
>=20
>> I've also had claude do code reviews of this branch. It's found maybe
>> 100 bugs that I've fixed
>> (maybe 25 more between v2 and v3). The vast majority of the bugs are
>> lock/unlock issues. Either
>> leaks on error paths, failure to check for TARGET_EFAULT in places or
>> passing args that don't
>> matter unless you compile CONFIG_DEBUG_REMAP to indicate copying, etc.
>> Some real bugs
>> have been found, including one that might lead to a multi-threaded hang=
.
>>
>=20
> This is better than nothing, and it's a common usage I have with Claude
> too. I just hope the industry does not settle on "let the AI review"
> instead of test/cover approach.
>=20
>> I have been putting off dealing with the PIE issue which blocks buildin=
g
>> most ports at the moment,
>> but there's two pull requests to address it in blitz. When I tried them
>> I hit some problems, but
>> maybe I've fixed those in other ways. If I fixed that, I'd know that th=
e
>> base code works, but
>> maybe all the pieces aren't in qemu-project yet.
>>
>> Based on all that, what's your advice?
>>
>=20
> In an ideal world, I would advise to upstream the minimum to be able to
> run hello-world. Once done, add tests for all existing syscalls.
> Then add new syscalls with their tests. I tend to think that good code
> is not the one being the most elegant/performant, but the one that you
> can modify with trust in what you did, which means covered by a test.
>=20
> In the real world, seems like we don't really have another option than
> taking it, except if you're ready to spend 6 months to add tests for
> this series. I'll let other reviewers finish the work for this series.
>=20
> I'm not against the pragmatic approach of taking it, and let it be
> tested on the field.=20

+1 from me.

> It would be unfair considering how the rest of QEMU is not always tested=
.

True.

Helge

