Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69034C3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 02:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC7q3-0000gD-U7; Mon, 05 May 2025 22:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uC7pt-0000ZT-Rn; Mon, 05 May 2025 22:15:12 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uC7pr-0003xX-SD; Mon, 05 May 2025 22:15:09 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7301c227512so3573842a34.2; 
 Mon, 05 May 2025 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746497704; x=1747102504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F2Z3nnBhdYwrCR9zjFHmsJrQMgdwfTQuAKXODb9StCU=;
 b=nrSLOeU8PMDKVyhkIn3JQg8dvVYzzNtHVQT7XZrVtKpIAq+/vKxzmy59itdfYznj3y
 PMC2q5xdNSlJtYtgfO0I5zJRXs4nJeXQDU/ARiDMhbJ98FR83e6uiNVRT+IstnP2IQFG
 wkhF5MFUT7i1ucX0U0Y2/6/rRbeOgJ4n2IW0W8HB/iLfvYw6tHY1+VfjTRxIeTPeDXzS
 l2RogietnOlHuzCwAG7LSd4f/5qVrPRqIJc883edFqgKnQ9EFCFgt0mGCfFOoWRq9lnT
 9PIYRzXAH2bsi9IIP1p3Pnpl0wFhs7K5FON54St7mVVJa4v0QJsS4XFQKJMNonyVO4EG
 efuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746497704; x=1747102504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F2Z3nnBhdYwrCR9zjFHmsJrQMgdwfTQuAKXODb9StCU=;
 b=o+xkQexH1Hj7Su+HIiACqgBo7FSmOirtOB//EeCIoM3p/e/eYGh3pE1gk3Op+W/n9Q
 O9xcrpyyFn/p/T5SBlkkM/x3O78Sbdrnai74ZBAr36vkt7REChJW2wYDytrSA6Vjpzjx
 yBocgyV/oONHR6VqzEspS0frfNEqPduxVTzQtm6Or7mMAEgaU27P9zfhLSeIO2EHEAhC
 QHWMzzSG6oTeasG/c7MuSJs3WLqh1qk9zVUyT3iSbuX5QLllS8f/scqfH+Tu3i9BE0Fv
 VMItFKQlLtLr/dr21uzLh6pymTXvCfFNmGmzw+SUX9gb7KsGIrl7soFq8GxGywVE3Mfl
 hKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDLKX7fwclh8GrqDDJnSL8ukwBKVryhyt2lCvdmE8xFPSdKizwSogx/2+bAxI/vB2Xxz0b4ACQoey95g==@nongnu.org,
 AJvYcCXXEBRcwPl4fFaAX36WnKrwDlzFKvaLvt7M5DQpjIfgBRck4x2ETUz6h9lncLNTnpSbIFn6wWxB1Q==@nongnu.org
X-Gm-Message-State: AOJu0YzuW+O4WmJWtUqxwBfjwi4lJCSqO4qzFJjPuwmBQ14vD7WK044z
 gzIX9zkQ9fjdu1DT4c9KoosFOwjdO819QtuhWwS9bEr52VFYvtNuieCTyBJHWSr5fSygaKHzBnS
 a24/VnOdkon4pH+ozlMMU+HY8ZdQ=
X-Gm-Gg: ASbGncsSAy6Z5WZELhyUU/vR/YE7nfnWPjjEaSV6dtyBrJO4xfsETAbOC6tFTPVZjXN
 zbSSY6eYWlg654KXmoDrjEAZMHljWmD24PZiPBV4ss5p42iD3DyMEM6VGDapDLkLS6RPM941QI0
 cMJaRrLqceNjqZqAnWGFVDKaltERABm3ztDw==
X-Google-Smtp-Source: AGHT+IHyPS3e860w6z+sTXO77peXXmCaGe8Sop+sUlxwMwc67vWvsieDuATF/4KDTAkpCoLB+JzTdX/p+p1j8QIWBiQ=
X-Received: by 2002:a05:6870:f694:b0:2cc:4516:afc6 with SMTP id
 586e51a60fabf-2db3d1625e1mr738543fac.36.1746497704497; Mon, 05 May 2025
 19:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250418091208.1888768-1-timlee660101@gmail.com>
 <874ixzgfc7.fsf@suse.de>
In-Reply-To: <874ixzgfc7.fsf@suse.de>
From: Tim Lee <timlee660101@gmail.com>
Date: Tue, 6 May 2025 10:14:53 +0800
X-Gm-Features: ATxdqUF_xjhU4ge4FT6GOcb2IctwQqwpERsNyWPaNV32RBbLiaqaaKpt9VuHmGA
Message-ID: <CAJG6D+hRQQq6DaoPVs+VU-sibTSA1OSwYkhgcNy2xy1Da3BtRw@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Fabiano Rosas <farosas@suse.de>
Cc: lvivier@redhat.com, pbonzini@redhat.com, wuhaotsh@google.com, 
 kfting@nuvoton.com, chli30@nuvoton.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=timlee660101@gmail.com; helo=mail-ot1-x32d.google.com
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

