Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC8BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZuS1-00008Y-OC; Fri, 02 Aug 2024 11:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZuRz-00007z-PT
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZuRx-0000VQ-QA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722613451;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y5xcLTmsoPoOM5+PdoDQBiXM1On4NZlcL/5GH9Qrm0=;
 b=JlfLONxQ5z4aiSp58+VLu4UzPCdziEClGs7pS7yA+J7uF6ai4E037/fPGupD9AEDZA3lG7
 K/RH6EGk+Vj1NsGYQQe7JWkt6gfrMBllDUskaRExw8RMnoKUqYMZmgelwvi7adZRt5M80z
 GHwLApFq5Uo43Vn8A2Ujumjj59HU+A0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-mAY63_3uMkqTZWlm0CaPqg-1; Fri,
 02 Aug 2024 11:44:07 -0400
X-MC-Unique: mAY63_3uMkqTZWlm0CaPqg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEF4C1954229; Fri,  2 Aug 2024 15:44:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 443E71955D47; Fri,  2 Aug 2024 15:44:03 +0000 (UTC)
Date: Fri, 2 Aug 2024 16:43:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 6/6] qapi: expose all schema features to code
Message-ID: <Zqz-v8wwfiF3BJe5@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-7-berrange@redhat.com>
 <87jzgzyqxi.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzgzyqxi.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 02, 2024 at 03:50:33PM +0200, Markus Armbruster wrote:
> Doesn't build for me:
> 
>     qapi/qapi-init-commands.c: In function ‘qmp_init_marshal’:
>     qapi/qapi-init-commands.c:70:84: error: ‘QAPI_FEATURE_ALLOW_WRITE_ONLY_OVERLAY’ undeclared (first use in this function)
>        70 |                          qmp_marshal_blockdev_snapshot, QCO_ALLOW_PRECONFIG, 1u << QAPI_FEATURE_ALLOW_WRITE_ONLY_OVERLAY);
>           |                                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     qapi/qapi-init-commands.c:70:84: note: each undeclared identifier is reported only once for each function it appears in
>     qapi/qapi-init-commands.c:464:70: error: ‘QAPI_FEATURE_SAVEVM_MONITOR_NODES’ undeclared (first use in this function)
>       464 |                          qmp_marshal_human_monitor_command, 0, 1u << QAPI_FEATURE_SAVEVM_MONITOR_NODES);
>           |                                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

IIUC, you are doing an patch-wise build. I see this error whe nbuilding
at patch 5, and its fixed by patch 6. These two patches have to be
squashed together really.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


