Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44444C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 21:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMaGL-0004nZ-Mi; Wed, 26 Jun 2024 17:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMaGK-0004nF-2H
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMaGH-0006HP-RL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719437584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4deKOcLvJA49Ab6v1E/DoQ6HZfgThMX4TEs3I/eZHc=;
 b=DjIbUG3QpCvfW5maowj23tsj/mM2bB6PoS6adgyvQyHqNHRYKwg5GVP8qoxoziR57UbKxP
 nI1GRUfL4ozqJhPj5ZDmkX5LpCEcKdToV862f4JuhQjKupSDAjOU+54N9tV+G1wMXyMJvy
 UX/1h0upG6ynuBopuhpOGrXuyoep/os=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-wYL5PTC1MaSZpR7_tUcTOQ-1; Wed, 26 Jun 2024 17:33:03 -0400
X-MC-Unique: wYL5PTC1MaSZpR7_tUcTOQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-362763f8d2eso3641822f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 14:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719437562; x=1720042362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4deKOcLvJA49Ab6v1E/DoQ6HZfgThMX4TEs3I/eZHc=;
 b=fkTr/Llvfgl7OH0ut0krnZAN/IEjaxmr6g8m9Fiwfn+xBC4C4FeNurZ2n/npcXnR4E
 7iyXbm6pHmZ1C9w+ib5ZBrC0qW3lUp1qneQubJCe4dSDD1sfMvttoe37Y8aZ23xfecCX
 Z54iHwowLNBoCgC3uaRM56NPp96Bg8EkFTyxKihMh0TV0oa/FbtUH8rPuc0x3OMoIb4a
 6+Ex9P8FYqztCpI1HlVXI8/W5tRBzQzcJ8Dxd25wPKdZrYOejyyCb5T2GlZx6rOYcr0Z
 jX+MTz8QjZr5F2+DQu8ylqey4zLRbgHHDWh1QVue6dLPL4A1VzE9ewWy6KWnpIFWvfIM
 8xNg==
X-Gm-Message-State: AOJu0Ywu8qj+r7rb6C+tEqCHOfZA1owYyJvkzOwOYtLBMTpPQm+ijtOW
 B26wvbVHFaeGgGJlPp/jwWyyfg8OSAJl7dugoq7FsMCAFjwYf0nAb4QTkNhkGG6cn9Mb4pcXV2D
 JBxMMGQWVk0LrWPQqo75mF3cSCTckxJ6LR+gD1hAIwAFZ0JP0zAlZx8c5cU+4PZU5yHhhZqIfwK
 m44DRTCEP+OA89AHfzSb6Jq6aL2RQ=
X-Received: by 2002:adf:e6c6:0:b0:35f:2725:f6cd with SMTP id
 ffacd0b85a97d-366e4f0bf67mr8062948f8f.59.1719437562400; 
 Wed, 26 Jun 2024 14:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIlE7KwDmCBWbuGKyZnKwVh0U2IOh+UmQ7NJkqU6EjQqqEWPZtWUbEB4xg8vszk0iMPH70xKr9ORDrdX3qqBs=
X-Received: by 2002:adf:e6c6:0:b0:35f:2725:f6cd with SMTP id
 ffacd0b85a97d-366e4f0bf67mr8062937f8f.59.1719437562101; Wed, 26 Jun 2024
 14:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240625111848.709176-1-pbonzini@redhat.com>
 <fnhkw.xyx5xkm2lgb@linaro.org>
In-Reply-To: <fnhkw.xyx5xkm2lgb@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jun 2024 23:32:26 +0200
Message-ID: <CABgObfaK+CQTni9MQjTADY-Fode9Fg3hTqSfm+2K8R9DCRJ5cw@mail.gmail.com>
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, flwu@google.com, berrange@redhat.com, 
 peter.maydell@linaro.org, rkir@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 25, 2024 at 9:17=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> >Move the macro to compiler.h and, while at it, move it under #ifndef
> >__cplusplus to emphasize that it uses C-only constructs.  A C++ version
> >of typeof_strip_qual() using type traits is possible[1], but beyond the
> >scope of this patch because the little C++ code that is in QEMU does not
> >use QAPI.
>
> Should we add an #else to provide a fallback for cplusplus until the
> alternative is merged?

As the commit message says, I don't think we need to include the C++
code in QEMU since it would be essentially dead.

Paolo


