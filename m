Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6024C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2rV-0006yY-TZ; Fri, 31 May 2024 10:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD2rU-0006xx-AU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:04:04 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD2rE-0001va-PL
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:04:04 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a98so1142772a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717164226; x=1717769026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAn80M9PCP2HHKd7EHvt0EJ/fTF8KPYuOVNq1RAFMTU=;
 b=fflPk7+BQYNaclfur8YweLy+e8OF0HQVqTHRaKt5cWsf+Pi7Rp1g4PNiwUGlvcb8Uf
 66OR4GK1DJsYxtCvJ6Hr4NCNb6UMoOgDEaQszLjXoUmFCqeURfTydkgy+yW/mt3A12Rl
 YjX+ZjwhX06l4wyHWe4lQ+zdnZI7xIjpZUwMzD2rND4zx+VXuEqqjgbyEIpug8cdKN2S
 mJpZuLveXFEGO+tHOlbrHQMmbOTBqSLjsQCTmzztZrfbv/aapLVTohL9ZU7bV8TqGtZ0
 ACzs/z5TXrAtqpuj/Gdw8T7RS3kn3nsiDcAKsg4PpC6eOf8+5TcnzKVOvbuKAk1PP9HM
 VgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717164226; x=1717769026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAn80M9PCP2HHKd7EHvt0EJ/fTF8KPYuOVNq1RAFMTU=;
 b=js359xJASfq6o6cD4yq+yUu2B4YMbQQEWhIjJdywUtqZoHW24xAtwbHyvXPFhXNYjx
 HdgPmB6OnN+6aOodPVn2Xq6tW1L186YUGTlOR7MgYHHth1rLRKpWbPqs+vReRTgjaOrC
 a7TZIbl6n4vtnLrmbxIaBlPDYW3VB8/eYa4UgLd2YJcnMO3FqeE2zApiaPAx49xfOKOV
 zpd1vRbc2RnWetY9Yv3gHFiswW53WzXA9Tb4zKLreVycFFyocZxYXCz1noTZ+zffY3Bq
 ll1WWkuJYmA8iqNKZrtpRU7F1ppEo9u/eUV5vCAwD8SXTE6ED/lY9k9zsOTN3VNqRqTd
 68aA==
X-Gm-Message-State: AOJu0Yy9eKC9erGT/eYauP2pYEJU4kbyF6CWD/khYX15ftFdGkadP7dp
 TdWF54ija5/QcTDNDbUvC1uvApXmJJp3MWBqY3IQJSjqNUVAKMJGW7tTIuNMp2sl+jWSykpKvZZ
 +8G9AtFiPWftoQrsoLBAp7Zpo0lv7DUciuAbT7Q==
X-Google-Smtp-Source: AGHT+IEyrAq3q7GSvc+rxvQGc1YaZOACkDsXJyxlEM4gKfj7Bd1Xxo8kON97lvHoo27mN5WdI/Rkun+7zDPj30w8T2E=
X-Received: by 2002:a50:9f62:0:b0:578:695d:d78f with SMTP id
 4fb4d7f45d1cf-57a3637700dmr1492521a12.15.1717164225908; Fri, 31 May 2024
 07:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
