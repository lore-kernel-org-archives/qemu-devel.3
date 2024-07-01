Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66CDC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJSX-0001jX-J4; Mon, 01 Jul 2024 12:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJSV-0001hs-Se
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:00:51 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJSU-0003OG-9m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:00:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso97688a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719849649; x=1720454449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKyI3Ta/IJuc0jtKHowxM+Ba7ejCi+nZUvuToFcgJJo=;
 b=HZNuOfves/teDUTsCv2RdHa4L6f+YN3gYNOGexMd92DJK7IRHYOIV9mwT2vMM7D64a
 KflWvKJipLlJAHaLJ3jMYx2uVNRhjUydXe4/pe64DFtNgY65PhILvWP1DDG3N78DkbeK
 BRneXXjA/d/W6vzJUUtFI/RZyD24VDtx5wlrmYhTXwFGRx+6h7uwrVKVdTNrhMMWFsGA
 l8K3CMNsg2NzH5vZqJY8P9XLzhrzdD+wLFXv0jdJpwNWynYE778PwEFAilosxkpkjcms
 jSfy8v99Wm2rgcq8rqbQpEmWspTdLDheH3cgR8XHAOsmtK/9ZOE61OivI4OVIbB5U71y
 vojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719849649; x=1720454449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKyI3Ta/IJuc0jtKHowxM+Ba7ejCi+nZUvuToFcgJJo=;
 b=D35wmrDa/QCNZZdK8UL2Q5vjSHoVUNX1yw7FkdjKfYfz0eUDTTZQU7yAysl7opOxNB
 W/8riGAfacQNoOikQ6dhC9gktwHeoPT0/RA3Wx+y4xoHjjUaVFc1rOXXRocUh3SSmQYT
 q4AZSKLuIKfOrGjPMalSLLKNw82y+yhsNTMhq4rwZTuy7RRKYZgsH66ofnHR7r2OTLmj
 OedJaPv5CUDq6n+ucMVgaRavsdQOxmnVQMVdd7xYoTT2tkeBqf28jmzWSkbu2Yhgx104
 qS/CmxH/aA7cFzRaHdkJGvzgfDbJYgZ+hl1rZX/DEp1HYgtNLl6oDkOk+Y5LtzMwJBdY
 PWcQ==
X-Gm-Message-State: AOJu0YxNPgjk+EnFYD2+TjK6eM8//u+DTPy4CjduerxA5BsRQTSfb5P5
 9uZiDAcReH/mhmVZchhbfbGfO3RlmMU+idHQTrAP+UKimk0JJI9otKB9ZO4UWXsirYCOEvLdfVm
 Q5NTmJW/NT3pDf2z2PxtJx9VNENsdp10g+JLeiQ==
X-Google-Smtp-Source: AGHT+IHnDqcoNNFx92p/ZEhKn52hMDEALNjHSMq4iJ9VUkxa3QYFypiE5IxUp7bFtWJw/Z6HZNj1iqooAogPVdSSxpQ=
X-Received: by 2002:a05:6402:1d53:b0:57c:abe1:8266 with SMTP id
 4fb4d7f45d1cf-587a0bfc6c3mr3830622a12.29.1719849648561; Mon, 01 Jul 2024
 09:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-9-philmd@linaro.org>
In-Reply-To: <20240628070216.92609-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 17:00:36 +0100
Message-ID: <CAFEAcA89z_bR_Sc5F_hcHKfK0xOXf__GudFGJfxmr=c9d+LX1g@mail.gmail.com>
Subject: Re: [PATCH v42 08/98] hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first
 (ACMD22)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 28 Jun 2024 at 08:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Per sections 3.6.1 (SD Bus Protocol), 4.3.4 "Data Write"
> and 7.3.2 (Responses):
>
>   In the CMD line the Most Significant Bit is transmitted first.
>
> Use the stl_be_p() helper to store the value in big-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
> RFC because I'm surprised this has been unnoticed for 17 years
> (commit a1bb27b1e9 "initial SD card emulation", April 2007).
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/sd/sd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I think Linux only uses this command in an error-recovery
code path (which we should never get into since our
emulated SD card has 100% reliability ;-)), which is
probably why we haven't noticed this before.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

