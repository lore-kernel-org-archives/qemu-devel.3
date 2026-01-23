Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D595D7237F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjG6s-0002lC-99; Fri, 23 Jan 2026 07:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vjG6q-0002jL-1f
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vjG6o-00041n-9k
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3qSs6bHtQifn8upv1ijmcsrsTTVKM29z9gWwLUc5Q0=;
 b=I4IAj1re/csD3AGSwYgiyP3daXxPeNlIlB1PJ0/5toG0nDjDnGXhK0goZvtpCfWi+nhCNe
 mh4x/Ky5764hv282tKOWpJJkIlKEx7W36o1Hp087Wx7R3cFTnPTOL/qXbS4e17AkfmGyk4
 AFBPqXTB3wG2MW5oVIdlL2yRoKeLGmY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-c6Yd4E1GOzSxlKDy5WUqyA-1; Fri,
 23 Jan 2026 07:17:44 -0500
X-MC-Unique: c6Yd4E1GOzSxlKDy5WUqyA-1
X-Mimecast-MFC-AGG-ID: c6Yd4E1GOzSxlKDy5WUqyA_1769170663
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 811C518005B0; Fri, 23 Jan 2026 12:17:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.180])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE98A30002DC; Fri, 23 Jan 2026 12:17:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E19718003AA; Fri, 23 Jan 2026 13:17:40 +0100 (CET)
Date: Fri, 23 Jan 2026 13:17:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH 1/3] docs/interop: Add vtpm feature firmware.json
Message-ID: <aXNlruNcHc_JWXrH@sirius.home.kraxel.org>
References: <20260123083204.999920-1-osteffen@redhat.com>
 <20260123083204.999920-2-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123083204.999920-2-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 23, 2026 at 09:32:02AM +0100, Oliver Steffen wrote:
> Some firmwares provide a virtual (emulated) TPM device to the guest.
> Add a corresponding "vtpm" item to the FirmwareFeature enum to reflect
> that.

I'm wondering whenever it makes sense to be more specific here, i.e.
pick 'svsm-vtpm' as name, or even 'svsm-vtpm-ephemeral'.  Specifically
because a (future) vtpm with persistence has some additional
requirements such as some storage device for svsm, so libvirt needs to
know those details ...

take care,
  Gerd


