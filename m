Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C16C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 09:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVAP-0003Dx-TE; Tue, 18 Jun 2024 05:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJVAL-0003DJ-EK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJVAJ-0003dS-Ke
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718703007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d96ik9IhjtOZdBReGkVdVluX9TR6hMD2qTLBTXUVts0=;
 b=dmtkNPsuEl7hopo52fuJsbxL3qiVGoytTDkyDO9NozbWLAFnWed4OBpONk8Z1AVhxMksSA
 KEVnnGqqRqptMIYDrlEAIKNVnv5eeQK2DtZ8QtoYXR9J7WkQpOl/9mzicQ5fQgBz9HwebW
 BA3UFZ98PtLwQP4YygrbOZQMFtlpJV4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-UufNUaklOiGgI04B2o3isw-1; Tue, 18 Jun 2024 05:30:03 -0400
X-MC-Unique: UufNUaklOiGgI04B2o3isw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52c83028d7cso3699180e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718703002; x=1719307802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d96ik9IhjtOZdBReGkVdVluX9TR6hMD2qTLBTXUVts0=;
 b=Nl3MM6WtgPReqi7gmutGovLPlwkLzAn0g1jniG/L14QGsQVytb6kIrf21zAnPl0STF
 4jsAn8GrPmQMXtoAl1F/159KY5S5CpqLO6KNOewtjam+Rc3sDIO1V9UTa0nofgnCjji5
 yofWuhbUs7ITkKB6S8sTyuuVRHoeB5gOSiYvQDFmXCLGi4OsmnYbf16opYYXqgE+6TxL
 GJgMs6Eulg9MoIiJlI2tkWo9JHZ4YQS9wf1gqUuJsNU3z4v1n+IsWLzNcEksc6y4okgy
 aU6OC0kbJRqULcHKbwpQvv+sfJ1LYzA/YeBKsFXT7N62VxoC0fqfUsSLi8hlplBiu7PJ
 vzGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUR12jL4ZFag2Rls7ZIS2iZpOK25aT1AUF0CN8KqteH2/ad3ne7cKg2DRfpAV/IvqgkaTMRrKQS4JFEISl0WUWnuBDue0=
X-Gm-Message-State: AOJu0Yz/6++Gm56rnkXiS1Z1FT/Wba1N5LnCzVQPEUJtP9jAyFKLDYv5
 zihn9YbgcrjUbViPo+B3h7M9tDTy5y3HC/yjpYa4uU50BFk+SDjN7y+RACiSeZpNjHi6Xe4TuuF
 UZFLA8V2vcyY/SqZU01KXbuGIlBn5gdTPDuOSNPKADYQDpfUvtNg3k5AzFMDA4+yedAGJtTEmkx
 q19sF97WbsDjaz/BeHKXt4hu66w7Q=
X-Received: by 2002:a05:6512:3f9:b0:52c:a574:28f2 with SMTP id
 2adb3069b0e04-52ca6e67068mr6571965e87.26.1718703002177; 
 Tue, 18 Jun 2024 02:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg3imHHfguEO49PyutsmyfwSvIShUlBuMCKWVwTnlYvFGPhxL6tiLZajOhI11gJnEkXYRd2HCoFMQlS2toUXM=
X-Received: by 2002:a05:6512:3f9:b0:52c:a574:28f2 with SMTP id
 2adb3069b0e04-52ca6e67068mr6571957e87.26.1718703001829; Tue, 18 Jun 2024
 02:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
 <ZnFPwinlmxpgH3mV@redhat.com>
In-Reply-To: <ZnFPwinlmxpgH3mV@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Jun 2024 11:29:49 +0200
Message-ID: <CABgObfaGHk=A1kCbvSYnCgepu4whk3VDjT=YgLwagxx4wEoYaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Tue, Jun 18, 2024 at 11:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> I wonder if starting with a device implementation is perhaps the
> wrong idea, in terms of a practical yet simple first step.
>
> As devices go, the pl011 device is simple, but compared to other
> QOM impls in QEMU, devices are still relatively complex things,
> especially if we want to write against safe abstraction.

It's true, but I think _some_ complexity provides a better guide as to
what are the next step.

I think it's clear that they are, not in this order:
* calling QOM methods (Chardev)
* implementing QOM objects
* implementing QOM devices
** qdev properties
** MemoryRegion callbacks
* implementing Chardev callbacks
* general technique for bindings for C structs (Error, QAPI)

> If we did this I think we would not have to give a "free pass"
> for a hackish C-like first Rust impl. We would have something
> designed well from day 1, showing small, but tangible benefits,
> with a path to incrementally broadening the effort.

I don't think it's that easy to have something self contained for a
single submission. Reviewing the build system is a completely
different proposition than reviewing generic-heavy QOM bindings.

Paolo


