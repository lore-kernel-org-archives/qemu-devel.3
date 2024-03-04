Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCUf-0003gl-IT; Mon, 04 Mar 2024 12:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCUe-0003gb-4N
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:52:52 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCUc-0004fc-Jf
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:52:51 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so3629400a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709574769; x=1710179569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq0HMb+S0siZfmA5dX/Qip+z0yQCI0SJIdUc6slLp44=;
 b=v0pa5bIZwkl80ezO3urviuBF09dTBbdBDOkX7EiSxTlLXnbCb8QkSf3gnlTmyIFp7a
 7DxC7i+yYcZ7OFoDEy1rFZUTz6WtpKeNiMPGhpMpAYmXNO7I7GHe3r+1TVYTgzHEph8m
 fuLnmiz5cN84jbUclhuyBMa4VfwcccBmPYnpgkHBgFh8xYDAkPNtk4R36zO1VKLpZ9ba
 cDZofj+ZjGbM83lJCcLv89SKje9tsz0Qe07DaiFvnZnmpCABKuN8zlDh1ofWeRBt801Q
 b0hMqCE6PK6gxI48Oh0jc9cJHEDgOYcmdkvnZ5ecXHaKzF1+d9RV4160VIRYqWL9hhpf
 nX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574769; x=1710179569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cq0HMb+S0siZfmA5dX/Qip+z0yQCI0SJIdUc6slLp44=;
 b=Im5A6/yMDzlsyC5AN5bMOEOIntKENUmg6114fTwULhvCD+y5quVhWF8OQv0tFMO3V/
 icjhLXndpwBfmCA0Wjzc3VHIrKzVCabKq+mdiIWmK5+QI6A5gYY7LZKgXDRkEGWUOn8a
 44HHcp46dCDlEorE3ZJWDNbHjXpBsoL7OqnfVrDJMtBW4Lg8CmJ9Et7FQLHtVM5hHt+G
 DDvHxGhiPHlZItIPW5xeTQQY8qkHJUVs+eTbYz1qLEBvomGPeljYxF9gZrFWMcQ0vF02
 jymxMh3jBOly7ayVwFTdIM2BlbIiapD6SIW+naK5p8ENj5fgKqEmekHlbWp4iwfWMMOR
 XSZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMenKrKSSJN0yQLE2qP5yi48gbFQhtoPKCTfIGJbe0lhuUZQJ3Sy3VmRr5oD951vYh2JENKAFDv9uoGMzLjH/dKx5QJso=
X-Gm-Message-State: AOJu0YyIzxJLu3ghMwP3mW0DwS69mPmY3OHddn/GOSgXiJs5hm+dbhnR
 bQ3HhTuyLav12mw3jsL4Fx/UIlIMtkr91eHx1YJVF/M6mItlMOe6uuwgSCs64e2PcX48u+Cy7Ru
 auayTmD8npWwOCebLdFP5WAoQYGzlCdO4ioLNNg==
X-Google-Smtp-Source: AGHT+IGf4AXx+6ZODC9VFm6E1i/T5PvyoOngNIgzNcLHQXLVgMvhJ8ao3V80J9Jxys5rgEL4fsl4vWyYZpY7dyXgdcg=
X-Received: by 2002:aa7:c44a:0:b0:567:564f:5bd8 with SMTP id
 n10-20020aa7c44a000000b00567564f5bd8mr1939183edr.32.1709574769063; Mon, 04
 Mar 2024 09:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-7-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-7-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:52:38 +0000
Message-ID: <CAFEAcA_=iA665ZDjmShNaeftbLbd9ddG5B2tWRuC_DycfrQssQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 3 Mar 2024 at 10:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65dfdc9677e4..d25403f3709b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3583,6 +3583,7 @@ F: util/iova-tree.c
>
>  elf2dmp
>  M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> +R: Akihiko Odaki <akihiko.odaki@daynix.com>
>  S: Maintained
>  F: contrib/elf2dmp/

Thanks for taking on reviewing of this part of the codebase.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

