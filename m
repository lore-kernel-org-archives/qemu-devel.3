Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA08CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Lm-0001C2-F4; Thu, 21 May 2026 07:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ1Lk-00016v-Me
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:14:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ1Lj-0003jp-4b
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:14:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so5131575e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779362038; x=1779966838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KvkQqJnov9V4Hva9UpYiD4H2AGlW0T13U2owH8wRcY=;
 b=eurW2ykGc6CW/Mz4StuRwhh8c6wFu7Yk4S1SNDX+zcA9sLhplSX7eXvLv4p7B3D0gX
 qpSP0RdYjfD9k8kBDmyKUsSJdhIvexs+2ic3a5GHFdsOtcfRsOsvqr0nHfTpkDKDRVSD
 lfbKrQXdKV8VkSW7GBTiXfftyIMmgNcLzUeZcS5C06ErGjEMxkAJ/jd/t+qKshgXh4kl
 cKyifqZX+rSYQXhafp0fR4QJy6kL8Z+7SreQ3RY30zHyILZSqv/XbAaTshow/NbGpOvC
 K/xZnHBYARbmzQHDO4bXFDpP9GdWf890idaJMUQtI2rzVmw31jyV3X34o+rgJe7AR7Wp
 lo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362038; x=1779966838;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+KvkQqJnov9V4Hva9UpYiD4H2AGlW0T13U2owH8wRcY=;
 b=hK2XFR/kIrMXZCwxhABJ4YW0JU1/F54f1Lc5R2sl2B2OUKw9k3xR+VU06sQLXGF/LF
 1lEIv0nRHe9+00PDpLQPDt1P7JyWjV8NmaQZ4RYxhApEKziOHoz8b5unG3PqtgbXSosG
 Uprq5dCrY0CIRZYjWyIOCc5uDdkxb+zaq2h7mj+eb3sfXtec+ozgpQlkpA2WiFaVJ8J1
 lc5AlzWmjTt35JGpgysob1sdY7P3kmoVJlI9sztvyaK5pKEO1x9l3yy9hKu7H58Z8NS0
 wn5HfN/r2ofvq0mtaiEWd6RaRpsrHxr3CptHDh+k5pjDgEF6urZlRLy35aN/u8xt2msp
 rBJw==
X-Gm-Message-State: AOJu0YxIXYgKO3glxqqzKbEB2z9X24tZ6K1JBMbyuaBE8uo0719NHv+Z
 tHTA8r6koJldTb7uOIWa8XndBvUiTzVluGuSasPfXPop76PPKcBdRjd81TvErdqjDvk=
X-Gm-Gg: Acq92OGefgEJRlbSmnZpSUqIU0BP25oxc9cCg8afmlSfaKSPKWXOStOdUhVXa153gmt
 gOaSyYlZOWpwKHVf3v+pkM48WCFwX/1HXSSXRL7DINFpeOt057iXAS1HgU69OtJJqqpmphbyzV2
 91CjlsMnSglOujkLuijfxKaPhc7Up4dM9LEiFNVix13Jv7qFiXbXFw3QhgpcsknQayltqka5D5x
 xVWqhgiqERSw3VUBZEFnlcR9PWbNJxeTZgnafPItB/TNwGvty8olyJC8iYiGBm5IDtLBODITjEu
 KrmFgAqEeENJLwA76hPpLoQ0G7GAF01S4FxCojVllej1c68fqeYarZhKzxMT3qu5Wt4Q8RUEK8P
 TjQ9RWJXf18P1+dqlXVT5vcvSXXOP91VIbq9d3R4x3RtMv6va0K9evcLhVMNtHOa1arhP1aDzNK
 vj4Wl7wbNZvgig8f+tWytzvn0=
X-Received: by 2002:a05:600c:8508:b0:490:32dc:61fa with SMTP id
 5b1f17b1804b1-490360cc732mr37344925e9.31.1779362037606; 
 Thu, 21 May 2026 04:13:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c99cb43sm19126975e9.4.2026.05.21.04.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:13:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 421155F886;
 Thu, 21 May 2026 12:13:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 02/39] MAINTAINERS: Delete trailing colons in section
 headlines
In-Reply-To: <20260521080511.999266-3-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 21 May 2026 10:04:34 +0200")
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-3-armbru@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 12:13:56 +0100
Message-ID: <874ik1ow0b.fsf@draig.linaro.org>
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

Markus Armbruster <armbru@redhat.com> writes:

> These are harmless as far as I can tell, so this is just for
> consistency.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

