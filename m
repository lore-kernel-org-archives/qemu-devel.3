Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE32C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0W9M-0002h7-AS; Thu, 03 Apr 2025 21:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0W9K-0002go-CL; Thu, 03 Apr 2025 21:47:14 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0W9I-00061G-5o; Thu, 03 Apr 2025 21:47:13 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so2231774241.1; 
 Thu, 03 Apr 2025 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743731231; x=1744336031; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kzvgtvlzoow10HY5mV55hqeVI6sqbm+j+bfoLPR/5mQ=;
 b=LBlNjOb8oQc6rB7R/nwciBtitqXWjOZA/CFkbSkxIUqkBdsa2KBQCOC0HQTZSWjz7N
 PsmwuMwYKXFde0moo/sG46Ay2vyrta6fSn4EYs0ErgjEYVDjmKIgIpea+9cDs4WsTNxU
 9EJMWHeylXsBAESeay/LAjOctk7CCbFAdG0hnRSGeny/u89184YTKA6u/uR0fIyYl264
 tlDXgdQQ/3PkOTF4mg5oRyb4s9PVsBy5lTVmuC8tZAHypdNj8wQ2RNk1N+zaE89ERml8
 CDUTKA/Yxw66YYjnrT0Ziw5gVGdKcepUqFV2XpjQTjmWH/GpCMhSPZqDpaJ46oh9DA+R
 /3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743731231; x=1744336031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kzvgtvlzoow10HY5mV55hqeVI6sqbm+j+bfoLPR/5mQ=;
 b=SXhCb1ciSkfkXESLUztGCxPRJDsEEABDE5JfppCvGUFzMzctwYZgz/Ivu/o7pFkWOM
 RWiTX5aVpHZeY8OMOsky+it1PxJbc3Zz8GjkTeBYjGblUhbLNZDp5JrtejSieNPCdIB+
 xDhQfVuqUgURj8ikN0OzHcWyKeWnnFec2QwoIlZsdTj+NF+KTg1Q9roVP7ty4nt/ceeY
 w5IE/9pTt7U9XkRzonUaw922wJG3QBUPZx8+zrul100VX5H7oYJIinZK6OBrki9sxJsL
 cLR9onjh0SkRFnfduzK1wGTWMubH7PkLllVV/BwHZDkgVyzp+TPh5C4b6GE3fW6TnQQZ
 9gmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTqzZZroj8DMTel4LqHau7TepB4poWIJ731zjq4GjL2xD8gXFT/zu0LtwSOpgkj6xqbVNw4pqmFAX5@nongnu.org
X-Gm-Message-State: AOJu0YxdwjKkLvRSwUH53FwW5UmgRHSqPuos5GP/nO5UxHM+UX0DetZL
 7dbJQkFkP/BpVmusM2ZbFSMPLcUf7M44wuG+PqJdIZvu8BkymRyhxj9pijXmZwl5Pby7xM8K1xv
 QbUkG2aXzt/oW9g8roBYtuGh8HJk=
X-Gm-Gg: ASbGncut+JPFiY7Majl96QEDOea92yJ1jOljoKFbN+wKhewFPFEVh8af+iyAydtjHPo
 AJUpRetSR/63M6mLIDU/+AanM+14IxSt7ZHOKvAuGajKo40BpFnohbDBi6PcJ5R7YH32jZWOnFL
 0HiRhmCV7GNk9oA8QezHEe37cGntJr0RJoLMFbQNRUH47xDzPw8uTOnGoj
X-Google-Smtp-Source: AGHT+IEAxhkjolzRzVboc93m3Hj5HAmEleiMhHbKL1v8tBUuzmGxYWNt6ZtGTQVm175VVcm7CLpVOOf6VD18G1297UU=
X-Received: by 2002:a67:e953:0:b0:4c3:64c0:8b14 with SMTP id
 ada2fe7eead31-4c8459ee36cmr4298890137.3.1743731230711; Thu, 03 Apr 2025
 18:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250312155547.289642-1-paolo.savini@embecosm.com>
In-Reply-To: <20250312155547.289642-1-paolo.savini@embecosm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:46:44 +1000
X-Gm-Features: ATxdqUE5b6UJywlwqlK-1XcMc2XyBxqKvsPSyXdy8Bf6dgSuZ3LglhLp659ZF6Y
Message-ID: <CAKmqyKPQHkzNiR9rWn+6P-qsqE4ApB7epA2=t0C8NvwUdfLPmg@mail.gmail.com>
Subject: Re: [PATCH 0/1 v2] [RISCV/RVV] Generate strided vector loads/stores
 with tcg nodes.
To: Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, 
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>, 
 Jeremy Bennett <jeremy.bennett@embecosm.com>, 
 Craig Blackmore <craig.blackmore@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Thu, Mar 13, 2025 at 1:57=E2=80=AFAM Paolo Savini <paolo.savini@embecosm=
.com> wrote:
>
> Previous version:
>
> - PATCH v1: https://lore.kernel.org/all/20250211182056.412867-1-paolo.sav=
ini@embecosm.com/
>
> Follwing the suggestion in the following review by Daniel Barboza:
>
> https://lore.kernel.org/all/9be2ecc4-fed3-4774-a921-259f36e23b1b@ventanam=
icro.com/
>
> we simplified the emulation by tcg nodes of such a complex operation as s=
trided
> loads/stores by breaking it into two separate functions.
> One function implements the loop that performs the main load/store operat=
ion
> with the supporting logic to address the vector elements with the right s=
tride
> and to fill with ones the inactive elements in the case of a load.
> The second function implements the loop that sets to 1 the tail bytes if =
we
> are in a tail agnostic regime.
>
> Cc: Richard Handerson <richard.henderson@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Helene Chelin <helene.chelin@embecosm.com>
> Cc: Nathan Egge <negge@google.com>
> Cc: Max Chou <max.chou@sifive.com>
> Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
> Cc: Craig Blackmore <craig.blackmore@embecosm.com>
>
>
> Paolo Savini (1):
>   [RISC-V/RVV] Generate strided vector loads/stores with tcg nodes.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++++++++++++++++++----
>  1 file changed, 273 insertions(+), 50 deletions(-)
>
> --
> 2.34.1
>

