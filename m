Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB65ACCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 19:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIXH6-0001sY-UC; Mon, 10 Nov 2025 14:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vIWuN-0003g8-LX
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 13:46:31 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vIWuL-0002DS-OW
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 13:46:31 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5943d1d6471so3369567e87.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762800387; x=1763405187;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+qxwc8BjTGv1PJbS/5O3QnvovBnKk7to9MfKbv4uVTg=;
 b=Udg5H/5NKhADPzGhmdSOMGD6lhxcb4Cc+xtRYSgYzpSfZqeUT7la+hUtnP6Tl9m+ts
 50jvuhe7qCPiU99E7cEp4jqfGelwJyhY0Vdtl2B3HGy1mKmXdikOxJVtlmlqCAmEl6/j
 s3lWgppeqWc5XeaYgzwCzEB81kqdYqkMQC5YQdsrXZZUqq9IhdyY9yFUlvYPKUBS27CH
 rPrQqDP4FOGDLKwOlYpwfkqNU4VrT/neX7C8l7pNL/YgXp+4URT3d8kwyfpGh5/+BMrw
 IBcBxWPXASliEeuCUXJwvtiygB7Ajrqfnl4Ng2ZtYx4EtB4s2ARXkCRIo44Yvq+5u91L
 aZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762800387; x=1763405187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qxwc8BjTGv1PJbS/5O3QnvovBnKk7to9MfKbv4uVTg=;
 b=Uc3eqCqxLkAKtT75RJejcNRu8LS7w50acBUjurgxr07He8jawpvdkWx367v+D0Nz04
 bpVeF+z9MGD8v8bjVBZqc1Je/4zy1X8O+B/nym8EYwfYsGKUO3P4HMtmsO/DSFZ+s2P3
 L62tAAo0z0WtVsyx4rl0PWYfZquTF9XjHGa8FoQBZONFhYFzLJJKUttyK9Kd4DeyC4tz
 jcfZFQOnLvjJfgEkW4Wc6KatKmV+4+78Krz2Ab2pOmgef1iDNpLRRSArSFkgjL1asyy4
 Fm1+8S6vtHd09Z5iyqcf4N/X1BgupcmBMv84tL4nFguGaU3ZxYynz54h9LhCejn7ww8P
 BGYg==
X-Gm-Message-State: AOJu0YzqzXywgkFD5p61kIOFQ6Wih1Ve9vendK+UGIj0kQGGSu/2AFmw
 Z6+mMgRRulBttpnxAA6g4y3kDpctNLFikU8tdCJkj4NAASHPnmuE8YA2fHGZrDDpzl3aJZ0PgLk
 Tc0OSEDPeDCQdIWGNYyaax6BAGwR/ir6TQb5bZUUC6g==
X-Gm-Gg: ASbGncv4WIzcSeL9Rpr5eMMOjnNo50YKfTM71XqPYfq3zpOlAng3PQnHStcOoZPzTB5
 k/P+TBDdFlKzPwSXKfA9ptnUlcLN82M6q5EUsGKobuwHS3KlrRI/TOUwCxwMrXGVbWwswmUUNpT
 eEZCqpMbb2ImwpilxE0NUMM+y8el927qAMMnRJr7MNmnXe4VRCIwf7D7wMXe5qeafLXzfVlE3o0
 E4BDf5qZ36INnpDxNeyfUJ9/rHVZStFaaqEseSADGySTpG7lKEoONNSstGovidTst0wrDyiMRMI
 nMx2rRT+HwM=
X-Google-Smtp-Source: AGHT+IGyAABh40RoE19n2tBxVMnI5ZCMhHRjdBAUp5oTZzLmmJCkCdr0h8V9fN12f0BS2E03cFPb4KOfyjOnte6txfs=
X-Received: by 2002:a05:6512:3c8c:b0:591:edea:8dab with SMTP id
 2adb3069b0e04-5945f1dab85mr2770297e87.38.1762800386903; Mon, 10 Nov 2025
 10:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20251109191532.32419-1-michael@videogpu.com>
 <d3f15618-3f1e-4e41-9e0b-228923c78e42@redhat.com>
In-Reply-To: <d3f15618-3f1e-4e41-9e0b-228923c78e42@redhat.com>
From: Michael Levit <michael@videogpu.com>
Date: Mon, 10 Nov 2025 20:46:15 +0200
X-Gm-Features: AWmQ_bnxYipt4rKavgZdMHdH2inwCBj5AG2wRVBI_Bi6XS1cvsuGL8QPiN9vEW4
Message-ID: <CA+KCYksKitF6YO390y9JhHWaE2bvKw1nPJ0Axq8FvJyCgEEfqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] RISC-V: NEORV32 CPU, peripherials, and machine
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, smishash@gmail.com
Content-Type: multipart/alternative; boundary="000000000000df1bb4064341f2f7"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=michael@videogpu.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000df1bb4064341f2f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>
> Are these binaries available publically somewhere on the internet?


Currently, as far as I know, there are no prebuilt binaries =E2=80=94 only =
source
files for the bootloader and firmware examples in the NEORV32 repository.
I compile the binaries and prepare the flash image locally.


> If so,
> could you please add a test in tests/functional/riscv32 that make sure
> that
> the machine is basically working, so we don't face any regressions in the
> future?
>

I can upload the generated image to my GitHub repository, or alternatively
to some QEMU-related storage if there=E2=80=99s a preferred location?
The test image is around 4 MB, plus a few kilobytes for the bootloader.
I will add the test of course.

Thanks for the review and feedback!

--000000000000df1bb4064341f2f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
Are these binaries available publically somewhere on the internet? </blockq=
uote><div><br></div><div>Currently, as far as I know, there are no prebuilt=
 binaries =E2=80=94 only source<br>files for the bootloader and firmware ex=
amples in the NEORV32 repository.<br>I compile the binaries and prepare the=
 flash image locally.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">If so, <br>
could you please add a test in tests/functional/riscv32 that make sure that=
 <br>
the machine is basically working, so we don&#39;t face any regressions in t=
he <br>
future?<br></blockquote><div><br></div><div>I can upload the generated imag=
e to my GitHub repository, or alternatively<br>to some QEMU-related storage=
 if there=E2=80=99s a preferred location?<br>The test image is around 4 MB,=
 plus a few kilobytes for the bootloader.<br></div><div>I will add the test=
 of course.<br></div><div><br>Thanks for the review and feedback! <br></div=
><br></div></div>

--000000000000df1bb4064341f2f7--

