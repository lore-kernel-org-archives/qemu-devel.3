Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48882C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLxza-00067a-Va; Mon, 02 Jun 2025 01:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLxxD-0005dj-E2; Mon, 02 Jun 2025 01:43:29 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLxwO-000316-1w; Mon, 02 Jun 2025 01:43:20 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a58d95ea53so6045921cf.0; 
 Sun, 01 Jun 2025 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748842949; x=1749447749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDjt/1Oq3qv3l1LceDFVzaa+v1qRMH9yh2FyC56g2ZI=;
 b=aFpDnYfCRY5X8LqPX0zu556NKlk1FAr4ifpeIijlGnEJVU0411yr8VfvFeMGzpxtjl
 WkRrNCqgZWSbfCpoTgxAAdW8KI9q3/h2VsMXkgS2pTLJwBwlAR1nOh8OeoqTecYpF7Ux
 X5YSj3bbI1oJ/Zttruek9aZKlhqSjuvNUuC+aTeadbCKiqDpWwMYTpgFGtzrVlLFinRD
 IqeTtKYB/Dh11VmrtX8xahlFExMcWScacaQjt3y3b1HaHn2kKuq5ikGxRbP9gc0CGXsV
 6r1pQ+uRiTCW0rwd6Qhxe/pnJE2N23bpZ6sX1GhVy24lc1c+o3Zc1m8D60o6k/Airfxe
 rSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748842949; x=1749447749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDjt/1Oq3qv3l1LceDFVzaa+v1qRMH9yh2FyC56g2ZI=;
 b=WbYTwBEAmi5pwtuHCvk1Pvo2epFH4+Y9qiqSlMqDnjJM1SwTaP0mXr71zoIp1FKY/c
 eAiExoZlAGiqty2i/+UMP2MlsN2caPvGx9CNXGKT1XIH55acLymFbEvKVVcEXdiZNGPA
 jTteU22oRjdATt/2wfP3UsBtsGGAJaodo0HhnlHPBWg2cUPackhAwFE5iKsRdQDkoXQ9
 lGmiW77nXJM6uspxwG/RJ9+ZKK+M25rgIJqujQu0Tq0IqgwLuYq/Li0I6tCtXahYzlJI
 K/VGAIB5045u1lLOzQA3snErBgL3eAlPOuXG+bkn2OaB1PEDsIPcVSiedkDvcLQ2NV54
 5nUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUq168/ibFoCiQdA2oMwN3l6tkmEwnrj4094mTnNne0fpdXUTKK6m+UerUi5rpFhQSSTVeYtTb0omg@nongnu.org
X-Gm-Message-State: AOJu0YwPUVkwBxYfLzDjsbVi5r6+/EmNAThJSf6Ix4af68koy6M+zSsj
 KZBKinK/YtJdzKFIkvztrPSWiLOHTYlzeRcVywWyJOBhuElyPQNI9rrPL+cNlw4OKTy2SFv2DlO
 YR2jub/Emh4qDOX5bl3sTJQpVq1sSaUuZpQ==
X-Gm-Gg: ASbGncs4mxNibvClLuWOT7Q31nXko8gDRc6IR2nqrlb6F++3dweG4iNQEU9OzZTvP01
 O1Ep3JgE60MA5CVzykQ243niDK3Rh8Z/5UO+gjRafb/99dr+dLiUnUYzmY8TrI5Ntvsa8QvF5PE
 IEZGCaefPG8j3Xfz97U8RiJvftYhkza73gfDQuus4fsMUbuLw5rJ7faYQYmPum7z4=
X-Google-Smtp-Source: AGHT+IHmQPDQwS79pC52oVn8j92v/e+7jcMPCc1tTanKme/Ppxwzrw0Lj5ZHVJ1bpGFbA5gMryoNX9/yLWK9/2tfr+w=
X-Received: by 2002:ac5:cdcd:0:b0:530:5b54:e035 with SMTP id
 71dfb90a1353d-530711eae2emr9482791e0c.4.1748839041791; Sun, 01 Jun 2025
 21:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 14:36:55 +1000
X-Gm-Features: AX0GCFsSs9L25y-to5GFCUKk9ZnkAJM6oUPN9FKZKfYMTtSLrXngMfHXRGnQp_w
Message-ID: <CAKmqyKPiKgnD_NxeTyQjG4i--b+vTKi3=yuYS_cC6HkCSRU1Sw@mail.gmail.com>
Subject: Re: [qemu PATCH 0/3] target/riscv: add missing named features
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x82e.google.com
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

On Fri, May 30, 2025 at 6:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> These simple patches add two missing named features in riscv,isa.  Third
> patch is a doc change I figured was worth doing.
>
> Drew, as far as Server SoC Reference platform goes, we don't have
> 'sdext'. I guess we'll have to postpone the Server Soc Ref work for now.
>
> Daniel Henrique Barboza (3):
>   target/riscv/cpu.c: add 'sdtrig' in riscv,isa
>   target/riscv/cpu.c: add 'ssstrict' to riscv,isa
>   target/riscv/cpu.c: do better with 'named features' doc

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> --
> 2.49.0
>
>

