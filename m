Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVOQ-0007BC-UZ; Wed, 08 Jul 2026 12:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whVOO-00077o-1R
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whVOI-0003F1-V3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783529093;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XkHhE4HS0EC9R/UNwCYKkpRr9HZXSRPHfO4vuMPwrWM=;
 b=Iuomqe+/znCSspY7IkaaLMNEnXrLR2nU7Rs9OxuVEChHKgBZJAGzkm0ic6fhJ9l+bxhK5O
 XaUgfj4m/FzWDWu+Q7TqJLJegtIn23gg8Nx7vsmCDwIUmjbo6OBEQtmhQ4olRwxVthfvTj
 7iCKQ6exZvCU0TNPwjhyv2Uz31kNvZE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-6rZPWQn5NTeILkmpW0M2_Q-1; Wed,
 08 Jul 2026 12:44:50 -0400
X-MC-Unique: 6rZPWQn5NTeILkmpW0M2_Q-1
X-Mimecast-MFC-AGG-ID: 6rZPWQn5NTeILkmpW0M2_Q_1783529088
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AF4B1955F2A; Wed,  8 Jul 2026 16:44:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A52C231D2; Wed,  8 Jul 2026 16:44:44 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:44:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 00/21] target/s390x: Extend qemu CPACF support
Message-ID: <ak5-efTUs5qqteKp@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <87jyr7jg13.fsf@redhat.com>
 <f5da328519f83191277bd5b3d8060712@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5da328519f83191277bd5b3d8060712@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

On Tue, Jul 07, 2026 at 04:02:28PM +0200, Harald Freudenberger wrote:
> On 2026-07-07 11:38, Cornelia Huck wrote:
> > On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> > 
> > > This patch series extends the s390 qemu CPACF support to be able to
> > > run a subset of the CPACF instruction cross platform. There have been
> > > requests on the kernel crypto mailing list about a way to test
> > > s390 specific crypto implementations. For example a way to test
> > > s390 CPACF exploitation code like the s390_aes.ko kernel module.
> > > 
> > > So here now is a set of patches verified on x86 and s390 which
> > > over (slow but working) support for a subset of the subfunctions of
> > > some of the CPACF instructions.
> > 
> > Hi,
> > 
> > I wanted to pick this, but unfortunately, there are some problems with
> > it, as spotted by checkpatch (sadly, I did not see this earlier, and
> > softfreeze is upon us...)
> > 
> > - Licensing information: new files (e.g. cpacf.h) must use an SPDX
> >   identifier instead of licence boilerplate text - this needs to be
> > fixed
> > - some files are using tabs instead of spaces in some places
> > - there are also some other moans (less important), but you may want to
> >   look at them anyway (the long lines are not really a problem)
> > 
> > Cornelia
> 
> Yes, I saw these checkpatch complains but as nobody else seems to obey
> to the checkpatch findings I ignored most of them.

That is very much the wrong conclusion to draw. Our existing in-tree
code may not be clean on checkpatch, because we change checkpatch
rules over time but we don't retrospectively change existing code.

New code is expected to be clean with checkpatch unless there are
some genuine false positives which can't be reasonably avoided.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


