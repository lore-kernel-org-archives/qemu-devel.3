Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF49C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 16:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s96IB-0004UG-EE; Mon, 20 May 2024 12:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s96IA-0004Tv-1K
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:55:18 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s96Hz-0002CG-50
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:55:17 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e724bc466fso16688311fa.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716224105; x=1716828905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GRdhjAurv7x57oA0Yc0vh/H6J3p5UHmbv7V3GLC+BJ4=;
 b=Qh+CkeQtW8ujBpQlZcs7w971jQ8MwqrDhjykvq2RqYAnAgvpcscWgwmIh+/4V0h4sj
 1X6UcaL8fozxwY4aB5pXzKg5NkdjbFSWDPP+vzvHQGjpA7hg5e5ofYM/esTxTwWxnwnI
 tG5NlgLly6ZpXrjPK9mt2y9moqkn+BNfQZtymvYHF+6EnQk/R2mh0mQ+LkP4CTdLfED0
 kiBaJI6rxbfkH3VzKGLHrp+vF51ahx5PXqFExsg/1h3GS6efag54dGilJ+XhaEgvB9Bv
 8EbxYRoOjuJk+ugE7G05WfXx5TlnDaRjqY8E+LRt1zpPlgLdf9BuA4sE4dinKv31tpVN
 Bb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716224105; x=1716828905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRdhjAurv7x57oA0Yc0vh/H6J3p5UHmbv7V3GLC+BJ4=;
 b=Uz4FzfkHBNnMHN1XgEoaAPGTot3KExjKsUfh65AG9PO6fwhbSvTWjDDkbpOP3lafe5
 6mcB1ATLPg9UmXsRIUjH9q1M9mYG2WRTs2fWnSXG17k3f7hKwwfHDuzTXXzzgHZ8JUao
 MP4GUwvi/PymqXHYKUxAXaTi1a6ybWyfqQa3OUzyo8kKWsSjCi04x+hhYOY2wq1SWDp+
 tDMEpsNFUMKoVD6wS3ZiA2AKWMInC8jYu59tg5l4aLssmdoPFOcc3tbUAdTCooUNEd8w
 jo3MLOkM9sGwlgfDrfxFRXuOdTtg5pGyFwKiJjGAsqx+eeEqTKZCZ1VxvyQd6lYtLLEO
 qJIA==
X-Gm-Message-State: AOJu0YzjoX8iUYjKxX+Lkbe+U8GGCaH0s79ASUJB+QQzZEpW+7a1kWLm
 SoUi5q2AEW/IJQTK00mITOTnRmncdZN0AjFg+zkxe/QRbeJZH97BLI3U8m+UMee+WwSK9dGT83w
 ng1+wlRnEOGix9VefXQ4jk8tmaQZq/yNxP/t/ZQ==
X-Google-Smtp-Source: AGHT+IEW7MB9Ycwx2yhQavMOBgfu8Y/6r96MGC9BXsVEKq0qIV1qsXYn+JVRbP1TcSj0R+rE/z0OmfxEFwFFN4SJ6L4=
X-Received: by 2002:a2e:900b:0:b0:2df:1746:a338 with SMTP id
 38308e7fff4ca-2e51fd3fe17mr235364021fa.11.1716224105041; Mon, 20 May 2024
 09:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240509002916.138802-1-dmamfmgm@gmail.com>
