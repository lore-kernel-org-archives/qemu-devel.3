Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A908AE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 16:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNfe-0000aP-7v; Thu, 02 Jan 2025 11:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tTNfV-0000ZZ-0h
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tTNfS-0007D7-KB
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735833801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psOMRh/cRJqSjkLrDaO1SdWNo6kSHdDkNYD1Db1ldek=;
 b=O5hCvjOszXS1TXIK33766E55RD9iwy79USOMEjxeyEe+eNfNrkVyq7GDZuKIHJTtXm8Q7x
 AxCnlfMvIOpvR2p/AMK+leNxnO2Kk+o4cnLBN43/DFeQDEsLrngOVnHMpAkCj7Gt45PNCW
 6AeQc6vynS2SSWSgMmciwGXGNxKKHPQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-uTEfqEH7PAaLtQF1EO5p3A-1; Thu, 02 Jan 2025 11:02:14 -0500
X-MC-Unique: uTEfqEH7PAaLtQF1EO5p3A-1
X-Mimecast-MFC-AGG-ID: uTEfqEH7PAaLtQF1EO5p3A
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467975eabdaso197739011cf.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 08:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735833733; x=1736438533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=psOMRh/cRJqSjkLrDaO1SdWNo6kSHdDkNYD1Db1ldek=;
 b=rKLo48vaycqCckA8pST7SiQVt4yUDCxfKJ7ZH6r2fZ7XsIf3+5594UzAU3A35JhEHf
 vCHmQmutKGUWS4nxYoJ5QkcG2bSQWqv7wLMGLjDDYaThzdML7mADXIWrmV5HKnIZaJ4t
 8K8BepXYjGYbgJvMdRsYNEQwiP/RXWi0rd1uZREWxn8DraAbqcGbSWCQchawib5ERZyM
 54HmV7lHhICmLt+op0rK86hUlVbEK4m8Yiu1aBToJNTNrZy0PffszEoBADiKBQFnfgRf
 H8vsLt8lNZmMDSe83/0O7vBKCQr8LmbckaHTTxLlrne0MUSfNkyMRRs18LvKtLXCuGD2
 NvBw==
X-Gm-Message-State: AOJu0YwNtdIyDqmvHUdpaQpqk2W/8hanQOvUW4akNkn6IY1hs0dcSCte
 OoqFjF8wCkviqIFaq4C5ltiN2w8roiHlL5RuaqVUqTuToaaW1Y2NJrxVzHnprM48Pepz092gHdj
 siFzODTHKYBWqFfVCq4StOZW6mtnKRliHDSvqnEcCMV79KYFjIYW756Sd/WSPnm+IWsIK3tv3pj
 VtnjAsCuegI7GC4J/PTtKJnMokf04cBz49QwY=
X-Gm-Gg: ASbGncvJZyr+ad70+TtAQFD84vnj529UHJfaSBZxZ6xNmATJgQgddm8P6vC1o+zfxaI
 ayOUzQnMfn1SpDxigO2dOr3EyBzYkThdRAtUU
X-Received: by 2002:ac8:5e51:0:b0:465:2fcd:cb0b with SMTP id
 d75a77b69052e-46a3b0c317bmr770573711cf.24.1735833733200; 
 Thu, 02 Jan 2025 08:02:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdHe74rwJVkYKfHlP5Mre8SJtrFj02ToSgRbnjulMHr1Fr5UoouURb6whBdbsYeCS1LZ+sSDYe74T6GAwIcLQ=
X-Received: by 2002:ac8:5e51:0:b0:465:2fcd:cb0b with SMTP id
 d75a77b69052e-46a3b0c317bmr770573491cf.24.1735833732947; Thu, 02 Jan 2025
 08:02:12 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Jan 2025 10:02:12 -0600
From: Andrea Bolognani <abologna@redhat.com>
References: <20241203094702.124748-1-abologna@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20241203094702.124748-1-abologna@redhat.com>
Date: Thu, 2 Jan 2025 10:02:12 -0600
Message-ID: <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 David Abdurachmanov <davidlt@rivosinc.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 03, 2024 at 10:47:02AM +0100, Andrea Bolognani wrote:
> Currently the script won't generate a configuration file that
> sets up qemu-user-riscv32 on riscv64, likely under the
> assumption that 64-bit RISC-V machines can natively run 32-bit
> RISC-V code.
>
> However this functionality, while theoretically possible, in
> practice is missing from most commonly available RISC-V hardware
> and not enabled at the distro level. So qemu-user-riscv32 really
> is the only option to run riscv32 binaries on riscv64.
>
> Make riscv32 and riscv64 each its own family, so that the
> configuration file we need to make 32-on-64 userspace emulation
> work gets generated.
>
> Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> Thanks: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>  scripts/qemu-binfmt-conf.sh | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

ping

There are already two ACKs so I think we just need a maintainer to
pick this up.

--=20
Andrea Bolognani / Red Hat / Virtualization


