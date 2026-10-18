Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F64FCCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIWfv-0005ky-Ps; Sun, 18 Oct 2026 15:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIWfu-0005kl-E3
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:36:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIWfs-0007Lw-SD
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:36:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48de6a62a4cso1139458f8f.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792352163; x=1792956963; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5MpV8Y5Vxr59zhOANmT98YUO29Ah1+lI73lVSjlr3cQ=;
 b=iqVE4qGHOdF2PI/AVnxgkOiRjQgavmnaGFMBi94zD34ugmUcZeVndNz2Dt5NyNJ1gK
 6mA3cT6P7jlg9odF4Q/A7W2aVkac/w6cNYH63jEOJg3Z50BmPa6MvnLOErtuIS8fydEh
 Z8sSBofLMWf+qGRRwRMXJY+uyu+BMcBRmBbDkzmzZGNhSTcmxG8SPHafqge0bVWqcPid
 U+ak9L6EWw1Jc55iuIPTjWPlKBZeBQFtcEvorvlyHnlOIAtrlpX8kIDIQbTNN8dB1CsO
 WuRpBPfmjuurRtfbZZHVvRaX+TmMJ5olAP/XEQlyrrdynNuHqhN48tCaGJNhhIIPJ0E1
 rXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792352163; x=1792956963;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5MpV8Y5Vxr59zhOANmT98YUO29Ah1+lI73lVSjlr3cQ=;
 b=xAmeGlhTtrV+SSowtK7rGH9Qo6znuv1UaeimIwon4/55JkGBAkDXGqDyPtIoG3yn5h
 ZXir+EdEtbg5GbJVS6285DnuqO9TovyPMGWE/i+pvmv1lx7dLUWSXKiynNAhUdw9Cla/
 bWIjNKznURRVYcMnds/mpFbWwCo8cFI+2dQMCMqDuwRBvz/zwR4A/YlxU/56/N2nFjx7
 oixq3F2pIZNnJAEvzY/y/D/TklctTviIgR7dXTKbAaPl05FUkU5Sfcrcw6WYWVO7uhDH
 ik8ScxG/7AxtK4zsms+FnLrtm9dHM+xcUxk8XuRvhQNGvaw6wo2LcXmRcuAUzqvV3/7k
 0uzg==
X-Gm-Message-State: AFq9FYJcApTcwuoGyHyisOwJL1YspUXITBmM93BBDS8NNXNsdRtO9AIk
 ZgDRvQMbjgmzybG6gzvyPsC4c2wXVi3P6CmZd9vmYfWIXVUHEkFcQL4P
X-Gm-Gg: AYBFou15DAo3m54m1yx2ILeZFp6lHUJ2JqV+KgfvI3kVA7AcDj8yHWE2LF/Lpnet9C9
 4U1xXAytkAEEsdhHrTIuhAoEVguX+kEHsIwLB94JTQMPWhk6j9OzXx5qjEjDn/EpEllp111HloU
 maG85t+9ZnxsYBSVXwZy8aimrgVv7dlo4qW+zA+fts1WqikByAJKj/lLMTeFGJiTiKjbjSsoC+7
 ol9dSokfjSbd3tQrpC3GgUsrU+rKEVBEz0PdbM9biJT6SiprVl+gYmv1icySFue7AtvocJ+QLpj
 sP7ltXO+blzpZp5W3XffO0essqfT4cpyOMShnISSbZV4/S6vfNR1nlk/qRbClPpPNvpSgAQoaIP
 nvSML7w2tixvVi4FZAxiDptHg67WzEGnh05FuaIHhgvSHXAGDvh/siDi+xYNwXhs/ul0C9Jk3cA
 eN4XqDIW9oT+dCKLCQ/bB8WuF6XRNQ2wlKEIOIMI3mHb7UHFzSBFHq4syVrFqgyc0=
X-Received: by 2002:a5d:474c:0:b0:48a:f454:3d4 with SMTP id
 ffacd0b85a97d-48e07fac2a3mr7395785f8f.53.1792352162727; 
 Sun, 18 Oct 2026 12:36:02 -0700 (PDT)
Received: from localhost ([31.7.57.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503a0dsm18961311f8f.47.2026.10.18.12.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:36:00 -0700 (PDT)
Date: Sun, 18 Oct 2026 22:35:58 +0300
From: Alexander Epaneshnikov <aarnaarn2@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille
Message-ID: <atUfTcaPUHqBQdno@alex-pc>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc> <atUZr1LP8k5b78I8@end>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atUZr1LP8k5b78I8@end>
User-Agent: NeoMutt/20260616-dirty
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=aarnaarn2@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Hello Samuel,

On Sun, Oct 18, 2026 at 09:10:39PM +0200, Samuel Thibault wrote:
> Does the device sends the cell count first or the device identity
> first?

I don't know for sure, as I don't have a real Baum display; mine is a
HumanWare Brailliant, which uses its own protocol. The comment in
NVDA's driver lists them as "device id, serial number and number of
cells", so the identity seems to come first, but that is the only hint
I have. BRLTTY's Baum driver doesn't use 0x15 at all, it asks for each
of them explicitly.

NVDA itself doesn't depend on the order: it stores the cell count and
the identity separately as they arrive and continues once it has both.
I tested sending the identity first and then the cell count, and NVDA
detected the display.

On Sun, Oct 18, 2026 at 09:10:39PM +0200, Samuel Thibault wrote:
> (splitting the actually-unrelated questions)
>
> Alexander Epaneshnikov, le dim. 18 oct. 2026 21:52:44 +0300, a ecrit:
> > On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> > > Ah, that is a requirement of the protocol? Then we need to do that
> > > indeed. What is the value of the uint8_t protocol field when it
> > > expects to receive 0x01 and 0x84?
> >
> > It is 1 (on). For serial displays, NVDA's Baum driver
> > (source/brailleDisplayDrivers/baum.py) first sends 0x15 with 0 to make
> > sure the protocol is off, then sends 0x15 with 1 twice, "in case the
> > display misses the first one". After that it waits for the cell count
> > and the device identity. According to the comment in that driver, a
> > real display answers only when the protocol goes from off to on. On
> > that transition it sends its device identity, its serial number and
> > its cell count, and it sends nothing if the protocol was already on.
> > NVDA itself only waits for the cell count and the identity.
>
> Does the device sends the cell count first or the device identity first?
>
> Samuel

--
Sincerely, Alexander

