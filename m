Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B8606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzoXa5pS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J5nu4mXX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUfT-0003ug-6p; Thu, 12 Nov 2026 08:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRUf6-0003t4-Oj
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:16:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRUf5-0005wd-8n
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794489378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8oRAByFoKJXmpTZ5jJVR3hRS9o4iIIb7p8HTTWKKac=;
 b=fzoXa5pS/3K4ym/a53J/FHLRVkVAm9vYkAz94VcAkRhjdfpigNaabJeHFq1nLNwCjlGGgC
 2tvBe9/KoVBnUDx5qTtNuTxSmv0PQxA2wpAHPwQT6Y199peIMGqavtahQtgZ7wH/h5mXEJ
 FNYSyC+6DMlTuGonTqjpssPzXlKiKy8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-JrWAuzh7M0WchLF4joCQOw-1; Thu, 12 Nov 2026 08:16:16 -0500
X-MC-Unique: JrWAuzh7M0WchLF4joCQOw-1
X-Mimecast-MFC-AGG-ID: JrWAuzh7M0WchLF4joCQOw_1794489375
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab442d8d13so17187221fa.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794489375; x=1795094175; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b8oRAByFoKJXmpTZ5jJVR3hRS9o4iIIb7p8HTTWKKac=;
 b=J5nu4mXXrWMNukucRNZBEZu2yqz0yEKUOjnn49vTtljyKYukY59JVvowhilFhdov4w
 4m0jLSGXx1WhwWv5KLI7n7SBwOGLNJVcb0ZQgXiUTzmRskDXPmmiPDp/UBoIEdfF+//T
 WbaFekLJmTqah0zsNISZ9kIeQM8qhHZfBnwtKTPy4UohAGKyrmW30gFN+LQerHQyhwo1
 97LzcIRKGB9i+VxyUH6abCWgXvxuZKC+fq8H3gJqOPSG10+s7c4PlRTKvCAs/62p4dyo
 SUrkXuQwD9xZsMaV//POTDpCey5nXQxZhxJpyZB8CDv3bdIvcGHL1OzdXjV/BcBrik7B
 gVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489375; x=1795094175;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b8oRAByFoKJXmpTZ5jJVR3hRS9o4iIIb7p8HTTWKKac=;
 b=mQwDxLynvxyjSx7h4l7kckHmRWNoF/KVRiF3W9HyJonkRZgdwCI6IyHO/Mgeap7Uqy
 WSbEQ3XhWbySyJ5ZBdfyUo0SDOGKPbDt4mcBlukbJX+t8sjDgcPlauLO3GBxIHfVFeI5
 ZUIO15T5sXs4LxyHuHKWescZlvdxvJErBMOolD3dMsdcatQ5WggTl8d4QzWTwcEPzvgx
 x/Bd7XpH3aHslFM2KDjtjGTk1x2IbAoEPcWdOck/z/camLq4qxjHZEpeNBQyoKYTPaGP
 TpBp4IbXzCPbKNjgdmIo49npceLx55uDEKkNwn4H2bYyKmGuLjAdRfqVQPt2AWPlbYFR
 H3NQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFBscTBidZMBsex8xrqnKCRrXzZs6Cja1o6azEcjwh700UCdChefR+9fYrY/rkLk5pWjhWb4PBJZJPv@nongnu.org
X-Gm-Message-State: APuU4Z/TQSgb9v4GjHugpmPbLA3nJsn+zVH2uOULlwgdXJTKIG1ZLNXx
 /LwJuiRBjccK2zq7v6OwuWu+SPVDdsx9mMfICm2OLXEVEaWdn53BzahxqajmeiLJhEc2AhiC6Am
 S4BCaPI2IPQdYvpVLVbVcb409apkSYrmpq7qR/SkwggiCEfAyuD/2smcQ
X-Gm-Gg: AYBFou3QB23lkFKw6GcFVPOgkavM+0mdNYFqlaGJViJIGa3Nubh76KQZ7GDETAFKV1H
 DFdNQOUfmY79itu6cw3Qea8Zia/Qgmn+sW/ODtuXpobGORzI+/iqgYCBrCKgF+0Fuo60G19yxIX
 KY+/g2B+VgRl5qTYXmvJnddg1k/4+Ube5BwcXmc6A4yA0nCk/Hb/eXwmiQbU0eKFPg3p2g5Abt4
 hFz26y4HJ+uuJJZjk+EiY1lw98sQbrWY+4c6XvxMWgbQ18SN/CVUiQGOGgkc8nzpiwovSWHMxQN
 gU7Zpm1Wytl3FvYOTvjvJ81CbhdMn5x0NXvj39KPHih20HY6E+7hKVPEXHtr//lRUx/MaPF1I0+
 vsO/zdQ7aOs7IjyTBbm22Rt9XRpM4ywv3KJU=
X-Received: by 2002:a05:6512:104c:b0:5c1:4f2b:a2ba with SMTP id
 2adb3069b0e04-5c15d5cc5camr2169086e87.34.1794489374909; 
 Thu, 12 Nov 2026 05:16:14 -0800 (PST)
X-Received: by 2002:a05:6512:104c:b0:5c1:4f2b:a2ba with SMTP id
 2adb3069b0e04-5c15d5cc5camr2169068e87.34.1794489374416; 
 Thu, 12 Nov 2026 05:16:14 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983f7801bbsm16872708f8f.5.2026.11.12.05.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 05:16:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 14:16:13 +0100
Message-Id: <DMT9E5FFXV4F.30S48C3V0RC7W@redhat.com>
Cc: "Klaus Jensen" <k.jensen@samsung.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH 3/3] hw/nvme: fix broadcast fdp events handling
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Klaus Jensen" <its@irrelevant.dk>, <qemu-devel@nongnu.org>, "Keith
 Busch" <kbusch@kernel.org>, "Jesper Devantier" <foss@defmacro.it>,
 <qemu-block@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-3-69b3e5dcd5c8@samsung.com>
In-Reply-To: <20261112-nvme-for-rc-v1-3-69b3e5dcd5c8@samsung.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 10:53 AM CET, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> The Set Features handler for the FDP Events feature asserts that a
> namespace is passed in the command because the feature is
> namespace-specific. An invalid namespace is rejected prior to reaching
> the handler, but the "broadcast nsid" (0xFFFFFFFF) is considered valid
> and causes the assert to abort QEMU.
>
> Reject it with Invalid Field in Command instead as per the
> specification.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4792
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Fixes tag and QEMU stable in cc.

> ---
>  hw/nvme/ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a0d22dacedfa..71c24dc02b67 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6636,7 +6636,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtr=
l *n, NvmeNamespace *ns,
>      g_autofree uint8_t *events =3D NULL;
>      NvmeRuHandle *ruh =3D NULL;
> =20
> -    assert(ns);
> +    if (!ns) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> =20
>      if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
>          return NVME_FDP_DISABLED | NVME_DNR;

Thanks,
Tommaso


