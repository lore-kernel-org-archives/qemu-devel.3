Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3E1C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9H4-000734-Lg; Thu, 22 Feb 2024 08:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9H2-00072k-4Z
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:38:04 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9Gy-00052p-VP
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:38:02 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-512dc7b7fc2so863453e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708609078; x=1709213878; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WCalUmY3jmC+0gOHXsLUQ3zzprQtwvb6ncOkdtexh+s=;
 b=MZ9p4D0SSLeuksv+VMqsdAsqqh7lY5dzVUCvC4AyO0SsvUbFcLl40+dTegv3k0zP9j
 aR/A4Cm5sO3MmuH7uuapYbcmcu8PfCe52ecz2bzUPCRkw847HalyhYTLq5NVn+sFblIm
 wC3QmDmul//HU4iI6iCbYpGTe896VA7QsIZaGjCYZi6QFyvEu9sLdxTK00JFUVofZ3+7
 uVXzwuvt6KXgczNpAB8aL50/qxnzKYt0w+7uPkQaeKZ2tywZcV5BICswqNFFGopTOFUG
 O85BPiBqWcllS5OK35Huu6/Dpjc9ebbDfOrfPxwCX9aNPigunV6qV7e52k9d7vhG2Y7J
 uZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708609078; x=1709213878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WCalUmY3jmC+0gOHXsLUQ3zzprQtwvb6ncOkdtexh+s=;
 b=QlQzQ5BblMZpmtVTzUCOz/qpY5/tXoIXYhWB5QCdv73yA4CWpGVUWDE/7uiPnGsiYM
 Z7+wU5GNVCU59jpPJpD31WVv3m5qsOplflbD+lVIiBt3fur2KHo2vXio81+HyDA894GJ
 a51QU8xuvO7tU9fg4WEQxvgwTzDHdSNyTrEL2vGHTrkv9dRcs4nYqAcFtRMcAyd5Rp8C
 O9pZNKwzJreXighlnt7Mg68ZqFGlwDX2CxRFqLgHFQpM6j1r7yhvufdhzD5DvNpOs67R
 277bZsjck4jFswRWlpCvFq/xdmLgtvTg8RJsIyENKLkVOc6vkLoEeT6ykbVKgJhXE1TD
 6lIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLxpKzY2iWjun9/P5lmiGpVmq+EWHGXCvSVewuoL76MXhWY9ppq4v4z9LcP8L+UolGo3toKSr6JLdcAxn9970LGTNWecA=
X-Gm-Message-State: AOJu0YwPB23SMu7ietXsZUwsRvJ44/z+rbLQj+J12Nh+lKP5GcuWnuN8
 MXePEFT12BOAK0tvXl0mo1kn7gQDFNsoLmZX9xWyVlPaSkG270RKgLslP2liL8mLBPzBbNrmaq+
 +A5PkHuWP+CqRPMAyiw8xKq0N9E+PddACLg5jwQ==
X-Google-Smtp-Source: AGHT+IFCoXX9EIm9Ax7Kw4ccQM0I26MJ+gUYxD//RahucPQn1LS/92stbuPqWFpaX5TqmbXsHzdWHQb/kzpz9Ebktf0=
X-Received: by 2002:ac2:546c:0:b0:511:88cc:4f00 with SMTP id
 e12-20020ac2546c000000b0051188cc4f00mr12486219lfn.56.1708609078081; Thu, 22
 Feb 2024 05:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20240115101643.2165387-1-daniel@0x0f.com>
 <30980866-7fe8-4900-a75b-01fe735e14e1@redhat.com>
 <5388387b-f7aa-4fa2-a65b-d3a3b52e23d9@ilande.co.uk>
In-Reply-To: <5388387b-f7aa-4fa2-a65b-d3a3b52e23d9@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 13:37:46 +0000
Message-ID: <CAFEAcA_RorzeXwHkBiq1Vjsxsh-u3ymGnJ-xY-4aBj7ivS-rtw@mail.gmail.com>
Subject: Re: [PATCH] target/m68k: Fix exception frame format for 68010
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Huth <thuth@redhat.com>, Daniel Palmer <daniel@0x0f.com>,
 laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Thu, 22 Feb 2024 at 13:34, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:

> This is also:
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2164

"Resolves:" for gitlab bug URLs; "Fixes:" is for git commits.

-- PMM

