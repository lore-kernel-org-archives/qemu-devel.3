Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2455EC48260
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 23:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX8DW-0005PU-Dv; Mon, 05 Feb 2024 18:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rX8DU-0005PH-Ga
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 18:17:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rX8DS-00012m-Sh
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 18:17:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40fc52c2ae4so33709485e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 15:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707175048; x=1707779848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeitvCb6Uw3OX3SJK6enKNtlPCWLILVXV5A1PXhfUkI=;
 b=VXaSwvmzALDGvtyZ19qJRQ2IM7zpHA/LPiJPA0cRerWRRGlHB/MfoZ0NbbSdPNGC+g
 u43j7ZYNu2wFjr0Da0HR46szEbKmNrG1i15t73sCV0e3OmwrR4ORqqg9Ct9/haEWte5H
 GMI9L7e4pC3pnmCiTlgetEkG1ISZtNn6gZX/7eo1fpH/k/PeKA7yOHm83KxuZ/msCFLt
 XC0mDFh8RiyWUPmr+1wk7ZmKLcrx64xbZ2RBi/sMiSvrna7daj54Uv6XtOqyzJ3InmiM
 ltxXdmkrC8evA1N/P6tBzaKFM7RiZIY58YJf8/Qj4Sbtym88q5YmD+N/ER9zdG36z1Kg
 sSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707175048; x=1707779848;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IeitvCb6Uw3OX3SJK6enKNtlPCWLILVXV5A1PXhfUkI=;
 b=jHyq+90vvIK8zTuXNy2qEMPmp1H4sAcYDTpajK3skFEzyfjYjlqMgDjwK67yeSKQaZ
 R9NeRFw9Qve5lU5Sci3A1ezb7TiWvDw3GhB1+SW46wr1BSIRhjo/11SGP+Tmf2yv1gPb
 WAFyKXbI1DVMT0zM0ASmYPIAsXZy3poPjLnq09JwnigtJ/6hmk+rpYgIHnxX9qiXiJS1
 VzkhLO44hbjfXDfpSOLFgh6p/bHCHXhAzRm7IYSJhKfbui0+/5TGhcaHuNO8clXbSg5y
 61OeyACvH2QVse3WypnPrwqsI6/+lYPezjVuF44Ypo2Gh2ZUjDcDIxCxGO5oDv1+ct1G
 KdoA==
X-Gm-Message-State: AOJu0Yx6S/CKIZty81r843hE/KSbDgpIso0PlA+jReu6ap4oJxYXWEu5
 kHIiCioPQgBh10S3xXWFxfzDpVqILN1q2SV/R1toHu678E2EioCo93SgzYWqzEU=
X-Google-Smtp-Source: AGHT+IGIxH1DHxev+4qg0Z76gfy/52PfOh6kgbdh/WfG4ghqV4wX7GAdGZCzea0z8PKL8xeqMR8Jlg==
X-Received: by 2002:a05:600c:5109:b0:40e:ac4f:7156 with SMTP id
 o9-20020a05600c510900b0040eac4f7156mr880879wms.5.1707175048629; 
 Mon, 05 Feb 2024 15:17:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cCEnBoRA5sw6vTXJkRq8Ikhf6GdUE7GbzWWjNH+OCWj4Wth+3UmnTVltHSl/7XClfKaq3Gc0bn39Iohz754m6dWcByV1IdxPy9FDdsOrT7qsdqitCYnbmK4yxWxTIjXhFoQ1GglkgcG9Sd49bG6EDFQFLQGWppQJTcxHnY9NYhd3M/jyOfAAPyN0ySc/SjSlqkDRzJJqQotkVKwoOIIHx0/T3iqCbxV5q3F8+/oWf77Kfw0oTcU1kWIeOPyNNbDQjV5raXM=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fb12-20020a05600c520c00b0040ef9ffd3c1sm41713wmb.19.2024.02.05.15.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 15:17:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7CE45F888;
 Mon,  5 Feb 2024 23:17:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Czenczek <hreitz@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
In-Reply-To: <20240205171819.474283-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Mon, 5 Feb 2024 12:18:19 -0500")
References: <20240205171819.474283-1-stefanha@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 05 Feb 2024 23:17:27 +0000
Message-ID: <87fry6mrg8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> C99 mixed declarations support interleaving of local variable
> declarations and code.
>
> The coding style "generally" forbids C99 mixed declarations with some
> exceptions to the rule. This rule is not checked by checkpatch.pl and
> naturally there are violations in the source tree.
>
> While contemplating adding another exception, I came to the conclusion
> that the best location for declarations depends on context. Let the
> programmer declare variables where it is best for legibility. Don't try
> to define all possible scenarios/exceptions.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/style.rst | 20 --------------------
>  1 file changed, 20 deletions(-)

While I may be convinced there may be some cases where mixed
declarations could make things simpler/clearer I don't support removing
all the guidance and leaving it as a free for all as long as the
compiler is happy.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

