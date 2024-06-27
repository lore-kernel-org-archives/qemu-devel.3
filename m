Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326E1C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlpC-0002R8-2E; Thu, 27 Jun 2024 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlpA-0002QA-Ih; Thu, 27 Jun 2024 05:53:52 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlp9-0008ET-11; Thu, 27 Jun 2024 05:53:52 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-80fc528a4ccso462742241.0; 
 Thu, 27 Jun 2024 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482029; x=1720086829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRkVQSX0SfYSuqjqmeNXmE2yHuROLzRDLocc86yFqqE=;
 b=ETRhEuvL8G8ZW8kMRWFbALxptmn629EDntdXEfMQI1bkM1JmdF4q0gAGqW14AqTB54
 oskcVzd1GVzdAboJtv7VPJ3uNrRIGPNCVTIsxPPYP5ZeuVRgdd4dvS01aEofpdR6Jg+h
 l1z/gac2Iij1qKjnGzuWi7f4Z5XYtg/MEbI7VV9X8OfTwIDuUKsMf4Z0GZCJ582ueCcE
 AxXc1XNAkiQdd/K7NAUdbGNPb2sU5zMQeCfy8nUnokSOP7erMCcErOA669lyriWLR+CO
 SxUn4jPmGtx4XMfRQ7mTkcgVhv7su12+2hRCp5BiQ8vZ3io5yNBwTlwQ/nMY1BMgTALC
 bo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482029; x=1720086829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRkVQSX0SfYSuqjqmeNXmE2yHuROLzRDLocc86yFqqE=;
 b=q/Lvauc1JnanBXZQBToIcBQUthDDHsbM+Blng0C7lYl20Z8bwdrm3W09X1s//04QOP
 8Wa+L8rxfCTuf+GwNNA8b44PTSZcjw/m4+ygWBu+PsClO6Ni1VJTrBY8XCWawczlQ7h/
 T1HQV0XUutWe+rP+r7DLqtN7vzyEKswpob0v42Aap5if7rSmLxfxqsVS10cxyywiQEXs
 fhHVwb3jK2REKx5VfoZAKmd3d2bpKQW1jczB7Xp5fEg557IfhI7fOLR/Te/yNGFBjM7w
 tHc8aqHUyqiCSpI8vNhGEQ7J73irmqHrwdpw6YU4lZLt7xBXxOwjXKYMypmlhvFCfgak
 Ii4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmK/DzjrvqSYtfgma/y6OB3vHICdIXAC5lQ8AulHpBKP2KCrGn1bDjRZn885wHc2mCMPSz24CTlnqeqGvlQ87XLWda64M=
X-Gm-Message-State: AOJu0YyAH9DXr24/oCAWWdm8dWqVxO4gB3gBtIq7p4trF33/s5OR+6bc
 UWTixuszFo4qqVg9HK12mMnbGERLBDoWxDdXIZo+6FY028kj1GwatDaV5aHHMWUqyXeAWvS1qGu
 tVZCRhZPdTMqnwOje5yp6IXQWAXI=
X-Google-Smtp-Source: AGHT+IGQO+ES4kCFWHmoAQke6PJt+Qr7+dikcxv/FOxctgxnu5xYg/ODLJZpdWV+geurdkZdAB8uBAmukBMQfiSPiEc=
X-Received: by 2002:a05:6102:5121:b0:48f:5923:d12 with SMTP id
 ada2fe7eead31-48f59230dcemr15727278137.34.1719482029581; Thu, 27 Jun 2024
 02:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240626132247.2761286-1-alvinga@andestech.com>
In-Reply-To: <20240626132247.2761286-1-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Jun 2024 19:53:23 +1000
Message-ID: <CAKmqyKPcN2J=YbvbE0Gk03CzfppT6M1cs=Y=e4jv28bVGug-cQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] RISC-V: Modularize common match conditions for
 trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Wed, Jun 26, 2024 at 11:23=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> According to RISC-V Debug specification ratified version 0.13 [1]
> (also applied to version 1.0 [2] but it has not been ratified yet), the
> enabled privilege levels of the trigger is common match conditions for
> all the types of the trigger.
>
> This series modularize the code for checking the privilege levels of
> type 2/3/6 triggers by implementing functions trigger_common_match()
> and trigger_priv_match().
>
> Additional match conditions, such as CSR tcontrol and textra, can be
> further implemented into trigger_common_match() in the future.
>
> [1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vo=
te
> [2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asc=
iidoc
>
> Changes from v5:
> - Merge first two commits to avoid build error
>
> Changes from v4:
> - Rebasing on riscv-to-apply.next
>
> Changes from v3:
> - Change this series to target Debug Spec. version 0.13
>
> Changes from v2:
> - Explicitly mention the targeting version of RISC-V Debug Spec.
>
> Changes from v1:
> - Fix typo
> - Add commit description for changing behavior of looping the triggers
>   when we check type 2 triggers.
>
> Alvin Chang (3):
>   target/riscv: Add functions for common matching conditions of trigger
>   target/riscv: Apply modularized matching conditions for watchpoint
>   target/riscv: Apply modularized matching conditions for icount trigger

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/debug.c | 129 ++++++++++++++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 44 deletions(-)
>
> --
> 2.34.1
>
>

