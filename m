Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA485C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 09:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM1HY-00008U-8s; Mon, 02 Jun 2025 05:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uM1HX-00008B-4U
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:16:35 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uM1HV-0006an-JQ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:16:34 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8134dee405so1133645276.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748855792; x=1749460592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5IyEm9zUeFusiTYrfhoPOLT4O48ynadwwuQz4mTU7M=;
 b=xXIqgnDLiPzvBHeTyY9q8ARUeAeeIxX/NYgBgnwFX27CkQ2tv7CDnkEJOlKHG6FaEs
 KzW9+O/0hrg21sBEcrC9HPptM/by11mJcTpfopasJs4HOG/je/n7oFqUHkB5nwBDyzLu
 9+6vZbc3hfaPVfBNk87zD5dFyycxzC5KS8tk1jwNTCDNpmGFEq1lMCwv9Gjq+/KWGOD9
 XEuH7sXJzcoVBIY4KXU4XWxLySv62OE1Zsov9PeQTCf6h+Ba3MG/AVRI7ZONfw5T24Pp
 tUGG/yCWE/iGg+ZIpj+AzogRBratmvRd64s0LMFjLipA9s6kcoqy0V+5cqUKMOi20ryP
 zhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748855792; x=1749460592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5IyEm9zUeFusiTYrfhoPOLT4O48ynadwwuQz4mTU7M=;
 b=wZJbTHlK+BgEiKg0933R7By4RrhWKyjUdpvp8gHoQNbaXzifpHedyq/BQ09v8Aj1En
 BijVGPADU14CVlbkK7q5vWS3q6ealIsaEmgRlZiuY5WFUtYIjee85Mr+VgDA68qc08nQ
 wFqZOBdeQiDCudjl/H9FqJ6yI7mc/ivKVuxcSpJRs61r16TSMaZE1wqawM/2FZtr6TzZ
 VLFFNK99FK2r7TdnycljH1YX9R7qhAozlS0ZBwnhNjIRXNploLYCuY+SajG13CO2IAW/
 QQaQGUiLs2MEO/vvUUEWK4KMYyp58AXCgWxUeHHtlP8ed+A9huW0royUWqw1pMkJWlkm
 nzGw==
X-Gm-Message-State: AOJu0Yxybw1ikLSlDt46UME/TZ3XXcAc9+S8+iHq9SAY1njnAWmF5bph
 oeZmvmComY0I8SRU2TxKgw/ZAnytNrptxz8IuM+q1uDk4H5qRwRylJpcyNjYZh9IrRhQLzXHkSD
 DKgLqku3QRsWdS+XHwasGCXvElIut8McOYUOU/1/1kA==
X-Gm-Gg: ASbGnct2klXjK/PTi9pJvpzkDtsBOZpCd19+KBMmD6DWBrMGIECSvWk6RN9yb2kDuS9
 ELBzaxs4quC3gU/dPlVXR0i2IDp25ziVVucsmlEEURijVUnvVudf3H1e9nnZqYIfR3OjMgyOBn1
 ypg5Nan2GAOkh9xSYw2yeGnqrwaMkFrFmWGg==
X-Google-Smtp-Source: AGHT+IH6x+KEh2edXXiw9vLL69xUrkEv/21KZBKiW161+4cDCSoN6twh/kL8cEh3FQf7z/mUl92aQkWOfCSbMDlwGpQ=
X-Received: by 2002:a05:690c:3383:b0:70c:965b:4700 with SMTP id
 00721157ae682-71097e2e5a2mr105072037b3.31.1748855791916; Mon, 02 Jun 2025
 02:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250602090726.41315-1-philmd@linaro.org>
In-Reply-To: <20250602090726.41315-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jun 2025 10:16:20 +0100
X-Gm-Features: AX0GCFu3S_xAqx_Tge0ibwSbuFYImCwiM09ylwvqHpNXhDohLNere4wVct6P7zk
Message-ID: <CAFEAcA-1w4jEq727Fs-QrXhETT_pQaTB7HVmptx_i_5Gaaw70g@mail.gmail.com>
Subject: Re: [RFC PATCH] system/cpus: Only kick running vCPUs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Steve Sistare <steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 2 Jun 2025 at 10:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> We shouldn't kick a stopped vCPU, as it will be resumed.

What is this trying to fix? Do we get wrong-behaviour,
or is it just a bit inefficient as the vcpu thread
goes round its loop and decides it still has nothing to do?

thanks
-- PMM

