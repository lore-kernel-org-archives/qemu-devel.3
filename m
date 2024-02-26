Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7974C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redk6-0007zk-HT; Mon, 26 Feb 2024 11:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redk5-0007yo-1b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:22:13 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redk3-0000s2-Ij
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:22:12 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so5811741a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964530; x=1709569330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IujkR6GbivfjAPk1KUxUVi/ADUOFIc3YhreRhoG7fMc=;
 b=A7vCDLxenk6l0jvTTd5tD4S8/IJLjwveW5hEKIOnKU2oUdv7HVBsQw2djLcMrdCc+e
 fXmZx43xwa5HOQeJocdzROSNiGn9YizwEkbEluwMU42cYMKv0bgimwN3WtNF02aJUCwK
 OQfJryrhPXJ2URHstH5Hc2iTVf2QiBL1XBA4WPVUEuC3cG2pooIfB5qzz69MxaYASoAN
 KX9DwJ9OXH0gGEPmMjZTFIh7O9H4ljh+yd6bMvn3HWzDEQhJtfiboV6QhP5+in3nUk8e
 +7t60YkMnSRGaUFG9SvwYRvSt8tCViE2dtv+gRh9R+jIjW0I/d2aC4qCtBCJmbtpnZXC
 evIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964530; x=1709569330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IujkR6GbivfjAPk1KUxUVi/ADUOFIc3YhreRhoG7fMc=;
 b=XDb2cfMDnkjG0Jz6a/Wwg4pJGz5Pf/j/3vC+bJ/92lOjMuIohwWqELDwwhm15aT36c
 j2bCtsCztl0isYWwIn+JhX05jIjxcK2oLmuNBmuskHBbgaGYtttYDxdquYc8B8UO3b6a
 cn51Ou9GeDuUuiCsxZgUgmg8pbd/e4W0VT3gJz9uXkXzg2wiqjzJ5g4IpCR4B8Z2AlNL
 IGY9MXUZvYSYQXKtRJKI/qL2RkMDeqWUv+9+lgpP4K+jjn6nXgRhJdfx4ogZHGI3qo3w
 akhcx3CpE17vPN21py8AF3qbyr3e203z496xtnouKXiNyAnvKEDiXjYq5rc8ZXTbNjMw
 FNWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2En4R7BL65xU6smB8CMiVn16qv+duKgRKuki5a4gqona2EMBzf+YgJ/2FUjWy90KNKBFYVHBIFdD39vhE1uAd3D6gpNw=
X-Gm-Message-State: AOJu0Yy+E80A5M9AkzrE0MzSRZGWUtWkfxfYJa2++l0i29D5xRzXiCGz
 Wyz+3bWnwPUKBIXWoy6LSpl4PQk+Q/rn1KPAd7D5vqzpEi30sfLpJ4Msu5ItjVKjoO7N11RumBN
 ThAX5O1sXKPjTTLRjAHe8AjVitHKMWoogNmBDxw==
X-Google-Smtp-Source: AGHT+IERfF9COUeJ6YLK+lUN5HLK74YmWHO56l5vgGtxxqCNTMdbkbc66S9QkksX8YpD6cPjS3Ib2yvHN8bYybAlohA=
X-Received: by 2002:a05:6402:1a30:b0:565:bc3d:d9dd with SMTP id
 be16-20020a0564021a3000b00565bc3dd9ddmr3425054edb.38.1708964529902; Mon, 26
 Feb 2024 08:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-32-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-32-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:21:59 +0000
Message-ID: <CAFEAcA-2_j3fbkJKyR7N-T__iewrt2OfP35dJLZC=MqdeONbZg@mail.gmail.com>
Subject: Re: [PATCH v6 31/41] Add mailbox test stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 26 Feb 2024 at 00:07, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.c | 60 +++++++++++++++++++++++++++++++++++
>  tests/qtest/bcm2838-mailbox.h | 37 +++++++++++++++++++++
>  tests/qtest/meson.build       |  1 +
>  3 files changed, 98 insertions(+)
>  create mode 100644 tests/qtest/bcm2838-mailbox.c
>  create mode 100644 tests/qtest/bcm2838-mailbox.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

