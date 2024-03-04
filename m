Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 11:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh6L0-0007sj-37; Mon, 04 Mar 2024 06:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh6Kt-0007r6-PF
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:18:25 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh6Kr-0002Ah-AE
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:18:23 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56647babfe6so6396736a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 03:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709551100; x=1710155900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMs3ISOUao/OFocAaFyhI2QBFu4QZ8uWW7uUjlKjk3A=;
 b=doI8R4pgqIUZPwHCD9wdQQGsu2oFYAxTOW0PI2ufIvcheVm7ReKMm8ZkHd4gRdMMK5
 52c306aKIp/FLtbwqO4MmkJSH1ihzxqISSQ9+AQNWJU938BKMbXHWGumh+ARbjh8wG+p
 47XXFIspm0lgqEVPXVcxmORA4ZvpyAj2dNnqFtPDPgGfo8nhjK0ya0zX9P8EesiC6GNP
 mBl9jdZVxyX4aHpq72juDwJPTme657lz7XQwaFrB2aGqCxeowmtVe0PrVzmKBJbjoaOH
 SJP85Iicw7ZQzgTAjhh0cVnTnVQpkB73+uqycAkmSgNoRJAPOjPVOzyHq4PYY8Q2KJgz
 WXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709551100; x=1710155900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMs3ISOUao/OFocAaFyhI2QBFu4QZ8uWW7uUjlKjk3A=;
 b=CFCFRMPJRnl2H2paptMJ30I9W3esLVYujX8Byw3Ix+YTmMM1nCEqiIe6rKcNs1ZUCr
 GkbckEmzqH5LDtLJfXB5eqMcI7EgdvBtc7FC7C2XN4H+5odZMlThTFWLrfp+ESIdK6Rd
 G269R3A47EPdUd44RWjz1lulqgFD5lfsRwYCxuGjmUmmTlP/T8hHEW9ZY96pugbtRHa4
 W5uDVCcmwfe0BU72UG7r5YaPlrprpbGADMBtV47Js8/4yLAvhlCse7Q7V9aqQletE8sc
 RN7szD1FEttO9nZD9BxyXKvf3erwlmqJ7fhTvaz6rTtSwiIKgP31fegeBRjOeUIXTYwQ
 LpMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa0xGckXG6EfA/iV+89nucHQK7RbtGGMYIHXeFoeD7bhJ/zVJsULlgsyvxn1iKAa4N6jg/v9LMlB5aYyrXpBKSZySimvQ=
X-Gm-Message-State: AOJu0YyVntln6/p4/3/WJJwcUnOToJsZGMhX8LPPQ+fBdQp2XPEZlGke
 BAxZvfFklUeS7d12UmwTdXogrjZwGnRFQRclqABgJrK/XPgf+KrmNDsl/3hKq1hQ6gGor7PA8pj
 Zn+y5/7wFB94N8Lx3/5eDounq8CRWtpv+Mxudxw==
X-Google-Smtp-Source: AGHT+IE0/iuU+LOYQi09oO7mwgJbdCRMEKbWK1XilcS2Wejss+kyMi8Qp31dmTALUtM5a8CrYFWHG8E5jpDf8ylv7SI=
X-Received: by 2002:a50:c90a:0:b0:565:ff84:73a1 with SMTP id
 o10-20020a50c90a000000b00565ff8473a1mr6173005edh.13.1709551099738; Mon, 04
 Mar 2024 03:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20240304093618.24131-1-thuth@redhat.com>
 <CAFEAcA83XhUSTDL9QL40ek4vDt-PMxRM10XeTXMPPZLwiibFxA@mail.gmail.com>
 <08136aee-2f2a-4d19-a19f-b461c14c5c93@redhat.com>
In-Reply-To: <08136aee-2f2a-4d19-a19f-b461c14c5c93@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 11:18:08 +0000
Message-ID: <CAFEAcA9e_nsQjiCtv74bDkvuCOLcOO8oqGuKo_REOve=QHOuow@mail.gmail.com>
Subject: Re: [PATCH] docs/conf.py: Remove usage of distutils
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 4 Mar 2024 at 11:10, Thomas Huth <thuth@redhat.com> wrote:
> Using my shell script to query repology, I get:
>
> centos_stream_8: 0.3.1
> centos_stream_9: 0.5.1
> fedora_37: 1.0.0
> fedora_38: 1.1.1
> fedora_39: 1.2.2
> fedora_rawhide: 2.0.0
> freebsd: 1.0.0
> haikuports_master: 1.2.1
> openbsd: 1.2.2
> opensuse_leap_15_5: 0.5.1
> pkgsrc_current: 2.0.0
>
> debian_11: 0.5.1
> debian_12: 1.2.0
> debian_13: 2.0.0
> ubuntu_20_04: 0.4.3
> ubuntu_22_04: 1.0.0
> ubuntu_23_04: 1.2.0
> ubuntu_23_10: 1.3.0
> ubuntu_24_04: 2.0.0
>
> So CentOS Stream 8 is too old ... but didn't we stop supporting the distro
> Sphinx there anyway since we switched to the python venv stuff last year?

Not sure, but that does ring a faint bell.

As our other option, what's the approved Python way
of comparing versions these days?

-- PMM

