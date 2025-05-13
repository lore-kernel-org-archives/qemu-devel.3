Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A588C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEr2l-0002Xb-C3; Tue, 13 May 2025 10:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEr2j-0002We-RQ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEr2i-0002CM-62
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747148138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/bIxfqZFmAURnemTP/bWekDyGtYr+xzDa0Ake1DpkEQ=;
 b=UBQYD7LN1UlcqRiTrVSsPzoo3SQfhKMX/E9xVGU3FiGbrSsPxZrHI28/B6o3dUVEEQPjhy
 0BdxGKorzbBhkYyuLRkSjN+S2xw08GlazG+xUHcY3d49O/Z1chLtD8lrD0hYclWyhXBWLO
 9vu8JpxQijl/+/hT8wSHfTO597ExSZk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-_bFRkF-VM6y1HFYhXfU1AQ-1; Tue,
 13 May 2025 10:55:34 -0400
X-MC-Unique: _bFRkF-VM6y1HFYhXfU1AQ-1
X-Mimecast-MFC-AGG-ID: _bFRkF-VM6y1HFYhXfU1AQ_1747148132
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABD56180098C; Tue, 13 May 2025 14:55:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E95D41800359; Tue, 13 May 2025 14:55:28 +0000 (UTC)
Date: Tue, 13 May 2025 15:55:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
Message-ID: <aCNdXOVqi1xfzmDX@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <87y0v4zuec.fsf@pond.sub.org> <aCJAaawKsNFAtSmy@redhat.com>
 <26fb50ca-36fd-4aca-908c-272c5a109bac@linaro.org>
 <87v7q5gcuz.fsf@pond.sub.org>
 <61564c23-833c-4ea9-9d93-af6c5be95eb9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61564c23-833c-4ea9-9d93-af6c5be95eb9@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 13, 2025 at 07:36:03AM -0700, Pierrick Bouvier wrote:
> On 5/13/25 12:59 AM, Markus Armbruster wrote:
> > > Just for information, I'll apply a Signed-off-by with my name to all
> > > patches posted (including the ones I won't touch) simply because I use
> > > git rebase --signoff by default, and don't want to have to do this
> > > manually and selectively, as I work with a single master, with stacked
> > > branches and update-refs.
> > 
> > We actually expect you to add your S-o-B to patches that go through your
> > tree whether you changed them or not.
> > 
> 
> Oh ok, it's good then!
> I was thinking it was deserved to "I'm the author of this patch".

The first one means that.

Essentially the S-o-B lines form a chain tracing the flow of patches.
The first S-o-B will be the original author. Additional S-o-Bs will
be anyone who queued or modified the patch on its way into qemu.git.
Each additional one says that they trusted the person they got it
from and thus they're asserting compliance with the DCO at each step

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


