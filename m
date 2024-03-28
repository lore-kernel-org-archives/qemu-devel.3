Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C47C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpn8z-0002sB-PO; Thu, 28 Mar 2024 06:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpn8x-0002ry-Jw; Thu, 28 Mar 2024 06:38:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpn8v-00029O-43; Thu, 28 Mar 2024 06:37:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so7165705ad.1; 
 Thu, 28 Mar 2024 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711622275; x=1712227075; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjtZ79gSoctoBt2DkkO45/cX6CE2CYNEeZPbmGuzzXk=;
 b=nQfS6KUYV6FsCDRHps/+lqP/HVmPzrQGTXdtUXJeM3uSvJs87hYyniuSBIljv0/GSB
 R6rodLcuBnXqNel9sqMhfNcMY0WeBTGwz+7cXuIRfUm7EeEOc8o5W8nGgNH+NDAURt9d
 JTgJ11lgpqtZaOYZqGsKoF/O+uH61diewrMt1F2V/bfPftmzF0eG3GhWKtaX6ubIU0hg
 ko1CduI7x5G6xe4ceI6yr48gbq8GqzBKx+9rlfJVedi4IwX1CPn8ix8aSDKBSVI/Jrdu
 GE1dbMlOtftuCyIRrAKtolPzqmHa3vhnxQPJ7CCugMfarQZRL5/L1jvQ76f6TkaRHIrI
 76Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711622275; x=1712227075;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sjtZ79gSoctoBt2DkkO45/cX6CE2CYNEeZPbmGuzzXk=;
 b=hj1tQo1BU5lGHbmAlKGoZTSBkTWxCCMeataCO9PRwaa/i5QX80N0muBXBnBAHO68aQ
 vR55fSo5I73iI8RZR2eMChCdVr3abg+/HNGFmD5kFPTsP+DKE/GvLWRActy6tfdGnppK
 bIX/tZnf1N2lc7w+/8Z8n+NU17aaR6BUarTL23MdMawkIFpBEb1CS0X2UyEmNiQxuuzl
 Un2SjOPWBjMxYicUEYYTcfIesCW99XDFsiyws+Jgnwfm61ILgsNegkzEx9O+LVEbsLi+
 3VYJAXjeODt15t6ytxSLEJHt4B+s88awLUxR6M8txn2/3e3ubbk5xByxKiTwDzZfyko5
 6zlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWta0V0pv+j94CROtUV62LI3Yh05FCHkieT0eJk9IG+u3cg8FFwRphdMrD5AH+jKneCHzlwRO1nwA17PITjufvndVWT3EPutO2Mcge/AiNaHjbNp3tgvzr/8hA=
X-Gm-Message-State: AOJu0YzanKYq8yR136FhGrW/bQg4ygI0Qtsk4PWcCs73gvjmToormFlt
 lqYXsC4J+LZI5U/cTX0yha56aRKkLQLLxurxnPK6HCOoVk3yreiP
X-Google-Smtp-Source: AGHT+IH7+apmRZ9kZmvyikampRJbrl2bulGBufhZOrMK9EqHCPJmydYtzuc8LFbimuXJfksh2pJulg==
X-Received: by 2002:a17:90a:b293:b0:29d:d7a5:91f9 with SMTP id
 c19-20020a17090ab29300b0029dd7a591f9mr1993222pjr.48.1711622275195; 
 Thu, 28 Mar 2024 03:37:55 -0700 (PDT)
Received: from localhost ([118.210.97.62]) by smtp.gmail.com with ESMTPSA id
 q12-20020a17090a178c00b002a017e2c24fsm3454034pja.37.2024.03.28.03.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 03:37:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 20:37:50 +1000
Message-Id: <D05BGFTTYF1C.1PG514RTVTZTD@wheely>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/3] target/ppc: fix tlb flushing race
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240328053131.2604454-1-npiggin@gmail.com>
 <D058D0G7Z2DX.L8OBHHBGWGU4@wheely> <D05AZMB7725S.27E3ZJNW7GJAF@wheely>
In-Reply-To: <D05AZMB7725S.27E3ZJNW7GJAF@wheely>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Thu Mar 28, 2024 at 8:15 PM AEST, Nicholas Piggin wrote:
> On Thu Mar 28, 2024 at 6:12 PM AEST, Nicholas Piggin wrote:
> > On Thu Mar 28, 2024 at 3:31 PM AEST, Nicholas Piggin wrote:
> > > ppc broadcast tlb flushes should be synchronised with other vCPUs,
> > > like all other architectures that support such operations seem to
> > > be doing.
> > >
> > > Fixing ppc removes the last caller of the non-synced TLB flush
> > > variants, we can remove some dead code. I'd like to merge patch 1
> > > for 9.0, and hold patches 2 and 3 until 9.1 to avoid churn (unless
> > > someone prefers to remove the dead code asap).
> >
> > Hmm, turns out to not be so simple, this in parts reverts
> > the fix in commit 4ddc104689b. Do other architectures
> > that use the _synced TLB flush variants have that same problem
> > with the TLB flush not actually flushing until the TB ends,
> > I wonder?
>
> Huh, I can reproduce that original problem with a little test
> case (which I will upstream into kvm-unit-tests).
>
> async_run_on_cpu(this_cpu) seems to flush before the next TB, but
> async_safe_run_on_cpu(this_cpu) does not? How does it execute it
> without exiting from the TB?

Duh, it's because the non-_synced tlb flush variants don't use
that for running on this CPU, they just call it directly.

Okay that all makes sense now. I think this series plus the
below are good then. Also it's possible some other archs that
use _all_cpus_synced() (arm, riscv, s390x) _may_ be racy. I
had a quick look at sfence.vma and ipte, and AFAIKS they're
supposed to take immediate effect after they execute.

Thanks,
Nick

