Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED5F34C54
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHtE-0000Vh-CL; Mon, 13 Apr 2026 10:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wCHtC-0000VB-Mj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wCHtA-0005hD-Jl
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776089022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VVfnciyxcekFDZDSENjcUVJRromxpt6QXZktKucBFJw=;
 b=K9ubi/wQWVKrtD1jRuZqndgnisjp8csAgcsQsCvdxXHD9c0BlRgKiXFIH04+GV6geTBZ1R
 GFDtsLyRJiu/YrZB/NVdZLiae7/HeWGOr6jl0XERucu3uDA5Iv333ycBgYK39GRl66GtKQ
 wGrO7IepN/Kg5IEmxgfE0IDnWZkDbLc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-URLytdUeNXuBl8W9twJR3Q-1; Mon,
 13 Apr 2026 10:03:38 -0400
X-MC-Unique: URLytdUeNXuBl8W9twJR3Q-1
X-Mimecast-MFC-AGG-ID: URLytdUeNXuBl8W9twJR3Q_1776089017
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7C021956094; Mon, 13 Apr 2026 14:03:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11C1E180035F; Mon, 13 Apr 2026 14:03:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E0D6D180078A; Mon, 13 Apr 2026 16:03:33 +0200 (CEST)
Date: Mon, 13 Apr 2026 16:03:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org,
 Oliver Steffen <osteffen@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
Message-ID: <adzucwBFU3u1HWnm@sirius.home.kraxel.org>
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
 <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
 <CAFEAcA-dTkoKs0tgF+VV0PayFbDcmH_t64P6AOT18ShwEKTW_g@mail.gmail.com>
 <adyZm41cp_nZHPYj@sirius.home.kraxel.org>
 <CAFEAcA-pZCrti_==m2u-Kq55dmqBcs8S=Ztns8moBxSe2fV+ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-pZCrti_==m2u-Kq55dmqBcs8S=Ztns8moBxSe2fV+ug@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> > I'd very much prefer to use device tree.  A device property is maybe
> > not the best choice.  There is this /chosen node though which is
> > already used to pass around guest configuration information (kernel
> > command line for example).  Maybe we can add properties there?
> 
> Sure, if you can get consensus on a device tree binding for
> it and get that documented in the kernel's Documentation/devicetree
> then we can implement something.

Documentation/devicetree/usage-model.rst (which documents 'bootargs' +
'initrd-*' properties in '/chosen' too) says:

   The chosen node may also optionally contain an arbitrary number
   of additional properties for platform-specific configuration data.

> But fw-cfg seems to me to be a much better fit, and it has
> the advantage that it requires no changes to QEMU at all.

On the firmware side fdt is easier because that needs to be parsed
anyway to find the serial ports, and the firmware also checks
whenever stdout-path exists in /chosen.

Adding a -chosen name=${property},string=${value} command line arg
to qemu should not be too much of a problem, no?

take care,
  Gerd


