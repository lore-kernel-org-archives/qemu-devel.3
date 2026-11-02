Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F313606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FAOZ7ZAQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqUL-0003CA-5A; Mon, 02 Nov 2026 06:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNqUF-0003BS-M5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:46:03 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNqUD-0005Bh-GN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:46:02 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso22206987b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 03:46:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793619960; cv=none;
 d=google.com; s=arc-20260327;
 b=EXnXAQ2E3Lp8wRGNkJw+ZTteNGjpsGVHWegEcH+oVBB/vD6bzk1F3oVzYuKwrzmJ2m
 ar0KF424/s6ayUhcRvoOsIAUP7sHMdKWHkbIqP8GlZHau+AYFdCCO95+AK3hAC7+YKMs
 i//P8yFCKBBdt3Da1eRpgcyM9YqNQktoW5ItF2/wvC+GIIL7Nd68vYVFNCxb2CNX5JDf
 hP9AIR6WuqXCaz9jF+A71ywI9OPQbL95py3sEdCJwrzNH57IvZTcybD9h6Yhs/PNjj9o
 1wiFDIU6mJHK194+GoLkpO1wgquaLb0bNu2WAOMDRJil4v9Ir8ctSP6TIpecZXD6ozGo
 Qo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cM+d+OkFK3FPcZOT97afCrApBvNj/83gzoTWtrFajs0=;
 fh=nGzDeVHUdnZKUdEN/A3t1mOx9QIS6zQ6u0Ifcf+j2PY=;
 b=P1R9br23TBYYS8LVrgvfhsk1g/bSE5uZw0T6u8BznbTG0ThYWv9vBkpT+YdyU4i45p
 eiPAQmrxCS1y+dSKrQJUjVMn17HYRvVRhbHIP3x79ad2eaeLB9noekjXly1Mj2+Oi9D+
 qXoOIHt5Do7LQelxkTzIPYezZfs/fUC196VpUeLjbg0kANBBVdpqIuhA54QqO7GIf5W4
 f4qTV5d1GZef0e855rq4ZeVrMet9ZiIYmi6z8Ey9WdiBuANA2WUm40hGcOwCmU5Xp02b
 9cxOFWCm13rxRAG08UuS4Nh8FjLf5UbgyxX4/e7GWQnwQavk+KS3nxneec3C3ibzFRcw
 oqNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793619960; x=1794224760; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cM+d+OkFK3FPcZOT97afCrApBvNj/83gzoTWtrFajs0=;
 b=FAOZ7ZAQR5CDsHanEu4j26krEy7BvMtbBks7Shng8w+5ZzPJC0RKZDxLdpd1Iiyp85
 bCbIaSL59ibNNtpxmf1N30Auj0UK9esPywMRboEZhenZWlFO5U5UfgE0WPM5/Rr7099E
 8wXx7cMJ3Bq1JSuR6mIxphV6+Pg9t6zcEY+aMIc7pMJkr6ABoyKaumb/rhkP/K7BnU7/
 pR5Xi1q3mkM8jeJus39nppisTk85dCdIxFlgJh9FQpzXhxlHb4jW+6+nQriTMLT3Eqz3
 R9zilu6DkjR+6z7K6eE2HMRA3TES18zjccboH6bgQvgJnRGky/ctArva4qw9RvLknGgp
 oTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619960; x=1794224760;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cM+d+OkFK3FPcZOT97afCrApBvNj/83gzoTWtrFajs0=;
 b=Q9PK51g355bNLwZ6VMtK+HSvKzI2xtMvdU/LLMamB397SeY2PYEfLotTClVs74NqSA
 QNSOAr0F3nnBi8L8+l/1A40NXQjJcAn+nWhdbKyBpWzq2+VYF10kohTJZTQ7pbzPyi58
 3cdvcyQO4oS+3z1bTwoptQ2is13dZH5c7Gasup7xloz3KiSmVMtlOP4KNtoEVH6wiRad
 dSWbcFOB1vqQ9FcTK7ed5GisF3GK/km4VSLk1S0wtgE5P+XrCmDzkGNOJjVkuqJN53cp
 EeRrq1OpsAvtsBQ0POhr8nQxTZ8JlMcFfi9+2dHsyrJIh8SHDAIO+QaCxGJZTgUG66PT
 yRVA==
