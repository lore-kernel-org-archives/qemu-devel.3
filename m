Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A1C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyPb-000830-Kq; Thu, 08 May 2025 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCyPZ-00082W-By
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCyPX-0004k6-JY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746699805;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GscHLCL+LwuKkOa1ZCyj9Y+ZdNjmPUuW6VDPzihSLUw=;
 b=hmgS4vZDYkKb44I6Q70wKg7d2UmimF0MWMsJStkS0I/Smw94TdoUETEV2m6khJmeMMVtlu
 nbEEDoRF4X/azGgjcY/Xm6ae/rYSQ31Rxxahtg5n7jFxpOzHeAnSLXWRF6ibRsYA9sCLPj
 K9y++It/sPcLkugRRDHfPd2sXgKCZ/4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-A0j5GCKOPvy8_CbuE-9meA-1; Thu,
 08 May 2025 06:23:22 -0400
X-MC-Unique: A0j5GCKOPvy8_CbuE-9meA-1
X-Mimecast-MFC-AGG-ID: A0j5GCKOPvy8_CbuE-9meA_1746699800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65B78195608B; Thu,  8 May 2025 10:23:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6291C18003FD; Thu,  8 May 2025 10:23:16 +0000 (UTC)
Date: Thu, 8 May 2025 11:23:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 2/5] include/hw/boards: cope with dev/rc versions in
 deprecation checks
Message-ID: <aByGENuj1O-SJ_xG@redhat.com>
References: <20250506160024.2380244-1-berrange@redhat.com>
 <20250506160024.2380244-3-berrange@redhat.com>
 <09b0a1cf-afac-4308-89a2-cc22aba5699d@redhat.com>
 <aBxxHob9MK0BYHLw@redhat.com>
 <3b92958c-c99f-4c9c-96b6-c5fbaaec06fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b92958c-c99f-4c9c-96b6-c5fbaaec06fc@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Thu, May 08, 2025 at 12:21:20PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/5/25 10:53, Daniel P. Berrangé wrote:
> > On Thu, May 08, 2025 at 09:45:50AM +0200, Thomas Huth wrote:
> > > On 06/05/2025 18.00, Daniel P. Berrangé wrote:
> > > > When VERSION is set to a development snapshot (micro >= 50), or a release
> > > > candidate (micro >= 90) we have an off-by-1 in determining deprecation
> > > > and deletion thresholds for versioned machine types. In such cases we need
> > > > to use the next major/minor version in threshold checks.
> > > > 
> > > > This adapts the deprecation macros to do "next version" prediction when
> > > > seeing a dev/rc version number.
> > > > 
> > > > This ensures users of release candidates get an accurate view of machines
> > > > that will be deprecated/deleted in the final release.
> > > > 
> > > > This requires hardcoding our current release policy of 3 releases per
> > > > year, with a major bump at the start of each year, and that dev/rc
> > > > versions have micro >= 50.
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > >    include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
> > > >    1 file changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > FYI, this causes a failure in the CI now:
> > > 
> > >   https://gitlab.com/thuth/qemu/-/jobs/9965651507#L163
> 
> Ah, just noticed the same error msg:
> 
>   qemu-system-x86_64: unsupported machine type: "pc-q35-4.1"
> 
> > > 
> > > Looks like we have to remove the related subtest now?
> 
> Hmmm shouldn't we merge this series on top of up-to-4.1 machines
> removal?

There's no dependency on that series in general, just removal of the
test case. We need to remove that test case regardless, because our
machines will automatically remove registration of the machine type,
regardless of whether the code is deleted.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


