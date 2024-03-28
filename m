Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC457C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 08:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpksE-0002Xg-2c; Thu, 28 Mar 2024 04:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpks6-0002UJ-Mb; Thu, 28 Mar 2024 04:12:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpks5-0000i0-7X; Thu, 28 Mar 2024 04:12:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso14043065ad.0; 
 Thu, 28 Mar 2024 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711613543; x=1712218343; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikyYGg0csAy2M48ddfYE3urQ2G5N3RaTgz0jBFpor28=;
 b=dtPv7mWDlsdSlCI2l4RR6iC5oxBfM37wuknLIvfCXVMeMPkNlc3u1M1fqaM4xXrEZQ
 7B5K+xNsOnlbmt+cpdlCXhFk1DFP6X+D4IEI8CdT8Adn1uKuu4Y67uyiQeXppKaAPWYA
 nDCxbf6/a0ALPnMsno7Kucngl3Hf6aDu+JsmgMrI+flXygAqJg2sPdl7I/zFRC0F5tg4
 BIfEF2FvMv0Zl4wzWkZD3J7SfGdap7+Z8CUA9yiqyXCOdhpKugBjB2mw4NtSyYw6eQSG
 lBUsWQpcCcdp54ZR3HemgGcsop6vcfgBMhxz7gklJ88hLQaOw1+jFw1BFVqFiFPVDPhK
 6alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711613543; x=1712218343;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ikyYGg0csAy2M48ddfYE3urQ2G5N3RaTgz0jBFpor28=;
 b=D3tvJ3jOvUG0eT/21aqjxfQZuGOvKRKVQou8PGhb8lrtWT3pmN0IKUbZGf81Z/osNQ
 3F4NVOFRsU4LAGuHL4wYA21EUXlotHkRAmHq5Dkc1raN5h/VZf0Om3atl2vNPUioaEPg
 ysfebfIFvSFCJNFmwV3qYD3H1vat6owWfoj82L7gcawgR7vAF/bC5u8FEXTJJr9zt/1U
 /YlMEaMH/Uj1NTovp1EXvRxXfAIjRfDr2oJ2WO66JFzRgzEw2ut0o9C/ti1T0Gbs6eNa
 lLxdIJFkrPBmtHz6OFZpvoyzPmkI/hwMLXdCQseKYtK9kicJ0vH4pZ4dbGvpbvBb8mac
 IzPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcU0xN/xz3QDyaukZLdAQuXX8U/g67d2QISv4Z5iG5JVuzPhBPsivxGPTffqa9AGJhEcoB7XFtYOe6/7fLxkPEDa0/25lUmlK4f2UPrwOSNdW8Lj7LFWSVhiQ=
X-Gm-Message-State: AOJu0YxVLjuSSba4WijeFK3s/72hLdlsnNXrVDtI4etsta8F4tUCOoMT
 q3qxV8sfO3EUZ1mp/n7LGxo4XqkfopBEaaGLmcBC3mllquunf5VP
X-Google-Smtp-Source: AGHT+IEXySBSVnY/x2iGa9qafj+lfgJp61lvEmYSrfAs6um41+2lQ39zwOqzRFm3cL+ndLvHuKTPgw==
X-Received: by 2002:a17:903:22d1:b0:1e0:185d:a73 with SMTP id
 y17-20020a17090322d100b001e0185d0a73mr2541002plg.9.1711613543077; 
 Thu, 28 Mar 2024 01:12:23 -0700 (PDT)
Received: from localhost ([118.210.97.62]) by smtp.gmail.com with ESMTPSA id
 kv7-20020a17090328c700b001e0d8fd208fsm901233plb.291.2024.03.28.01.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 01:12:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 18:12:18 +1000
Message-Id: <D058D0G7Z2DX.L8OBHHBGWGU4@wheely>
Subject: Re: [PATCH 0/3] target/ppc: fix tlb flushing race
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240328053131.2604454-1-npiggin@gmail.com>
In-Reply-To: <20240328053131.2604454-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Thu Mar 28, 2024 at 3:31 PM AEST, Nicholas Piggin wrote:
> ppc broadcast tlb flushes should be synchronised with other vCPUs,
> like all other architectures that support such operations seem to
> be doing.
>
> Fixing ppc removes the last caller of the non-synced TLB flush
> variants, we can remove some dead code. I'd like to merge patch 1
> for 9.0, and hold patches 2 and 3 until 9.1 to avoid churn (unless
> someone prefers to remove the dead code asap).

Hmm, turns out to not be so simple, this in parts reverts
the fix in commit 4ddc104689b. Do other architectures
that use the _synced TLB flush variants have that same problem
with the TLB flush not actually flushing until the TB ends,
I wonder?

AFAIKS it seems like the right fix would be to use _synced, but
force a new TB at the end of the TLB flush instruction so the
flush will take effect on all CPUs before the next instruction?

In any case this is tricky enough and I only hit it with a
test program, so I'll leave it out of 9.0.

Thanks,
Nick

