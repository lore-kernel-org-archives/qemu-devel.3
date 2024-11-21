Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A3D6E2A4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3y1-0002Mw-LD; Thu, 21 Nov 2024 04:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE3y0-0002Ma-3M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:59:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE3xy-0005hv-4j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732183151;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtCEN0HNedzetUTOAnieKdVaTi/hMeE9TxTYw8LGl7g=;
 b=RWf72cnVtmAHvXT51pkRq9GOs3Nx5CfFQgHSow2JQuPKeetKf3qWNm9lp0t3f7nWhXoSql
 ZWYHMyH02H9uOx4stYJ/HX/k1gXlGFXpe9M+aTCoFCWQsp1KGhEH+souYSVq+NJ9ipv7no
 cZUiO/njXrHC3s84OqeqCS78gGp1IJc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-wMPhofgRNg-L2v2SRcb6MQ-1; Thu,
 21 Nov 2024 04:59:06 -0500
X-MC-Unique: wMPhofgRNg-L2v2SRcb6MQ-1
X-Mimecast-MFC-AGG-ID: wMPhofgRNg-L2v2SRcb6MQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A36BC1954B02; Thu, 21 Nov 2024 09:59:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DBCA19560A3; Thu, 21 Nov 2024 09:58:58 +0000 (UTC)
Date: Thu, 21 Nov 2024 09:58:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: New "rme-guest" QEMU object addition
Message-ID: <Zz8EX70z9qyLcEQg@redhat.com>
References: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
 <Zz8DMob1P-ip0qN8@redhat.com>
 <8A08FAE0-3712-4EFD-A39F-3D39D92B8B07@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8A08FAE0-3712-4EFD-A39F-3D39D92B8B07@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 21, 2024 at 06:55:18PM +0900, Itaru Kitayama wrote:
> 
> 
> > On Nov 21, 2024, at 18:53, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Thu, Nov 21, 2024 at 02:34:24PM +0900, Itaru Kitayama wrote:
> >> Hi Jean, Mathieu,
> >> 
> >> I’ve been using you guys’ ccs/v3 QEMU for some time to bring
> >> up an Realm instance without a major issue, and as a one who
> >> is making changes libvirt to support CCA, I wonder if you
> >> could merge the v3 local changes under qap dir first so I
> >> can query the feature from libvirt?
> > 
> > Is the CCA host kernel support merged yet ?  As a general rule we would
> > not expect to merge QEMU support for a feature, until after the corresponding
> > kernel support is merged.
> > 
> 
> Ah, only the guest part. So now I understand.

You can still post PoC patches for libvirt based on the latest out of
tree QEMU code. We'll review them in the normal way, and then when the
kernel & QEMU stuff does merge, there'll be minimal further delay on
merging the libvirt side.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


