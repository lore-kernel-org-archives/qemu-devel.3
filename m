Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55835C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTz9-0005d6-LG; Tue, 17 Sep 2024 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1sqTz6-0005Np-Ew
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:54:57 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1sqTyp-0000LK-CL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:54:55 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-82cdada0f21so137585939f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563266; x=1727168066; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61XaBCJHY6YUIRxRweyMtM5JczlHuQWVPbVt/Ctmrjg=;
 b=DkOjkJA4zLbDO4KqXwY5saP0FvcwnazLr6q1ji3LdqN3yAnxbiZxFSYB27o/I37k4r
 5iAJUmZl5u4gXk/WCuhA5SucwS2mjM/pQhg2KpI0wIaBKPDe1wD941U2YVDC1Cq2EMye
 4V+s1WKnUmPE1cNtxelktOXXGzEduwSSusRkBPXhBDqqCrKfIv6jH8l9c1IQLNa8FiVE
 Eq1jmMwS5K6n1kwTtQTjuzuG9puN2yvpMt0+FkJ7ypfEEXe/VyS4vy0XVWgUid6OgJr2
 74/j2aAeW4/P5i657sJBU/AOsxA+dQSVgHER4wqVLctw8Q1zwbSOUP5dJ2e099zqL1wM
 jkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563266; x=1727168066;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61XaBCJHY6YUIRxRweyMtM5JczlHuQWVPbVt/Ctmrjg=;
 b=rxdx0BZ+gx9HbmSCeUXsJsQeycbojp6mVOqdL/hclSavoWko1oHMlsD/JAjKiPEHOd
 fWcOc0+5j0jA97ogRko9vGVrRQmudljc9KJBthchgyDNUZgmhMab40G3AChH9tWfLiXg
 Pu0cpPc50EDw3Go3V7oXnyHBqh2ydcALBfEqKO7S697dNUg9K8udmwwum21HhpNtH9Bp
 /fKJwIw/GevFCo4bB3Jqza3/yZn672EO1bswjrlRneCBX86oc+8jWyYHvsDCBbouIZXb
 8nOXAnrWsJZYTjnbrKakf9Gs2vNkUGLXNac44iNS8MdgPlxfyPfcIkkgy7fJYJj5HexU
 B7OQ==
X-Gm-Message-State: AOJu0Yxqfegu6Jq/0TGi4Y/UOq8CTXT8WZtDPoFUOpZoZzlRJ+NKQtKg
 8mjooCqgMFFC0xveeImIeg/jsOQuwK0MJ3YxFF4E+bFRmVKVFzN2K3HQJUW+ffAFSR24djIT7Jx
 xO3lC2jPdUcit0ibnv0DS4yjEtGFtJne2yMqklakJ4AYZvxvdrQc=
X-Google-Smtp-Source: AGHT+IG7+gz3rTQ2/s1RFwZhOPAYnuAyCupersfyB2spnDM7B1EhOnCv8EeROgtcQdpVvaYJ7y7Ek9a++tL12xkl6HA=
X-Received: by 2002:a05:6602:341c:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-82d376a7d37mr1413665739f.1.1726563266320; Tue, 17 Sep 2024
 01:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240917085058.1740-1-philmd@linaro.org>
 <20240917085058.1740-2-philmd@linaro.org>
In-Reply-To: <20240917085058.1740-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Tue, 17 Sep 2024 10:54:15 +0200
Message-ID: <CAPMQPEJegTwz0K_bZB=QKN8HwMJt_0mtpTMWmK=mpVHQRnJ1Hw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests/unit: Really build pbkdf test on macOS
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Oops, this patch wasn't meant for this series, already posted & reviewed:
https://lore.kernel.org/qemu-devel/20240917065736.27883-1-philmd@linaro.org=
/

On Tue, 17 Sept 2024 at 10:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> Fix a typo to run the pbkdf crypto cipher tests on macOS.
>
>  $ make check-unit
>    ...
>    87/102 qemu:unit / test-crypto-pbkdf      OK      2.35s   17 subtests =
passed
>
> Fixes: ebe0302ac8 ("tests/unit: build pbkdf test on macOS")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/unit/test-crypto-pbkdf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkd=
f.c
> index b477cf4e4b..12ee808fbc 100644
> --- a/tests/unit/test-crypto-pbkdf.c
> +++ b/tests/unit/test-crypto-pbkdf.c
> @@ -25,7 +25,7 @@
>  #include <sys/resource.h>
>  #endif
>
> -#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWNI)
> +#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWIN)
>  #include "crypto/pbkdf.h"
>
>  typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;
> --
> 2.45.2
>

