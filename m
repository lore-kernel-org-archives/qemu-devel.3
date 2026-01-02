Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A87FA3727
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 10:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbcF6-0007PE-0c; Fri, 02 Jan 2026 05:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcF2-0007O5-ME
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:18:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcF1-0003ZW-9e
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:18:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so77752225e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 02:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767349120; x=1767953920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVGlBhkayG2HEz48fKY7RkuLx3xd3hQpvWoghhStn1k=;
 b=oANOLyd6uGHZ1Cu8QctXcsaYPZnPLeeARgFdv0/7WWg59rFQSMGWmbFbt9VDZ2gZKI
 u+ui8DrNUhnIO75WfViHHo1dUUQpZvEPBkIYyXJ/HFcC8aXXyV1EhkgJhyZB+KcwQKur
 fiO9h/92bzu0bCRAdIqhWrJXAqPFtzZF0ihn12YDCXv0nzFJn9mbme6DMRlJ4i5Yt2R2
 I4wgltGvEHhX1pEydKpB28b7W63wDMGdZ8LUBR1nPf/cf/inObT2O5snnsgyY7TioaEP
 CVXlCxjLS9HFlLctKnqm06KUpxwgx1GoHIhUGnYHW0jl+ZP7W3MkLSOMGB0oG4LEVY5p
 KQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767349120; x=1767953920;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVGlBhkayG2HEz48fKY7RkuLx3xd3hQpvWoghhStn1k=;
 b=feRdM2VEAmeqMJDUjba8cvU2TVy0bViHzNMedHkl1S5S9hX7n3RhkfYhuOpLXWtvg0
 gTUsAkS1kv30i6Wb1svZAEsq/m2w5UpCxmujymiob8XMojdv6ee9rR0GJSP30h5CpJjX
 VtOc+WfRGuQ8+mLXAYx398YstzJchGe3eimtl3CEnw1tHoXDmnmwVN92dOhC37GysWxA
 YmzOXmEzG0+Ljy6DtoAJ0YrY0jKo/0Hf+BobA91slhvy+NkT4vn6D5P+vUeUvwP+V+sW
 kfUCVX6tJlxFgbhnHmvDmeN6ORiTlk2Q99/PN7rCOjOBmcsyDb6qUipobQJXUKEMK3qe
 1n9Q==
X-Gm-Message-State: AOJu0YwvwiHeQpUASFf+MzANPIhhXayKEh/ydgY12EzjVr19xbOCuEvA
 ZQP9w/s8w2CE9eXN+C9HJEsgefn6YXq0vTeQDoOmvXhAWFIPINakZ3vn1413zNnrFKf6kejhkEJ
 fULEm
X-Gm-Gg: AY/fxX4Ohmm4Z+K7seQOaTbnV84iuh0JLrCqB8GQR6YiAr2jgIdaVM6iHVMppMv7UdN
 TifIWfMSvaz90NdPwW41mZEcdDAB/B7SmgQc1Yzc1k3YQvYofR6gy9sG4VETUaDauqgdkbF1UFm
 SclTnk1UKAtuPncelWylxQ5Kh5AcCyW7J+6QW7MJbMQWdhqN8KsEALLUx7UAQpxvzqYCmT+V3Iq
 rtaFYAq2tbrru+SqyNGlcxoKfxpLZ5sR/7+N1plG2v8lxBKeQlOvXGryVfnvFmdmEgdnEJrZnKz
 CYVLg2iVuiZQf4nSalCyQs151amatk7eJTjehhNNY0B+DPyREbzDlpa52shKNjPGXJ9ksYPQTwI
 6KXgg0KC8s26NOi4IvZ4WKFVwUps6PFfGdUQ8UQmlCw3KXC3uai1bQYXrO7giSwuIrr0AWNCcS2
 EBJj822cCBmnQ=
X-Google-Smtp-Source: AGHT+IHZYVVDZJbbOZU4Sv/0Nh1uNRbnYJV0A0b1Ozwtk5T1wQorGOspa9AZ+29L/QbCJ1mbvWLDMw==
X-Received: by 2002:a05:600c:4fc6:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-47d1953bc3cmr417282595e9.5.1767349120174; 
 Fri, 02 Jan 2026 02:18:40 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm751552415e9.12.2026.01.02.02.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 02:18:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CD925F7FE;
 Fri, 02 Jan 2026 10:18:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] plugins: bump plugin API version
In-Reply-To: <20251227094240.6652-1-neither@nut.email> (Julian Ganz's message
 of "Sat, 27 Dec 2025 10:42:38 +0100")
References: <20251227094240.6652-1-neither@nut.email>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 10:18:38 +0000
Message-ID: <87ms2wxqpt.fsf@draig.linaro.org>
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

Julian Ganz <neither@nut.email> writes:

> We introduced a new function `qemu_plugin_register_vcpu_discon_cb` as
> well as some types since v5.
>
> Signed-off-by: Julian Ganz <neither@nut.email>

Queued to plugins/next, thanks.

>
> --
>
> I should probably have included this in my patch series introducing the
> register function in question instead of noticing that the API version
> was not bumped with 10.2.0 after the fact.
> ---
>  include/qemu/qemu-plugin.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 60de4fdd3f..b445c26389 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -72,11 +72,14 @@ typedef uint64_t qemu_plugin_id_t;
>   * - added qemu_plugin_write_memory_hwaddr
>   * - added qemu_plugin_write_register
>   * - added qemu_plugin_translate_vaddr
> + *
> + * version 6:
> + * - qemu_plugin_register_vcpu_discon_cb
>   */
>=20=20
>  extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>=20=20
> -#define QEMU_PLUGIN_VERSION 5
> +#define QEMU_PLUGIN_VERSION 6
>=20=20
>  /**
>   * struct qemu_info_t - system information for plugins

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

