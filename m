Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A8EC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Dy-00080d-AD; Fri, 25 Sep 2026 11:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA8Du-0007zV-4b
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA8Dr-00062F-OW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790351545;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpFse7rrEPitovkApIlW7GzKI4ztmXF8hT5DQwLbuj0=;
 b=C7Tc36rL4hQjUJb3uU7iDOEDZS1xC6qLzqq282YQxzfHD4Vz3JAWvKYRkl2vHrMPLsijkx
 kqSAmj5l4aZlUSYWHHs2JzkoTB0vjKFJom9DXluEDVPFM/xTfpfLR4wJGezmU6AYSKfu3M
 4W6ILeHmraA2mNtYfvIzm5nAp7UPd1w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-KKnc4k3bOji1GIWih6pwIQ-1; Fri,
 25 Sep 2026 11:52:21 -0400
X-MC-Unique: KKnc4k3bOji1GIWih6pwIQ-1
X-Mimecast-MFC-AGG-ID: KKnc4k3bOji1GIWih6pwIQ_1790351540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BF471883056; Fri, 25 Sep 2026 15:52:20 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585F830002D6; Fri, 25 Sep 2026 15:52:18 +0000 (UTC)
Date: Fri, 25 Sep 2026 16:52:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/4] tests/tcg/meson.build: introduce cc_alt (alternative
 cross compiler)
Message-ID: <araYr9QGHATaZm5N@redhat.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260924213942.26491-3-pierrick.bouvier@oss.qualcomm.com>
 <arZBMfW-1WcpjNZs@redhat.com>
 <b1e1ffe5-a7ce-44be-96ed-b425c15cb10c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1e1ffe5-a7ce-44be-96ed-b425c15cb10c@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 25, 2026 at 08:17:04AM -0700, Pierrick Bouvier wrote:
> On 9/25/2026 2:38 AM, Daniel P. Berrangé wrote:
> > On Thu, Sep 24, 2026 at 09:39:40PM +0000, Pierrick Bouvier wrote:
> >> This allows each target to provide an additional list of cross
> >> compilers to check. With this, we can detect default cc for common
> >> setups (debian/fedora/macos) without user having to provide a
> >> --cross-cc-* option.
> >>
> >> In addition, it allows us to pick up host compilers for various hosts.
> >> (debian and archlinux have $arch-linux-gnu-gcc installed
> >> with gcc package by default, but not fedora).
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  tests/tcg/meson.build | 46 +++++++++++++++++++++++++------------------
> >>  1 file changed, 27 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> >> index 0006d192cab..59ab73e1d10 100644
> >> --- a/tests/tcg/meson.build
> >> +++ b/tests/tcg/meson.build
> >> @@ -21,6 +21,7 @@ tcg_tests = {}
> >>  # {
> >>  #   'name_of_target': {
> >>  #     'cc': 'cross_compiler',
> >> +#     'cc_alt': ['list of alternative cross compilers', ...]
> >>  #     'cc_dockerfile': 'name_of_dockerfile',
> >>  #     'cc_feat_cflags': {
> >>  #       'name': ['feature cflags'],
> >> @@ -210,7 +211,7 @@ foreach target, plan: tcg_tests
> >>  
> >>    # return a clear error if user misspell a target entry
> >>    foreach key, _ : plan
> >> -    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
> >> +    allowed = ['cc', 'cc_alt', 'cc_dockerfile', 'cc_feat_cflags',
> >>                 'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
> >>      if key not in allowed
> >>        error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
> >> @@ -218,15 +219,18 @@ foreach target, plan: tcg_tests
> >>      endif
> >>    endforeach
> >>  
> >> -  cc = find_program(plan['cc'], required : false)
> >> +  cc_list = [plan['cc']]
> >> +  if 'cc_alt' in plan
> >> +    cc_list += plan['cc_alt']
> >> +  endif
> > 
> > If you're combining these into a list anyway, why not just
> > have 'cc' be a list of CC names to begin with and not bother
> > with a separate 'cc_alt' field ?
> > 
> 
> It's just a semantic choice, since cc has to be provided in docker
> container, while cc_alt do not. I can add a comment if it makes sense
> for you with this explanation.

Ok, I don't mind, was just wondering if there was some reason I
was missing for the separation.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


