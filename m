Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336ADC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxaO-0003i6-Ul; Mon, 05 Aug 2024 09:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1saxaM-0003bI-WD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:17:15 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1saxaL-0002MB-3b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:17:14 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f1870c355cso4723661fa.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722863831; x=1723468631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VEAorHw3iySICsknNuJ2mKl2TzQoX2wxyxH/XPe4xZ0=;
 b=N+vGvLSnYvknaL2kFUBZRcMfsQr7Vdmqgnf66ldatO8DRsOj67mW7HYvT9YjFm8Vvp
 yc74zsnbOMD3GMJZ84MndqlxYPXGQj1Benni5N4zHHpZ4GP0vaodCgMQjjsZt+ppbQ4K
 +BPjj9opvYJMTZDrdjuK3bOQjzJCrI+lYP1UVG1H49NGOqZNNBdGRhH046Md3nTTV0om
 baTWJ66Q72RxhSoTRkwMrZrCL/s1xBKpK/eYzCU4eY+EsPWKIpEWWa4S5W7ecp+XYTnx
 lxmgVy2ilE4f7rW1fxdrwf59tYFT/nzieCb51/R9nHks5IkvipdXqF8rrtVJG8v9xYuv
 0JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722863831; x=1723468631;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEAorHw3iySICsknNuJ2mKl2TzQoX2wxyxH/XPe4xZ0=;
 b=YTo8qjXfIDWcIbppD225WApmQYplJHWWb3RjcCzLzqO1skYQvnMqrKxrloE8SBJWVz
 e8RBnCP65tq62Nar0kA1sJLbqx4chM3+VU6tmcbeq5FtNrnI2Z4tR0cfZDykoybqBWTi
 dKh5c3LD8lG2P74ZugeR9+hVwOEyYiiEh/w+PtgKLhQPws41ltiXFNuTA8IyYSiQbhE+
 ylgYqJI/d8EBxlwBwFQi8dLkJPf6jXGwVjHCKMaHNL+yTMyB3/Qk0jD41XrYKNB5XJcr
 mE9ku3ZBLkiPrfl4NfC09Er9puWp9DAR7p3tRLE5lno9vtnYBEhV13wDDanL0c00eoTU
 7R9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXffx5/pPOG4GJ1gPbqaWksGnVgiim5Z+uT+mmfID+M4+wuENXd07nT48EZ4oDEnlSPzcQ9it6Q61c+W81MGI0sk3hdnW4=
X-Gm-Message-State: AOJu0YyRTqwgok23dnpyVPjUYFoTj+d4aEqX4dj6g4uY97hOnAnAWhTb
 Hqyofn5SJTkxQSDfFhSVyu0HNhf4Wmh4CnV9buBSdmuocWAxWi+VDxxGUfVscQH65wa396WEGXE
 B
X-Google-Smtp-Source: AGHT+IHmWrZ8fUlQIQbY1P9HQwzWebpMjewEutgdVLGDe2q07oU2Rb4eYIy3kg/yPmQO1W/gW7QehA==
X-Received: by 2002:a2e:96d9:0:b0:2ee:974c:596f with SMTP id
 38308e7fff4ca-2f15aac18f0mr79588101fa.28.1722863830051; 
 Mon, 05 Aug 2024 06:17:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282babaab3sm198293425e9.28.2024.08.05.06.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 06:17:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FC365F882;
 Mon,  5 Aug 2024 14:17:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Brian Cain <bcain@quicinc.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] target/hexagon: don't look for static glib
In-Reply-To: <20240805104921.4035256-1-hi@alyssa.is> (Alyssa Ross's message of
 "Mon, 5 Aug 2024 12:49:21 +0200")
References: <20240805104921.4035256-1-hi@alyssa.is>
Date: Mon, 05 Aug 2024 14:17:08 +0100
Message-ID: <87zfprqfcb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
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

Alyssa Ross <hi@alyssa.is> writes:

> When cross compiling QEMU configured with --static, I've been getting
> configure errors like the following:
>
>     Build-time dependency glib-2.0 found: NO
>
>     ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup for gl=
ib-2.0 with method 'pkgconfig' failed: Could not generate libs for glib-2.0:
>     Package libpcre2-8 was not found in the pkg-config search path.
>     Perhaps you should add the directory containing `libpcre2-8.pc'
>     to the PKG_CONFIG_PATH environment variable
>     Package 'libpcre2-8', required by 'glib-2.0', not found
>
> This happens because --static sets the prefer_static Meson option, but
> my build machine doesn't have a static libpcre2.  I don't think it
> makes sense to insist that native dependencies are static, just
> because I want the non-native QEMU binaries to be static.

Makes sense:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

