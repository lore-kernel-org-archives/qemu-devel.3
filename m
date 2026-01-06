Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E12C47BEA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd5F3-0004Ar-0B; Tue, 06 Jan 2026 06:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vd5F1-00049g-GM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vd5Ez-00007J-En
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767698924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMwEua+98XF9igP68OY/Yae7V3fSQ4wuzTGsqccIc8E=;
 b=cfiXCEaO5M6OAy18ONHIobnBT+9p0XF7o5okLzYkcMkN1AQRzN7aiHRGUioyPQLSDFutpc
 P/yrvJl0dcNolVpoVmmCwzaIOUmKA9VaJHswoVqZcfvVaXgWNz4QR368iAtdMb/G0+S/8v
 Lh8Yw9RUegbsetVRTPI4tll6CR+boGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-xsDbrfHcP8eJbpjSc1FC6g-1; Tue,
 06 Jan 2026 06:28:43 -0500
X-MC-Unique: xsDbrfHcP8eJbpjSc1FC6g-1
X-Mimecast-MFC-AGG-ID: xsDbrfHcP8eJbpjSc1FC6g_1767698922
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07D601956058; Tue,  6 Jan 2026 11:28:42 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.32.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 503CC180035A; Tue,  6 Jan 2026 11:28:41 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id A554F620790; Tue, 06 Jan 2026 12:28:38 +0100 (CET)
Date: Tue, 6 Jan 2026 12:28:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] docs/interop/firmware: Introduce extended syntax for
 FirmwareMappingMemory
Message-ID: <aVzs_6lD5XJhCn0H@dobby.home.kraxel.org>
References: <20251228232649.1708400-1-abologna@redhat.com>
 <20251228232649.1708400-3-abologna@redhat.com>
 <aVvNV0X0uZ4lVBWv@redhat.com>
 <aVzbqk5FSrG9rSuM@dobby.home.kraxel.org>
 <aVzliFd70KWKcMJR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVzliFd70KWKcMJR@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  Hi,

> > Maybe have separate json files describing the variable store template
> > only, and expect libvirt searching for one in case the firmware
> > descriptor has the 'host-uefi-vars' feature flag set?
> 
> Or just have the host-uefi-vars feature flag alone, and then libvirt
> can just invoke virt-firmware in whatever way it needs to create the
> json templates and not worry about providing any pre-defined json
> files.  All the default microsoft CAs are ultimately embedded in
> virt-firmware and spat out when given the right args.

Makes sense too, given that the long-term plan is to do that anyway to
allow distro-specific varstore setups.  So doing that right from the
start, only without the certificate configuration part which comes
later, looks like good approach too.

BTW: virt-firmware-rs.rpm has a utility (virt-fw-vars-setup) which can
do exactly that without pulling in python as dependency.

Question is how we enable/disable secure boot then ... 

One option would be to special-case the enrolled-keys feature for the
host-uefi-vars.  A little bit hackish, but with the advantage that the
switch would be transparent for libvirt users, existing xml syntax
continues to work.

Another option would be to add xml syntax for varstore setup, which will
be needed anyway in the future for the custom certificate setup.

take care,
  Gerd


