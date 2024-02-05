Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55807C48298
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 12:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWyLA-0002ZP-Ve; Mon, 05 Feb 2024 07:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWyL7-0002Z7-NA
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:44:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWyL4-0007qe-DW
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:44:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so30505325e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 04:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707137080; x=1707741880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJoFIuhgZegAh08IWT8vkYB6iEY1Gc3ZsYBcFzkueY4=;
 b=KTxiKVaiR0qIjiUA3YQNItcgyx22VffPrxFhZ7cOCfJQYpk/pCnhStvb/kc87MCg4W
 YIR2V+tx92qxQG5SM/C3nIkP1grQDt9d2Hz1z8VKQd42+Np+mWHcmibMRvMzQVqPMnSA
 3AbhL5L3xhAHii3C9ub5dEVCQAkeojSb07bW3OLovgg3+XjoQpjwzpqqw4KbtFaW0FkR
 pBynYlxcG5z/2xLjaUFwNXJekNpKQc4aNcuHqBDGMeZmMDi+mTZ7G3OAHcZDT2lhzm+L
 KdsIgGYGAXwpLv3cOurIg1zIINSCsPC0/2c3hz+ZG2D7dHqBDHK5oqmNJZs/s9ifIC6b
 E2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707137080; x=1707741880;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FJoFIuhgZegAh08IWT8vkYB6iEY1Gc3ZsYBcFzkueY4=;
 b=T4xpr4SkpfobdSorhrE1dfujUge5HpewesJf1O/ITvMIx+24c0DjW4Cy6P1bJscnWz
 tuoKrg5qxGumRqdzIS1zgRf0VzrD4tzFzUW14sYAqCdGBsY1XBNtC2QfKaJOnFiEvZd2
 jjxCSjFS/JzCVFU7ZmNyrL+BkHZVXeDU7gRPDB1E0Z16ONv5TZ8oFPtzBo+UXfnuaPY/
 A91H7g2m22C+emAUYrMUOWndvLBjnJJSK1mF5jvJOV6KAfOmo3VFabJikax5iwCziptQ
 CI79XncrTZCf8m2x2EykQON7Cq8jjE2vYZ2VeZED/HPHmWL4byznQ0WUxHIzOmA/zOZA
 cfuQ==
X-Gm-Message-State: AOJu0YyJv/miSWJIOZNBVzXtSjBVvtAwY+h0TNgF7jeTp+Pw2yV3QVTj
 r8f0n1DDHb6gZqb8GefqlwQb9rPytpkWqjytSP0WLrTz0Dfrhuio6SgFcbwBk7I=
X-Google-Smtp-Source: AGHT+IEFey0CUaz09N1HwvWBMUD0pmQiGwyocJEXOOxXcLZSvSfoghUegdq9fEa7bCy+xox4ydpCGA==
X-Received: by 2002:a05:600c:4f8a:b0:40f:db0f:9022 with SMTP id
 n10-20020a05600c4f8a00b0040fdb0f9022mr1744410wmq.9.1707137079732; 
 Mon, 05 Feb 2024 04:44:39 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUI2EI383G73GCjF4UN3K63SrY2jV0bCY/zeHI3y4hFsDUJaVpYJageLWaIwO1tTBHPCpLQE8vhVTm92jnq+1hZBccDoatwdSzuBRD8OrxnJQlM0/Qi
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv15-20020a05600c548f00b0040e9d507424sm8526798wmb.5.2024.02.05.04.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 04:44:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9B9A5F888;
 Mon,  5 Feb 2024 12:44:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  raphael@enfabrica.net
Subject: Re: [PATCH] MAINTAINERS: Switch to my Enfabrica email
In-Reply-To: <20240204023758.83191-1-raphael.s.norwitz@gmail.com> (Raphael
 Norwitz's message of "Sat, 3 Feb 2024 21:37:58 -0500")
References: <20240204023758.83191-1-raphael.s.norwitz@gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 05 Feb 2024 12:44:38 +0000
Message-ID: <87fry7f5c9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Raphael Norwitz <raphael.s.norwitz@gmail.com> writes:

> I'd prefer to use my new work email so this change updates MAINTAINERS
> with it.
>
> Signed-off-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f9741b898..a12b58abe2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2556,7 +2556,7 @@ F: include/hw/virtio/virtio-gpu.h
>  F: docs/system/devices/virtio-gpu.rst
>=20=20
>  vhost-user-blk
> -M: Raphael Norwitz <raphael.s.norwitz@gmail.com>
> +M: Raphael Norwitz <raphael@enfabrica.net>
>  S: Maintained
>  F: contrib/vhost-user-blk/
>  F: contrib/vhost-user-scsi/

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

