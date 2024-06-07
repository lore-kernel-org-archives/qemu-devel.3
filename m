Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595A9C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaSv-0000eL-P5; Fri, 07 Jun 2024 10:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaSt-0000cu-Kr
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:21:11 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaSr-0008Gp-RG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:21:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a30dbdb7fso2930662a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717770068; x=1718374868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uwa41rkjIFb2siIe1EJT8B7NiKbO2eiLM7ot7b/wWJg=;
 b=kVB9CB1GIHmlf+NTxUg77y76i4V3zu9yNKsyYrSnmft/Bsnboet+tOPIHIKOjw4zFX
 dcAnOQzhbunXuCXbs4UYY8NtxnWP4fSyboob8pU9b1jmpYMT4NyFL5qOEFt+g8pNjUnF
 5LcHfGTdI9jWRSANgxxquliIM9FjLbGGGL/4ri0hCa4bHTT5s3ql7NcfPEYVCnyJB8sV
 JkUuqbg7dfiTAZH7Mgo83OGFO561xqRk9DHKsy51h7+HvJM7dP2ibk9gu6pWOael3A5S
 hqBb7Nf2PhGFtCfHDN25jH+7dPAqJbMfGdAfwpCqtco4/FMTPo+TAuhpgMFegtJHy0VC
 HtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717770068; x=1718374868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uwa41rkjIFb2siIe1EJT8B7NiKbO2eiLM7ot7b/wWJg=;
 b=kY+iDBEn4DKdknUKF9j6GeEWdcHveonNhP287K+JYJBTz9UsPaPoFKU7r43mdU1xmF
 UpdgywrS9iBAnoX4ogvnV/9CbOW0STS//+rQZM5vN8x7dYOGksN7xmZVg/whbGtrKp3h
 mCzR09wqNfl0MrSPuP12HThgsFXhp+qhAHGIXThMZKmVv9+x7/84sDAyYh2b6jJ+HjLm
 JKNn87lOdwQJc8aZKWuYW/P7NOyA6SLzUBncVbXyD+T6YJ2a9hNvwiL0fvcCyDgt83bJ
 mJNLufsyHgYVuDpPGCFJQpvORSTBUSdhLpiXEIRB2n+Y9X1V+x8brHxza6kTY+3FGhfS
 reqg==
X-Gm-Message-State: AOJu0Yxvx5gVacuzNqJ6wi+JLFDG1C3VCoN63g7bIYpPlKScGdzWDqFB
 uWvnFSspAlua3WszaaQQtLE9hjdNYzvgLvOYXwekdIwTJk2yZNGhCwqzDuZvYzzoaKgTF84Hspx
 B9iWAgg69M1Xl58AvzIJeUD2oVpJVAq4jzWWXww==
X-Google-Smtp-Source: AGHT+IG5WoPBgaqu9M5Bsf9j3Pk9qFLWKMPwW0T0psIyCG2LZAC8Cx/0uPNVWsVXiikpLN8cXL1pC3yLYgd2mYhr0+w=
X-Received: by 2002:a50:8e54:0:b0:57a:2a56:8a37 with SMTP id
 4fb4d7f45d1cf-57c549edc3dmr1256500a12.13.1717770067982; Fri, 07 Jun 2024
 07:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240604064409.957105-1-pbonzini@redhat.com>
 <20240604064409.957105-19-pbonzini@redhat.com>
In-Reply-To: <20240604064409.957105-19-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:20:57 +0100
Message-ID: <CAFEAcA9W4V8o1KstZo5YyDZo9+JZ3uQ9KApnjZ5EOzuSc+ZpfQ@mail.gmail.com>
Subject: Re: [PULL 18/45] i386/sev: Introduce "sev-common" type to encapsulate
 common SEV state
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Dov Murik <dovmurik@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 4 Jun 2024 at 07:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Michael Roth <michael.roth@amd.com>
>
> Currently all SEV/SEV-ES functionality is managed through a single
> 'sev-guest' QOM type. With upcoming support for SEV-SNP, taking this
> same approach won't work well since some of the properties/state
> managed by 'sev-guest' is not applicable to SEV-SNP, which will instead
> rely on a new QOM type with its own set of properties/state.
>
> To prepare for this, this patch moves common state into an abstract
> 'sev-common' parent type to encapsulate properties/state that are
> common to both SEV/SEV-ES and SEV-SNP, leaving only SEV/SEV-ES-specific
> properties/state in the current 'sev-guest' type. This should not
> affect current behavior or command-line options.
>
> As part of this patch, some related changes are also made:
>
>   - a static 'sev_guest' variable is currently used to keep track of
>     the 'sev-guest' instance. SEV-SNP would similarly introduce an
>     'sev_snp_guest' static variable. But these instances are now
>     available via qdev_get_machine()->cgs, so switch to using that
>     instead and drop the static variable.
>
>   - 'sev_guest' is currently used as the name for the static variable
>     holding a pointer to the 'sev-guest' instance. Re-purpose the name
>     as a local variable referring the 'sev-guest' instance, and use
>     that consistently throughout the code so it can be easily
>     distinguished from sev-common/sev-snp-guest instances.
>
>   - 'sev' is generally used as the name for local variables holding a
>     pointer to the 'sev-guest' instance. In cases where that now points
>     to common state, use the name 'sev_common'; in cases where that now
>     points to state specific to 'sev-guest' instance, use the name
>     'sev_guest'
>
> In order to enable kernel-hashes for SNP, pull it from
> SevGuestProperties to its parent SevCommonProperties so
> it will be available for both SEV and SNP.

Hi; Coverity points out a problem in this code (CID 1546885):

> @@ -540,12 +491,21 @@ static SevCapability *sev_get_capabilities(Error **errp)
>          return NULL;
>      }
>
> -    fd = open(DEFAULT_SEV_DEVICE, O_RDWR);
> +    sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    if (!sev_common) {
> +        error_setg(errp, "SEV is not configured");

Here we check for a NULL pointer, but we forget to "return",
so execution will continue on...

> +    }
> +
> +    sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
> +                                         &error_abort);

...and QEMU will crash here when object_property_get_str()
dereferences the NULL pointer.

Adding a "return NULL;" should fix this.

thanks
-- PMM

