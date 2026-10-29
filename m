Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD01606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AGhIU49j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ3f-0003RJ-FH; Thu, 29 Oct 2026 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQ2p-00038x-4f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:19:55 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQ2n-0007OR-D5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:19:50 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b0d63f60bcso18882427b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279988; cv=none;
 d=google.com; s=arc-20260327;
 b=lUYcxCQFfea3Yq60EnNNATu86AN1uEzY78tE94KlOCt2kqOVCLNjGaD8qEr2SXQ9Yv
 cP1Vf1gqIi3H9a0flQkYIoUhnJYtOrUObGtEhhI2WB4pAZDGynv2lb2Nw2SEiMORDcMd
 rc1OjuIinE9ecpr8IIUDPVvnOuHrpAGqmSePuaZJX6DLDFs6HGGuJMh8/wL10fy6tgeW
 WGl1ylVZDh1+XO0xcXuJjjfI90S/W082slDAXSKlnGWfhg1jeMZoOTqaxlPeBJ9vFuKd
 y9w5UtIWeGuOIKJ6mvIBpZioyHZZVah1zidRkLZtQ2tPPBLrNvKYrJiS36dNv2D84si+
 6XaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A+Eq13IeGP0aNcY+C3RUDzkkzntQ9i36YlHtS3VUWNA=;
 fh=gSO3vwQvJdHsnuGdz18l2exk4nXgMK8+Etjcw4MjM6Y=;
 b=Phivrtl6qOOr9PBGtWcdzsZfK2Ttsgw2WZML+HA32VGQRzlSYl4D6SvZn0B2iTXCal
 VLeZVr207FMKfBtJ0UyLvz50SDZ83gJF24qyeAYS6Ni4mFH9tGT6FSYOkDUDhfKyyEkf
 fz30dX8F3bvVZcsIZI2Bj3utweFldTMBKpVlqm8SzClD+7TMIHpzEua8V/Ipp4oB44ja
 r9sxQgCaEB2TowI52NuQYsNg43AxLBtYlxNJxCjZB5yks4V3as6PRDiaXR3fwGXouPgc
 9pz7bKKowt3XmBGugWdo9yKUy3R8MsBzUrymhwC+QT/SusrRDVopSwxzbp5zDbcuglK1
 oGrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793279988; x=1793884788; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A+Eq13IeGP0aNcY+C3RUDzkkzntQ9i36YlHtS3VUWNA=;
 b=AGhIU49jvrwtGZRFJZMqcpp8AqVzWOJNmwSIDfRDQXL4rQu0/8GDE6WFy0y2J4NscF
 MsJ+Zq/LoUAT8XgJ3iOTfeMJNWJ90XfWfQZrqEsMOiMdEDyuFxd6SQOxB0smQRArGOWN
 YM4uJIrVCs/roR/a77q7GpnvB5ZOXMuXNjqvBfag1r2XTmdYufnd7eHw5cpH6xnYt2rd
 mUvkn2/OZ+PB2BfHY+kzc3aOEn2kp+WbzfpwyR58OEyPtUpUEgyQB9uO61gDvT8lsoJv
 vTbMAMzXvONPJebH0YcPPlAy4k+o8JTGx5L7pK0I+c5c/eYjdaehK55mFzlNYGSguPUd
 iGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279988; x=1793884788;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A+Eq13IeGP0aNcY+C3RUDzkkzntQ9i36YlHtS3VUWNA=;
 b=uEAQm/D/EQ3KubeLyPYKegJYXIWGgwC7zBjNi91K4WCvOp7gb01U9Q3NxaBfsYgB/l
 0JL0ngPxzxXRDYZM2drSEAw2+0yzhOxU/xRv5/jMJDHtYmVzE9CMp/HNGF1lrII2ErgB
 aaE010NPrQHXGkXuSgCsKC0UWqz6jzr5PcQGbxxJ5nLCPRubZP5536VrJLkR5vQ980J/
 IbYR7vKdn7Z4iDTDe1W3M/nA5TA02SpnC8Bvefq0ERlHXDH3r4ofj2tb41LwnzHtL30w
 5HoI3Lgd8HRtIwPPVIb1doa9wS9Tsm4m17cFW5a2gv/h2gIv/QXp27ki2u6QxU9jp8aW
 TENA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpoxGKz9PqvjEduyrXJTERoxG59/MPShFyGUyDU8L0QVPiQsxtutWxib3D4eMggCgnLJY/VZaqlJC2@nongnu.org
X-Gm-Message-State: AFq9FYLPGAJwAMDqZjEIwgBp00Ie7PKvFpT4pYXctAccJKwArYfcsFJP
 NrTizUUXF0CW4fq2+b7hCeQGpg9HKH/uVP9tWEox84aKAOZrlbLJdz40H+G+OiCyz2epvgOzosd
 XQ9Z93h+yKaXsXuCLnAdASoPMcg9sbd4kMIzMnKqoDQ==
X-Gm-Gg: AYBFou3QXdKrsdERV2QXrwafPBI6LcDOtTuuwslhNPmvz/6Qv702JH91qBre3QEXCfB
 u1Ov26jdXol7DuRDzisAhGgcdHv78xSY42mNsOoZKQJrCGRB7BNAAY4NYMzbs195ltqwp4utEiQ
 BrdlY8yVoC1Iup7D0/bx4OtS9WUxGWuhrAw0FTYzcJyReffPRQip4LpDl1MTGsW1/Roy4IGI4Kj
 4w0OjpA9NWuO4IG7ogIkOJPuTq5n3C7FDZsRuWadc0EavXahH7xMm3IPH8f2wcKJNLFi+hPMX+K
 5wtvRIEqpyh0DS44AlhdPnSnChXmzzLh9Uf7dldDA7l+0Ir4hP/T2SiwJEEJtXEKC0aTgmE9w1I
 FJPPwe1hqYuxvpI8sHwuAke9rdGewD6llYknnC0o+jFrNNfvg9im+PqopXwx7Rq3MTxElpLo542
 LUppC6xd0ZviHODOMeMvvbaCofvhtYyAjkT/Ucd7RSog==
X-Received: by 2002:a05:690c:ec9:b0:8a8:7fda:15ee with SMTP id
 00721157ae682-8b1b5d04153mr38970777b3.50.1793279988027; Thu, 29 Oct 2026
 06:19:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025110857.1973128-1-peter.maydell@linaro.org>
In-Reply-To: <20261025110857.1973128-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 13:19:36 +0000
X-Gm-Features: AclHuK-44kUA95_tql0SGvMdMFiGnbyomi6aZU5ansareu_HvyBkKtM-owyIMEM
Message-ID: <CAFEAcA98yOpsZZbSOBad0f-W8gzx+_0x2cTTMhcQhbijqpHdyg@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 at 11:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The xlnx_dpdma DMA engine allows the guest to do DMA to host buffers
> for audio and graphics data.  These buffers are set up by the xlnx_dp
> device, which calls xlnx_dpdma_set_host_data_location() to tell the
> DMA engine where they are.  However, this API doesn't provide any way
> to say how big the host buffers are, and the DMA engine does not
> check whether the guest is trying to write off the end of the buffer.
>
> Add a length argument to xlnx_dpdma_set_host_data_location(), and
> bounds check the guest's DMA writes against it.  The DPDMA ISR has
> bits for each channel for "descriptor payload is too large", so we
> report such overflows there.
>
> Cc: qemu-stable@nongnu.org
> Fixes: d3c6369a96a8 ("introduce xlnx-dpdma")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4134
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

