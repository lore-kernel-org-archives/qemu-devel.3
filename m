Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2B8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpwf-0000Ur-S2; Fri, 01 Aug 2025 09:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uhppM-0007t0-OP
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uhppL-0007qV-2n
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754054977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lmewEZCrbPA81DnV8etOkywIAyotgY3NAQv/G1bg1fA=;
 b=gpDF23ElyGfYsfww66/5eVTZ4ayFkipe7Y4DeXD0HpqDWpc7oD9S1ZjxSXJUiJAE3cAJqM
 f4OCk/bb8zE17ptnZKEj9pIlbIJvKC+vuEtJKpIME9WZyVlNViZb6gjtTxYz1s1JwLaNm7
 5q5PE8gmNazAwMdNPy5ZM0AyTqdakuM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-16xpGBfCP4SoFoSt5hRL5Q-1; Fri, 01 Aug 2025 09:29:36 -0400
X-MC-Unique: 16xpGBfCP4SoFoSt5hRL5Q-1
X-Mimecast-MFC-AGG-ID: 16xpGBfCP4SoFoSt5hRL5Q_1754054976
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fb5f71b363so19011916d6.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754054976; x=1754659776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmewEZCrbPA81DnV8etOkywIAyotgY3NAQv/G1bg1fA=;
 b=Trx626UFtPJRnbwvZiHkqNABuydOZ0qSyUP5CMdncF3GZTdV9kdSE0fbsbWb07/+xv
 /3bElSeQ7juVxAO0U0Q84as6djexHSUrjfOaS1ou58+iZ59VyVmW30p+sqbKYafAQXc0
 w39Ypxh7+GtUymOsLQuAUO9ZxCuQ+P2uFEt1laEYE85+VH5S27vivq2Vvt1MPHr7pYvE
 Glyg2o76rOycB5tMigExdGNYjh/RdWhCXksAm3g+MkMd+caEErgQH7bQRqNut6dS8lB+
 sP6eD+dcE9OLyWCIduF8fkJuq87EXVBlzpwaOKA48yKz8xbIVzK9tfgVm8xjz7rqLeBg
 7yYQ==
X-Gm-Message-State: AOJu0YzbSxD91EYOdomScHywFw/jftRiFa8RW0yckQo46j2+mGtMy4lz
 KEuJtuR2sSFPpuVb3i30RatRFsI4kE2AsWLQmaxnPdnSOREVqTiJ0Tvrs2y5bo35qE125vaAAdd
 1NnXbbwIZt9qDlQS0GNXk5IkGQXBhew4kxZvuj7ctUwB+PC/m0mUTB5oW
X-Gm-Gg: ASbGncvvR5Ls/j5PSX6IV1kpMDFxRHn/4ujB34j8erv6pSzXvn6exRO8sXpvLqKfQid
 IfRw45LzOmIY7Nync8Q2Bly8ZtuVebZPOUKvKvxNdxbdRerqS3+KDZVIW60VqD4c7lynAAkhsgN
 6z17Na/hhPZyGeXP6kX8PUlUCdQOwSUQrKbE4z+51yZzHzTlEnv1olW3xgelxAquZIcZh+f/FRQ
 1Zd9AmIx1EzF/+a8+LfPBLuelyOOubXgqjNx7L3u94i+NHlIBoqC4dkJIZTAla0QP1pjfURqFer
 qxLzHOkR8PPnzaFIzdo/P6Vwh7QzeL8U8OfT9pAsT7rptpuGr3P9V5047h1U+rFykxea2Zy3Lo1
 h4IKcpObFGJFt/8E=
X-Received: by 2002:a05:6214:5010:b0:707:5319:d3cd with SMTP id
 6a1803df08f44-70767456d88mr153309956d6.26.1754054975686; 
 Fri, 01 Aug 2025 06:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ8ToAMsglbHYpRcZgLaYN5tzVzmJDmaTYIhAxv45L0nYyuNc11U/0/zPOwZ+P9Zqoznt2yA==
X-Received: by 2002:a05:6214:5010:b0:707:5319:d3cd with SMTP id
 6a1803df08f44-70767456d88mr153309456d6.26.1754054975051; 
 Fri, 01 Aug 2025 06:29:35 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cde6f49sm21418436d6.72.2025.08.01.06.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:29:34 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:29:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC 1/2] hw/uefi: Add hardware-info ID for virtio mmio devices
 for SVSM
Message-ID: <ho3splx5lkooqwkthu7w32kxuwl3qnu7umjwl45ybdejy4rctm@odhcm5zxyskv>
References: <20250701121815.523896-1-osteffen@redhat.com>
 <20250701121815.523896-2-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701121815.523896-2-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 01, 2025 at 02:18:14PM +0200, Oliver Steffen wrote:
>Add a hardware-info device ID for virtio mmio devices intended for use by an SVSM.
>The ID has already been reserved in edk2, see edk2 commit f25e3d0d2c55.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> include/hw/uefi/hardware-info.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/hw/uefi/hardware-info.h b/include/hw/uefi/hardware-info.h
>index 94c38cff20..d688af0e8a 100644
>--- a/include/hw/uefi/hardware-info.h
>+++ b/include/hw/uefi/hardware-info.h
>@@ -14,6 +14,7 @@ typedef enum {
>     HardwareInfoTypeUndefined  = 0,
>     HardwareInfoTypeHostBridge = 1,
>     HardwareInfoQemuUefiVars   = 2,
>+    HardwareInfoVirtioMmioSvsm = 0x1000,

Can we use hexadecimal everywhere?

Which is basically the same for now, but I mean using the same format 
(0x0001, etc.). That said, I would probably do it in another cleanup 
patch.

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> } HARDWARE_INFO_TYPE;
>
> typedef struct {
>-- 
>2.50.0
>


