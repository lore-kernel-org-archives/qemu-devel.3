Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428AEE909C0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsMf1-0007lq-51; Tue, 17 Feb 2026 10:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsMep-0007ka-Q6
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsMel-0001sC-Ci
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771340788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E97BhVEkGS4yV2/iriRUh6aDfnZvXEEqK2r4Kj+pr00=;
 b=bzkQa8DrjABXAouNyrQFoj36jtprsbKzGeYMmOx2dt9ufDHvg0IZHrRxHNxbsMVDjHF9hL
 HNUmNxQvw1t8LNTMIHB/1qpDMTwvzH3YUNQoghgViAqGWCgpq/WyetNlb120WjxgO1HVRq
 6LBldWm88N4Ynvhs8IwI/ndWnes4bBs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-g5Nbt1mlOP20p4khGFKr1g-1; Tue,
 17 Feb 2026 10:06:26 -0500
X-MC-Unique: g5Nbt1mlOP20p4khGFKr1g-1
X-Mimecast-MFC-AGG-ID: g5Nbt1mlOP20p4khGFKr1g_1771340785
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2421718005B7; Tue, 17 Feb 2026 15:06:25 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.33.182])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA9D51800351; Tue, 17 Feb 2026 15:06:24 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id DD1F768963F; Tue, 17 Feb 2026 16:06:21 +0100 (CET)
Date: Tue, 17 Feb 2026 16:06:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 1/1] docs/interop/firmware: Add 'uefi-vars' member for
 FirmwareMappingMemory
Message-ID: <aZSDyBn2UAYmB8C-@dobby.home.kraxel.org>
References: <20260217131553.313772-1-abologna@redhat.com>
 <20260217131553.313772-2-abologna@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217131553.313772-2-abologna@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 17, 2026 at 02:15:53PM +0100, Andrea Bolognani wrote:
> This allows describing firmwares that are loaded as ROMs but also
> support a UEFI variable store. This is the case for edk2 builds
> that are set up to use the uefi-vars QEMU device, and whose
> descriptors would advertise the 'host-uefi-vars' feature.
> 
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Swapped v2+fixup for this.

take care,
  Gerd


