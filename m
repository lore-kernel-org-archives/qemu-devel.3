Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9D0C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dzm-0007JQ-Vl; Wed, 08 May 2024 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4dzk-0007J4-Vx
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:53:53 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4dzi-0005xx-PM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:53:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso1090544166b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715162028; x=1715766828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kz6J1+pLsobBLcj0x7rTc+o+bMuujCnGRo9EUUcj9JI=;
 b=zXoppQatERbbiBLHVhULl6RhfO9oP6VEZYN/MBrHMS1LDewRDOFraZpgsMsT+NHZEk
 c5NQgXkvOMT5XN3dDqexhlErQW3fRUUiCRWXf41jR3VfKMyuVU7RJytl9lZW5ciBGip3
 Z2xVSmQzQNRP2vrmtRFRutlynf3oOkcRj3GK5JjaUPj19HA21wqbgVTPXhZBBFXOrWFF
 Zvn85kLJscSdVqcrJ8TMNbUOVFDohXx4h74g6n8tR0E4Zy4wJ+x7NSo00Y4q7yZJ9xxk
 jEJLPvVagh3hp1Cr7VpcPb0sJt6uS8aPa8wX9iYIK4vzmRG+BgUtHvX9oagACygx9jZe
 vjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715162028; x=1715766828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kz6J1+pLsobBLcj0x7rTc+o+bMuujCnGRo9EUUcj9JI=;
 b=EtxZFkEXpFcrbY4/fezwGP8sehl3p+OLG9st4T3qMF1MsHUPnUktYtTgqgnpNAk2yZ
 2N9PoORfjcnqTCM3nuqoU5Vr7r4AJOsW7ZcgDpbMjEZn3JXBQJt/2BeVQJcfj2qEnzSu
 S0+MhNNi5ZMtigbeHEf8/8+w3W5lZQYkl+GJCqH1Yv5NkazfAANvdaZ3ub1RgwWWuysJ
 im5aVgzrHl6oUjjeHfXBKj2F9gM26Pxf3MSH11PeEkHedOEYJZ3RF/+MfhdUsHwvwwZo
 l8DB4vSh6DY6kmoKkbswO6QSd0P+ALtlr88P0DtKIMc3oAcKA3rxQeSvHXwfM37LsuY3
 H/4g==
X-Gm-Message-State: AOJu0YzyXb9RzGvtwjJL2qFB1nN36NX+YYAZ5fBVu+QLElSyUM+bfDPc
 Aj45DIq+R3S7jy3ddBfBEihiRI/Ie8ioXErgq+IotwmXxZCarj0Zf3dqM3HEr0k=
X-Google-Smtp-Source: AGHT+IEhcINjAIYOipbCTuZObiZkVM/2yRTpcq+GlIhoGZApJwRtymVGgt2rtBkWCFVam0pfO5A94Q==
X-Received: by 2002:a50:930c:0:b0:56e:64a:2a47 with SMTP id
 4fb4d7f45d1cf-5731da83cbfmr1203716a12.42.1715162027875; 
 Wed, 08 May 2024 02:53:47 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 n10-20020a056402434a00b00572df643637sm5562245edc.62.2024.05.08.02.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 02:53:47 -0700 (PDT)
