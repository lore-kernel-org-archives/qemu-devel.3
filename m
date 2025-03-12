Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DADC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJb0-0005qu-9e; Wed, 12 Mar 2025 06:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsJay-0005qR-Am
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsJaw-0003db-LU
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741776348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hAwtOBYrQjQ/21KJAiNDSbnvNwjg765Ie6xrmEoTXT8=;
 b=Clrqz8LTyPip0jLHhm9MJQE0ubVfXKET0deUIsU75/MJGhHTkyOaORsmFPLGXGdmTmOdcD
 Q7BmuiP3w1I2zkrLrtfnFhMYAOJLaP05hGEczndHztC6xi13tIgnJmvlSlk0VD8LBFTKuA
 37zEmoAKJ0gU0UnvF2IQFpZD3D7bAFM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-TMhtWcjvPqC0XJZ2DTA1gA-1; Wed,
 12 Mar 2025 06:45:42 -0400
X-MC-Unique: TMhtWcjvPqC0XJZ2DTA1gA-1
X-Mimecast-MFC-AGG-ID: TMhtWcjvPqC0XJZ2DTA1gA_1741776341
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20EFE1800D9F; Wed, 12 Mar 2025 10:45:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 519EC30001A2; Wed, 12 Mar 2025 10:45:37 +0000 (UTC)
Date: Wed, 12 Mar 2025 10:45:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Bibo Mao <maobibo@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Giving your own patches your Reviewed-by
Message-ID: <Z9FlzR5xkTe1aOuW@redhat.com>
References: <878qpamvk6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qpamvk6.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 12, 2025 at 10:45:29AM +0100, Markus Armbruster wrote:
> I stumbled over commits that carry the author's Reviewed-by.
> 
> There may be cases where the recorded author isn't the lone author, and
> the recorded author did some meaningful review of the patch's parts that
> are not theirs.  Mind that we do need all authors to provide their
> Signed-off-by.
> 
> When the only Signed-off-by is from the recorded author, and there's
> also their Reviewed-by, the Reviewed-by is almost certainly bogus.
> 
> Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
> help reduce the accident rate :)

Is a commit with S-o-B and R-b from the matching author semantically any
different from a commit with an author S-o-B and NO other 3rd party tag
at all ?

The latter seems to be the more common case, with over a thousand examples
of commits with no 3rd party NNN-By tags.

$ cat > no-3rd-party.pl <<EOF
#!/usr/bin/perl

my @tags;
my $commit;
my $author;
while (<>) {
    if (/^commit ([a-z0-9]+)$/) {
	if (defined $commit) {
	    my $ok = 0;
	    foreach my $name (@tags) {
		if ($name ne $author) {
		    $ok = 1;
		    last;
		}
	    }
	    if (! $ok) {
		print ("$commit: $author\n");
	    }
	}
	
	$commit = $1;
	@tags = ();
    } elsif (/^Author:\s+(.*)$/) {
	$author = $1;
    } elsif (/\s+(Signed-off-by|Acked-by|Reviewed-by):\s+(.*)$/) {
	push @tags, $2;
    }
}
EOF
$ git log --no-merges --since 'two years ago'| perl no-rb.pl | wc -l
1296

That is 8% of all commits in 2 years seemingly having no 3rd party
review.

Pretty much all of our core maintainers have commits exhibiting this,
so I won't include any names.

Some of these will be just a case of forgetting to copy the R-bs
from the list.

I suspect most are just a case of a maintainer making a pragmmatic
judgement call to merge something having given up waiting for review,
and not wanting to badger people into reviewing.

Most appear to be fairly trivial patches which is good. So that 8% of
commits is probably at least an order of magnitude less lines of code
changed in that timeframe, and the less "risky" code at that.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


