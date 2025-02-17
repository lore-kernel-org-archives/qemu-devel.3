Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59270C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4ER-00025Q-E2; Mon, 17 Feb 2025 11:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk4EE-0001tt-Pf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:44:21 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk4EB-0008B4-Cm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:44:17 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5ded1395213so7132531a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739810654; x=1740415454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3FHUaz8ZQxfTEz+ywIpzuVfvUH6DLK/X9OlNeD6XI5Q=;
 b=rM7Xn8Z8js4ZBqat6W2jD+mWcUJJYe/ogBHtoHV80l1VcIp/bUIuX6CVydA3Pml18c
 7WiKK0IsUufEWQa4hu0BcgO02MwMOO91O4z43mJhPIVxiGG/NmqPjvhXUsMAzWF3tuDw
 Q4o5jtE8OLgfLau8svGHZ1zYdfjQYfhqGXurnNxltJAYlyaRHkIbo5ZzCYRjNHI0nA9D
 KOxpyejxnyeUZK8FerDCNzGkrKDgZrq28oFarg5G1HVxTb1T1uFpeZnj4m3EfE1I3RdK
 glXf2pJBB8PrXCm9HBYT1xF3MlFRVecG4VA5QjMrpFjQ7wA5DcP7prtMU09/omN6qAJa
 MYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739810654; x=1740415454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3FHUaz8ZQxfTEz+ywIpzuVfvUH6DLK/X9OlNeD6XI5Q=;
 b=QFR58DomwmNG+1zjmlipOon9eCN8iFTiHo/XRscY+2ch/KVxoZ5Gj1SAoFFLtCwZ9a
 w5DqAx4RcPFGieEAruIYARcxlCCiiJ7Ho4UbISpw31MtQd8FIAlmCx4uCmaESoYGnTBJ
 t8kyypqTrdnXuvuF3q6s4RNiN0ec3mgVXG7dy73RkDgqWDKqPPhXGXMLrv6F4vFaqVdY
 8q0WW5Njnn5xopmclTLsgixAaYdNZIHLnnrGiCgNVDfkbQDEO7Re/klCaqQgM9iwZQ8q
 IsiinwcJGNeQkmrDF28Znnh0jTZvWzmtbWD6Yr5m1Og2Im2B7D6qHUnQ12jG72Kbc1Sp
 S2IQ==
X-Gm-Message-State: AOJu0YyWZuvtlXcU3JmC+kFUdFy0HQiuYnZZfW0nrLo+Gjz4V/oMuFJz
 76IDGqdiYKXIOwYKHoM3PLQMEb83pIQ9pdfzqFHkA2W2MI31hFh+MgxNR8dDYpHDn0pxB8Tlrwb
 w8Ec+B+nZ9rsY0qT4kk6RPBbgSpbg1ouBZZ1Srg==
X-Gm-Gg: ASbGncuN70BTyLf0X9GyutttunRPcqkTz5oqeySnJtfd8oBA0zF71iP8gtMIYIz9GLR
 M7+YSCKfdTZGtzZ40AH+qlAb3DIygX9i8HwA66mbbm8GcinduSEbh1LKnKI69aKCbmZnmp/VpcQ
 ==
X-Google-Smtp-Source: AGHT+IF2z0Tn106JwfTcbTOA8ob1xJk3Nzd1r8r28ml+1/7h8E8YoLHQcQF1OiE2O94pGUXHt/b9leat+umNKo4ICJo=
X-Received: by 2002:a05:6402:3488:b0:5dc:a44f:6ec4 with SMTP id
 4fb4d7f45d1cf-5e036092b01mr11041093a12.13.1739810653589; Mon, 17 Feb 2025
 08:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-4-kchamart@redhat.com>
In-Reply-To: <20250217163732.3718617-4-kchamart@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 16:44:00 +0000
X-Gm-Features: AWEUYZkA--iZUaOyUegiY0uWHGnZA28MagWGT1ImgXRuF2Ab4cbzkvy7fM5jJho
Message-ID: <CAFEAcA89YVi-0WTD=9=-nvK2-kr859VAtxgmvyhfTDNx3TvERw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs: Fix "Arm" capitalization
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Ninad Palsule <ninad@linux.ibm.com>,
 sebott@redhat.com, 
 maz@kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 17 Feb 2025 at 16:38, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> This is based on Peter's suggestion here[1].
>
> I simply addrressed the occurrences that I found with `git grep "ARM "`
> in the docs/ directory.  I didn't touch stuff like these "StrongARM",
> ARM926EJ-S, ARM1176JZS, etc.  Related commit[2].
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg05137.html
>     - docs/cpu-features: Update "PAuth" (Pointer Authentication) details
>
> [2] 6fe6d6c9a9 (docs: Be consistent about capitalization of 'Arm',
>     2020-03-09)
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

