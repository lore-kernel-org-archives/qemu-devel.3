Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70BCC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk16W-0003Tj-K1; Mon, 17 Feb 2025 08:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk16U-0003TP-Nd
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:24:06 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk16S-0007fg-Sp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:24:06 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5dc39ede40so2109435276.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739798643; x=1740403443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ImPdxCbzLfZbm+Im9GPC7SBy2QXQei9F05/Rwvm6ey8=;
 b=D4JuoNL7VTQPJr+Zh2R8E5vc9IDJ8aCsTm3xRemP5o5kt8VlUJqYeIkF7MohMtR/El
 V/sdqjT5wU+2cZ2AnJihFQ8NGd3chG+WLBt2trATNJoXyQeVDhlhaQAEtPEjsPdmRTdG
 Q0dFcnwKQCQOnwMhkhmlerBYAQ1TkaAs5lwxwflsr03/BHmlSnmhWahNxDLtauX7xYOl
 VPZn/9tpD8aTbLGCnTsFo9EKOhHC0ZEtCS9t32kqsciWq1p9fYMT1v7KZEM5PHN4oS0F
 9oie5cxz+6t8ENLMwgugCBm4fuuLoT9CqqDeUXDCOiR81fTiV4vKCJAm5VvpTtunWeuE
 nqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798643; x=1740403443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImPdxCbzLfZbm+Im9GPC7SBy2QXQei9F05/Rwvm6ey8=;
 b=wwqfH51t7yeCGgAJDslcTEOUh45X1vBG4WxyeTSOMF415PZF0Bo6GnL8z6SZJHq0/Z
 WCg8JcKlzPjSPylSDYXDC3boZk9fKuUpZ8HPM0xNp7LXiXZCp9knmMgn3QOA8TJGA6Yv
 NW48eGlB62aAHSWy5gAxzxoFwHLM4FMNIUv+/ka5Wn5DLIUXAmxWOAiCuOfrCqD3evIO
 f+ezGpVKhNk8R+gygca0+qkA1YMHMVXfFK0/OUZjNaYyN8XBoaGuRmSIK2WWQPJQdwX6
 iDGD0d5Q84rA/Rzw1JHBbY4jlIPDQNdIc+HceMpLrgTmTu66NE1z+Wh95WXPG9PrsUrt
 hdNw==
X-Gm-Message-State: AOJu0YzbKySU08cH0D0Nph//GM5HFZRcyH/CSQKWN4y8lLATxOqTPMR3
 bR8COwYvnW5AUEv0I5pqbUWybRKB6f9rxu1bUbJSPbbRhzM1slFWh0AaTTVWRBoFLLorQMjP6Ac
 3Q3qGUbX2CNGPnYU6C22wZPbgJe3810bdE2adTA==
X-Gm-Gg: ASbGncs+dArGeIENpwHDou6tbU3jw3/EVuePehzjcThY/N0RhmXwLg5psUdKEezgYkR
 q5M5p/W75kOMt07RzovB7Nu8YOxc9N3uZcrmCDPqv+LjQXr0jONqPTJI9mfr1W62mFy3wIde0AA
 ==
X-Google-Smtp-Source: AGHT+IHn/5uBYEcEfuf62osQsmwewhf+q1KS62zCpfLr5PMh/z61PR2M9Ke8u9oq3nM+YguGO1gA787hgV4h8xEOMy8=
X-Received: by 2002:a05:6902:18c2:b0:e57:fd58:ad51 with SMTP id
 3f1490d57ef6-e5dc9034483mr6776156276.1.1739798643063; Mon, 17 Feb 2025
 05:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20250213084219.2975727-1-kchamart@redhat.com>
In-Reply-To: <20250213084219.2975727-1-kchamart@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:23:51 +0000
X-Gm-Features: AWEUYZkcmvJY6s5eLDYtzmVvSJljIFAjCX8XkYb2BhFxcVOHEA5Paai8F7oB1hw
Message-ID: <CAFEAcA9MgeaCQspu=4dCusTQVP3KOvpze55vshPJCaNS_E43yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] docs: Small changes to system/arm/cpu-features and
 more
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, maz@kernel.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>, 
 Tyrone Ting <kfting@nuvoton.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Joel Stanley <joel@jms.id.au>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 Hao Wu <wuhaotsh@google.com>, sebott@redhat.com,
 Eric Auger <eric.auger@redhat.com>, Ninad Palsule <ninad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 13 Feb 2025 at 08:44, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> In v2:
>
>   - Add live-migration context to the PAuth docs (Marc Zyngier)
>
>   - Fix the Arm capitlalization (Peter Maydell)
>     - Context here:
>       (https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg05137.html)


> Kashyap Chamarthy (3):

Hi -- it looks like only patches 1 and 2 ever made it to
the list. Would you mind resending, please?

>   docs/cpu-features: Consistently use vCPU instead of VCPU
>   docs/cpu-features: Update "PAuth" (Pointer Authentication) details
>   docs: Fix "Arm" capitaliaztion

(nit: "capitalization")

thanks
-- PMM

