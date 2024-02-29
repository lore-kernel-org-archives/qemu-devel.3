Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5360C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiGo-0000Sy-Gg; Thu, 29 Feb 2024 10:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfiGn-0000Rx-Ct
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:24:25 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfiGk-0004qv-Ap
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:24:24 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5661b7b1f51so1757897a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709220261; x=1709825061; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JDRqt2kRtaRcmiIgQ/2TgrvJ3PNvi4qCxIASklb/qq0=;
 b=Eitvuaa3AkbDPY01SGtB5f9A6UyT0R/eAgZj18vtGn4+KNuCj/rcAly5E21HYmpQL8
 fiAoHQubIpm/n+XAiphm0F4AcY92cpsj75pOjU/eXkgNvxZDdbygWbuEeX84kJ/HumEp
 b0MRu2xQQ/hUnjPSjfsLLi8y7NjuvH+FUr1iM4A/vp3MLflWd9dBo0xbvULgUunU6+/m
 WPGfyeeQ1jwg7rb3g3/DhJazVcs2LAS7u/UbchWS69f0iRLjJ5CxqeLdx2U4ED4JE+jM
 eZHy4si1B7G1ZgmtI+E/31fdE1axEXCX8vkE4yjtQ8Y7jVJNBH8sT2FL43D6fnRKMxt4
 Pzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709220261; x=1709825061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDRqt2kRtaRcmiIgQ/2TgrvJ3PNvi4qCxIASklb/qq0=;
 b=LLQxBuo8nDDjRSFxB57XQa2hA/ZZoqmDn+HV7Ro0bXxPRnHL8y4C9IYFAOLSyA0iKw
 Z3l6E6NsITx5Njon04raFE+PY/QJb4WVyb+oq3Exl+/NnLfg0jjqIvYBDz7Uvjg9pbu5
 hcBh1qauYBESlRUO4C4OKVJ/anKqKjoDaEWiE3Gt/1b2dEdxzzkOz8UMgL3lz6gAklTN
 Dm0NmQKjG+fpe9aDOmdzU7GW/yjlgSH+UaeZuQAV86sQaNABixVLPhjTkfCsSGeH8cu1
 yVXZ3Rd3V8fhJeDGttnQmXY0zXbC5YMR3X6GHSf21r0E/RLBJxZdpylKPKAgGCgzTmYV
 kOPw==
X-Gm-Message-State: AOJu0YyWGbxrHgF46OVtv/QBsid5HJi6pamxvTSE9RKm+h/tmZilqb5S
 oWvty1KdYwu4Z7Q3aE3VUwxjsVJfk2KDes8SdtP8SGICCbO8/FVL0kAPRzqoEhUdJuKZTvNjOTy
 ICw+Id1StLpxXDJI3w4g7QWb5uLIgqbugWrcBcQ==
X-Google-Smtp-Source: AGHT+IG17Q8QwFvNtlHE7UuIMgucgk68GUkyqrwxQakMFphWTP7ekA7RF3V5hfutq+ggg+45MVzYVVKo9PhjJwoqQ+M=
X-Received: by 2002:a05:6402:1498:b0:566:76e4:bafd with SMTP id
 e24-20020a056402149800b0056676e4bafdmr1748079edv.39.1709220260763; Thu, 29
 Feb 2024 07:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20240228051315.400759-1-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 15:24:09 +0000
Message-ID: <CAFEAcA_sy+5uFced3mx8WmaUnRiCCF8_QyL1Ov7M73R0mZLNpA@mail.gmail.com>
Subject: Re: [PULL 00/25] Migration next patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>
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

On Wed, 28 Feb 2024 at 05:13, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 158a054c4d1a40179f5e83cd7e1cfe65de457b92:
>
>   Merge tag 'pull-target-arm-20240227-1' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-02-27 15:34:41 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-next-pull-request
>
> for you to fetch changes up to 9425ef3f990a42b98329d5059362f40714e70442:
>
>   migration: Use migrate_has_error() in close_return_path_on_source() (2024-02-28 11:31:28 +0800)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Fabiano's fixed-ram patches (1-5 only)
> - Peter's cleanups on multifd tls IOC referencing
> - Steve's cpr patches for vfio (migration patches only)
> - Fabiano's fix on mbps stats racing with COMPLETE state
> - Fabiano's fix on return path thread hang
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

