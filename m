Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07917C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIob-0001kp-VV; Fri, 24 Jan 2025 07:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbIoU-0001jk-TP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:29:31 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbIoS-0002EU-Eq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:29:29 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e46c6547266so3027780276.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737721766; x=1738326566; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=efMVIS2OJvZChKfhD3bA4i8iiE1MrrvOurOUjNZNHAA=;
 b=q7FHYCgJvh96IiUOVFrsdOWaAPzaHB7qZNlDw7SB9PFz9BNTKF+GpCqyt2+TqaiMYi
 ERbAAUbGQhQWXJO6TRKi0vR2zKs4AUHNIxkljah+9ZR1Zkx3jIAAXIMY/7x1MOxFGsMe
 n6OhRJHCtwQq/J3BMrseTyiurfhZ7u9aWI+jLduu3dc4Uz2hn3ysPQul9kOme4Kjulln
 WNYOi+iqlDXqVxMlqR50OtucMBSH2GaASydorftCIIHj6wIE9Fqt3uxobgc8D+PCAgpz
 6LqjFQTeHUxMS3puOS+gPebpf6cS8bKJU55Gl/zAE5u6470SPlYm5lGluHflDab51HE5
 QUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737721766; x=1738326566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efMVIS2OJvZChKfhD3bA4i8iiE1MrrvOurOUjNZNHAA=;
 b=saMCGRTyv5+yHFDVhuZI7TuJ6DTvIGhcP7q61WfQmrpG8VoJoea1IOTt3Zq1+hJAWq
 VaW6X8/04rxRlbiWTGV4hTJIGWuVYrUJsvpzHq3sOsThgnLYPE6M4oGCP04b1xBSoNIE
 XkiH5YS5FLQL8JNYYxdxw7BwXh7k8MTbh3vYO080FWBOloPKWWR6nW/g8rVZ2SXL2oB8
 xcyj0eiQ9SX0HGwltnfDWLulRStws/tjcFifoHFiPezhtIidAUGuHwiQCEKOmCdtba3S
 NB8xOp4uo48ySKpA+8KlEi/DjAujnSLKKPLMUpBgHgZzoeJ+xQZrmBAK3+O2OQsa7E73
 vdMQ==
X-Gm-Message-State: AOJu0YyIbuLCFH4STABJX9id6b8+C1ao89en69IKwrHVxr4i8GudYMff
 5lSwskNATAw0HnVOq/2siSu7AndsMLfhM78FRrUrVr3qciljPV0G9pAjrl2lwwe/IVp5qwkZbD6
 LDz0hsPxcYdjbsC+c6OFvLt3nPehVOopcveOLwQ==
X-Gm-Gg: ASbGnct4RdXh1Sm/ZueQv/m92GKUtPAQezTqaUexVge0R1JlOwpo25MjiH6EeaaKchC
 C/jRyAsX/s3k5bmVB8wqKwEbBnL8sAH803L6pT7N6BCRVsIubaLwrJjS3TlKON4s=
X-Google-Smtp-Source: AGHT+IFe5/kv+gI0EVGRyX+u5Ax7KrFo6z70X7gn/YvA0Vzr/nqnYHLMF3rwNmuVWUAO5u1NPNhAoY8nvaYn7/avdHU=
X-Received: by 2002:a05:6902:15ce:b0:e58:183e:90e0 with SMTP id
 3f1490d57ef6-e58183eb5e1mr7348147276.11.1737721766687; Fri, 24 Jan 2025
 04:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20250124025322.C47A24E602B@zero.eik.bme.hu>
In-Reply-To: <20250124025322.C47A24E602B@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2025 12:29:15 +0000
X-Gm-Features: AbW1kvY1wfkncgAQtVuYHX5EvXiQMvbuR42PcLV2XeISeXSANYH_FB-4ymU4DLU
Message-ID: <CAFEAcA_2d1mE2btg-TghmjNy1u1UftB8LCMC7QnWX+xV1+rObg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/hcd-ehci: Fix debug printf format string
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 24 Jan 2025 at 02:53, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> The variable is uint64_t so needs %ld instead of %d.
>
> Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/usb/hcd-ehci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

