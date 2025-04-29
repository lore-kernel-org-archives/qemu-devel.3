Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC61C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9dU6-0006tD-3E; Tue, 29 Apr 2025 01:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9dU4-0006sT-Fc; Tue, 29 Apr 2025 01:26:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9dU2-0000m8-Qa; Tue, 29 Apr 2025 01:26:20 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb12so8768598a12.1; 
 Mon, 28 Apr 2025 22:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1745904376; x=1746509176; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJMtN93qAJDV52APutKw3aHE46j5Lu8zSEfK8s5WeDU=;
 b=ReO495Lpt77R/hW3nG5db3dIXMEObzfCQkTbNuxyncpeNz/hhFnET2dxChKWfxwf7A
 /WBDwCYDATDnwuyB4RFRxPWauyg8OKqXppi+JwPXYSyjwsu7Fbyzki9HJUv7RLTqoduU
 6EOiKyycPmOEptMIH4JfIrpQSBH1vGAUqkuyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745904376; x=1746509176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJMtN93qAJDV52APutKw3aHE46j5Lu8zSEfK8s5WeDU=;
 b=qsCiVYbfs1+Nk4KSRZUaiJVJQ78w+86vCDMiWAv9hJIK53ZhtW1jWBIFet+fD9RJsh
 +7wab8iGNamXzzrVDqpNDGyKHw6XX2opMhppHHjpLJ1WEAJ7JKCV5vww9kRdqdcs6HES
 1Hjd0kXMks0JNEXe6Xcak7OHu4+bqmQaMa/HqvkRbLqvgjNx1I8GoWwxdc+7MCrQRGgi
 Dcvwnrzrb9+VVPTg+vBcW8CPYg4VxI0ZQv8loRW22kWQF6MOnAIJurVW6rHbDEmYJLLy
 WtU+JXeFFxHIh+F9bdo1au8tgzALeG4z3+WrEGox9RMRUsIe0HA3C/vcAiYnhtX8i+Cy
 UNCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfGpBDw/9H3ghbxH1Ahqt6xHutqTEzMDtGrbPdBrK8AMbp9D+UVf350B49maMDFcO7Y5li/G6JOxvU@nongnu.org
X-Gm-Message-State: AOJu0YwBrdDVMSra+x7VtzehRyq61l6nPKe9yPdvhHVXw2fgZUvyFhfN
 HhGDOd4sX0Dq+N0oPBqXMWdxfsJAyBzBILEVEpTSoX9m1+r88BT+vLR+3rTA7Iz0afJet9U1xVz
 Bx5lPwoo7c9kqfsLWKFtUWvAPn1I=
X-Gm-Gg: ASbGncvsQ2+f9FdgO8Y8ffU/1J7rMWiKxS3XNXebD2ZkjaQmVZ/Zjb7RhfgWXzCiI1G
 oC91oXVsTekyWm+skZr35LkGsQAUgLjbKRQXcon/Crx/Pjl1COyMXf6s1nzmPnS2UZTOhx/KBkQ
 riaNlLgw/KYXonQMdPrCbdqgTd8+r3HYO4
X-Google-Smtp-Source: AGHT+IEDJTrIGjuw37CwcSAbcYTBfH626cKxE4Z5PpjpDbd36yB8JnEtSfZ6cp0xmoPWG1FbcMOGQj3sE3kBZL3C1w8=
X-Received: by 2002:a17:906:45b:b0:ac3:3d10:6f with SMTP id
 a640c23a62f3a-ace848c23c4mr689034566b.8.1745904376398; Mon, 28 Apr 2025
 22:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-10-dbarboza@ventanamicro.com>
 <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
 <3b31ef8d-87aa-4a38-8ada-39490f7a4908@ventanamicro.com>
In-Reply-To: <3b31ef8d-87aa-4a38-8ada-39490f7a4908@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 29 Apr 2025 14:56:04 +0930
X-Gm-Features: ATxdqUHb0qbtb1fwUlHSQ2aHft3JoRibGo78VT5wcuff3nMeg8esSQVWfAWdzbg
Message-ID: <CACPK8XfbATkk6NgR8GW3pa+UhjWJmbxRTzdUiCaQTGkogRHF3A@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Fri, 25 Apr 2025 at 22:03, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/24/25 6:41 AM, Joel Stanley wrote:
> > On Wed, 23 Apr 2025 at 20:39, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
> >> strings for uint64_t and hwaddr types.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> ---
> >>   hw/riscv/virt.c | 29 +++++++++++++++--------------
> >>   1 file changed, 15 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> >> index 036a0a9bfb..075c035f25 100644
> >> --- a/hw/riscv/virt.c
> >> +++ b/hw/riscv/virt.c
> >> @@ -309,7 +309,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
> >>
> >>       addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
> >>       size = riscv_socket_mem_size(ms, socket);
> >> -    mem_name = g_strdup_printf("/memory@%lx", (long)addr);
> >> +    mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
> >
> > I wondered why this wasn't a HWADDR_PRIx.
> >
> > addr (and NodeInfo::node_mem?) could be a hwaddr? That would make
> > everything more consistent.
>
> I didn't put too much thought about it in this patch. I saw that 'addr' was an
> uint64_t and just matched the format string.
>
> As for whether this 'addr' var and NodeInfo::node_mem could be a hwaddr, at first
> glance I don't see why not. There are lots of 'hwaddr' references in the memory API
> (memory_region_* functions, address_space* functions, etc) so using hwaddr in the
> memory context is valid.
>
> If we want to go further, the patch that introduced hwaddr in QEMU (commit a8170e5e)
> states:
>
> ---------
> Rename target_phys_addr_t to hwaddr
>
> target_phys_addr_t is unwieldly, violates the C standard (_t suffixes are
> reserved) and its purpose doesn't match the name (most target_phys_addr_t
> addresses are not target specific).  Replace it with a finger-friendly,
> standards conformant hwaddr.
> ---------
>
> So it seems to me that the idea is to have an abstraction of target independent
> physical addresses, and memory is a good example of that. I believe we're not
> making full use of hwaddr and overusing uint64_t. Thanks,

Cool. I've got a little series that I'll post. It cleans this one up,
and cleans up some other device tree things.

Cheers,

Joel

