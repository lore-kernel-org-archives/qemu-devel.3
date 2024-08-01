Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E33FC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 01:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZKDW-0000Vt-Bq; Wed, 31 Jul 2024 21:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZKDU-0000VN-L9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 21:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZKDS-0004rX-Rj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 21:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722474169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EPtgXVG1DmXN8mUPqzXK4hPCx8jDKiZuZxR6dbrnTQ=;
 b=K67U6rB8qJl5o215w6zBP53N78+ecuQTEfIsQt/3PKBtmQFBc1X76wpZGgayD2sSAmIi+/
 luTSnAxP5MM4+QeGzpeflLHmpj3uahsmLpEfnijqfrpZp+I7YHSag+WxPhTqmFpw+9rwX5
 VYPtidLgDQ8mzdhzAOktMTkUG3y8fZ8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-2w3nF_O1N3yCEk4f5nRdNg-1; Wed, 31 Jul 2024 21:02:48 -0400
X-MC-Unique: 2w3nF_O1N3yCEk4f5nRdNg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6688c44060fso128546187b3.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 18:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722474168; x=1723078968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EPtgXVG1DmXN8mUPqzXK4hPCx8jDKiZuZxR6dbrnTQ=;
 b=wcNXHB09wURK/XxyviKwNxVG8ViEW0vmksmLhW65u4nR6lwDFsRv3FAzBnVfAC+8Ug
 mq9Bj10tN/jklZtRN+zCFLdxWQdeJdZW9cC1KH+yJMp71FnjBtuXDLR4PcMP41r8Odx2
 FRPQLkPYT/G7oRSuqJrtyQXhpJmR6CNzCkjMzbUcWAJ/vtlaQSKFu+x+CxNn2mjFzany
 7LgYcQW1iuWU8NCN1OocJFmGid/c9hFtJCZlrbAybwlGlTAE24kkG9UGli5aY/jyVHWa
 m64245Dn3ihBzTZMtkj2M4ubjtrgRuoriIq+earbv9qcjrd7Yh3q3rQoUGb0f65NSeFF
 t8WQ==
X-Gm-Message-State: AOJu0YzbQEVjXhuiXX4nK+jSm1YEtucp5jlJeoPkiuH8xTkKU1PxaFu0
 18BTHDxqyCTafnFVULoH3ZEcnvDAGULLRyyTC5ZSryX6uBREM9aQW1nbzJVyRp67fR6RECTMI/j
 klBW1M74ZpczRRPvLt+AvdRr1QLdh1uLWHlXfAuo33P/M6fpdn4oCW2xCs88sTr48PT80YJ5jbx
 o2jRAR0hbJdRWeLzqfRekIrn5A0Z8=
X-Received: by 2002:a0d:d2c2:0:b0:65f:7cee:43b with SMTP id
 00721157ae682-6874c831fd1mr1432597b3.19.1722474167827; 
 Wed, 31 Jul 2024 18:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkc15aDKVHH3uOKMYYIWFcMJ5yGLicXXFfZd+KYx38Ns7DB7mfW6sSOPgdc+j5g3qEXTbXjO95vBc0SsuX67E=
X-Received: by 2002:a0d:d2c2:0:b0:65f:7cee:43b with SMTP id
 00721157ae682-6874c831fd1mr1432307b3.19.1722474167551; Wed, 31 Jul 2024
 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-4-crosa@redhat.com>
 <ZqdvR3UFBCAu8wiI@redhat.com>
In-Reply-To: <ZqdvR3UFBCAu8wiI@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 31 Jul 2024 21:02:36 -0400
Message-ID: <CA+bd_6Lepg=uXs1NViYV5eZBGot2ZRAYUi-NDXwSBsdBk17LPA@mail.gmail.com>
Subject: Re: [PATCH 03/13] tests/avocado/intel_iommu.py: increase timeout
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 29, 2024 at 6:30=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jul 26, 2024 at 09:44:28AM -0400, Cleber Rosa wrote:
> > Based on many runs, the average run time for these 4 tests is around
> > 250 seconds, with 320 seconds being the ceiling.  In any way, the
> > default 120 seconds timeout is inappropriate in my experience.
> > Let's increase the timeout so these tests get a chance to completion.
>
> A high watermark of over 5 minutes is pretty long for a test.
>

I agree.

> Looking at the test I see it runs
>
>    self.ssh_command('dnf -y install numactl-devel')
>
> but then never actually uses the installed package.
>
> I expect that most of the wallclock time here is coming from having
> dnf download all the repodata, 4 times over.
>

Exactly.

> If the intention was to test networking, then replace this with
> something that doesn't have to download 100's of MB of data, then
> see what kind of running time we get before increasing any timeout.
>
>

I was trying not to get in the way of the original test writer.

Eric,

Are you OK with replacing this command for a simpler file transfer?
Any suggestions?

Regards,
- Cleber.


