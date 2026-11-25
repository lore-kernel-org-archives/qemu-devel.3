Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=VFArBynu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWJCE-0003oD-OZ; Wed, 25 Nov 2026 15:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xWGxE-0005ql-25
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:38:49 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xWGxC-0007UQ-8Q
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:38:47 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67c0bd676eeso4314616d50.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:38:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795628324; cv=none;
 d=google.com; s=arc-20260327;
 b=DUjqUEYAeN1++zFc2Yt1GhE4rCtSuenV+Y4+JuwEeQnTX1AteQGqW9uBCXj6Brnp80
 oaPvlBEVE3wz+IsGhhyNw2kd9PPYlKqqNai2kSLFcSZRD+Qtvu6L3+3b93RXh0+sJNCB
 QQjvF+2bGHFswagP/XQVUSYOH5xFsu2b9rNiaIZmqHon6TSIaR11LudpM29S5onjglxo
 HkXDU5l7rkg/9A7ZEEDcbxAXHm1RFJWOsnlj/ZCVaxN9vdXzXnwQSDVARhQH5zm9RrGh
 mYmyyFapU/bgX6xj5fHlZHZ8525+1y/PVWqYysUHE9TfVjIuekrq/wB/I2+zQoED0c9x
 WIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yg2rtayaj+yDc6xyYp07Hyzvzpn7tMq3vAWY1vPC+bA=;
 fh=oG5ROaCBdD6B1Rv5q1eIc7VNMs+1XjypOEja+EKWGgg=;
 b=Qb8nVJ3HqjMxGx0cnChQEwoYLfYEOrFnPPGySvEnZHWT0a86nGCgIMn2he+GoLoEQz
 oIufIFl7GiZJ7piPXoOO1NQk5ekvqYHsZbI5WnN8jra2n55q+kG0ZY9ltPzUt7HQbG5N
 Lq4vZOgZofK0A65HdRchypT9tHgQGM1fb5+EmZLWtgF6YMLNYHU0WwDXXMWDI5hBhc2Q
 gTRxeo3m2xM4wHSRwtnve0nDm62RHS+bk6eHF3luik4iOxXbBxLV1ZsjfUj9tgMYC5zp
 QcSZXnG0vYY+9fSMra4m/186bXu1hAXMKUVfX5HfEcDGi2eANzeYjDAvv7sbqIGKFU+M
 muGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795628324; x=1796233124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yg2rtayaj+yDc6xyYp07Hyzvzpn7tMq3vAWY1vPC+bA=;
 b=VFArBynuNp9fwJ30tp8LNLWky4hE5vIQVq5VsYIKOYZ1IM7Mi9OszocOnH5iS3uEHy
 gE0nzdW2PwXwmhq5moDcDfz04SqtedMrT39mJpjt24uTeKAKjWFCzemproLf9ax82d6y
 EZAyq8HvazCeZ5768zO9w317Jx4XhE39mVE5YlqTZ0ivDmA7kDVkqKFbo/nI1iGIrVLq
 ooWTZMHk/ILR5f+aHbJNZnla9ORO3bS+KBq1PgaQmu9v4CR4kgDkKenol/eLXOGd56XW
 mzhTDEKJnsM3UNdNGbY5OaCDx6jwWj/lQ5WLkMMQ2qavefImc177TECyw1mpH4eUXBhg
 5YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795628324; x=1796233124;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yg2rtayaj+yDc6xyYp07Hyzvzpn7tMq3vAWY1vPC+bA=;
 b=11b8apHe1DmDa+L+DCneVrEqRdgWM1pI34SM76GJpznRfvlIZuIqCAZmOz2ZCxOlSI
 omKyf0RRgpkLrocEXA83LFMcTv8otyP/5jcEuCPIRZ5vKViojPQL247+ru0n83w0LEvZ
 Jl2KfLDSAUS28PysNtC4xwoyTWJbeSmzcR1whPhP7PIu2b0j4YWzcFQHdIFyFJyNQcCg
 e4xxIZeAsXkZTI1NTLb6Olpu9nL/01RwqmjkyS83OTjV87fNCcULSCc21cIHI286FDmb
 Rptii9VpxTNDp1h76MQsqmO/kEb+G4bcRRXh5hxToauAdd7888oZkMbVyGyHBHY6hxoP
 AkMQ==
