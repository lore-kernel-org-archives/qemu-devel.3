Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AB5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 03:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZMRJ-0004XB-Kn; Wed, 31 Jul 2024 23:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMRG-0004WY-S9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMRF-00056o-Gu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722482712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIA8qtIEwBqGQojB8vR+PEMLSgLeUXkAJyI8y+mq9FA=;
 b=A1jG9AbfrDoH9/BN5TJchnL0Ub5vIAKD8u82fvkSKLkmF3F1Wtyf2mFbFUSPaf35hAiVXr
 g+zL9C1HullYJLv6TG+QtBsrTz6brUQ8T+OwlZorDpx+TM2dJ1z0e6tBvd/1BOBD+W9JXS
 GywUAHNP/D4ini4iwIcv7TFmpHLGgRM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-BMETwDrVMmS28Ff5DEwyKg-1; Wed, 31 Jul 2024 23:25:10 -0400
X-MC-Unique: BMETwDrVMmS28Ff5DEwyKg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-66a2aee82a0so125419287b3.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 20:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482709; x=1723087509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIA8qtIEwBqGQojB8vR+PEMLSgLeUXkAJyI8y+mq9FA=;
 b=KCjpMRLygEqJ8bAK4RPgSeRLUoT5+JMqIPmPExuEW3Y5zgpewYkksgDbxrpZT8rSc3
 KxeKu4irLFydiK+6jDlcd9IEYJe/0Jg4ik9YjlQwt6drq4mKSoHYpU7+qeLQaKQd1IF2
 UlP8lVHanvGVxDMvRA4hiuB4gKcULt3hgG8WSBj0UPbkLlQBJOe60QVyJSHzDjlvKGRR
 NS0XLqZSrrTA2ZFbLaijQizMjID6S2AO4/WVE1W6ppIxhAJsJpTqfyxIg9ROHcKjl+XL
 R+j2yqOpY1z/zsn3ur112Lx4I2dTOfCBMCu3HNhWVSm5vtqOCiMXYff0fPx2ddRtv6DQ
 W1gA==
X-Gm-Message-State: AOJu0YxW06wuHFQHqOFG27pCNtJingxPf7QhZVwbs64LxyOYINgQJKjg
 wZk9SFHH8hl0lekbiNn6WM8EfxxqP2EcfYsLYixomfafeEefieyiTOcQsvdqHPhbn9ZAAWP3yGh
 pfqCWwwtvMcyAZVIC5Z7HDM7x8XcSG/j3p+R3jPYv10qPsTbrxPVugU6oJtxzje0RLzb86axe+Y
 Xg+imYLZjBjKRphTzWrKyiFL58zKM=
X-Received: by 2002:a81:5b04:0:b0:66a:843c:4c38 with SMTP id
 00721157ae682-687521b9560mr5159487b3.37.1722482709706; 
 Wed, 31 Jul 2024 20:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdm8eONMfPaB0Qsap8XfUDxD67qSjsWH3V5PzSZRWN1oS7bhdQe8tBToa8XMYEsh5v+snsMPZPXHV3aL0f7zE=
X-Received: by 2002:a81:5b04:0:b0:66a:843c:4c38 with SMTP id
 00721157ae682-687521b9560mr5159337b3.37.1722482709450; Wed, 31 Jul 2024
 20:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-10-crosa@redhat.com>
 <Zqd2edn1-aNiVriv@redhat.com>
In-Reply-To: <Zqd2edn1-aNiVriv@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 31 Jul 2024 23:24:58 -0400
Message-ID: <CA+bd_6JBpV3A_yyi_R5uELfZkf4zfKJSW9YuZd+am-guK7-QjQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] tests/avocado/boot_xen.py: fetch kernel during test
 setUp()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Mon, Jul 29, 2024 at 7:01=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jul 26, 2024 at 09:44:34AM -0400, Cleber Rosa wrote:
> > The kernel is a common blob used in all tests.  By moving it to the
> > setUp() method, the "fetch asset" plugin will recognize the kernel and
> > attempt to fetch it and cache it before the tests are started.
>
> The other tests don't call  fetch_asset() from their setUp
> method - what's different about this test that prevents the
> asset caching working ?
>

The "wizardry" of the "fetch asset" plugin limits itself to analyzing
test methods and the setUp() method.  This test currently does that in
the "fetch_guest_kernel()" method, which makes it blind to the "fetch
asset" plugin.

If there are other tests doing that (in custom methods), then a
similar change would be desirable.

Regards,
- Cleber.


