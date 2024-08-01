Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0942C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 03:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZMNO-0007fo-PY; Wed, 31 Jul 2024 23:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMNO-0007f2-4u
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMNM-00036R-Aw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722482471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3L2qM8ejm2ahCeHxHfhlaEvmc2geAFoV8VAb1fNK9SI=;
 b=Z7XUjjhrhfLWuNutt1+4hr48v71+VNYyg6qh0QzegFAsEsnNWca5oAWFMlixymLD7MqzAl
 UJ+7RKNbNYkdNYXflYV5Ncls/oktdXHcvYK1XAx68eh6RKYQw4FGX17ZTZjK/i2wG8VQIx
 W9/7vIsumdWvk8QwSZ1J/Asyp1r9BjM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-3yhx5yRRNMyEtzTaMmUFkw-1; Wed, 31 Jul 2024 23:21:09 -0400
X-MC-Unique: 3yhx5yRRNMyEtzTaMmUFkw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-654d96c2bb5so117765347b3.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 20:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482468; x=1723087268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3L2qM8ejm2ahCeHxHfhlaEvmc2geAFoV8VAb1fNK9SI=;
 b=g0zPStDf+iEcX7kQ37JB6FTT5XXApigTTC3nzt0/iyYzeychKJ6yY8rv4YNr5+m4EN
 y44t1wMsXycpz0H5SYcJA3ntMOad6OYxpiUYnV1nFUbPrTEWknTceu4A69456GgwXtw6
 5qXd7YHPEogZUtQ2KXjaPkj18NfrAIOE8gKUbCPg17026nIoTFLC0irfA/OjAe+me2z3
 LkYLTziwHZbSk5YjZS8aXdPzAAEy971/dSSKQIjaIyAtWRpPUj6AZ3izViJxYXrkOV19
 1axu6BZkx16pUUuJCOnT/SvrjBzFX21kNL51xdfIs5UPf7VyWoQUOErcWwjlGq9COLRB
 2qTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOAA+u5RPcAmZovPEgBdJOiBZjtxvR0LlnNJFeyFetYkpDqbduWkt+CrWLAHQWxIXYk5p9Vs7hS4FVTCIP/WntLPlcuI0=
X-Gm-Message-State: AOJu0YzOpR1bWpJEaTY58jZhcYlCCCcvfqOelCGJeSYAGkkvNOuDP7BA
 dop0/3Y0hoF83wGbml427iTrhRQWqAzu0E2Myvrw9rJfbpvTBfM5YY8IxENkpg36rDzTSDiX5HV
 udSfNMXvfLaCV1Zg/zwa+C8JpetZUmhRSMHZOAKCARDdUBR6IovHE6pUarB2b6O/DiC11gByzrs
 rCaPRAsAnTIV0PURna6f5cu4DwyfM=
X-Received: by 2002:a81:9e0b:0:b0:65f:9796:2bdf with SMTP id
 00721157ae682-6874e3a353bmr11944427b3.27.1722482468402; 
 Wed, 31 Jul 2024 20:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/B7vKknlSLIpX/PzKYimkunlNYGAGba4CoCVx15nKCeW8j5fj5eTdje1OP15fs0TyI/8uKynT9Wdinr8oj8E=
X-Received: by 2002:a81:9e0b:0:b0:65f:9796:2bdf with SMTP id
 00721157ae682-6874e3a353bmr11944157b3.27.1722482468074; Wed, 31 Jul 2024
 20:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-7-crosa@redhat.com>
 <ZqdzqnpKja7Xo-Yc@redhat.com>
 <6dbc898d-be8a-497c-87bb-d13d956cd279@linaro.org>
In-Reply-To: <6dbc898d-be8a-497c-87bb-d13d956cd279@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 31 Jul 2024 23:20:57 -0400
Message-ID: <CA+bd_6LFDwv+y7c8gu89bCcgX3QXHXsyvCrCiAidP40ptdKExw@mail.gmail.com>
Subject: Re: [PATCH 06/13] tests/avocado: use more distinct names for assets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>, 
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

