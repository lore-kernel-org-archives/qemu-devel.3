Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBF8C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turpj-0007U2-1P; Wed, 19 Mar 2025 07:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1turpS-0007TA-Mk
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1turpP-0001Hg-H2
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742384597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0ZwO+fCpD3t43mQctiP0uSbZ/+nn4frayCJIihuHKU=;
 b=IlEvhUNxMZlve8C9tiPc9kGzN3qc9GpeanHAEa/r6vtdE23NK4LaN08oAS+g5us32vVYr0
 LNSl8xBwP8M12y7YvE4w8nzb1zdgBPfo7o5h1KAQwV9flyTJJ0IOBYE1Yd9lYNaxTNrBw/
 a20V5yTrvYyGv9kaz3WZz7ib3yzZM6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-OwmizDLmORSXwQdVgA8EcA-1; Wed,
 19 Mar 2025 07:43:13 -0400
X-MC-Unique: OwmizDLmORSXwQdVgA8EcA-1
X-Mimecast-MFC-AGG-ID: OwmizDLmORSXwQdVgA8EcA_1742384592
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 230DB180025B; Wed, 19 Mar 2025 11:43:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16BED1828A83; Wed, 19 Mar 2025 11:43:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9399E18000AF; Wed, 19 Mar 2025 12:43:06 +0100 (CET)
Date: Wed, 19 Mar 2025 12:43:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 16/24] hw/uefi: add UEFI_VARS to Kconfig
Message-ID: <wugt4k6aqrrjs64ol5m5hbqhpuyivcn72duwmvf4wl3jfuufkf@nqaky6hv7bqs>
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-17-kraxel@redhat.com>
 <Z9qqLUJ-1KTKyJzX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9qqLUJ-1KTKyJzX@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 19, 2025 at 11:27:41AM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 04, 2025 at 01:48:04PM +0100, Gerd Hoffmann wrote:
> > diff --git a/hw/uefi/Kconfig b/hw/uefi/Kconfig
> > new file mode 100644
> > index 000000000000..ca6c2bc46a96
> > --- /dev/null
> > +++ b/hw/uefi/Kconfig
> > @@ -0,0 +1,3 @@
> > +config UEFI_VARS
> > +	bool
> > +        default y if X86_64 || AARCH64
> 
> RSICV64 uses UEFI too, is something extra needed before it can be
> enabled there too, as it would be desirable to introduce it on all
> UEFI targets concurrently.

Assuming riscv has a platform bus too a riscv version of patch #21
should do.  Also some work on the firmware side, but that can happen
independent from the qemu changes.

take care,
  Gerd


