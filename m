Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D310C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtrk-0000Z9-L5; Thu, 25 Jul 2024 04:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtri-0000Xs-Up
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtrh-0000ip-BI
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721896220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrET2FWXfqn+GL+YgrPfdt/Xo/QDFQz+aHxS5Sr1res=;
 b=ZoeN//RWAUKPrIZSA44afnN07P0QrvB18MJhGnSfFvWlV3qm1jaxKHbecKEKI9If23xEAe
 s68M+F9tegdWUpJFCSCQW/79rStFmf4GTHDgLK3yL9D/dDN1kzQLIVwsxvMwyLJnkhRqcL
 f+lrtxQpnUwfEuaRL9Q650r6IWNbt1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-1UMNgMq0NiOteQtxsm18QA-1; Thu, 25 Jul 2024 04:30:17 -0400
X-MC-Unique: 1UMNgMq0NiOteQtxsm18QA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3688010b3bfso507529f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 01:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721896216; x=1722501016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrET2FWXfqn+GL+YgrPfdt/Xo/QDFQz+aHxS5Sr1res=;
 b=MKqAjkBYnK5ch5TlsXytqC0max6D4O7JHOBB0E5rKp1r8615hMA2jSgZUEw3X41hkO
 aRALqfMGggAJi8cwipeDs4kMnAJ+Bxzba37vT5Wg3pEk0VDU3Eh9ql8K60hdr+PF6nAM
 itottmMym8atSiWejaa+LhuU+osBcwgWGNBxOETzSxlJdmoKoTMMrAKtsEx6pYxQDnyB
 +TAa9gITyxP2H8JEwaUC/f/5J2fEYhXu6buwb8aTloBFBRgbSxpreCkZVY/Lbbqa+n7V
 NB9j+O7u/CWQaFc8aPW8OLV3OlHirTrmxoa7Vpqpt+xQT/hBfYEMZj3ig21EbqSkbX4L
 A5HA==
X-Gm-Message-State: AOJu0Yy8R1mUZRM37KSgQMx+iTGUGX3og+1+HW/dAt8uHaDX4czIB/BK
 Dhh9Kxs3+laHEOMw4SjJTVADwh9OL51jPqgH27HrL52g6nV60d4UBXUbB6X7CGVepSV3D3i6R6b
 E+LLXw2/rqxoW5WmwLE8cJc09ScH+eYzf7ZdH3j9iIDa+5CdCMCaP
X-Received: by 2002:a5d:648c:0:b0:368:6f64:307c with SMTP id
 ffacd0b85a97d-36b363c46dfmr1286278f8f.15.1721896216671; 
 Thu, 25 Jul 2024 01:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBsSIU8riW1ndq18DdyS6pv10t8S4hQbIQkP/ZzniGLF1hJ3hWP+RNhTGxECf77fklyk/rjw==
X-Received: by 2002:a5d:648c:0:b0:368:6f64:307c with SMTP id
 ffacd0b85a97d-36b363c46dfmr1285234f8f.15.1721896198769; 
 Thu, 25 Jul 2024 01:29:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b368638fbsm1319686f8f.103.2024.07.25.01.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:29:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:29:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
Message-ID: <20240725102957.29a133ea@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

On Thu, 13 Jun 2024 18:30:14 +0100
Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:

> Hi all,
> 
> This series implemented S3 and S4 sleep for loongarch virt machine
> and microvm.
> 
> For loongarch/virt a kernel patch is requried [1].
> 
> [1]: https://lore.kernel.org/loongarch/20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com/

series also should include arm/virt patch to enable this
as it's another user of GED

> 
> Please review.
> Thanks
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (3):
>       acpi/ged: Implement S3 and S4 sleep
>       hw/loongarch/virt: Wire up S3 and S4 sleep
>       hw/i386/microvm: Wire up S3 and S4 sleep
> 
>  hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
>  hw/i386/acpi-microvm.c                 | 18 +++++++++
>  hw/i386/microvm.c                      |  3 ++
>  hw/loongarch/acpi-build.c              | 18 +++++++++
>  hw/loongarch/virt.c                    |  3 ++
>  include/hw/acpi/generic_event_device.h | 12 +++++-
>  6 files changed, 115 insertions(+), 9 deletions(-)
> ---
> base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
> change-id: 20240613-loongarch64-sleep-37b2466b8d76
> 
> Best regards,


