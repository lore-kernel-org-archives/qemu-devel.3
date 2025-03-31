Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9416C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 10:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzCXO-0006q8-4I; Mon, 31 Mar 2025 06:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzCXM-0006pd-9f
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 06:38:36 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzCXK-0008R8-C5
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 06:38:36 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so763486766b.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743417512; x=1744022312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YyESUsuWRi1PC7E+N28GieaBOXFK2R42TwhkserlSiM=;
 b=ovawZT/O2uKRgOY0rHthGQvE3atmKfYhQoSEeFFq0yLasw5e2eBvI/ykRI3/NR5rjc
 5eE9pgKl89y7hv51wEhzYCKUGC6/bQC2amHnzVbSFyJGL7HAECvoh/mdmkZJW1vAr+l3
 3uWQ8r5exz13tMPz9Px/8FIOgGwqMmz1kecNWwvGL411qmxTnIHjtPin9spDlJOJT6oQ
 aCCEKgb+rVCqbMmH7JccxXpvxfTgCkWSqP04gFsopk7Q7uwTDpHUe65fw3B4/I8oQz4u
 CnLcHBeLsg+15pkDLrIqCBvqXxhIqcm03yaSODBipL4ceKC2pEYdoByehCz3XeKp5RWY
 tmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743417512; x=1744022312;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyESUsuWRi1PC7E+N28GieaBOXFK2R42TwhkserlSiM=;
 b=F3yV/ptt17ShX7lIGItniKOYYgdr96pguAqOKBqDUUS9AvaW2FaNpZ5JExQUMBDton
 Fscq+guuFPJspjVM3eDe1QVDPHVh4FToLRTtq8D4L/jAZXJMgkIL+Vrc0IkB7g+MkQ8q
 FcLjjhMFSmxfm9HUer3cisU4SNnSVW9OxgCmRcSLBeAaW9Pqej12qJUq2eutnPzfJ3bI
 98F6pexs3+sIWY5ArjmGJC5Pr17mge3NrDylqa8FA/ByqcxVGunmgvfbBpYr6NpTZaem
 8IyF/9D3UVMR4q/Isu9b2YgLEqqkRJvVBPDplCvoD66rW8GpFYOS/IMu+K/30H30A9FK
 B2/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFUoz9lKhv9RVgqoizrMW1bMHnh2FX6eifwhSHTrD4/+tCu8LccFZ5ZZ8punhxTwCDLY7zbdxBtvCv@nongnu.org
X-Gm-Message-State: AOJu0YzVNdyk/w1SpKFmgRUN12+9MIQqHbewHhSNoiri4QHfydQxbjqr
 aJGsvIkS79tCthtfFUUK49MG45kW7mqM1AsXavaDOgOnc5L1BnGyIkoqsxuwfYE=
X-Gm-Gg: ASbGncvv1xNoJCRneyZnoJmtbgRsEeUXECdOGHBGX1yFHavrwn5max4FROVsjaiWmTw
 uNhX5NxeKtV/x9bZ7Li0Nznb8KSaDz2ttDKn4hbqDfN0AG0nOX5j9yY3S8VC9tvqpxktRZERoDb
 Q0KhPIxnBKxmfIdrw2rsBh7RdYg5nl/WqUbHtnypHb21qb6bglcomoL3R2zggj/06GaMsV4bFlo
 ViQjSHEEEFZ+y5MPktvOcP5mmPEgcrPBMo/pHwE4ZiBMxm48YL4+M5N+vgh+hCWvMHnIeu+qmh0
 yttLFlphwvmMhIywBSv+ic0psYJZDdJKYkO/Qfr/zkYDQv0=
