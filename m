Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F25CE909A9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsLg5-0000LH-0q; Tue, 17 Feb 2026 09:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsLg0-0000KU-F7
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsLfx-0007rO-BN
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771337018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qKSzX9R1m++tW24JaSFYE0RYvrFv5B3FXjyQ7uVCEx8=;
 b=XXdjHb2zay/GLdn1yVXs1g71mnfIliBYxMTiXFH22XmIN0eUPt8U+zw71/wzOVo9BgFQva
 Lxpnfdf2JyYU3D9dfDJ01Psjkff5SlkCaW0Rmtz2NzhJdC2WKroE7bKebEzU6ArzD3iAJ+
 EdWwYwcBYnq+OUOLF4mzdFDpGnnKlfw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-zzV-G9iyPV-nzrpX82_uQQ-1; Tue,
 17 Feb 2026 09:03:34 -0500
X-MC-Unique: zzV-G9iyPV-nzrpX82_uQQ-1
X-Mimecast-MFC-AGG-ID: zzV-G9iyPV-nzrpX82_uQQ_1771337014
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A86B51956054; Tue, 17 Feb 2026 14:03:33 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.45.226.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33CB81800348; Tue, 17 Feb 2026 14:03:33 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id EF26F685FF5; Tue, 17 Feb 2026 12:37:15 +0100 (CET)
Date: Tue, 17 Feb 2026 12:37:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/1] docs/interop/firmware: Add 'uefi-vars' member for
 FirmwareMappingMemory
Message-ID: <aZRStq9gJVoe9JkT@dobby.home.kraxel.org>
References: <20260209133906.294720-1-abologna@redhat.com>
 <20260209133906.294720-2-abologna@redhat.com>
 <87seazn3ep.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87seazn3ep.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 17, 2026 at 10:08:14AM +0100, Markus Armbruster wrote:
> 
> (Since 11.0) and indent like this, please:
> 
>    # @uefi-vars: Information specific to firmware builds that expect the
>    #     "uefi-vars" device to be used to provide access to the UEFI
>    #     variable store.  If the mapping contains this member, the
>    #     firmware descriptor should advertise the @uefi interface from
>    #     @FirmwareOSInterface as well as the @host-uefi-vars feature
>    #     from @FirmwareFeature.  (Since 11.0)

Fixed up and queued.

take care,
  Gerd
  


