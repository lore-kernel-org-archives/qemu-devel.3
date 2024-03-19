Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E830C54E69
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaSt-0002uD-VQ; Tue, 19 Mar 2024 10:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaSe-0002pj-5d
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:29:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaSa-00077U-Mf
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:29:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso3599121a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710858539; x=1711463339; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmTixtA5mxo2F6hyqWhxuGgqVtjT5jJDOL02JUCxo+c=;
 b=RB6+cU4iEQoPkDz9VCNDV/8Ul4QMA4Much/7SQZ6CI62pAufilJig5UBNeYe42JxVi
 DcSn3Zyqn5SQtPLCGOV2I+qv/GD7p1aikXre/dmW7eOdRfU7yLrIHE6BxDocHL0nDvsX
 lUXpNT/MBIVotiyaqCWbTvlGkEKYilUEl3ateaJEfro5Xnn+5ujOLxA0i2b3cTnH5qsE
 v5yVxg+jBixq51NyB+1KhZoVfSXeYH101oPJNaiztXVKQ3l8uQeuucby2A7Fk8AY7R7G
 IRRMOd3PG3pkAgsodPXHycbEw2E61Qff4V9JnWrh+R/x9yErQZgmfcIEn8aAQiSGci8I
 MaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858539; x=1711463339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmTixtA5mxo2F6hyqWhxuGgqVtjT5jJDOL02JUCxo+c=;
 b=L7Pam6JXzqPRf6DnyQq+vGOkICl2HMik2JTN18JDPti34u9jLWfdCZlb2lc0bi1gM/
 nwpv1ul8uKsvKPCEK+EGls3Gma5YxdJr1FTISTpJ8+Rnt5LF6QYOkIWNrv1GLSaJuLQG
 yPdJsN2pzD7UG/UMQXXjgt8ZEo6k5Maz64nfeZerZuv/NWWr0E/BsZBU0PHBaP7kjY90
 RcapYF1W+OOxZCVgeXnE4mETMK0in7sMYSfmzLxgVirHfoKZShezF/7/09ACcge8CghO
 E3MqKaKyA8mLQn1fV3wV3NOxBK/HwAOEp/ifWG0nrgEFqFBynfs0mIaRrXBusm+2XYkK
 6fhg==
X-Gm-Message-State: AOJu0YxM2LmOc7xgDqyK7NphfXe97ySI59VwVSzh/BGaTKq3v8/HtKmX
 jY4THNhgx61QSpbmhrb4DIwM4GCe3EhyKTQTt+YchU6qxnfaPPD9eBr6LkcUxKgvln+UFQ0Wryt
 d2MgNvxdAN8ltgMttynJtf3MtjjLwdgAVizZYge9h2Q/lGB54
X-Google-Smtp-Source: AGHT+IFKBEE62k2qLozDokXzU8+D3/mws82lKlIVnkr5WTTgk04hw9n9A6WhIYrXYbgRE80gzP3JR/B8xycp67/rOpU=
X-Received: by 2002:a50:9e61:0:b0:568:a8f5:d47d with SMTP id
 z88-20020a509e61000000b00568a8f5d47dmr2577322ede.17.1710858538718; Tue, 19
 Mar 2024 07:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240312110815.116992-1-peter.maydell@linaro.org>
 <ZfA6Df6jy9AdgnsK@redhat.com>
In-Reply-To: <ZfA6Df6jy9AdgnsK@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 14:28:48 +0000
Message-ID: <CAFEAcA-owzLWHMwg1suxREb6mSMHbyNBGXU5O0bDNRgyTm6z3w@mail.gmail.com>
Subject: Re: [PATCH] tests: Raise timeouts for bufferiszero and
 crypto-tlscredsx509
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 12 Mar 2024 at 11:18, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Mar 12, 2024 at 11:08:15AM +0000, Peter Maydell wrote:
> > On our gcov CI job, the bufferiszero and crypto-tlscredsx509
> > tests time out occasionally, making the job flaky. Double the
> > timeout on these two tests.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2221
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > cc stable just because it probably helps CI reliability there too
> > ---
> >  tests/unit/meson.build | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> > index cae925c1325..30db3c418fa 100644
> > --- a/tests/unit/meson.build
> > +++ b/tests/unit/meson.build
> > @@ -173,8 +173,9 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build=
_dir())
> >
> >  slow_tests =3D {
> >    'test-aio-multithread' : 120,
> > +  'test-bufferiszero': 60,
> >    'test-crypto-block' : 300,
> > -  'test-crypto-tlscredsx509': 45,
> > +  'test-crypto-tlscredsx509': 90,
> >    'test-crypto-tlssession': 45,
>
> I'd probably suggest bumping this to 90 too, as it is a similar order
> to CPU burn complexity to the other tls test - both of them create
> a huge number of certs for testing many scenarios.
>
> Either way,
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks; I'm going to apply this directly with the tlssession
timeout also raised to 90.

-- PMM

