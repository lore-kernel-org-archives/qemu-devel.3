Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB19ACF3970
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 21:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srOWj-0004LE-QD; Thu, 19 Sep 2024 17:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1srOWh-0004JZ-VT; Thu, 19 Sep 2024 17:17:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1srOWf-0000gH-RN; Thu, 19 Sep 2024 17:17:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2054e22ce3fso14506085ad.2; 
 Thu, 19 Sep 2024 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726780639; x=1727385439; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoSjHxGhf0A2MNCQwDDUg4rIGiQy/h0AKZYL30BhkPs=;
 b=Ez744S5PTHBsbh8mWDkUqO3om/zja+oAHw1q5uzOdXoSBABQZOUpkn9Up9VGDGsn8j
 D6Ujl0tKhko+WDDFU9GUgC+cBkp0nPX4mjVH9LkiV9MWVe8Aayi4QX+Qb74roVGtOkz+
 9JrUjW+w9T0G4PoPopNoaQAnspL3MXF3319Zu9GLRfCaRSjryPdq1zKw1VM2KNBl4YSX
 xTM3kfDVsxqiGlkNNgMnQOS+74CEl0vUgc0q1EVWFcqASRbLtwcyVUwZ89G4YUYmKLKE
 lpAXE4o4vuJoPtZlYw4k1hAlBNxhFiTIpyKly8VKyEqLNbmSD89ItBH9o77kwUgrONE3
 QrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726780639; x=1727385439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoSjHxGhf0A2MNCQwDDUg4rIGiQy/h0AKZYL30BhkPs=;
 b=OyZDXexKFfiM25D00XM/ikhsiTKsbnZbhCjsDfWZr8031H5e0evEt81P2VPjCAw6BV
 vCPmMxz1w7/HfPCKxhueTjE9u84nrv7HS9ZZZep1ZZb+qGLHuJEiLbCN7IX8oBPuk9ir
 HII+GpHp+bcRcyJTsl/3peA4l5D8TIFnByy18xAawj5weCtCDiU18E3Js4yB1ze4/kFa
 c8qbH9nbbxpkpzLcX56CjKIHTJIooiViSwKV6RM7324oI1cUHLJxwXtKL9RiUP6XEVDC
 PvTpp1733PJRnpg2Sz4bdQrcTZxr+aonJ+VgjQdFa9gYzJ9gxtrIWztTp0P0RQ8yhXCe
 F6XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQky7WNVY5ayWMqzqwLw8cyiDL17SRXMWb5zHruCB+k/K/750Dcq7HkTX3RgZDPcshzGQj93DL/tAf@nongnu.org,
 AJvYcCXiSu7zO4FcmMD7h93GxaTs7kanT+mgeo90S1VIffPKTh4kSxcwx/gqK3VH/w8KnjRZF+1ubdC+cAEOJw==@nongnu.org
X-Gm-Message-State: AOJu0YwAO3LXCNxMGjSLBNimDL9IBAoJUhC/eh7IcLQ3Ww5qlZkbgEZ1
 J+NfaoPgzxm8yjAKUy8CgwplSIs/Ps9IAQIzzi70vewqwdqFGPX6ohqKERonmex3BE5Fb0C2lgi
 tWJAk4hnBM550X29gxJp7zPRgZso=
X-Google-Smtp-Source: AGHT+IHAvGMT4xeFtLIjE6EjMcJl2/vC+wLjcFSVbyA8+lR9ePxEbtdjGl5qTFACGv5YpvFSqsQYDFi4sgPo32XRcpQ=
X-Received: by 2002:a17:902:f7c5:b0:207:45f1:d1fe with SMTP id
 d9443c01a7336-208d843e28dmr4947685ad.61.1726780639256; Thu, 19 Sep 2024
 14:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
 <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
 <20240917-2683603a6ea10148772d365e@orel>
In-Reply-To: <20240917-2683603a6ea10148772d365e@orel>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Thu, 19 Sep 2024 14:16:42 -0700
Message-ID: <CAMqWt3ofKAZVMjDcpA=xYcwaRw9ZJ51o1g+pp2vobVoyT2ODkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 atishp@rivosinc.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Drew,

On Tue, Sep 17, 2024 at 5:45=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Sep 09, 2024 at 01:27:05PM GMT, Alistair Francis wrote:
> > On Tue, Aug 6, 2024 at 7:05=E2=80=AFAM Gregor Haas <gregorhaas1997@gmai=
l.com> wrote:
> > >
> > > This patch series adds support for specifying OpenSBI domains on the =
QEMU
> > > command line. A simple example of what this looks like is below, incl=
uding
> > > mapping the board's UART into the secondary domain:
> >
> > Thanks for the patch, sorry it took me so long to look into this
> >
> > >
> > > qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -=
m 4G -nographic \
> > >         -device opensbi-memregion,id=3Dmem,base=3D0xBC000000,order=3D=
26,mmio=3Dfalse \
> > >         -device opensbi-memregion,id=3Duart,base=3D0x10000000,order=
=3D12,mmio=3Dtrue,device0=3D"/soc/serial@10000000" \
> > >         -device opensbi-domain,id=3Ddomain,possible-harts=3D0-1,boot-=
hart=3D0x0,next-addr=3D0xBC000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f=
,region1=3Duart,perms1=3D0x3f
> >
> > This will need documentation added under docs (probably under
> > docs/system/riscv) of how this should be used.
> >
> > I'm not convinced this is something we want though. A user can dump
> > the QEMU DTB and edit it to support OpenSBI domains if they want.
> >
>
> I also feel like this is just pushing the population of device tree
> nodes from an editor of a .dts file to the QEMU command line. If some
> generation is needed, then maybe we need a script, possibly one which
> has the same command line inputs as proposed here. afaik, we haven't
> typically taken patches which help overlay the generated devicetree
> with additional nodes. For example, see [1] for one such proposal
> and rejection.
>
> [1] https://lore.kernel.org/all/20210926183410.256484-1-sjg@chromium.org/
> Thanks,
> drew

Thanks for the link! After reading through that chain, I can see that there=
 is
typically high resistance to guest-specific device tree patches. As such, I=
'll
probably abandon this patch series rather than doing more work to clean it =
up.
I do wonder why there is so much resistance to these types of changes when =
the
need for them arises so often in various boot firmwares.

Thanks,
Gregor

