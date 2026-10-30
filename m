Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE2606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NA47CIKA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmPq-0006jn-Ou; Fri, 30 Oct 2026 09:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMmPL-00064n-EI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMmPG-0004sm-7o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793365948;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luqN36eQr9cvX7ZlJUQi6wCB1RlpaTkpx7SoAr5njao=;
 b=NA47CIKAYHWLHOvSd6fo8zKJQA8ABMWP3OavFXMhs3kHyG33lcy57wK2Y8z3MVBtUrx+CA
 NTx3NmgYq7simlINfZromsvKztkZrDNSkgnZzZX2d95TDwIvN2T9z57UU9spSaqlHHV8be
 cosNnwR83mAekw+YZm2yHh8sx0u9/ys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-wLI8iMc8NRaHZo9QEuBdlw-1; Fri,
 30 Oct 2026 09:12:19 -0400
X-MC-Unique: wLI8iMc8NRaHZo9QEuBdlw-1
X-Mimecast-MFC-AGG-ID: wLI8iMc8NRaHZo9QEuBdlw_1793365938
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 077D51828ADD; Fri, 30 Oct 2026 13:12:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 905FB1956088; Fri, 30 Oct 2026 13:12:09 +0000 (UTC)
Date: Fri, 30 Oct 2026 13:12:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 09/28] hw/net: mark e1000, e1000e, IGB, rtl8139 & sPAPR
 VLAN as secure
Message-ID: <auSXprZs_pozFfqV@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-10-berrange@redhat.com>
 <CAFEAcA8GwF=EdaqvO7OBNZY1ku8LWNH5giveZYXSVnmk9JWfng@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8GwF=EdaqvO7OBNZY1ku8LWNH5giveZYXSVnmk9JWfng@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:12:55AM +0000, Peter Maydell wrote:
> On Fri, 11 Sept 2026 at 15:42, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Historically most NICs are only interesting for non-virtualization
> > use cases and have not been written with malicious guests in mind.
> >
> > As a general rule either virtio-net or xen-net should be used in
> > all virtualized guests requiring a security boundary.
> >
> > There are a handful of exceptions resulting from historical usage
> > in the x86 world, to support virtualized guests lacking virtio
> > support.
> >
> > Thus the rtl8139, e1000, e1000e & IGB NICs are declared to provide
> > a security boundary.
> 
> You've said in several bugs (e.g.
> https://gitlab.com/qemu-project/qemu/-/work_items/3872 )
> that igb wasn't covered by the virtualization use case.

Hmm, yes, I forgot I had said that, which I guess shows the value
of this series long term.

> I don't care either way, but I wanted to check since I've been
> marking igb bugs as non-confidential when triaging on the
> basis of that...

I added it in this series because I forgot what I previously said
and then found our RHEL shipped it. I've since checked that the
RHEL inclusion was only for ease of SRIOV testing, not intended for
production deployment.

So consider 'igb' dropped from this patch. We'll continue to treat
it as insecure, unless a maintainer steps up to request otherwise
and fix historical issues we've had disclosed this year.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


