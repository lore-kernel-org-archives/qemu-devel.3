Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C0CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxltQ-0001BA-Vl; Mon, 07 Oct 2024 07:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxltP-0001AX-FN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxltN-0001K6-57
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728300427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nKqBnt/fCOBu40ubx4JznSGepSs7ghbPdITuSOSGVo=;
 b=OcxS4h0S8SjqskIua9jZsHd4cGWa1W7H3bFZzOk1PgYqpPZot0pUsiHymhMhkmtzy31Vw3
 AxYsXvdL+I2IZFElCYYdT2tXeS5jiRnIqZ1bizrS6AFNTtP+WSrjJyJ7D7IuycrAFY9kol
 OpgfPuZPX/ucbPnaNgVjzGBwez+Dt4U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-oXG8utIwOQi1r1PFW6bZYw-1; Mon, 07 Oct 2024 07:27:06 -0400
X-MC-Unique: oXG8utIwOQi1r1PFW6bZYw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cd4ec04a1so1761370f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728300425; x=1728905225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nKqBnt/fCOBu40ubx4JznSGepSs7ghbPdITuSOSGVo=;
 b=DQXxg/ibQIZJYiCeztd57O/aAN/g+GW4lg9owjRo4EZZEwmFN08mjKdPYuPouRPqyX
 VSj9SdEKmT+2bWyNB64FBQm3mlWMha2H4S53f7GKKI0YAP6woGZLf2idswiUw+Q5+RxK
 8xM4+CfFnMvsSHs8GT32d+lIFIXXZw97aOVKEttisYs5R4l/scpl1zaUmtihWRfnPq6k
 wY/i2P4UKwY7+9jq1ioDytW/J7nnkwcXdJZ11erlI6tLAjzDvi5Q3JxPVjXS17CXUbyB
 Abf2gTRXgqCGGDuD89gKXeeyGeFk5KdleUwtPBd/QIu7zSAvbEQ/i8pxExLHyZlE8DSN
 8dLA==
X-Gm-Message-State: AOJu0YzWpoqdh90vCTjYiH4TW7/nXITEnRPtG2wAjTg8QxfrEuwVEY3e
 DMSJO1NYgeQEHhR4Wdv1U+dE1pPx87cKlTeX9asQQM2eIbfuXuG8Y+c+xxvItI6HA4xBGt3Ds9W
 T45J4ON70ac+MEZzcVvGVRUideAPezmJW6zfANCW09wFdkm8YeB5/0Oiah8bUybtp2/8ER+VExr
 Q8WytLZeadDx4Y4YeUW3ZlJq9PW/o=
X-Received: by 2002:adf:e501:0:b0:374:ba83:8d73 with SMTP id
 ffacd0b85a97d-37d0e6dae2amr6181354f8f.8.1728300424838; 
 Mon, 07 Oct 2024 04:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBFQwRnfH6pJlQQqrFl3l1SMSt7cNX3VLUkFV1aiUPe14k06IqUT1J1SEqsgazNkqq1S28P9+FSYd9ciYJM+g=
X-Received: by 2002:adf:e501:0:b0:374:ba83:8d73 with SMTP id
 ffacd0b85a97d-37d0e6dae2amr6181343f8f.8.1728300424500; Mon, 07 Oct 2024
 04:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <ZwPB9SnTvkr082NA@redhat.com>
In-Reply-To: <ZwPB9SnTvkr082NA@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Oct 2024 13:26:52 +0200
Message-ID: <CABgObfYZgR9xNnP9mHWU92XZZ_VeFLHimkd-t-63KX_KWeDZ=A@mail.gmail.com>
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@intel.com, pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 7, 2024 at 1:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> The current dockerfiles don't include rust, and I see nothing
> here updating them to add rust, so how is any of this getting
> test coverage ?
>
> Even though this has Rust disabled by default, I would still
> consider CI enablement to be a pre-requsite for merging even
> basic Rust support.

I agree in general, but there's already a lot of work that can be
parallelized and the idea of someone managing Rust-related patches
out-of-tree was discarded. So this seemed to be the only way to
proceed.

Right now only Fedora 39 and 40 (with updates) are able to compile
QEMU with Rust enabled. Full CI enablement requires further work to
reduce the minimum supported version of the compiler, after which
rustc can be added to the libvirt-ci inputs and to the Dockerfiles.

Adding a CI job that uses nightly rust (via rustup) is high on my
priority list, but first of all I wanted to integrate clippy (because
the main point of having a job with nightly rust is to have a heads-up
on future clippy warnings). That said, I'm also not sure how one would
go adding rustup to a container generated by lcitool (for example
should I add a new dockerfile that is _based_ on one that already
exists? would that change when Rust/rustc is added to that
dockerfile?).

I think the best thing to do is to do a presentation to the whole
community, maybe next week, explaining the state of the experiment and
asking for help.

Paolo


