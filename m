Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A69606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0af8Qdt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFwL-00014z-4r; Fri, 06 Nov 2026 04:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPFwI-00014L-Fh
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 04:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPFwG-00036w-1n
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 04:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793956126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrRMLM1AFmYi/bs5etB4HJkcjnYDxynCvbguHNw2R60=;
 b=N0af8QdtjFsR0m10wmIj7KILbvw+VsMQn/lBsGsRYqPeHN4/pXuLi9wIhMITqO8wMkhTBw
 F/UrroSqV9rFy9JmZ2GdTe7Apnedvg+DYHgwnlHiXDlmYk+02pAc8owc4uC0SM5WbYclve
 3GEo2b5iYxyFTmBL7K9iMMax8yazTms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-yzAb6lIKNqGlxw4drA2uog-1; Fri,
 06 Nov 2026 04:08:42 -0500
X-MC-Unique: yzAb6lIKNqGlxw4drA2uog-1
X-Mimecast-MFC-AGG-ID: yzAb6lIKNqGlxw4drA2uog_1793956120
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B55551956057; Fri,  6 Nov 2026 09:08:38 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E1B1956047; Fri,  6 Nov 2026 09:08:31 +0000 (UTC)
Date: Fri, 6 Nov 2026 09:08:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Junjie Cao <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "clg@kaod.org" <clg@kaod.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "kfting@nuvoton.com" <kfting@nuvoton.com>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "deller@gmx.de" <deller@gmx.de>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "anthony@xenproject.org" <anthony@xenproject.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Message-ID: <au2ZDOY7MGdY74L9@redhat.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
 <20261103142327.1348025-1-junjie.cao@linux.dev>
 <SEZPR06MB73626D50E685F83DFB006D8DFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <SEZPR06MB7362D089282550D7585C16DEFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR06MB7362D089282550D7585C16DEFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 03:45:58AM +0000, Jamin Lin wrote:
> > Subject: RE: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
> > leave it off
> > 
> > > Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub
> > > property and leave it off
> > >
> > > Hi Jamin,
> > >
> > > On Mon, Nov 02, 2026 at 09:22:05AM +0000, Jamin Lin wrote:
> > > > Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an
> > > > older machine type keeps the hub it has today and a guest saved by
> > > > an older QEMU still loads.
> > >
> > > Reran the migration check from v7: with pc-q35-11.1, a guest saved
> > > without the series loads on v8 with the hub in place, for qemu-xhci
> > > with four HID devices and for q35 -usb with six.
> > >
> > > But this missed the 11.2 soft freeze, so in 12.0 pc-q35-11.2 is an old
> > > machine type too, and hw_compat_11_1 (my suggestion on v7) doesn't
> > > cover it. Saved with pc-q35-11.2 on master, both cases fail on v8:
> > >
> > >   Unknown section or instance '0000:00:01.0/4/usb-hub' 0
> > >   Unknown section or instance '0000:00:1d.7/6/usb-hub' 0
> > >
> > > The entries from 02-05 want hw_compat_11_2 once the 12.0 machine types
> > > are in.
> > >
> > > Junjie
> > 
> > Hi Junjie, Marc-André, and Gerd,
> > 
> > Due to the QEMU code freeze and the planned 11.2 release in December,
> 
> 
> I am not sure about the correct release version. I expect it to be v11.2.
> If the version is wrong, please correct me.

Yes, the forthcoming release is 11.2, the version then ticks over to 12.0
for the first release of 2027.

> > disabling automatic hub creation while keeping migration compatibility with
> > older QEMU versions requires adding the property to hw_compat_11_2.
> > We need to wait until after the QEMU 11.2 release for the maintainers to add
> > hw_compat_11_2 to each machine type.
> > 
> > The USB redirection server is my original upstream goal, and I think this task is
> > independent of the automatic hub task.
> > So, I want to split the auto-hub changes into a separate prerequisite patch
> > series and send v9 after the QEMU 11.2 release.
> > 
> > The USB redirection server common protocol series still needs rework on the
> > device announcement and control transfer patches.
> > I will send v9 next week and mention that it requires the patch series that
> > disables automatic hub creation.
> > 
> > This way, we can continue testing and reviewing the USB redirection server
> > common protocol this month.(November)
> > 
> > "If you agree, I will send v9 next week. Otherwise, I will wait until after the
> > QEMU 11.2 release and then resend the full patch series as v9."

Don't delay sending new versions of your series because of the release
freeze.

Just put a "TODO: change to hw_compat_11_2 before merge" in the commit
message to call out the bit that you know needs changing before this
can be finally ready to merge.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


