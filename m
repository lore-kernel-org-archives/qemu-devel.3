Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F0E63F21
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 01:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrnAf-00057C-0w; Sun, 15 Feb 2026 20:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vrnAb-000572-W0
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 20:13:02 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vrnAZ-0006sh-El
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 20:13:01 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 c9df4d7d81c51f612bc6d719256d83bf1e2291941ef015ac3bbbf3455704683e with SMTP id
 69926f10f47733397cf01b64; Mon, 16 Feb 2026 01:12:48 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1771204367;
 bh=V74aTczj7tA03dQavbJYRZd2eyGTw+qEahtBzo9SImM=;
 h=Message-ID:Date:MIME-Version:Subject:X-Mailgun-Dkim:From:To:Cc:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:From:
 Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=D3ynC/qDRFOu/fxbZgghkNVOo20SNMG0SHXpeedQ9/NzcTfDypwVPgHV6K9b5Mknu
 cu4o+8BeHfT6iyuIq9XXYlEPM7aMkak/lBR2yb7DZETwIuFrofotTlDF//yUrhoTKv
 MsU1tjRO3kBmWsZCYWy5hRyJy4qyAWo9fdrEZE+QwbHHtwoh4rf0ZE7A+ZoIZuvf7m
 wfFwZEcja7paJRLUudpMKgBnmsir2veNbUzvDCbvEnShnka3MKdgmaPoejwb3wIWzz
 vktGOikQJilGMk9zulePgl2A+uSl1Tumq0rL2MJ1tAPzPi/MSaBpRB5Cp7oiS79mQB
 KiYGTBlzqH9+A==
Message-ID: <7dfb9920-540b-4586-afc6-a60bb96c2921@yodel.dev>
Date: Sun, 15 Feb 2026 19:12:45 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "rcu: Unify force quiescent state"
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jim MacArthur <jim.macarthur@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260209120336.41454-1-thuth@redhat.com>
 <0e63016c-2ca3-4074-8a5e-db46f22d8eda@linaro.org>
 <745fbb72-a977-4ec4-84ea-eefc33cf33a8@rsg.ci.i.u-tokyo.ac.jp>
 <f64415bf-8c89-47ff-95b7-f362d51dc9bf@yodel.dev>
Content-Language: en-US
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <f64415bf-8c89-47ff-95b7-f362d51dc9bf@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

+rth (maintainer: accel/tcg/tcg-accel-ops-rr.c)

Hi,

On 11/02/2026 09:12, Yodel Eldar wrote:
> +Ilya (author of mentioned commit)
> 
> Hi, all
> 
> On 10/02/2026 05:14, Akihiko Odaki wrote:
>> On 2026/02/10 20:04, Jim MacArthur wrote:
>>> On 2/9/26 12:03, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.
>>>>
>>>> The commit introduced a regression in the replay functional test
>>>> on alpha (tests/functional/alpha/test_replay.py), that causes CI
>>>> failures regularly. Thus revert this change until someone has
>>>> figured out what is going wrong here.
>>>>
>>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3197
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   I just hit this again in the CI:
>>>>   https://gitlab.com/thuth/qemu/-/jobs/13018713844
>>>>   ... it's annoying, so I'd like to suggest to revert the offending
>>>>   patch 'til someone fixed this.
>>>>
>>>
>>> Hi Thomas,
>>>
>>> I am actively investigating this problem, but haven't made any 
>>> important progress so far. It's looking like a timing bug which is 
>>> annoying to track down. All I know for certain at the moment is that 
>>> faking some of the values returned by qemu_clock_get_ns to be 
>>> deterministic improves the failure rate, but does not remove it 
>>> entirely. I'm fine with this being reverted for now; we can add it 
>>> back in once we figure out what the true cause is.
>>
>> Thanks for investigating this. Let's have the commit reverted until 
>> there is some progress:
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
> 
> After the quiescence commit, timeouts were the only regression, until
> f098c32db48 ("target/s390x: Fix infinite loop during replay") when the
> replay test began failing with error, too; maybe this serves as a
> diagnostic trigger?
> 
> Yodel
> 

