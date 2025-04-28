Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75284C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Jzk-00011u-8r; Mon, 28 Apr 2025 04:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9Jzf-0000qW-5A
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9Jza-00048o-NC
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745829452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gnTckmOK0vSIhVB03YJKiFvsjQYRAEDW9Ouw8N7bVw=;
 b=ZWF9Hl3WzfJg+7cO/q/qcpoqewjSlYRs1v+8gPpy2xAN7e1XNBkL+muVC7wa7ADZx7iuez
 l3p9GMf08Z9mMKhceYWEIFB6o+VXx2rTljlt8lvfUbApA/ss8EDD6nZLicDE7F5kL59w05
 f2ChZdjZvLqq4jSXR110hAgsEdp1TY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-B1obPjlNN9ehRFkezdd6lg-1; Mon,
 28 Apr 2025 04:37:27 -0400
X-MC-Unique: B1obPjlNN9ehRFkezdd6lg-1
X-Mimecast-MFC-AGG-ID: B1obPjlNN9ehRFkezdd6lg_1745829446
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA0F31800263; Mon, 28 Apr 2025 08:37:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.151])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02158180045C; Mon, 28 Apr 2025 08:37:21 +0000 (UTC)
Date: Mon, 28 Apr 2025 09:37:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 stefanha@redhat.com, Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aA8-PjcGmMrGqXGK@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <aAs6Q2GiBUbUCc2I@redhat.com>
 <65639a73-c6d7-472f-8788-69341f93760d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65639a73-c6d7-472f-8788-69341f93760d@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 25, 2025 at 01:39:49PM -0700, Pierrick Bouvier wrote:
> On 4/25/25 00:35, Daniel P. Berrangé wrote:
> > On Thu, Apr 24, 2025 at 11:33:47AM -0700, Pierrick Bouvier wrote:
> > > Feedback
> > > ========
> > > 
> > > The goal of this series is to be spark a conversation around following topics:
> > > 
> > > - Would you be open to such an approach? (expose all code, and restrict commands
> > >    registered at runtime only for specific targets)
> > 
> > QMP defines a public API between QEMU and external mgmt apps, and personally I
> > like the idea that the API exposed is identical across all binaries and thus
> > the API becomes independent of the impl choice of combined vs separate binaries,.
> > 
> > > - Are there unexpected consequences for libvirt or other consumers to expose
> > >    more definitions than what we have now?
> > 
> > QEMU used the selective hiding of commands in the QMP schema as a mechanism
> > to allow mgmt apps to probe for supported features. We need to check usage
> > of each QMP API feature that's behind a TARGET_* condition and identify
> > which libvirt uses as a feature probe, then come up with a strategy for how
> > best to handle each case in libvirt in future. We might need some additional
> > runtime mechanism to probe for certain things, but we won't know until we
> > look at things in more detail.
> > 
> 
> Could we consider to hide the concerned commands from introspection related
> commands as well? The same way we prevent those commands to be registered,
> we can probably prevent them from being visible for libvirt.
> The code would still be there, and compiled once, but based on runtime
> target_X() value, it would not appear in introspected schema.
> 
> I'm not sure how all this is implemented from QAPI code generator, maybe
> it's hard to do something like this, if we build the schema at compile time
> for instance.
> 
> > > - Would you recommend another approach instead? I experimented with having per
> > >    target generated files, but we still need to expose quite a lot in headers, so
> > >    my opinion is that it's much more complicated for zero benefit. As well, the
> > >    code size impact is more than negligible, so the simpler, the better.
> > 
> > IMHO it is unfortunate that the API we currently expose has a dependency on
> > a specific impl choice that mgmt apps are expected to rely on for feature
> > probing. An ideal API design is not so closely coupled to impl choice
> > (separate vs combined binaries), and would expose enough functionality
> > such that mgmt apps continue to work regardless of the impl choices.
> > 
> 
> At this point, do we know which kind of "feature" gets probed? Is it only
> the list of commands available, or is there probes based on enum/struct
> definition?

In general if it is visible from QMP it is liable to get probed - any
and every aspect of it is in scope.

To figure this out you need to produce a list of each command/struct/field
that has a 'if $TARGET' conditional, and check whether libvirt uses it or
not.

> > We thought the conditionals were a good thing when we first designed QMP
> > this way. We ended up using two distinct classes of conditionals, one
> > reflecting build time features and one reflecting which target binary is
> > used. I don't think we fully contemplated the implications that the latter
> > set of conditionals would have on our ability to change our impl approach
> > in future. I think the proposal here is taking us in a good direction
> > given what we now know.
> > 
> 
> Thanks for considering an alternative way given the new needs, that's
> appreciated.
> 
> Would that possible to get some help from people from libvirt or QAPI
> developers for this?

There challenge here is how QEMU will change this without back compat
problems.

Our deprecation process won't work well here. There's no nice way to flag
up that we're about to change the way conditionals work.

Most of the time libvirt adapts by changing the way we "probe the data",
but in this case its about adapting to the way we "probe data about the
data".

This kind of problem is why I liked the previous idea that Phillippe
was trying of introducing a "qemu-system-any" - it didn't affect the
behaviour of existing qemu-system-$TARGET commands, so apps had a
clean line in the sand between old & new behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


