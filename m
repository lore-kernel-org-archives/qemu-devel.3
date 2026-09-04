Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6775CC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MUw-0006DY-R6; Fri, 04 Sep 2026 01:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x2MUu-0006DK-AW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x2MUs-0002k1-Fw
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788499793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8Dp4OEHE4PQFg3Th8GenXljeg76pHdsrU4kpFRBhPw=;
 b=g3lCiJugg1lZv7vt2QocaEtywh4/Ras1LVZO0asfQU1KODAg7103u2AQW2xoMTEL6+vBdV
 PgiW0uy8pBLg6gvdXtoLfrtjnQ3U6SdAL1STgyPS5zSiwMvMVTgPYRE11o2DaJonRVGOb9
 OkPGie2iw2YXI5SwT4WZ3HUCL5r7Re0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-HvncyaaoPsaKWPeBlRNW2Q-1; Fri,
 04 Sep 2026 01:29:49 -0400
X-MC-Unique: HvncyaaoPsaKWPeBlRNW2Q-1
X-Mimecast-MFC-AGG-ID: HvncyaaoPsaKWPeBlRNW2Q_1788499788
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AD9B195F17D; Fri,  4 Sep 2026 05:29:48 +0000 (UTC)
Received: from ghoffman.nuc.csb.home.kraxel.org
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D55DE1956049; Fri,  4 Sep 2026 05:29:47 +0000 (UTC)
Received: by ghoffman.nuc.csb.home.kraxel.org (Postfix, from userid 11758)
 id 53E474006269; Fri, 04 Sep 2026 07:29:45 +0200 (CEST)
Date: Fri, 4 Sep 2026 07:29:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Message-ID: <appWT4FHRUc2j6BA@ghoffman-na.rmtde.csb>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
 <aplMPpjG6X__JZeM@sgarzare-redhat>
 <aplPIuIgLYKofjGq@leonardi-redhat>
 <apl2D4DKmfHohZdF@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl2D4DKmfHohZdF@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 03:55:31PM +0200, Stefano Garzarella wrote:
> On Thu, Sep 03, 2026 at 12:47:00PM +0200, Luigi Leonardi wrote:
> > On Thu, Sep 03, 2026 at 12:32:21PM +0200, Stefano Garzarella wrote:
> > > On Tue, Sep 01, 2026 at 12:09:18PM +0200, Luigi Leonardi wrote:
> > > > The guest policy must be provided at guest launch start: LAUNCH_START for
> > > > SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
> > > > specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
> > > > specification, section 4.3 (Guest Policy).
> > > > 
> > > > The policy parameter in set_guest_policy was never effective: by the
> > > > time this callback runs, LAUNCH_START has already been issued for both
> > > > SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
> > > > sev_guest->policy has no effect. In practice the only thing this
> > > > callback actually does is set the ID block and ID auth for SNP's
> > > > LAUNCH_FINISH, so rename it to set_id_block to reflect its real
> > > > purpose, remove the unused policy parameter, and drop the non-SNP code
> > > > path which was entirely dead.
> > > > 
> > > > This is preliminary work: actually forwarding the guest policy to the
> > > > platform before LAUNCH_START is added in a later commit.
> > > 
> > > IIUC the behaviour is the same after this patch, but IMO better to
> > > clarify.
> > 
> > Yep, will do.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > > > ---
> > > > backends/confidential-guest-support.c       |  12 ++-
> > > > backends/igvm.c                             |   6 +-
> > > > include/system/confidential-guest-support.h |  28 ++++---
> > > > target/i386/sev.c                           | 118 +++++++++++-----------------
> > > > 4 files changed, 67 insertions(+), 97 deletions(-)
> > > > 
> > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> > > > index 156dd15e66..a0b36d2da5 100644
> > > > --- a/backends/confidential-guest-support.c
> > > > +++ b/backends/confidential-guest-support.c
> > > > @@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
> > > >   return -1;
> > > > }
> > > > 
> > > > -static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> > > > -                            uint64_t policy,
> > > > -                            void *policy_data1, uint32_t policy_data1_size,
> > > > -                            void *policy_data2, uint32_t policy_data2_size,
> > > > -                            Error **errp)
> > > > +static int set_id_block(void *id_block, uint32_t id_block_size,
> > > > +                        void *id_auth, uint32_t id_auth_size,
> > > > +                        Error **errp)
> > > > {
> > > >   error_setg(errp,
> > > > -               "Setting confidential guest policy is not supported for this platform");
> > > > +               "Setting ID block is not supported for this platform");
> > > >   return -1;
> > > > }
> > > > 
> > > > @@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
> > > >   ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> > > >   cgsc->check_support = check_support;
> > > >   cgsc->set_guest_state = set_guest_state;
> > > > -    cgsc->set_guest_policy = set_guest_policy;
> > > > +    cgsc->set_id_block = set_id_block;
> > > >   cgsc->get_mem_map_entry = get_mem_map_entry;
> > > > }
> > > > 
> > > > diff --git a/backends/igvm.c b/backends/igvm.c
> > > > index 7b7bdc72b7..85de0d54ec 100644
> > > > --- a/backends/igvm.c
> > > > +++ b/backends/igvm.c
> > > > @@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
> > > >           id_block_len = sizeof(struct sev_id_block);
> > > >           id_auth_len = sizeof(struct sev_id_authentication);
> > > >       }
> > > > -        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
> > > > ctx->sev_policy,
> > > > -                                          ctx->id_block, id_block_len,
> > > > -                                          ctx->id_auth, id_auth_len, errp);
> > > > +
> > > > +        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
> > > > +                                       ctx->id_auth, id_auth_len, errp);
> > > >   }
> > > >   return 0;
> > > > }
> > > > diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
> > > > index 5dca717308..6d35ddb97a 100644
> > > > --- a/include/system/confidential-guest-support.h
> > > > +++ b/include/system/confidential-guest-support.h
> > > > @@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
> > > >                          uint16_t cpu_index, Error **errp);
> > > > 
> > > >   /*
> > > > -     * Set the guest policy. The policy can be used to configure the
> > > > -     * confidential platform, such as if debug is enabled or not and can contain
> > > > -     * information about expected launch measurements, signed verification of
> > > > -     * guest configuration and other platform data.
> > > > -     *
> > > > -     * The format of the policy data is specific to each platform. For example,
> > > > -     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
> > > > -     * ID block and ID authentication in the 'policy_data' parameters. The type
> > > > -     * of policy data is identified by the 'policy_type' argument.
> > > > +     * Set the guest policy for the confidential platform. The policy
> > > > +     * configures properties of the guest, such as whether debug is
> > > > +     * enabled. Its format is platform-specific; for SEV/SEV-ES and
> > > > +     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
> > > > +     * so the policy is in effect for launch.
> > > >    */
> > > >   int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
> > > 
> > > I'm confused, this commit says "rename set_guest_policy to set_id_block"
> > > so why this callback is still here?
> > > 
> > 
> > We will need this callback in a following patch, so I thought that removing
> > it to then add it again was pointless. If you prefer I can go this
> > route, or I can specify it in the commit message.
> 
> I see your point about avoiding remove and re-add the callback, but
> self-contained commits aren't a matter of preference or taste, they're
> a maintainability requirement. A callback declared but unimplemented
> across three commits leaves the API in an incomplete state.
> 
> Please move the set_guest_policy declaration where it's first used.

A typical and good way to handle cases like this (a fix needs some code
reorganization) is to split that into two patches:  First patch does
the code reorganization without functional change (in this case: split
one callback into two), then have a relatively small patch with the
actual bugfix (move one of the two callback calls to another place).

take care,
  Gerd


