Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8612DC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrvF4-0007er-Or; Thu, 06 Aug 2026 06:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wrvET-0007bS-V4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wrvES-00035x-2z
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786011706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HSOxvu1xEhmxC3euC9cfxKv95SRh2F8YsCe2RfSQno=;
 b=RMec2LV5Dqnvj0l8aRJd1729Osutuc4Ih3bcBqlsEfVMsGxdfmlFTqT/jCCoRviSU6nKC1
 ahdhhCoc7sdMHvJIlwfkBTdA26REyLQg8ps63DjZKWG262aa5mEa+6B1YY74j485T1wJiK
 m850uzEnsXFoBSUTKjdyu0MbFblK1lw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-d_cQeOcQMu-x61qMLw6p2w-1; Thu,
 06 Aug 2026 06:21:41 -0400
X-MC-Unique: d_cQeOcQMu-x61qMLw6p2w-1
X-Mimecast-MFC-AGG-ID: d_cQeOcQMu-x61qMLw6p2w_1786011699
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED73D1955BC5; Thu,  6 Aug 2026 10:21:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6459F1800347; Thu,  6 Aug 2026 10:21:35 +0000 (UTC)
Date: Thu, 6 Aug 2026 11:21:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
Message-ID: <anRgKw58IMYoR4p-@redhat.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Wed, Aug 05, 2026 at 12:10:27PM -0700, Pierrick Bouvier wrote:
> On 8/5/2026 9:53 AM, Daniel P. Berrangé wrote:
> > On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
> >> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
> >>> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
> >>>> In the next commits, We'll replace the logic to filter QOM types per
> >>>> target from a static one (based on INTERFACES) to a runtime one, based
> >>>> on is_available() function, that can be overriden per class.
> >>>>
> >>>> Introduce the new interface we'll use for that.
> >>>>
> >>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>>> ---
> >>>>  include/qemu/target-info-qom.h | 15 +++++++++++++++
> >>>>  target-info-qom.c              |  5 +++++
> >>>>  2 files changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> >>>> index 91be415ed33..83eb537333b 100644
> >>>> --- a/include/qemu/target-info-qom.h
> >>>> +++ b/include/qemu/target-info-qom.h
> >>>> @@ -14,6 +14,21 @@
> >>>>  
> >>>>  #define TYPE_TARGET_INFO "target-info"
> >>>>  
> >>>> +#define TYPE_TARGET_SPECIFIC "target-specific"
> >>>> +
> >>>> +typedef struct TargetSpecific TargetSpecific;
> >>>> +
> >>>> +typedef struct TargetSpecificClass {
> >>>> +    InterfaceClass parent_class;
> >>>> +
> >>>> +    bool (*is_available)(void);
> >>>> +} TargetSpecificClass;
> >>>> +
> >>>> +#define TARGET_SPECIFIC(obj) \
> >>>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
> >>>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
> >>>> +                       TYPE_TARGET_SPECIFIC)
> >>>
> >>> Looking through the series,I don't really see the point
> >>> in this interface.   Why is this not possible to do by
> >>> adding 'is_available' to MachineClass.  It would make
> >>> the rest of the series simpler and especially avoid the
> >>> need to introduced yet more series of macros for defining
> >>> machine classes.
> >>>
> >>
> >> We'll need the exact same interface for cpus, and devices also. IMHO, it
> >> makes sense to have this in an external interface, instead of forcing it
> >> to be present in all cpus/devices/machines. I also considered adding it
> >> directly in Object class directly (would be the simplest), but I felt it
> >> would be hard to motivate it.
> > 
> > I don't see a need for the common interface across cpus/devices/etc as
> > as code that's filtering only cares about the specific types. It also
> > definitely doesn't beloong in Object class, but the Object class could
> > be changed to make it simpler.
> >
> 
> We agree on this.
> 
> > The object_class_get_list() method could get a 'bool filter(ObjectClass *cl)'
> > callback which could be invoked on each class to filter it.
> > 
> > That said I find it pretty undesirable as an approach that we're
> > registering classes that can't then be used in a given situation.
> > This has a ripple effect where every bit of code that iterates over
> > classes needs changing to add filtering after the fact. It is also
> > not great for scalability, as it means every QEMU process will have
> > the union of all classes for all targets registered, most of which
> > have to be discarded / ignored at runtime.
> >
> 
> This is inherent to the nature of having a single binary.
> We need to cover those two requirements:
> 1. having a filter mechanism (per target)
> 2. have all the classes accessible for the heterogeneous machines that
> will be coming in the future
> 
> 1. could be covered by what you describe, however, it breaks 2. For
> this, you need to be able to register all types by design.


Even the heterogeneous machines aren't going to need all the
classes from all 30+ targets that QEMU supports.

IIUC, the current approach relies on '--target <blah>' to select
which target we need. Would the heterogeneous machines not just
change that to allow "--target <this> --target <that>". It still
looks like we should be able to significantly limit  what we
register for heterogeneous machines.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


