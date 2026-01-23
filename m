Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2938ED7237D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjG9q-0004Qi-Ii; Fri, 23 Jan 2026 07:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vjG80-0003aD-Gi
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vjG7x-0004Ot-Ee
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l96kqEoHtSdb+30/O5ouVYirh3ek9WjBD39dgjMtKag=;
 b=gFWrPfSP8WP+kfzpvjtn2dOG44fD4HH8o1xeJVlF2s/vSgn1Ta9Xg+QJ9lO3XW+Yxj0seC
 aAFsvOO1WMfRPB5/SRFQ9f+KPGLDXmFjzWzLHnHPP0hXGovQnrK98eoDtO+IH4gQo+WJdk
 Vjmh91gNM6L4PeSIAytgPSxnHfiFg/I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-TE0rQWgZPhuIbEu0d1tOQw-1; Fri,
 23 Jan 2026 07:18:55 -0500
X-MC-Unique: TE0rQWgZPhuIbEu0d1tOQw-1
X-Mimecast-MFC-AGG-ID: TE0rQWgZPhuIbEu0d1tOQw_1769170734
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CCF018005B5; Fri, 23 Jan 2026 12:18:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.180])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB9EF1800665; Fri, 23 Jan 2026 12:18:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 98B0118003AA; Fri, 23 Jan 2026 13:18:51 +0100 (CET)
Date: Fri, 23 Jan 2026 13:18:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH 2/3] docs/interop: Add AMD SEV-SNP SVSM interface to
 firmware.json
Message-ID: <aXNm6IPvqH0xgjtL@sirius.home.kraxel.org>
References: <20260123083204.999920-1-osteffen@redhat.com>
 <20260123083204.999920-3-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123083204.999920-3-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

On Fri, Jan 23, 2026 at 09:32:03AM +0100, Oliver Steffen wrote:
> AMD SEV-SNP defines a guest to Secure VM Service Module (SVSM) firmware
> [1] interface. Add a corresponding item to the FirmwareOSInterface
> enum.
> 
> [1]
> https://docs.amd.com/api/khub/documents/Al5Q~fSl~kWKkJ3zC0vk_g/content
> 
> Signed-off-by: Oliver Steffen <osteffen@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


