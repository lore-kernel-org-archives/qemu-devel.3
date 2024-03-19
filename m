Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFAEC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmWd5-00070q-Fe; Tue, 19 Mar 2024 06:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmWd3-00070e-GM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:23:33 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmWd1-0007I4-RM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:23:33 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56b85146589so2141055a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710843810; x=1711448610; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPmHxYAXJtSzwlMtLfrxRM+9nElh6nAnY6hVIKy1Xdc=;
 b=ewRdZ3BkQreQ8m0AUS0dZ0d59W/dvLkaWk0IYKvSPfC+XtvM9GYkc3py3mG/FyWPR0
 xnpZ2XJ7FP44IVy6ESB3Q6KcbL88hPFsO6ra71EPWkmfpijyH1jjMzHlht4UAZq9LjSJ
 fRgTg8yRnonA5lJkuzKS8lbw7aeesvV0PdPLl7zhTEIjy8Z5YOcyxmjoar92xSwPN9E/
 SyDnCu8h6D/mzWbJHepIXd2E8DzNxDPfFweDoWbNJ809BPdefpxjxR7R7/4pxXzIOuOG
 psCZDCGqubNNsPab81wfD4VKlFi4/jAlKKDTLFMUubdvTM6q9mD6q39DoErqsY60Dk1X
 jTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710843810; x=1711448610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPmHxYAXJtSzwlMtLfrxRM+9nElh6nAnY6hVIKy1Xdc=;
 b=Annfmo5EDhIjm/jB8jFYsn0NnoKs5c+/B9iPBJBy8cJvtM6RLSPVcFsPHzU/IoJSAA
 Rtd9UzFPc8MdEyciPwA8GKaGU0O/bJfcpy8Kr7wGWbXSIhFHES6ITWpx5S+nYps9HgNC
 HgpmHsYtH1XZ3o//wvdk8xuHsWhOi2rPHN0nohrFn7xWx2DeqmIi35FSvhwRprBRZJ1P
 Rxb8oX7KHxpgWV5+9YsfwTgdGmAaXCoXzmldZvMiPjjxYR+V1Lh5wv26HhxcV46l/pUV
 My3FQUSAs64nTcyMjeCxYi6wf7bSyESoJmoNF3lhjT84VAlr6TOD7LjW+PHhBDLZRFQw
 QIpw==
X-Gm-Message-State: AOJu0YzYj8vglLNovH9DCUm15ZLxUnRC3dfngHFEQ2zUDbx1zoWw2CX9
 CJsrenRAZ0OPTNVS4D0fJpNnrMOIxx3wk8mGtNKnin4Hj2LGTP7+oZzR0HrpX8zpyxQGTHL6ofK
 HGFlT/M4ODe1w7U46OWaB5A8FR8qP7jpg6CzlZw==
X-Google-Smtp-Source: AGHT+IGsGXQxZMzX1ICa0ArgJ1330Ldp4w9P0dpE3GHY2C0RsjfddcbsVlweyoNpuUT9/pM4yHT1y7rggExvZskEKoA=
X-Received: by 2002:a50:a6d9:0:b0:568:aced:e5a0 with SMTP id
 f25-20020a50a6d9000000b00568acede5a0mr2125864edc.14.1710843809730; Tue, 19
 Mar 2024 03:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240317205803.361163-1-peterx@redhat.com>
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 10:23:18 +0000
Message-ID: <CAFEAcA-Bzvj-x1nqhN4N6iU2oSjgJw0Hiy-wM8zndh_XXqihiQ@mail.gmail.com>
Subject: Re: [PULL 00/10] Migration 20240317 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <ppandit@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sun, 17 Mar 2024 at 20:58, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 35ac6831d98e18e2c78c85c93e3a6ca1f1ae3e58:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-03-12 13:42:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240317-pull-request
>
> for you to fetch changes up to 9adfb308c1513562d6acec02aa780c5ef9b0193d:
>
>   migration/multifd: Duplicate the fd for the outgoing_args (2024-03-15 11:26:33 -0400)
>
> ----------------------------------------------------------------
> Migration pull for 9.0-rc0
>
> - Nicholas/Phil's fix on migration corruption / inconsistent for tcg
> - Cedric's fix on block migration over n_sectors==0
> - Steve's CPR reboot documentation page
> - Fabiano's misc fixes on mapped-ram (IOC leak, dup() errors, fd checks, fd
>   use race, etc.)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

