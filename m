Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0BEC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnM6-0000iF-8d; Wed, 05 Mar 2025 06:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpnM3-0000dS-6n
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:56:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpnM1-00039V-FK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741175759;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXikQWvwjTuk+1BHtLJk70XTuKhKdL4IPzaePJxP8e4=;
 b=iXuKV9Pa1h+ZMyFpeBxJdPxI1NlfWJGUQbq4mcKznWj6VGOqUdPqZLjnaPmIfmn784WBnM
 0YCFMqd3RWhUjNVr2qUCHP3DZ/psuK3DSR6tCDytsHkHfr8yUOTIJQP6i86jFlP4ByPF/i
 jlkneEtomluHJE4TGEXCLD+2CcSFXdU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-6CGcmW1POMu9rA7vzDiFag-1; Wed,
 05 Mar 2025 06:55:51 -0500
X-MC-Unique: 6CGcmW1POMu9rA7vzDiFag-1
X-Mimecast-MFC-AGG-ID: 6CGcmW1POMu9rA7vzDiFag_1741175750
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49A3818004A9; Wed,  5 Mar 2025 11:55:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12DDA195608F; Wed,  5 Mar 2025 11:55:45 +0000 (UTC)
Date: Wed, 5 Mar 2025 11:55:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 3/7] tests/functional: remove all class level fields
Message-ID: <Z8g7vk24ivLII5di@redhat.com>
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-4-berrange@redhat.com>
 <8c801030-cd71-4ad2-9b21-419bac68031f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c801030-cd71-4ad2-9b21-419bac68031f@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 05, 2025 at 12:51:16PM +0100, Thomas Huth wrote:
> On 28/02/2025 11.27, Daniel P. Berrangé wrote:
> > A number of fields are set at the class level on QemuBaseTest, even
> > though the exact same named field is then set at the object level
> > later in most cases.
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/testcase.py | 6 ------
> >   1 file changed, 6 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > index 058bf270ec..5b18416bed 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -33,12 +33,6 @@
> >   class QemuBaseTest(unittest.TestCase):
> > -    arch = None
> > -
> > -    workdir = None
> > -    log = None
> > -    logdir = None
> 
> This seems to break the ACPI test:
> 
> https://gitlab.com/thuth/qemu/-/jobs/9316861224#L164

Our current code initializes  self.log in the setUp() method.

The ACPI bits code references self.log in the __init__() method.

So historically it has been referencing the class level 'log'
property which has always been None. This means if it were
to ever trigger codepaths calling self._print_log it will
crash on referncing None. So this patch has exposed a preexisting
flaw that was dormant.

I think the fix is to move ACPI bits logic out of __init__ and
into its own setUp() method.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


