Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A880D65C7E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBYwo-0004Gb-Sd; Thu, 14 Nov 2024 07:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBYwj-0004Fw-TX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:27:38 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBYwi-0007YL-Az
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:27:37 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so42795966b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731587254; x=1732192054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=651mH3GerAvGB6U/W6o4KQ9Sfky31LwJCRo193RNzlw=;
 b=sUOKE6dKw1EuktmWdur29ZXaB9ChvPmtuGFYBfNgEpnNrzwgtni6LgLcBWs74mzsi9
 2prCfvhtkV49bngosWo2wMon7ppHuwtN3ek+CoOIleGlK+ZXE3YkU/L7/66NqBw9pg7z
 rT16VsnjjycgKPQmnZkhVu1SfVULObkMxkbi/4GX61+F8t/5Yku2hLWkSr0U1AT5psia
 qhKGX30/CsczPhDrJ/TplAsv4466C6F5YXJ0n7lAT1gidjYAbP6Z12aBeXyvCojIpDYK
 31lnsBmrE67m3pcJAYp5oydXsHH75gJkIyJqBIKGKAIIImMZjDSRl5BZvQq7/jD6zABD
 9M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731587254; x=1732192054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=651mH3GerAvGB6U/W6o4KQ9Sfky31LwJCRo193RNzlw=;
 b=JKgvaBLSpWlxjp4SpVTyG7jEWwRGqAG+i77B6FPLRbQ3RBz8XBLKD/ktMZaEKmFgNf
 U+yGlAbihAOjk3tnYH2+bTCc4zT7sphcCC8J+e8E1nw2H5V+QETSUdZ90MvdzYNo8izU
 oqnTeQwO9pSRTJJyZe2z3IrFABKminkbykU04qoIfxPiBqN2iokDwnoTKkfhvfngfEJR
 7ihi+vjyl9yslQe57ZudJ5rDhaHBzQMRC0ts1ah0zskDUoHBd1nvSj2q1DC0DSHUCkAf
 LwA2YZczJ7BiXcU4UlUhKFRW8Qwyg9hACmb9cPlswRmWeUZziHrlOOwYBoT6WDfrwa9d
 i5KA==
X-Gm-Message-State: AOJu0Yw5ROuohekMF5wQlo7hoOsEC9AeXMHMJ9QnNOeoc+7Z1TOgVQ+z
 SoZkUJjOyFMdlByi2EgIVZFA57Ap/Y7Vre7DWSyoDTjc5tHrAYJwL4iIuKIp/Yv3npgQpGVJhcw
 2ZXLxh6EcpVDxnW1N4Q08+Ffmtyr94+G6uww27G8l8VyNrtZx
X-Google-Smtp-Source: AGHT+IHrfCPdaXRl237rkDE53vYEmPpPsolDC4PWtpu3Yf7NllU1aiZR2YB9PkXfdzz44Ikfq+o4VvVBTODkLecp4B0=
X-Received: by 2002:a05:6402:13d3:b0:5cf:634a:10ce with SMTP id
 4fb4d7f45d1cf-5cf77ecc7admr2438749a12.25.1731587254437; Thu, 14 Nov 2024
 04:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20241114075051.404284-1-r@drigo.nl>
In-Reply-To: <20241114075051.404284-1-r@drigo.nl>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 12:27:23 +0000
Message-ID: <CAFEAcA-TT4MHjs0ikAz5jnx05B33yUhWnBdfvcOcyTUj2=BsFw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/rocker/rocker_of_dpa.c: Remove superfluous
 error check
To: Rodrigo Dias Correa <r@drigo.nl>
Cc: qemu-devel@nongnu.org, jiri@resnulli.us, jasowang@redhat.com, 
 jtomko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Thu, 14 Nov 2024 at 07:52, Rodrigo Dias Correa <r@drigo.nl> wrote:
>
> of_dpa_cmd_add_acl_ip() is called from a single place, and despite the
> fact that it always returns ROCKER_OK, its return value is still checked
> by the caller.
> Change of_dpa_cmd_add_acl_ip() to return void and remove the superfluous
> check from of_dpa_cmd_add_acl().
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2471
>
> Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
> ---
>  hw/net/rocker/rocker_of_dpa.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> changelog:
>   v2: fixed misaligned line



Applied to target-arm.next, thanks.

-- PMM

