Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04AFD58D41
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZ5t-0005ys-Mu; Mon, 25 Nov 2024 08:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFZ5q-0005yA-Vd
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 08:25:35 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFZ5o-0006eQ-51
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 08:25:34 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so5717639a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 05:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732541130; x=1733145930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ADdGhoysVegLCwQoW48kN0DpEGNfwFq46x7SMBDb2Ws=;
 b=VyZ+t1FF9vEVSpkMLMZ+UrQShtfTYL6ASsiOfHJHkTM5mhVmtXVyRlk7ytIi3qk7S5
 W654t+tBT3avnciDLtj4fmtPFdU55Fc5na+la74L0yPXJNCIGlHyjdFEKGxEcZyUuH3E
 FQWqZ+XD/xDU262zkUGogRCtUQMvfsAoR/CneNcOEBxY12zdETnYCHQR8DuMHvq7muSs
 mAfLhCQ/GHvnidcrwVxXsTHdh1GG+on02FSbhGzcwoYBnUHoi+YZDWhvNQT6DQmVfpkC
 WhQi0skABQvD7UKpsFpeFOZm8+6FL+BOoXch+8aHC01IJ8Hgl3Znqxb4qeAHv2Dhr/52
 v+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732541130; x=1733145930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ADdGhoysVegLCwQoW48kN0DpEGNfwFq46x7SMBDb2Ws=;
 b=hQ/f3wgDxd9anA7L6Z2JY+ho5V6m8k9lA8emQRutmkjv3n8Bq/M9fE4YCeV9KPcTdI
 vj/7lYJuabTubiDcHqroOUQ3WGb7z0ZJ+IP/oyzuLVnnKDvREDUbpbkhmo5Tva71TKTK
 Wtt9kF79AImDdp7gPgwafCYNE6Db5deeGSawHnQuGJYGeHz1ol5gT6c4B5n4OsbcLRtQ
 KmbHAr5biyt0r08awAb1JAH+MaNZZSs1ilJojDz2qsxY+q/fSkYahKHraNFPQQMCSdbZ
 VPjUJ+f0Rg4VFat9JgnlUNm0bx+EBVgMpcaYeqM9c0iJnRLBCdKKVOXDEnxJ8dE2t1rc
 /gLg==
X-Gm-Message-State: AOJu0YzW/yeyyHkoUgr52PlBj5yBM93kEcKTUnBgzSftTSwVOavEXvY2
 NXYubkafEZ9Qw4rrsJPBDBjrAmtaUjBGO9OHCQQi3LzokJY40klLWJZxHtu5EufiAIAFCKeqqjm
 K3lkeQKdH7uG8Ym3B/Qx+XumgEp8ehZchqs5cQQ==
X-Gm-Gg: ASbGncvZfg3qY+CvUGYKy3u3VvMJ96AH7UTFYnANUwTGWSoPOPgXyKnU388hbo3AN7f
 e5KPjRcbU73yQBAbGdnlUaUT1JCWzvHVl
X-Google-Smtp-Source: AGHT+IFLvzaP3UnRJg3fNZrQPXZEZHX40aQ0zmvUoNI2hGxRP+q0oKGVhODM7s6N/bzkQBm6nQAHvk6F/JPrRkqoO0c=
X-Received: by 2002:a05:6402:370e:b0:5cf:c97c:8218 with SMTP id
 4fb4d7f45d1cf-5d02069b662mr11039766a12.22.1732541129813; Mon, 25 Nov 2024
 05:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20241125125448.185504-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20241125125448.185504-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 13:25:19 +0000
Message-ID: <CAFEAcA-V3PGF7vst8QFjh+bWVx5EGDt_B9ZCe1OryNV8e39N4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 25 Nov 2024 at 12:54, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).
>
> Used versions:
>
> - Trusted Firmware v2.12.0
> - Tianocore EDK2 stable202411
> - Tianocore EDK2 Platforms code commit 4b3530d
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Hi; what's the benefit to taking this update? Would it be better
postponed until the 9.2 release is complete?

thanks
-- PMM

