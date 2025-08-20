Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8501CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohij-0002C4-3V; Wed, 20 Aug 2025 08:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uohiT-0002AH-T2
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uohiQ-0000pM-HO
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755692092;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP64gk8SOdqT/LFxqY0iDJBiyivIT295bgTsypE1PP8=;
 b=KC56J2ReObkMb1bQUCFRv/Pu5YnMc1YEp+le0q6p2Wpo203+CSLSHV53Vpr345psjCDfVS
 nc3XD4YrQ48XLgKoInXiX1kUWUocaFMELvFsSK+U12FMMt+II8wezNrZlKwJ+KDVvvvysJ
 IwAvzGJesTz4uFKY+11u1p2uPKqnqS8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-Go_jOvwdOveEy8hNE-tXLQ-1; Wed,
 20 Aug 2025 08:14:50 -0400
X-MC-Unique: Go_jOvwdOveEy8hNE-tXLQ-1
X-Mimecast-MFC-AGG-ID: Go_jOvwdOveEy8hNE-tXLQ_1755692090
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A453C197753E; Wed, 20 Aug 2025 12:14:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC55519560B0; Wed, 20 Aug 2025 12:14:47 +0000 (UTC)
Date: Wed, 20 Aug 2025 13:14:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Message-ID: <aKW8NABFH8g-NCkx@redhat.com>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
 <20250806150539.2871-2-tanishdesai37@gmail.com>
 <aJOpG5XuWHYZUQ4c@redhat.com>
 <46c5fbcb-9aec-4f9e-984a-b2f255210007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46c5fbcb-9aec-4f9e-984a-b2f255210007@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 12:35:39PM +0200, Paolo Bonzini wrote:
> On 8/6/25 21:13, Daniel P. Berrangé wrote:
> > It is best to have new functionality added in a separate commit
> > from the removal of obsolete code.
> 
> My mistake - when Tanish and I "un-rebased" these patches from on top of
> yours, we placed the removal of the "nocheck" functions in patch 1 instead
> of patch 2 where it made more sense.
> 
> > I've co-incidentally got removal of this obsolete code in the
> > tracing test suite series I posted, so one will need to be
> > rebased on top of the other, depending on what order Stefan
> > wants to take the patches.
> 
> If the main blocker (the /dev/stdout issue) is fixed quickly, your patches
> should go in first because they aid in reviewing this one.

I posted a new version that drops the stdout patch

  https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg02716.html

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


