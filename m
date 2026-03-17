Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA39FED9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VsV-0005On-OI; Tue, 17 Mar 2026 10:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2VsT-0005OA-T1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2VsQ-0002IB-UE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773759513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYlGddRn/mgrx/tYnayJ8htokC3pVdHHNuzlgBf+DQg=;
 b=Tm+HsmS0RntQb+9Wpou24B1UUZXWMJwunqVXgifhhSjqkVmLuExJt43bfwwXYcnMVs9TxM
 mV9ksQD9c38piccgT18I9ajM57NTQqOXB9bQYPKU4giuN0nqC8Sa3WAsGrijG7lLKJUyvB
 Z67/yAU0qWd5kSjeXgYn2ufH7B3NDUg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576--LarwQHCPOqLTw6wIbYAFQ-1; Tue,
 17 Mar 2026 10:58:31 -0400
X-MC-Unique: -LarwQHCPOqLTw6wIbYAFQ-1
X-Mimecast-MFC-AGG-ID: -LarwQHCPOqLTw6wIbYAFQ_1773759511
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07311944F12
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 14:58:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.252])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 861391800763; Tue, 17 Mar 2026 14:58:28 +0000 (UTC)
Date: Tue, 17 Mar 2026 14:58:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: [PATCH v1] qga: add guest-get-windows-security-info command
Message-ID: <ablsEcXwDIPlMzZb@redhat.com>
References: <20260316123144.1758888-1-eashurov@redhat.com>
 <CAPMcbCr1XmSnHG_KUvDekU=OzKWhuD7=PjHcxB6VmCYrZCqY4Q@mail.gmail.com>
 <ablh_gd57v3vGP6m@redhat.com>
 <CAPMcbCoEL-a_TxCaJO7y7mkPNGR9us-N8mHTQRM=iGiJxTek+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCoEL-a_TxCaJO7y7mkPNGR9us-N8mHTQRM=iGiJxTek+w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 17, 2026 at 04:45:20PM +0200, Kostiantyn Kostiuk wrote:
> On Tue, Mar 17, 2026 at 4:15 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Tue, Mar 17, 2026 at 04:07:59PM +0200, Kostiantyn Kostiuk wrote:
> > > On Mon, Mar 16, 2026 at 2:32 PM Elizabeth Ashurov <eashurov@redhat.com>
> > > wrote:
> > >
> > > > Add a new Windows-only QGA command to retrieve Windows security
> > > > features status including VBS, Secure Boot, and TPM information
> > > > from the guest.
> > > >
> > > > The implementation queries Win32_DeviceGuard and Win32_Tpm via
> > > > WMI, and reads the SecureBoot UEFI variable through
> > > > GetFirmwareEnvironmentVariable().
> > > >
> > > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > > > ---
> > > >  qga/commands-win32.c | 404 +++++++++++++++++++++++++++++++++++++++++++
> > > >  qga/qapi-schema.json |  56 ++++++
> > > >  2 files changed, 460 insertions(+)
> >
> > snip
> >
> > > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > > index c57bc9a02f..f54fdf942f 100644
> > > > --- a/qga/qapi-schema.json
> > > > +++ b/qga/qapi-schema.json
> > > > @@ -1952,3 +1952,59 @@
> > > >    'returns': ['GuestNetworkRoute'],
> > > >    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
> > > >  }
> > > > +
> > > > +##
> > > > +# @GuestWindowsSecurityInfo:
> > > > +#
> > > > +# Windows security features status.
> > > > +#
> > > > +# @vbs-status: VirtualizationBasedSecurityStatus
> > > > +#
> > > > +# @available-security-properties: AvailableSecurityProperties
> > > > +#
> > > > +# @code-integrity-policy-enforcement-status:
> > > > +#     CodeIntegrityPolicyEnforcementStatus
> > > > +#
> > > > +# @required-security-properties: RequiredSecurityProperties
> > > > +#
> > > > +# @security-services-configured: SecurityServicesConfigured
> > > > +#
> > > > +# @security-services-running: SecurityServicesRunning
> > > > +#
> > > > +# @usr-cfg-code-integrity-policy-enforcement-status:
> > > > +#     UsermodeCodeIntegrityPolicyEnforcementStatus
> > > > +#
> > > > +# @secure-boot: Whether UEFI Secure Boot is enabled
> > > > +#
> > > > +# @tpm-present: Whether a TPM device is present
> > > > +#
> > > > +# @tpm-version: TPM specification version string (e.g. "2.0")
> > > > +#
> > > > +# Since: 10.3
> > > > +##
> > > > +{ 'struct': 'GuestWindowsSecurityInfo',
> > > > +  'data': {
> > > > +      'vbs-status': 'int',
> > > > +      '*available-security-properties': ['int'],
> > > > +      '*code-integrity-policy-enforcement-status': 'int',
> > > > +      '*required-security-properties': ['int'],
> > > > +      '*security-services-configured': ['int'],
> > > > +      '*security-services-running': ['int'],
> > > > +      '*usr-cfg-code-integrity-policy-enforcement-status': 'int',
> > > > +      'secure-boot': 'bool',
> > > > +      'tpm-present': 'bool',
> > > > +      '*tpm-version': 'str' },
> > > > +  'if': 'CONFIG_WIN32' }
> > > >
> > > >
> > > Let's make this more generic
> > > command guest-get-security-info
> > > use 'union' to describe OS specific option like VBS
> > > { 'tmp_present': false, 'secure_boot': true, 'os': { 'type': 'windows',
> > > 'vbs': false, .... } }
> > >
> > > make tmp_present, secure_boot, vbs_status optiononal
> > > missing = unknown - as we can have it unimplemented for some POSIX/BSD
> > OSes
> > >
> > > vbs_status is Win10+ only feature, so it can be unknown for Win8
> >
> > I wonder if a new command is justifiable / needed.
> >
> > Should we consider returning more info with 'guest-get-osinfo' ? It
> > is slightly different from the info returned there currently, but
> > at the same time reasonably in scope in the sense that it is
> > essentially reporting a set of OS "feature flags". They happen to
> > be security related in this case, but we could have other feature
> > flags we want to report too in future.
> >
> 
> guest-get-security-info can fail due to WMI issue. If we merge this into
> guest-get-osinfo,
> it means guest-get-osinfo will fail just because of a Windows component
> error. Sounds bad.

In what scenarios would WMI fail, and should we treat that as non-fatal
regardless ? ie indicate that the information is unavailable - that
already appears to be done for the TPM feature, but not the other
security features.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


