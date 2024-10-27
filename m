Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0616D10C08
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 08:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4yDE-00081m-Km; Sun, 27 Oct 2024 04:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4yDB-00081V-Ch
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 04:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4yD9-0004r6-Vv
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 04:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730016077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOG0Om3HwykUbgAN29OSBeKr0FDoL+NWdpVIxQs43ss=;
 b=hUXfhN+ezl557YB6UQjX3WLy+wG20hnKsc4wSbwu7+vMvrkCoU4Uvt7IB+nAiU8qq+Yg8e
 LkZYLuCo37kFZD9WdEL9kc8r6b8/Jek0W8UNQSv6lSzWnBDVByYPK4kEB5XuBx4pBK9yL/
 C7Hzf2ThltG796P0R2Op+1ktm9DyNaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Qm8_AE31N5iDZNVFcyWjOw-1; Sun, 27 Oct 2024 04:00:55 -0400
X-MC-Unique: Qm8_AE31N5iDZNVFcyWjOw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5016d21eso1640849f8f.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 01:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730016054; x=1730620854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOG0Om3HwykUbgAN29OSBeKr0FDoL+NWdpVIxQs43ss=;
 b=iEs7BfVSU1ttEjGxHzoNkhzvXhRvz989ecZsUjDeqGlLkyUCHfbsYsZP68sdOtJWlm
 XgyjCs7IIWtPRcgfm+cSOzKz2+9muuC6Pq/fp8rfOB8W81WdOBrisKinIju+5Tg9XcbI
 fVhjQzY6SvMqZZ/yu4ch4ydzN/+3xFZFiqlS2CQrhuqE6qQNT9Mtr40KGj9ZtpAyAO45
 qJAFo/1HcZtUrcnvGTljIYhDZn1LnJAlj1xRXffyPQwfz/x93q0taepPq9lXiuz0B8Ka
 PFklNQP6RJyNpAb9OG/H/quBVsom33BvUNEi7eclwYObX+hfb2Ylo+jA7hi7LlQzkBgu
 2sMw==
X-Gm-Message-State: AOJu0YwXKh9XTxh8NK1WoXEYRSh1lhGOgtaSAH04TpxquvACAV8URNku
 GNQXKl3O/T9feZtlaxdkOPGvUqGqlzqJ2O+Qasi6WvCOd3BzzGdDF6p6WxfgP+TlbpUn7LbQDvr
 8XxaIk2KlXvYhmDDILelo7LDOc8pC/G202HlvUD7QCtsZubZ9R+XmW/9fAmgN3Tuzat6Om3a0hU
 SVjOgIBwXjPrUdzGn/ia/wq6usohQ=
X-Received: by 2002:a5d:55c4:0:b0:37d:47fe:7c59 with SMTP id
 ffacd0b85a97d-3806100cecemr3845367f8f.0.1730016054360; 
 Sun, 27 Oct 2024 01:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs2losqmuwzFl6Gvx0ytywTNwTM9iQRz9Gd01wsG3oBEwIOr1bvImRNiXj6bQY3t5uopHNrXTFlrwuOt4/7vU=
X-Received: by 2002:a5d:55c4:0:b0:37d:47fe:7c59 with SMTP id
 ffacd0b85a97d-3806100cecemr3845332f8f.0.1730016053957; Sun, 27 Oct 2024
 01:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
In-Reply-To: <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 27 Oct 2024 09:00:41 +0100
Message-ID: <CABgObfb2qZnH6CKp37pxr8Dq5x39ug=0ND8K4_STerXKxxd6Vw@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.488,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, Oct 27, 2024 at 8:02=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>i
> I think this is the wrong direction (ie, backwards).
>
> Sacrificing current code to be compatible with old stuff feels wrong.
> Especially for really old, like rustc in debian bookworm.
>
> bookworm has rustc-web (and a few related packages) which is regular
> rustc version 1.78, just renamed.  It is regular bookworm, not backports.
> It has some packages disabled (compared to regular rust) and is a hack,
> but it exists and can be used for now (dunno if it is sufficient for
> qemu though).

Thanks for pointing it out! It is indeed better, however it does not
support mipsel.

> Also debian has backports mechanism, which also can be used for qemu -
> I can try back-porting regular rust (and llvm) to bookworm.
> I think this is a better way (at least a way forward) than trying to
> move backwards.
>
> But generally, what is the reason to support debian stable?  I understand
> the CI thing, - we need a way to test stuff.  For this, I'd say a better
> alternative would be to target debian testing (currently trixie), not
> debian stable.

Basically: it is not too hard and it can be reverted without much
hassle once we stop supporting Debian 12 in general. Also, the
next-lowest version (in Ubuntu 22.04, which has 1.75.0) would still
have some relatively invasive changes, for example patch 11. We'll
always need some workarounds until all supported distros have rustc
1.77.0.

Paolo


