Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE82FD132D5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yUk-0006cd-1Y; Mon, 04 Nov 2024 09:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7yUX-0006be-2v
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7yUU-00066o-6L
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730732136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BIl1wV/POGxRVvJ/xgu9mieQi4BcYqsNXyUVVHmJCY=;
 b=Vc6ULyCB4USLP4yTTQccAPGmUSdtjQRItkCRKRsFIw3MfNLh7aKQ2NiEy10WxHV8HyLk3B
 gnHMaOpOSF10pXOAeAOHkF+omXFh/6EZU1VzHm7JJpbI5zaaYc7A+yLEusgGMS8EnH53PS
 uzS3fcdkfr1KxtnTb0sOfqdqt09lBgw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-ZgtPKhoHMHKsmHdXECW89g-1; Mon,
 04 Nov 2024 09:55:33 -0500
X-MC-Unique: ZgtPKhoHMHKsmHdXECW89g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABBC71956058; Mon,  4 Nov 2024 14:55:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.152])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70DD219560A2; Mon,  4 Nov 2024 14:55:24 +0000 (UTC)
Date: Mon, 4 Nov 2024 14:55:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Message-ID: <ZyjgWJ3bZ69sueE2@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com> <87y128nrfr.fsf@redhat.com>
 <Zx-3OUioG1l47hW3@redhat.com>
 <24ca0278-5018-41e3-a097-ac560a16f8fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24ca0278-5018-41e3-a097-ac560a16f8fa@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 04, 2024 at 03:45:13PM +0100, Eric Auger wrote:
> Hi
> 
> On 10/28/24 17:09, Daniel P. Berrangé wrote:
> > On Mon, Oct 28, 2024 at 05:05:44PM +0100, Cornelia Huck wrote:
> >> On Fri, Oct 25 2024, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>
> >>> On Fri, Oct 25, 2024 at 03:28:35PM +0200, Eric Auger wrote:
> >>>> Hi Daniel,
> >>>>
> >>>> On 10/25/24 15:13, Daniel P. Berrangé wrote:
> >>>>> On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
> >>>>>> From: Cornelia Huck <cohuck@redhat.com>
> >>>>>>
> >>>>>> Add some documentation for the custom model.
> >>>>>>
> >>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>>>>> ---
> >>>>>>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
> >>>>>>  1 file changed, 47 insertions(+), 8 deletions(-)
> >>>>>> @@ -167,6 +196,16 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
> >>>>>>  properties have special semantics (see "SVE CPU Property Parsing
> >>>>>>  Semantics").
> >>>>>>  
> >>>>>> +The ``custom`` CPU model needs to be configured via individual ID register
> >>>>>> +field properties, for example::
> >>>>>> +
> >>>>>> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> >>>>>> +
> >>>>>> +This forces ID_AA64ISAR0_EL1 DP field to 0.
> >>>>> What is the "baseline" featureset implied by 'custom' ?
> >>>> there is no baseline at the moment. By default this is a host
> >>>> passthrough model.
> >>> Why do we need to create "custom" at all, as opposed to just letting
> >>> users toggle features on "-cpu host" ? 
> >> We could consolidate that to the current "host" model, once we figure
> >> out how to handle the currently already existing properties. Models
> >> based on the different architecture extensions would probably be more
> >> useable in the long run; maybe "custom" has a place for testing.
> > If you can set the features against "host", then any testing could
> > be done with "host" surely, making 'custom' pointless ?
> Yeah I do agree that we may not need to introduce this "custom" model
> bus just enhance the custom host model with the capability to tweek some
> features. For instance we have the case where migration between 2 Ampere
> systems fails with host model but if you tweek 1 field in CTR_EL0 it
> passes. So I think in itself this modality can be useful. Same for
> debug/test purpose. As mentionned in the cover letter the number of
> writable ID regs continue to grow and this enhanced host model gives
> flexibility to test new support and may provide enhanced debug
> capabilities for migration (getting a straight understanding of which ID
> reg field(s) causes the migration failure could be helpful I think)

FYI, in x86 target the -cpu command has had a "migratable=bool" property
for a long time , which defaults to 'true' for 'host' model. This causes
QEMU to explicitly drop features which would otherwise prevent migration
between two hosts with identical physical CPUs.

IOW, if there are some bits present in 'host' that cause migration
problems on Ampere hosts, ideally either QEMU (or KVM kmod) would
detect them and turn them off automatically if migratable=true is
set. See commit message in 84f1b92f & 120eee7d1fd for some background
info

NB "migratable" is defined in i386 target code today, but conceptually
we should expand/move that to apply to all targets for consistency,
even if it is effectively a no-op some targets (eg if they are
guaranteed migratable out of the box already with '-cpu host').

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


