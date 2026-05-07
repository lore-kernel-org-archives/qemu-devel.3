Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B98CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 01:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKnvq-0002zI-8e; Wed, 06 May 2026 21:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKnvn-0002yR-Vz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 21:53:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKnvm-0007Qg-DC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 21:53:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b941cd869cso1901885ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 18:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778118817; x=1778723617; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QjH51N5gRBje4zfyAuMFpy4mElWAieUlW8ldn/FLWgQ=;
 b=MwnSxLYB91PM7Gt+Im6dmncghFGK0Cwwo3/Bz1gaYf2YcibF/OBDGZfPDJqUXp1v4E
 SC0C2Ici6ltBbTZkPVlEBgRdr2ECenpGdqIzIPWKdrKjMDgV+TDXCNG2wqD9GaD5N/HE
 NzH+1n3WzKV0R6SQ1FEult9OkR5dqmajOt7t5yxeHbXK88mjVciPK2Azm3/7AG+fzeaD
 9lg/ar5E9ZpoJpYWgIsg9E1fMVnNsAfbSnaDrizEv575XCTLKEwZAA9WwAFdAKTq0xoG
 VxwjuWWe2y91wQ7ffcg0exHLoDojZTeBGTPI6r7Ib670xYtapjRJo5jjbHTgqtf71C2b
 /6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778118817; x=1778723617;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjH51N5gRBje4zfyAuMFpy4mElWAieUlW8ldn/FLWgQ=;
 b=i9rCs6VPVFIvcrNbSM0sllS4aFH1KmY/00Yt8L7wsteLRCfQ5pi+typnoi9L9m6aGo
 fVhW70n19SN8qSVHhGTw29FsFGViWI8teltnCegS7Dw9HFBdmk3WeOcOfQH4ID0XNHlU
 7/3pbN2dMSeg2bjypM4QaIJDUaFg88ntoSccZMpWpG8gSWOWcwfry1hVE5HaackVrVGq
 Q5RmlXWbWQb2ziERevZxlkuqfqdOof6lXwTWh++cyYOkb0p+jT8gtY3CCiG7O6bXU4in
 Qd0ULf7O+FxTDXYuAUHTpNZ5aKgs/qdGRNDR3hD2lu5xXO6+gQhlL7D58e3ebdJKp+oQ
 z8TA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Do5h1CfP86gIQ54x+kvv1Lduc4d2proXnBw3b2U/n/h4ejzNZZ9aWzYxwG/Wnj2uQ841BS6kFvfko@nongnu.org
X-Gm-Message-State: AOJu0YyxF/z/a8lZcamcA7pKD9ABSDnMpzAfkrtv0hxhi/FNOMD//+Kf
 obsjTqrLnl8tKYIp2QNbjU0Dl34IRhSpL0Y32IK3HsDHOKGYW8NJquHW
X-Gm-Gg: AeBDies4fsk2MZfGX+aMIlQYEk3zUBZEbFXVt8ek9ZrM92Ex5ZKRgvlcXBV2CKq9Sha
 wpclh2CIKpasjddEreRBkCSG6oixs8UCgb2NIMeSOahM3c2GDPPOKn6vt67Kx9THtAPdmK60dY6
 L2Cl+a+JjiSIEABpDai3KllfuQoCgDMG89korFSpNhUU8waPgvKKnvyoosxShQUi5KLWUo+xipa
 x+RV2q/ctV/2/zqquGNhrMAa6nDp2R/rWUQwhwiiYhP9jMBRWQ3aN7TIdqgyADESosxVqWHruDe
 H7hW9QrfvgR7Xc9tULBGNF8dDCDca7+3Yge12xAtaEty6wGBh51fsYcoRa17nchiC9MJy7abbf1
 ri2+7pzo/mUs/y7ODLZpgHr6mTo1JSFXPNtyXx2intmZwTNjCxHrHuwHLZpaqm41G5hi1IcszZQ
 9fdPmXa2bPZth47oS1P9j44gBcgH5WwOBd9DqGSq3ctL4n4CTPUABkdRFg6yZI8MPTCq49tngAa
 tT8ryUX
X-Received: by 2002:a17:902:ebc1:b0:2b9:601e:da11 with SMTP id
 d9443c01a7336-2ba798d378cmr55848035ad.35.1778118816798; 
 Wed, 06 May 2026 18:53:36 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaaef08bsm5574245ad.28.2026.05.06.18.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:53:36 -0700 (PDT)
Date: Thu, 7 May 2026 11:53:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/13] hw/riscv/boot: Provide a simple halting payload
Message-ID: <afvwB1edp2C0O7vQ@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-5-joel@jms.id.au>
 <CAKmqyKNiJ9hGQVPsq8pEz8ydEWydW=umT4XwWanwk-etADgf_Q@mail.gmail.com>
 <afkvnrQveMGC1lcE@lima-default>
 <c20e1c76-a9aa-400b-8ad7-129347c1b9c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c20e1c76-a9aa-400b-8ad7-129347c1b9c0@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, May 05, 2026 at 10:06:08AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/5/26 01:52, Nicholas Piggin wrote:
> > On Thu, Apr 30, 2026 at 09:35:33AM +1000, Alistair Francis wrote:
> > > On Sat, Apr 25, 2026 at 11:21 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > 
> > > > From: Nicholas Piggin <npiggin@gmail.com>
> > > > 
> > > > OpenSBI hangs before any console output if the domain init code sees the
> > > > next stage is not in an executable region.
> > > 
> > > That's an OpenSBI bug though and needs to be fixed there and not just
> > > hacked around in QEMU.
> > 
> > You're right of course. OpenSBI has other no-output crash cases in early
> > boot code (not just this), so it would be nice to fix properly. It wasn't
> > trivial to fix (IIRC because serial device is not detected before a
> > bunch of the early failures), I have some hacks, but I need to go back
> > and come up with something nicer.
> > 
> > This is only related to Atlantis by coincidence of the physical address
> > map. It can be dropped out of the series.
> 
> Meanwhile add it in hw/riscv/tt_atlantis.c:
> 
>   static void
>   tt_atlantis_setup_opensbi_halting_payload_fixup(RISCVBootInfo *info,
>                                                   hwaddr addr)
>   { ... }
> 
> and call in tt_atlantis_machine_init()!

I was going to drop it entirely but that might be better if Alistair
doesn't mind. It means we can keep the opensbi functional test. It's
still a hack just the same, but at least not touching greater-riscv.

Thanks,
Nick

