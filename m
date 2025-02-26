Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E7C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 11:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnFvw-0001uU-AG; Wed, 26 Feb 2025 06:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnFvt-0001tc-E3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 06:50:33 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnFvr-0005S5-EI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 06:50:33 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so4774089276.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 03:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740570630; x=1741175430; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h2Vatto6nSrvODRy+Qu/VnnAtl5w9cRYwpnb27LlFdw=;
 b=IowpKkvqGHOdI76X1Ws3Ed2ahFLjft6Y633VX6ZKQOamvL2yZjyELZrH1q2fEBkina
 Rq052b1mIDlEEvX8pRhIgPr3IAcygXl6NPQV27DXqFVecCejH0VVUQ21zxgSOMMYGSkQ
 1GR3/7Ql9/0f5zPRh2xsSGwWqKWRU87+r9/pylszNgUwC7t2j8C8f9BwMyUN5gJoF9bX
 6TrweDRE23rNQSFhvAGxoudj1YGaXk1JoOmHbQ7S3eZ2VegaI73lniZhRvJteDLreSkP
 25pyeJQG7h6MjFb03LvcAVpfG/GFFSdrCnuraAez0B+Sj6AtQ+juXu6NdUU+u3uFDu51
 9NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570630; x=1741175430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2Vatto6nSrvODRy+Qu/VnnAtl5w9cRYwpnb27LlFdw=;
 b=i1VIMFNbOGRD3/WNYSZLKvjTmKsm7Ivv1w8HDD4Xps8XNYhB+qYdY/ddMgYxvD0UEG
 MrWKLflvhDGFWceXa0PmEYiyvrYo9xxVYhR4aT9EHproSzr2gSgGFID/Efvs/FqBl044
 43uKyKwnvQyVqwp4jaxKX0VM0iYpp2gwHopOHceY/JbN0dopyNxSGKVeBMGQ/fJK8ksS
 ixms+tpEaew4GxbnDf1Xyg/g5fPwia0XIeQ8Gti0kReu6dhO3YIynK2JswLT7I+4kg81
 n0kYM1WvARUbaM6ULVVxkOxG2QAThM1h7nQ4oaEdU0eK105BrXlCkARs/IUvuragJMCB
 HfvA==
X-Gm-Message-State: AOJu0YzTSBGuIQOqOe+eudNPjHKMUJ+CaISscEwcmQVUHAEjO95qAz27
 ZIBYAblU9VoMDCyA+nVL4BDzEkRVdERc7mN4UsPAIPSel1fY5C7wZz3vuOegQNRYAzjL4A0n6wu
 oVvhteaivR3nIuQjH2C8pxQrsSp7VNHeJvr6v6Q==
X-Gm-Gg: ASbGncvszvnlL8Rh+w6TNqVqrxVwill+zAzITCd9v9X7QmN0iH0ROMa7kvNp7wTkXs3
 PZx4T6tisLo65jz5qsz5ee6UHEQZgzU9tqcEnlWNHah89E+WdmjdBH22AlYiZOPnehUb7rH79OY
 s7aafQXPdp
X-Google-Smtp-Source: AGHT+IEntVP7mzhZuoiwFprgLLFGyyXzVP+gOViMgUPRwWFxrrg6pcUUyL3LXnZkaSOFrICXuQErwLWhvLChmRtaMtw=
X-Received: by 2002:a05:6902:1b04:b0:e58:30dc:615b with SMTP id
 3f1490d57ef6-e608a56d282mr3011080276.22.1740570629981; Wed, 26 Feb 2025
 03:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
 <829e9fd0-2d0f-45e6-ab89-d933d344cfe2@linaro.org>
In-Reply-To: <829e9fd0-2d0f-45e6-ab89-d933d344cfe2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2025 11:50:18 +0000
X-Gm-Features: AWEUYZkTC4CfXKM-iA9oHWkGexNeyUEl9CBDtKNHRCHZbKN9AzbswPYxU6-joBU
Message-ID: <CAFEAcA8BHzA_P7yX+cDMb1WiyGTzkh6xjvam4RHs5aoM1X6mkw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, titusr@google.com, hskinnemoen@google.com, 
 wuhaotsh@google.com, qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 25 Feb 2025 at 20:57, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 2/25/25 05:41, Peter Maydell wrote:
> > (Looking more closely at the cold_reset_values handling
> > in npcm_gcr.c, that looks not quite right in a different
> > way; I'll send a reply to that patch email about that.)
> >
>
> It may be a hole in our CI right now.
> Would that be interesting for CI to run all tests (check-functional +
> check w/o functional) with both ubsan and asan?

We do have at least some ubsan tests in our CI right now
(eg the "clang-system" job). The problem with ubsan coverage
is the usual one that we already have too much CI going on,
and it takes forever and we don't have that much headroom
for adding more jobs.

On the asan front, also, yes, coverage would be a good idea.
Here I think we will probably have to gradually ratchet
up the coverage because I'm pretty sure that at the moment
we will find we don't get a clean pass (mostly for "uninteresting"
memory leaks).

(I do also usually run a local
ubsan test build when doing my acculumation of patches in
target-arm, but since that's a manual step it is fallible :-))

-- PMM

