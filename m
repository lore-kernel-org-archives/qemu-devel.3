Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629A2C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0Vr-0003oL-SG; Tue, 26 Mar 2024 02:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0Vn-0003nx-9Q
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0Vl-0004KC-SO
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711435336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+rNV0B7COoxfRRucYCIuKri3hhNsoSigBLk9rxyEPE=;
 b=a2OdN0D7cx/oq1A3DWpFXctJRG18WfQvgoEeKItyO3UD5iGVSOeEAW8KmNRRlufV+63xW+
 62v48UdZbnuFMdAig9vc/SeXmpaBwTG3fH6aFlW5EAiDk/lYtHDCvJKkzxVfXAG9X8xIkh
 1fJQvfYG64UoOKmTezCj5h4c/OHkEmA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-pd3LikqZPU6E1kP_uCLOAg-1; Tue, 26 Mar 2024 02:42:14 -0400
X-MC-Unique: pd3LikqZPU6E1kP_uCLOAg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29dd9bfd4fdso4685696a91.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711435333; x=1712040133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+rNV0B7COoxfRRucYCIuKri3hhNsoSigBLk9rxyEPE=;
 b=Rg3wEuG9AJkm4n1PU3HHuhKxkRKQeKNeNl100Kwvuh293WKHPEcOVm//9uE0urUw5c
 D+ma57wz/4E6ZQX+1JWudnk2m50841l0QDYv4sZJZSbrdKXWUPkMa8R11SxUGgpAYyls
 IrIb4124bDofHWYKxYtmICPtUAPLCj6vkePrismkMHyEVk4vKegHVZvKUS1jrbQ97yUx
 +b2CZtQ+Zlc79jlXng7bbLrorp7HJY/UzIWHCL/G/mp/IPqGt7crXBqqt2MXhYU+bAue
 CwaF6TSpzHd4oc8NRCv2Bv+NczykctnwhT5NKcqFBqpZC2qSnlB5xGRTvPgBQIyz21V4
 lp6g==
X-Gm-Message-State: AOJu0Yz/pwUACPhnYe695c9tcYjkGGy29+vsfS6AcWuQuEAjs5ugmzSn
 XpFo8CRZ+eVJ/WmGl8ejD2h44RdaYF1rR+3xvizDRchUS4DO46M6zFwFUCaQGfXnu0euZisYqID
 MjHrVMzPo7V0aV+S9m+caMpZ91MKkNmLIHB7fZNxFAeqUlf060uM1UlwgSsEJUrqiX223siJEx3
 1bVvtkLBToYfapUQ3kvIHaDdZHOr6laxxxNzE=
X-Received: by 2002:a17:903:230e:b0:1e0:b75a:8f8b with SMTP id
 d14-20020a170903230e00b001e0b75a8f8bmr8207957plh.45.1711435333101; 
 Mon, 25 Mar 2024 23:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVV5P6fGOavhP6Feat4lAHox1t/OOoNukiLzi4djZ7c2sGzge7sH9tAblNf8ldfuDSVYYhTgCKKGH0h+00vyI=
X-Received: by 2002:a17:903:230e:b0:1e0:b75a:8f8b with SMTP id
 d14-20020a170903230e00b001e0b75a8f8bmr8207944plh.45.1711435332838; Mon, 25
 Mar 2024 23:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231219-glib-v1-0-1b040d286b91@daynix.com>
In-Reply-To: <20231219-glib-v1-0-1b040d286b91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:42:01 +0800
Message-ID: <CACGkMEsETOZnWkBpq95-no4_uP8QczsutEkK-GM_79_PKwajnA@mail.gmail.com>
Subject: Re: [PATCH 0/2] tap: Use g_spawn_sync() and
 g_spawn_check_wait_status()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

On Tue, Dec 19, 2023 at 7:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> g_spawn_sync() gives an informative message if it fails to execute
> the script instead of reporting exiting status 1.
>
> g_spawn_check_wait_status() also gives an message easier to understand
> than the raw value returned by waitpid().
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (2):
>       glib-compat: Define g_spawn_check_wait_status()
>       tap: Use g_spawn_sync() and g_spawn_check_wait_status()
>
>  include/glib-compat.h |  2 ++
>  net/tap.c             | 52 ++++++++++++++++++++++-----------------------=
------
>  2 files changed, 24 insertions(+), 30 deletions(-)
> ---
> base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
> change-id: 20231219-glib-034a34bb05d8
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>

I've queued this for 9.1

Thanks

>


