Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE934CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDltB-0008Oz-6a; Tue, 28 Oct 2025 11:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDlt6-0008Ng-HL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:45:35 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDlsw-0004bW-Hk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:45:32 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e11347fd9so6924708d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761666318; x=1762271118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knnT1ftdmTMJx/XyavOPGJh2UCADWh3KX8LeDc7hUa8=;
 b=HfaEyvitMxhO7ov9QvNgd6Nnw1OWdbyccwFniaUvi1HGYiqfM74PRP/AQziLvUjNaw
 Kdg1t4aFIHs2WWxBQPmOX6iTMJA4+ma7EG6NX6+I+7fXDb2VQoZE5y3dh2I2R10nczpU
 grkZcoyJW4fyClA+5kMhSPt48myfIEQnPgnsZOp2YMRFH3EC6SVMhD89UaWm/lSxQHl7
 X2yI/0vYWLhtEjMvc0t8GrtsouXWf3HYw8r4YfMDn9DAby4qmD8yCgEPfkiG05Jl0Rz4
 q4ZZiMfBXMpPQ4gYiqWZ2jxDKH+j0ZNho1vnE8dS1P+CaWaQ2n0FcW6gykwDMT/69rf3
 JU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761666318; x=1762271118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knnT1ftdmTMJx/XyavOPGJh2UCADWh3KX8LeDc7hUa8=;
 b=QF/iu1x74oag6ROr1JAyYxqJQSac+uNt3tkSZL4NzPPGKgakLybei7c6z1oCN905o8
 BW5/mJsGOlygyX112IJgLrzSbQFeiXQDWrpguf7rrs6UTk8MDiWEzAuMwDiEdOAqLcBP
 bMApWIGDHmvrOcf814aQamZntiV8GNzWqXESBcVCDs6E8kXPEHiPbttqIYnpXUBwV7NN
 Mp0PJR1TzJcNGZk64rKyv5syQCkDZu1+SEgGmjeLOsuuOV3kIiIbUxRI5PF4OODe40d5
 ly21EnPxlHA6Nn5ywqmd1sZYKCUDDEHzoD5uGFfS/JlbaHgWC+Rgo4Oj+8BDQY9WVMyt
 /QlQ==
X-Gm-Message-State: AOJu0YzzdPqIELB6ibK/j1q23mNvqXT9h7XIbltMSaOSwryZQTM8CnqI
 zVvVbLg842U0oQYfYGym2CM4/VRZ4LzHj8acd5facBO29uzB9HnI0Az/+onc5wQKh2k+QcYBp4D
 gBZcvWtGOF6gsJdgpNdhrLQdFo9aP5jHWwglXQtwU5g==
X-Gm-Gg: ASbGncsAQoJ1EiDpPMfAxculodUga4LJ7Qggm5Wd2BIwDS1evihSusSYDS8RkuRYvmI
 ZLLnamgBJnvJ8Ai55wGVaRDmUxyi7U3bRoPLVgjEMAASzgJK2y15TTglxV5Ixg74DFudt2Vwtha
 /sUhh2YMc/fNHXvyVn8OlTA8WXdqPhObxcPt21RyTo64unR8cDKj03ZsXJebyQT5akm4l8ww/js
 ay/o/oT38+zF2LJvxOtEdyhivvNTagdMUTCAaZG/XEDM+ulB7/xu5JeONaEDw==
X-Google-Smtp-Source: AGHT+IF1tsX8B8ODvnmAHDIpvh2LJFczDiQsY2ee0V5DVnxa/M0OLoTOk4GaJaUAbc5VTbFhhWy+XTA3Ul09ajY2ZPQ=
X-Received: by 2002:a05:690e:dcd:b0:63e:3a34:7bac with SMTP id
 956f58d0204a3-63f6baa0f6emr3042756d50.62.1761666316772; Tue, 28 Oct 2025
 08:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <CAFEAcA-3SzHPmLc-huMnyNbZBnEwi5+fbPNuvCYJcvY7gYboEA@mail.gmail.com>
 <0d2fcc9b-ad42-4668-a8bd-9ecb70c9822e@linaro.org>
In-Reply-To: <0d2fcc9b-ad42-4668-a8bd-9ecb70c9822e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 15:45:04 +0000
X-Gm-Features: AWmQ_bnFyegvKgNoRM11TRUoBuIr3K__VeiCDYbNWOQn3uB_WvI8Z4KPJOly3Rc
Message-ID: <CAFEAcA9GNmtQUUCVg-o4MsJ78saaiH69VHrLcJCQSBWsEE_eBA@mail.gmail.com>
Subject: Re: [PATCH v3 00/59] target/arm/hvf: Consolidate
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 28 Oct 2025 at 15:41, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 28/10/25 14:10, Peter Maydell wrote:
> > On Tue, 28 Oct 2025 at 05:42, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Missing review: 15, 18, 26, 32, 33, 38 (up to #41 could be merged)
> >>                  42, 43 (up to #49 could be merged)
> >>                  50+
> >>
> >> Since v2:
> >> - Improve host page size/mask uses (rth)
> >> - Remove cpu_test_interrupt in hvf_wfi (rth)
> >
> > Richard found an issue with patch 32, so I'm going to
>
> IIUC this is not an issue, just a worry about performance,
> whether getpagesize() implementation calls a syscall.
> Anyway I'll cache the value locally -- or better, maybe
> have qemu_real_host_page_size() doing that --.

I just meant to note "the patch needs some change before
it can be applied"; I agree that the changes are minor.

-- PMM

