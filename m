Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD306C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTAH-0000t0-Gu; Tue, 03 Jun 2025 11:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTAE-0000rq-3M
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTA8-0004kd-7D
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poz9VS25rKsGDeTWAk7J1Urzud3ZXyg/dyjUvIXrQ60=;
 b=JQt35z8RgFD51i5pIpDa+oAs/Tv3cTtt+uEVQ2hazucqM0o3/aM4gjK0Nz+Snql94yIBtg
 +dAhpTOZs+rGvEx0nD8GvBgnR5ceFsQDJ5L6PXFS1X1vGgGLe14laQiJrO68jiPJpcgviF
 U37D654HMLJcGgGCO/AZmIgvSQ+M4BQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-1ft1RLnxM6SEd-BPSxfOLg-1; Tue, 03 Jun 2025 11:02:44 -0400
X-MC-Unique: 1ft1RLnxM6SEd-BPSxfOLg-1
X-Mimecast-MFC-AGG-ID: 1ft1RLnxM6SEd-BPSxfOLg_1748962963
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so15645575e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962963; x=1749567763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poz9VS25rKsGDeTWAk7J1Urzud3ZXyg/dyjUvIXrQ60=;
 b=nPkt7JMlVgCvo//7I8i7ubvGOl21fX9BHbx/xf/5RrZvq0WNzxLufjXOOlBwx7B5mk
 MyRvXTCs0w8mvVqL2Ig2p+fCIAAo3kuLCxveXblcSB6QsD8sCPIoa7bYo6K4NbsZS34Q
 M9hMPHZHHIEQXq+wo0Zs+hWsCH4jgo7mHWpLA4PBr8PY9yd/aZThfyFer+LTHs24+4bG
 /DaHeBSP0zP/+Jp5VpaamdOXmN4+5x5Mz+CxeunqS5cQgN6PZSlBcqNKtuqQOoAiTO4M
 kZNFi1XDmk1j2Fu6pLbAFc3bBOS1pKwXVE8pWN0+1jdnaD0movidx/e/X0CEhoM4VOGd
 xu1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW21Nup/WiPQWLthFaqhio0DPqhnmQoM/NG8XxoOYdmYXbp9VEORRC3Qw9Ueo9NFTjaETm9Q8xmXtnd@nongnu.org
X-Gm-Message-State: AOJu0Yw3fDdBlminWFsjbwGgE1Drdjl7HzFxLruFGoYw1cVX+Erhrvgn
 IjYBUyrp/zOSFqc89cVrfIr3porJ8cMLFfSNkKFPgzaPsm8IGjxoRpawFwf5vT/obolkVT4Vyl0
 uE0937VIRBHhZfd+7karhJwgHc36FSOTJfa8OJmgJzJKw6LbJTS6hjil/
X-Gm-Gg: ASbGncu/PrFdV8L3M0ZKV4DD89y/q50N2PBwluJ+RzOh5d0S9e5MVYAQf+X3uj7MY4e
 y/hXRqJXmqFHgEbXwYMhSeDTA8PXcZqnFczlE64EwNVIOk1OQ0wjmBegGntglX1VExFbCzIbRIb
 nejw+SHhL66c7ja7lob/kQodnuIkRLUtQ6y7OcE8Fwlufn2PAQMw71jWUJVfWG3cDDykIZwlAcP
 GC9bQDV3l+JiDtqe9tFBC0QNfP07cjPqvztw73x3C/GOhdafU3LuF2SHi/e4vped8cxrXKMoxt0
 7A1Q20bikSUPs/+XYg4/76zTibRT6zQG
X-Received: by 2002:a05:600c:1c1e:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4511ecb8a5emr104759025e9.7.1748962962939; 
 Tue, 03 Jun 2025 08:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi4DQhNBW/h3xz2Zi9Yh7jJ/P2tL+6llJyWEZWT0kzv9R1SMwo/y0LbTNv8nDFs2pEUk675A==
X-Received: by 2002:a05:600c:1c1e:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4511ecb8a5emr104758095e9.7.1748962962269; 
 Tue, 03 Jun 2025 08:02:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f83sm17948071f8f.49.2025.06.03.08.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:02:41 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:02:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org, Yanan Wang
 <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, John Snow
 <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
In-Reply-To: <aDad5elq0bgZ/tvp@intel.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
 <aDad5elq0bgZ/tvp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 28 May 2025 13:23:49 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote:
> > Date: Wed, 28 May 2025 10:09:56 +0800
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpu=
id
> >  field
> >=20
> > On 5/12/2025 4:39 PM, Philippe Mathieu-Daud=C3=A9 wrote: =20
> > > The X86CPU::check_cpuid boolean was only set in the
> > > pc_compat_2_4[] array, via the 'check=3Doff' property.
> > > We removed all machines using that array, lets remove
> > > that CPU property and simplify x86_cpu_realizefn(). =20
> >=20
> > No.
> >=20
> > We cannot do this. Because it changes the behavior of QEMU.
> >=20
> > 'check_cpuid' is true by default while 'enforce_cpuid' is false. So that
> > QEMU emits warnings in x86_cpu_filter_features() by default when user
> > requests unsupported CPU features. If remove "check" property and the
> > internal 'check_cpuid', QEMU will not do it unless user sets enforce_cp=
uid
> > explicitly. =20
>=20
> One option would be to have x86_cpu_filter_features() unconditionally
> turn on verbose and print warnings, but some people might want to turn
> off these warning prints, I don't know if anyone would, but it would be
> possible.
>=20
> The other option is still to keep the =E2=80=9Ccheck=E2=80=9D property.
>=20
> IMO, the latter option is the better way to reduce Philippe's burden.

we essentially loose warnings by default when some features aren't availabl=
e,
qemu still continues to run though.

Given that Daniel acked it from libvirt side, libvirt doesn't care about wa=
rnings
(it does its has its own cpu model calculation). Likely other mgmt do not c=
are
about it either, and if they do they probably doing something wrong and
should use QMP to get that data.
That leaves us with human users, for that case I'd say one should use
enforce_cpuid if feature availability matters.

so +1 to removal
=20
>=20
> Regards,
> Zhao
>=20
>=20


