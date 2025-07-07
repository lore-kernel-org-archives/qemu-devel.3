Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55B1C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 10:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYj5B-0006ay-6T; Mon, 07 Jul 2025 06:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYj1L-0003fF-5q
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:24:24 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYj1D-0006eS-PE
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:24:22 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-712be7e034cso23468347b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751883852; x=1752488652; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFzNIV+b2EnV9yxz86OOZS8bWRHA9/t9f+sPv3D8NEo=;
 b=OsnWt5RRRp8QkfFOb/XSN42R/alfC220FWOcOCpOVtvdrRJexbPUfl4f1II8VVoypv
 O4bQO/znkxUwfNhLcwMR+itxPSEaFwDDCEO1ymuwYBfR1phok89a52awtnJEiz2vmdPQ
 Qa+VfSkURCKvLGv/Uo/w/x/RgAw8Y6GpTtmnN1XNiX3mH69febFcTAO79EXTxufrJs2l
 fYIjD+ltdBTareJdfldjIOUy4Hnj9ykX9MqfQwC1OcQU+NIA2QplIxV4xoEkbsnc+7n5
 103nucoy4gYZxb42IQGA9Qxr40FdYJ3Kmz8Tf2bemQw2ooQjGxIyeZ87xLYYNS3Tkc54
 ARjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751883852; x=1752488652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFzNIV+b2EnV9yxz86OOZS8bWRHA9/t9f+sPv3D8NEo=;
 b=UlE4Gf4jl0DyBRZdtq6KK1t4/LfSuaJrk6T+ULshymRVmwaZFohjkNWFVRYLoY3Y8N
 lBjzyuOWdNg60Em+GUfS6nYttR9XqGr6qNRJ5T4CA0+JA60crYtiRHwID+/2MazzPXIW
 gespo6NiAXWa+7aGSh7cmi6HPibyearFwEeh8XRjHqlSgslf9Zf1wq9kFWKQxMdD4kQI
 blvxJ3riK1wwVYutiDQYZmljvJ8wCTCKxLuCDt80nq0vRj6W5FPkZqEUEBzI+HRpCG2F
 53cYFspQIwwrNznWzrZ6tC4uFHVzXKClaD3wZUAoFzZ86pZx23wC1W5BAmm1KLj9zB5t
 GApg==
X-Gm-Message-State: AOJu0Yzm0kMu5mbFIqH+/sXNLJbyLJROEJ/47x813FogLYQJ+Pu5N0rQ
 D4PXKGlBTgfN9Z2RWesJZdJA0Ppe19SPpVl65bvou3Iadg5L7mH/nnkyS3sNUJ8lU5vMYydUzoQ
 UhCJhpsvNfMl4pUO6zyfGrEBH75sZPxID2sdlkEhWUQ==
X-Gm-Gg: ASbGnctAIWV/ENqQwYsCdvnrX1CqlgaTFPjKScxR/sWurM+yqyS39StCjqVK7fCKjvs
 37BuskeoMx+03klpuFP/UBmGkaXiWpA87QRKx1vzXdGZz22weVee9EqecC/E+aKnH6n1dScKf7z
 YCzf/wyV75eVBY2+tRwMyKk3pWw/sJpD4Ps9T8Ae8EdrDU
X-Google-Smtp-Source: AGHT+IHBGjmEb1pzaL0IsEnkNZ2egT7XPO9t65q57BXRIFDxR2J/nL5CxNQfmJ+10h6u+ZlMqWiFRcHR2JZ0msi2Qpw=
X-Received: by 2002:a05:690c:9986:b0:70e:326:6ae8 with SMTP id
 00721157ae682-71668d02d18mr171936747b3.2.1751883851887; Mon, 07 Jul 2025
 03:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250707101412.2055581-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250707101412.2055581-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 11:23:59 +0100
X-Gm-Features: Ac12FXzwwOb0B84sJEqVnIuFKIwoxL5Wz1roAp-dsyqteC1rqEMv6NldpwRcLQ4
Message-ID: <CAFEAcA9-8aBg87X7cjRgWicqr5BOjjYX3dbGmO5udA-f-TzGxA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: "qemu -tpmdev help" should return success
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, yanqzhan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 7 Jul 2025 at 11:14, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Like other "-foo help" CLI, the qemu process should return 0 for
> "-tpmdev help".
>
> While touching this, switch to is_help_option() utility function as
> suggested by Peter Maydell.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

