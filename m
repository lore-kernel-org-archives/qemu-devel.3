Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC95F46C7F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 21:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wADYJ-0005Q2-Ta; Tue, 07 Apr 2026 17:01:40 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wADYA-0005Op-5g
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:01:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wADVv-0001K1-ER
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:59:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CBE15600AC;
 Tue,  7 Apr 2026 20:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A646C116C6;
 Tue,  7 Apr 2026 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775595550;
 bh=m+tZlWT6PpHFvAYmYtrq5ynvY8VedrOo9lnWAeHIrKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ig7dF6hcqibZeW771dYZ7twTcwvn4OoFe56i9+h+GNoyuOfp1GFeH1F2uFc5yLL+m
 FbfmYg86D/oro0Wx1pNVzWaYZSlA1bozpjJYnrEOUUdRCAgAQjqDaGMT7O0U6hc+gX
 5Em/pZN0hKxxowxAdlPlpUIG3bfw/xN9L2u/bGeZnHA78O7HZJZQO2mHI5xVDAVEuh
 49xiE1X5gE1XtLgJm9f84H4IEwPieI9/SQgPRgAUYBndfVZCIgd97iMzy9tTMl3Z2J
 MbXLAvM9dxi6+5c1nN+USulMdUFpOkGL8FVPe0ZMmh6WU/6p7Wz+YDsopBf3XsBsP5
 A1DiAC8vZgIxg==
Date: Tue, 7 Apr 2026 22:59:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 3/5] qapi: add monitor-add, monitor-remove,
 query-monitors commands
Message-ID: <20260407-erhitzen-anlaufen-ffbbd453251b@brauner>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <20260407-work-qmp-monitor-hotplug-v3-3-cb259800fffb@kernel.org>
 <adTgYYklczPVA40Q@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adTgYYklczPVA40Q@redhat.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 07, 2026 at 11:45:53AM +0100, Daniel P. Berrangé wrote:
> On Tue, Apr 07, 2026 at 09:32:47AM +0200, Christian Brauner wrote:
> > Add QMP commands for dynamic monitor lifecycle management:
> > 
> > - monitor-add: Create a QMP monitor on an existing chardev at runtime.
> >   The chardev must exist and not already have a frontend attached
> >   (enforced by qemu_chr_fe_init()).  The new monitor starts in
> >   capability negotiation mode.
> > 
> > - monitor-remove: Remove a dynamically-added monitor.  CLI-created
> >   monitors cannot be removed.  The removal sequence is:
> 
> Why should we block removal of statically created monitors ? Our
> normal approach is that the creation of objects via the command
> line & QMP be indistinguishable.

Sounds fine to me.

> 
> 
> > diff --git a/qapi/control.json b/qapi/control.json
> > index 9a5302193d..fd58b57c31 100644
> > --- a/qapi/control.json
> > +++ b/qapi/control.json
> > @@ -211,3 +211,107 @@
> >        '*pretty': 'bool',
> >        'chardev': 'str'
> >    } }
> > +
> > +##
> > +# @monitor-add:
> > +#
> > +# Add a QMP monitor on an existing character device backend.
> > +#
> > +# The chardev must already exist (created via chardev-add or CLI).
> > +# The monitor begins in capability negotiation mode -- the first
> > +# client to connect receives the QMP greeting.
> > +#
> > +# @id: Monitor identifier, must be unique among monitors
> > +#
> > +# @chardev: Name of the character device backend to attach to
> > +#
> > +# @pretty: Enable pretty-printing of QMP responses (default: false)
> > +#
> > +# Errors:
> > +#     - GenericError if @id is already in use
> > +#     - GenericError if @chardev does not exist
> > +#
> > +# Since: 11.0
> 
> We're just about to release 11.0, so 11.1 is the earliest
> opportunity to merge anything now.

I mostly copy-pasted this together. I honestly had no idea what the
current release cycle is.

> 
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "monitor-add",
> > +#          "arguments": { "id": "extra-qmp",
> > +#                         "chardev": "qmp-extra" } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'monitor-add',
> > +  'data': { 'id': 'str',
> > +            'chardev': 'str',
> > +            '*pretty': 'bool' } }
> > +
> > +##
> > +# @monitor-remove:
> > +#
> > +# Remove a dynamically added QMP monitor.
> > +#
> > +# The monitor must have been created via monitor-add.  Monitors
> > +# created via CLI options (-mon, -qmp) cannot be removed.  The
> > +# underlying chardev is NOT removed -- use chardev-remove separately
> > +# if desired.
> > +#
> > +# If a client is currently connected, the connection is dropped.
> > +#
> > +# @id: Monitor identifier as passed to monitor-add
> > +#
> > +# Errors:
> > +#     - GenericError if @id does not exist
> > +#     - GenericError if the monitor was not dynamically added
> 
> I don't think we need to include "GenericError" in the description.
> We've abandoned the idea of error classes in general, so everything
> is GenericError  except for a bit of historical cruft.

Ok.

> 
> > +#
> > +# Since: 11.0
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "monitor-remove",
> > +#          "arguments": { "id": "extra-qmp" } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'monitor-remove',
> > +  'data': { 'id': 'str' } }
> > +
> > +##
> > +# @MonitorInfo:
> > +#
> > +# Information about a QMP/HMP monitor.
> > +#
> > +# @id: Monitor identifier (absent for CLI-created monitors without
> > +#     an explicit id)
> 
> We can't make 'id' mandatory for the existing arg without breaking
> compat, but IMHO we should allocate an auto-generated 'id' if the
> user omits it.

Ok.

