Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVxR-0006Fc-0I; Fri, 07 Mar 2025 06:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqVxO-0006FP-DL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqVxM-00039G-J3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741347210;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADevMCHJEIMKlvEwgTr56VtTzAzVW8Xh5a/QyeE0JCI=;
 b=eOayppfzyTJw4TYLFKTNGzgJ2jSfydOCGM3y4AqrnmBhLghK/GPIVC8ADIuCMcadhaCcLy
 v5VRBwYyLU1O2i089BjNsiwZ+QwK2yiJhJMO3ZGdrRzEepeAVcuzwyLh5m9TJ24X633iCo
 VGZMtzdncunj7Q9qEeXWxMsEyZ76zDs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-ixiYgLpLO3SFxBDlQZbmtg-1; Fri,
 07 Mar 2025 06:33:29 -0500
X-MC-Unique: ixiYgLpLO3SFxBDlQZbmtg-1
X-Mimecast-MFC-AGG-ID: ixiYgLpLO3SFxBDlQZbmtg_1741347208
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EA9C1809CA3
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 11:33:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36E281956095; Fri,  7 Mar 2025 11:33:25 +0000 (UTC)
Date: Fri, 7 Mar 2025 11:33:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v4 00/11]
Message-ID: <Z8rZgkpZZtPONrJe@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
 <Z7NOjiz20gzBQhX5@redhat.com>
 <zymp5hndhvvb6qvomct4kytoyxwgjtienz5ahlb4fbbuyffqpm@6ttbn2mod64w>
 <ymk72bffcas5pzv5mmyo3ubgnyv72d2xepiinecaujocnizqil@i6tzfc3zgqwm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ymk72bffcas5pzv5mmyo3ubgnyv72d2xepiinecaujocnizqil@i6tzfc3zgqwm>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Mar 07, 2025 at 12:25:32PM +0100, Victor Toso wrote:
> Hi,
> 
> On Mon, Feb 17, 2025 at 05:52:49PM +0100, Victor Toso wrote:
> > On Mon, Feb 17, 2025 at 02:58:22PM +0000, Daniel P. Berrangé wrote:
> > > On Fri, Feb 14, 2025 at 09:29:33PM +0100, Victor Toso wrote:
> > > > ################
> > > > # Expectations #
> > > > ################
> > > > 
> > > > As is, this still is a PoC that works. I'd like to have the
> > > > generated code included in QEMU's gitlab [0] in order to
> > > > write library and tools on top. Initial version should be
> > > > considered alpha. Moving to beta/stable would require
> > > > functional libraries and tools, but this work needs to be
> > > > merged before one commit to that.
> > > 
> > > We don't need to overthink this. I don't think we're best
> > > served by continuing to post many more rounds of this series.
> > > Better to just get it into a dedicated git repo and iterate
> > > via pull requests IMHO.
> > 
> > Well, I'm happy to hear it. How the repo get created so we can
> > move the discussion and patches there?
> 
> Now that pluggable backend [0] was merged, I take that we should
> create a repo so I can submit a PR for to Go bindings. Who should
> we ping for this?

People who can create new repos are:

  https://gitlab.com/groups/qemu-project/-/group_members


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


