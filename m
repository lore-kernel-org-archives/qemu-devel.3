Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F3606A33E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xX92zYnJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWK1G-0006tH-R1; Wed, 25 Nov 2026 15:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWK1D-0006qQ-UX
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:55:08 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWK19-000699-95
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:55:04 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2f0458cc9easo50594045ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 12:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640100; x=1796244900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I8aZA+se1Jkt8jpO1gDa+uYGoM66BwVKnBUcBtFRbzk=;
 b=xX92zYnJaj1mC1NjwgWEZQMYyhih3iZ7Yaw6nbnfD6GTfCqNLseAff6sXtGLZCj6Bh
 75GDtnDU0KUHUyc01xuGHhRTzreWloAI6wD87u2IgFuOtEJnbxQpYxFyYe2lBAm2H8Z4
 WgBdDsVzONd7xVrBelXIub9ltqfBp5ZZcQgPMa7GJAlOoMUKbP17qnYymJjy3PTlH/fI
 z17DNjEHl1Y2Fuk5OUgNHRIkHYyhKDWH7f2LSxk6NNUYFAqkGBZGWmtKs6aM8dv08b5H
 74iPbOqI23Yq6VmGQ0GeX0EIfhgnnTOHa3Ws43Ku+47SVB3x2GjVWBAEpnm5I+J4I3eY
 Ht/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640100; x=1796244900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I8aZA+se1Jkt8jpO1gDa+uYGoM66BwVKnBUcBtFRbzk=;
 b=yI0R5bwoGRFUmZBKtVk6JRHNSkOR3zE1AqRLPoTX2bZgJFVFqz74bfMIFhLRNWbDft
 Ez7dU0CmMXiI1BPtzT1hjZJMrS7gLmxK0vF/KztphQc/VEX4c4VcRBAQYkb5VUovIy8l
 4EqHNdYisxGi3qi1jvI/MjkiobehiGSgghafyzZyROnXCAztWhTqsNvRMj9lBQTtEfBe
 GsAXle4sLdtWImm1kdMuRyLT+Qem2t2Y36fqo4/udzdSam2Sd8Pvf0ZmRogQD1Q/mL8h
 yoToCTrB78t28GA+luZGsnqjb6kWQglYUrABXSx7/ZQiN3k2S5ViAFOVixwr+RJ90S1t
 7iRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHYLI6av2S5FeeUQdjyWAwrjmQa8e9AYELAS1Z8j+ikAL+N1xCvzNLMUerWQMPVv2mNb1+6Bsuk3fjY@nongnu.org
X-Gm-Message-State: APuU4Z915VzDp1C23R5xW+jNYwYK1wzbTrhFVhiuK5ldUXtmgmXvxU3I
 eZjNvmHi1LVqS2Qo7tNTTvCBjkEnhq9y2BjwohKxPat9dxKwgu4suEHY8866j/Doar0=
X-Gm-Gg: AZFdTZc1oncMXhXyLEzRlLqO/ycR5Z50rqGd3/BK9NSgddD2aDfV/NtA54+KqZDD9xG
 rUZ6vPJZhZxqvqmgk4Il9338nlGvitVE3TeHSxd8475Yoqk5bE540NxLozOZcM2VH7QOe/MO/rJ
 9TvtzOrQoEgUvMx4/l4rMjXN6Sp92IrUPcBfBUuhB8tDmHVzFTtC4VWdTUH9yYNFshoLN49Mhli
 leDDUuINz+fUs6naKT6RuzAVxKPsjzI7bKU4Ukj+QeucdytpfYO9tKcfbnMqSF4dC7ciMB8Yb6c
 /JbQEUhWcNKTaNXUR5b1vz18sSIbkodoDJQktP+FU3oQmyfBOjxDJ1YevzP7f/27K6/r1LaqMOg
 0LSA7lxpYc2wzpPt9RAj19yTWEOe+oasdb/y+L+B5Niur856fSY1mXFIee4a4T/OrspzoKipfBD
 C9khKAnuXqWysg0Q0a0r3JTpmUpWIB5MQA9pjfjWnLaFpxekScRh+R5FZckMt0Ugg3LjW/YbNL5
 El/AOPH0rGkgxPEuYo3jLzIMIaJAwpU6xpI/4uhO63ohb5bac0CqXzoXSRUQNmOGM4K/2WZpfXp
 UxYo5jYbxFUYixGVCZcWWJlAH2GftfKKiZm+1EBTQfwJFEwgZk/fde9lATOiVcEK
X-Received: by 2002:a17:903:4b04:b0:2ed:1ef3:9ec with SMTP id
 d9443c01a7336-2f03f17d159mr189507135ad.14.1795640100062; 
 Wed, 25 Nov 2026 12:55:00 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee84425sm94471275ad.6.2026.11.25.12.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 12:54:59 -0800 (PST)
Message-ID: <90070c95-0742-48ec-8e42-8944347857a8@linaro.org>
Date: Wed, 25 Nov 2026 12:54:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 11.2 00/14] ncr53c710 driver rewrite
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20261125024951.10428-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125024951.10428-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 18:49, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 225d5bd4691fc75e32536428fc9a23ddb8e30784:
> 
>    Merge tag 'pull-nvme-20261120' ofhttps://gitlab.com/birkelund/qemu into staging (2026-11-20 11:44:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa715-scsi-v6-pull-request
> 
> for you to fetch changes up to a4de3d6e91850c2e7ccfe4e0bda86959f5b4fbe0:
> 
>    hw/scsi/ncr53c710: Bump the migration version (2026-11-25 03:23:47 +0100)
> 
> ----------------------------------------------------------------
> NCR53c710 driver rewrite
> 
> Rewrite the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
> LSI53C895A model (hw/scsi/lsi53c895a.c), an actively maintained sibling
> in the same NCR/LSI SCRIPTS family, adapted to the 53C710: its register
> map, single byte (DSTAT/SSTAT0) interrupt model, big endian SCRIPTS and
> table indirect fetch (the part sits on the big endian PA-RISC LASI bus),
> and 24 bit DMA counts.  Behaviour follows the NCR 53C710 Data Manual
> (Jun 1992) and Programmer's Guide (Oct 1990).
> 
> The driver is only used by the HP-PARISC emulation in the 715 machine
> and was tested with:
>    - HP-UX 10.20 installs and reboots into the installed system, on both
>      the Ignite (16700A) media and a software install that overlaps
>      tagged commands.
>    - Linux lasi700/53c700 installs and boots Debian off the 710.
>    - NetBSD/hppa 9.4 and 10.1 (osiop) boot and enumerate disk and CD-ROM.

Applied, thanks.

r~

