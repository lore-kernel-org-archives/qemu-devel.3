Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783BBCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEsRo-0004Ye-AR; Thu, 08 Oct 2026 14:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEsRm-0004Y7-Bc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:02:26 -0400
Received: from out-233.mta0.migadu.com ([2001:41d0:1004:224b::e9]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEsRk-00080v-FA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:02:26 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=jU6GDQ0fJbLuacS3jddnGX6Gx21ZsLiy/RhDp+9bc88=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791482540; v=1; x=1792087340;
 b=fZXWQdjw76bpfbAjHBsLkArGgU2omfEdH+dh9SqSxZyV1XUL473WnQgvspa1H8CeqYzNTpQ3
 X+rwHTiw8IS246BJQYCe6RWLPCzvyZ7H1F1epV+5+XeK20vtgNoXOfZX00JT4jTVSYMnNzANfvI
 gKEebU1BviXWNf/gETE33lB8=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id fb66060a02026bdd;
 Thu, 08 Oct 2026 18:02:19 +0000
X-Mizu-Trace-ID: fb66060a02026bdd
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5ba429b64c5so1065e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:02:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwiN1AI7OmQN1qmRmJt0/vLRcwYrKzyoG+3i4WiLPmXqV36omaOOpszN/Hl+FcM+WZdNP4VsHXgLNgL@nongnu.org
X-Gm-Message-State: AFq9FYJUWEkOUEqqqAWaIPxL/ee67yzXi/ZGhE6ipsNJ3jjx5EF9Mvez
 KypXOuNJgNK0zxJ3p7OW63zJvTGpxE8eE1/IsooUVlyH8hQEeXvk6OWVEHmRkg1HgBiOVTSH+27
 DpU2F/UkqpYgTYn2NjBrI7ppvfbQOHtNX1PGA8hrH
X-Received: by 2002:a05:6512:3e0d:b0:5bb:27df:415f with SMTP id
 2adb3069b0e04-5bcd58a00b2mr166665e87.15.1791482537918; Thu, 08 Oct 2026
 11:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
 <20261007080019.350315-4-fuad.tabba@linux.dev>
 <4ajscli4c4ef7agtizxzdiopjseck5qwa6s4n4mmwwjdrqlnby@xit5l76dxm2w>
 <CA+EHjTxsC8K1Bw6fAMs6APaqVDpup8192dCeJs+vfeh2fN+6Aw@mail.gmail.com>
 <3dqmrslvb3zrr3ndzmcmy2tv5vqovntordzdjqkp2vn2deklua@qkcedhe4owgv>
In-Reply-To: <3dqmrslvb3zrr3ndzmcmy2tv5vqovntordzdjqkp2vn2deklua@qkcedhe4owgv>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 8 Oct 2026 19:01:41 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwnpaFRFEzT8N34=t6JzKn+x=a6GUqa1U6vH2e+vW6C8g@mail.gmail.com>
X-Gm-Features: AclHuK8yKj6g9Ofrj1aWGEVt6NjDny5SPHd9V97LWwmYXzLzRa1XNrjqqSOSOSk
Message-ID: <CA+EHjTwnpaFRFEzT8N34=t6JzKn+x=a6GUqa1U6vH2e+vW6C8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add a test for the 52-bit TTBR
 base address layout
To: Gustavo Romero <gromero@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Will Deacon <will@kernel.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:41d0:1004:224b::e9;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On Thu, 08 Oct 2026 17:40:27 +0100, Gustavo Romero <gromero@redhat.com> wrote:
[...]
> RAM_BASE is precisely defined as 1 << 30 because the way we link the tests based
> on the memory layout defined in tests/tcg/aarch64/system/kernel.ld, right?

Yes. The tables are static, so they're linked a few MB above RAM_BASE,
inside the blocks both stages map at RAM_BASE (and stage 2 again at
HIGH_IPA | RAM_BASE).

> That's the bit that also confused me, like, how Stage 2 entries:
>
> s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
> s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK
>
> are taking us back to s1_l0. How s1_l0 ends up related to RAM_BASE :)
>
> Hence, I think it's worth mentioning that relationship also in this text. How
> about something like:
>
> "RAM_BASE is chosen to match the memory layout defined in kernel.ld. As a
> result, s1_l0 resides at an offset from RAM_BASE after linking."
>
> Wdyt?

Agree. The stage 1 and VTCR.DS stage 2 mappings depend on it too, so
I've put it on the RAM_BASE define for v3 rather than in that comment:

        /*
         * kernel.ld links the test at 1GB, so the tables below lie within the
         * blocks mapped at RAM_BASE.
         */
        #define RAM_BASE    0x40000000UL

Cheers,
/fuad