In-Reply-To: <20240520232634.317988-1-dmamfmgm@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 15:03:33 +0100
Message-ID: <CAFEAcA8JFMid+SeHWuoaK9meVWwgch9wwzKmT4SFUXz4U_iacw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: David Hubbard <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 21 May 2024 at 00:26, David Hubbard <dmamfmgm@gmail.com> wrote:
>
> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the way the ohci emulation handles a Transfer Descriptor with
> "Current Buffer Pointer" set to "Buffer End" + 1.
>
> The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than td.be
> to signal the buffer has zero length. Currently qemu only accepts zero-length
> Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI hardware
> accepts both cases.
>
> The qemu ohci emulation has a regression in ohci_service_td. Version 4.2
> and earlier matched the spec. (I haven't taken the time to bisect exactly
> where the logic was changed.)
>
> With a tiny OS[1] that boots and executes a test, the issue can be seen:
>
> * OS that sends USB requests to a USB mass storage device
>   but sends td.cbp = td.be + 1
> * qemu 4.2
> * qemu HEAD (4e66a0854)
> * Actual OHCI controller (hardware)
>
> Command line:
> qemu-system-x86_64 -m 20 \
>  -device pci-ohci,id=ohci \
>  -drive if=none,format=raw,id=d,file=testmbr.raw \
>  -device usb-storage,bus=ohci.0,drive=d \
>  --trace "usb_*" --trace "ohci_*" -D qemu.log
>
> Results are:
>
>  qemu 4.2   | qemu HEAD  | actual HW
> ------------+------------+------------
>  works fine | ohci_die() | works fine
>
> Tip: if the flags "-serial pty -serial stdio" are added to the command line
> the test will output USB requests like this:
>
> Testing qemu HEAD:
>
> > Free mem 2M ohci port2 conn FS
> > setup { 80 6 0 1 0 0 8 0 }
> > ED info=80000 { mps=8 en=0 d=0 } tail=c20920
> >   td0 c20880 nxt=c20960 f2000000 setup cbp=c20900 be=c20907
> >   td1 c20960 nxt=c20980 f3140000    in cbp=c20908 be=c2090f
> >   td2 c20980 nxt=c20920 f3080000   out cbp=c20910 be=c2090f ohci20 host err
> > usb stopped
>
> And in qemu.log:
>
> usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=0x00c20910 > next_offset=0x00c2090f
>
> Testing qemu 4.2:
>
> > Free mem 2M ohci port2 conn FS
> > setup { 80 6 0 1 0 0 8 0 }
> > ED info=80000 { mps=8 en=0 d=0 } tail=620920
> >   td0 620880 nxt=620960 f2000000 setup cbp=620900 be=620907       cbp=0 be=620907
> >   td1 620960 nxt=620980 f3140000    in cbp=620908 be=62090f       cbp=0 be=62090f
> >   td2 620980 nxt=620920 f3080000   out cbp=620910 be=62090f       cbp=0 be=62090f
> >    rx { 12 1 0 2 0 0 0 8 }
> > setup { 0 5 1 0 0 0 0 0 } tx {}
> > ED info=80000 { mps=8 en=0 d=0 } tail=620880
> >   td0 620920 nxt=620960 f2000000 setup cbp=620900 be=620907       cbp=0 be=620907
> >   td1 620960 nxt=620880 f3100000    in cbp=620908 be=620907       cbp=0 be=620907
> > setup { 80 6 0 1 0 0 12 0 }
> > ED info=80001 { mps=8 en=0 d=1 } tail=620960
> >   td0 620880 nxt=6209c0 f2000000 setup cbp=620920 be=620927       cbp=0 be=620927
> >   td1 6209c0 nxt=6209e0 f3140000    in cbp=620928 be=620939       cbp=0 be=620939
> >   td2 6209e0 nxt=620960 f3080000   out cbp=62093a be=620939       cbp=0 be=620939
> >    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
> > setup { 80 6 0 2 0 0 0 1 }
> > ED info=80001 { mps=8 en=0 d=1 } tail=620880
> >   td0 620960 nxt=6209a0 f2000000 setup cbp=620a20 be=620a27       cbp=0 be=620a27
> >   td1 6209a0 nxt=6209c0 f3140004    in cbp=620a28 be=620b27       cbp=620a48 be=620b27
> >   td2 6209c0 nxt=620880 f3080000   out cbp=620b28 be=620b27       cbp=0 be=620b27
> >    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2 40 0 0 }
> > setup { 0 9 1 0 0 0 0 0 } tx {}
> > ED info=80001 { mps=8 en=0 d=1 } tail=620900
> >   td0 620880 nxt=620940 f2000000 setup cbp=620a00 be=620a07       cbp=0 be=620a07
> >   td1 620940 nxt=620900 f3100000    in cbp=620a08 be=620a07       cbp=0 be=620a07
>
> [1] The OS disk image has been emailed to philmd@linaro.org, mjt@tls.msk.ru,
> and kraxel@redhat.com:
>
> * testCbpOffBy1.img.xz
> * sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed
>
> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> ---
>  hw/usb/hcd-ohci.c   | 4 ++--
>  hw/usb/trace-events | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index acd6016980..71b54914d3 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
>          if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
>              len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>          } else {
> -            if (td.cbp > td.be) {
> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp != 0 */
> +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
>                  ohci_die(ohci);
>                  return 1;
>              }

This patch seems to me to do what the commit message sets out to
do, and it looks unlikely to have any unintended side effects
because it turns a "USB controller flags an error" case into
a "treat as zero length packet" case, and I have trouble
imagining that any guest could be relying on looking for the
controller error. On that basis I'm inclined to accept it.

What I would like to see is what we could classify under
"rationale", which is to say "what prompted us to make this
change?". In my experience it's important to record this
(including in the commit message). There are of course
many cases in QEMU's git history where we failed to do that,
but in general I think it's a good standard to meet. (I
am also erring on the side of caution in reviewing this
particular patch, because I don't know the relevant standards
or this bit of the code very well.)

Why do we care about the motivation for a patch?

(1) In the present: it helps to raise confidence that the
proposed new behaviour is right. This is good because QEMU's
test suite is far from comprehensive, so in some sense any
change to the codebase is a risk.

For instance, if a change is being made because the QNX demo
floppy doesn't run, then the fact that the change fixes that
failure-to-run indicates that our interpretation of the
meaning of the standard, or of what should happen in the
grey areas that the documentation doesn't clearly describe,
matches what the QNX driver author (an unrelated third party)
thought and probably also what a lot of in-the-field hardware
does (since QNX was no doubt tested on a lot of different PCs
back in the day).

On the other hand, if a change is proposed because it fixes
booting with older Linux kernels prior to commit XYZ, and
kernel commit XYZ turns out to be "make this device driver
program the hardware according to the specification rather
than relying on an accident of timing", then we might want
to look at where we want to be in the tradeoff of "run older
kernels" versus "put workaround for a guest software issue
into QEMU". (Workarounds for guest software bugs are something
I'm very reluctant to put into QEMU, because my experience
is that once they're in the codebase we can essentially never
remove them, because we don't know what guest code might
be relying on them. But sometimes they're a necessary evil.)

(2) In the future: if in a year's time or more, somebody
reports that a particular commit has regressed some specific
guest workload they have, knowing why we made the change in
the first place is really useful in investigating the
regression.

If we need to change code that was initially added to solve
a problem when running FreeBSD, we know we need to re-test
with FreeBSD.

If the change went in to fix a buffer overrun, we know we
need to be careful and cross-check that we don't reintroduce
the overrun in the course of fixing a regression.

If a change is one that we made on the grounds of "reading
the spec and the code, this looked like it was clearly wrong,
but we don't have a definite repro case of it breaking a guest"
then that might put "revert the change, we were mistaken" on
the table as a response to a future regression report.
And so on.

thanks
-- PMM