In-Reply-To: <20240509002916.138802-1-dmamfmgm@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 17:54:53 +0100
Message-ID: <CAFEAcA_FgqggnQTrJYFuLkazz9YNysNwOt8Q=9e+kr+nr_UA4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 9 May 2024 at 01:30, David Hubbard <dmamfmgm@gmail.com> wrote:
>
> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the ohci validation to not assert if invalid data is fed to the
> ohci controller. The poc in https://bugs.launchpad.net/qemu/+bug/1907042 and
> migrated to bug #303 does the following to feed it a SETUP pid (valid)
> at an EndPt of 1 (invalid - all SETUP pids must be addressed to EndPt 0):
>
>         uint32_t MaxPacket = 64;
>         uint32_t TDFormat = 0;
>         uint32_t Skip = 0;
>         uint32_t Speed = 0;
>         uint32_t Direction = 0;  /* #define OHCI_TD_DIR_SETUP 0 */
>         uint32_t EndPt = 1;
>         uint32_t FuncAddress = 0;
>         ed->attr = (MaxPacket << 16) | (TDFormat << 15) | (Skip << 14)
>                    | (Speed << 13) | (Direction << 11) | (EndPt << 7)
>                    | FuncAddress;
>         ed->tailp = /*TDQTailPntr= */ 0;
>         ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0)
>                    | (/* ToggleCarry= */ 0 << 1);
>         ed->next_ed = (/* NextED= */ 0 & 0xfffffff0)
>
> qemu-fuzz also caught the same issue in #1510. They are both fixed by this
> patch.
>
> With a tiny OS[1] that boots and executes the poc the repro shows the issue:
>
> * OS that sends USB requests to a USB mass storage device
>   but sends a SETUP with EndPt = 1
> * qemu 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.19)
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
>  qemu 6.2.0 | qemu HEAD | actual HW
> ------------+-----------+----------------
>  assertion  | assertion | sets stall bit
>
> The assertion message is:
>
> > qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.
> > Aborted (core dumped)
>
> Tip: if the flags "-serial pty -serial stdio" are added to the command line
> the poc outputs its USB requests like this:
>
> > Free mem 2M ohci port0 conn FS
> > setup { 80 6 0 1 0 0 8 0 }
> > ED info=80000 { mps=8 en=0 d=0 } tail=c20920
> >   td0 c20880 nxt=c20960 f2000000 setup cbp=c20900 be=c20907       cbp=0 be=c20907
> >   td1 c20960 nxt=c20980 f3140000    in cbp=c20908 be=c2090f       cbp=0 be=c2090f
> >   td2 c20980 nxt=c20920 f3080000   out cbp=0 be=0                 cbp=0 be=0
> >    rx { 12 1 0 2 0 0 0 8 }
> > setup { 0 5 1 0 0 0 0 0 } tx {}
> > ED info=80000 { mps=8 en=0 d=0 } tail=c20880
> >   td0 c20920 nxt=c20960 f2000000 setup cbp=c20900 be=c20907       cbp=0 be=c20907
> >   td1 c20960 nxt=c20880 f3100000    in cbp=0 be=0                 cbp=0 be=0
> > setup { 80 6 0 1 0 0 12 0 }
> > ED info=80081 { mps=8 en=0 d=1 } tail=c20960
> >   td0 c20880 nxt=c209c0 f2000000 setup cbp=c20920 be=c20927
> >   td1 c209c0 nxt=c209e0 f3140000    in cbp=c20928 be=c20939
> >   td2 c209e0 nxt=c20960 f3080000   out cbp=0 be=0qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.
> > Aborted (core dumped)
>
> [1] The OS disk image has been emailed to philmd@linaro.org, mjt@tls.msk.ru,
> and kraxel@redhat.com:
>
> * testBadSetup.img.xz
> * sha256: 045b43f4396de02b149518358bf8025d5ba11091e86458875339fc649e6e5ac6
>
> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> ---
>  hw/usb/hcd-ohci.c   | 5 +++++
>  hw/usb/trace-events | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index fc8fc91a1d..acd6016980 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
>      case OHCI_TD_DIR_SETUP:
>          str = "setup";
>          pid = USB_TOKEN_SETUP;
> +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to ep 0 */
> +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
> +            ohci_die(ohci);
> +            return 1;
> +        }
>          break;
>      default:
>          trace_usb_ohci_td_bad_direction(dir);
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index ed7dc210d3..fd7b90d70c 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -28,6 +28,7 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len) "DataOverrun %d > %zu"
>  usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
>  usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
>  usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
> +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad pid %s: ed.flags 0x%x td.flags 0x%x"
>  usb_ohci_port_attach(int index) "port #%d"
>  usb_ohci_port_detach(int index) "port #%d"
>  usb_ohci_port_wakeup(int index) "port #%d"
> --

For this patch,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Are you happy for me to take this patch and apply it to
target-arm.next with the git Author and Signed-off-by:
lines both being "David Hubbard" ? (I think if I understand
our conversation in the other mail thread that that's the
right thing.)

thanks
-- PMM

