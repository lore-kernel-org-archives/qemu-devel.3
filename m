Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A177CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24xd-0006ih-JF; Fri, 26 Sep 2025 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v24xc-0006iN-QY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v24xT-0001Sg-7J
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758879699;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NZ92nOib7TJ/EZiBRqVvHKzi3wwQhdXlB428d082GQ=;
 b=a1XJqgyFIXdbsBPhR/YOZdVzK2UOYY/1oE7NZym0PpXZESRnmD2Ot/8nXPcTzUmcZjRhCL
 8fKjauTGTEIiiKm4piQrgH1aGfaYPgyHyxZL/LLh9f7w2PrTrvWHn8okuvmUliEig5zbmC
 i460HNL09qoU9z1Cq9D4mIkA1+JpoT8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-G7MOHeZePyahDh5BRnjkaA-1; Fri,
 26 Sep 2025 05:41:36 -0400
X-MC-Unique: G7MOHeZePyahDh5BRnjkaA-1
X-Mimecast-MFC-AGG-ID: G7MOHeZePyahDh5BRnjkaA_1758879695
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D590119774EE; Fri, 26 Sep 2025 09:41:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E3618003FC; Fri, 26 Sep 2025 09:41:31 +0000 (UTC)
Date: Fri, 26 Sep 2025 10:41:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH v4 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Message-ID: <aNZfyKKmm6g78ahQ@redhat.com>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <f94da379-eee1-4375-95e6-7349c3c188ee@linaro.org>
 <1d096685-ada0-4c8a-b16a-ed8a5df7b90d@redhat.com>
 <269cec44-b851-4b2e-a1f0-ae3a24cd97cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <269cec44-b851-4b2e-a1f0-ae3a24cd97cf@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 26, 2025 at 11:32:58AM +0200, Philippe Mathieu-Daudé wrote:
> On 26/9/25 11:14, Thomas Huth wrote:
> > On 26/09/2025 08.49, Philippe Mathieu-Daudé wrote:
> > > Hi Gustavo,
> > > 
> > > On 26/9/25 07:15, Gustavo Romero wrote:
> > > > tests/functional: Adapt reverse_debugging to run w/o Avocado
> > > > 
> > > > The goal of this series is to remove Avocado as a dependency for running
> > > > the reverse_debugging functional test.
> > > 
> > > 
> > > > Daniel P. Berrangé (2):
> > > >    tests/functional: replace avocado process with subprocess
> > > >    tests/functional: drop datadrainer class in reverse debugging
> > > > 
> > > > Gustavo Romero (7):
> > > >    tests/functional: Re-activate the check-venv target
> > > >    python: Install pygdbmi in meson's venv
> > > >    tests/functional: Provide GDB to the functional tests
> > > >    tests/functional: Add GDB class
> > > >    tests/functional: Add decorator to skip test on missing env vars
> > > >    tests/functional: Adapt reverse_debugging to run w/o Avocado
> > > >    tests/functional: Adapt arches to reverse_debugging w/o Avocado
> > > 
> > > Out of curiosity, do you plan to post the final patch removing Avocado
> > > use / dependency?
> > 
> > Which other uses of Avocado are you thinking about? AFAIK, this test
> > here is the last one that used Avocado.
> 
> Maybe I was not clear. After these tests conversion, I don't see any
> more use of avocado, so we can remove its dependency on QEMU, right?
> Basically, in a final patch I'd remove anything related to:
> 
>   python/setup.cfg:37:    avocado-framework >= 90.0
>   python/tests/minreqs.txt:35:avocado-framework==90.0

The python code CI jobs all rely on avocado. In the python-qemu-qmp
repo John has a patch that drops avocado. That can be pulled over
into QEMU, but it is likely John will propose removing the python/
directory from QEMU instead and using a wheel.

Either way, this patch series doesn't need to touch python/ dir,
as work on that is in-progress separately.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


