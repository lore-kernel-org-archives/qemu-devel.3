Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D62CFB45B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 09:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy6OW-0006eO-VL; Tue, 08 Oct 2024 05:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sy6OU-0006Xl-Gy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sy6OR-0006u3-HE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728379233;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jy6TACDW7wezF2fyd5o7TjcQ8Isv6/XwX9r/zSKLGAI=;
 b=PQVMI0Am4ympjE7wAPz6c0Pguo76aDSgr6uY15pruPXy3myMEZCdrEI/t+G7qxtG8aOYkE
 UQ+sFEXcQmqJD+HOLbNNg9bqQwJxrpLmSaQVdkoDPyR0LUPrkmqA7tnrlgnXf+o7KuYFv0
 xUV3xFS01adM9wFqCWJ3g2AarAAlYUY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-hgwec0zAPX6Rv8_8EPgJfw-1; Tue,
 08 Oct 2024 05:20:27 -0400
X-MC-Unique: hgwec0zAPX6Rv8_8EPgJfw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 378421955F79; Tue,  8 Oct 2024 09:20:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D30281956056; Tue,  8 Oct 2024 09:20:23 +0000 (UTC)
Date: Tue, 8 Oct 2024 10:20:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
Message-ID: <ZwT5U2FsG6ugWZVu@redhat.com>
References: <20241007171717.1436982-1-pbonzini@redhat.com>
 <ZwQmDzjojjAs-dQR@redhat.com>
 <CABgObfYPHFyBShEY2Qxdg+2yG_7aXp-cN8rdkMB8Ha8v1Qe=Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYPHFyBShEY2Qxdg+2yG_7aXp-cN8rdkMB8Ha8v1Qe=Ew@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 08, 2024 at 11:03:47AM +0200, Paolo Bonzini wrote:
> On Mon, Oct 7, 2024 at 8:19 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > I think that in addition to the nightly job, the mappings.yml should
> > add rust toolchain, and have a 'system-fedora-rust' job, since you
> > say that Fedora 40 should already satisfy the min version requirement
> > without needing nightly there.
> >
> > Even though the mappings.yml addition will add rust to /all/ containers
> > this is fine - a perhaps even a good thing - as with any dep we have, it
> > shows that QEMU does not mistakenly try to enable & use a feature on a
> > rust version that is too old to work - it reflects that most developer
> > envs will have rustc present, even when its too old for QEMU to use.
> 
> Ok, I'll work on adding bindgen support to lcitool and then do this as
> a separate submission.

FYI, lcitool already has a package mapping for 'bindgen' defined as Alex
added that for QEMU's benefit a few months back :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


