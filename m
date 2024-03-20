Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBCAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzC8-00011G-Fq; Wed, 20 Mar 2024 12:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzC6-00010d-PV
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:53:38 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzC0-0002L2-K9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:53:38 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso161738a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710953610; x=1711558410; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97WJ94tVaWyQDS20RBk5pqdtF/qrZ18uATSOj44Z0Yw=;
 b=WPA9QDjAdcMLKMcxHV7CKZFSNnNIpImqLzor0DO0PDnZsUnvXz1SXa4YK6zN5sY3nB
 Rh0UQPKe2UGHYhS+JFpGvijoSVde37SfzL6DqzXM/P0QfUr1gA9Ttc7hqKwYAaBnwRTL
 XSvcPRTSL2T30udc2WPuNRTHRi/F+ygb9mQU2c3n55Hv2TAQcqRIXi68hdJau6K1Ih19
 eBIvTM4uMBDTbUOPOQ1iuBlAvkiQ1W42/VV1B4lklB98BmnCXqeIcp9ejxjD9wb1KpA8
 2RPjSmJG2Pa6kFzNe/jzyVoLFwW1Ej9ec5js/sjmbQyQM7wp4gmoaQgFdQ7IwUCG5g85
 gq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953610; x=1711558410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97WJ94tVaWyQDS20RBk5pqdtF/qrZ18uATSOj44Z0Yw=;
 b=WA2cxKTblhMw4mnwyIL0ppbwp/kFP80I3vF34NgUFRE0aJTCVUrm9NwFJNWO8BuxA6
 gwyviYscu9nNU6Vs4e0SnmCUfqwpkVQ75kTrP82yVEYFs8amatpvejrmpF/WSsSUkSaI
 dogtt/89eSJly7STw977ZYCGB+Icoa4tbMoPlhMr4gG36hyV3RoNBqis9hDHzy5DSHqn
 XFgPQjE6FN27qFicFgts+8l9qV31dn/ycRCdeni4shYQmLi9J4A+FTqfpjFRQLnMKSU6
 bKzoEYaMhthP1WTdtBO50rYh/eyXEZPukkaA7rR8yy4ULR7TRPeSxbx1aOLb0b+OTyzC
 /Y6A==
X-Gm-Message-State: AOJu0YyyMBFedlMjcHxBFjj858sxLvkmiEI1KmVUnZCUuW9RYOCrLUMO
 uZGRvQu/LM/Y5p3t3NGTGMqMJxbaLdAHT/JvO7nFNAPhYJtTi9pykA3FMkTaKL1sYyk0s9gIFAv
 Ijol5f07pfM5iGMppuNkskeZWgXUXhS6SL4Iqzg==
X-Google-Smtp-Source: AGHT+IGfA+e/uejiuGPf1l9dSFjzQADCHE4VWpMn/O+sno8Klvk/y4uAEZWUysKaoE2ak7djYhw5g5lqwkt+cjGaq9g=
X-Received: by 2002:a50:cd93:0:b0:568:b0f4:fe69 with SMTP id
 p19-20020a50cd93000000b00568b0f4fe69mr200254edi.12.1710953610599; Wed, 20 Mar
 2024 09:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240320164055.60319-1-philmd@linaro.org>
In-Reply-To: <20240320164055.60319-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 16:53:19 +0000
Message-ID: <CAFEAcA81u9J9iijs-CNDbsANb6c0Cdb4qQKmBd=DiQAoFA4U=w@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 0/2] target/monitor: Deprecate 'info tlb/mem' in
 favor of 'info mmu'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Mar 2024 at 16:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> 'info tlb' and 'info mem' commands don't scale in heterogeneous
> emulation. They will be reworked after the next release, hidden
> behind the 'info mmu' command. It is not too late to deprecate
> commands, so add the 'info mmu' command as wrapper to the other
> ones, but already deprecate them.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/monitor: Introduce 'info mmu' command
>   target/monitor: Deprecate 'info tlb' and 'info mem' commands

This seems to replace "info tlb" and "info mem" with "info mmu -t"
and "info mmu -m", but it doesn't really say anything about:
 * what the difference is between these two things
 * which targets implement which and why
 * what the plan is for the future

I am definitely not a fan of either of these commands, because
(as we currently implement them) they effectively require each
target architecture to implement a second copy of the page table
walking code. But before we can deprecate them we need to be
pretty sure that "info mmu" is what we want to replace them with.

thanks
-- PMM

