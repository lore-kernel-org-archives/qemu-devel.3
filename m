Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D27C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpgW-0008Cb-Ix; Mon, 08 Jul 2024 10:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQpgP-0008Bm-1l
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQpgN-00060Q-EJ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720450171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SkJo/6Pii6pZ98dT6jDqRTjQhsaH59RpYtqwPg2dH8=;
 b=LT2NUn2ofyPKcb76ZzVfbqk9AUgPcR2zNwnLvNaHrmAOt4HEVAXJaqU4Ouk0XGPe1YvJ78
 +nzVVC+5jmTuJ2bXWuhUTS1RXy+GboUdtaNEjhxSTu8P7QP3L4J7qfYULspKDwg4urLImx
 AlAlseskjRHe3C5mCx/SKCilVmKhXa0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434--7mL9zTrNNaQI7yaTmD1fw-1; Mon, 08 Jul 2024 10:49:29 -0400
X-MC-Unique: -7mL9zTrNNaQI7yaTmD1fw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367a531a2f0so1924182f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720450168; x=1721054968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SkJo/6Pii6pZ98dT6jDqRTjQhsaH59RpYtqwPg2dH8=;
 b=r0KiukWcJoCo3OoScuumxvHH9cnfG3XQgfFuhk9VzeNcN0CMliYau2c2RjulSJQpyA
 XZoi9016EwFYwCUCrn9gn/PriGs5DLkPTKb9IpPdaFqjPu1RQU3W3DB8p9swfOfSu0Dl
 PIzezGlXipaBHlgMU+GtRzO0bsKiaiwl8oxzQSe0LdZl8dE45Hh2jg7m/4wUD7hQ6tV7
 WlInnY/w25bO17ej1i8DkHPXk8XTD/rnWmmScjUr7O+N+sZnoJXx7befji1pXjlZDfjp
 +2ebRVhR1YpMz95mDk7KGl2++9D43pIGlPlgGAVFzZSNuPwPqO/rZcQnerpMJ1m19AQX
 qefg==
X-Gm-Message-State: AOJu0YyJ8YLwmxsQbTRLjheqwMDuWzRxHMeRhsCgJkIzE3Di+auSdnSI
 9Lvjf0hIyx07NqEXqWer6CuKTu2iBznbiu59i1czwJ7M9QEVwBw2gwm4qQE3S8ihNa89G4TAFZ9
 JNoFxR5/zAWV/suXkF/hImEhk8lUDttmZh4m+MQcq47X0ehs+1wIVnYkniUWErvHoLihXQ7p9gN
 BQFM0FMLWFDMtpWfoeYGHx0az84/Y=
X-Received: by 2002:a5d:4810:0:b0:366:ebf5:c6cc with SMTP id
 ffacd0b85a97d-3679dd683cbmr7635012f8f.50.1720450168479; 
 Mon, 08 Jul 2024 07:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUId0b2WFe4vskiUL0+17jYqDOLppLIjTkwQOTVoygqSC5JJ5M5JXrka+JTkqZFvk1xJivzjLsD58bFs/vfug=
X-Received: by 2002:a5d:4810:0:b0:366:ebf5:c6cc with SMTP id
 ffacd0b85a97d-3679dd683cbmr7634987f8f.50.1720450168114; Mon, 08 Jul 2024
 07:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <12f78335f01f2264b91b3170995aa86ccae7d0cb.1720094395.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <12f78335f01f2264b91b3170995aa86ccae7d0cb.1720094395.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jul 2024 16:49:15 +0200
Message-ID: <CABgObfZXiNdu_bFFfbZzyR0JCWdJ=J6WBHo+K35pxFCpc+EqTw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 4, 2024 at 2:16=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Add options for Rust in meson_options.txt, meson.build, configure to
> prepare for adding Rust code in the followup commits.
>
> `rust` is a reserved meson name, so we have to use an alternative.
> `with_rust` was chosen.

Did you find any problem with the other approach that I sent, to
support --cargo and the CARGO environment variable in configure?

Paolo


