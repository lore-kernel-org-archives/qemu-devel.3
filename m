Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B839C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 05:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjv4U-0000dF-PG; Tue, 12 Mar 2024 01:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjv4P-0000cc-1Z; Tue, 12 Mar 2024 01:53:01 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjv4L-0008T2-Tm; Tue, 12 Mar 2024 01:53:00 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c1a2f7e302so2478802b6e.0; 
 Mon, 11 Mar 2024 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710222776; x=1710827576; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLST/+LxPFJFeiKQZp5C4/yG7knQNlqjhhzs4+zCE9M=;
 b=KCn+h2kpcWiY/o1hAe9KJ3LAN8b3MTpLP1wQy3HpogJGagl/z2XhBULPFeipoUSYVZ
 3S2NEuPY/6LFgprlR1VFHlB4TjOA5vtBjEMVedssOKhwHpv+HReCMm7f+lwrMi/srgfv
 HxzNQVksDbEmhrVE4wyaIqieuWgbJM3t1EO2em6vj5BMVMcIsPkoZ/mNBZEOp6KWOin6
 JJF9HYS/QMquyf2X66E3WfYcT7wCoW+lHrz1ato3tgSCX/O3ibNWGzyrFYVhYIE82RM0
 afR1VnaxAdSZwdONcQQxlTJjGVG+ZtYH6/Emrg1ETiQvLCDAxnVlif3YPU5izwUzrRKG
 Yo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710222776; x=1710827576;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xLST/+LxPFJFeiKQZp5C4/yG7knQNlqjhhzs4+zCE9M=;
 b=OKYKCSDF2/stzJHz7QtcFX97uwRRyp8ULnh7RkIYOnaoce62ODu1dqEKUpvXcr79+m
 txy82wC+waivU9zOBW2SZXPb93Q/uMeC6UGhKKdSCpKGJlb8KcBEF1sU8K/kzh1Q6cGM
 P0sdzu9oqwJbmeg5YSaPEHIT2NAo3esWCfSWCJEiqFQzPHLczppJ2XFFR8gLe2hbgG71
 EsUvc4CyCEgNmOpI0gRWhaTCIy5f6VWfsmfjfifriEHvcAhGOlfL6hwg379KKw8U8Z3M
 B3RawaRT5EO0rjwTmxa4bFDvoeghFPShErGrzNsygywmoqvt0Rb/LaCsmALrSixtKuzE
 /hUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLyznvJIe+qDpa1PpACPDMGa3Fl5T2QMyD9+vHjPGkzIsSWmKKe6fYLA38uyw4LlEp6lEsVIsb2kq0pbjtjH0UZQTf5RJNsMe85y020e8VdW6Dnxs5BRAm0Q8=
X-Gm-Message-State: AOJu0Yx653VTAn68Bjd1bGZx6ULhlZw6mCQW780/8MsOFaXf20y5xs71
 MW7q1Cq4yZYSf5tdsF+mmN7LEKWLd3N+hSp1/exadydSoXBXtCTU
X-Google-Smtp-Source: AGHT+IFl8RN0ibzoWHUitI6aPMczNZpijpS11q75Z2xrAJzx8yyD7Kj5bhZgWuTS4Jipt13LfXnmWw==
X-Received: by 2002:a05:6808:6487:b0:3c2:54c7:2073 with SMTP id
 fh7-20020a056808648700b003c254c72073mr2256312oib.33.1710222776271; 
 Mon, 11 Mar 2024 22:52:56 -0700 (PDT)
Received: from localhost ([1.146.55.44]) by smtp.gmail.com with ESMTPSA id
 p1-20020a62b801000000b006e66a76d877sm5536450pfe.153.2024.03.11.22.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 22:52:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 15:52:50 +1000
Message-Id: <CZRJDIF198N3.HBI9LR13HIA0@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 00/14] Nested PAPR API (KVM on PowerVM)
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x229.google.com
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

