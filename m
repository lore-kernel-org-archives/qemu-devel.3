Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Hek-00071X-P9; Fri, 26 Apr 2024 05:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1s0Hei-0006v3-Cl
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1s0Heg-0004IC-SR
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714122845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzqgLx78EvlSfnqx+14UcMQjMPJVBXLZODD/QaXQlmY=;
 b=OMrHTEcvIalog/iFk6j99KqUnCPfG9dnIyDrvBQWCl1KE5g/ZsdewpmcVPK5h7sMAPuJ+h
 MMibD/d7E87mBOM7fiphVfPEaLja5SecCLs647O/dLE5DNa5vgZPrbDnH3zTOpiBNeK1MI
 C/4T5oCdRJhJMK5jg6rs59YYV1od1sQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Pn8we3oMN8eqA93S9DveDw-1; Fri, 26 Apr 2024 05:14:02 -0400
X-MC-Unique: Pn8we3oMN8eqA93S9DveDw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2dad70b6e03so13805281fa.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714122841; x=1714727641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzqgLx78EvlSfnqx+14UcMQjMPJVBXLZODD/QaXQlmY=;
 b=GRfgDKEoWDMEG6zm3K7kznPHfeOqPT/3O2RIxMk2JkQmKbuEHg/3sIlADbiskDzcNx
 JH4pA5c5X/V7QMY8gfiVwtuCM1hHf8QlzIMqk/K9ku+a9NMUm9+eczJ/IiaLguERvDLF
 m/VRVGli6dPqbvgXE9I18KWwT7DBwc+EkfbXZcpwAGFc0vFDWDZC1WaEiXO6Gjq9OEjO
 3JuAzdg40qrZ5PZv3fMBxDDJZ/ADlCaduDLrdHMpoUspFVIFNEhG9eZHbWmwEgUahTVh
 VkBcv3TbmLxgnCmF/ikEt9cB1XtjcbdHJDi6AM7odlMKCluCo5o/YQfCkleRp1v8Dkte
 Eq2w==
X-Gm-Message-State: AOJu0YzFQsU9LAA53MhZDuwXMuQwR7jAusUFw7BzYLkh96dTS1cAor2M
 hM2kESiukPPVzfTQuM545yQKe7iFQI17ADRjU3bdzbbwssa9kxEgnpSO4Eg+ipQzG+qJ7BmJ3gn
 cXuNic+9EhqCOLv2BitponKGMyx9ayC7u9CC0CWeqZTaV3h3FOtgybiZCVqQnbfrWesZevEPRhi
 W8P+bVstZiAKdhU++4S5kOdyUvoP4=
X-Received: by 2002:a2e:bc04:0:b0:2da:6f70:38b6 with SMTP id
 b4-20020a2ebc04000000b002da6f7038b6mr1648970ljf.35.1714122841400; 
 Fri, 26 Apr 2024 02:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9y/HWJwf1jpWocOFqS3oFX2RfA8othwHG4DUsGIedHQiE2uXXpDnExoVy2hS3AZfPwtIikJW4213sCNgc3kg=
X-Received: by 2002:a2e:bc04:0:b0:2da:6f70:38b6 with SMTP id
 b4-20020a2ebc04000000b002da6f7038b6mr1648951ljf.35.1714122841072; Fri, 26 Apr
 2024 02:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240420054606.13353-1-thuth@redhat.com>
In-Reply-To: <20240420054606.13353-1-thuth@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Fri, 26 Apr 2024 11:13:49 +0200
Message-ID: <CAMXpfWswsBtuaSXs_pK+-La2qeMrKSSU1JzmP_uCYp3rbxn0vw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove useless architecture prefix from the CPU list
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

This series has been successfully tested in x86. Execute the cpu help
command and check in the list the x86 prefix is no longer present.

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Sat, Apr 20, 2024 at 7:47=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> Printing an architecture prefix in front of each CPU name is not helpful
> at all: It is confusing for the users since they don't know whether they
> have to specify these letters for the "-cpu" parameter, too, and it also
> takes some precious space in the dense output of the CPU entries. Let's
> simply remove those now.
>
> Thomas Huth (3):
>   target/i386/cpu: Remove "x86" prefix from the CPU list
>   target/s390x/cpu_models: Rework the output of "-cpu help"
>   target/ppc/cpu_init: Remove "PowerPC" prefix from the CPU list
>
>  target/i386/cpu.c         | 2 +-
>  target/ppc/cpu_init.c     | 9 +++++----
>  target/s390x/cpu_models.c | 9 +++++----
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> --
> 2.44.0
>
>