Message-ID: <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
Date: Wed, 8 May 2024 11:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 7/5/24 22:20, Cord Amfmgm wrote:
> 
> 
> On Wed, Apr 24, 2024 at 3:43 PM Cord Amfmgm <dmamfmgm@gmail.com 
> <mailto:dmamfmgm@gmail.com>> wrote:
> 
>     On Thu, Apr 18, 2024 at 10:43 AM Michael Tokarev <mjt@tls.msk.ru
>     <mailto:mjt@tls.msk.ru>> wrote:
> 
>         06.02.2024 10:13, Cord Amfmgm wrote:
>          > This changes the ohci validation to not assert if invalid
>          > data is fed to the ohci controller. The poc suggested in
>          > https://bugs.launchpad.net/qemu/+bug/1907042
>         <https://bugs.launchpad.net/qemu/+bug/1907042>
>          > and then migrated to bug #303 does the following to
>          > feed it a SETUP pid and EndPt of 1:
>          >
>          >          uint32_t MaxPacket = 64;
>          >          uint32_t TDFormat = 0;
>          >          uint32_t Skip = 0;
>          >          uint32_t Speed = 0;
>          >          uint32_t Direction = 0;  /* #define
>         OHCI_TD_DIR_SETUP 0 */
>          >          uint32_t EndPt = 1;
>          >          uint32_t FuncAddress = 0;
>          >          ed->attr = (MaxPacket << 16) | (TDFormat << 15) |
>         (Skip << 14)
>          >                     | (Speed << 13) | (Direction << 11) |
>         (EndPt << 7)
>          >                     | FuncAddress;
>          >          ed->tailp = /*TDQTailPntr= */ 0;
>          >          ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0)
>          >                     | (/* ToggleCarry= */ 0 << 1);
>          >          ed->next_ed = (/* NextED= */ 0 & 0xfffffff0)
>          >
>          > qemu-fuzz also caught the same issue in #1510. They are
>          > both fixed by this patch.
>          >
>          > The if (td.cbp > td.be <http://td.be>) logic in
>         ohci_service_td() causes an
>          > ohci_die(). My understanding of the OHCI spec 4.3.1.2
>          > Table 4-2 allows td.cbp to be one byte more than td.be
>         <http://td.be> to
>          > signal the buffer has zero length. The new check in qemu
>          > appears to have been added since qemu-4.2. This patch
>          > includes both fixes since they are located very close
>          > together.
>          >
>          > Signed-off-by: David Hubbard <dmamfmgm@gmail.com
>         <mailto:dmamfmgm@gmail.com>>
> 
>         Wonder if this got lost somehow.  Or is it not needed?
> 
>         Thanks,
> 
>         /mjt
> 
> 
>     Friendly ping! Gerd, can you chime in with how you would like to
>     approach this? I still need this patch to unblock my qemu workflow -
>     custom OS development.
> 
> 
> Can I please ask for an update on this? I'm attempting to figure out if 
> this patch has been rejected and I need to resubmit / rework it at HEAD?
> 
> 
>          > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
>          > index d73b53f33c..a53808126f 100644
>          > --- a/hw/usb/hcd-ohci.c
>          > +++ b/hw/usb/hcd-ohci.c
>          > @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
>          > struct ohci_ed *ed)
>          >       case OHCI_TD_DIR_SETUP:
>          >           str = "setup";
>          >           pid = USB_TOKEN_SETUP;
>          > +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only
>         allowed to ep 0 */
>          > +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
>          > +            ohci_die(ohci);
>          > +            return 1;
>          > +        }
>          >           break;

I made a comment on April 18 but it is not showing on the list...
https://lore.kernel.org/qemu-devel/593072d7-614b-4197-9c9a-12bb70c31d31@linaro.org/

It was:

 > Please split in 2 different patches.

Even if closely related, it simplifies the workflow to have
single fix in single commit; for example if one is invalid,
we can revert it and not the other.

>          >       default:
>          >           trace_usb_ohci_td_bad_direction(dir);
>          > @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState
>         *ohci, struct
>          > ohci_ed *ed)
>          >           if ((td.cbp & 0xfffff000) != (td.be <http://td.be>
>         & 0xfffff000)) {
>          >               len = (td.be <http://td.be> & 0xfff) + 0x1001 -
>         (td.cbp & 0xfff);
>          >           } else {
>          > -            if (td.cbp > td.be <http://td.be>) {
>          > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp,
>         td.be <http://td.be>);
>          > +            if (td.cbp > td.be <http://td.be> + 1) {
>          > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be
>         <http://td.be>);
>          >                   ohci_die(ohci);
>          >                   return 1;
>          >               }
>          > diff --git a/hw/usb/trace-events b/hw/usb/trace-events
>          > index ed7dc210d3..b47d082fa3 100644
>          > --- a/hw/usb/trace-events
>          > +++ b/hw/usb/trace-events
>          > @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret,
>         ssize_t len)
>          > "DataOverrun %d > %zu"
>          >   usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
>          >   usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
>          >   usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
>          > +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp =
>         0x%x > be = 0x%x"
>          > +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t
>         tdf) "Bad
>          > pid %s: ed.flags 0x%x td.flags 0x%x"
>          >   usb_ohci_port_attach(int index) "port #%d"
>          >   usb_ohci_port_detach(int index) "port #%d"
>          >   usb_ohci_port_wakeup(int index) "port #%d"
>          >
> 


