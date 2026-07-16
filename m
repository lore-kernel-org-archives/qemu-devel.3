Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23925C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJ0f-0000z5-00; Thu, 16 Jul 2026 06:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkJ0d-0000yb-4p
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkJ0a-0003jS-Cl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784196477;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QB3Vl3jIxBhDyn9lEie2A5ENiZxJIkk0EUQBCTPCu4Q=;
 b=cO9VGsttFzwVv7E2qH2FRfBifAKT5U7e9i6NBoMq4lXezw9eSKNUObJwM2pGPn3yu52sS2
 8eMfESkuoeGTR4DrxCuA+0F5ybUmY5Y6sDYJ6mEs8XKpHSXLk3egZh4t9V9WNpZGs39NKK
 XI01gWuvK9vdOQbAS4uKiZgyDf8yihM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-BYRdOszWOXmvmdJOyDE40A-1; Thu,
 16 Jul 2026 06:07:55 -0400
X-MC-Unique: BYRdOszWOXmvmdJOyDE40A-1
X-Mimecast-MFC-AGG-ID: BYRdOszWOXmvmdJOyDE40A_1784196474
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04D881956068; Thu, 16 Jul 2026 10:07:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6B163003EFD; Thu, 16 Jul 2026 10:07:51 +0000 (UTC)
Date: Thu, 16 Jul 2026 11:07:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] gitlab: introduce files mapping GitLab accounts
 to real names
Message-ID: <alitczlegqIl-UIh@redhat.com>
References: <20260715154029.1216464-1-berrange@redhat.com>
 <20260715154029.1216464-2-berrange@redhat.com>
 <87se5k3xoo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87se5k3xoo.fsf@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 15, 2026 at 03:38:47PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > It is desirable to be able to discover the GitLab account handle
> > assocaited with a real name in the MAINTAINERS file.
> >
> > Rather that duplicating the same account handle multiple times,
> > inline with the MAINTAINERS file entries, this introduces mapping
> > files:
> >
> >   * .gitlab-map-auto - data automatically queried from GitLab
> >     using the 'glab' tool and REST API
> >   * .gitlab-map-manual - manual overrides/augmentation for
> >     cases where the MAINTAINERS real name does not match the
> >     GitLab account real name
> >
> > The former would need refreshing when we add new MAINTAINERS
> > entries, if the person had to be added as a GitLab account
> > member. For this purpose scripts/gitlab-map-update can be
> > used, assuming the user has the 'glab' client tool present
> > and configured with an access token.
> >
> > To audit how many maintainers have GitLab handles present/missing
> > scripts/gitlab-map-check can run a report.
> >
> >   $ ./scripts/gitlab-map-check
> >   Missing GitLab handle for maintainer 'Akihiko Odaki'
> >   Missing GitLab handle for maintainer 'Albert Esteve'
> >   ....
> >   Missing GitLab handle for maintainer 'Zhenzhong Duan'
> >   Missing GitLab handle for maintainer 'Zhuoying Cai'
> >   GitLab handles missing: 158 / present: 68
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


> > +# the GitLab account real name. As such...
> > +
> > +# ...all gitlab handles in .gitlab-map-manual must also exist
> > +# in .gitlab-map-auto and ....
> > +for HANDLE in $(grep -v '^#' .gitlab-map-manual | awk '{print $1}')
> > +do
> > +    grep -E "^$HANDLE\s" .gitlab-map-auto >/dev/null
> > +    if test $? != 0
> > +    then
> > +	echo "Unexpected GitLab handle '$HANDLE' is not a member"
> > +    fi
> > +done
> > +
> > +# ...and all realnames in .gitlab-map-manual must also
> > +# exist in MAINTAINERS
> > +grep -v '^#' .gitlab-map-manual | \
> > +awk '{ saved = $1; $1 = ""; print substr($0, 2) }' | \
> 
> Is 'saved' doing anything here?

No, it is left over cruft after my experiments with
getting the right logic.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


