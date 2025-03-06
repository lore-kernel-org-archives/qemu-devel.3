Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66554C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 12:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqA7K-0001JH-5v; Thu, 06 Mar 2025 07:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqA7C-0001G3-Rk
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqA7B-0003SA-29
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741263252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nS+3xFPXcMVz8qCgElJuiE63kZ9Kx19R5+2J2b0MPd0=;
 b=QhMMDV5ierU3fFBzUQFJFSnfiIP6ibktUaJipylFNFZLjyQ7wOyHNIjkhwa801JdN9kOWC
 XR7gvN/LMopylCG4RRqZuWVVWpO/nS6Cr2Z/1jGcnUTK48fwofdS6W6m61DNFfhUzOqjxM
 J/6DJ5MtvCWxHNempVDHV8dtwAsTUiM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-MuEFQ1AHOmeDZF6t82db0w-1; Thu,
 06 Mar 2025 07:13:55 -0500
X-MC-Unique: MuEFQ1AHOmeDZF6t82db0w-1
X-Mimecast-MFC-AGG-ID: MuEFQ1AHOmeDZF6t82db0w_1741263234
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE451954B39; Thu,  6 Mar 2025 12:13:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27B051800373; Thu,  6 Mar 2025 12:13:51 +0000 (UTC)
Date: Thu, 6 Mar 2025 12:13:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
Message-ID: <Z8mRfNqcU_sic6_m@redhat.com>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <b2971494-525a-4d39-820d-7bb8905d60d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2971494-525a-4d39-820d-7bb8905d60d5@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Wed, Mar 05, 2025 at 05:56:46PM -0800, Richard Henderson wrote:
> On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
> > +void legacy_binary_info_init(const char *argv0)
> > +{
> > +    g_auto(GStrv) tokens = g_strsplit(argv0, G_DIR_SEPARATOR_S, -1);
> > +    unsigned count = 0;
> > +    const char *binary_name;
> > +
> > +    while (tokens[count]) {
> > +        count++;
> > +    }
> > +    assert(count > 0);
> > +    binary_name = tokens[count - 1];
> 
> This is g_path_get_basename().
> 
> > +
> > +    for (size_t i = 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
> > +        if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
> > +            current_index = i;
> > +            return;
> > +        }
> > +    }
> > +    fprintf(stderr, "Missing legacy info for '%s' binary.\n", binary_name);
> > +    abort();
> > +}
> 
> I'm with Paolo that this should not abort here; Error is better.
> Even if the caller supplies error_fatal.
> 
> When testing for errors before and after a patch, I often rename
> the binary, e.g. qemu-system-aarch64-good / qemu-system-aarch64-bad.
> Leaving it in the same build directory is required in order to let
> it find the uninstalled rom images.
> 
> Is there a way we can preserve something akin to this?

Replacign !strcmp with  g_str_has_prefix in the above code would be
an simple option to preseve the use of custom suffixes, along with
special casing on existence of 'kvm' in the name.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


