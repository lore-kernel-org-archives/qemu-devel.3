Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD6606A905
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jw21akbs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvVQ-0002mv-OI; Mon, 02 Nov 2026 12:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNvVO-0002cu-47
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNvVM-00061V-4j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793639251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zudGjxucN5O6IVv4PU8MXnw26n+HnD1jmcSKKs9X+zs=;
 b=Jw21akbsE8b/Ssuj6D1KQziIms0QHgY6MwrrmU5T8iF2K7LOvZnzMbkEEiu0eeH5gjcALN
 zfJac5cgixzVpBbNG+ESri8c+DokbAYlBpxXFnGyp62g+PaYWkmCtYhJdRNdmeOf98Ehdo
 Zno+W0758WHwHwbKp0uZV3I1zfgrHCQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-1foQ7NmAOzqkqlS98gmCHQ-1; Mon,
 02 Nov 2026 12:07:29 -0500
X-MC-Unique: 1foQ7NmAOzqkqlS98gmCHQ-1
X-Mimecast-MFC-AGG-ID: 1foQ7NmAOzqkqlS98gmCHQ_1793639248
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C6A1800D8B; Mon,  2 Nov 2026 17:07:28 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 178A41800347; Mon,  2 Nov 2026 17:07:27 +0000 (UTC)
Date: Mon, 2 Nov 2026 17:07:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] Misc fixes patches
Message-ID: <aujDTUd_wAzbqGwo@redhat.com>
References: <20261102122645.3353402-1-berrange@redhat.com>
 <d11965a7-6a8c-4d83-aaad-a208f5d3ef28@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d11965a7-6a8c-4d83-aaad-a208f5d3ef28@linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:36:01AM -0800, Richard Henderson wrote:
> On 11/2/26 04:26, Daniel P. Berrangé wrote:
> > The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> > 
> >    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> > 
> > are available in the Git repository at:
> > 
> >    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> > 
> > for you to fetch changes up to f4b560dd12612fa12217f3a621ab54dfb6157040:
> > 
> >    accel/nitro: mark 'nitro' accelerator as secure (2026-11-02 11:08:45 +0000)
> > 
> > ----------------------------------------------------------------
> > * Mark virtualization related machine types as secure
> > * Mark KVM, Xen and Nitro accelerators as secure
> > * Use getexecpath on OpenBSD
> > * Use qemu_dup() over dup()
> 
> Fails build on windows:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17671461626#L2066
> 
> > ../io/channel-file.c:57:17: error: implicit declaration of function 'qemu_dup' [-Wimplicit-function-declaration]
> >    57 |     int newfd = qemu_dup(fd);
> >       |                 ^~~~~~~~
> > ../io/channel-file.c:57:17: error: nested extern declaration of 'qemu_dup' [-Werror=nested-externs]

I'm dropping that patch for now, since it is not critical for the
release. Sending a v2 PULL.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