X-Google-Smtp-Source: AGHT+IFSJNZuM5smiQqA7G8jICfD2gJxiBrKvXpSL+O5/DVYSx9dIZxsljVHBGy5SlucMLLSuG8ouA==
X-Received: by 2002:a17:907:6092:b0:ac1:f002:d85d with SMTP id
 a640c23a62f3a-ac738a0c8ebmr784282666b.6.1743417512285; 
 Mon, 31 Mar 2025 03:38:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b205sm618212266b.60.2025.03.31.03.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 03:38:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC9785F88A;
 Mon, 31 Mar 2025 11:38:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rust VMM <rust-vmm@lists.opendev.org>, QEMU Devel
 <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, VirtIO Dev List
 <virtio-dev@lists.linux.dev>
Cc: Bill Mills <bill.mills@linaro.org>,	Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Michael S. Tsirkin <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, Matias Vara Larsen
 <mvaralar@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: Central repo for VirtIO conformance tests?
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 31 Mar 2025 11:38:30 +0100
Message-ID: <87semtpjrt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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


Hi,

We've been working with Panasonic to expand the testing of VirtIO across
a range of hypervisors and VMMs. We've tackled this with two approaches:

  - simple unikernel to verify features and basic functions common
  - rootfs images to exercise the whole device

The unikernel utilizes rcore-os's no_std VirtIO drivers to discover and
initialize a range of VirtIO devices. The tests mostly focus on checking
no unknown feature bits are advertised as well as ensuring features
dependencies are properly realizable. This is useful for those
interested in moving workloads between hypervisors to ensure you don't
end up relying on a proprietary feature that aren't available elsewhere.

The virgl test also does some very basic blob mapping to check the
underlying mechanics are working.

The unikernel outputs a TAP stream to make integrating into a test
harness easier.

You can find the current state here:

  https://git.codelinaro.org/manos.pitsidianakis/virtio-tests

While we only build an aarch64 unikernel the upstream drivers have
examples for riscv and x86_64 as well.

As more complex VirtIO devices like GPUs tend to have a significant
user-space component, we have also started building Linux rootfs images
to exercise those. The images themselves are built against a baseline
architecture so they can be used on as wide a range of hardware as
possible. They have been built with buildroot to make them lightweight
and as close to the upstream projects as possible without relying on
particular distro support. You may have seen the recent aarch64 GPU
image being added to QEMU's functional tests recently:

  https://gitlab.com/qemu-project/qemu/-/blob/master/tests/functional/test_=
aarch64_virt_gpu.py

I'm currently working on a similar image utilizing a subset of the
blktests project to exercise the VirtIO block devices. The various
recipes can be found here:

  https://gitlab.com/stsquad/buildroot/-/tree/adding-blktests?ref_type=3Dhe=
ads

although the intention is for all the recipes and basic QEMU based tests
to be up-streamed into buildroot in due course. While I will no doubt
expand the functional tests in QEMU over time to utilize these images,
there is a wider question of where would be a good place to host a more
comprehensive VirtIO test suite? While useful for validating proprietary
hypervisors there are also a bunch of other VMMs and VirtIO backends
other than QEMU:

  - rust-vmm's vhost-device collection of vhost-user backends
  - CrosVM
  - Cloud Hypervisor
  - libkrun

As well as using VirtIO backends with other hypervisors such as Xen,
Gunyah and WHPX.

So this brings me to the question posed in the subject. Where would a
good place be to host these conformance tests?

My initial thought was to see if this is something OASIS could host as
part of the specification however I'm not sure OASIS is set up for such a
thing.

We could host it as part of the QEMU project as a service to the wider
community. While it should be pretty easy to expand QEMU's own tests to
work with multiple hypervisors, its test machinery isn't really setup
for non-QEMU VMMs. Ideally we would want the core repository to be able
to run on multiple hypervisors and use different VMMs and backends
depending on where they are being run.

The other option I considered was hosting with the rust-vmm project -
although maybe that just makes sense for the unikernel tests as they are
rust based. We certainly need more automated testing of the vhost-device
repository which can serve as a backend to multiple VMMs and
hypervisors.

So what do people think? Where would be a good place for common test
repository to live?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

