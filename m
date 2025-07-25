Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4000C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEr3-0001E9-Bg; Fri, 25 Jul 2025 05:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufEqv-0001AA-FV
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:36:37 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufEqt-0004e6-Ok
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:36:33 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-712be7e034cso20050117b3.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436189; x=1754040989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4uEUzrIk6LOMJMKBqZfajhIJWzEv6qlLKpv6Dm5+tM=;
 b=zb+848ZsEkicpeLPUETrZYC2vDJm/j80YhYTAIyAfULTiP8OLP/DMZ7uAtZz7mlnEU
 l1jQgGmhg0PrLIXuJsm7N16xUGctVw554Ek9yM0eRzF9ja/aQdUuN1V/Oeat9ul8DRPI
 5/RZxmuI4QSIjbeLLjH2PoAbN5Mxh9yalNV4RHrHEshpJwVCewsI350uMJNodnwE4Iq/
 BP43rc0oK4BNZwAOGOkp53u+cnScObxnvEmNKKuM3+TQUiO09uwW7/gcgArwRtTO4jWW
 Vmnxu1YoIs0lT0AxwQoJ60zExXl++KGTaArCNZ0vGsWcWc6rm0Sh3WjgwuEEBv7VngIZ
 W+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436189; x=1754040989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4uEUzrIk6LOMJMKBqZfajhIJWzEv6qlLKpv6Dm5+tM=;
 b=hZ3caselh36MzjC9vVYDSs7H8hzFAWt53VBXfIaQogbX4kHXsktR7tz+fDRZY+lVY6
 TGW+M36arTKddiULW3gj/+c8ae3FswbMakOHQ2vAJjP0p1hEmBWNn7YJ995t85Asq2Gs
 GvcCQvmvPfdbeVJSbTxDREJCg6tWz6IdvVsq/eUnqa4+uXTOrtmDMSU+6FRW0b1NSVx4
 qtzJ4nI1yE2DFN3jXsCQeLe1a1BwclEOPcVYOkyUxNS2lsOeFNtno+SDEMsz9Xc4yBXE
 wu/8xfffBn8Sye9zHcs3QjuZWjDpboPW4Cg6FGmJq9MgmEz5galmHYaPn8K+sgTVmglS
 1EfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1p4e6OrrfPZ23ghiGjBkea+Vo/DfG3FcAGUQa1xwxVDkIU3TDYk+Ux4kp49zXalMhLiuCI1jKgb/S@nongnu.org
X-Gm-Message-State: AOJu0YwfumW1fQplwsRKAPAx00DScgrreLRfpz5bUvUHkfVIsSulpITC
 fbGSU51zK42hWbkYjCI30rmVVOEaBRFCUBXL23mHYDEBIkPo7MC13+HICmKUlzu6LyjAgLtnuji
 DYJHhlTtlj3cwzD1srSj4zsCsTtMZ2k6a1xa/MxsUsQ==
X-Gm-Gg: ASbGncsc161MQiAqTFW+HZNoj+q/S+8C6L5ti+uPP6RGER2Oq2YvhYvTqMV6TR20wCy
 zkmiGWI0BjY0nvtjqIf+yCvHzJrbuVTthcPs3bnpBArp8CgHHspKTI/jwDDjTLxrYtojzyUfv/j
 mdsqH64F4icJLdzKSgu0xI5YWOpJtYcZtDOvy9uM/LZcGh4hErMjxqpscejbjQwvB5qf/T8c4DJ
 Dq2bIMM
X-Google-Smtp-Source: AGHT+IEKNEtdpyUTS90Jq/yPJWm8KGrcqMzLUwpGJhRCuhqda6GI4mZz3dYUI+EB3yg3p9i4IUxkQ2YiIJosg4nC1ZA=
X-Received: by 2002:a05:690c:311:b0:70e:2ba2:659d with SMTP id
 00721157ae682-719e341e852mr13522127b3.23.1753436188888; Fri, 25 Jul 2025
 02:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250214072029.515379-1-jansef.jian@hj-micro.com>
 <bf6df47b-8815-4d84-a01b-010281187d24@linaro.org>
 <CAOGAQepyzkZS-kK-rH=rv_pNRCwLBG1UJJ4q4oWztJfCnA=YXw@mail.gmail.com>
In-Reply-To: <CAOGAQepyzkZS-kK-rH=rv_pNRCwLBG1UJJ4q4oWztJfCnA=YXw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jul 2025 10:36:17 +0100
X-Gm-Features: Ac12FXwrklE9lp7DkWkk_OlZa51gT1l4oMz6XZWWvXtZ29qLWznjH0U5PwtFGZY
Message-ID: <CAFEAcA8pmNjrWtWOTF=ekomKNU1SNT963=JtL1OYEbvj+D=2yw@mail.gmail.com>
Subject: Re: [PATCH-for-10.1] hw/arm/smmu-common: Avoid using inlined
 functions with external linkage
To: Roman Kiryanov <rkir@google.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 JianChunfu <jansef.jian@hj-micro.com>, eric.auger@redhat.com,
 qemu-devel@nongnu.org, 
 Will Hollins <whollins@google.com>, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 24 Jul 2025 at 17:54, Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Philippe, thank you for looking into this.
>
> On Thu, Jul 17, 2025 at 11:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > (sorry for previously missing this patch)
> >
> > (cc'ing Google folks for
> > https://lore.kernel.org/qemu-devel/20250717205735.2345674-1-rkir@google=
.com/)
>
> Will this patch be included into 10.1?

Yes, I'll pick it up for target-arm.next; thanks.

-- PMM

