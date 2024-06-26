Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E04C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 21:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMaOh-0006IU-7D; Wed, 26 Jun 2024 17:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMaOe-0006IB-5g
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:41:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMaOc-0007yW-F0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:41:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fa3086cf25so17785ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719438101; x=1720042901; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVKzMtxOca7/8HftdvQ/Z4Czo5Qf/IXfcZnHSh3IGak=;
 b=HLyJ4Omx28lSBQhMTDpiyAIKAQdteCERLLZGUZcg3u4P7XMkdmi9To0ker9gBwpzBh
 EEtyLfajWBgn/iJqZBV8CJLJbHCm7Uzeu3AoL9lXuq1kncJMdejcMlaez/kGTLfhAPis
 25znnCUIWIN5fX445LHUIH76NBDQX1bk6R9ODNeqtV+L0PnW0YKALCZLDEClgzaX4xHj
 3BzkK+sUMn/KqGdc3LZO/n5p8tV3GheDVDDDwPwOO0BDL9hTXz7hDjBB8bKAMpBoLz1j
 RdJjnj4LofZGuVBJB1hVqTunrUVop3iM2GB+pKzN1/08vkWOvToliKWSDrth9DUAFHfs
 8kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719438101; x=1720042901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVKzMtxOca7/8HftdvQ/Z4Czo5Qf/IXfcZnHSh3IGak=;
 b=X/LsjXAK48I2e+QbTfj4C+0pmzEyg7p4HzCtTrJzW0ozU/09Is2y0KOeBaYqcW9aYO
 utqsM6ZAE7WVIr3oK2Wq7GU0JzjdIALmxrwl/CmeXdXAguVOY4AszU2ACSyoJzHA9VT4
 AbvXpnF9xJouJjyzc1FYWaXOLrZBInPaXSn9rDXfu5OWjDhJFYLAosn9CJKQ7nxbyqAo
 42uW+q8gagZJkOjcPGDsY4Jf18MKf4FcM+I46y9ed7xKjPOmOk+bB5uGi3gd1B7ThtPd
 cH8hZLeumzrlV808fEaOrxAdp1s7gdo4TBK5AiwCzv0e3XxgwYlmH6bQ3CjTLL/P0t7+
 56/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpruBRhCX6nwS1DzsOORoFHNsiaD+J5g1rU3GdIkA3hApl0A9X8+TL0mf/hrezaN2Mcx1r1K6GM8Htcj9jqjgzUVg9gkE=
X-Gm-Message-State: AOJu0YyVOdb8A2BJzN7R1GOp2EWo9+3sceptGLfnAUwbw62NJkkXTa2w
 V+KfK63bEVkEHItV/iOhaJ12ry/szuR28PBv7SuftTWeWw06EshpgFL5dKYSCobSg8eph+WlEgp
 rqtzNXapW88poaM513e/MW+tEZh7crb1AKata
X-Google-Smtp-Source: AGHT+IE8m8ljWSQnFZ7Ygr5gfUOp+pdgS5ez8f8uiQ8Sp0HRCe5f0LT6FfCI0v6El+NXt5+21e9+1OOt24+PXsNfdmo=
X-Received: by 2002:a17:902:6a81:b0:1f9:e3f9:6dd3 with SMTP id
 d9443c01a7336-1faa9928becmr1206175ad.16.1719438100549; Wed, 26 Jun 2024
 14:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240620201654.598024-1-rkir@google.com>
 <09b7e7e1-30a6-49d0-a5f8-9cfc62884c55@linaro.org>
In-Reply-To: <09b7e7e1-30a6-49d0-a5f8-9cfc62884c55@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 26 Jun 2024 14:41:29 -0700
Message-ID: <CAOGAQep9ua4Vd8wigAb7SrdOjkc3kfvSEmjgcfh=asZRe=begA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: don't use void* in pointer arithmetic in headers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, jansene@google.com, 
 mett@google.com, jpcottin@google.com, alex.bennee@linaro.org, 
 berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=rkir@google.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jun 20, 2024 at 11:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Roman,
>
> On 20/6/24 22:16, Roman Kiryanov wrote:
> > Google-Bug-Id: 331190993
>
> Again [*] I'm trying to figure what this tag is, no hit on
> https://issuetracker.google.com/issues?q=3Did:331190993; is
> this useful to commit it in the mainstream repository? So
> far it is confusing me.
>
> [*]
> https://lore.kernel.org/qemu-devel/e865d8e3-e768-4b1f-86d3-aeabe8f1d511@l=
inaro.org/
>
> > Change-Id: I5a064853429f627c17a9213910811dea4ced6174
>
> Ditto, not useful.

I am sorry, Philippe, I missed your message. If you prefer us to remove
Google specific tags from our commits, we will remove them.

Regards,
Roman.

