Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB81E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVt5K-0002Ty-W8; Thu, 09 Jan 2025 09:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@weiser.dinsnail.net>)
 id 1tVt5G-0002T9-BE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:00:28 -0500
Received: from heinz.dinsnail.net ([85.214.221.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@weiser.dinsnail.net>)
 id 1tVt5E-0006TV-4Y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:00:26 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
 by heinz.dinsnail.net (8.18.0.2/8.18.0.2) with ESMTP id 509E07t1001005;
 Thu, 9 Jan 2025 15:00:07 +0100
Received: from eldalonde.UUCP (uucp@localhost)
 by heinz.dinsnail.net (8.18.0.2/8.18.0.2/Submit) with bsmtp id 509E05iT001004; 
 Thu, 9 Jan 2025 15:00:05 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1]
 (may be forged))
 by eldalonde.weiser.dinsnail.net (8.18.0.2/8.18.0.2) with ESMTP id
 509DwrGb022989; Thu, 9 Jan 2025 14:58:53 +0100
Received: (from michael@localhost)
 by eldalonde.weiser.dinsnail.net (8.18.0.2/8.18.0.2/Submit) id 509DwrEO022988; 
 Thu, 9 Jan 2025 14:58:53 +0100
Date: Thu, 9 Jan 2025 14:58:53 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Hank Knox <hank.knox@mcgill.ca>
Subject: Re: [PULL 11/13] ui/console: Remove dpy_cursor_define_supported()
Message-ID: <Z3_WHQI3GMepJkxp@weiser.dinsnail.net>
References: <20240716180941.40211-1-philmd@linaro.org>
 <20240716180941.40211-12-philmd@linaro.org>
 <f0b1df5e-4eee-4a56-a8a0-5426cdf2b3d5@tls.msk.ru>
 <CAAibmn1FQgHwt4LapR1gJzyue4bf7Uhbua0sxGg+PxaEjR0Row@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAibmn1FQgHwt4LapR1gJzyue4bf7Uhbua0sxGg+PxaEjR0Row@mail.gmail.com>
X--MailScanner-Information: Please contact the ISP for more information
X--MailScanner-ID: 509E07t1001005
X--MailScanner: Found to be clean
X--MailScanner-From: michael@weiser.dinsnail.net
Received-SPF: pass client-ip=85.214.221.163;
 envelope-from=michael@weiser.dinsnail.net; helo=heinz.dinsnail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Hank, Michael, Phil,

> > > Remove dpy_cursor_define_supported() as it brings no benefit today and
> > > it has a few inherent problems.

commit 4bba839808bb1c4f500a11462220a687b4d9ab25
Author: Akihiko Odaki <akihiko.odaki@daynix.com>
Date:   Mon Jul 15 14:25:45 2024 +0900

    ui/console: Remove dpy_cursor_define_supported()

> > Apparently this commit made windows10 guest to freeze.  There's a rather
> > hairy bugreport at https://bugs.debian.org/1084199 .  Also there's an
> > interesting bug filed against qemu,
> > https://gitlab.com/qemu-project/qemu/-/issues/1628 ,
> > which seems to be relevant.

Thanks for looking into this! I am now also affected by this bug and
highly motivated to resolve it. :)

I recently updated my Gentoo Linux system which included an update of
qemu from 9.0.2 to 9.2.0. After that I began to experience the issue
reported by Hank with a Windows 10 VM in libvirt using QXL graphics with
SPICE in virt-viewer. The Windows is fully updated and I've tried
installing the most recent guest drivers to no avail
(virtio-win-0.1.266.iso).

I've reconfirmed the issue with a freshly installed Windows 11, fully
updated and the same driver ISO.

Downgrading to 9.0.4 makes it go away. Downgrading to 9.1.2 does not.
Reverting above commit off of 9.2.0 as a custom patch to the Gentoo
package makes it go away as well.

At this point I grabbed the git repo and started another bisect between
9.0.0 and 9.1.0. During that I found a good "reproducer" to be to
frantically click on all the application icons on my desktop as fast as
possible (Firefox, Edge, LibreOffice, Chrome and PuTTY, FWIW). Apart
from a lot of CPU load, disk I/O and memory pressure it also causes
frequent cursor changes from pointer to spinning wheel to pointer with
spinning wheel. If nothing else, it helps pass the time to the freeze.
:)

With that I ended up at exactly the same commit as Hank found above.
Reverting that commit off of current devel HEAD makes the problem go
away as well. With vanilla devel HEAD the freezes persist/come back.

I can also confirm that the issue has to do with scaling of Windows UI
elements. At 100% the freezes to not appear (or at least not so I can
trigger them with my "reproducer"). At 150% or 200% scaling I can
trigger them quite quickly (< 30s).

Also, identically to Hank's findings, the VM continues to respond to
ICMP requests (ping) as well as agent requests from virsh (e.g.
guestinfo). A shutdown command however hangs/times out.

On Tue, Oct 29, 2024 at 03:04:29PM +0100, Phil Dennis-Jordan wrote:

> Can we get the user to set qxl->debug to a value > 1 and see if the freeze
> coincides with logging from here? (Possibly tricky to intercept the fprintf
> output from Qemu run via libvirt though.)

