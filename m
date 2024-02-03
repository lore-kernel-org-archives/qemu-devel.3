Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DF4C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 11:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWDsY-0003qW-5v; Sat, 03 Feb 2024 06:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rWDsW-0003qF-Cm
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rWDsS-0004Oy-6R
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706958482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQXGd96uHTRAKKn3FjVseEuprY59bAKKRh3PVLvv8JE=;
 b=dATzPa5jqg0PfHVnQl9o44GvGyiQCUSaIX5cGQyFCcgYYbBfT0JDxCiyY3EnHtLytlQ+9p
 PNd6E/tqeqMI4ka/hW584dKZPRzFoXTf4w/1qs0RJml14hkvfjFM3C5On490ovyyf2yXsX
 NHsny3FB6XLUpV7xt8yq/G71wF03bJI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-fWXxcxIMPeuZCDBMgy5eBg-1; Sat, 03 Feb 2024 06:08:01 -0500
X-MC-Unique: fWXxcxIMPeuZCDBMgy5eBg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d09d9ceaceso1091571fa.2
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 03:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706958479; x=1707563279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQXGd96uHTRAKKn3FjVseEuprY59bAKKRh3PVLvv8JE=;
 b=cv84ZPVOENKr413xR0Xf9C621tqsvGENi4YHhZaU8ZWr1yjWkwQfiXnhXHSkPM0F7/
 7DMYMBca60aamFlWE5kuZ00YBiJaZzWphQhKEi7wlK9qAwq6lvzYsL2DvdN0RZVl1X/K
 YGqagC0OxZp9SHDyeAM+RNQkv+bslGE9QY6htgY9qm3qGCzkK9g71fNAKZCSU8n+1Yfh
 jZZgIh+fU/UxV2S5BP7auHZupPh3XJbS9sK8ewkgRiL4dDJim/pBrED9OEoW0XqHbwzr
 j6EVVkbX3t3H0NM46qNeeNm6pV6idXxoP2UR1A730gcfXS//il1e2aBssAeuCFvvVyW3
 kSXg==
X-Gm-Message-State: AOJu0YzWDXEXEQldg2cdGhwlTXT4j7qIFnQC10ETmxzm+z2L6WTOA00C
 X3VaXiM062ewobBd/W7YceeGs7cW3YJSFFhtCis33N8uSHnE61wbDBVrf4y8OAQS9aDQFv8CMuP
 h1Koq9tYxLYzVVIVBzOtVNMu54VpinbR+9I4GdV5WXQgbNj3uytNKE88U2L/xmhQ5idoJsxHdVa
 FuYUuu7MDma8ILmr7pJTqp8JjNxLY=
X-Received: by 2002:a2e:740d:0:b0:2d0:6d69:7d25 with SMTP id
 p13-20020a2e740d000000b002d06d697d25mr2654029ljc.11.1706958479628; 
 Sat, 03 Feb 2024 03:07:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ3Omj/dZjLe4NvvF8oWdKNSnMWucVeZ9/0vNZSlRqzQnw8IbS2MSwWXUhjeV1MiwKNP8GbR/joGaeF7dtLNs=
X-Received: by 2002:a2e:740d:0:b0:2d0:6d69:7d25 with SMTP id
 p13-20020a2e740d000000b002d06d697d25mr2654017ljc.11.1706958479268; Sat, 03
 Feb 2024 03:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20240203080228.2766159-1-armbru@redhat.com>
In-Reply-To: <20240203080228.2766159-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 3 Feb 2024 15:07:46 +0400
Message-ID: <CAMxuvazGCS+JCOhaw=WGy2E=8U=o7K+uqiPJu+eeHn-W_HTYsw@mail.gmail.com>
Subject: Re: [PATCH 0/4] char: Minor fixes, and a tighter QAPI schema
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, devel@lists.libvirt.org, 
 eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi

On Sat, Feb 3, 2024 at 12:02=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster (4):
>   chardev/parallel: Don't close stdin on inappropriate device
>   tests/unit/test-char: Fix qemu_socket(), make_udp_socket() check
>   qapi/char: Make backend types properly conditional
>   qapi/char: Deprecate backend type "memory"

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
>  docs/about/deprecated.rst |  8 ++++++++
>  qapi/char.json            | 28 +++++++++++++++++-----------
>  include/qemu/osdep.h      |  9 ++++++++-
>  chardev/char-parallel.c   |  7 +++++--
>  tests/unit/test-char.c    | 25 +++++++++++++++++++++++--
>  chardev/meson.build       |  4 +---
>  6 files changed, 62 insertions(+), 19 deletions(-)
>
> --
> 2.43.0
>


