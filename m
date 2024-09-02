Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7540AC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 23:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slGtF-0000QZ-UM; Mon, 02 Sep 2024 19:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1slGtE-0000PY-BY; Mon, 02 Sep 2024 19:55:20 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1slGtB-0005TP-7c; Mon, 02 Sep 2024 19:55:19 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-846c0a741cbso776357241.2; 
 Mon, 02 Sep 2024 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725321315; x=1725926115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWhPeY5N6+COPLNfbVBRldGQiErYp7LSBYN1sBE/NC4=;
 b=VhpYBYBh/Fnx4QX6j5msYvnHZ5t9A/gPgQyYRylKfwsBBG/CyRXh+5eaK+RG9jA6OH
 Tizx9Ux6iIbwd5aAhuniqZClo5dDMgoTB25duDiQFC7LPItTz5Bi/yfqwt+njgiW8g4W
 O5Aje+VLQf3GpCohz4EDVEYmGVaGRxlxbxYYkofxzg82vf9w4wjYlorM4+Jx1mAtli2y
 RZzxFW7Up6+9evVFPt91i4e7frSPb6e6AOfYAJwZNlu1ZkRvmrVE9gM20vU8JVYalbqS
 irD8qFuQ/hKC0qlyR2GAdsUEJg6wwL5W0xepk6HvsYGpA3tittxBpANOl+gJga/+E/0G
 dcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725321315; x=1725926115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWhPeY5N6+COPLNfbVBRldGQiErYp7LSBYN1sBE/NC4=;
 b=mXOc+LwyDEWQqk4S83cbIfFGPXPt0DW9ecmHuBLsAlfk5APi2DqL2KKhTRNSYM7xBz
 xivkCyyfHGRfZGCK//bORdlCUaeM3ZGLz1lPpIurd3Fhp1qSpkneJEFuWQjWSRXKcx3m
 XRKrxUSujOUZ99SCl30blVYbqisU0yPE3wYEUTYLzgNol7A81eqIegzNjpcRyEp8mC3D
 Wq0OL8KvoZDOV+lM2Cdl1Wd8k4uWrMZ8HsGOua4Ii/VdbHHfe5dfJyPblk/xK/ws6LAS
 7Z78LDD5PhIjbv5vfUMDg21jk5a96130Il2mBzREKiwqtz5ajsR+6yG01bEb9begwnZj
 Oplg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ2iK6NQlKobsghYpTPIC24VWzMlIinjBonLSIRGmucmNJt5Rd7MV637HegG+LmTyhnEd7n0/wr2Fl@nongnu.org
X-Gm-Message-State: AOJu0YyuJDlJMVQIFcJSD+7u4XHPP5T/EnJdsSTYWOfsWrNjfMkWzBj7
 iKg32VpiGE+Iv3eW62qAfH/+7Yj5AA/X49NNtHxDGrXJeukuK5RxFhJWxtWd8OGnpgPgXzIO3x7
 mmQsn5ZQyoQ5XA10ozX6ek7mp87U=
X-Google-Smtp-Source: AGHT+IFCHBUeupg4WwYo1gRPQOBMxaIUtwlnYST2nWfZ6ojxAuzhtZOhs1HTVqt8UmUzUFfWtVi5kg/NOX/7gOX8IS8=
X-Received: by 2002:a05:6102:370e:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-49a7773522cmr10340458137.6.1725321315194; Mon, 02 Sep 2024
 16:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <747e3626-e4f4-47e2-bdfa-ca047f9f8443@redhat.com>
In-Reply-To: <747e3626-e4f4-47e2-bdfa-ca047f9f8443@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Sep 2024 09:54:49 +1000
Message-ID: <CAKmqyKNk2u0ApN2PV40EX_tsY8cFD56XcSKhyepQbqzEdP4_zQ@mail.gmail.com>
Subject: Re: tests/avocado/riscv_opensbi.py does not work reliable
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng@tinylab.org>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Aug 31, 2024 at 1:35=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
>
>   Hi!
>
> While running a lot of tests (i.e. with a very loaded machine), I noticed
> that tests/avocado/riscv_opensbi.py is very flaky when the host machine i=
s
> slow. I can easily reproduce the problem when running a big compilation j=
ob
> on all CPUs in the background and then run the riscv_opensbi.py avocado
> test. One of test_riscv32_spike, test_riscv64_spike, test_riscv32_sifive_=
u
> or test_riscv64_sifive_u is failing most of the time (but not the virt
> machine tests).
>
> Looking at the logs, it seems like the output sometimes stops somewhere a=
t a
> random place before the boot process reaches the spot that the test is
> looking for. Looking at riscv_htif.c, there does not seem to be any flow

I suspect this is: https://gitlab.com/qemu-project/qemu/-/issues/2114

> control implemented here, so I guess at least the spike test is currently
> doomed to fail occasionally. Is there anything that can be done about thi=
s
> (e.g. is flow control somehow possible here or does the interface not all=
ow
> this?)? Otherwise, I think it might be best to mark the spike and sifive_=
u

Patches have been sent to the list to hopefully fix this:

https://mail.gnu.org/archive/html/qemu-devel/2024-08/msg02743.html

Just waiting on reviews and then the merge window to open up again

Alistair

> tests with QEMU_TEST_FLAKY_TESTS here to make it clear that these tests a=
re
> not reliable by default...?
>
>   Thomas
>
>

