Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FA6C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 06:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2lS3-0001r4-31; Thu, 10 Apr 2025 02:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u2lS0-0001qk-GA
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u2lRx-0004iQ-CH
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744266701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2dz+s5bRTTUxzLOjQBd4OnQUS89uWhwMzuAtY1Qis4=;
 b=djmKAQXnSiQrkK3ZJW+GhhSGhpEGY/OIExpdX1VsW3tn6T5Tii9muaKYCwMJ9d5oCD9Gpa
 pygCKuIHXa7LWnjHyH+r4a05YB809VBpcbt18tJEAUvyXsMahu16CZJ0g4G6g3655Naaej
 hK5rC4RnUwqwqfxf9rHV8nmORSaRHYM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-CkNbQZgkMTCtIhUvzkUrYw-1; Thu, 10 Apr 2025 02:31:38 -0400
X-MC-Unique: CkNbQZgkMTCtIhUvzkUrYw-1
X-Mimecast-MFC-AGG-ID: CkNbQZgkMTCtIhUvzkUrYw_1744266697
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-225974c6272so4360615ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 23:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744266697; x=1744871497;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2dz+s5bRTTUxzLOjQBd4OnQUS89uWhwMzuAtY1Qis4=;
 b=HXfE/dsAn9zVWLeK1ePsoIsVUq+iSH9pb+1NnJvQgnLu9vDKbc1Y+WlZ6IYc8A3Sjv
 p4W6im3VhA4SfcmKCmkSBSaI05J2nUwPvbjmzrkpTWql1l0iRDxL4nSLnMxZyELh9NDR
 t+7eiGs+raKj3dp7ZxHTliSD31edfOyuDd+h2kudjHPVjR/wBvJUbG0tXoP1npdQ599M
 VRy8nA/vPh1IlCLd1ca4vuHr8SL+reUZBXm9lhkGcnDOFGqGLPchIgm4CA4FsGNDlW4Z
 y40KyW8SqeRV1nnF3QXAUWlT0da2C7rtsBHlpkliLGS60hXRtW7S+Y9sZED7gXTxmGsE
 y/+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9KibTS+N1+A/C7XfTVciZPVMNv92kNCVx9gWf+lQGct7/mM/ef9FCgM1WZkv4wENZ/2e1Ow55Qtx8@nongnu.org
X-Gm-Message-State: AOJu0Yy/yAZQ+MZd4krWW8yzJvKZiW9x0e2AFgFN8YKlWNsfD4xisEmC
 6Hv2eQDj05Axvb4/gvnKW+MCMaZYBamVrm71vfKC8Qwh6XNcO/WKryriWWomvUfxQt/A0YNNpLl
 Q05yht3LSxSdkdgetS7WVDI0tQ8Hd0A7Zsye5j06UiVQypXpT8iU6
X-Gm-Gg: ASbGncvX1HsG36vL5FWifv4Xf9CF5rM9LSEIQwptBQtmLXe/nY2UiOxRsUwa+jJSu44
 iiqaMFYCyIu/eDkb2fyR6hoRwpMeqXS1K+TprnzNyxqAFI+JWs4XPa4rkJn8+jmIi2oGfrWV8lO
 CDeA+cT4h7HYUphewuCH4aVeIrLYbNgIm4SQtpOVcmHMD0Dt9jMynaSp1w4JdvwHKiZEhsu5aZX
 nL9NHbUWCwziYg/Hn+bk2ovPO7tYkMJzqTUo/Mq/fd4sUV3EvFuBFjnsDzn00euV8MYmRF6sz/F
 nn0tHRvyQykZpOzbsAUkjbZnFqrn
X-Received: by 2002:a17:903:984:b0:223:fb95:b019 with SMTP id
 d9443c01a7336-22b7f9214bemr27411725ad.24.1744266697318; 
 Wed, 09 Apr 2025 23:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOiMJ6oFRZc0UIb7sH2FHdlqeVr/EWRRqgpsbKO3NFizN6rv5RIHlTXzLf5zCaPpKHhhGqZw==
X-Received: by 2002:a17:903:984:b0:223:fb95:b019 with SMTP id
 d9443c01a7336-22b7f9214bemr27411245ad.24.1744266696890; 
 Wed, 09 Apr 2025 23:31:36 -0700 (PDT)
Received: from smtpclient.apple ([115.96.147.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1e69320sm2456940b3a.159.2025.04.09.23.31.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Apr 2025 23:31:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aex5mpxcyybat5joqgvx4ssall53ksrfz3kkkpveso3jjosi4v@bofv3pqsgim4>
Date: Thu, 10 Apr 2025 12:01:18 +0530
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>,
 Alexander Graf <graf@amazon.com>,
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tsirkin <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A385A2F-EB29-4573-8458-C5762792DC96@redhat.com>
References: <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
 <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
 <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
 <CAAH4kHbFBekcmxBQcOA9K1Y+sFc2Jf56YEa4iv0M88ib7pCjgg@mail.gmail.com>
 <aex5mpxcyybat5joqgvx4ssall53ksrfz3kkkpveso3jjosi4v@bofv3pqsgim4>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 9 Apr 2025, at 11:51=E2=80=AFAM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>>> The chicken-and-egg problem arises if you go for hashing and want =
embed
>>> the igvm file in the UKI.
>>=20
>> I don't really see how signing the IGVM file for secure boot helps =
anything.
>=20
> It doesn't help indeed.  This comes from the original idea by Alex to
> simply add a firmware image to the UKI.  In that case the firmware is
> covered by the signature / hash, even though it is not needed.  Quite
> the contrary, it complicates things when we want ship db/dbx in the
> firmware image.
>=20
> So most likely the firmware will not be part of the main UKI.  Options
> for alternatives are using UKI add-ons,

But add-ons are also subjected to signature verification. How does not =
using the main UKI help?

> or simply ship a plain igvm
> file.  Details need to be sorted out (but they don't matter for the
> vmfwupdate interface design).
>=20
>> Do you need the UEFI_APPLICATION that uses the vmfwupdate interface =
to
>> be signed for secure boot? Seems unnecessary.
>=20
> Agree.
>=20
> take care,
>  Gerd
>=20


