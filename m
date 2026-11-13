Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A251606B180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CJZKLkFh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrmz-0002wi-Uw; Fri, 13 Nov 2026 08:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRrmp-0002jn-9B
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRrmn-0000ot-LI
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794578266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/lIf5s2RmRonMeKbtcrjUzuyFZjFu/FVzOJvTDtSCU=;
 b=CJZKLkFhXQ0c7nMNNQz58AX24Eg9ws4dPBONiQhuEVncQFbLqEpa2sqx1smCyCx0g+zkDw
 e6TYLvpz1Uzs6w2psS5YgCE5842QOcHZtvHuAGFc+NIvxXgSDrVEqg0jDrydd4wxZUKIOQ
 gqE66laUVR3C1imRLBXw7WwDpHiW/d0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-97ta8ggwNgqYWsqmqES6GA-1; Fri,
 13 Nov 2026 08:57:44 -0500
X-MC-Unique: 97ta8ggwNgqYWsqmqES6GA-1
X-Mimecast-MFC-AGG-ID: 97ta8ggwNgqYWsqmqES6GA_1794578263
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 812081955DEA; Fri, 13 Nov 2026 13:57:43 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8CED1956086; Fri, 13 Nov 2026 13:57:41 +0000 (UTC)
Date: Fri, 13 Nov 2026 07:57:39 -0600
From: Eric Blake <eblake@redhat.com>
To: guillaume vincke <guillaume.vincke@ovhcloud.com>
Cc: armbru@redhat.com, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] NBD patches through 2026-11-10
Message-ID: <avcWw34WAJKerP2L@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
 <820539b6-d161-43ff-8889-cb40c1ecc6f2@linaro.org>
 <avYRrN7--EID31IM@redhat.com> <878q2xz3i7.fsf@pond.sub.org>
 <ff4c1e4d-cb1b-4c61-ad2e-537131c45dd9@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff4c1e4d-cb1b-4c61-ad2e-537131c45dd9@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 09:12:09AM +0100, guillaume vincke wrote:
> > > Markus, what are your thoughts on a QMP addition this late into 11.2
> > > so that the test in 2/8 can be stable? I'm torn on whether the NBD bug
> > > in 1/8 is severe enough to need to go in 11.2.0 proper, or whether the
> > > bug is weak enough that it is safer to wait until 11.2.1 via the
> > > qemu-stable process.  Patches 3-8 fix CVEs, so they definitely belong
> > > in 11.2.
> > 
> > "Only bug fixes" since soft freeze.  The closer we get to the release,
> > the more serious the bugs need to be.
> > 
> > Including tests with the bug fixes feels okay to me.  Test
> > infrastructure in QEMU proper, like a QMP command, is pushing it,
> > though.
> > 
> > What's the impact of omitting or disabling the troublesome test until
> > after the release?
> 
> In my opinion, the 1/8 fix and the associated 2/8 test can be postponed
> to the next release. That behavior has been there for a long time and,
> as far as I know, nobody but me has complained about it. Taking the
> time to get a robust test in is probably the safer option.

That settles it. I'm saving both Guillame's bug fix and the unit test
for 12.0 when we can also pick up the QMP changes to make the unit
test robust; and planning a strong possibility of backporting the bug
fix, but not the unit test, to 11.2.1 once the 11.2 release is out.  I
will respin this pull request accordingly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


