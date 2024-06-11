Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFC3C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwSq-0004gE-BE; Tue, 11 Jun 2024 04:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGwSl-0004YH-95
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGwSj-000779-4y
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718092953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gOIMo7agRsQ1q9S/U/C6xOuQiN0B0LBlbYxEE6Uqm3g=;
 b=c9VDw5bp4k9Bn6hgao1kJZhhBq+5eP4jfyidyxTgdTNo3nnA2N+uxSJokVQI8D/GI9NfJP
 DjnNTemEOszVRfSughrDbECLNzSjzDkz54IoVaRH1Cq/2a11J/xHhRidpetRVNRylKw3yN
 Cp3wRwcVMpEzXCuyX9Z5RTFAPGDaf7M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-r0Hf-Q0JNBq9g-Sqkf0Z5w-1; Tue,
 11 Jun 2024 04:02:27 -0400
X-MC-Unique: r0Hf-Q0JNBq9g-Sqkf0Z5w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07D5519560B4; Tue, 11 Jun 2024 08:02:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C44719560AA; Tue, 11 Jun 2024 08:02:21 +0000 (UTC)
Date: Tue, 11 Jun 2024 09:02:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmgEiiyLbxVgjitc@redhat.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <evt7n.ggoypj31l14q@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
> > > The staticlib artifact contains a bunch of mangled .o objects?
> > > ==============================================================
> > > [staticlibmangledobjects] Back to [TOC]
> > > 
> > > Yes, until we compile without the `std` module library or we compile it
> > > manually instead of linking it, we will have some junk in it.
> > > 
> > 
> > Besides the size aspect, which potential advantage would there be to
> > switch to no_std?
> > We don't build a bare metal or kernel binary here, so why introduce this
> > restriction willingly?
> 
> We'll see that as we progress. Might enable more platform support, for
> example. I have no definite answers here. Also, I know binary bloat is a big
> complaint from people with dislike of Rust, so I pre-emptively addressed it.

Requiring 'no_std' would significantly limit what 3rd party crates QEMU
can make use of, and thus would put more burden on QEMU maintainers.
I don't find "binary bloat" a credible technical argument on its own
either, so certainly not sufficient justification to take on the pain
of 'no_std'.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


