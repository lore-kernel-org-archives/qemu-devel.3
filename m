Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89AFC83F25
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 05:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueSLM-0006wA-D1; Wed, 23 Jul 2025 01:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSKp-0006t8-1R
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSKm-0000g0-7Q
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753249686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7b/O0vnM+psj2BnMAm8mvZutenuHSiT7n2oyU6SQsLk=;
 b=cgSMCOnQ5Q+CvjyEbnKqi4ivoD2EYcJ6RBQ8Y7Ev4LnQC/G2zh4ajUoXHDBLZub2XbUAlv
 eoUO8VhNo/EGiagI7BaJkQ19lcjUtNkg0Y60LSYPdh+Gi7+O3HwjYMAY76GZsvk4fsRBYE
 5LOPrsdEi2YLEy5wkyZWaMtpIDA0lUE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ggPauCPPOKaYcsIvsIxANA-1; Wed, 23 Jul 2025 01:48:04 -0400
X-MC-Unique: ggPauCPPOKaYcsIvsIxANA-1
X-Mimecast-MFC-AGG-ID: ggPauCPPOKaYcsIvsIxANA_1753249683
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-313d346dc8dso9581153a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 22:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753249683; x=1753854483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b/O0vnM+psj2BnMAm8mvZutenuHSiT7n2oyU6SQsLk=;
 b=XmywHzbRHVvfg1BTJZblx+amFWpUWmK/tqMN9552TRdI2wQ8t3TKt4upEsXA8g539F
 RFd9KOIBv6x7m+VWO+bJnGGgySX0N0APdREh7cIvqlIIiIRu30rA5O3wLohf4xiN9P9b
 QvmqFC9/AZbLqhKVLroXr5vtQr3LR83kwhBFKJ2jRLyuMFHG/OvHKqLp1G5H7OXlO9L4
 ivkIITum7vnlAC1ARajhg9xbzcQPBTJ8J3p9QZETN2hd5lIPkMdHrSiG1PkndLjOnptb
 fGhwaRiwigY0/bfZ00C9qjl5hx5rATwmX0ofH3r2Ho0kI7HI7uUJeYjH5TS/PUpUGaL1
 QkrQ==
X-Gm-Message-State: AOJu0YwVz6SYyWLQJ3ffIgrpZH+WGnU/+5I6OgMR58mFvSDTGMaLnt6j
 IF8TouZ1emcO/+OAzWdkVOTnMOb2yHv1Q5AXIdQmzIEhcM8YhhgwxAZmNBjFgCutOweElm/qaAE
 jBPdgvPYbWu6cpthTRP9yrOpL0KGb8dxJA0tL5nX5gg2416enV4Ov4oajLVG6VjZWCpDL+aKyRx
 8mc8t/BdNuu/3wQdFsPWRl8sntj9OzABU=
X-Gm-Gg: ASbGncsu0X+3oLKZccIUrOqgeNKLLLc15Bvj/cXE4ImGX0CJ6RVL7xIWdrSNUj8FLom
 gY9mIQv4noTfn0g0YKN7XQWelqf7Fqel+wQEF7PboRwV1PUO5JWE1JsEcQu+Ivp78bqGEhFnqLu
 c7YNwjPhe+ewiS4CdA/Rs=
X-Received: by 2002:a17:90b:5624:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-31e5082aee2mr2354245a91.23.1753249683191; 
 Tue, 22 Jul 2025 22:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPoMxYsNMPgcyyOsZnHDbOaU8qCUfT8+qjt3uI5DMVpHvwtla3QdY966iIWzZrG6I1gsxN4b5Fqb5p1ECtV7A=
X-Received: by 2002:a17:90b:5624:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-31e5082aee2mr2354227a91.23.1753249682823; Tue, 22 Jul 2025
 22:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <253cd85bc76ded8259fc9d12ed3764e2507bcb75.1752828082.git.pabeni@redhat.com>
 <CACGkMEvBr0dQdNqtYNdOT+oN13aOWh1Hob7C6NLbSKCcEDPtLg@mail.gmail.com>
 <6a1e2b06-4f4f-45b7-8875-ecb60f74aa8d@redhat.com>
In-Reply-To: <6a1e2b06-4f4f-45b7-8875-ecb60f74aa8d@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:47:52 +0800
X-Gm-Features: Ac12FXx3exO7Fhb94na-eE3uhqmw-U-oCfr-L8_DN7cWUTQz4JsQrHqyTE8berc
Message-ID: <CACGkMEvoNZp=bsV_VtsxCE1zKMpS=DdXZQ+-aVcwtb5tibTckg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 06/13] virtio-pci: implement support for extended
 features
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 22, 2025 at 3:37=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/22/25 5:28 AM, Jason Wang wrote:
> > On Fri, Jul 18, 2025 at 4:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> Extend the features configuration space to 128 bits, and allow the
> >> common read/write operation to access all of it.
> >>
> >> On migration, save the 128 bit version of the features only if the
> >> upper bits are non zero. Relay reset to clear all the feature
> >> space before load.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >
> > This is a guest noticeable behaviour change. I wonder if we need a
> > command line option to enable and disable this feature for migration
> > compatibility.
>
> This point is not clear to me, could you please elaborate a bit more? do
> you mean we need i.e. a DEFINE_PROP_BOOL() or the like to enable the 128
> bit space usage?

Yes, or maybe have a way to let the device to enable it automatically
E.g when UDP GSO is enabled for virtio-net.

Thanks

>
> Thanks,
>
> Paolo
>


