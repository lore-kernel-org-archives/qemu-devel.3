Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D15CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slns1-0004sd-Jh; Wed, 04 Sep 2024 07:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slnry-0004kv-Vh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slnrx-0003Gh-BT
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725448092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+xm5ji9Z6bP3j3oosGGiKvn5K1ngfMnXxi/PO+7KAw=;
 b=Kxdq1KG3aMCJLlnzF4sPyQnYNCu1+lNQ/wpzNsvXO2XvdY0xRkHmIVQXsxbqCn9qlbSYg3
 J4wpVNlk+VumtVIwznVeQTbQqRf5fpZGhUYlEiRaoxjC7ZqZnuvumbCt9hyjl2809T9Tnz
 upB6gpdHYrsSBZkNZ/nh3L0B4XJ5OhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Jpe-kTBhMNeJapEUJ4Hiyw-1; Wed, 04 Sep 2024 07:02:04 -0400
X-MC-Unique: Jpe-kTBhMNeJapEUJ4Hiyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42bb68e1706so58397175e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725447724; x=1726052524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+xm5ji9Z6bP3j3oosGGiKvn5K1ngfMnXxi/PO+7KAw=;
 b=Sd2mCnfVtDK9bxRxJ3vsXEHZ+zU1pvL9vqnVWBaJuvViuP1coLe/RDdHJfn41veHBb
 WKEI2oKOnjgZF046lSfgEekcXyZ1fXpaL3zWL/YOzyJmHjXVIhwp9ArM/CC/XjP8Y+Cp
 Pw06JvxhBuH4XqiWk+Yli/ZY9oWDTlFUZ3NIWYft7D+NRtDj5WXr/84dkb2FC+28OLvj
 bCJS1KY3jgAqKfQQi5h7EeaUqwZ3l4wjWzQtDXfn2tj66/Hz/q4Gtm9X/5GduLKq29Ig
 IGT8JMdsYqCoIkGK0C7pmT5QCsnNMwFsslRb4P8qY9VfcxIQvA1yGx5uus/w2LmkCYCR
 rVQg==
X-Gm-Message-State: AOJu0Yzp4jQ1KbwALSsUP5+rGASHpSmVObTEXWiUKqo/gghP5dXU/TGl
 /ro1TuNi0CtFgABooJpJ89968zCSiEwQ3P48K9LkCN0y19RYH8oXpgNsuEJrraQpdnkFIb5a9BX
 1zySWJ7PI0VkdAylkuRkmbXlie8SrOIyFxydhL2XiWM53gd9ozqDvpCXZZnXU+23zRTe/4Ubqgs
 bwl5UJPKezdL0jw5cNrf8E+UfwDmg=
X-Received: by 2002:a5d:6712:0:b0:371:88b9:256d with SMTP id
 ffacd0b85a97d-374ecc67c04mr4684710f8f.6.1725447720831; 
 Wed, 04 Sep 2024 04:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5cZonIBSJd9+StD5GlWnvvEG6Iw0YjaILDiZAYbUHUqMvNgYEH5Ro+FY/LkP3je9oWP4a1iTjmCFt/52zS7A=
X-Received: by 2002:a5d:6712:0:b0:371:88b9:256d with SMTP id
 ffacd0b85a97d-374ecc67c04mr4684600f8f.6.1725447717922; Wed, 04 Sep 2024
 04:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Sep 2024 13:01:45 +0200
Message-ID: <CABgObfbe1tFWb1yogUskbUszFyHjy_qhk0k6B9YrgBeVNTnDww@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 28, 2024 at 6:12=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.

The only comment I have is that I would drop the allocator support
completely. It adds complications and, at least initially, we can
plan/hope that all cross-language allocations go through a constructor
function like error_setg() or object_new().

In the case of QOM, if we wanted to allocate objects in a Box rather
than malloc-ed memory, we could also put in the object a free function
that calls

   mem::drop(Box::from_raw(p))

Fixing rust.bindgen() to use the right CLANG_PATH/LIBCLANG_PATH should
probably be done in meson itself. The (not too hard) alternative is to
just use a custom_target.

Paolo


