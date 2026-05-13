Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9A6CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN6Zc-0000QD-Mu; Wed, 13 May 2026 06:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN6ZV-0000P9-SM
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN6ZT-0001zj-QN
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778667126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57W4DyR6SVOmssopCRErCIiRao9NqkRbc0Iq8EGSZzE=;
 b=UTAWOqvUJsfJX45+OY6XFyEPH3B9rikt0pfjaj0fj5qZmG9G2MKRw0uoGWpADKhJahDuB7
 +SVOBko+vVPuE3g303JW9lvzic6Wz8/2S1et+yncWiGezoqxFOEeOSq/tQc7zmvL4Tt3mY
 rttMU2uo015XeidsmvNAxzI9afyMTIA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ucORkv8SO9uznXcvPJlrJA-1; Wed,
 13 May 2026 06:11:59 -0400
X-MC-Unique: ucORkv8SO9uznXcvPJlrJA-1
X-Mimecast-MFC-AGG-ID: ucORkv8SO9uznXcvPJlrJA_1778667118
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2183F183064B; Wed, 13 May 2026 10:11:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.213])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2814A30001BE; Wed, 13 May 2026 10:11:44 +0000 (UTC)
Date: Wed, 13 May 2026 11:11:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 12/16] tests: validate dmsetup result in test 128
Message-ID: <agROXRPbcxL5mmy-@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-13-berrange@redhat.com>
 <92e4dccd-5f0f-4268-b6d9-6236fa5ed219@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92e4dccd-5f0f-4268-b6d9-6236fa5ed219@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 12, 2026 at 08:53:47AM -0700, Pierrick Bouvier wrote:
> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> > The I/O test 128 uses 'dmsetup create' to create a device, optionally
> > using sudo to elevate privileges.
> > 
> > This dmsetup command works in GitLab CI, however, the test then fails
> > with a missing device name:
> > 
> >   1..1
> >   # running raw 128
> >   not ok raw 128
> >   ----------------------------------- stderr -----------------------------------
> >   --- /builds/berrange/qemu/tests/qemu-iotests/128.out
> >   +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
> >   @@ -1,5 +1,5 @@
> >    QA output created by 128
> > 
> >    == reading from error device ==
> >   -read failed: Input/output error
> >   +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
> >    *** done
> > 
> >   (test program exited with status code 1)
> > 
> > It is believed that this is due to the build env using a manually
> > populated /dev, such that the device mapper node won't ever appear.
> > It is not a race, since a test adding a sleep did not result in the
> > device appearing.
> >
> 
> Could that be related to the fact it's running inside a container (if it
> is). Maybe it's just missing exposing all /dev instead of a limited set
> of devices.

We don't have any control over what's present in /dev in test environments,
so we shouldn't assume /dev automatically exposes devices that we can
create via device mapper, as it could be locked down.

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/128 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
> > index d0e00d24b1..d75b1a451a 100755
> > --- a/tests/qemu-iotests/128
> > +++ b/tests/qemu-iotests/128
> > @@ -42,6 +42,12 @@ _setup_eiodev()
> >  		echo "0 $((1024 * 1024 * 1024 / 512)) error" | \
> >  			$cmd dmsetup create "$devname" 2>/dev/null
> >  		if [ "$?" -eq 0 ]; then
> > +			DEV="/dev/mapper/$devname"
> > +			if ! -e $DEV
> > +			then
> > +				_notrun "Device $DEV not appearing"
> > +			fi
> > +
> >  			sudo="$cmd"
> >  			return
> >  		fi
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