On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> There is an existing Nested-HV API to enable nested guests on powernv
> machines. However, that is not supported on pseries/PowerVM LPARs.
> This patch series implements required hcall interfaces to enable nested
> guests with KVM on PowerVM.
> Unlike Nested-HV, with this API, entire L2 state is retained by L0
> during guest entry/exit and uses pre-defined Guest State Buffer (GSB)
> format to communicate guest state between L1 and L2 via L0.
>
> L0 here refers to the phyp/PowerVM, or launching a Qemu TCG L0 with the
> newly introduced option cap-nested-papr=3Dtrue.
> L1 refers to the LPAR host on PowerVM or Linux booted on Qemu TCG with
> above mentioned option cap-nested-papr=3Dtrue.
> L2 refers to nested guest running on top of L1 using KVM.
> No SW changes needed for Qemu running in L1 Linux as well as L2 Kernel.
>
> Linux Kernel side support is already merged upstream:

This is all looking pretty good to me now. Considering it's quite
self-contained and adding a new feature, I think it's good to
merge.

I would like to have an avocado test for it, but the avocado
framework has a bug that's causing issues with the ppc hv test,
and we might have to move to a new host kernel with the KVM
support merged. I can take a look at that, I think we can add
new tests after soft-freeze.

Thanks,
Nick

> ---
> commit 19d31c5f115754c369c0995df47479c384757f82
> Author: Jordan Niethe <jniethe5@gmail.com>
> Date:   Thu Sep 14 13:05:59 2023 +1000
>
>     KVM: PPC: Add support for nestedv2 guests
> ---
> For more details, documentation can be referred in either of patch
> series.
>
> There are scripts available to assist in setting up an environment for
> testing nested guests at https://github.com/iamjpn/kvm-powervm-test
>
> A tree with this series is available at:
> https://github.com/planetharsh/qemu/tree/upstream-0305-v5
>
> Thanks to Michael Neuling, Shivaprasad Bhat, Amit Machhiwal, Kautuk
> Consul, Vaibhav Jain and Jordan Niethe.
>
> Changelog:
> v5: addressed review comments from Nick on v4
> v4: https://lore.kernel.org/qemu-devel/20240220083609.748325-1-harshpb@li=
nux.ibm.com/
> v3: https://lore.kernel.org/qemu-devel/20240118052438.1475437-1-harshpb@l=
inux.ibm.com/
> v2: https://lore.kernel.org/qemu-devel/20231012104951.194876-1-harshpb@li=
nux.ibm.com/
> v1: https://lore.kernel.org/qemu-devel/20230906043333.448244-1-harshpb@li=
nux.ibm.com/
>
> Harsh Prateek Bora (14):
>   spapr: nested: register nested-hv api hcalls only for cap-nested-hv
>   spapr: nested: move nested part of spapr_get_pate into spapr_nested.c
>   spapr: nested: Introduce SpaprMachineStateNested to store related
>     info.
>   spapr: nested: keep nested-hv related code restricted to its API.
>   spapr: nested: Document Nested PAPR API
>   spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls.
>   spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
>   spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
>   spapr: nested: Extend nested_ppc_state for nested PAPR API
>   spapr: nested: Initialize the GSB elements lookup table.
>   spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
>   spapr: nested: Use correct source for parttbl info for nested PAPR
>     API.
>   spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
>   spapr: nested: Introduce cap-nested-papr for Nested PAPR API
>
>  docs/devel/nested-papr.txt    |  119 +++
>  include/hw/ppc/spapr.h        |   27 +-
>  include/hw/ppc/spapr_nested.h |  428 ++++++++-
>  target/ppc/cpu.h              |    4 +
>  hw/ppc/ppc.c                  |   10 +
>  hw/ppc/spapr.c                |   35 +-
>  hw/ppc/spapr_caps.c           |   62 ++
>  hw/ppc/spapr_hcall.c          |   24 +-
>  hw/ppc/spapr_nested.c         | 1550 ++++++++++++++++++++++++++++++++-
>  9 files changed, 2204 insertions(+), 55 deletions(-)
>  create mode 100644 docs/devel/nested-papr.txt


