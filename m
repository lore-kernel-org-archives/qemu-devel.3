Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB36C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 07:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7sAO-0004XZ-CY; Fri, 17 May 2024 03:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7sAD-0004Tb-Vo
 for qemu-devel@nongnu.org; Fri, 17 May 2024 03:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7sAB-0001x3-E1
 for qemu-devel@nongnu.org; Fri, 17 May 2024 03:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715931478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUf10ZOceV8KLddA/OPHgi+vqJuSwnuX3to0i7K9Qfg=;
 b=CUpMKhgEwNOGzUGCZzPJ638E2S9gWSKxugr3LpsKfl88GTef4YFkV6pSe2ZJds/zLRVk6V
 AxYKoIU9excUWn+4FJ3Nfh6gMfVCPxDaxBw639CdNJF5LYvoG395q4ioz+xTlgvtXcE0ps
 A7pcGeut/6+v7qfs+kueC9Xho+zrbz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660--HV63a5XNjmOvYfu_Y5AeQ-1; Fri, 17 May 2024 03:37:55 -0400
X-MC-Unique: -HV63a5XNjmOvYfu_Y5AeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A9D7101A553;
 Fri, 17 May 2024 07:37:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E46D200A0B4;
 Fri, 17 May 2024 07:37:53 +0000 (UTC)
Date: Fri, 17 May 2024 08:37:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] gitlab-ci: Replace Docker with Kaniko
Message-ID: <ZkcJULpLGRuuG9K4@redhat.com>
References: <20240516165410.28800-3-cconte@redhat.com>
 <ZkZPRILIqoyGbdEk@redhat.com>
 <771ff437-9bb2-4d4b-9397-f675d227191c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <771ff437-9bb2-4d4b-9397-f675d227191c@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

On Fri, May 17, 2024 at 08:24:44AM +0200, Thomas Huth wrote:
> On 16/05/2024 20.24, Daniel P. Berrangé wrote:
> > On Thu, May 16, 2024 at 05:52:43PM +0100, Camilla Conte wrote:
> > > Enables caching from the qemu-project repository.
> > > 
> > > Uses a dedicated "$NAME-cache" tag for caching, to address limitations.
> > > See issue "when using --cache=true, kaniko fail to push cache layer [...]":
> > > https://github.com/GoogleContainerTools/kaniko/issues/1459
> ...
> > TL;DR: functionally this patch is capable of working. The key downside
> > is that it doubles our storage usage. I'm not convinced Kaniko offers
> > a compelling enough benefit to justify this penalty.
> 
> Will this patch fix the issues that we are currently seeing with the k8s
> runners not working in the upstream CI? If so, I think that would be enough
> benefit, wouldn't it?

Paolo said on IRC that he has reverted the changes to the runner which
caused us problems. Docker in Docker is still a documented & supported
option for GitLab AFAICT, so I would hope we can keep using it as
before.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


