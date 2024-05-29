Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17579C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC7BM-00080s-NG; Tue, 28 May 2024 20:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC7BK-000809-Vg; Tue, 28 May 2024 20:28:42 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC7BJ-0001nj-9X; Tue, 28 May 2024 20:28:42 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so285413b3a.0; 
 Tue, 28 May 2024 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716942519; x=1717547319; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9OCHsN13xTs7QvAKf0Ll7OlCqJ1/9Trtkltfk5FJhw=;
 b=KQIRBaGrV8f7eib6D+RbT2HBG4pT3CB8ySD0NH8f0CZB5c7rfVPSdoj1vBe5K7rXIp
 5G17mTlaLbZp59KcyLGzPFxPgxX6hxGWBFmhC9CHFHjDDdMGNFRLiwvTeElZLrQDjfzW
 zxL4goxiRQnB26JLvy7FpPTAIutTXKqTN1jrnjvXELTnx1PgmusciP3gUXig8pjhz6oK
 V6LXo8iJFn1t+r/6zFmcClud885j1HxYhzJtzhuHxr4rWQtC+ZGrzCni5dZ6jCYNy//O
 bSayOQLY2Uu8PABIMGECQGaM3HpJTsmMAhjmQnFFTo+WHjkBuv9wAso1Q370QCjZ44GO
 MLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716942519; x=1717547319;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e9OCHsN13xTs7QvAKf0Ll7OlCqJ1/9Trtkltfk5FJhw=;
 b=HeStUX4apuI3VRRw+gW8jdDVI3KWvTnCxNidZnLRjPTGqVIPUltLFPddkycPzDyKvs
 Mg0gItWaggaX/bjr2L9lHh5fmUVfb8YJAtA4AA6Bsrb9SZHKHPe0wyP0K8uhuzcllCav
 e4CrgOiQuPVEWQXgRtCMBGk5Ks7B0+r55DPHAp+8OAvR29JGvxuHBWwGXvBh8QfIKPth
 b8hRDAp2b4YqVlQgs81wXQgd5f4tFK4T3asBu2xkO1UCC1idcDjcp/pF1zZcsQWX36YA
 tN/1+sOL1Sz1DC0TjExolanq3eaLZ4PC2D9jeadb2jEuXigUU/WKwV4xkhZ0OhMJWcsS
 fgKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO3tu22diSoKwvhPWg+0TaJya1k4IBQTuT02NEY3lArchoC8cDml30ih/myTvfMmmJnZ+3BDuii17U2AHsKEmJRmmXdKRaRc3hgK7ZE5XWzGudlUXycVG0FUo=
X-Gm-Message-State: AOJu0Yzqk1+TUYLV9I7xP+DoE6qzXMuNHhyFYfoMkS/FWDoahj8Zdv9v
 yS6Ui0YZukCxfTNfCGNMF0kHVx4WPUcd+ve9ramVgiNfPQJHDgamLm+8ow==
X-Google-Smtp-Source: AGHT+IHFxUHA3E+ayZd15eriMkLxEIJ21N+wEAoX4AvH6eeLO97eaMLEugslVZefNyPciuCzFkKM2Q==
X-Received: by 2002:a05:6a00:3020:b0:6f8:c94f:578a with SMTP id
 d2e1a72fcca58-70202c0508cmr780087b3a.12.1716942518733; 
 Tue, 28 May 2024 17:28:38 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc163a94sm6969422b3a.77.2024.05.28.17.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:28:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:28:32 +1000
Message-Id: <D1LPBPFH9DL7.2ZXX9I94PCZUB@gmail.com>
Subject: Re: [RFC PATCH 06/10] ppc: Add a core_index to CPUPPCState for SMT
 vCPUs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-7-npiggin@gmail.com>
 <0d8011f6-653f-49fb-9cd8-008fc0029d78@linux.ibm.com>
 <e18f4a73-055c-4fc9-bad8-26a9a70fe081@linux.ibm.com>
In-Reply-To: <e18f4a73-055c-4fc9-bad8-26a9a70fe081@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Tue May 28, 2024 at 6:52 PM AEST, Harsh Prateek Bora wrote:
> corrected typo, it's bitwise.
>
> On 5/28/24 14:18, Harsh Prateek Bora wrote:
> >> -=C2=A0=C2=A0=C2=A0 (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_valu=
e &=20
> >> ~(cs->nr_threads - 1))
> >> +=C2=A0=C2=A0=C2=A0 (POWERPC_CPU(cs)->env.core_index)
> >=20
> > Dont we want to keep the bitwise & with ~(cs->nr_threads - 1) ?
> > How's it taken care ?

For these accessors it actually just wants to have something that
compares if a CPU belongs to the same core or not, so exact value
doesn't really matter.

Maybe the helpers should do that comparison. It could possibly even
be a class method to be really clean, although that's more costly
to call (but writing to a SMT shared register is pretty costly anyway
so maybe doesn't matter).

I'll think a bit more.

Thanks,
Nick