Seems like the force_rcu notifier in rr tcg became incompatible with
record/replay after Akihiko's patch; preventing registration of the
notifier when in record/replay mode appears to fix the problem:

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f84342e044..2073b1b13e 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -179,13 +179,15 @@ static int rr_cpu_count(void)

  static void *rr_cpu_thread_fn(void *arg)
  {
-    Notifier force_rcu;
      CPUState *cpu = arg;

      assert(tcg_enabled());
      rcu_register_thread();
-    force_rcu.notify = rr_force_rcu;
-    rcu_add_force_rcu_notifier(&force_rcu);
+    if (replay_mode == REPLAY_MODE_NONE) {
+        Notifier force_rcu;
+        force_rcu.notify = rr_force_rcu;
+        rcu_add_force_rcu_notifier(&force_rcu);
+    }
      tcg_register_thread();

      bql_lock();

as confirmed by running:
     meson test --setup thorough --no-rebuild -t 0 \
        --num-processes 1 --repeat 100 func-alpha-replay

I'd like to do some additional testing/analysis to make sure this
doesn't just trade one bug for another as I continue to study the
internals of RCU and replay/record, but any comments regarding the above
fix would be much appreciated.

E.g., could we continue using a force_rcu notifier with record/replay if
we added an async replay event for it, or by some other means?
Should we?

Furthermore, mttcg also uses a force_rcu notifier, but record/replay
isn't supported with multiple CPUs, so are we really in the clear there?

Also, the issue that firstly motivated rr_force_rcu():
     https://gitlab.com/qemu-project/qemu/-/issues/650
doesn't appear at first glance to occur in record/replay mode when the
notifier isn't registered during record/replay; is that thanks to
Akihiko's patch or was that never a problem in record/replay mode?
Side note: eliminating the force_rcu notifier for non-record/replay mode
does cause the same regression as in issue #650; i.e., rr_force_rcu is
still seemingly necessary outside of replay/record mode.

Here's the backtrace of qemu-system-alpha as it hangs in replay mode:
------------------------------------------------------------------------
Thread 4 (Thread 0x7f2b841ff6c0 (LWP 7653) "qemu-system-alp"):
#0  0x00007f2b88c0906d in syscall () at /usr/lib/libc.so.6
#1  0x000055692672e554 in qemu_futex_wait (f=0x556926ca6670 
<rcu_call_ready_event>, val=0xffffffff) at /qemu/include/qemu/futex.h:47
#2  0x000055692672e768 in qemu_event_wait (ev=0x556926ca6670 
<rcu_call_ready_event>) at ../util/event.c:162
#3  0x000055692673a87e in call_rcu_thread (opaque=0x0) at ../util/rcu.c:304
#4  0x000055692672d032 in qemu_thread_start (args=0x556965cbd7b0) at 
../util/qemu-thread-posix.c:393
#5  0x00007f2b88b8797a in ??? () at /usr/lib/libc.so.6
#6  0x00007f2b88c0b2bc in ??? () at /usr/lib/libc.so.6

Thread 3 (Thread 0x7f2b831fe6c0 (LWP 7654) "qemu-system-alp"):
#0  0x00007f2b88b8ff32 in ??? () at /usr/lib/libc.so.6
#1  0x00007f2b88b8439c in ??? () at /usr/lib/libc.so.6
#2  0x00007f2b88b843e4 in ??? () at /usr/lib/libc.so.6
#3  0x00007f2b88bfe2f6 in ppoll () at /usr/lib/libc.so.6
#4  0x00007f2b8a690784 in ??? () at /usr/lib/libglib-2.0.so.0
#5  0x00007f2b8a690a17 in g_main_loop_run () at /usr/lib/libglib-2.0.so.0
#6  0x0000556926565683 in iothread_run (opaque=0x556965d17c70) at 
../iothread.c:70
#7  0x000055692672d032 in qemu_thread_start (args=0x556965cf46e0) at 
../util/qemu-thread-posix.c:393
#8  0x00007f2b88b8797a in ??? () at /usr/lib/libc.so.6
#9  0x00007f2b88c0b2bc in ??? () at /usr/lib/libc.so.6

