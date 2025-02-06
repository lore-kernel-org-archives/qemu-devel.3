Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775CCC02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg4BX-0002Bn-Gg; Thu, 06 Feb 2025 10:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg4BK-00027M-SU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:52:50 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg4BF-0006tf-OV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:52:45 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e589c258663so1113108276.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738857159; x=1739461959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qK0YsYi5T0TrmWuzPT6kLfisgyFRI4UVYy2zpuffB5k=;
 b=saz22xorWG+9KIYeHMBgHo+3beIDjPP3O1N7z1r8RJcSOqk/1TSa5AdExeFgecMAW2
 SetwIrPXO5PelPFktjJHrhMMxyjos9ktReL5zwz3NYhat5nOKbmFQlGiJ+jm8wrbYJ8P
 cWI6zGSMQwfh5jpoqp2TxWoNdSOXMq8s3rvkj7XTXiEukuqm/rhPZP2HZWnV/bkGyr29
 f3M+nTl3lyTsltjLdvRPOv1/Ro6N1PrgSX7tpgr2ulmRrBVuGYblDZqZ9azb0XvdUQnr
 m2LDaT0gEkEzVsOAjrT9KWLb7jV3sxJ+oJEp8u7XNEXkCvNPp+sDCm3LBYXcx+cT1cX8
 ok7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738857159; x=1739461959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qK0YsYi5T0TrmWuzPT6kLfisgyFRI4UVYy2zpuffB5k=;
 b=iID+YkEItGoU25HJtBWGMvgINt4UwPNsVVrSQYYE2VVNSgEQBv9xZMf+1Rms85pRQl
 3VXIz4aupY7FjHiJUSPrFi3ly2/CX79mv2+6VpKyR0Lk3EkvfKU/3ze2ym43mvBqhzzW
 BCcWEG0eDRwBp+U+cnWxqEfmGWLXJuL+BIwwxBUvSzvT07x9H2TSVk9ATw/F7/MwqD8I
 vEJrkvSlo2tCMV2JblfaRDr1fG9dlTJrs7Gnj45CKzh2fvoC/M0WyhSXQtO6CtEYPw5l
 p72PJI4W8Y32fJOqiQ84H5UyKXhW191kMJQJ1RNc4yD/cSf5lkU9Z/RqgLcxoHiRHN2M
 qepg==
X-Gm-Message-State: AOJu0YyMR+h/iUl88f5ZKaYeXvwL7RAjohoWzlYx/0UK/3sWl/WTGvcz
 1c6ahKA6/sgdqDKNkZZUkdqh9pIpMF//9EJrT4Se47z5XIIPEeAGtF7fBD+4CIhzsegDPrz2Ah4
 dclO1Zi4A0vIxxxAxbXljjCNywQsOdJ5wOtFlvQ==
X-Gm-Gg: ASbGncsyzi48fqWCKEwCgMyFfMXN0f/tuQJLVQKZBQNlnd+wlu6C7JEcRuu+eUY3dKq
 d1N58XFAkbf4AsHqAyMTIo/AjE5dNAuGhGi1wOiUfGeGWuFgmGrhPsOrXN9ypnuJ/eKOA8W/gsg
 ==
X-Google-Smtp-Source: AGHT+IGINeWTSKbjmfoPs4JgPVdgMOggbKB4BYTLBGiV0ephLv9sPQFpHMENgqCDe7gKGTrcm7ROiGqMd8iBtYFmdt4=
X-Received: by 2002:a05:6902:1087:b0:e54:ab05:4505 with SMTP id
 3f1490d57ef6-e5b25c0957bmr6324767276.44.1738857159185; Thu, 06 Feb 2025
 07:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
 <20250203144048.2131117-7-alex.bennee@linaro.org>
In-Reply-To: <20250203144048.2131117-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 15:52:27 +0000
X-Gm-Features: AWEUYZnAPSByxpRAMEhM1UO803j7aoDYdB1KX7S44_DfsCu2bJkbx0AXWGbu_is
Message-ID: <CAFEAcA8ZcYtD44h1VupTR+Ka30D+HY6H+n-DnTW9muhy7_u6NQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] tests/qtest: tighten up the checks on clock_step
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, 
 qemu-rust@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Mon, 3 Feb 2025 at 14:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> It is invalid to call clock_step with an implied time to step forward
> as if no timers are running we won't be able to advance.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

