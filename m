Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B724C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0Qf-000280-RN; Tue, 26 Mar 2024 02:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0Qe-00027n-EF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0Qc-0003O5-Nv
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711435001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuUO7hJZYeY/C4bnC9MT7mBW6lFOAGajeqlFu62p+yg=;
 b=X4uflxxGy5MkCrG8h6bQs1KIuAQ0gpFURjSGwbd1FVti8AAs2X/CXSVe7ekvqBmfse32sA
 jfgK19JoQTiqX5jMy8H7P8bXTS/ngftuA0ZauiLTCgRsge5FSLngbWKD7/5kvAPowivbSZ
 C4nW8GEsKAw/fLCddmrcM8gwoJurOCc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-x37uVVfwOsiYt2tPHgeOJg-1; Tue, 26 Mar 2024 02:36:40 -0400
X-MC-Unique: x37uVVfwOsiYt2tPHgeOJg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cf35636346so2823648a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711434998; x=1712039798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UuUO7hJZYeY/C4bnC9MT7mBW6lFOAGajeqlFu62p+yg=;
 b=UH2Dlfhqa5+OddJ2zOh4WS8Esr/6/Ac8Zhf5XzbdodAziIwKwUlLGQUwSN9N+9MQc7
 4RHLKBeab26MZg0m1KWhIYeIIE675hepxYpQOcY2jyfXwf95HYgXEakjLyuB+sNmM1MB
 RpqTB+GMZpDDjrobWGrAaLEl4fDDIr4ou1REH+eIPsjMPyL1T2POFcJARx5d3kiuBsRO
 lJBNwuwKo4a56OCJ+ZuhEnnTOvhlN38KYI/KduZfffQlR+5Hz0b/02B35kWRGwVNhCcQ
 72HYt5QI6VpgmgwJ7gsapS/q9MXC6myzkqj7jaxVHmBiMw6RVLNTQTsKvll621x+sndH
 +BLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8eLyhYUpFVL0zuJz761Es5Ws8VSAs5ZnBYvlZ7/uWPQ5RPxwdOIhxqeMVYzQHJk3f9twLKwc7FC56wEIED1PQ59r5vCU=
X-Gm-Message-State: AOJu0YzDYZF6A4WEek2GmBui/x8LJTI+b7pxyThnE/XrHpYUYkK9clqP
 WyjsUImf2ESFo9bj1+QCC//V22zlaTFXvUyfMarKud/K2tAcVAV5KE/iHnCGYA6Wfje8XSiXRKR
 W38Tr9NmuEQkpuMYpp35vqSVX2PVfUrAmOY4qvzbaRpTRaH3yXtGQPBHVrWjLPjqQ4q47IiZT9Y
 GMoN4w2JFdyKVAVWJWcrX55kyAZhJi9oxIjqs=
X-Received: by 2002:a05:6a20:1581:b0:1a3:a79b:490a with SMTP id
 h1-20020a056a20158100b001a3a79b490amr2063778pzj.60.1711434998413; 
 Mon, 25 Mar 2024 23:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6xi34t+i0WD5DAmuMcJEPRGLXZCX9Mk2KQJoPco5alJYma+szbHgBFfsYqoTylyBu84mY3bCvpYKz5oOsH5s=
X-Received: by 2002:a05:6a20:1581:b0:1a3:a79b:490a with SMTP id
 h1-20020a056a20158100b001a3a79b490amr2063770pzj.60.1711434998153; Mon, 25 Mar
 2024 23:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240212-tap-v2-1-94e2ee18b925@daynix.com>
In-Reply-To: <20240212-tap-v2-1-94e2ee18b925@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:36:27 +0800
Message-ID: <CACGkMEv=8kRRz3j40e8q=UBZhL8yEWEHX5kF7OoiDByjJ+6iaA@mail.gmail.com>
Subject: Re: [PATCH v2] tap-win32: Remove unnecessary stubs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

On Mon, Feb 12, 2024 at 10:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Some of them are only necessary for POSIX systems. The others are
> assigned to function pointers in NetClientInfo that can actually be
> NULL.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Rebased.
> - Link to v1: https://lore.kernel.org/r/20231006051127.5429-1-akihiko.oda=
ki@daynix.com
> ---

Queued.

Thanks


