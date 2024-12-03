Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA9E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMWJ-00068e-Bo; Tue, 03 Dec 2024 01:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMWF-00067Z-Qq; Tue, 03 Dec 2024 01:36:25 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMWD-0000ax-Fm; Tue, 03 Dec 2024 01:36:23 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-514ec8ea37bso1233538e0c.0; 
 Mon, 02 Dec 2024 22:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733207780; x=1733812580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY+kP7hz7PssZVmf49SEHTMuyYr94FiKVNhhoAYt/k0=;
 b=nU1xUJNgrJpgqBOByu4ZDaElIUlWoApqzHXImgi6aQmNVzBBsJhcqdBhEQg16Ckc6C
 JOPHLZB9fZqa+ESM63v3THfNvF0KYSM2mmyXVyhXfMJ0LVnyhuNoqySYZqA2/bM4xttt
 wp3sb3obX/vo86Usq4MTRndf3uL5/Gxb2WkbbPZEPGUdU7eNLzdB4RGLgBKg0kiTf13I
 wnjFSgb6gmkEnwwp0i9kAq9GekOjZJ6j1OYYdQHbscQ+SLMGk7x5tS7pS///rDVKUBLQ
 5p0a1cKVoTUJO4lr1C7wDjQy4ZPNFZGzjAiHwX6/6fiXWrAa4lHnQSiZTH4DeCG7zu8C
 a+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733207780; x=1733812580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY+kP7hz7PssZVmf49SEHTMuyYr94FiKVNhhoAYt/k0=;
 b=XmfcpRDQ0BscXe45jUX/abLRbqC+5/HJoycFPexCVMQDS0cwBh1CXrWq+RJl4v8zJm
 p/o4V5bEZRl3Ko7JSIBbu2l8QQC/IrWcq/fGGB70Zh4E7ymKo6P9DwejLCG/bo5mwWej
 bEoRoDXfK75wfWad2+mgklYtX2F0VAXfFXACt5tCgjk6/bkHuaq3KntiZDJtxs8JA/yj
 hKF75USppOJTEhP7mul5tkv+uGsivPPVPXy5aw9hM14iWC13bhnjNuVQWvyugtLm8CBb
 +6FE1FVwToIgl0ff/TmXPoHDe5AH9f9kBcMF4y9GpIt+sMQzRypqiINLhO4KMGA10M62
 t3Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+6pqKgvOtl5rEoPbeiX+kLqtV73mFfSOob2LNeXKBLLuY4Bp6ejDlasBYVvOlfL5cwPYgDGK3WgNG@nongnu.org
X-Gm-Message-State: AOJu0YxSuodc1BYaWBMvjP/FsQf3/P8vr7sD5OIEuqjr8Ddz2+F/qx5p
 f+2dMCvoZ/MD+jnvN0F/F8VpT8iG1HRYVRpe9YqPtA+zjL5Tb+doTaV+hvvS/DlQizqsAxp5k3a
 UWvwZTAK5yW5GacbY5eryLkV1O4M=
X-Gm-Gg: ASbGncsNhZ4SJyUSN966nzOI2jX7yp5Y4UUlIOLCR8qY+/6xEk4IBu5/5aBs/ut16E2
 UvzqeHO1JSXGeyqW6sjXVsUFQ1qsX9+zf
X-Google-Smtp-Source: AGHT+IGuX72dsU43T+kxJhk789gJga6H1gZ5heTsPzf8LDuKMbNEsKdrR/h/RLAJk9MVb5uQb4Qoa54Rx3dVOsohiF4=
X-Received: by 2002:a05:6122:2511:b0:515:4fab:301a with SMTP id
 71dfb90a1353d-515bf3092e6mr1970335e0c.5.1733207779835; Mon, 02 Dec 2024
 22:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20241129154304.34946-1-philmd@linaro.org>
In-Reply-To: <20241129154304.34946-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 15:35:53 +0900
Message-ID: <CAKmqyKNbL6QpN_jsHTptB1Oa=bFRuR3rNsfjsXrmti2V9=h_Bw@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 0/3] hw/char/riscv_htif: Remove tswap64() calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Sat, Nov 30, 2024 at 12:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Trying to make sense of these tswap64 calls I
> figured this device could be simplified.
>
> Tested using 'make check-{qtest,functional}'
> on both big/little endian hosts, no failure but
> I'm not sure the code path is covered.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   MAINTAINERS: Cover RISC-V HTIF interface
>   hw/char/riscv_htif: Explicit little-endian implementation
>   hw/char/riscv_htif: Clarify MemoryRegionOps expect 32-bit accesses

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  MAINTAINERS          |  2 ++
>  hw/char/riscv_htif.c | 15 ++++++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> --
> 2.45.2
>
>

