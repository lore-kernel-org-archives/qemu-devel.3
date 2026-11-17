Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA0606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F2z4rXSH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTG8Z-0004h4-OZ; Tue, 17 Nov 2026 05:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTG8Y-0004fx-0U
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTG8W-0005xr-Af
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794910199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=AaVz058lMGmnbTjiBP8fE/tv9B0zTzbDiwZDIcrCyrc=;
 b=F2z4rXSHFDNvAbvgRe3vDeOErFoyBc5XxGzn09M+j/zNOjyTMM3wgLy8koFaW3n76P1NrB
 3BVhoDn8f+wbRSvHDSZdhg21lQf31zvCHHKebMTbZqwBFCZ5GLvQkRiQ85/HUL2BNN5DB8
 Zj+IrCcKktXNOD1AkKGNnAUXbTOb8c0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-fEyicn2fO2-k64Yef2X4Ow-1; Tue,
 17 Nov 2026 05:09:54 -0500
X-MC-Unique: fEyicn2fO2-k64Yef2X4Ow-1
X-Mimecast-MFC-AGG-ID: fEyicn2fO2-k64Yef2X4Ow_1794910194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1C1D1955F44
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:09:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 688DC180054B
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:09:53 +0000 (UTC)
Date: Tue, 17 Nov 2026 10:09:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: System emulator security boundary policy now enforceable
Message-ID: <avwn7izLPHpSmVun@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the latest pull request of mine that is merged, we now have
the mechanism for enforcement of the QEMU security boundary policy
with annotations completed across QOM classes for machine types,
devices and accelerators.

For a bug disclosure affecting a system emulator to be accepted
as a security flaw the reproducer scenario must now pass without
warnings when adding the '-compat insecure-input' flag.

For example:

 $ qemu-system-x86_64 -compat insecure-input=warn
 qemu-system-x86_64: warning: Insecure QOM type tcg-accel accepted by policy

 $ qemu-system-x86_64 -compat insecure-input=warn -machine isapc -device ne2k_isa
 qemu-system-x86_64: warning: Insecure QOM type isapc-machine accepted by policy
 qemu-system-x86_64: warning: Insecure QOM type tcg-accel accepted by policy
 qemu-system-x86_64: -device ne2k_isa: warning: Insecure QOM type ne2k_isa accepted by policy

Alternatively you can have QEMU crash on the first violation

 $ qemu-system-x86_64 -compat insecure-input=reject -machine isapc -device ne2k_isa
 qemu-system-x86_64: Insecure QOM type isapc-machine disabled by policy
 This type does does not provide a security boundary to protect against untrusted data or actions


When triaging an incoming disclosure affecting system emulators
please use this mechanism as the primary guide for whether to
handle it as a security flaw with a CVE assignment request, or
merely a normal public bug.

This mechanism is intended as authoritative, while the security.rst
docs describing virtualization vs non-virtualization use cases are
merely a high level approximation.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


