Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843A4CD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKB3V-0000na-9m; Tue, 05 May 2026 04:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKB3U-0000lY-Jm
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKB3T-0001xM-4S
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777969377;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D03kjbrea2xdjYg0YajIhEU22HOqEvlMrKtRAijqgUo=;
 b=Ia/U5JRFLfioG41kMb4l76ksAh56YDn+OVg1bGQ2YkI+d30F9gTYXuFSMdgukSXslD4T0D
 L7tzLof2P6P+0s4X5H3OzHou40QS5hS8IpW3S/3tk+LkEY8oknHl3voOCVmb2+9EEXY8yi
 sFTdB6J4jx/iX8dsCxKu70PDrWrONVg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-xuXkiCX8O4CjU11zVvKF2g-1; Tue,
 05 May 2026 04:22:52 -0400
X-MC-Unique: xuXkiCX8O4CjU11zVvKF2g-1
X-Mimecast-MFC-AGG-ID: xuXkiCX8O4CjU11zVvKF2g_1777969371
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58C7E1956050; Tue,  5 May 2026 08:22:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6504180034F; Tue,  5 May 2026 08:22:46 +0000 (UTC)
Date: Tue, 5 May 2026 09:22:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: milesg@linux.ibm.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
Message-ID: <afmo00Lm0ajJ6I9b@redhat.com>
References: <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
 <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
 <4def4bcbfe241bcd8437a195757dd753ce09a32e.camel@linux.ibm.com>
 <1bf864b8-0dcf-45d6-a2fc-fc34b1bafe97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bf864b8-0dcf-45d6-a2fc-fc34b1bafe97@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 04, 2026 at 11:48:57AM +0200, Cédric Le Goater wrote:
> Hello Glenn,
> 
> 
> On 4/30/26 17:43, Miles Glenn wrote:
> > On Thu, 2026-04-30 at 17:15 +0200, Philippe Mathieu-Daudé wrote:
> > > Hi Harsh,
> > > 
> > > On 30/4/26 08:54, Harsh Prateek Bora wrote:
> > > > Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
> > > > 
> > > > Glenn,
> > > > Please take a look and let us know your thoughts.
> > > 
> > > Glenn can have a look, but I think we are good to remove them now,
> > > they have been deprecated for more than 1 year, enough time for
> > > any reaction ;) Otherwise that'd defeat the point of deprecating
> > > and the pain for us to schedule and wait for months.
> > 
> > Philippe,
> > 
> > Sorry, I thought it had been made clear back in August of last year
> > that we would need the PPC405 CPU to hang around.  The topic was
> > brought up by Cedric when I added support for the PPE42 processor.  Is
> > there some formal process I need to go through to have it removed from
> > the deprecated list?
> 
> I don't know of any un-deprecation process. I suggest sending a patch
> to revert commit 52f0b59ec6b7 ("hw/ppc: Deprecate 405 CPUs"). The commit
> log should mention the PPE42 processor which is a stripped down version
> of the IBM PowerPC 405 processor.

Yes, that's exactly the process - just remove the text from deprecated.rst
and warning messages printed by the code (if any)

Daniel


