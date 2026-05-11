Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735B2CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSMi-0002H1-57; Mon, 11 May 2026 11:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMSMf-0002GY-Q5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMSMc-0002wV-Rz
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778512569;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57lGxKw6KssNtFzVwy9HoirW88XXWqZd2UrheMKML8U=;
 b=dZbg3cjJHCAUQYVJkWMDfEwJMRvLwNMNNqYoqBEF6OiJYh5m2A4b5FYGA3hrJofThkd7bT
 Dq6OlW7/gqN0L7OrP0+UkCvRedAjYQN9pm9FyzgeAptfnlxs8CqlXXnshf7Iy9KIb3VB2m
 JXESo+3usoI1NPRFflRqAgBDJtHeerk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-TzIIRkXkN96ACe49JZjwKg-1; Mon,
 11 May 2026 11:16:05 -0400
X-MC-Unique: TzIIRkXkN96ACe49JZjwKg-1
X-Mimecast-MFC-AGG-ID: TzIIRkXkN96ACe49JZjwKg_1778512564
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE5B61800629; Mon, 11 May 2026 15:16:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A411800357; Mon, 11 May 2026 15:16:01 +0000 (UTC)
Date: Mon, 11 May 2026 16:15:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
Message-ID: <agHyrU3vDP73rLzw@redhat.com>
References: <20260501115506.3792110-1-peter.maydell@linaro.org>
 <CAFEAcA8QA32mcVOU+iB7Go40h_RwEtYKyZcOQT4nv1nEY92v+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8QA32mcVOU+iB7Go40h_RwEtYKyZcOQT4nv1nEY92v+w@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 03:47:33PM +0100, Peter Maydell wrote:
> On Fri, 1 May 2026 at 12:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The Python os.setxattr() API is Linux-specific, so trying to use
> > it on other OSes triggers a failure:
> >
> >   File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
> > line 227, in fetch
> >     os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> >     ^^^^^^^^^^^
> > AttributeError: module 'os' has no attribute 'setxattr'
> >
> > Since we only set the attributes here for informational
> > purposes, skip them when os.setxattr() isn't available.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Is anybody going to pick this up via their tree, or should
> I just put it into target-arm.next ?

I have it for my misc queue, but if you want to send a PR now then
consider it to havve

  Acked-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


