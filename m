Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93895C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 15:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIn6-00075N-4J; Fri, 12 Apr 2024 11:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rvIn4-000754-O5
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 11:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rvImp-00058K-DV
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 11:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712935554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QRMf4A9pdnITwrqT/648C2rZ4OGfHGeacWNc0Yevds=;
 b=er7+4Hwxd8orvAR9ZIXFEdH2AH8vvQV3RfgV7ZdWzkJENKe+lVj2P1vqqHf33SYL0s5wYc
 BYmVnps7edNKwmhFvIHaut1fIQK1pCifCkNGBmpEJfpbe7AVzWpsFmKpJ9HWOB6S1keWLk
 +5DUAaV+HjL5EY2TzYMQue2QL01wGlI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-meRXeSqcOmyrdieNc6Z0MA-1; Fri, 12 Apr 2024 11:25:52 -0400
X-MC-Unique: meRXeSqcOmyrdieNc6Z0MA-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-36a2a5027afso9877575ab.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 08:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712935550; x=1713540350;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4QRMf4A9pdnITwrqT/648C2rZ4OGfHGeacWNc0Yevds=;
 b=Yotz0kJM6Cj4PZBdrC4cGBgjZB4fPZcODImC6HpcZZTkAU4+fbMQchd0NIAeP0N5Ox
 kiIVskAju+usQ/7JNeYYXQQnLYcpQRGoQ2Zhmyx17Gv4E5Tj3OW3kZ5TX5qMjz2gzP0h
 qyNuv4QoLWbj2z5qg7kv7EDWpHE3J/S6nfBayzBIqfsVHyyUOO9IltTmDhEIOqzke/hj
 2JMoBiSSOSwrkcaNopAmW01iBFZ1AuCaWeS4qasaJXUQkFmAsiwx0+y/DF4rDSO30RbU
 44kzegDLekc0d+n7rFn8JlKClOc6qU+r2Va1ac8b8mNUiwWcnH0PDpRDSqFdcfqCHNfm
 2BQw==
X-Gm-Message-State: AOJu0Yw0sX75nyfVNSUN7M+ZcAT8f6H6IuTg9GDgQskXPoXZzQWda/Id
 wFLI8DXWJW/gI0bDHac682oEHVQicHf/GEy7tb2agnUSy48vDIrMOo0CK2VRDXZFsE+FIUKgZeI
 mCsUORJj6MpKz2Er2aT8CAP7PxoyHeJS2WPBOxQPDXUrUlqrNKCNz
X-Received: by 2002:a05:6e02:174a:b0:36a:2f18:109 with SMTP id
 y10-20020a056e02174a00b0036a2f180109mr3277890ill.4.1712935550721; 
 Fri, 12 Apr 2024 08:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg0+P5r9UzsiYEKaHFc1yEaUWdkxqbwVpnMzcH9433uUGLUE9JzhnKE/PYzm8WjyOpunktQA==
X-Received: by 2002:a05:6e02:174a:b0:36a:2f18:109 with SMTP id
 y10-20020a056e02174a00b0036a2f180109mr3277881ill.4.1712935550461; 
 Fri, 12 Apr 2024 08:25:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 l13-20020a056638144d00b004829e76a7c1sm1107539jad.172.2024.04.12.08.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 08:25:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:25:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 02/12] hw/vfio/pci: Replace sprintf() by g_strdup_printf()
Message-ID: <20240412092546.348163c0.alex.williamson@redhat.com>
In-Reply-To: <20240410160614.90627-3-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
 <20240410160614.90627-3-philmd@linaro.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 10 Apr 2024 18:06:03 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use g_strdup_printf()
> instead.

Isn't this code only compiled for Linux hosts?  Maybe still a valid
change, but the rationale seems irrelevant.  Thanks,

Alex

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/vfio/pci.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..cc3cc89122 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2442,10 +2442,9 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
> =20
>  bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>  {
> -    char tmp[13];
> -
> -    sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
> -            addr->bus, addr->slot, addr->function);
> +    g_autofree char *tmp =3D g_strdup_printf("%04x:%02x:%02x.%1x",
> +                                           addr->domain, addr->bus,
> +                                           addr->slot, addr->function);
> =20
>      return (strcmp(tmp, name) =3D=3D 0);
>  }


