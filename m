Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D439AF3C9A0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuubg-00026U-Aw; Tue, 24 Feb 2026 10:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuube-000267-Pb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:45:50 -0500
Received: from mail-yw1-f178.google.com ([209.85.128.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuubc-0006dC-Mo
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:45:50 -0500
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-797d36fdb96so86854437b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947947; x=1772552747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJX4i915jlOLd1OJFSK1z59VQIyGA6uWO4ySvc4Q4G4=;
 b=B54TP6RqomK9BjZh7080rnxZ898AJCq7BHTXU9IxAtLCXQTFAW7jioCZJ6hHc9fopI
 hSLuh3Hz/+P2k0znkFvL2xCB8ptXVsQzC47d3S2YGalYOwYe7FsvJwjh2bUSmRQBJJse
 SqrsiSd1gIRm7pAyggmDzrkdXDLlGY/ksBwN9PcpJzLL4+JnXaQK2fi3n+rNGQq4SWVy
 Njj8F62LWpDH+Y+IfL7sNp42TcGTGYgJ1TeIzOx+peuDsM9L8o4vGLkMDAr2/C7IqvBI
 82wgQw8iEw8p9RgBneXNudwVuN/EdUyeDev7HbFOhI7YCDNMWgli4eL5/wEYE9ZkXGQu
 Dw3g==
X-Gm-Message-State: AOJu0YwZ14H1xFsaREcSmnwvpA9IaJTtn9SU9uoYa4y6o9g3B5qSJ/5S
 JrVgIuGDiT8YlTZH38V6A9wAmUrywQw95FKtV0Slza4HG4TXmPPq5YlBGFd1B3U+0Yk=
X-Gm-Gg: ATEYQzz9kDFAOyZOaGMYWs2QQyt8fgHyFBXwMItpadjWe9gHrem3UXHhiiMZ0Ej7Jbs
 iMCLKFKilCfaUGV3wuBBYubDBQmK8y6skJu6BdL+vhkbkE7bmNG+tOOJDqVrSlWtzC6fxo52uwY
 PVmy8U8EkcnEh1xKQffz1nyIlCHkHfkCUrcq6AS3rvTvQbjnXtixtRyh5U0swzGAxU788a+xw9p
 ylFXGub4hpSNqHV+PyM/ptptbe4/3CoVWIg81Xl9FJn4KIORtiMTBDMDJktaLbV+ZRq+bMe/55C
 qT9MhwT7OItJGYMbjj08k4d+1TEdVSOMQ4giQdSC7Nds63trtfQVVJ8yRpCLCAlSaMCwSqr1NEY
 BDSxs+Y2xge4WVYcFV9DzjsSh6plwWJceNOXoHfNx+0yNcpgVOjHKaU90kI3+4gkoFr/7X444A8
 8RASu1kgXyYKd174qYsWaO1om3X+WtVDP2KGDCm9pwkN3svI/he0eHtS9blt4C7twrqDShSrKFw
 C7M57UVv8P+s1R2CI8j89Am6xsf5spjc00XdULHux97ZRd9K74ARzu0/Cjb5/aNavLEOwZFrUNL
 rU4Jqb8=
X-Received: by 2002:a53:c087:0:b0:64a:d7e6:a1e4 with SMTP id
 956f58d0204a3-64ca61c9120mr266269d50.38.1771947947335; 
 Tue, 24 Feb 2026 07:45:47 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com.
 [209.85.128.181]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-64c7a27069asm4563219d50.8.2026.02.24.07.45.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 07:45:47 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-79800183233so71312617b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:45:47 -0800 (PST)
X-Received: by 2002:a05:690c:306:b0:794:bc47:df1 with SMTP id
 00721157ae682-79865048551mr3181327b3.22.1771947946967; Tue, 24 Feb 2026
 07:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-22-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-22-8ee5ae17056f@bsdimp.com>
From: Gleb Popov <arrowd@freebsd.org>
Date: Tue, 24 Feb 2026 18:45:20 +0300
X-Gmail-Original-Message-ID: <CALH631kA4Ww_9TP=1wH5Xvr9766kakngc3tKM48vAhVHA4i9vw@mail.gmail.com>
X-Gm-Features: AaiRm50s1M_jF4Ukm0L6DxtFdtPNNhnAj3kyd1iodq6j-ZJer73ubpeIcOE_Ym8
Message-ID: <CALH631kA4Ww_9TP=1wH5Xvr9766kakngc3tKM48vAhVHA4i9vw@mail.gmail.com>
Subject: Re: [PATCH v4 22/24] bsd-user: Implement System V semaphore calls
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.178; envelope-from=6yearold@gmail.com;
 helo=mail-yw1-f178.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 5:42=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
>
> From: Stacey Son <sson@FreeBSD.org>
>
> Wire up semget(2) and semop(2) syscalls to get System V semaphore
> implementation, as well the undocumented __semctl used to implement the
> bits of the interface in libc.

semctl(2) seems to be documented since FreeBSD 2.2