How would I do that? On the source level or is there an environment
variable/command line option?

> Given that "The time before the freeze seems to be random, from a few
> seconds to a couple of minutes." there is a possibility of a false
> negative during the bisect. (i.e. commit marked GOOD that should be BAD
> because it happened to not hit the freeze in the usual time)

I went to the commit before this one and the issue disappeared. Also the
positive effect of reverting it off of HEAD seems to suggest that if not
the main culprit it at least makes the possibly underlying issue
surface.

> We could ask the user to check whether there's any connection with mouse
> cursor changes, e.g. whether he can more easily provoke the issue by
> perform actions that rapidly change the mouse cursor. (For example by
> visiting https://developer.mozilla.org/en-US/docs/Web/CSS/cursor in the
> guest and moving back and forth over the test area.)

I've extracted the IFrame URL
https://interactive-examples.mdn.mozilla.net/pages/css/cursor.html from
this and played with it for some time.

On an idling system the cursor changes do not seem to be enough to
trigger the issue. Once I start to put load on the system by starting
applications as per my "reproducer" I can no longer be sure if and how
cursor changes play into it because lots of windows start popping up.
All hangs I can remember have been showing the segmented spinning blue
wheel animated cursor though.

> Is there an easy way to take a sampling profile on Linux that will show us
> stack traces of all the threads in the frozen Qemu process? On macOS this
> is easy with the Activity Monitor GUI or iprofiler on the command line.
> That ought to confirm whether it's a deadlock or indefinite wait in some
> Qemu subsystem.

The stuck qemu still does things at about 3% CPU load.
I can attach to it with gdb and pull the thread list below.
Do any of those look interesting to you?

(gdb) info threads
  Id   Target Id                                            Frame 
* 1    Thread 0x7f0eada740c0 (LWP 741887) "qemu-system-x86" 0x00007f0eaf73e656 in ppoll () from /usr/lib64/libc.so.6
  2    Thread 0x7f0ccdffb6c0 (LWP 742004) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  3    Thread 0x7f0cceffd6c0 (LWP 742002) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  4    Thread 0x7f0ced7fa6c0 (LWP 741998) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  5    Thread 0x7f0cee7fc6c0 (LWP 741996) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  6    Thread 0x7f0ceffff6c0 (LWP 741993) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  7    Thread 0x7f0d0d7fa6c0 (LWP 741991) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  8    Thread 0x7f0d0e7fc6c0 (LWP 741989) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  9    Thread 0x7f0d0f7fe6c0 (LWP 741987) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  10   Thread 0x7f0d2d7fa6c0 (LWP 741984) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  11   Thread 0x7f0d2f7fe6c0 (LWP 741980) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  12   Thread 0x7f0d2ffff6c0 (LWP 741917) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  13   Thread 0x7f0d514f76c0 (LWP 741915) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  14   Thread 0x7f0d52cfa6c0 (LWP 741912) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  15   Thread 0x7f0d534fb6c0 (LWP 741911) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  16   Thread 0x7f0d53cfc6c0 (LWP 741910) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  17   Thread 0x7f0d591986c0 (LWP 741905) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  18   Thread 0x7f0d6531e6c0 (LWP 741902) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
  19   Thread 0x7f0d9afff6c0 (LWP 741900) "SPICE Worker"    0x00007f0eaf73e656 in ppoll () from /usr/lib64/libc.so.6
  20   Thread 0x7f0ea89ff6c0 (LWP 741898) "CPU 1/KVM"       0x00007f0eaf74534f in ioctl () from /usr/lib64/libc.so.6
  21   Thread 0x7f0ea95a96c0 (LWP 741897) "CPU 0/KVM"       0x00007f0eaf74534f in ioctl () from /usr/lib64/libc.so.6
  22   Thread 0x7f0ea9daa6c0 (LWP 741896) "IO mon_iothread" 0x00007f0eaf73e656 in ppoll () from /usr/lib64/libc.so.6
  23   Thread 0x7f0eada740c0 (LWP 741895) "vhost-741887"    0x0000000000000000 in ?? ()
  24   Thread 0x7f0eada740c0 (LWP 741894) "kvm-nx-lpage-re" 0x0000000000000000 in ?? ()
  25   Thread 0x7f0eab8356c0 (LWP 741892) "qemu-system-x86" 0x00007f0eaf74776d in syscall () from /usr/lib64/libc.so.6

This is right after the display gets stuck. The workers die down over time.

> Michael, what's the situation with the patch you suggested in your comment
> on the Qemu bug:
> https://gitlab.com/qemu-project/qemu/-/issues/1628#note_2144606625 ? Is
> there any chance we can get the Debian user to try that?

This patch on top of current devel HEAD (as well as directly on top of
the commit in question) makes it worse: The freezes start happening
immediately after the desktop shell is started. I think I've even seen it
freeze when the boot logo and spinner were still showing, possibly when
the (also scaled) login screen tries to initialise.

I'm out of my depth further narrowing down the cause and standing by to
try whatever you tell me.
-- 
Thanks,
Michael

