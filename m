Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF8FF43691
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhID-0005RH-8o; Fri, 17 Apr 2026 07:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDhI9-0005PP-DZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDhI7-0002tB-Qn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776424998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFzOxyWFLCSliW6UgXZ/l/3J8XcP+Ks1WvE9FuQdRCE=;
 b=QrgIatFMtraLDCe3rQRZAQuCtssl7o/ceQcUdQniSIBVW9HU63lg2+2Q0ubGKZKhARqugT
 42SYk556AjVOhfFNpcOXplENDUrBaFlSVfyvYgeRTNkFRVHG2/I8HQDEnD2HAqk6+OMyMO
 VCf+MRSJbNwwwZZStYvM9l35WMZHMYg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-6wK4nqR7M7GrgIVwGyJ5bQ-1; Fri,
 17 Apr 2026 07:23:16 -0400
X-MC-Unique: 6wK4nqR7M7GrgIVwGyJ5bQ-1
X-Mimecast-MFC-AGG-ID: 6wK4nqR7M7GrgIVwGyJ5bQ_1776424996
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1C891800454; Fri, 17 Apr 2026 11:23:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60BFF180047F; Fri, 17 Apr 2026 11:23:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 008FA21E6A28; Fri, 17 Apr 2026 13:23:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,  Kashyap
 Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH 5/7] MAINTAINERS: Remove PhilMD from firmware sections
In-Reply-To: <20260417110550.70068-6-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 17 Apr 2026 13:05:47
 +0200")
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-6-philmd@linaro.org>
Date: Fri, 17 Apr 2026 13:23:12 +0200
Message-ID: <87tst9ltjz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> I'm not paid to support this code. I haven't followed
> it neither, so be fair and just remove myself.
> Demote the status to 'Odd Fixes'.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5e766ca6c9..df8413c79e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2837,9 +2837,8 @@ F: hw/usb/vt82c686-uhci-pci.c
>  F: include/hw/isa/vt82c686.h
>=20=20
>  Firmware configuration (fw_cfg)
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  R: Gerd Hoffmann <kraxel@redhat.com>
> -S: Supported
> +S: Odd Fixes
>  F: docs/specs/fw_cfg.rst
>  F: hw/nvram/fw_cfg*.c
>  F: stubs/fw_cfg.c
> @@ -3955,14 +3954,12 @@ F: docs/specs/fsi.rst
>  F: tests/qtest/aspeed_fsi-test.c
>=20=20
>  Firmware schema specifications
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  R: Daniel P. Berrange <berrange@redhat.com>
>  R: Kashyap Chamarthy <kchamart@redhat.com>
>  S: Maintained

Odd fixes?

>  F: docs/interop/firmware.json
>=20=20
>  EDK2 Firmware
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>  F: hw/i386/*ovmf*


