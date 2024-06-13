Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EAFC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHohI-0004U4-9e; Thu, 13 Jun 2024 13:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHohH-0004Se-5E
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHohF-0003UZ-Hf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718301430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zb6pqNxI74iToge51ry0W/CKz8UHzczmMRz/HpWjWok=;
 b=WZa5TpwIkCdkOk1CICEnoSRhtLQozAmRP+NwihXLbReaw31XXaE6utTJkCaE7rmkIIj89J
 7WeDix6MosO0F18dg9h7qwv8qSwW1DeL9RVl5um6W+cc+WInROPdo+VKvTn9y+jzc34gVu
 ZbM8RQnNnmLgFzaeMGBVC79eFIe46uM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-79bRkHCfNCy1GM0hZ-VL4A-1; Thu, 13 Jun 2024 13:57:09 -0400
X-MC-Unique: 79bRkHCfNCy1GM0hZ-VL4A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421179fd82bso8490175e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301428; x=1718906228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zb6pqNxI74iToge51ry0W/CKz8UHzczmMRz/HpWjWok=;
 b=E0UwOVz10s16LptOvLiCmsI7R/FqxOrtrYvU5a4LIhKNedJGE9kEN/+RzxwWRk00F4
 IeFDYoAULwNI0t/+E6vZg2KPi0HP1thUj4WVz3Bk5fxgV3O219c0zK1E55pt0SxpQCDU
 b5fV7pt9RkWyL4za9rrGNGZH6yYTRycmyBODC90G2XdfM10VG/6TXGRL4TWBgiJS98bd
 nOj8H9/4Pp/ugJdtTHZ+1EAVFkmehQ8UbNuOns2iqz4yMlatVD1W8Nb+zwiRLbnWFQaJ
 2sPd2l8lweS6x5jRhte0pPYbVxyHHQb4CkzAEl6MjE9kBCKt9P8HwnuuwTfZOSTzRPJE
 d8tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCOTs9zfWj5Mn/W6aelfw8ilIOZ1EWe47MZzJUBrBnG2Dgt620udKcnwU50bN7VcOVRf10HRrzSrZkduNbNJ4bR8yAtFs=
X-Gm-Message-State: AOJu0YymSK8jmot7sbdsBGiU6gKuyirr0P12aU4+7cw4Z18HOOnJme8+
 W8kyNwCL5bN2qar/gNVInCgTyWzw39PEb/rJ2YK2gec00EXl6gRYBpRe+hTpswpJh1eQYVvqlyQ
 kW0T6JZ65NnFaY7Z5ZQKgter0OPgXk3jMOHQunnaB6wWI1pZsLqvwRNsRloN6ieoSox6WQXynpN
 SqcwUmeXd/2oUXdOIRg9X4P0F7pSI=
X-Received: by 2002:a5d:6187:0:b0:35f:44c:b3ef with SMTP id
 ffacd0b85a97d-3607a781a05mr313825f8f.52.1718301427989; 
 Thu, 13 Jun 2024 10:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkhNaE3sJeI86A7DFYHW824xATcwyuO08K8XCPG7mWVQu3KZeD6PiAHGzz/fIdiP+VorcSf148hz6Sfg1jmHk=
X-Received: by 2002:a5d:6187:0:b0:35f:44c:b3ef with SMTP id
 ffacd0b85a97d-3607a781a05mr313804f8f.52.1718301427582; Thu, 13 Jun 2024
 10:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <ZmscPKyuK7RVgrMo@intel.com>
In-Reply-To: <ZmscPKyuK7RVgrMo@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jun 2024 19:56:55 +0200
Message-ID: <CABgObfYnCQu9_yqL=CwO-O8qKqhXqnkZ0JGdZpTy23TX1AuHkw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 13, 2024 at 6:06=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> I think deeper and higher level bindings will have more opens and will
> likely require more discussion and exploration. So could we explore this
> direction on another reference Rust device?
>
> I also think there won=E2=80=99t be too many Rust devices in the short te=
rm.
> Going back to tweak or enhance existing Rust devices may not require too
> much effort, once we have a definitive answer.
>
> I wonder if x86 could also implement a rust device (like the x86 timer
> you mentioned before, hw/i386/kvm/i8254.c or hw/timer/i8254.c IIRC) to
> try this? Or would you recommend another x86 device? :-)

A timer device is a good idea, just because it's another pretty stable
low-level QEMU API.

The problem with hw/timer/i8254.c is that it has the KVM version, as
you found. The HPET is an alternative though.


Paolo


