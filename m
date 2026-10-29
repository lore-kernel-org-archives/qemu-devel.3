Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB51606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HqNoodDo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPdB-0000nG-Tt; Thu, 29 Oct 2026 08:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMPd7-0000ma-O4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:53:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMPd6-0003iy-A1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:53:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so18729725e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793278394; x=1793883194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pCDpzVz7p9WlDdEVf/sgUXZvv00TYfpw0k+go8eWT3Q=;
 b=HqNoodDoJWmek5MScH3ZfMra+aUYRwKXUKIS3g2yex/6y8Rr6KWGDwYQz+rDNzaM6o
 G+5ALttWoiDjW7yLwaxsXvk2JW0WbSOdErWWwqfaSO9qo4DXYg1AuJWFsEUeetsCPkTl
 NXUfJNNA9Gvcb4XHJUS2vyYPOtdv0gPmz/IcJWhi0lo0BMrkE+JqB7w53bQ6EZmoznxU
 iplexLAUm2ST+eGuU9AqDeuNxY3UHJ1YZVsNanE1uwRO0ZwzzrYZYfFE5K2PbsmhTgGh
 WsglaR5gn0wqhyYgbQJ1WwUfhoxG9b2orcEEJPiYncgrQ3rZ2RubfDDepvnOcKYOnVHO
 4GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793278394; x=1793883194;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pCDpzVz7p9WlDdEVf/sgUXZvv00TYfpw0k+go8eWT3Q=;
 b=UhUfnb+KLo8odGZNWt8DS1qsdU3GjtJ12T/TLe+Yq1rcMoTMnNPSdWRiC8iDuiQG5J
 Nk3kq1TP/jF+P8EH8liOZjN6UgtdyPPNfyPeO3HP58HgJWWemXZun27G7Ie8OQb7yZgD
 zKWWOG9vqancjaJDiRzMNgWxIwGMGYLjY6EkfrC50ThTrXhlZDlquqyBdwlK41j8a7vB
 7PNGemtrGi1+eK+VoCCF4rWeBMtOts51fmdoAUlQz9KUlAySwacMJ1qHkRjWcecVNSPp
 PKhlA0gTb6bFErUxBKbRLf6h/S0VMRcoLWVbx8hlK+dFkwSkdnnBCZgdfFCWFUk13AX3
 Cw0w==
X-Gm-Message-State: AFq9FYJr4KXl0+8Rk3k0ZH7m324dd/1GsR7wjJPwBKl2x6b6mVhgtC7S
 OTyAYkRh3d9wt2EyqerqwCVAb/csdUNDHcQwKjTuzmiM7HX4aX+d6FoonbsNkdtT8jQ=
X-Gm-Gg: AYBFou3jMHaJmuSkbd+aKDTMNbNRdvAy/vqqyHgGenZnT+iufz77fBOlJgpXEUqBo//
 M2slb4kpDAHOt4XrGQ2bPY7FlVYNteny/vDNnxM1l4wiAtOvunCj43XRSOq1yJG72uJHaLnvJqD
 TMj446ZarIs7g8032zQzKifSVsiKwXD1BUhzvdcteTqvGtxCuXHI90hiBFDSgsZcZygw41uxSJ5
 1Ra3ui/Vp9svA9FTCd8+Q2qAp9mTrIL0hoQsDvO7wjSeau9PKO2wepKHbdqrA86rBBuDJKWXxS9
 V4588HXGiishQm3JSnjn+sFQ/GUacD20JEkPhtv4RqbvUC0qOg/7V+5wiKwHEhi89E2E+GbqXJb
 H0axfEenOWIfnhHN2uHNP7clMlDHwF8H1+JUH+tf/PdfVa8iDuos8rCHvyjTQB/ndx/fNbwxf2B
 kmIRutNtaR7CUUXw0rEhg5a26V6pQyeCMI/t4KtBIagxVus3JL3Q4zuW/iEX78PjADDnhFA7zj4
 fEHmGZPNGE8bOqkjaY1COeIS2uc2G7Ngk66xVGwGDef7jxMJpnThr1gjtelUOTfYvA0E/yw41cv
 G6A6/RFxeXvXNasefOamz/a6dOec
X-Received: by 2002:a05:600c:4455:b0:4a3:59c7:f226 with SMTP id
 5b1f17b1804b1-4a965ec950amr116714385e9.6.1793278394463; 
 Thu, 29 Oct 2026 05:53:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece5e4asm33518936f8f.59.2026.10.29.05.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 05:53:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ACD35F898;
 Thu, 29 Oct 2026 12:53:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stringer Mattingly <stringermattingly408@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Hi, need help with qemu ios vm
In-Reply-To: <CAN+BGFaMPE1PhwfYQgDhjT6xhXQg7q7XcDSmpskijG8Cg+5HhQ@mail.gmail.com>
 (Stringer Mattingly's message of "Thu, 29 Oct 2026 11:41:32 +0800")
References: <CAN+BGFaMPE1PhwfYQgDhjT6xhXQg7q7XcDSmpskijG8Cg+5HhQ@mail.gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Thu, 29 Oct 2026 12:53:13 +0000
Message-ID: <878q3gacsm.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stringer Mattingly <stringermattingly408@gmail.com> writes:

> whether it can be provisioned and get appleid accounts authorized ?

The upstream version of QEMU doesn't have any machine models that can
run iOS. The closest thing we have is the vmapple machine which attempt
to match what macOS presents to guests with its native tools. However
you have to be on a mac to run it.

>
> thanks

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

