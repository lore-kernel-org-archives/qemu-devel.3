Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B9ECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRZP-0007d8-My; Wed, 24 Jun 2026 13:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZD-0007S9-W3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZ7-0004X1-HB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782322746;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDQziEsfUtQl+3SmaHHeypiWarcBAizvHEXpN3YHCfE=;
 b=UDI4DS0ypin46i0dlNIF63ZEtBNmK/Dux4xWQwJkVCEf7/rlcNTxjjF/1dYo+HsLbTotfA
 zhHVafYHzH+okaO3fDpBtmZukAeSqqWOoOMh87a4XTnNxpWAZxP/qCywwqBtwuLZkCpISD
 YwBEv3jL9aDSXlG8hTJTW0RumHHaPtM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-_pCcHpG0P4CN5zJZWtYThg-1; Wed,
 24 Jun 2026 13:39:04 -0400
X-MC-Unique: _pCcHpG0P4CN5zJZWtYThg-1
X-Mimecast-MFC-AGG-ID: _pCcHpG0P4CN5zJZWtYThg_1782322743
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 910D61955F6F; Wed, 24 Jun 2026 17:39:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.102])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20DE3180049F; Wed, 24 Jun 2026 17:39:01 +0000 (UTC)
Date: Wed, 24 Jun 2026 18:38:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 0/2] Record maintainer/reviewer Git Lab handles
Message-ID: <ajwWMj0_3pht2uZM@redhat.com>
References: <20260624122936.2706393-1-berrange@redhat.com>
 <96b2433f-f2ef-4c68-84de-2ef3508d8809@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b2433f-f2ef-4c68-84de-2ef3508d8809@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 24, 2026 at 03:19:15PM +0200, Philippe Mathieu-Daudé wrote:
> On 24/6/26 14:29, Daniel P. BerrangÃ© wrote:
> > When triaging GitLab issues, whether regular bugs or security
> > disclosures, we need to be able to assign suitable accounts.
> > 
> > We can only assign Git Lab handles for accounts that are members
> > of the QEMU group, or QEMU repository with the "Reporter" role
> > or higher.
> > 
> > Currently one needs to run 'get_maintainer.pl -f <file>' to get
> > the maintainer / reviewer names & emails, and then look in the
> > GitLab members page to see if there is a match.
> > 
> > This simplifies that by including the GitLab handle alongside
> > the email addresses:
> > 
> > The GitLab account handle -> real name mapping is stored in
> > separate files .gitlab-map-auto & .gitlab-map-manual to avoid
> > redundancy in the MAINTAINERS file. The former file is
> > auto-generated and catches 99% of the mappings, the latter is
> > for manual fixups.
> > 
> > With this series applied as is, we get the following stats
> > 
> > $ ./scripts/gitlab-map-check
> > Missing GitLab handle: Akihiko Odaki

...

> > Missing GitLab handle: zhenwei pi
> > Missing GitLab handle: Zhenzhong Duan
> > Missing GitLab handle: Zhuoying Cai
> > GitLab handles missing: 161 / present: 57
> > 
> > Plenty of those will have GitLab accounts, but are simply not members
> > of QEMU. Plenty more probably aren't registered with GitLab at all.
> > 
> > Short of emailing all of those people directly, I don't see a good
> > way to identify their GitLab accounts (if any), in order to invite
> > them to the QEMU project. I don't want to blindly invite accounts
> > which merely have the same name on GitLab as there's too much risk
> > of getting a mis-match.

...

> No clue why Hanna is listed here...
> 
> Applying: gitlab: introduce files mapping GitLab accounts to real names
> Applying: get_maintainer: add ability to report Git Lab handle
> .git/rebase-apply/patch:121: trailing whitespace.
> hreitz	Hanna Reitz
> warning: 1 line adds whitespace errors.

There is trailing whitespace after 'Reitz' that crept in.

> 
> Anyhow,
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


