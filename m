Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E358D49216
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 12:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU1pZ-0000Gg-CU; Fri, 12 Dec 2025 07:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU1pU-0000GB-RT
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:01:02 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU1pO-0006TL-KD
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:00:57 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2e5da5fcso773573f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 04:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765540852; x=1766145652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xVQ07WIMAbRsGFKjwfGN6qUZWXk4IPt/t2JtQbcGKc=;
 b=ejXVntldmAsynX6EsOTCpMX8lh4lALXdjZRHazTxjG8cd7f3YpsXplvsvXAuPbMgtz
 Sg+D47Awi6cWnZ7XEDzTyz0cXetrQ4xy5wvKrSxn2GerdZ6ost4Pvg9Q1BbpgGMEHSxw
 CqrPdyGz/b/jWZHKt3XvEmj2q6SeVbKmQy7UsUqParGOlKYUAjiDaxcMI0Cwxa3QrYdb
 XxkCvFJbtxw2qBBKwGCllz8k6wvbm9ZkhP3ZC6pI1wKSPunayPzCZFNA/StToz1Urt0E
 abDcCqVZ9M2o/1jSiD3wamP+BWcfaPqAH9nrDorcAOYwLtzbgJJwLvf+/3Gd9EL2+XVg
 Jx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765540852; x=1766145652;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8xVQ07WIMAbRsGFKjwfGN6qUZWXk4IPt/t2JtQbcGKc=;
 b=X7FDVC2lkyGNJ4k5yr2lPi3EwaOZJEAVJB4pphYxUCP3vF2/QlLZnLTktz8GX1Zxn1
 bowx0fmAUBYUgSTsxa8u0r9XvZgAvmPZ3LQaRDuNBGbTif/6x4//eQ+jYEinKSMbO6MU
 gTY/c1Nksog5exO30H2XfGR264DGaJybxTf/P01HsgrWxHnURgFI8SXMh0NvUra39Qrs
 QXpu9y8WsZgjRXTr7MvaXzikyo0ALhj8qBkVdz1rnK+dCztjrlw6CXQeBIznHQ/RTqRi
 p9lzQ+t6EFOIYPY2jlXbEPOefcs13/CWcPklVCqbNw5U9BgIoY/FRsVgPAHF5V9xnADP
 1Eew==
X-Gm-Message-State: AOJu0Yxj4Z5JZxPMRM+VJhKVPbp7+o8idvOibbqtAUhBG/AK653Epho/
 BwgdDIAR0/PWKQqchlfTQhn0CQVemAFrREaD0QEWHKDfkou/xCA6ZMqzZMmeBBnrLlU=
X-Gm-Gg: AY/fxX62oKMOTB2aAePA/AJge9RKpzw/p4LLxJ9fdytlKAehdEVDXJZ52wOhetI2jgx
 U9KFh4hmtPpiws1bd/19Y7lrya/KvwXPS3blCiYZURoz7c+XVG+/lHNALuSlof7Gw1bNAyXD/RW
 mm0ph+cj0v3mtL8nkHf5DaAhnGb0Dksjc5hadL2IABzo9Q8G9e2EiFEZ5ZSv4A7/JIukhikikbk
 gYRmUblLzWomsY14QXGiDYBYurEC6qRL81UhPFA6W0JQ69JzgpmsJhTR/x5KfZQkGt4XxulVfv6
 zxVBuJ/ZflfxdZ6pEfkh0fdxTP/11EsvuGybrni72NeDriLrqkjMGH32zRXAH8TD0VRq6xb4qsV
 17/gtP7XLZP4tSLDlnI8FKUDDaGyhiQIcPO2yAahdz62C7tmjR91NWEpfqqfDVeY1lhnj6P/O/S
 3zTzxbyUiHHdA=
X-Google-Smtp-Source: AGHT+IGKXpS/J9mfarA4CSgjs+ixeZmanM3/s7Qvc9bkcu9lpq3yTMXXs3qgNkRIx/GGv4xN+pVLfw==
X-Received: by 2002:a05:6000:1acb:b0:425:742e:7823 with SMTP id
 ffacd0b85a97d-42fb44a2407mr2165691f8f.12.1765540851739; 
 Fri, 12 Dec 2025 04:00:51 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b750sm11246600f8f.42.2025.12.12.04.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 04:00:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9EBB5F82E;
 Fri, 12 Dec 2025 12:00:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex Bradbury <asb@igalia.com>
Cc: qemu-devel@nongnu.org,  erdnaxe@crans.org,  ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 0/5] contrib/plugins/hotblocks: Minor bug fixes and
 add limit argument
In-Reply-To: <cover.1764716538.git.asb@igalia.com> (Alex Bradbury's message of
 "Tue, 2 Dec 2025 23:05:53 +0000")
References: <cover.1764716538.git.asb@igalia.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 12:00:49 +0000
Message-ID: <87o6o3ucy6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Alex Bradbury <asb@igalia.com> writes:

> This is a resend of my previous patchset which unfortunately seems not to=
 have
> been applied (see
> <https://lore.kernel.org/qemu-devel/cover.1753857212.git.asb@igalia.com/).
> I've rebased on current HEAD, checked it works as expected, and added
> Reviewed-by tags to the patches, which all received review.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

