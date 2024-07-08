Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1121FC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpJO-0005rz-8X; Mon, 08 Jul 2024 10:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpJH-0005qO-UP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:25:43 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpJG-0000Os-Ah
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:25:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so4782127a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720448740; x=1721053540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=62pq1SIFDKjIXIXOgcgF+DnxBDPzl/esRPeShLoiKf0=;
 b=lPRc567zEX6vpYECdg7C3zPWgJunkmoO+wQFBeLYo5hvTVdnUDiDvfWwwXXq84C8zH
 Yr7RhkQDo8oUGd72SEy2Qy5pZWFRuLS7KIk3C8immC6BoIR/W4BUMlDPLXBwfTKs/USj
 5nLeG5fK4hK7tKuJArV8smilFsEDOy7PBBLXpK8a7LaXExxmmdeBt5fwIYU0deMIdfDd
 bapMrrrTnlkgAhcxFx0yfk0M5yIKA/ikU76OV/XVSVewnMl+c5i4T9MMSkclREq///Wi
 CWp4lF5L9X2NuXysI2Wx14lAfXYQYjxQWDY/ENRcHK16e2eQoki6KItmCQ4bodwi6X3f
 stMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720448740; x=1721053540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62pq1SIFDKjIXIXOgcgF+DnxBDPzl/esRPeShLoiKf0=;
 b=cl1TyyUBOaCAoYF+CGm9VK29S51CR1Kc/JRSCce+xqBcROKAMUrSqMRML4FhW3404F
 MaCrqxwSzEFqQ9L2fP/YIWE9Sk2zY+lbGdYOcqPv5zlT00z8SlO8r41xHK4btGSili/C
 ynlu2sHxXUWuhrRscMOmR5w0DFKPo007hmifXTR/tXEHn9O5V8hcSHO04CufmHUtc7gi
 6n9IpWTkn5/TN/FuJ3SXprjL9gkw/SvgPmTELEBRk8i+w9GM1mz6l+IVRNGW8Cs6QOqP
 zpvnGWuDeWUcfXO0Ar85Abq+yeV3iVLnf4KzGceAFWt4uaT/xz9K7xk8ucSaJPCj25sE
 z3HQ==
X-Gm-Message-State: AOJu0Yx3AJ9O8EeGUjtF77QCYheXmToAtTDzY2xuy0CNYFlNGbcYn5F7
 4AMWnr8fBYeOmQgyjxexP0PfO+ClKnisEwoimRGSGeD0mr++72E3dax3g9+dh/RwDNl9XHqpjWd
 ldVkjhMzjRa1UV+IZXXpyznCjIgrII4jpHp1Apw==
X-Google-Smtp-Source: AGHT+IG1bNP7hnN7BsUzIgqSxcmWJhDkAZzg5HyTbZNiuuEAjAwA7dz09PlyAE+KH6JlaE87/iU76wWmbJdN/OSTEDU=
X-Received: by 2002:a05:6402:51cd:b0:58f:cf2b:6707 with SMTP id
 4fb4d7f45d1cf-58fcf2b682dmr6835361a12.25.1720448740067; Mon, 08 Jul 2024
 07:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
In-Reply-To: <20240702234155.2106399-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2024 15:25:28 +0100
Message-ID: <CAFEAcA9+EP88kUB_3qpiFdsf1Lqb1NmbqM=+hNaC_5=kYWiJ9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 iii@linux.ibm.com, david@redhat.com, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 3 Jul 2024 at 00:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While looking into Zoltan's attempt to speed up ppc64 DCBZ
> (data cache block set to zero), I wondered what AArch64 was
> doing differently.  It turned out that Arm is the only user
> of tlb_vaddr_to_host.

riscv also seems to use it in vext_ldff(), fwiw.

-- PMM

