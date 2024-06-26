Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DFFC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVJs-0005xy-92; Wed, 26 Jun 2024 12:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVJo-0005uW-0U
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:16:25 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVJm-0005rY-D8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:16:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6fe617966fso458798266b.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719418581; x=1720023381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WWFhJQV9EcgvIMRLXLoG6uNdudSKhjHqBmF9m0oHDgY=;
 b=ZFinh8oE3RfRK3BYGgdf1rH7UBybdfc0UrUOcOK4R0ZlqwiDGDw187o6JP+eaqf5iL
 38pBMzcRRXYmGuJ52WmSnt9Llm7Ee1XWQcNVV3sGsy5HsAyJtgoZXq+o8k+Liwmrk1f4
 96sGqp56sx75lgQadWA3Nq9IR7NZfw+6xcDdZ4eaL7mRa+odSWu8BmxlErApm9b/fgso
 /YepL0pTbYryNnFCO3+wqcM0boAJ6RUL5M7uYclPJfAZpP4ckpi+qLcJ05ldeCIvASnt
 pv2t2bKw98BG6WOGJkBFdIzU3I1BF3UGdo5SDlRpSOkpZCNUOO08XAht0e55qeYXduh2
 afbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418581; x=1720023381;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWFhJQV9EcgvIMRLXLoG6uNdudSKhjHqBmF9m0oHDgY=;
 b=gueoor46GIH5Mn30cYiqdU5d0kBHqjPyJH3KFU5ZT6MwyhJ569DKsa5fNh/8+TyLDT
 ZbxPQmyKv12tzP1HkmsYX5FAo57J/v97Q/W+za2zZ/2OOxUjrvNsk47RR/yCxbwApw/D
 uZvULBdCKJBl7JPPBfzTNnrtKAsDmqfBLZM7iC+YM+41FbvKHoWyXzOdHZW5RwyBeuOf
 +hUEOt8VQ47BanAO4cDfKiwxUUomWXc3BaDr9NL8fA5vgGVERZlhbIwajoClBosE0OGw
 a1tbRccpcc0KsNmKqMhyB2bmOKWoZlLntSID/nXUPglnIGCO+zIZzgOyoyvEWEx/gW3e
 4y1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTfB/ZLS2RHUqtuX8vAdwUZFiRc4val5CoTxguVMlvgXz481CMQDcuCFhcno4m3QbA0K6Kh4PyB6qV+j+EUpLzKjmfZ8E=
X-Gm-Message-State: AOJu0Yy7swNIlkrLUmiB3SGZn56nh27T1JZQ4fz+TZygmMRiLjLJfm3Q
 YK+pIHGFS76AgHLs7Nc7G0Sj1ccAgj4c4AGtK19FRC/muqo1nmx8MBJBcmuRsoCTW4t5cb81wLs
 V
X-Google-Smtp-Source: AGHT+IE0QBgAJUr5eJ+5F6SO0x5tR8DNTo1gdbGLeYm2/cUIaIw8TmP5WeMtSV5eQp1ZaqqfehHTZg==
X-Received: by 2002:a17:906:c2d5:b0:a6f:6b6a:e8d2 with SMTP id
 a640c23a62f3a-a7245b4cac4mr666935066b.11.1719418580532; 
 Wed, 26 Jun 2024 09:16:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7265580e84sm222724166b.98.2024.06.26.09.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:16:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B18D5F8AA;
 Wed, 26 Jun 2024 17:16:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/docker: Specify --userns keep-id for Podman
In-Reply-To: <20240626-podman-v1-1-f8c8daf2bb0a@daynix.com> (Akihiko Odaki's
 message of "Wed, 26 Jun 2024 20:09:37 +0900")
References: <20240626-podman-v1-1-f8c8daf2bb0a@daynix.com>
Date: Wed, 26 Jun 2024 17:16:19 +0100
Message-ID: <87v81vof1o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Previously we are always specifying -u $(UID) to match the UID in the
> container with one outside. This causes a problem with rootless Podman.
>
> Rootless Podman remaps user IDs in the container to ones controllable
> for the current user outside. The -u option instructs Podman to use
> a specified UID in the container but does not affect the UID remapping.
> Therefore, the UID in the container can be remapped to some other UID
> outside the container. This can make the access to bind-mounted volumes
> fail because the remapped UID mismatches with the owner of the
> directories.
>
> Replace -u $(UID) with --userns keep-id, which fixes the UID remapping.
> This change is limited to Podman because Docker does not support
> --userns keep-id.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

