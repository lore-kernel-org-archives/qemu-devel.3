Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EC606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eGtCw9/X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdqz-000535-LY; Wed, 21 Oct 2026 17:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJdqy-00052w-DN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:28:08 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJdqw-0002nB-Cn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:28:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso1651549a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 14:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618084; cv=none;
 d=google.com; s=arc-20260327;
 b=n99LcorT9f6srTH1k7RXSgCw3+/uTTjT0/sp+vdmMrJ67v8qE2QARIZXbflweQlhzq
 IzzfYv+5z8uX357yRczW3TNAQFyjWpnqadALw1k8ItkluCFmR6VJuJ07SSb2SsOlD9d2
 1qfemBFbiVcmPsk6cRo1vAt1kpxJcSw6daQ9u9jg9MtgDC7/wdqPoDdCXK5rLDN9lIiS
 XP5Rbu4/RBBpVMVq+Ls0rQOhJeo15jz2NR3ZVtRy1aGVG7uLmVqBXoZgzK0V8FQLN6x1
 ACdsOhLJfr7qkurMZP3fPypZ/IIZ+Am0Q/6N192gJVjv3kjTdgk9xVW4kmt7fn/kYFU/
 J7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=0FH+NcSpivZ5sFC7JTR8Qxg9K78cqE2VrFFHaNWlycc=;
 fh=Mp7S2o0aGNTBdX8sk69ozRTKPVMnJf5E1HEcRYRYP3Y=;
 b=hUMuPUCq4bBodMVNudJKPsy2zjvjUZe9AjpFnf/G+KwGRoG5x8vKw9HNzIqKUFyecP
 hR5aIU/0CL9atxmOJJLKb1Z9hWTgjb49O19pman2y6N3VF1faph9fAVXa0GVcD7t9BYC
 X+TaUeJCTxllQWIjfk60m8dvVg5BdlRL5+lvo95l+a16IJdvhMTMWpAVNq2pCaMSnWAI
 jdsxVCel699urbJ6ONNFHVlrfwXGK8MxLd8e6WdVFQSOR/gyIjG8tEfFTg6rXsmRNfCE
 65J5F83UTc9TOj2+t5MmFN9Q/mm9m+5W5Sop7oK5g/KHDDAR60aXbaoFxSjIM5GlcVGq
 YFHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792618084; x=1793222884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0FH+NcSpivZ5sFC7JTR8Qxg9K78cqE2VrFFHaNWlycc=;
 b=eGtCw9/Xt54u+JnXacspQs6sDCOqmJ8fFzmEs8zT42FzxhqiujxEAN1xfKhHfRYELn
 CX0oAknWzJ/qr9LwOovHtGgHpF13kMv9t+wte0x/vJ+SViydquJreFBanyCcFJqUbhqM
 vKx1Gu6ilqpGmsczPYsxy0+bS8UBEBaDTCCGTEg5f+KQ3HA3L0r2jpXFuRwLCw7x/nKC
 Gf5oF8pzXjm3sz2RHkjTJ6Orbgoxlo2GRh8nxphzktqWL0oLcJY0JhhQJWDCB7CTudBR
 ZteP4DS/z+Ck5dqSdRZlQUCiMPNCCFbmLMsSygbFUrnemBMSVwBWLJhI8DsueEWVpZ0e
 68Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792618084; x=1793222884;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0FH+NcSpivZ5sFC7JTR8Qxg9K78cqE2VrFFHaNWlycc=;
 b=sJnlre0R4e4eoigSVPCm6owOQ6HT7ch4Mw3evp1Vzi/lHWn6qb+pj/d3khI4tVVdQe
 UJkVMxuABJY6j1gcsE35SOILU/0NYH064b59aKAaHV3MaA+6FuPNuqh0lcULWQ8QqmmU
 N5BkTfWPjqHDvr6bn20saIT5l528ILNug7pGXDR3MVRpepbMGrsZJbC/tad/obZr1RwR
 5Gf/Mo58VS2/rn6+KU/GT+JryMLABlL+KQvNz7Jlqaybl4v9kG7rYk0zN9HElbJNr8KY
 POB6Tjg/QNExJM1S4Xj3d0N8Rlzonkg5O4QbqraCO9WgBK5b5tZUlcR72Qmp3TePj8+1
 se1Q==
X-Gm-Message-State: AFq9FYLp4zcHF1zZEBZXHWGZLxm0dtFwwQc2a5TDixwmghBpdRfS8oNW
 joxzQVNH7qOJz9lyl+XzQLBcfR9FVdJWvAaP4efAj6uBkVlNn6r69sESmTdgrnQQrB1R2XoB6Pg
 9woPzk9evR6P+HFffjKmLb5eD2r9tOyRzEY4tnHk=
