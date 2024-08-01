Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D3C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXuC-0006vi-0v; Thu, 01 Aug 2024 11:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZXuA-0006oy-DP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZXu9-0004Fa-2z
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722526788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvtcL26MELukLXBLKiU1OvgArmvH0sx0AOPSGAsOPYQ=;
 b=i/SUnjPIGpQbKcmLdTeG7zQq7hoCEvpSS33EbTRFuaPWKmEkarCRvawV/lfYnWN/tw26LZ
 beDiBbYQjxrWXMK1Aq10ZRC8yabYIUT/8cfStR7vix9cmdZh1X61EGXqh3WRqYmP+xVYGn
 NsMw0c/HgqGKl3upXdNMsxQQXB3qNCw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-8S_VLEVBMW2A08c3xX-MTA-1; Thu, 01 Aug 2024 11:39:45 -0400
X-MC-Unique: 8S_VLEVBMW2A08c3xX-MTA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-64b70c4a269so132736897b3.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722526785; x=1723131585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvtcL26MELukLXBLKiU1OvgArmvH0sx0AOPSGAsOPYQ=;
 b=xM3LTaXmCd/JcaAgir9TLZoXcF6nK2TVTALr6VuDscIsJdmH1bkYFwQxCiDyFiBqzh
 rkfTf5KFl33jc3SQu1VEhzqOIKwz9UBQSmY1vp/qNsF7xElQ+/9oeMrrmBKiQpFlKVl2
 39I+XNDIo1U+7GlEwDecce4DXgn5pRgBauAJZ7orSxJJn+zRg5F0ME4oYOLSvAcxqjN/
 9sD/t5NSY4do6If1k4jP34ax3UKwpGA0aqBp7mPa5VrvX/jQB6KCaRaEETVcGbkWaPIg
 jVhYeF4co2G0oy5R8+lEWzEkamUnsIArhntdD0H8M4tj0JbqHtiuzTZJBtbXUVSpXxo5
 596Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3UyxfBAmeHH9zAmRtHiDTxYmxaU7z+Wa6zx59AmrO/wpO7MUQQicyPRi1DiooRMhtVzwH9DNyCk5TpwXEN/S3IEmEcF4=
X-Gm-Message-State: AOJu0Yy+hppL2WxfOhMB/0M2s6FHaH555ODhoGe6BDscF+/0iGnJVYSg
 YSGCpnbsU2SqARjlDWCkTfOJsRivD/SK1pj3F8C60DT7LmP7SZTtSy2dXNFezD0B+af53/F/mmj
 QyiTqppAhJexO7Uo/liTlVgd4wLGJJavg78iGv6GoXjP/+Z/GKjCQ3YmSx1wfWx1dggFuBzqGZn
 ZCXm/AzdHulxjJPeHSJvwl9UEwT4o=
X-Received: by 2002:a81:6ec3:0:b0:65f:851d:8fb with SMTP id
 00721157ae682-689614169ecmr5418547b3.19.1722526785241; 
 Thu, 01 Aug 2024 08:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEstoQY1wa9dYRGq1XTayGmAh4S4JQ1xiqn++gZGCkL13Di/n3qojj4QYU6j5a+xzQ2XxaZWOdBKgFbysxmOk=
X-Received: by 2002:a81:6ec3:0:b0:65f:851d:8fb with SMTP id
 00721157ae682-689614169ecmr5418347b3.19.1722526784938; Thu, 01 Aug 2024
 08:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-8-crosa@redhat.com>
 <Zqd10nIix4gXKtDw@redhat.com>
 <63ef2c5b9ab213f544173df027abf5b056d59e8a.camel@infradead.org>
 <87wml0coat.fsf@draig.linaro.org>
In-Reply-To: <87wml0coat.fsf@draig.linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 1 Aug 2024 11:39:32 -0400
Message-ID: <CA+bd_6JNRhj4K48Fg_yb7KeXmEYgzxyT1NJJJ6K0yFxamc9UwQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 1, 2024 at 10:26=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> There are no real failures with readonly=3Don although you do see init
> complain a bit about not being able to mount /dev and open log files.
> snapshot allows that to happen but doesn't change the underlying
> storage.
>

I could swear I experienced failures when I developed this patch.  But
like your patch b9371a7b90 already fixes it.

Dropping this one.

Thanks!
- Cleber.


