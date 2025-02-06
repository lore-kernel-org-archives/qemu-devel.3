Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD01C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5kC-00023K-1d; Thu, 06 Feb 2025 12:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5k5-0001sQ-Ln
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:32:49 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5k3-0002cQ-RW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:32:45 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5addb0eb8eso1010908276.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738863163; x=1739467963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PlFt7Zw45R18PGMj5maGWrpFddJpJXDab8WCgAb5xFQ=;
 b=XAQYxoZkHJeZntJE+rE9EPRPrVJEz1vChO+RXAKgy7KyhMcrpN/jrVNXmsB/NIsvao
 2Jl2fdZvdketbjRDmkwzWP3Jq9ckIV3oPw2wEMRJ36/YpnREFVuQxMIeQ4bD4VMft7NE
 BEfwMIWpm6R3SRbDq5mO8+ww+qy6tHcQ9FBWS6f/glMckfwVtPa49FFhENh/QiFtRmEt
 Wl4smQIzh1IuB1jqYGlq8E4o+V1wZ+EYQI+ekadYmIf0tbhzH0fx6vb6iAYTw3bx3FDE
 XbKjHAnbAWKOe3VfldJRvSQYGsz3EhTOv+R3HRxBpOL89YaS/p66GjbSPlBy05R6aB/N
 nX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863163; x=1739467963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PlFt7Zw45R18PGMj5maGWrpFddJpJXDab8WCgAb5xFQ=;
 b=tXM3QsgJ3NxnpuwLg+MVjT+QIfM+Fgk14PYrq0JqvePNN+SFidkkqKUJWI2JZQS9+7
 Qub0d5qvX4uRRC1unCgJGc6cH+ahW1MRhgGzbnZpQS5+spFn6YBXx8W5B/O6KnXB+kcZ
 vt2XdoXdpmjJL9XfF+/GBz0heN2MZPbeSv9500epbfoomQLKMJ1J4EuLJyPzICs/aIzo
 IPPBRKuQtIj46w5Hh9ovBkEOpBzKt8+tuyUZmYJRQHwPFINkNo9GWbMt/Y9As9cw4xdR
 cIQ8gUGT5Ou9I7CZwiJqa+K8iKuEoWAZ/juSK2DmxuezeeIt2wORHtdKdG3YVLhKMsBs
 h/sA==
X-Gm-Message-State: AOJu0Yxs8XSepmnofn5ngR2dQdImXS3SQzWORrDGbr+hxvNIoQMCdAYb
 G3qBq5xt1GkKRnyfXYG2d8n9ArivFhojSkUkpuAQY9HEHeDNTPNUMtPf0nIWVGu5dRgQnY2AicM
 cJrXWtXZxMD1PWRfgo0bYLZZNDBBk31DOPdozDw==
X-Gm-Gg: ASbGncu+HfjwqCV7p3GJ+o++TT1n1aFeHMfZtV9tdHrtZVFwyXaSnRYyi83QgQYXrjR
 l2Nr0hpaet3X2aJ23Xf32gtD7ZRRHMTuHbly5qjnonixkktQfG57MCC3OnAPjMJt+tyXrUfVMUg
 ==
X-Google-Smtp-Source: AGHT+IHWfO9vwj61X/Zpt300EQnQeJiW3QnkdXAPQTSV+ioV1yTeS1uxHpCgowTY+Rhk+u1ksOGKN9oH+x1u+VULhR0=
X-Received: by 2002:a05:6902:1610:b0:e57:8991:be4b with SMTP id
 3f1490d57ef6-e5b25bcfceemr6804194276.35.1738863162403; Thu, 06 Feb 2025
 09:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-19-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-19-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:32:31 +0000
X-Gm-Features: AWEUYZl9jjT-V2VhqezxrkX6Nc1ENnIfrW6RMcemJ24rQnFKYn2FSiOD2MfqVaA
Message-ID: <CAFEAcA_gxGWivT7byZh9gYc2QHfsTqbJ8vtxPDToOxLMdMvwQg@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The implementation just allows Linux to determine date and time.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  MAINTAINERS         |   1 +
>  hw/rtc/rs5c372.c    | 227 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/rtc/Kconfig      |   5 +
>  hw/rtc/meson.build  |   1 +
>  hw/rtc/trace-events |   4 +
>  5 files changed, 238 insertions(+)
>  create mode 100644 hw/rtc/rs5c372.c

Should there be a patch after this one that adds this device
to your board ?

thanks
-- PMM

