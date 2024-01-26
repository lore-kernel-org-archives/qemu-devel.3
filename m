Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F54C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQkl-0005w0-P8; Fri, 26 Jan 2024 13:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTQkj-0005vC-R7
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:16:33 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTQki-0003UR-0Y
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:16:33 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a539d205aso787841a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706292990; x=1706897790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k3m3r/DWlDKxkMoVx8YYRCp3xDTq17ve0cQaruo9Sms=;
 b=xhOiyztSgouyoGx8ZGyYSbDgzsmot0AYpDcUcDzDvxX0CAUdCaluaDAbsjBDlTPH6f
 HTeGK7RfiWFRJIRPpHU/AnjY/dpFqIR5czh21VAGtw+93Rle3oV4e5LCHF/wgh5wNI/X
 wB6vHqEDUB02qnjF6F/S9YZMWwdm6ThBjPzeJewhYd3iMWP1doK4A6hQn5LCbNp0zS6b
 nMOzC6qxii7T8YmpjTukONbKHB7gXBoQTbkxS/Fah++q/ID3MBYWk3gAEpWn52f8gYHN
 trMYJ2bHcCjfDcyUcOwdf9RWigqAlkr1VoPuNM5lneBwgSKHSDIzqSgExn641DXv+Hfn
 UQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706292990; x=1706897790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3m3r/DWlDKxkMoVx8YYRCp3xDTq17ve0cQaruo9Sms=;
 b=RiWxXzf28fxkxTIBANSo6f+6uZeiFbFn20co7EAv9P5Bs7irSJCE9mUHCwXgnGcF2L
 sYSKTrRshhuBCZfZKowJZAsOUcjT4hkYLbrGbwSylpCtaIk8/OzhVc8o+6LO81Qt2qFT
 27WWCGWSTVJTJSr3u3fhZSVILmn+9Pf9gC3LThjf4H24MagOIcWpyd91qHhondHHOcxG
 cXfkXvJrgzI1+I5L6xjugbCi2oDwF4/HNIHHuUShSlGL+3/VNCqjkz+g96CrUvlS84F6
 bFGWex6PhFYondOy31gDv/xMh6bNsOoA28L9IhewE4A+gN6JbW63ob0BskN+OeFylvRV
 4uwQ==
X-Gm-Message-State: AOJu0YytMtwExAhBWy4CJYH2RtVkL9Pxs8lBKimGkTcj7ETvwkKusN1t
 bGKFKJdN232T1VqoZabZuSn9vUH8VZWGkRlKqvM2U4QdRkh9WZfeDiUcrEOcB9ue0OdSgVm6Okw
 22a4v/XmA0xMi01r6K56ruCEFZfZtYzVSaK4ju1t4Myx5/oV2
X-Google-Smtp-Source: AGHT+IFrE4eLiVQmy6rYyKkfPe9xErfuQr238Kn9uZXabCXjsLCJiOi5jkIHHXXHyMnAZAPoX3LyJ3YvVGQ4mvUiXf8=
X-Received: by 2002:a05:6402:5208:b0:55d:2d9f:30c0 with SMTP id
 s8-20020a056402520800b0055d2d9f30c0mr116896edd.1.1706292990511; Fri, 26 Jan
 2024 10:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20240126041725.124562-1-peterx@redhat.com>
In-Reply-To: <20240126041725.124562-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 18:16:19 +0000
Message-ID: <CAFEAcA-iEvpEkOGgMM5sy5S37J1xpqySAYx4ntzhV9JRriJa5g@mail.gmail.com>
Subject: Re: [PULL 00/15] Migration 20240126 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 26 Jan 2024 at 04:18, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:
>
>   Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240126-pull-request
>
> for you to fetch changes up to 24b0c2ec956ca225282f81470f7c26f5bb844885:
>
>   Make 'uri' optional for migrate QAPI (2024-01-26 11:06:13 +0800)
>
> ----------------------------------------------------------------
> Migration pull for 9.0
>
> - Fabiano's patchset to fix migration state references in BHs
> - Fabiano's new 'n-1' migration test for CI
> - Het's fix on making "uri" optional in QMP migrate cmd
> - Markus's HMP leak fix reported by Coverity
> - Paolo's cleanup on uffd to replace u64 usage
> - Peter's small migration cleanup series all over the places
>
> ----------------------------------------------------------------

This fails CI on the AArch64 host:
https://gitlab.com/qemu-project/qemu/-/jobs/6031311759

because it's trying to use the neoverse-n1 CPU with KVM.

thanks
-- PMM

