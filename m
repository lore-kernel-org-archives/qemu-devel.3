Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357FFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHui-0000I7-O8; Fri, 10 Jan 2025 11:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHua-0000GZ-V1
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:31:06 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHuY-0008Kj-By
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:31:04 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3a0acba5feso2859219276.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736526655; x=1737131455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tOjN8m6pAWWKlrF+UoiZ9BUWdCEnhAqrkAD4Lc4wiQU=;
 b=wgfJg+ejYflCm7qFz/fbitxol7zVoF2Dy7NiCEEN/knS/nWlj0oET8CxahVyOwH6NG
 sGQHRFwlK2o8QKUyDEuGMb49z4U8K4nnAlWpLmRXNu6ZHkqGpkyR7lJAw/WAGvSDq2+M
 wyzFyTI9zLCOclz7/oeqEzz9grTNQe4mZUv6a2AlLbP/acJo07ZrQnt3DZZ+csQvHqiQ
 uSQ41pY7CFa0w71gkzWrtcm5TK4k1VWAF7iAuFv80hYJh+dm4CYnZE7i3jKOt0cYxHRF
 6D75qAsMdUyjvuO/5ANU/6w5h9HwamBat7AgwXnpsSMj4dCtC6iXlPGA9n7JK74Ha8Qv
 ZxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736526655; x=1737131455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOjN8m6pAWWKlrF+UoiZ9BUWdCEnhAqrkAD4Lc4wiQU=;
 b=KLmh3hlpR6buAF8n6Ur8q1g6B9970U+oNWgGgTB0cmXZ4tiiwfjynMSrK/lgo40MTS
 Ny0IU2pM5u9BQafILMEG/ChwNFjsxSY1pK3oIfd9n8tW06SrsuwtRCZ8eX2tceC7ylDP
 eknROWbRfGm4VTwTZbTJSQgwgTLvSSDZPaWQU1GEq7ApSjOs8MtZAdaoYVom/EcKAkev
 DlBP63DLYm6rKE6Q2Qb2yiEZRrk1dgv5HTVyO04qiMCQaxP7xeqiuX38sNjSugb/fd4B
 pSDTdd1AuhEfEo7pUtD7eXhQ+I2aDzmKbPzOKN4S747uehB+lC+kUtmiXqmeds0TYW5N
 Ib6g==
X-Gm-Message-State: AOJu0Yw+q6zXTJsZHk7bN2kFsGF3hakXCVhMlOmJbptHmSyfA5lwH1Wv
 SSuWmxT44nyiGDVMwUvIrH0KCSiIYeTu7vaSasYfJUBBygWTFeEEnkN1WeCTrKR6y6T9nD936A0
 vZ7VvQZworcjgr8nXv1XWjHj2OnqdQEtNj6XYxQ==
X-Gm-Gg: ASbGncvy89gpsjNVOunKLTX9CZik94QqwD5v58zCeMlAPDfpMkHU1AEiuQ2x/Q4iDoX
 xtlh/OeVqitZGPhLATlIzK4AWg7F+dVfKWq8dV1k=
X-Google-Smtp-Source: AGHT+IFIThR1nWg2E2ZbcTQ1CB6HxWK3gXQFQb3UMHPNlFswAmVdNbpsenaVwBSS6Nzr5+VyewZOoFjzWUxAry+zRKU=
X-Received: by 2002:a05:690c:4b05:b0:6ef:4a1f:36b7 with SMTP id
 00721157ae682-6f53125116fmr94518747b3.25.1736526653899; Fri, 10 Jan 2025
 08:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
In-Reply-To: <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 16:30:42 +0000
X-Gm-Features: AbW1kvbDlPjtMqJ70EJJAZfqo4gcYiCApNqqwcyLmxpQWs7Vv0GP0MPiMsqw-po
Message-ID: <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/system/arm/virt.rst | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index d25275c27ce..9f1457cf9a2 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -17,9 +17,17 @@ to have the same behaviour as that of previous QEMU releases, so
>  that VM migration will work between QEMU versions. For instance the
>  ``virt-5.0`` machine type will behave like the ``virt`` machine from
>  the QEMU 5.0 release, and migration should work between ``virt-5.0``
> -of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
> -is not guaranteed to work between different QEMU releases for
> -the non-versioned ``virt`` machine type.
> +of the 5.0 release and ``virt-5.0`` of the 5.1 release.
> +
> +When saving a VM using the ``virt`` model, the snapshot is automatically set to
> +target the latest ``virt`` versioned model. When loading the VM with a more
> +recent QEMU version, you'll need to set machine model to match the version of
> +your snapshot. When loading it, QEMU will return an error with the expected
> +``virt`` version you should set, so you don't need to record it.

I don't think we should be encouraging this -- our standard approach
is "use the versioned machine types if you want migration", not
"you can start with an unversioned type on the source end". So I've
dropped this paragraph.

> +
> +VM migration is not guaranteed when using ``-cpu max``, as features supported
> +may change between QEMU versions. To ensure your VM can be migrated, it is
> +recommended to use another cpu model instead.

This paragraph is good, though -- that 'max' doesn't work for migration
is important, and we should definitely document that.

thanks
-- PMM

