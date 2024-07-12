Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3772CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHCV-0007f7-3H; Fri, 12 Jul 2024 10:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHCQ-0007eQ-Sb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:24:39 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHCP-0005Uq-B1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:24:38 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77c1658c68so255160166b.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720794275; x=1721399075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U4/RCF17e3pFk8h8tUIJ1pGGBygiPYPdrkwAJWIIVfY=;
 b=BQtBJp6iCQQSHQkYhOtWsuBDHl/iUy9YQcoKxig4BZzUwFwm6qB5Grr6Vty1L26wXy
 gTUrMvYLC0yJH+bGCZ49zUExt/nqjx80t0drGYkSqtL2LfFABDGj7zlzvIVwMetDJGtD
 hVev5AAXJ94VVUL0qVPE/cUXgaxAmuVbeAyE862Fd9o/LIjlKPKTMRqIzd5zNaYKnQgg
 mEf9y3fpCrlsOuZygISjhgVTqhxw5f1sR3tQ7shsNATfOsVgPelDGqKY5xvyhVs8OPbT
 l1DPi7TmDt3Ou5PKmmz3zWOpP82r1vmMW4vbFnAeVLGQye806bLkCYWlay0wFcNoJubf
 DNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720794275; x=1721399075;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U4/RCF17e3pFk8h8tUIJ1pGGBygiPYPdrkwAJWIIVfY=;
 b=Rp7hwA5npVI5nBFtXeoMsmxHRuRx4waSTBAcz4o/9FPXtR2B1MpIWFQpXdVrM0meeO
 GSVRdn6aPL3ea6fb3qKAT+rNMRugSWtxF6FSYTBCh2z5t1rCOP/pRCrjpX1ghR9bCr0i
 x8FbPilhu3yEoL96ntSvSZK7HcyCpr3nsPdhZyWRl+Bu394zkg9OrLPRN4IRxge7Ov6m
 ctx7k/xhtpXUgtO834LRhO3LULdYNMDm501rO4yYTGrFRTeD0yrNQwfMwdOxSj6WJpND
 f7uX69TNuyax9pVh86mpRENvRncf1ttWIITfjDM9BdTm0VjbfJpgMwiOqgjDMmgFJCqx
 7MjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr8h9ZHymLukd+W/E3Bfn2P+/kgYnwOfaYaX1X2LSDX9RckTcQe9e++7cVLI6SQLUKkLadF0IHEccW1hYXeiOfUPks6vE=
X-Gm-Message-State: AOJu0Yyr9vxBsUasHjRpSo5gZ9TnSxuVto/W3fxS92pQPkXml8I03Ioy
 O+WNcwN+ZcJawda2asNe9RaBBE8AuFJUdmnNQwLVJeEIwteNwmMoZBQENJ2En7g=
X-Google-Smtp-Source: AGHT+IG9u3VlFwAOvNvr8+8H70sNfEBccmq6LkaHntA+8F5vN/TyQw8dyuDebU5QpQDXkE9IHWpn3Q==
X-Received: by 2002:a17:906:395b:b0:a74:84e8:9994 with SMTP id
 a640c23a62f3a-a780b7053e5mr849710066b.45.1720794275071; 
 Fri, 12 Jul 2024 07:24:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff00bsm349152566b.118.2024.07.12.07.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 07:24:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 739B75F713;
 Fri, 12 Jul 2024 15:24:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Ed
 Maste <emaste@freebsd.org>,  Li-Wen Hsu <lwhsu@freebsd.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [RFC PATCH] build deps: update lcitool to include rust bits
In-Reply-To: <CAAjaMXbNMnq5QuqfX=AZubMdL3npFGjqBRk1jYFFtgtteyaqUw@mail.gmail.com>
 (Manos Pitsidianakis's message of "Fri, 12 Jul 2024 16:21:34 +0300")
References: <20240710154335.2510260-1-alex.bennee@linaro.org>
 <ZpEBds6AUnPsVCY4@redhat.com>
 <CAAjaMXbNMnq5QuqfX=AZubMdL3npFGjqBRk1jYFFtgtteyaqUw@mail.gmail.com>
Date: Fri, 12 Jul 2024 15:24:33 +0100
Message-ID: <8734oer8m6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hi Daniel, Alex,
>
> I will pick this patch up with all the reviewed-by trailers for my
> next Rust RFC series if that's alright with you,

Absolutely - I made it for you ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

