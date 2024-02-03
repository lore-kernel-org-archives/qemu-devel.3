Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB26C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 16:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWIrb-00076q-Mh; Sat, 03 Feb 2024 11:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWIra-00076Z-3e
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 11:27:30 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWIrX-0000tm-O7
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 11:27:29 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5600c43caddso1014947a12.2
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706977646; x=1707582446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ci9vG8YGLyJYMOSKzLmaGmMLOOPb6Y8LRkEkvYKcgw=;
 b=CoZDgI+PxCznUQwnptiPJ8ONZB49thxMeJRKrbDLpbDdnXU9C+EPXo8C174bxYrK0a
 cal1vAPAMnUYOusAvCL7eLemQsc/KZRVi6XjLgCHYpiLSLtqP4/D5pz0P0iFEpFlEAUm
 iffDWXGTFEKqcjsqSFiK/RIowpl7O+8ty1t0MfGGHq9Dpn2Q1DzhsCvsyAvmXYqyd45D
 H/NlQsk35tqQBmArwC+eNCLhhlfE5o+Jzz0D7cS7jWYg+opf0MGZb/2Ya1Uu5e0kG60d
 5eeauLj/OxFb4HcVmPHTIrFsTxmaz+c2Zh+zIkD9kfgJqDNBvRIbTGIccfZz2rxsUA2D
 ar6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706977646; x=1707582446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Ci9vG8YGLyJYMOSKzLmaGmMLOOPb6Y8LRkEkvYKcgw=;
 b=iMrzw22w9sbxj5AKk34Dv1CmjwEmDyBSyH9VK6QhqmE/EtIScQBca+sneSlkBxvdVz
 D2T32XW3JT+/bVuPkeom4/N/6bOF4WV2tPWApMJopU3Xi7KGUhbltzdeN0xCem917/vL
 hPKBrNlPcW1rrgVzNnbC42tdd3re/s9vvxp/2l+AWWqsaSCYuV0KRZutiXHPm96ejicU
 giNFTIQr4epq4biXGkHePue31hLjyi8tCkN7x1j4IDNR48UMh1w1mn2GppnV6I+/8TtN
 oNwZCq2qKkeGyluxwWhY1JhnRqpFyn3jhdRuVILnOtuDrm25VpOQ9/gav+yalUADxQkV
 ufWg==
X-Gm-Message-State: AOJu0YzoFubGzMLo0TIcbbkOOtKWkr17fqgnpUHzMc+UZJifPo9gtsD2
 i9M5ce8aaV43GzzkYC7mRO0lOf4/CAUCfCRll8oWwRzguhzddrUG2BOVbILsFMr1/cQG8Vijei0
 mxk7uheva/ogz1HgZzYt36FxeVrmh3gxjBUvtdw==
X-Google-Smtp-Source: AGHT+IHcJs5lBXIMlcmYukTOlpXnFEEkUKjFzwvKVHNnoBK+PGU5XGvlu2gWmdyvGjQVAmpxPH3h30PvWOAbQTt0IsE=
X-Received: by 2002:aa7:d6d7:0:b0:55f:aff5:49a3 with SMTP id
 x23-20020aa7d6d7000000b0055faff549a3mr1827197edr.8.1706977645784; Sat, 03 Feb
 2024 08:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20240203083415.2937003-1-armbru@redhat.com>
In-Reply-To: <20240203083415.2937003-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Feb 2024 16:27:14 +0000
Message-ID: <CAFEAcA_8F_N9A4awQZH=0FyZzzLtiqO5VJ+DNEsvzwC5BYdc_A@mail.gmail.com>
Subject: Re: [PULL 0/5] QAPI patches patches for 2024-02-03
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 3 Feb 2024 at 08:34, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 29b008927ef6e3fbb70e6607b25d3fcae26a5190:
>
>   Merge tag 'pull-nic-config-2-20240202' of git://git.infradead.org/users/dwmw2/qemu into staging (2024-02-02 16:47:36 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-02-03
>
> for you to fetch changes up to 3424ed6caf9759eb57405d965537fd5f3d70026b:
>
>   qga/qapi-schema: Move command description right after command name (2024-02-03 09:20:33 +0100)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-02-03
>
> ----------------------------------------------------------------
> Markus Armbruster (5):
>       qapi: Drop redundant documentation of inherited members
>       qapi: Drop redundant documentation of conditional
>       qapi: Elide "Potential additional modes" from generated docs
>       qga: Move type description right after type name
>       qga/qapi-schema: Move command description right after command name


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

