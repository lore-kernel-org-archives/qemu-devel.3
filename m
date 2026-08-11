Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE13C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthW9-0004Hl-Pk; Tue, 11 Aug 2026 04:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wthW7-0004HH-KQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wthW3-0004TT-Q3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786435638;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPYVAgsyg9jRqfAZB8GhtsQkf2a5d8TuBwn3/lh/FB8=;
 b=MIsLWeP7dK8WA9Z9geHuYq1iTRGDbB7L71OAOGcdMFOYrhXCHwVyndO2Gl4UTB4VAq5OVg
 ADQQrjKBPdBnj+NZZtMCCoTr0M/RyYwOFOUKHDTd6wvNc9pjOI5ZHcgE/ByBYVnTEhqoZx
 rVjJrpEzWRlf8knZNJ6hh8z97r5Z0Kg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-Xt8uz6fuOWWeL5LX9dq5Hw-1; Tue,
 11 Aug 2026 04:07:17 -0400
X-MC-Unique: Xt8uz6fuOWWeL5LX9dq5Hw-1
X-Mimecast-MFC-AGG-ID: Xt8uz6fuOWWeL5LX9dq5Hw_1786435636
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E79E1956096; Tue, 11 Aug 2026 08:07:15 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1E471800577; Tue, 11 Aug 2026 08:07:13 +0000 (UTC)
Date: Tue, 11 Aug 2026 09:07:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 00/39] Make HMP optional (and later standalone)
Message-ID: <anrYLgyzGTVze_8n@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <ab1837fa-3e1b-48a9-a2d7-70cef35f1ed4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab1837fa-3e1b-48a9-a2d7-70cef35f1ed4@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 10, 2026 at 11:49:08PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Marc-André,
> 
> On 25/6/26 23:19, Marc-AndrÃ© Lureau wrote:
> > Hi,
> > 
> > This series makes HMP compile-time optional via --disable-hmp. The
> > resulting binary speaks only QMP - reducing the attack surface, binary
> > size and enforcing a separation between machine-readable interface and
> > interactive debugging console.
> > 
> > QMP offers almost all the functionality HMP could provide, so a separate
> > standalone "HMP-like" console could be implemented on top of it.
> 
> I'm in favor of the overall goal, but am reluctant to the amount of
> CONFIG_HMP #ifdef'ry added. During the last years we changed our style
> to link unreachable stubs, allowing easier code maintenance. Are we OK
> to deviate in this case?

IMHO the right long term solution is for every HMP command impl to be
moved into a separate file - many are already in separate files, just
need to finish the job. Then the condition just becomes a meson.build
rule instead of an #ifdef for everything except some code in monitor/
directory. Until that's done, I think the #ifdef's are bearable as
is.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