Thread 2 (Thread 0x7f2b821fd6c0 (LWP 7655) "qemu-system-alp"):
#0  0x00007f2b88b8ff32 in ??? () at /usr/lib/libc.so.6
#1  0x00007f2b88b8439c in ??? () at /usr/lib/libc.so.6
#2  0x00007f2b88b8468c in ??? () at /usr/lib/libc.so.6
#3  0x00007f2b88b86e5e in pthread_cond_wait () at /usr/lib/libc.so.6
#4  0x000055692672c9ee in qemu_cond_wait_impl (cond=0x556965e6df40, 
mutex=0x556926c821e0 <bql>, file=0x55692683204f "../system/cpus.c", 
line=0x24e) at ../util/qemu-thread-posix.c:225
#5  0x000055692630728b in qemu_cond_wait_bql (cond=0x556965e6df40) at 
../system/cpus.c:590
#6  0x000055692643b864 in rr_wait_io_event () at 
../accel/tcg/tcg-accel-ops-rr.c:114
#7  0x000055692643bcc5 in rr_cpu_thread_fn (arg=0x556965e69aa0) at 
../accel/tcg/tcg-accel-ops-rr.c:235
#8  0x000055692672d032 in qemu_thread_start (args=0x556965cf2ea0) at 
../util/qemu-thread-posix.c:393
#9  0x00007f2b88b8797a in ??? () at /usr/lib/libc.so.6
#10 0x00007f2b88c0b2bc in ??? () at /usr/lib/libc.so.6

Thread 1 (Thread 0x7f2b8690f180 (LWP 7652) "qemu-system-alp"):
#0  0x00007f2b88b8ff32 in ??? () at /usr/lib/libc.so.6
#1  0x00007f2b88b8439c in ??? () at /usr/lib/libc.so.6
#2  0x00007f2b88b843e4 in ??? () at /usr/lib/libc.so.6
#3  0x00007f2b88bfe2f6 in ppoll () at /usr/lib/libc.so.6
#4  0x000055692674d35a in qemu_poll_ns (fds=0x5569667017a0, nfds=0x5, 
timeout=0x3b597370) at ../util/qemu-timer.c:343
#5  0x00005569267485ee in os_host_main_loop_wait (timeout=0x3b597370) at 
../util/main-loop.c:308
#6  0x0000556926748740 in main_loop_wait (nonblocking=0x0) at 
../util/main-loop.c:592
#7  0x0000556926335226 in qemu_main_loop () at ../system/runstate.c:903
#8  0x000055692665e8cf in qemu_default_main (opaque=0x0) at 
../system/main.c:50
#9  0x000055692665e989 in main (argc=0x19, argv=0x7ffdb6f6f898) at 
../system/main.c:93
------------------------------------------------------------------------

Interestingly, the `shift` value used in the alpha replay test's
`-icount` option somewhat sneakily complicated debugging: When `shift`
is greater than eight (it's currently nine), both TIMEOUTs and ERRORs
would occur in `meson test ... func-alpha-replay` (after f098c32db48),
but when `shift` is lowered, only TIMEOUTs occur. With my fix, neither
occurs regardless of the `shift` value, but the kernel still seems to
mind as seen when given an initrd [1]:

     ./qemu-system-alpha -initrd ./initrd.gz \
         -machine clipper \
         -kernel ./vmlinuz \
         -append 'console=ttyS0' \
         -icount shift=9,rr=record,rrfile=replay.bin \
         -nographic -net none

yielding this printk:

     BUG: soft lockup - CPU#0 stuck for 61s! [udevd:219]

Is there an important reason why we set `shift=9` in the test?
If not, maybe we should lower it, too, while we're at it?

Please let me know if there's any other information that would be
helpful with resolving this bug in the best way possible once and for
all; I did quite a bit of testing/debugging over the last couple of days
and would be happy to share more of the results/methodology.

Thomas and Akihiko, if it's alright with you, could we delay the PR of
the revert at least until we sort this out? I realize the erratic
timeouts are gumming up the CI, but maybe we could reduce the deltas of
the git history in short order if it's not too much trouble? I can
submit the patch in one to two days; I just want to make sure it's done
correctly.

[1] 
https://archive.debian.org/debian/dists/lenny/main/installer-alpha/20090123lenny10/images/cdrom/initrd.gz

Thanks,
Yodel