X-Gm-Gg: AYBFou1pAcVU0yzkMyXDE30VSMGkFHxlxvXisoGobKH1ihK47y8NPVJ3TlsKo2k2Inc
 /sM7ao78ipMocE5T8mfp9cQLz6aIi9S6sKqN8QAOkVlM3DNLe1J6/AoM0F48uckbQVUS+crevcd
 EQdqGPfIURhmXFIUIRSGsbEzIR5JfGTHb7O+ex29fPS0TMqFvkEOmJuJdZItdJLixt2T3po9mCu
 2Qm5eNI/QSXm5B+Ff+D+wO7mDPB+uhDmVtn1v+75A3Zx5E2ZxlHVGJ57GoOx8NR3FGO1NGY5riC
 L3MdLN18UyD0OTDRJZkRtHgmctzUE1Ym7KnId9G8uD+9KMhxCRkIrT11ysgE8vE/vq0yqJNArsB
 1ZMeriJ/8Z1VME/AXeOaT0CfJYDg1uVgnrHwTZw==
X-Received: by 2002:a05:6402:5519:b0:6b3:d0a0:1358 with SMTP id
 4fb4d7f45d1cf-6b408f075dcmr2227858a12.41.1792618083525; Wed, 21 Oct 2026
 14:28:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
In-Reply-To: <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 22 Oct 2026 05:27:50 +0800
X-Gm-Features: AclHuK-V5KltJycT6MomEK_6jfWJMcp1yoIrpZdvFryXtMe3FUsiRxUIiF2kLko
Message-ID: <CAE2XoE88ma_mKg-40_3zOZyH3vtAndezpLp_5V6uM5DEgeo+1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 2:27=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/16/2026 4:22 PM, Pierrick Bouvier wrote:
> > This series adds this target to set of multi-target.
> > Changes are straightforward: functions and helpers renaming, and one ty=
pe
> > restriction for this target only.
> >
> > While the series applies cleanly, it will need those additional two ser=
ies to
> > build multi-target test binary:
> >
> > - Based-on: 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
> > "multi-target: remove dump functions duplication"
> > - Based-on: 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
> > "multi-target: remove qmp_query_cpu_model_expansion duplication"
> >
> > Usually I prefer to wait for series to be merged, but I have good hope =
to catch
> > the freeze date if current series is reviewed, and send all three at on=
ce.
> >
> > v2
> > --
> >
> > - make virt machine only available for riscv targets
> > - enhance multi-target test to detect duplicated types between all targ=
ets (we
> >   missed the virt machine since we were always picking the first target=
 avail)
> > - add an additional commit with the rest of softmmu commented for futur=
e work
> >
> > Pierrick Bouvier (9):
> >   target-info: add target_base_riscv
> >   hw/riscv/virt: make machine available for riscv targets only
> >   test/unit/multi-target: check QOM types can be initialized with any
> >     target
> >   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
> >   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
> >   target/riscv: prefix helpers conflicting with other arch
> >   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
> >   meson.build: add riscv64-softmmu to multi-target
> >   meson.build: list all remaining softmmu targets as comments
> >
> >  hw/riscv/virt-acpi-build.c                    |  2 +-
> >  hw/riscv/virt.c                               | 14 ++++----
> >  include/hw/riscv/virt.h                       |  3 +-
> >  include/qemu/target-info.h                    |  7 ++++
> >  meson.build                                   | 18 ++++++++++
> >  target-info.c                                 | 11 ++++++
> >  target/riscv/helper.h                         | 24 ++++++-------
> >  target/riscv/tcg/bitmanip_helper.c            |  4 +--
> >  target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
> >  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
> >  target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
> >  target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
> >  target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
> >  .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
> >  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
> >  target/riscv/tcg/op_helper.c                  |  4 +--
> >  target/riscv/tcg/tcg-cpu.c                    |  1 +
> >  target/riscv/tcg/translate.c                  |  4 +--
> >  tests/unit/test-multi-target.c                | 34 ++++++++++++++-----
> >  19 files changed, 113 insertions(+), 57 deletions(-)
> >
>
> Except if there are specific comments, I'll send it as a PR tomorrow,
> with the two companions based-on series, and with the current helper
> renaming, as there was no comment on general helper renaming. Helpers
> renaming can be reverted as part of general helper series.

Hi Pierrick
I personally feel a general helper introduced too much magic, I think
helpers renaming is fine.
If we want sharing a name, a more make sense way is refactoring them
have same behavior, such
as add/div/mul.

>
> Regards,
> Pierrick
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

