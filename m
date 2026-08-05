Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD7EC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wresJ-0007rz-0x; Wed, 05 Aug 2026 12:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wresH-0007Vv-Gj
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wresE-0003Vj-Lg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785948824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGwSfQK33iJ8EYZmDWQQyicgq+hSomf9oLA8U/o3Gaw=;
 b=ZMA/6JP7g9QphudzJUDsIh76zY7G3JXu3YO8y8U6n86qGytE9BubRmxWkEH/DRjbnNcBVr
 iVJiUxSuKcsaBJKLmZkr8f20mssiGouf94DCqliig1qRIIleKyykBvVFmYTm8x42Me+0W/
 4bqjmTrm5s3PV2oQHYzM7MDQjz9PEmY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-fVJIa4m7OgWL33EC1pHtMw-1; Wed,
 05 Aug 2026 12:53:35 -0400
X-MC-Unique: fVJIa4m7OgWL33EC1pHtMw-1
X-Mimecast-MFC-AGG-ID: fVJIa4m7OgWL33EC1pHtMw_1785948814
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5401800846; Wed,  5 Aug 2026 16:53:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5917219560AB; Wed,  5 Aug 2026 16:53:30 +0000 (UTC)
Date: Wed, 5 Aug 2026 17:53:26 +0100
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
Message-ID: <anNqhjSU5tEDC0br@redhat.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
> > On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
> >> In the next commits, We'll replace the logic to filter QOM types per
> >> target from a static one (based on INTERFACES) to a runtime one, based
> >> on is_available() function, that can be overriden per class.
> >>
> >> Introduce the new interface we'll use for that.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  include/qemu/target-info-qom.h | 15 +++++++++++++++
> >>  target-info-qom.c              |  5 +++++
> >>  2 files changed, 20 insertions(+)
> >>
> >> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> >> index 91be415ed33..83eb537333b 100644
> >> --- a/include/qemu/target-info-qom.h
> >> +++ b/include/qemu/target-info-qom.h
> >> @@ -14,6 +14,21 @@
> >>  
> >>  #define TYPE_TARGET_INFO "target-info"
> >>  
> >> +#define TYPE_TARGET_SPECIFIC "target-specific"
> >> +
> >> +typedef struct TargetSpecific TargetSpecific;
> >> +
> >> +typedef struct TargetSpecificClass {
> >> +    InterfaceClass parent_class;
> >> +
> >> +    bool (*is_available)(void);
> >> +} TargetSpecificClass;
> >> +
> >> +#define TARGET_SPECIFIC(obj) \
> >> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
> >> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
> >> +                       TYPE_TARGET_SPECIFIC)
> > 
> > Looking through the series,I don't really see the point
> > in this interface.   Why is this not possible to do by
> > adding 'is_available' to MachineClass.  It would make
> > the rest of the series simpler and especially avoid the
> > need to introduced yet more series of macros for defining
> > machine classes.
> >
> 
> We'll need the exact same interface for cpus, and devices also. IMHO, it
> makes sense to have this in an external interface, instead of forcing it
> to be present in all cpus/devices/machines. I also considered adding it
> directly in Object class directly (would be the simplest), but I felt it
> would be hard to motivate it.

I don't see a need for the common interface across cpus/devices/etc as
as code that's filtering only cares about the specific types. It also
definitely doesn't beloong in Object class, but the Object class could
be changed to make it simpler.

The object_class_get_list() method could get a 'bool filter(ObjectClass *cl)'
callback which could be invoked on each class to filter it.

That said I find it pretty undesirable as an approach that we're
registering classes that can't then be used in a given situation.
This has a ripple effect where every bit of code that iterates over
classes needs changing to add filtering after the fact. It is also
not great for scalability, as it means every QEMU process will have
the union of all classes for all targets registered, most of which
have to be discarded / ignored at runtime.


IMHO we should never register the classes to begin with.

The trick is dealing with dependencies/ordering during early startup.

eg taking one random example:

  static void zynq_machine_register_types(void)
  {
      type_register_static(&zynq_machine_type);
  }

IMHO we ought to be able to say in that:

  static void zynq_machine_register_types(void)
  {
      if (target_arm()) {
        type_register_static(&zynq_machine_type);
      }
  }

The problem is target_arm() depends on having parsed the '-target'
argument. The type register methods are called from qemu_init_subsystems(),
which is called before we have done CLI parsing. This looks fixable
though. We already have two iterations over argv in qemu_init().

We can move qemu_init_subsystems after the first iteration, and
process -target in the first iteration.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