On Mon, Jul 29, 2024 at 7:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 29/7/24 12:49, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Jul 26, 2024 at 09:44:31AM -0400, Cleber Rosa wrote:
> >> Avocado's asset system will deposit files in a cache organized either
> >> by their original location (the URI) or by their names.  Because the
> >> cache (and the "by_name" sub directory) is common across tests, it's a
> >> good idea to make these names as distinct as possible.
> >>
> >> This avoid name clashes, which makes future Avocado runs to attempt to
> >> redownload the assets with the same name, but from the different
> >> locations they actually are from.  This causes cache misses, extra
> >> downloads, and possibly canceled tests.
> >>
> >> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >> ---
> >>   tests/avocado/kvm_xen_guest.py  | 3 ++-
> >>   tests/avocado/netdev-ethtool.py | 3 ++-
> >>   2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_gu=
est.py
> >> index f8cb458d5d..318fadebc3 100644
> >> --- a/tests/avocado/kvm_xen_guest.py
> >> +++ b/tests/avocado/kvm_xen_guest.py
> >> @@ -40,7 +40,8 @@ def get_asset(self, name, sha1):
> >>           url =3D base_url + name
> >>           # use explicit name rather than failing to neatly parse the
> >>           # URL into a unique one
> >> -        return self.fetch_asset(name=3Dname, locations=3D(url), asset=
_hash=3Dsha1)
> >> +        return self.fetch_asset(name=3Df"qemu-kvm-xen-guest-{name}",
> >> +                                locations=3D(url), asset_hash=3Dsha1)
> >
> > Why do we need to pass a name here at all ? I see the comment here
> > but it isn't very clear about what the problem is. It just feels
> > wrong to be creating ourselves uniqueness naming problems, when we
> > have a nicely unique URL, and that cached URL can be shared across
> > tests, where as the custom names added by this patch are forcing
> > no-caching of the same URL between tests.
>
> I thought $name was purely for debugging; the file was downloaded
> in a temporary location, and if the hash matched, it was renamed
> in the cache as $asset_hash which is unique. This was suggested
> in order to avoid dealing with URL updates for the same asset.
> Isn't it the case?
>

Hi Phillipe,

I've replied to Daniel's question, but let me repeat the relevant
parts of the $name behavior here.

---

Under 88.1 the "uniqueness" of the URL did not consider the query
parameters in the URL.  So, under 88.1:

   avocado.utils.asset.Asset(name=3D'bzImage',
locations=3D['https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?path=
=3D%2Fkvm-xen-guest&files=3DbzImage',
...)
   avocado.utils.asset.Asset(name=3D'bzImage',
locations=3D['https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?path=
=3D%2Fnetdev-ethtool&files=3DbzImage',
...)

Would save content to the same location:
/tmp/cache_old/by_location/2a8ecd750eb952504ad96b89576207afe1be6a8f/downloa=
d.

This is no longer the case on 103.0 (actually since 92.0), the
contents of those exact assets would be saved to
'/by_location/415c998a0061347e5115da53d57ea92c908a2e7f/path=3D%2Fkvm-xen-gu=
est&files=3DbzImage'
and /by_location/415c998a0061347e5115da53d57ea92c908a2e7f/path=3D%2Fnetdev-=
ethtool&files=3DbzImage'.

I personally don't like having the files named, although uniquely,
after the query parameters.  But, If this doesn't bother others more
than the maintenance burden, and Avocado version bump is applied, this
patch can be dropped.

---

Now, an update: instead of dropping the patch, it could be simplified
by keeping just the "name" parameter (with the URL) and dropping the
"locations" parameter (that has a single location).

Let me know if this makes sense and what you take on it.

Regards,
- Cleber.


