Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A24606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d1hWlfSi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP9eP-0003ns-6x; Thu, 05 Nov 2026 21:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1xP9eF-0003lt-N0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:25:49 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1xP9eB-0004xQ-HP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:25:44 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-945ae2daa3eso22811885a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 18:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793931937; cv=none;
 d=google.com; s=arc-20260327;
 b=IQ71/gtqBjwGbzCwwsEdJT8Hiuubi4vVyAxVZu4xhckDtt5gcQG6hpYtLSqqqSvXhG
 rPek7//ce7LuXA5+Ofjl8/XQ07o7NiGs/tE0C1dv8Ug9c0JIqQ22CMdu6EZrNGTURQzf
 Rlx1VtYJ2IsWPbUnnYQZ5abxHpi/nK/Rbmihzl0+ABl8KHQylMs8Bl1DoQU/Em5TYpFO
 afygEQ4ceppofZjaAPppatipC/Ztzwxcr+v6dYX6KI5aoqANJGfQ7vkdgw2IChWlzFZr
 sB/DQ9NtP/aG7RbLZ//BQCnRGnyzy36L7RVLjym5omhXRJAmg+LLkUM0AQTYZUeieuS4
 LoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pgG1/WFURbop1Inpu5WXlNwvEEqh4m1m8ew99capOjc=;
 fh=H6kgUSE5ymZ+ymaEjrJOkevr5RAZxAKcxOrkoSwLBi4=;
 b=qDnVObQLLI2nnkHr941gYhZ1O9sBWNYaYTWsrmxjgNonHF0i7hB4MWNe9mOwkOT9IU
 O+IrUsL2olDOT53qM1gkHt3aNBh7uhFhn0odsE0z2gScFm344OLCsDJ4EXsql+v1PtxO
 P+jPMdipGppUpHUuC6zKjqwTwT5jVx3O8I5GN4wr0FBB4xnMnHJK+p45J138ii9vRnBF
 gRRal19uj+SwjTyqJyjaYW+EJnpfmSvpziG2lQsdVq8ZtX6rzuuDhjXfeMxJ5rM/CsZu
 RaG00o0YuvbyJ0cKZl1+uLoPn4aqQ/MCpZtcYmGYK2PzSnXpxf1VGZewc6XSpmatI0RB
 2pWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793931937; x=1794536737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pgG1/WFURbop1Inpu5WXlNwvEEqh4m1m8ew99capOjc=;
 b=d1hWlfSidRLJ6MKCXPbu8BhPXDG3N/ufjWYiQ7yseNpYlqn8R4mOvk9WoZr3wEEsSv
 ujEkpIRmwFGccpNQrFFQ9jz3xVkKINoqIGE9PDEZNV/yENAmIkdp86FsnWHGJH/+eTRf
 7aAnotdWGCpjboB0gQv2EcK7VaZBugvp4hxqRtwUU66V9PK/1VB0FiiQY7MWMdyVXUVk
 GhUxXRdLzJD6Ge6VxCqv2sdytMs36YVTBjTzTM7x4yE3Dw4w6YgGKiawsMjSPMEOHaoo
 Y1CfprQsPtb7WvvRSITZ7DnZQ68qTmXsKRwqnkixIdS40Ceuvh/1OAothDco9xN8IVMn
 W5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793931937; x=1794536737;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgG1/WFURbop1Inpu5WXlNwvEEqh4m1m8ew99capOjc=;
 b=uw/lo5wHoYo/9W+Ctn/0yKkqhviZCnDQEnO+G1JU+CgmGqqwsawbq17u+VQXWmoqp7
 lG1a1kCyNn2K3dvBuqlzCHly5+MLGqFjvaydtsdiLlrxXuhEoWEi5KCrPTQZHZpjgVb1
 LiSUI+/h7SKu7J6hlm2t5wCov4xQ8xdPrnx/hzvD5sUIEpC6jlRNkrGXTcZz3se6/zCT
 9jzPEsyT8YGxPWxPeYVBResXJqE1UESaAlgqlFX1/q0MiIal50ZzN0sodNZMvqohnjQI
 husPjeBOu1MJ3lBg0GBtiOSYrTyFa4SHTnHG5mUVMukF+3Kv3PzM7rwvqciCZwSqlC+U
 qbYQ==
X-Gm-Message-State: APuU4Z9nuTSqzvxjhezgt8AmgrktMYgkktUV868AraW+6jFbHEDi5lbh
 TSjHvl/0Q51NOOQO9ynlLXS9pdohChF0Yu03IWu6Yb8tEM1Kt4H7LIt60HDG21+nvDxjyg8SPov
 XRF82tKESLDiQGE3xv3JFZAQVbpOMgXk=
X-Gm-Gg: AYBFou3QQiSHzD5BYcpTg18Zdl2WHq1K3XV8D+itoI5L7K6rbH1hbd7W6ClkPmsPBDB
 N3SKoCvBSeaFeXcI6kpyrUKk8dKvc/GtdYS87XNGSTzd5E6pfzgTQSXlPz9nNA30LAacxHWrWz+
 Cm85NKnUGCuumg8P/pio3K0Po8JxDNPgI+3BfsG7jXMrQOUOQykJ6DfQ5FE8xwvXL3RiO8lynCD
 /EChxG5hOtSORup/CHDWAm9bZDeKN8Td4lbjN2jgclJ2Mh78YyrQP49c8e2ugfVY0+PMS2J0VBI
 iIW7BPpqU04fj90/5RUrk2y+04yftnSFK8wpEYzt91Mtlf3ecfiAHxWCro2feFUgOR4xFpEep/j
 WL4S9yJWDpzc77lSuXPs0ZKAhreup2nMs0lJex9x9BcMXO5iACh5t76ZEWk9/gMK22mmlqEoHpf
 ZHWPYOjzO1MTi+UECfL0CSRH8TOQcyD2qIcSTVG3fJYdRo2cYl6dg35B8=
X-Received: by 2002:a05:620a:84c9:b0:93e:c12c:f142 with SMTP id
 af79cd13be357-945f356285fmr159770085a.76.1793931937256; Thu, 05 Nov 2026
 18:25:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-14-philmd@oss.qualcomm.com>
In-Reply-To: <20261105125203.40320-14-philmd@oss.qualcomm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 5 Nov 2026 18:25:26 -0800
X-Gm-Features: AclHuK_IrN3GhLnbigIJYmu1h8-wxESrCor66rb-AwgS7YcweErE8fkX0fydS1I
Message-ID: <CAMo8BfLMaWO=7t9uL_eS=L-KvUpOtj3S7J_htZ8jYVKps-bjPQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] target/xtensa: Replace deprecated sprintf() with
 snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.993, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Replace sprintf() by safer snprintf() to format ISA error
> message, silencing -Wdeprecated-declarations produced by
> Apple clang 17.0.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/xtensa/xtensa-isa.c | 50 +++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 19 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

