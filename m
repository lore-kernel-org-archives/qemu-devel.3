Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D961CEF14A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 09:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy6xX-0006MK-RA; Tue, 08 Oct 2024 05:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sy6xU-0006HN-9g
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sy6xS-0002QM-ND
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728381405;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oQdtNkAE0kDx5DrXc/I4IMXe1U6j2nR35UVUEf8LZQ=;
 b=IuD7el01HLOHYri5vdQUvo06r2hLdGdngA+KniqbcdCX06Dg0DYmcJLAugQyZp50kopBii
 VQ46kGBU983LnyDJQytWbDSYesE3FbpaPdFI4OUc7IYHwzSmSqnSQnylU3GQrSrjSM8NJZ
 SnfP/Ekl36trugI8Gs2pJ31Q5pF7/Uo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-78s_xC9FOUiEhH_BsaYiXQ-1; Tue,
 08 Oct 2024 05:56:43 -0400
X-MC-Unique: 78s_xC9FOUiEhH_BsaYiXQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A18D1944D31; Tue,  8 Oct 2024 09:56:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D14ED19560AA; Tue,  8 Oct 2024 09:56:33 +0000 (UTC)
Date: Tue, 8 Oct 2024 10:56:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
Message-ID: <ZwUBsy0HVI2egm7p@redhat.com>
References: <20241007171717.1436982-1-pbonzini@redhat.com>
 <ZwQmDzjojjAs-dQR@redhat.com>
 <CABgObfYPHFyBShEY2Qxdg+2yG_7aXp-cN8rdkMB8Ha8v1Qe=Ew@mail.gmail.com>
 <ZwT5U2FsG6ugWZVu@redhat.com>
 <CABgObfZHMAT18nCgtfKDuu96WN__ZNMJizOvVqFLMMNa=Zn5uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZHMAT18nCgtfKDuu96WN__ZNMJizOvVqFLMMNa=Zn5uA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 08, 2024 at 11:45:49AM +0200, Paolo Bonzini wrote:
> On Tue, Oct 8, 2024 at 11:20 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Tue, Oct 08, 2024 at 11:03:47AM +0200, Paolo Bonzini wrote:
> > > Ok, I'll work on adding bindgen support to lcitool and then do this as
> > > a separate submission.
> >
> > FYI, lcitool already has a package mapping for 'bindgen' defined as Alex
> > added that for QEMU's benefit a few months back :-)
> 
> Hmm, it's missing on SLES15. I wonder if we need to add support for
> cargo install, following the model I used in this series.

Yes, that could work as a special case, but we don't need to worry
about that until we enable rust by default later.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


