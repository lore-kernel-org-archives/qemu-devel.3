Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17B9C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsAz-0006n1-3Z; Wed, 04 Jun 2025 13:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMsAU-0006aT-WD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:44:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMsAQ-0004NU-TL
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:44:49 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2320d06b728so1220115ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749059085; x=1749663885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EEsPwnubASzkmTF/k7nd0dK924OU/Me/6bPKPn791UY=;
 b=LSaqVFU9aKeVFzMJW8R9CcfaRVPSqmQLUv/MoC85beydIDY/6rXzO8Bj4TunXIYZPa
 mH4CPJEpxdCosr7YXZr4tB9nGnQHp7ewQZVPrbuSwlRZYYXrxmBreJsEJPrR03vGiibM
 WCDCG0zlJLJa2ur7F5sPIK6kY3yE1cu+/gy/MlPUL/4PMqlEJ1hTXiSANlFNbwPcxL9w
 NnosDlHkvReJFGemMvKE4CHUD4aXtOUufgk8avph5C+V4DU7OYLhrW0zZl9123S2qxpt
 fwpIqmmApgaEzBe1A8Dcc0AtoIP3RnXlLT5WMot5EN6kEyQctLp6/9L2n0EofkJDwj8O
 j6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749059085; x=1749663885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EEsPwnubASzkmTF/k7nd0dK924OU/Me/6bPKPn791UY=;
 b=W66FFEMsSn4G2Spk7OhvZMmOE7FC6RcDxt/f36GHjUitDhRwqw7yuKfPqbGhjFJdeZ
 KKEB0Ex/37oz3nunmkCoKX+7xAFOipx5wbpwdTaHmPgXoRXP4XkjcIcSewZIJ5CAH2gW
 +yDaQbPvdotJNtk9DA/jeYc321/TDBcJ5TEfFsAd0zmKlgfrBUoCe1++SuMH79+j7IF1
 /0dQ9Y3J2NgTdLlazgAKrhUpgE9yc7siIm+AcfG4sahv+EGf3PXyAzqnu2Xfe4StnkF3
 eQg1DXE7R5uryu97MOGZlDAOT5TzuOrGCkXDixm9er/PeOUaBC07MozDNbb78zsXf9GE
 AuJw==
X-Gm-Message-State: AOJu0YxZT808PFZmJqyWgScQPrAHgU5L1yf428+a10h9ketWSlIc6WYC
 6ndeV3PsdjPuFfOSiMhAsnUq3EPpxEu9oGxsXKcmYkojm5a618oDdYQt+iuz3xNcHxhzdXFu7Cj
 wDsTDPupstw==
X-Gm-Gg: ASbGnctrMZmqrgyW6MBslrSdGyb9VARflvn55Z6KfQfpBjtYYEAPIvOYtyiYENnoeb8
 6WK/pEnr30WXWo5q0bb1ZQpRVZLWo0nIxZ0JVvtvvpbOIcdVbP6KqDZaspxoCb5mzi3ctPxcqZa
 rDS942vuZ3NEcvqfZz0fVcu2rZ9s2GhTJY8yHPunuXKFBNL1YtxZNxkNj9xaLCsYBtYky/HWUDP
 aX/Wn1Jx9RFpFOMmK/x7Ri1ljQs9KS/eDSiGw8vj3NLraNTjBdmJ+uEKHpR7sFP02SmOxnAhFEy
 i0UqBagJ7IbB36vHiMlM+rPW/+4u5oxny8jooq+A3yrPHPjmf8eR0LHJKZwquCcx6o/n+ibTnOL
 MCA==
X-Google-Smtp-Source: AGHT+IEzOZ4w9rbx4VWYVKmGQQvL1Py1SCsyh6g6feEkW3pogZACN85YnVQRnI63Ec0tZzl8Ht4EzA==
X-Received: by 2002:a17:902:f64a:b0:235:ec15:592b with SMTP id
 d9443c01a7336-235ec155a5fmr24948425ad.21.1749059084756; 
 Wed, 04 Jun 2025 10:44:44 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-235eaa077aesm7418565ad.7.2025.06.04.10.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 10:44:44 -0700 (PDT)
Message-ID: <e9cce3b5-1e8c-4200-b63c-c3e897620cbf@ventanamicro.com>
Date: Wed, 4 Jun 2025 14:44:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] target/riscv: add missing named features
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Please disregard this post - some old patches were left in the dir when I
pressed "send" ...


Thanks,

Daniel

On 6/4/25 2:37 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> In this version I fixed the problems caused in bios-table-test qtest by
> patches 1 and 2.
> 
> A small change was also made in patch 1 to avoid spamming "Disabling
> sdtrig due to priv spec version" warnings when running vendor CPUs
> with priv spec < 1.12.
> 
> Patches based on alistair/riscv-to-apply.next.
> 
> 
> Changes from v1:
> - patch 1:
>    - skip the warning and disable of 'sdtrig' for CPUs that have priv
>      version < 1.12
>    - update bios-table-test
> - patch 2:
>    - update bios-table-test
> - v1 link: https://lore.kernel.org/qemu-riscv/20250529202315.1684198-1-dbarboza@ventanamicro.com/
> 
> 
> Daniel Henrique Barboza (3):
>    target/riscv/cpu.c: add 'sdtrig' in riscv,isa
>    target/riscv/cpu.c: add 'ssstrict' to riscv,isa
>    target/riscv/cpu.c: do better with 'named features' doc
> 
>   target/riscv/cpu.c                |  16 ++++++++++++++--
>   target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
>   tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 416 bytes
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 


