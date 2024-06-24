Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227DAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLn9t-00061U-0O; Mon, 24 Jun 2024 13:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLn9q-00061E-H7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 13:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLn9o-0002ov-7y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 13:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719248827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=915IcUz9rOYREIBzljcGHDIQpx3aev4i2gyd3B2pFMY=;
 b=PZCwOUgGy6AFLG0Lje+gfmBXzU+d9aeun25rPHZsbi5Aahezbniw22/jtpz+g3O8gXsBFw
 skeLk7t/DynoUhIYPQ/1oRIzQf8x35WdHL13zeIfOqTk5Sju3IXBj367gqn/pxTqh8L5QL
 YX+caNMyqjfKdS+eA3S7BcuFr7l0uMU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-vey-xIiRM_O9UbAdF8lIOQ-1; Mon,
 24 Jun 2024 13:07:03 -0400
X-MC-Unique: vey-xIiRM_O9UbAdF8lIOQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FA3519560BC; Mon, 24 Jun 2024 17:07:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66FB019560BF; Mon, 24 Jun 2024 17:06:59 +0000 (UTC)
Date: Mon, 24 Jun 2024 18:06:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Dave Hello <hsu@peterdavehello.org>, Zhao Liu <zhao1.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <Znmnr3XCiPM89Xag@redhat.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
 <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
 <ZiCDzzFDRmQGPtDD@intel.com>
 <Fu0jQm-Z4E7D_J11oxIlfRJ9ZYK_QDKMYOs-9NNVX_jH9_aS5_9cyysois3SaVVtuTqR-H77MiwWLaa5RkPTEnCEdy0NvUmOuwqyirCbdhY=@peterdavehello.org>
 <5qJ0Q0ZnUCu-VdtMQOwzj54wLBfeXb9ozncO8PjFiOlXbu4RHQeVCZyn7ZMWq89yqqE7GZX3Bsuk9YqWugHmx-Wu4Oh1GZ5wboTuZ-QUk8k=@peterdavehello.org>
 <CAFEAcA8q5O1i-EDviKf-yN5DAsxsSofA3xa9ChMbn_tC91iNuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8q5O1i-EDviKf-yN5DAsxsSofA3xa9ChMbn_tC91iNuw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Fri, Jun 21, 2024 at 02:07:52PM +0100, Peter Maydell wrote:
> On Fri, 21 Jun 2024 at 13:50, Peter Dave Hello <hsu@peterdavehello.org> wrote:
> > On Wednesday, April 24th, 2024 at AM 2:20, Peter Dave Hello <hsu@peterdavehello.org> wrote:
> > > Thank you for all your help; I wonder if the copyright can just
> > > belong to this project because the copyright to me personally in the
> > > open source world just to deal with somebody violets the license.
> > > Otherwise, I'm more copyleft. What do you think?
> >
> > I'm not sure if the previous mail has been dropped. I would really
> > appreciate it if anyone could give me some advice. Thanks a lot!
> 
> We can't give legal advice, but the QEMU project doesn't do
> copyright assignment. Copyright remains with the original author
> (or with their employer).

While we can't give legal advice, going back to the original question
I have an observation that may resolve this.

IIUC, the orignal question was what to put at the top of the .po file
where it has:

  # Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER

I don't believe the QEMU community has any stated requirement that every
file have a "Copyright" line present. Entirely omitting this line is a
valid choice from QEMU's POV.

What matters to QEMU primarily is that the file has a declared *license*
statement.

Any Copyright lines present are woefully inaccurate in most places, since
they're rarely updated despite 100's of contributors working on a file.
The respective contributors still retain copyright over their own work
regardless of what a 'copyright' line says or doesn't say.

IOW, the contributor (or their employer) may decide for themselves
a policy of whether to include or omit such a "Copyright" line, on
contributions submitted.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


