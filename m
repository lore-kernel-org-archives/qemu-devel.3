Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE88C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9hD-0006tG-A6; Mon, 04 Mar 2024 09:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh9hB-0006sy-Qx
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh9hA-0007zL-6P
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709564012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrGcuJnTFPsaL/eSFEj2V+HX589aeCr3iofM64ssxwU=;
 b=irDYllUCG7ja1iklFcdC/f2pwwP22mvohIBOOrXG87YVeyLbBQKZPs2kZm/JdKkL61JuJL
 gdzXVw72rK6rwrEs9kmVUJqBdU/4T2cs9gj4WdnHmgJeFGWj5+SBuBJU/lMpqz51qolmmA
 +nPFi4+HYbvFhWUt8nJP05SA4hbgT8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-JmU-gcJVPRKWpEPTLiiwHg-1; Mon, 04 Mar 2024 09:53:30 -0500
X-MC-Unique: JmU-gcJVPRKWpEPTLiiwHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 558C5869ECD;
 Mon,  4 Mar 2024 14:53:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F86F200AD76;
 Mon,  4 Mar 2024 14:53:27 +0000 (UTC)
Date: Mon, 4 Mar 2024 14:53:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/2] gitlab: update FreeBSD Cirrus CI image to 13.3
Message-ID: <ZeXgZbB5ijUMSEiP@redhat.com>
References: <20240304144456.3825935-1-berrange@redhat.com>
 <20240304144456.3825935-3-berrange@redhat.com>
 <CAFEAcA_92-kjjf2L_Z-+w+GX=kCQU+OnLMYp44eLwj8w2T-fpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_92-kjjf2L_Z-+w+GX=kCQU+OnLMYp44eLwj8w2T-fpA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 02:49:28PM +0000, Peter Maydell wrote:
> On Mon, 4 Mar 2024 at 14:46, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The 13.2 images have been deleted from gcloud
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/cirrus.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > index 64f2e25afa..b45f9de62f 100644
> > --- a/.gitlab-ci.d/cirrus.yml
> > +++ b/.gitlab-ci.d/cirrus.yml
> > @@ -52,7 +52,7 @@ x64-freebsd-13-build:
> >      NAME: freebsd-13
> >      CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
> >      CIRRUS_VM_IMAGE_SELECTOR: image_family
> > -    CIRRUS_VM_IMAGE_NAME: freebsd-13-2
> > +    CIRRUS_VM_IMAGE_NAME: freebsd-13-3
> >      CIRRUS_VM_CPUS: 8
> >      CIRRUS_VM_RAM: 8G
> >      UPDATE_COMMAND: pkg update; pkg upgrade -y
> > --
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> This one should be tagged
> Cc: qemu-stable@nongnu.org
> I guess?

Yes, this will be applicable to stable.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


