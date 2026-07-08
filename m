Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA766C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTv1-0002ze-Dx; Wed, 08 Jul 2026 11:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTv0-0002zW-C3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:10:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTuy-00051m-P8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:10:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso467715f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783523431; x=1784128231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dog45U8CslKPZMBfN7lbot2aKITEtDC47Q14kJ0vTB4=;
 b=fT4KgbgqPNd4BIo6TJoNhuawStWxG+HmT7jgskjI4iNe0Biyk27H4fhovHSjdjB8/Z
 ulEuTZ32l62HdEFVrR0u3Q+2vSgQFsHpoGP13ZIiCzF/6EB9e7HSo31VKor75/BRzzRw
 x+Kp1AMZjD6GmHGMbq6h97tFE0b1s6FUWfcdsrqb1/ptojruU5Q5+noCJU/HxP7PYRSr
 CUPHjofJ6AmKDMrvY8ED7nSOyyzKKD+Mmj1H94Iwj8eZsgE8rh6AwiCy5mpL2O0BxqZB
 y/JVlhFSDYDkmhH5LwEPHdx/0nSy+mutMB28IfiwbpP6fg49CqFmwM2cuMXpNyG5T6HZ
 /rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523431; x=1784128231;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dog45U8CslKPZMBfN7lbot2aKITEtDC47Q14kJ0vTB4=;
 b=VEIsQ5alW0/JtkBurhjn6sK0nVWD6dRB8dI9RQogarwVXlFwrZgY5DPPEn+zYyBZHE
 MZWkGDaE0LXrU2OMV995aXW7om6cE4x65RnSvHAcvawwE5jSTuniAYfNK/P/O9yYdhrO
 H4dmqBUQqoNABE1sNFVTsLf8gNegecA5/gjRwDxaULNDTMBXji9+ElReIpkTE8w15VSL
 37SlkM5HEF9FoRzHg1MLU0tMqToR2cEBmyOJEwwKQFR0e6E5D13KHhQfYFSxAvZ+FpwO
 tsuD0E2JrAholWZQu4B0Uwzq3G2lLNpMUC6xcq8LPBKtb5FPE932qX2J+Zr1S7cqx1p9
 c8yw==
X-Gm-Message-State: AOJu0YxOl6A4KSYka8FSOiJiFUBJeFEZsjsNPCrFYCsknnf+VVvL0Slq
 kEvITPNO3c1gYZmNp/ptKnC1eJBiWUXSia4aE0/Lh/utPp4A4AnwzBGvvG9nNigJBT4Zf4/ILeA
 gnz1IwjM=
X-Gm-Gg: AfdE7clRH2OtspS/Y9ao3zSXZe6WL96O7wIyq9H/RzogsZBJ9Tn7EhKS6J0yInkRAzh
 VK1qezymHZtFeK2oMkzqVg0hyeZAuBuTpRtGfKp3I1iyYAscItLNBNq+S4mA9c1dPTIs7TD5mr4
 X4XUZIkqMJXl4tVPSFCCCZ0NTwJhIXrdoyVw2+v1CCgWoXVjlari8TzoEUclxnUGkqHIAB1GJgm
 Xj1lpBj+zU9aAX0teAY4XrtNT/kgEVcqpNB+DRTpGFosFHalpV8IcLWPOEL4Z4T7SjeQmeanfBv
 CC4Xy7f7kE0IuktYyB+NQIsIFUb4iXjd0hxtq83dlCkSZvOIDmdqqe3BOXrspEUsKCSxG/cfrSC
 zKFs2dg2GazLJewA6W7g7T02JEG7zP6LNFS7oukXRHi0uJgc+CPL3wGCW0MOokb1jGdRm93RWLd
 2hV1vKYkXtpOk0
X-Received: by 2002:a05:6000:2312:b0:472:6602:3347 with SMTP id
 ffacd0b85a97d-47df0807c50mr3393583f8f.43.1783523430815; 
 Wed, 08 Jul 2026 08:10:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm42703347f8f.28.2026.07.08.08.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:10:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A744B5F8F3;
 Wed, 08 Jul 2026 16:10:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Ryan Zhang <ryan.zhang@nxp.com>
Subject: Re: [PATCH] mailmap: Fix Ryan Zhang email address
In-Reply-To: <20260619071422.99061-1-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 19 Jun 2026 09:14:22
 +0200")
References: <20260619071422.99061-1-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 08 Jul 2026 16:10:28 +0100
Message-ID: <87tsq9tt3v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Add a .mailmap entry to fix the invalid email introduced
> in commit 490a3e1867f ("ui/sdl2: Set GL ES profile before
> creating initial GL context").

Queued to gitdm/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

