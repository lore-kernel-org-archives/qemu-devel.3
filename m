Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C410C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxM4-0001Lu-Ks; Wed, 20 Mar 2024 10:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmxM2-0001Jc-BH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmxLz-0004v4-SD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710946539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMve2G1FefKyMNUQ145tH4K1aI4it5RSr2l3PA5qcB8=;
 b=ajNXCwVWyyGczd8eqGjFIz8boKIje3P5Cq8nHzBK3Ur7jasJ5WkFokHsZMtBsdsejU61WI
 s4mYnOzxGgVacT9G04x/d+cVMdIXNhjZNFQD79AbbfGTxLc1PJZXrZy+rgNPk0FKdCf6Xw
 eyIS24PLMedLjnH/2wZIljrqTTK5PT8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-6GHbGWcdNtamxN0XfmC0nQ-1; Wed,
 20 Mar 2024 10:55:35 -0400
X-MC-Unique: 6GHbGWcdNtamxN0XfmC0nQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92A221C54464;
 Wed, 20 Mar 2024 14:55:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 826B417A91;
 Wed, 20 Mar 2024 14:55:30 +0000 (UTC)
Date: Wed, 20 Mar 2024 14:55:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 2/9] backends/confidential-guest-support: Add IGVM file
 parameter
Message-ID: <Zfr43LCD4A-Td8o0@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <26c2bb5f2de41471dde304223cd943215d3183c5.1709044754.git.roy.hopkins@suse.com>
 <4ayfzr7mwmb2smh5jdwnimasmvazmozeo7kn7x2oojaqreijjn@myyxobx4rml4>
 <e68e95c67048c732f15d54f7bd75732c749072f9.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e68e95c67048c732f15d54f7bd75732c749072f9.camel@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 20, 2024 at 02:44:17PM +0000, Roy Hopkins wrote:
> On Tue, 2024-03-19 at 16:10 +0100, Stefano Garzarella wrote:
> > On Tue, Feb 27, 2024 at 02:50:08PM +0000, Roy Hopkins wrote:
> > > In order to add support for parsing IGVM files for secure virtual
> > > machines, a the path to an IGVM file needs to be specified as
> > > part of the guest configuration. It makes sense to add this to
> > > the ConfidentialGuestSupport object as this is common to all secure
> > > virtual machines that potentially could support IGVM based
> > > configuration.
> > > 
> > > This patch allows the filename to be configured via the QEMU
> > > object model in preparation for subsequent patches that will read and
> > > parse the IGVM file.
> > > 
> > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > ---
> > > backends/confidential-guest-support.c     | 21 +++++++++++++++++++++
> > > include/exec/confidential-guest-support.h |  9 +++++++++
> > > qapi/qom.json                             | 13 +++++++++++++
> > > qemu-options.hx                           |  8 +++++++-
> > > 4 files changed, 50 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-
> > > guest-support.c
> > > index 052fde8db0..da436fb736 100644
> > > --- a/backends/confidential-guest-support.c
> > > +++ b/backends/confidential-guest-support.c
> > > @@ -20,8 +20,29 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
> > >                             CONFIDENTIAL_GUEST_SUPPORT,
> > >                             OBJECT)
> > > 
> > > +#if defined(CONFIG_IGVM)
> > > +static char *get_igvm(Object *obj, Error **errp)
> > > +{
> > > +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> > > +    return g_strdup(cgs->igvm_filename);
> > > +}
> > > +
> > > +static void set_igvm(Object *obj, const char *value, Error **errp)
> > > +{
> > > +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> > > +    g_free(cgs->igvm_filename);
> > > +    cgs->igvm_filename = g_strdup(value);
> > > +}
> > > +#endif
> > > +
> > > static void confidential_guest_support_class_init(ObjectClass *oc, void
> > > *data)
> > > {
> > > +#if defined(CONFIG_IGVM)
> > > +    object_class_property_add_str(oc, "igvm-file",
> > > +        get_igvm, set_igvm);
> > > +    object_class_property_set_description(oc, "igvm-file",
> > > +        "Set the IGVM filename to use");
> > > +#endif
> > > }
> > > 
> > > static void confidential_guest_support_init(Object *obj)
> > > diff --git a/include/exec/confidential-guest-support.h
> > > b/include/exec/confidential-guest-support.h
> > > index ba2dd4b5df..b08ad8de4d 100644
> > > --- a/include/exec/confidential-guest-support.h
> > > +++ b/include/exec/confidential-guest-support.h
> > > @@ -51,6 +51,15 @@ struct ConfidentialGuestSupport {
> > >      * so 'ready' is not set, we'll abort.
> > >      */
> > >     bool ready;
> > > +
> > > +#if defined(CONFIG_IGVM)
> > > +    /*
> > > +     * igvm_filename: Optional filename that specifies a file that contains
> > > +     *                the configuration of the guest in Isolated Guest
> > > +     *                Virtual Machine (IGVM) format.
> > > +     */
> > > +    char *igvm_filename;
> > > +#endif
> > > };
> > > 
> > > typedef struct ConfidentialGuestSupportClass {
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index 2a6e49365a..570bdd7d55 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -859,6 +859,18 @@
> > >   'base': 'RngProperties',
> > >   'data': { '*filename': 'str' } }
> > > 
> > > +##
> > > +# @ConfidentialGuestProperties:
> > > +#
> > > +# Properties common to objects that are derivatives of confidential-guest-
> > > support.
> > > +#
> > > +# @igvm-file: IGVM file to use to configure guest (default: none)
> > > +#
> > > +# Since: 8.2
> > 
> > Should it be 9.0 or maybe 9.1 ?
> 
> Good question. Obviously it is hard to predict which version this will
> potentially land in. I can update it to 9.1 because it is unlikely to be in any
> version prior to this, but what is the normal convention for choosing a version
> number here?

Pick the version number that is soonest release accepting merge
of features.

IOW, most of the time you can pick the version number in current
QEMU git master HEAD. During release freeze (ie right now), you
have to pick the next version number, since features aren't accepted
during freeze.

So choosing '9.1' right now is correct.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