> This fails on top of current master, please take a look:
>
> $ QTEST_LOG=1 QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/npcm8xx_pspi-test
> # random seed: R02S03f79fc48ba73b76c881f93f90b015e9
> 1..3
> # Start of aarch64 tests
> # Start of npcm8xx_pspi tests
> # starting QEMU: exec ./qemu-system-aarch64 -qtest
>   unix:/tmp/qtest-32530.sock -qtest-log /dev/fd/2 -chardev
>   socket,path=/tmp/qtest-32530.qmp,id=char0 -mon
>   chardev=char0,mode=control -display none -audio none -machine
>   npcm845-evb -accel qtest
> [I 0.000000] OPENED
> [R +0.034918] endianness
> [S +0.034944] OK little
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 10},
> "package": "v10.0.0-530-g88d6459dae"}, "capabilities": ["oob"]}}
> {"execute": "qmp_capabilities"}
> {"return": {}}
> [R +0.037373] writel 0xf0201002 0x1
> [S +0.037396] OK
> [R +0.037417] readl 0xf0201002
> [S +0.037426] OK 0x0000000000000000
> **
> ERROR:../tests/qtest/npcm8xx_pspi-test.c:45:test_init: assertion failed
> (pspi_read_ctl(qts, pspi) == CTL_SPIEN): (0x00000000 == 0x00000001)
> Bail out!
> [I +0.037909] CLOSED
> Aborted (core dumped)

Thank you for testing it. I think the failure seems to be related to
the following commit which, has not been merged yet.
https://patchew.org/QEMU/20250414020629.1867106-1-timlee660101@gmail.com/
Here is our test result for reference. Thanks.

tim@openbmc:~/qemu$ QTEST_LOG=1 ./build/tests/qtest/npcm8xx_pspi_test
# random seed: R02Sede04390f31d107799cc627dd5992309
1..3
# Start of aarch64 tests
# Start of npcm8xx_pspi tests
# starting QEMU: exec /home/tim/git/qemu/build/qemu-system-aarch64
-qtest unix:/tmp/qtest-974125.sock -qtest-log /dev/fd/2 -chardev
socket,path=/tmp/qtest-974125.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine
npcm845-evb -accel qtest
[I 0.000000] OPENED
[R +0.075439] endianness
[S +0.075466] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
"package": "v9.2.0-2138-g694a7d11fc"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
[R +0.077905] writel 0xf0201002 0x1
[S +0.077915] OK
[R +0.077943] readl 0xf0201002
[S +0.077948] OK 0x0000000000000001
[I +0.078171] CLOSED
ok 1 /aarch64/npcm8xx_pspi/init
# starting QEMU: exec /home/tim/git/qemu/build/qemu-system-aarch64
-qtest unix:/tmp/qtest-974125.sock -qtest-log /dev/fd/2 -chardev
socket,path=/tmp/qtest-974125.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine
npcm845-evb -accel qtest
[I 0.000000] OPENED
[R +0.075965] endianness
[S +0.075991] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
"package": "v9.2.0-2138-g694a7d11fc"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
[R +0.078505] write 0xf0201002 0x1 0x05
[S +0.078515] OK
[R +0.078546] readl 0xf0201002
[S +0.078551] OK 0x0000000000000005
Wrote 0x05 to control register
[I +0.078806] CLOSED
ok 2 /aarch64/npcm8xx_pspi/ctl
# starting QEMU: exec /home/tim/git/qemu/build/qemu-system-aarch64
-qtest unix:/tmp/qtest-974125.sock -qtest-log /dev/fd/2 -chardev
socket,path=/tmp/qtest-974125.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine
npcm845-evb -accel qtest
[I 0.000000] OPENED
[R +0.076480] endianness
[S +0.076506] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
"package": "v9.2.0-2138-g694a7d11fc"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
[R +0.079280] writel 0xf0201002 0x5
[S +0.079288] OK
[R +0.079312] writew 0xf0201000 0x1234
[S +0.079316] OK
Wrote 0x1234 to data register
[R +0.079337] readw 0xf0201000
[S +0.079341] OK 0x0000000000001234
Read 0x1234 from data register
[I +0.079565] CLOSED
ok 3 /aarch64/npcm8xx_pspi/data
# End of npcm8xx_pspi tests
# End of aarch64 tests

-- 
Best regards,
Tim Lee

