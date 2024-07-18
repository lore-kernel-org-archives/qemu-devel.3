Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3C5C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURk4-00074F-Ua; Thu, 18 Jul 2024 10:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1sURjv-0006fN-SA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 10:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1sURjt-00008U-PB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 10:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721311447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcHRIfgwzVr/vbjvGC1hg3LzLrXmEZ1O8YCS6oyPmOs=;
 b=AFGJCql5i+tngDWmByw9JLD3KrgvNJNUZ62SE3WvHF6ydm/8q5F4/CYQbWh2TEKNEZnd+J
 C0u3HCzhJWFz2or0TJzQTlwqOFNLTo8x0HB//L6SXQnnwkGGx4tCjIMDGG4mLD0hnS5mDG
 xkrS+2VAmlroavnwFHrCAhCZ0WFI25g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-5cCPV1goNQa9HbrOOzrw9Q-1; Thu,
 18 Jul 2024 10:02:44 -0400
X-MC-Unique: 5cCPV1goNQa9HbrOOzrw9Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 230A01944B32; Thu, 18 Jul 2024 14:02:41 +0000 (UTC)
Received: from pinwheel (unknown [10.39.192.73])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938251955D48; Thu, 18 Jul 2024 14:02:37 +0000 (UTC)
Date: Thu, 18 Jul 2024 16:02:33 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v5 1/4] docs/interop/firmware.json: add new enum
 FirmwareFormat
Message-ID: <ZpkgPNz68Cd8E3hb@pinwheel>
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
 <20240718-qapi-firmware-json-v5-1-0dba12d7aaf5@linutronix.de>
 <877cdionhq.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cdionhq.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jul 18, 2024 at 03:09:37PM +0200, Markus Armbruster wrote:
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:

[...]

> > +#
> > +# @raw: Raw disk image format.
> > +#
> > +# @qcow2: QEMU image format.
> 
> It's not the only QEMU image format...  Maybe "The QCOW2 image format."
> Almost tautological, but I don't have better ideas.

For slightly less tautology, not sure these are any better:

    @raw: Disk image format that's plain and unstructured.

    @qcow2: Disk image format with support for copy-on-write and more.

[...]

-- 
/kashyap