X-Gm-Message-State: APuU4Z+jwxeUVf9ejgplxs+NmYmo1sG0AfrgyZ40BVh7ULBmnrXFupT8
 TKgxTL5qPb4CNyeELD2eclhpN+EYiuRBZttR3FRKv7iBqlHzkgPRoDj6lDq6xvOBasfQyyif+GV
 MF25Zsxw3KsVzL/7+N0toKS0PKZ4GhrndLPR4B0wI/Q==
X-Gm-Gg: AZFdTZcGhgx4QUOjBTh8GLFQwFTKd1jxBeRtbgsMVilE9qkGKHmQKa1LhjKWIlJCqYC
 QCLD2jnakkNjy01Z+woipv9WFc3Lh+0b3Ye/MwpRppwQo7HPKVswKZVurB3eoNEOBQSo1fxHF05
 HBt7X/9n8PJZTiFlIF0EX+9x14OCguDjOdWP6unntKnVhyIjd5Dld/2rohhlHX5vev5vOHB9K11
 TKNJNrgsPmas2evptfS+/s+dAHmPB+PWiQ+wnbX4lw008Vs9ndyKmjnGw3uPno65/Lh8ClBkp6O
 eR63tCR8gkkZRFqvzRJxyiVjmiO6AE+tw4kizSFPtmtSCQnIv3vCAkoQVNZR5K2y57kkLZ2/1Be
 wLDo7q4vDejM1xCzAcK7hEnCLSvoANEnfHpHNf1OImLpOiOQFCEg3cgPZ2ezwudetRnKzYKaEhn
 kOU6nZX24t2eO6zCOAikpCHeyICA==
X-Received: by 2002:a05:690e:b84:b0:67d:c045:d0c4 with SMTP id
 956f58d0204a3-67df43d0811mr8510530d50.19.1795628324363; Wed, 25 Nov 2026
 09:38:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
 <20261125100604.128764-1-w1355457260@gmail.com>
In-Reply-To: <20261125100604.128764-1-w1355457260@gmail.com>
From: Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Date: Wed, 25 Nov 2026 11:38:32 -0600
X-Gm-Features: Aa3M54puAqjfTj-0Ucj035gGMODhbk0Tuntpvz1M-3rvT8iwGPSu0Yk6VtdsU3o
Message-ID: <CAEev2e9YBm-rA1+-mmw-qF-5dLw7uO0o=knHh30KAyDVepBsfQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add Spacemit K3 Machine
To: Zixin Wang <w1355457260@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 15:02:22 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zixin,

On Wed, Nov 25, 2026 at 4:06=E2=80=AFAM Zixin Wang <w1355457260@gmail.com> =
wrote:
>
> Hi Anirudh,
>
> Thanks for the series. I have also been working on a SpaceMiT K3 machine =
model for QEMU (a Linux-first subset that boots Linux through OpenSBI), and=
 I have qtests and a functional boot test for it locally. Since your series=
 already covers the K3 machine, I will hold my own version and not send it,=
 to avoid duplicate review effort.
>
> Would you like help with tests for this series, or do you plan to add the=
m yourself? I would be happy to either contribute tests (I can share the qt=
est/functional-test setup from my model) or boot-test your series with the =
K3 SDK images and report the results, including a Tested-by tag if the test=
s pass.

It's great to hear that others in the community are also interested in
a QEMU machine for the K3. I would suggest helping review this series,
get this upstream and then add features that are missing.

I decided to take the firmware boot approach since we already have
many machines in QEMU that boot OpenSBI/kernel via -bios/-kernel (you
could use the virt machine with the x100 cpu type for that if you
wanted), and the full firmware boot approach felt like a more
interesting problem to tackle.

I do wonder though, the tests builtin to qemu use kernels from
tuxboot, and the newest kernel version available there is 6.18 that
doesn't have any K3 support (and no dtbs either). The builtin OpenSBI
rom is also older. How do your tests work then?

I will probably add a test that boots the fw via nor flash (with an
image hosted on my github possibly?), loads in a kernel/DTB/busybox
initrd and check if we reach a shell. I need to figure out where I can
get a kernel/DTB for this.

Regards
Anirudh Srinivasan

