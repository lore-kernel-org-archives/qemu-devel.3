Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8558606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EredelZM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUD8-0001CW-85; Mon, 23 Nov 2026 08:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVUC5-000102-Np
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:35:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVUC3-0007qC-FR
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795440890;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/yE4ywmJ53Ojt5hHKPC5Z/7MUve6m/To1ZFK3euevQ=;
 b=EredelZM4X0WAIKvBxlIVQsF0B8SwOz3hDU2b2wVjdPqx7H8tQl7G0oiuAk6rubYcql00z
 8xS4ZmMTqKJO8bZS4OT3MXb/pqO4nD1EL433ahpj+WR7WmKwqUsBkTe/a97ebZyv0UERYo
 JHUiHdP9eNNth+V608bHBd5V43RHNsI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-zcFF2P79NUiNodYOesVX2Q-1; Mon,
 23 Nov 2026 13:34:47 +0000
X-MC-Unique: zcFF2P79NUiNodYOesVX2Q-1
X-Mimecast-MFC-AGG-ID: zcFF2P79NUiNodYOesVX2Q_1795440886
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563FA1956069; Mon, 23 Nov 2026 13:34:46 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D847343; Mon, 23 Nov 2026 13:34:44 +0000 (UTC)
Date: Mon, 23 Nov 2026 13:34:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Subject: Re: [PATCH] git: Fix broken relative symlinks for Claude and Gemini
 skills
Message-ID: <awRA8q1X-GmogMQf@redhat.com>
References: <20261123092817.1237214-1-zhenzhong.duan@intel.com>
 <awQNLBquRToihQJV@redhat.com>
 <47428c0f-34a5-4cb4-991a-e1d5d8bbdfd1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47428c0f-34a5-4cb4-991a-e1d5d8bbdfd1@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 02:26:39PM +0100, Philippe Mathieu-Daudé wrote:
> On 23/11/26 10:53, Daniel P. BerrangÃ© wrote:
> > On Mon, Nov 23, 2026 at 05:28:17PM +0800, Zhenzhong Duan wrote:
> > > Update the relative symlink targets for both ".claude/skills" and
> > > ".gemini/skills" from ".agents/skills/" to "../.agents/skills".
> > > 
> > > Fixes: 3e9fe057ae0b ("agents: Add a skill for finding your way around QEMU")
> > > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > > ---
> > >   .claude/skills | 2 +-
> > >   .gemini/skills | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > FYI, I've also sent the same fix several weeks ago
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02802.html
> 
> Can't we just remove these and let the generic .agents/ path?

It seems like both claude and gemini honour the agent skills
standard, so yes, .agents ought to be all we need AFAICT.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


