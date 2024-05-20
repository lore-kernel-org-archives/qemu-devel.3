Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07673C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s96Rs-00086Q-24; Mon, 20 May 2024 13:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s96Rn-00082J-9X
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:05:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s96Rf-00040S-Hv
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:05:14 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-574ea5184abso8380724a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716224699; x=1716829499; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tMPERZXK5uOdmJMx2mnd9/g1csLZ7kbvqiTV1sWzEQ0=;
 b=bFJsagqziFnP5EnC+omIIX4Scj46VObWbK0BPrEXbjRUWj5P0PLIZQAipufaLVtZz6
 OECVNGnTHH3Q/VKTZc02B6HAdherCABePb+bsWjM2iMyaWyL8JGA8tAVohAi24OsXf4O
 LQvtxX6tVfzG74ydKyHY4DEd1OEdpDjBfP8uI5bEOPoTDAi0MaHsN6VN/Sdyhp/VrEvg
 5R9O8q2eJe5734JSEKKcDlbXlbqPFA3WUFu0W7noY9FH9Fomr5DAK/DwFgkxE0bDColA
 6WPPZIi1qo5ONGr3XaFypURkABcjtVURNfp7Dz6vBWHgw8k0qKn4yGxhAAPg6AZZZWmv
 cH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716224699; x=1716829499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMPERZXK5uOdmJMx2mnd9/g1csLZ7kbvqiTV1sWzEQ0=;
 b=SNCfN/nZjUi60uqJCMfh4po+VljWQrXsM09NDGJz3s/3wjtZeqeXbKnsEs+GY0elwy
 n+qaCuT9TkiG2XL8LUwZGrAVa3gSEPCXGp+OOiETHPdNlV79oU1NrqYJqvMrTYqZuBS/
 LA3PSI0EGB6md7J9gs+hVyLeSmBITTmZ/V9c3if62Xp5ukyynskRuFdGBI/q0Ax/RMSm
 AbiJAMxIpnPbh5SFH/kktyF9ohReXGL1FW+rhYn5O8ZB6Ur5XEqK8FZ/gBFW1d96ztdR
 /tzN/lHFVgmG3cXYxaGQ0oannuDE5TDp+ML32TeY+m4s7Ic+iSh+EjvjCgiIPUtFEWmy
 Uq3w==
X-Gm-Message-State: AOJu0YxybK4e1JGuja1ikexJhQxVoCn+Inn0q1T/KmpFZeHtLoHbxUg7
 GRiD6FS+H2X30nSN70xDqedd65FGGR60zIjvGLHEOhEhDrKSnX5wVVWiNiHeFivFDRmUyWfHqgT
 PQYwbHGrHpa9JJgBr/GhvKk2KeFFLpgP/2GQNWQ==
X-Google-Smtp-Source: AGHT+IHihhYwZr0iUnr6CVjVcJR83UoSm1uQDpdvfMfyYSmplpsL0YCu8GfOIrzBxA9+RPCrf4QV6JgaP+aa8MfMJUY=
X-Received: by 2002:a50:9f21:0:b0:572:6249:96bc with SMTP id
 4fb4d7f45d1cf-5734d67eea4mr20960308a12.32.1716224699522; Mon, 20 May 2024
 10:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
In-Reply-To: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 18:04:48 +0100
Message-ID: <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 6 Feb 2024 at 13:25, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>
> This changes the ohci validation to not assert if invalid
> data is fed to the ohci controller. The poc suggested in
> https://bugs.launchpad.net/qemu/+bug/1907042
> and then migrated to bug #303 does the following to
> feed it a SETUP pid and EndPt of 1:
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
> qemu-fuzz also caught the same issue in #1510. They are
> both fixed by this patch.
>
> The if (td.cbp > td.be) logic in ohci_service_td() causes an
> ohci_die(). My understanding of the OHCI spec 4.3.1.2
> Table 4-2 allows td.cbp to be one byte more than td.be to
> signal the buffer has zero length. The new check in qemu
> appears to have been added since qemu-4.2. This patch
> includes both fixes since they are located very close
> together.

For the "zero length buffer" case, do you have a more detailed
pointer to the bit of the spec that says that "cbp = be + 1" is a
valid way to specify a zero length buffer? Table 4-2 in the copy I
have says for CurrentBufferPointer "a value of 0 indicates
a zero-length data packet or that all bytes have been transferred",
and the sample host OS driver function QueueGeneralRequest()
later in the spec handles a 0 length packet by setting
  TD->HcTD.CBP = TD->HcTD.BE = 0;
(which our emulation's code does handle).

> @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
>          if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
>              len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>          } else {
> -            if (td.cbp > td.be) {
> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +            if (td.cbp > td.be + 1) {

I think this has an overflow if td.be is 0xffffffff.

> +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
>                  ohci_die(ohci);
>                  return 1;
>              }

(On the other hand having looked at the code I'm happy
now that having a len of 0 passed into usb_packet_addbuf()
is OK because we already do that for the "cbp = be = 0"
way of specifying a zero length packet.)

thanks
-- PMM