X-Gm-Message-State: APuU4Z/k/rMYMwh5wyrTCUxSyjwBxSKp7IESXje27V/6E6Iu6s/+w2wq
 jVms4aVbOD0tWGx0vZjsuLghQ35VPnAUf8LMRPRTT2OYYSW0ZcE08z06FD3ixeTzYQvh9FnbrJT
 A0KbjmpnSMiECPz05dQwrlhtJlO15r/FGeRVuw0EDEw==
X-Gm-Gg: AYBFou0C9d5IOyc3+S2lJf4tKgj7l6sEN5GT8QkDsTMb9dDPe/VblPXQ7WLZJOqRbXR
 wBwMR+MPZJGom/3UWauJZBjVKGvUcjMXr05JF3LZ0sgAB2KWmuF67J/NGpBW7s+ZAvKMkhz8Pvk
 BcgD32wqumNb8uwYQsbPBszCsj97CaaVXO8Q2qINlux/SFaU0F3ADDFaVRKoqz4twS3KGktuFnF
 qiR2Wflq5UTDgFqsxN+/czn8c3HH81bGF7zal9QjTEioymKHaH1bpov51MxjsIbA6609SQQY1Tp
 q/BnJTKW8hsc89pjtbGrYewB3IrcULVqLhT3fdoU/9xVejxN6Byw7k3kCN8B72LCrlLDqCXdpz1
 ojfHfSKvnNbhxbwiGV5icwKva0O4dUMVt93MGUBaPS2uEXh1oPvU0oqE7s87SIQpsRA4bbauTvC
 LnKKPV2gcxol8YQBcyZkonhEbgCqw0r1NDp7myqxR3HA==
X-Received: by 2002:a05:690c:a845:20b0:8b0:7c07:559e with SMTP id
 00721157ae682-8b2b671f358mr49202097b3.36.1793619959549; Mon, 02 Nov 2026
 03:45:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
In-Reply-To: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 11:45:47 +0000
X-Gm-Features: AclHuK-wDrJgfslnMYOmifVyRPkEII5gwoMgNS-IC5bvGS7LjBqYob_ZN0YKpbQ
Message-ID: <CAFEAcA99W4x7WJPnGX+1b_uLmmyzi+WGsipkxfdkxhSka9-ePw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/net/bcm2838_genet: TX index wrap and full RX ring
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 jasowangio@gmail.com, marcelomanzo@gmail.com, serg.oker@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:42, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> Based-on: <20261027143036.44973-1-marcelomanzo@gmail.com>
>
> Two fixes for the BCM2838 GENET model of "[PATCH v6 00/17]
> hw/arm/raspi4b: working PCIe and GENET (real networking)", which is in
> target-arm.next. They apply to target-arm.next; if that is simpler,
> they can also be folded into patch 12/17 (implement GENET TX path) and
> patch 13/17 (implement GENET RX path) of that series.
>
> - The TX consumer index counted past 16 bits, so the first transmit
>   across the wrap never ended: the device sent the ring's descriptors
>   forever with the BQL held, and the guest and the monitor hung. A
>   guest sending a sustained stream hung after about 65k descriptors.
> - The RX path wrote frames past the consumer index of a full ring and
>   overwrote frames the guest had not read. The fix keeps them queued
>   in the net layer until the guest frees descriptors, as e1000 does;
>   real GENET drops them and counts them in DISCARD_CNT.

I'm just about to send a pullreq with the GENET changes in it,
to hit the softfreeze deadline. I think what I'll do with these
bugfix patches is put them in for the next lot after that, so
we have some time for code review, rather than trying to apply
them in a hurry and maybe merge them with the existing tx and rx
patches.

thanks
-- PMM

