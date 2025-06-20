Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90774C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWTG-0002ol-69; Fri, 20 Jun 2025 03:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSWTB-0002nV-EU
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSWT9-00034S-KQ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750405643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSzVx0A36/lS+sGsqB4jZLLzXavOOg7gRXGg5HazKDo=;
 b=KK90CjndNqCzvVn1Z+t6DOc56hzsCsSBccxo9+M08Hc38Uv8TW10ILc2WI8ahLAfRLpxJc
 QLmSvA5lvtpApR6O+W3b/+nAr3GaqTPEZ4DQFsBIgrY67PXfOhKLYP/rDiOKrd3bwNQgiw
 fiAFhn7N0ONxS0PPQFwOAIVZeR/OgO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-cARPrvKOO7yAyFJgfNXqeA-1; Fri, 20 Jun 2025 03:47:22 -0400
X-MC-Unique: cARPrvKOO7yAyFJgfNXqeA-1
X-Mimecast-MFC-AGG-ID: cARPrvKOO7yAyFJgfNXqeA_1750405641
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d64026baso9336055e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 00:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750405641; x=1751010441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSzVx0A36/lS+sGsqB4jZLLzXavOOg7gRXGg5HazKDo=;
 b=H/PLl51c6qPDHfpVhgqGpnFB9EQ3UR+9zqOqMXMui/IAMUO5maF/kkDZRD9EasR8UC
 g9i0Oz5n8ZDoLchVoU0tn4eXJkOyWpFbtVbKSfEsek7J+y5wQBSBZGkOjDTjWgb3IX2p
 NHICt1oZAqafPwA86tG3UAdehSIRSKeO46D6s3lR6Io8oZ6x+UYXy/QNSZRR7F057sV0
 7/lhMZNY7PQDRY3tY37IOYVOggotCucRE3RzeWQSC5TSw3949cOnW43+r4JRuOt5e0bE
 hdtqSFyJ2fUsOyYwqYh+MB8g/lJi37nEyvc2QRvRICZFsD0sv6uk3X+YF1Y2ScQuIRdx
 VC+g==
X-Gm-Message-State: AOJu0YyRI0lvu0kGELO+c+oZ7J3P9733COt5O48FPvyGBKjbax76MtUu
 fD8L3yI4tl71D3mmrqQIXbLDA1mkh58edli2E3HaEmLjGjrtxJ0qOwfmfNlQ241PJB1u4lcffTX
 Wdyalq5GBWcKbgykV4hs302/EQvUA8wy5vXMVQyqCiNcE1I+FVySriMyL7K+qhFrcLRt531Ubt5
 lUuMxbmPhVD9FKAYR1Rz+2nNC7WXLa+Z0=
X-Gm-Gg: ASbGncvloR068yOuudhxJyn8KRnBDUdTyeG+TgtIguRvmK6s64oP4Qy2iEtdgWm1qOS
 Dr7xvop1ldhZtYXYc1IHOSKOl5jZwzj5SVRsSyD99GG7xvePBdWPcs6t6ivmPlfz6R1jC2Vu1Yj
 52JnQ=
X-Received: by 2002:a05:6000:2104:b0:3a3:652d:1638 with SMTP id
 ffacd0b85a97d-3a6d132bf0bmr1166904f8f.48.1750405640891; 
 Fri, 20 Jun 2025 00:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvmHKlgdcMo9Jlt9bgnEWnspLNL948fmRdEd6NpaB+ZYxfgsXIPTNyy+XkdwpbE4eBlEeE79Ev/Z3Vnfftnx8=
X-Received: by 2002:a05:6000:2104:b0:3a3:652d:1638 with SMTP id
 ffacd0b85a97d-3a6d132bf0bmr1166893f8f.48.1750405640608; Fri, 20 Jun 2025
 00:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250619203351.393786-1-pbonzini@redhat.com>
 <20250619203351.393786-4-pbonzini@redhat.com>
 <c60001b3-12d2-4261-8b6b-a7bfaf4e71ff@intel.com>
In-Reply-To: <c60001b3-12d2-4261-8b6b-a7bfaf4e71ff@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jun 2025 09:47:09 +0200
X-Gm-Features: Ac12FXzKI1kP-9p65vUQT0zvwRvzuQom7gsbWauqAu-E5-Sh1gH_4we_zLYh9oA
Message-ID: <CABgObfYpkWDLtiJ3gAb8ouExON2q9BmB1NNMj6jyQ4Wh17rGKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>, 
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 20, 2025 at 8:47=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
> > +void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)
>
> The previous version of mine, defined the return type as int, because it
> wants to stop the QEMU when it hits the failure of
> address_space_read/write. However, this patch returns
> TDG_VP_VMCALL_INVALID_OPERAND to TD guest for such cases.
>
> Shouldn't the failure of address_space_read/write be treated as QEMU
> internal error?

The operands are provided by the guest, therefore I think it's an
invalid operand error.

Paolo


