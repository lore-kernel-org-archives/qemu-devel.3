Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98451C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 05:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjuHU-0008KG-PC; Tue, 12 Mar 2024 01:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjuHR-0008I4-5q; Tue, 12 Mar 2024 01:02:26 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjuHP-0000OJ-GO; Tue, 12 Mar 2024 01:02:24 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so4370118a12.1; 
 Mon, 11 Mar 2024 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710219741; x=1710824541; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ndaXPb7f1ih42QobnOClFJRBx94v4z3va6+Oiuxyqw=;
 b=IluCkkQJR0yzRWekestIsYICimZcL5LKG2TyDOtwR4a2lFzEqk5LAUH6pRhPb4Xqut
 qSK2kaJ4zfjKoOnieizO44iucfDL7BJo93Ji54ghRPVWARVSiFyNhCzd1TMKDYNh/A2J
 jcusgjAw+6jkv9tbYrpCD2FGbadbMYUtUlJowf9JeXejYQGRCLP3zir4CdQmABXsY6l8
 KGVZ+oYR2PAdXI32o+LLFzt2O+wabCHmuQk+W0CFL6O1JgbeWLWQvO6O4E4w4ABkJ6rv
 tTxXEasXlLNY7XX2T/rSt4GIShANVlwNs0wraHpKrZz7mvxLBIDjb4+ntxTUGIcRtZat
 M3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710219741; x=1710824541;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ndaXPb7f1ih42QobnOClFJRBx94v4z3va6+Oiuxyqw=;
 b=ZMp3bKWaailUxwzngacqC7QzBiBE5ceA8KOJhyIi+Nme/1Cj3/jxoFMSOXChiRkzK/
 RaCQnl/OcqKVwTOpFyeaNFlK+YN5ntFFIwswKO9XGO5ia7BCVIaYHd2Bn1yz+TRorZgQ
 UbjXGCcNB1VZ/YtTs5doTaSZL6bYV+IL1NT5XS/4dcvnouhCtb3PchG6tnVvjStRNHfs
 +Pgc9P8Z5Z1X9rEu16366xIMpNoL2gOI40ftmLc9WNdhgcbesWOf5CGdU8y3B6KEkAMm
 lxSl9sJlMNYIvgVbBGr6eYeR6rTEuFx4vND9Ozmb51GMRFKzVBPTjj2eO7RHzYaK6rCV
 Tu+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmNHLBsuFEFzXxNVBksTqNm4U6nbjM4ec//unenWePdxHSgbsxngGZ3zU4i5xM+f0f5A+ErZ4Pu4G089ZyLU3K7gQGdg+nkjdTKNPZVpYQ9MtvcYTH/I/J27Y=
X-Gm-Message-State: AOJu0YwlMCHzU4viqxVgw5/hURUMffiyEXV9kydtR22OFaU3CrN1WytM
 4RBH9Qyr8dpNAUuu7CLfHVcwJuUoiZH9a7t0hbs26Y5i07O1yPoj
X-Google-Smtp-Source: AGHT+IHXJZpdFpXcxK92l9u8RN+vFc/Pmeb0f9+l5yr7mHsjhWjpRzviXrweYLJMA0PNB7W29iDMoA==
X-Received: by 2002:a05:6a21:33a1:b0:1a1:87a9:5caa with SMTP id
 yy33-20020a056a2133a100b001a187a95caamr6647937pzb.29.1710219741329; 
 Mon, 11 Mar 2024 22:02:21 -0700 (PDT)
Received: from localhost ([1.146.55.44]) by smtp.gmail.com with ESMTPSA id
 n17-20020a170903111100b001dd6412cbe9sm5566183plh.252.2024.03.11.22.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 22:02:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 15:02:14 +1000
Message-Id: <CZRIARPDRC29.2377OJOQHTV2J@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 <devel@lists.libvirt.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH-for-9.0] docs: Deprecate the pseries-2.12 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311190459.66334-1-philmd@linaro.org>
In-Reply-To: <20240311190459.66334-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Mar 12, 2024 at 5:04 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> pSeries machines before 3.0 have complex migration back
> compatibility code we'd like to get ride of. The last
> one is 2.12, which is 6 years old. We just deprecated up
> to the 2.11 machine in commit 1392617d35 ("spapr: Tag
> pseries-2.1 - 2.11 machines as deprecated").
> Take to opportunity to also deprecate the 2.12 machines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> In 2025 I'd like to get ride of the code related to:
>
>   include/hw/ppc/spapr_cpu_core.h:31:    bool pre_3_0_migration; /* older=
 machine don't know about SpaprCpuState */

Acked-by: Nicholas Piggin <npiggin@gmail.com>

I can merge this via the PPC tree.

Thanks,
Nick

> ---
>  docs/about/deprecated.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index dfd681cd02..65111513cc 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -237,13 +237,13 @@ The Nios II architecture is orphan.
>  The machine is no longer in existence and has been long unmaintained
>  in QEMU. This also holds for the TC51828 16MiB flash that it uses.
> =20
> -``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
> +``pseries-2.1`` up to ``pseries-2.12`` (since 9.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
> -Older pseries machines before version 2.12 have undergone many changes
> +Older pseries machines before version 3.0 have undergone many changes
>  to correct issues, mostly regarding migration compatibility. These are
>  no longer maintained and removing them will make the code easier to
> -read and maintain. Use versions 2.12 and above as a replacement.
> +read and maintain. Use versions 3.0 and above as a replacement.
> =20
>  Backend options
>  ---------------


