Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8263C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTZ6-0001Nc-JW; Tue, 03 Jun 2025 11:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTZ0-0001HU-6x
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTYw-00087i-5i
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AE+1gvPEAmBWuwxAr+LLK+pYLokZawpsPaPYYiN5Ho4=;
 b=Iu6fIH/Jh2TlHS2ySg5GKqiahdykoNQiFYXdnIMptXMvqZErJj2WxtO7bO5/N9WyfyIxJw
 mCX/20ZnM0946uQO4fZsT6krW9g3ZS7tue5cp68fJh9QPA9iEDjkzkjf6yspXzmGy0cXGl
 Fsfoj9U1REO6hWPFE4DicILTs9kHqYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-lgKBLG6pPnCzjDVq-Q7HFA-1; Tue, 03 Jun 2025 11:28:17 -0400
X-MC-Unique: lgKBLG6pPnCzjDVq-Q7HFA-1
X-Mimecast-MFC-AGG-ID: lgKBLG6pPnCzjDVq-Q7HFA_1748964496
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so29987445e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964496; x=1749569296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AE+1gvPEAmBWuwxAr+LLK+pYLokZawpsPaPYYiN5Ho4=;
 b=citVIaSXBdyze4vp9Bx4ryybIBavfqYUjYN+AyromlIsdgRMkRux9R8Bdd+OcUil8j
 +9g9DD3OEls5typf3fHAo1SzRupvBNWn0Ilyb6XcpuHH+vJAWLXyKGfspPzwrLYNe3gB
 FYuw7GCjutmwD7IezT9SGxZyL/3AafO+QUziuw6EUn1rBwHvp/8BRQEhbnzMRvzFMHC5
 Ohd+pWAIfnNl6TThcSH9775XE35qsPNDVSrethkBItpLEmlAxtJ1Bx/L7kQ40EnNP0an
 H1d2uyjXTWTph5OYIbRrGTBbxs4iPITIOar5C6m39NEitqohlydkXcB+FDA7IKdKQWJd
 RLGQ==
X-Gm-Message-State: AOJu0YzboRtZy8joBntZvCoewzTP28wUfOcuwQ9y21h1ZbnKRicGC9JV
 ONjr4GsvqPppr85Jat5wsR0cXuKoQt9pD97XeSFP1No2aETKdI8bBGVmiCHFeC78vL90N+Onet5
 bR52TAqD8V3Vwev+wPPYRYh5xWGXN7vEuQxcR1hMDTnfEf16cEPgdHQmI
X-Gm-Gg: ASbGncsEwEKdcg7WKV2P5I0Kpb42b/Hw/JtNKB2qPnj/zrM4Rr9toaBEk+wwRv3Z1hX
 +af/DrjCGHoA8i2tmsHd1irGYZWmBuu9WYmhJ2RywljITkz051G8S53RCPBXySqkVqDzB00qH6U
 xjWGrYOBCMb9Le6CzzoPtwMQ+XpjEa/+MZ0ZXrxTw0G2NcMJwpcXVq2U2gAT4oQj7Fqn7Kpjdo0
 A5Pj1NQLQAQlpqS6uJ9kCFR6YVTqr05sQfiDBGxvR82y/jZ+G7uZ8bnKUPs5CpUyWcOm5/uYEFj
 hpt3HgZS9zQffqQGMZns7OIhVMAwMYtyyKpvsymMaMY=
X-Received: by 2002:a05:600c:a4d:b0:442:f482:c421 with SMTP id
 5b1f17b1804b1-450d654ff26mr126829335e9.22.1748964495650; 
 Tue, 03 Jun 2025 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQEUoazvRNc19Qs72cc7tuAGEEmvz0Y0yvIvJG1tutfXXXDLhRR3Rhhd/98DNTS3Px1O1V0g==
X-Received: by 2002:a05:600c:a4d:b0:442:f482:c421 with SMTP id
 5b1f17b1804b1-450d654ff26mr126829105e9.22.1748964495273; 
 Tue, 03 Jun 2025 08:28:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa21e4sm171130225e9.11.2025.06.03.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:28:14 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:28:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 05/18] hw/core/machine: Remove hw_compat_2_8[] array
Message-ID: <20250603172813.63bd1f55@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-6-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-6-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu,  1 May 2025 23:04:43 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The hw_compat_2_8[] array was only used by the pc-q35-2.8 and
> pc-i440fx-2.8 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/boards.h |  3 ---
>  hw/core/machine.c   | 14 --------------
>  2 files changed, 17 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 77707c4376a..84bd3735c42 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -835,7 +835,4 @@ extern const size_t hw_compat_2_10_len;
>  extern GlobalProperty hw_compat_2_9[];
>  extern const size_t hw_compat_2_9_len;
> =20
> -extern GlobalProperty hw_compat_2_8[];
> -extern const size_t hw_compat_2_8_len;
> -
>  #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bde19a2ff67..bc0606cf740 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -252,20 +252,6 @@ GlobalProperty hw_compat_2_9[] =3D {
>  };
>  const size_t hw_compat_2_9_len =3D G_N_ELEMENTS(hw_compat_2_9);
> =20
> -GlobalProperty hw_compat_2_8[] =3D {
> -    { "fw_cfg_mem", "x-file-slots", "0x10" },
> -    { "fw_cfg_io", "x-file-slots", "0x10" },
> -    { "pflash_cfi01", "old-multiple-chip-handling", "on" },
> -    { "pci-bridge", "shpc", "on" },
> -    { TYPE_PCI_DEVICE, "x-pcie-extcap-init", "off" },
> -    { "virtio-pci", "x-pcie-deverr-init", "off" },
> -    { "virtio-pci", "x-pcie-lnkctl-init", "off" },
> -    { "virtio-pci", "x-pcie-pm-init", "off" },
> -    { "cirrus-vga", "vgamem_mb", "8" },
> -    { "isa-cirrus-vga", "vgamem_mb", "8" },
> -};
> -const size_t hw_compat_2_8_len =3D G_N_ELEMENTS(hw_compat_2_8);
> -
>  MachineState *current_machine;
> =20
>  static char *machine_get_kernel(Object *obj, Error **errp)


