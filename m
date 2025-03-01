Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B76C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 15:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toOrC-0000Us-2o; Sat, 01 Mar 2025 10:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1toOr7-0000SJ-B4
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 10:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1toOr5-0002jv-Fm
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 10:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740843257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5y9cK7VneKio4mMbPh/RAMMXESA392aXIB6glLBvXNg=;
 b=QOEfye+4ZfC3Sj9xQ7iuOy+6Bq6ElNnBj4BYjOvr77xzMu5qTdnWI/0JMeEjl4CIIJ/hxD
 Hhaa0CQtEj0vMGIFpbJ6sg8eP4oOF/s1rJCOXr9jmpkzWwzzJ/2GqEgY/6Xh2yEjwXTpr4
 VBYImgQjpnpqFBFwWIBeLA6n6kn2JTo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-Pfy-r8aEOnivNcwGF15slQ-1; Sat, 01 Mar 2025 10:34:16 -0500
X-MC-Unique: Pfy-r8aEOnivNcwGF15slQ-1
X-Mimecast-MFC-AGG-ID: Pfy-r8aEOnivNcwGF15slQ_1740843255
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abbba16956bso378589866b.2
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 07:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740843255; x=1741448055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y9cK7VneKio4mMbPh/RAMMXESA392aXIB6glLBvXNg=;
 b=G2JCd6v7YJzVEKeCHvjxx9H+fo0Rq+saxHic2Y80UKlGAu0to1gHHMg7UJlHrBonCl
 Yz8NcrN9jvMr1QZts563N7a7XoVxf3bjiXRxYNBSauRnLO6mcPXf/myF8MDjvkZzNodz
 hL2ysHjY83dEFNAnuI//xrWxj2HNr7Y2HF+hOOHzk0ApvvODZ7vZVDsw+bFkrMOQ1aSQ
 iVuYfIMRzq6Jh8OX6YUkRkBCW+FbgBxrke/+Jz6S8Z9Me2lJ2qHQZROLTip6jnMa2LCC
 gauiS/y2QTRKXN+GNBLOfBfH3Kv0MHgD2CTCU5ODx8+gnDJ7UcJCClQw7oDFYlw9ixxb
 fp2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXmBn5SqH+x2blcn4IpaOiFc6rmw/jK3A8PttONlliKnoC09NzSlgBf1HTT9dQ3pg4VRP9FPrYcQwa@nongnu.org
X-Gm-Message-State: AOJu0Yzbl0r5Gxrq03QA1V/IMOpHA72AHuUAVSaI8ysTd1iOOSKo6qkL
 wxKKKlb2dd8bkvRmV3lj54jQlAxCNQ+70+CRp3CLiW8FQfjv0dN/oXfNu/Hc3MSk5sPwxJ8VYGY
 wpKkxtT3muepxCMZX3Znkupg738aBgXB8YozTzowe+dy/t+xAPwlRY+tYtHF6Is4BgfJGgff8AY
 2WsAYXBbi4bijm46rXdi8I5AiHcZI=
X-Gm-Gg: ASbGncvV1n34ZwLx2P1ki/CNMH7139yuKEtfHr4D41JcdP/5ohuOhJ76AEFVge6KwCW
 cRZxJdpCQwXngMYh/pvPzyevoUuRIQx1I3bdXZUzXYUnnXJebh4w723a3cUJiMeL70o8mgMJa
X-Received: by 2002:a17:907:97d1:b0:abb:eec3:3941 with SMTP id
 a640c23a62f3a-abf268225cdmr817044566b.45.1740843254748; 
 Sat, 01 Mar 2025 07:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGRSPr2S7ZEYmqYOFbz/qVnLpouthLO9PrIBRiDCjphzY3xtRIJd87m46t4KKeslQPRX90tXW0aPXSdsRkusU=
X-Received: by 2002:a17:907:97d1:b0:abb:eec3:3941 with SMTP id
 a640c23a62f3a-abf268225cdmr817040766b.45.1740843254384; Sat, 01 Mar 2025
 07:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20250220065326.312596-1-anisinha@redhat.com>
 <Z7bZBsqO6MxhFKVp@intel.com>
In-Reply-To: <Z7bZBsqO6MxhFKVp@intel.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 1 Mar 2025 21:04:03 +0530
X-Gm-Features: AQ5f1JqG9FyWblCwaF2xVHWtso_Yy1pTRGIVJghpM3c3q00UjitmYUy5zu6I8mw
Message-ID: <CAK3XEhM505AFFND17_SOOJnTPB+u2+hKXDdo01oyza9T1=H2ww@mail.gmail.com>
Subject: Re: [PATCH v2] microvm: do not use the lastest cpu version
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> On Thu, Feb 20, 2025 at 12:23:26PM +0530, Ani Sinha wrote:
> > Date: Thu, 20 Feb 2025 12:23:26 +0530
> > From: Ani Sinha <anisinha@redhat.com>
> > Subject: [PATCH v2] microvm: do not use the lastest cpu version
> > X-Mailer: git-send-email 2.45.2
> >
> > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > introduced 'default_cpu_version' for PCMachineClass. This created three
> > categories of CPU models:
> >  - Most unversioned CPU models would use version 1 by default.
> >  - For machines 4.0.1 and older that do not support cpu model aliases, =
a
> >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
> >  - It was thought that future machines would use the latest value of cp=
u
> >    versions corresponding to default_cpu_version value of
> >    CPU_VERSION_LATEST [1].
> >
> > All pc machines still use the default cpu version of 1 for
> > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > changes with time. Therefore, if machines use CPU_VERSION_LATEST, it wo=
uld
> > mean that over a period of time, for the same versioned machine type,
> > the cpu version would be different depending on what the latest was at =
that
> > time. This would break guests even when they use a constant specific
> > versioned machine type.
> > Additionally, microvm machines are not versioned anyway and therefore
> > there is no requirement to use the latest cpu model by default.
> > Let microvms use the non-versioned cpu model and remove all references
> > to CPU_VERSION_LATEST as there are no other users (nor we anticipate
> > future consumers of CPU_VERSION_LATEST).
> >
> > Those users who need spefific cpu versions can use explicit version in
> > the QEMU command line to select the specific cpu version desired.
> >
> > CI pipline does not break with this change.
> >
> > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> >
> > CC: imammedo@redhat.com
> > CC: zhao1.liu@intel.com
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Sergio Lopez <slp@redhat.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  hw/i386/microvm.c |  2 +-
> >  target/i386/cpu.c | 15 ---------------
> >  target/i386/cpu.h |  4 ----
> >  3 files changed, 1 insertion(+), 20 deletions(-)
> >
> > changelog:
> > v2: tags added, more explanation in the commit log.
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>

Who is picking this up?


