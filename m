Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5951AC5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wunoJ-0003eF-Sx; Fri, 14 Aug 2026 05:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuno0-0003bm-VP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:02:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wunnz-00068m-74
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:02:24 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a37a2b7000so882629a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 02:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786698141; cv=none;
 d=google.com; s=arc-20260327;
 b=lcmsWdF2/bz9C0O+ZnJrwIJQ3vsvm3SurXLAxZmg4lKoEcAEd+bBzwTcUH3BUhD1fP
 GKXK+f8T9Z9ON38ubFIbxiYA70TfqrMCAP4Fip41JbCQ4PVZo+I1qRw1L7H+IHzRpX7W
 ZHXwVZCHWSfmOp8x537tGQzBGuZ0tZ6NyuMaJ0imjINGxOKOHMbtasjRYaIg+QXVZpMs
 X1T8dUj0x3V1Id5p+2iEHnpPg8rDHmqMn0kSHKLs8Eun9K1VYwJVHZKGm8xYjKYCGr7X
 989A0/18OfKdUoqkiIKs01+7TwGOU3eYF2oFaZUa5MyTglA/BjGyiJSfZOBJDoddW5vi
 Gjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TWQh/1AslFFhipqJhLsfLJ8VgD256ddNYmk6L4ikyBQ=;
 fh=RNR0fx3lVXtwzBb+Z+kUg6SLYrgtIDSvnMyWvrMTeRk=;
 b=YU+ipL6gn6IJHhnJS/Yp9tjqPXvLDoKaQJEZ4T/W89bMikkWcESlv1lMuMWlxVxBQT
 DhvL7hpK5YlfF5wYQkt+rMyJOT3PbFIemRsl6jxEO2QAoqxE23JgTLGAATd1gOhNrBNY
 l/KLmxvjLHKF3APqQNc/mQNGkoq8pV5AxHgjTQJVd0afwUmur1LmVuvfCAHLsfIMf0fV
 ee69Imc4KTAz4DyQ2QMb9jaCmfkasDMIdxQq/bmfrVnAJGi0K/77bsUdt0KEtDQI/N5w
 xM3+X/DWSb4/WrYCtb801oE8ELN7DqkjU2XEKkluNVJOfhS5NqQBpqWdoGv7B7c+GxYJ
 lBCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786698141; x=1787302941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TWQh/1AslFFhipqJhLsfLJ8VgD256ddNYmk6L4ikyBQ=;
 b=R+HjrQd+Jj+kqAFh0GV0RDPDdYQTyjb9OwAK9+pJvfplrqtXHh5MfaXfIxSfuEYGP0
 7I4ZODzYfhzZ8ggGnRNX/vVJe5St4vp1HShcffanuTvK4/TTWzJXmVPUs0auIyezagfT
 sRlkKXWmMF6Uk9CCOapiCoz3HqqLRYu4+0qHRV55/XQsd43eqwagPjZGCO5dcUB9npfD
 qNPaTdA/EJghANKycuwlevVL0monrwYdt7Cg01Haq19I3MdHEMehqKrhOTQkarXUVDbs
 fQ7TUPz9gk+ua/ddj54u5dI7ipeFSL4F2Zr/1g2fX6sZV9ysFLQV1PShPJp33Q4qd/8g
 TtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786698141; x=1787302941;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TWQh/1AslFFhipqJhLsfLJ8VgD256ddNYmk6L4ikyBQ=;
 b=T/95XMgX7FDX4uTjxY25RImv/IBwO+1WcJ+fetrPd8dwCcnKt8/PFJ+JtHZmoEPz++
 6k2b5DmGgmPuNslz4VdkMfYMCuLir4++IitYh0BOhDu7janVpLMqx72bnhfOUE8Wz1Ul
 E2mk4LLyBIEKfiq3/8xaAR5yZK4LnFxLSglpMWyMluJTOVNHk/s3qylnJkkQFA7B30jE
 Lh/oYoS3i6Q82PJSPNPruyK/laXIqi9ROtMWVMeYv7QXh7cvQi+DgMFpuc7Fybj8t14M
 AwBt2F458oZxJaTWYE861IFF9m/bP5OkQAEffg1KAD/a6TnjLSfUHpC+5ZRS1WrgzcEm
 lgXA==
X-Gm-Message-State: AOJu0Yybzg0/7SeJFLGQhfWGG8o3hMJm2AdupXt1HIhAvE44YKqXRpiM
 /Pf0cTQdrG7Qi0LwtrmNTz+1xbBEVrU9yPvxPmv7tEDLsiZml4gBHshT14eg+B9ejHMV0gHxtzG
 aoEJeuaE84hT2Azgp/bqE5MBYhZepxr4=
X-Gm-Gg: AR+sD12bQYVBUrj4lIXBJY5OCmMMY2kj8NuID9OU0Ipu9PTypRAO0z6yNpGM6fW9DqF
 i0sPNg+RazAFTOOom8rEYKLEZybkJc/nmBShPVKkZMbpGG9mUWCNYH39ra6owPkPwIg2tJ6UKS8
 oSHvJJiMdDWy+20//mAWlmATY1p9Rm14eW7mCwycVcqYHdGZU1WAj4tK3pMrVWg1oE5r0R94rB4
 OUhvUPXUCafJssXTP2HUKea3//A2FNv+RnsnkSxHAZDnvFYREKv8SF0mgcT2dIGLRcK+PMzuPFM
 ExTdilSvGh0XTd46QvZ1e5wVoKSurxdlm/l7yOUpow01
X-Received: by 2002:a05:6402:390a:b0:6a1:da7a:917b with SMTP id
 4fb4d7f45d1cf-6a38a9972b6mr2045926a12.20.1786698140582; Fri, 14 Aug 2026
 02:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-7-zhangckid@gmail.com>
 <87mruyni2a.fsf@pond.sub.org>
In-Reply-To: <87mruyni2a.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 14 Aug 2026 17:01:43 +0800
X-Gm-Features: AUfX_mxjWBlpcFE8gvrOYnj21ycatfQuP-EjFENA6D_mEaK4iir46FEuw41MCcM
Message-ID: <CAK3tnv+YqCPf8Wb461KJuSKdGMLSEhPQrM6AnJQAukwUsU_ixA@mail.gmail.com>
Subject: Re: [PATCH V11 06/15] monitor: track IOThread users with QOM paths
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Aug 7, 2026 at 10:04=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Acquire the shared monitor IOThread AioContext once, using the monitor
> > QOM path as the holder, and reuse the stored context for later
> > operations.
>
> This describes what the patch does, but not why it is useful.
>
> > Release the holder during global cleanup and dynamic QMP monitor
> > deletion to provide an explicit acquire/release lifecycle.
>
> This at least provides a clue: "to provide ..."

OK, will add more comments here.

Thanks
Chen

>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>

