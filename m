Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470ABC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRXxr-0002Ny-Bx; Wed, 10 Jul 2024 10:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRXxp-0002MQ-RN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRXxn-0002Hn-J3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720620388;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cneCrluObtZcSknj7MJLIBnD46WLjl4GwT3EuXoVYcc=;
 b=ZbJhU/7+YwFn9De8OT05frdbjsd2xTvrq5lSMH49Czd3CXQEzjY5WNkAzvPXKR8s13pQAT
 xyBSdK+q0b7Uxuf42t9RuiHZCNV3iI6wWBn5SCocU8HLUbX9WiK1vt0TunBC8wGUKdtYQf
 FHMtIzQX1qNeghYuUvfkMQQo5TRYMgE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-2CyJqUkeMua7Na1e5sZfKA-1; Wed,
 10 Jul 2024 10:06:21 -0400
X-MC-Unique: 2CyJqUkeMua7Na1e5sZfKA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B6E1955F3B; Wed, 10 Jul 2024 14:06:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA0119560AE; Wed, 10 Jul 2024 14:06:13 +0000 (UTC)
Date: Wed, 10 Jul 2024 15:06:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
Message-ID: <Zo6VUns5ZOkuTlRA@redhat.com>
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
 <20240708-auto-v2-1-f4908b953f05@daynix.com>
 <20240708063152-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708063152-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 08, 2024 at 06:43:02AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 08, 2024 at 04:38:06PM +0900, Akihiko Odaki wrote:
> > DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
> > as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
> > is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
> > bool.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> There are a bunch of compatibility issues here.
> One is that PROP_BIT accepts different values:
> 
> 
> bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
> {
>     if (g_str_equal(value, "on") ||
>         g_str_equal(value, "yes") ||
>         g_str_equal(value, "true") ||
>         g_str_equal(value, "y")) {
>         *obj = true;
>         return true;
>     }
>     if (g_str_equal(value, "off") ||
>         g_str_equal(value, "no") ||
>         g_str_equal(value, "false") ||
>         g_str_equal(value, "n")) {
>         *obj = false;
>         return true;
>     }
> 
>     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
>                "'on' or 'off'");
>     return false;
> }

That's just in relation to the CLI string parsing behaviour.

It is also broken at the JSON level, since

   "rss": true

no longer works with device_add / -device JSON syntax.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


