Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE09CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEn89-0001Nf-NS; Fri, 31 Oct 2025 07:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vEn7u-0001MK-37
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:17:02 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vEn7h-0006sX-KY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:17:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6dbb4a209aso399474666b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761909403; x=1762514203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84dQQuQZUpiEJNbL90PnFW9aGRW5hOd6mnnFES7i4oA=;
 b=KGM1yap1SwcxJ4YR3+7c7tP5/j7vE3mJLBc3ptievdhfX6WnzJ0UoA8lPusuAUehtK
 N9Jl0zN/zz8qNCwAzxYZIdDxAvDgSoVOv3T39CLga1EzA+dPMAH6jNWh4ve7iIOe0xXc
 mhSSt68fiRl8lUePPvhmm7fkR7bCsQpAHVTXAI3J1S2d/LnKVJq8ehlNf1Qg5ZzzEqWn
 zni5NNlVOlzbfcwvT/Dz37DhAJ0wfETKgh3qEhNZ2kcbv38KhE6OC1Qpf2jCnzPu7Jwn
 U3ubZYJGtTg7AfK09M3/o5xI2DVGSV2tfHv9DkSQs70/H53V+FPV5bMCTq3SSs41bZ4l
 vUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761909403; x=1762514203;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84dQQuQZUpiEJNbL90PnFW9aGRW5hOd6mnnFES7i4oA=;
 b=XI4yepHr+32HaG8gO8Bj7T3wZjof5o/6Q78AFpzZJ3Ao4a7WpFQ/Zv1LCUtKkGDwyB
 w8rHdOgSGgvTwEMKF1WZuxaTSGw1SPOztMD9tDHIf1OZ8hDdrVwu+QmcV8FU05lhdxHJ
 Xn1zZj6J5+EuKe2Vep8wgClPuwEDP9JyYQWK3KO7YjQeUy8lOWNkrycVzjr7s0P2lVYA
 FG3VcSy6Lk8I5wmRY59brWdvo2eltorqNGvvKsOWhm//oc+oOggk9NG2erGowgyJq4mt
 0tcruPkaOf9J0I/R8jDGumoBSWPd/jw5b9G9E0PWZhpXD2uM535z5J/2hnZ49oHDhIdl
 l1kg==
X-Gm-Message-State: AOJu0YzUAGwL/FmBxzGYfQHd3qEg67YRjfydg4cBQ2EMZR6Hy7o4zse/
 RyhwE1638tDxAsikPttLVRwgZjcwEiSNkihIxVVCY5gcYMM6n4gq9yxL8jdQlA==
X-Gm-Gg: ASbGncsSJdIhK+YYeyNMpBA8DudE9VYlCDUiK55Uq1ao4H0FEp/sYZtB3wMvXxNglId
 jEECLdvuHJVAXY+kv/HNM5CfDweM1Ablon5YHd+9d+QN5nhS44qptRnst3O1M7hAqo076P0gRb4
 uHTkstEMbq/7KT5u0WmyZ1fiZvSg0o7NvIO+eael86QcBhb51q70vtX9FIh8AkeZ+3YWgzrWkoy
 tBR8ad2q3JUboWmwPzuS+KwwpJF34M7Da1llCp0JaGsBomjXji/yZCND5OCsGI7BmvEWTZRQToB
 SkJQYmUQiCpWgdcewtKoROqP60+wC04PfAPPLn3YKkILwjWYVHomffNyUNglTQk5F2hBY5FaBFK
 BgZUkKIo0Ar/2kUUVC92dqcoIh7Mpiw7LQV5E+jIj7wA6lsyHVb0Dz+sS6v8t05zQO/9bzDDiot
 B6wTadQ3TpeiYuNIT2H3o6Kp7kpcKUwBQa7dG2VetcKI7irkXWsYIPexu63C76hXxTOBBy+pn0
X-Google-Smtp-Source: AGHT+IHwClixWNV00Njyxu7hjC+/PMIoujD37hZztE0cJi/slSEpDngHxAXMujdFphFJRj9dKKZCOw==
X-Received: by 2002:a17:907:94c7:b0:b32:2b60:eed with SMTP id
 a640c23a62f3a-b7070624345mr288653366b.44.1761909402645; 
 Fri, 31 Oct 2025 04:16:42 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400e42d34416465d6be.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:e42d:3441:6465:d6be])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779a92c9sm149626066b.22.2025.10.31.04.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:16:41 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:16:39 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/2] KVM Support for imx8mp-evk Machine
In-Reply-To: <20251029142311.2986-1-shentey@gmail.com>
References: <20251029142311.2986-1-shentey@gmail.com>
Message-ID: <DD4D4E54-2935-4A74-BD9D-0C175F61687C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 29=2E Oktober 2025 14:23:09 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This series adds KVM support to the imx8mp-evk machine, allowing it to ru=
n
>
>guests with KVM acceleration=2E Inspiration was taken from the virt machi=
ne=2E This
>
>required a device tree quirk for the guest clock to be kept in sync with =
the
>
>host=2E Without this quirk the guest's clock would advance with factor <h=
ost
>
>system counter> / 8Mhz=2E
>
>
>
>Testing done:
>
>* Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
>
>  `qemu-system-aarch64 -M virt,secure=3Don,virtualization=3Don,gic-versio=
n=3D4 \
>
>  -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx8mp-e=
vk \
>
>  -accel tcg -smp 4"=2E Observe that the `date` command reflects the host=
's date=2E
>
>
>
>v2:
>
>* Mention various tradeoffs in the board documentation (Peter)
>
>* Accommodate for single-binary (Peter, Pierrick) by having CPU defaults
=
>

Any chance we could get this into 10=2E2?

Best regards,
Bernhard

>
>
>Bernhard Beschow (2):
>
>  hw/arm/imx8mp-evk: Add KVM support
>
>  hw/arm/imx8mp-evk: Fix guest time in KVM mode
>
>
>
> docs/system/arm/imx8mp-evk=2Erst | 18 ++++++++++++++++++
>
> hw/arm/fsl-imx8mp=2Ec            | 33 ++++++++++++++++++++++++++++-----
=
>
> hw/arm/imx8mp-evk=2Ec            | 21 +++++++++++++++++++++
>
> hw/arm/Kconfig                 |  3 ++-
>
> 4 files changed, 69 insertions(+), 6 deletions(-)
>
>
>
>-- >
>2=2E51=2E2
>
>
>

