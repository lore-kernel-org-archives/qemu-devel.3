Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E625D41C30
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 10:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBAoZ-0005lA-Lh; Wed, 13 Nov 2024 05:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBAoV-0005kW-Bb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBAoT-00043j-Qm
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731494489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hc59rYI/xSj7t6kbwTR4B7hyVJRMDpac3lzSfGH1LsQ=;
 b=UTMgp+286FsXw6/2AP3w2P9Y6DTvlKYlHqyBc4+rs3mVOyuCALBzlVRwel5UuNy7zEI8/S
 WnKpizEsGPV5kjJ3pwifubrLFRDrCo5SI/6GSHk8RSnhkjwpeFVIeLR5eqLTVa/nQsi15R
 VcBvfBnDnBDyFOkbleBDQrU/co1sZA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-aXLJZo9KPfmxCHtb9TAgJg-1; Wed, 13 Nov 2024 05:41:24 -0500
X-MC-Unique: aXLJZo9KPfmxCHtb9TAgJg-1
X-Mimecast-MFC-AGG-ID: aXLJZo9KPfmxCHtb9TAgJg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso3616375e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 02:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731494484; x=1732099284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hc59rYI/xSj7t6kbwTR4B7hyVJRMDpac3lzSfGH1LsQ=;
 b=wsNgJaa+Nexiz9EYBhD1Y8dM6M38WJU0zDqPY52imVYLJBvxKmz4OG7IjLnW20iDdK
 pVtki3DeLeGNY5z0Yr2vlyQoCB2jSZ9Ctey4RUl4rP5iryFEWVMqIVZEWmabPxK/kl6X
 tz73HerxnaKZTtc6naYG+21VZgrzWEj4F2GQcYJJNLwAyC4Cu+RyZO7da1Qa+mSYX9hs
 WIzPEqCWyIsXush5+TdBx3TxcSkk6MjSWZRgA+7EN++kcO1+2QvkkPZ1ffySNGPTinNl
 gRwH5P1hen073Pnn8Nui/S5JcDdTTnj5HKZS4T2YlWqNdmnJiuQ7QggYiK9dRtQpBH8K
 i9fA==
X-Gm-Message-State: AOJu0YwVSPDxBvDaTqikfisA/J/l2uMPAbByZpNnG489PAGlxBb+wHvD
 BWmn4R7t7qESfUT8AxcsKoSvV0lT+H8a1detGORL7Y6zs83hPill+mqzF8TGhsTXhe4TF0w8++C
 fm58aFljlZsHDhGHSvACcmSIIk57yZxprwh+UPFp2N5GlT/X4fXlKT2A4TDxTjhvqBNsyKXDPOm
 tRNw7lzYeMB1B8q+CJLtsSC/gIxwQ=
X-Received: by 2002:a05:600c:1c10:b0:42c:b166:913 with SMTP id
 5b1f17b1804b1-432b74c112amr173840645e9.11.1731494483710; 
 Wed, 13 Nov 2024 02:41:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgzh/brct2L75BkWs2sABrBEz8jz93+16RxsagehyHvTUUSzWaZ0WVSWnBludkk+oR6qvnb+1IFmKq9DjLMO8=
X-Received: by 2002:a05:600c:1c10:b0:42c:b166:913 with SMTP id
 5b1f17b1804b1-432b74c112amr173840455e9.11.1731494483411; Wed, 13 Nov 2024
 02:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-2-pbonzini@redhat.com>
 <SY0P300MB102699E99096F482F06296EF95592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfb9ujpoRrNUUqyiAefSfTOWSV-SGmo2YrSoMdfxBeAD9A@mail.gmail.com>
 <SY0P300MB10263A5B33FAAEDCB04CDCD295592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <6e1fce37-4a22-4f36-9798-a424e4ba43d4@redhat.com>
 <ME0P300MB10400DF22DE6A86AA4E121BE955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB10400DF22DE6A86AA4E121BE955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 11:41:12 +0100
Message-ID: <CABgObfa_Azg87Ye_tYp2-G9Nah4U6S52HKSVTw65X_hzbo08xw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] rust: qemu_api: do not disable lints outside
 bindgen-generated code
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>, "Wolf,
 Kevin" <kwolf@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 13, 2024 at 7:52=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
> > A symbolic link seems to work too.  Thanks for the tip!
>
> Linux-based hosts should be fine. Should we test if symlinks also work
> on W32/W64 systems?

We already use symlinks for scripts/symlink-install-tree.py, fortunately.

Paolo


