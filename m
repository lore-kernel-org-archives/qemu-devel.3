Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A641D6B6C4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 19:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6E3L-0004MA-Bw; Wed, 30 Oct 2024 15:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6E3J-0004Lh-7s
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 15:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6E3H-0007Os-A9
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 15:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730315297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpv/a7sxV2NHsoE3vWIjJzNbWW53ACUFNPdx8V7HSmg=;
 b=gVvavV/NzGfg+hEqPBy663tr+cqfMJVsY52It7i22sv4OzgF4Xx3b839Xv78IdzZGWfAZ2
 TCg5Dn7fX9dNyYwK/c4cVvSDzIYKOZraaP6vfQM1uEuV1xZF4Tk1CJhWemUHSbLErzBqfS
 qBEvCfLh4C/vloTlfutgWabryzneSa8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Al0Vua9SOR2in25NY3p1xA-1; Wed, 30 Oct 2024 15:08:13 -0400
X-MC-Unique: Al0Vua9SOR2in25NY3p1xA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf496eda1so4280346d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 12:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730315293; x=1730920093;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tpv/a7sxV2NHsoE3vWIjJzNbWW53ACUFNPdx8V7HSmg=;
 b=t+hyczvM0MJfwjrLVtpeFXByfaLq5ARnybfzSi8IUjIB6loAtLlEHK71VhQtKn+mxO
 YyJAqqDbgk9MMqy5RS68aXr69nYvXUsap/dybnj0/sJwSY+7X+YSFx8wNOIcxIKybgtD
 OPn1sSLqmBlRfV7BikALmNn0psn8G6sGY58gHMwgXHzh/NMiDx78txa9gpPKS5XlUd0N
 8g1lI+kLhamXlk5sHso+oVazUBiyrGkqGoRaPx8hAiuy5SJuTrwadG+bWfbiLUHsLfo6
 yARVLHztgniIsxrX78WYmCkWQi3KkLQlPjUVzBl4G+aDYbXkR1BJbj208BTjkAUKYezL
 1cuA==
X-Gm-Message-State: AOJu0YzKVJVa+gE0VLlPTp8hRd3bi07tKyaX1KY7FH8iptq9hD/FMbLS
 QA5iFt3oqWLuuNNGtJT/nIwqneh4u+m33O80mqLNA/dA72Ohvb6vxQsai7ukbbSJnw1m+NJbaZ0
 ARhuyOwlUPzyy4X6fGqa/peyqT1YKvbeGd3QWMd3XfENqN1grc+AK
X-Received: by 2002:ad4:5443:0:b0:6d3:413c:745b with SMTP id
 6a1803df08f44-6d351b2084dmr8830116d6.34.1730315292651; 
 Wed, 30 Oct 2024 12:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAJPmAd06hl3pZspvZKmpm/9c515KeuErV+4Hi+1YvOdVTqzXzYrPyE1y6XuGXZko9bPRnEw==
X-Received: by 2002:ad4:5443:0:b0:6d3:413c:745b with SMTP id
 6a1803df08f44-6d351b2084dmr8829846d6.34.1730315292283; 
 Wed, 30 Oct 2024 12:08:12 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2d466sm54492996d6.115.2024.10.30.12.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 12:08:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:08:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyKEGIQzVZ7c1OTV@x1n>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <ZyJ1zJoOaLuNHPI-@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyJ1zJoOaLuNHPI-@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 30, 2024 at 06:07:08PM +0000, Daniel P. Berrangé wrote:
> On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> > v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> > 
> > This patchset introduces the singleton interface for QOM.  I didn't add a
> > changelog because there're quite a few changes here and there, plus new
> > patches.  So it might just be easier to re-read, considering the patchset
> > isn't large.
> > 
> > I switched v2 into RFC, because we have reviewer concerns (Phil and Dan so
> > far) that it could be error prone to try to trap every attempts to create
> > an object.  My argument is, if we already have abstract class, meanwhile we
> > do not allow instantiation of abstract class, so the complexity is already
> > there.  I prepared patch 1 this time to collect and track all similar
> > random object creations; it might be helpful as a cleanup on its own to
> > deduplicate some similar error messages.  Said that, I'm still always open
> > to rejections to this proposal.
> > 
> > I hope v2 looks slightly cleaner by having not only object_new_allowed()
> > but also object_new_or_fetch().
> 
> For me, that doesn't really make it much more appealing. Yes, we already have
> an abstract class, but that has narrower impact, as there are fewer places
> in which which we can trigger instantiation of an abstract class, than
> where we can trigger instantiation of arbitrary objects and devices.

There should be exactly the same number of places that will need care for
either abstract or singleton.  I tried to justify this with patch 1.

I still think patch 1 can be seen as a cleanup too on its own (dedups the
same "The class is abstract" error message), tracking random object
creations so logically we could have the idea on whether a class can be
instantiated at all, starting with abstract class.

The real extra "complexity" is object_new_or_fetch(), but I hope it's not a
major concern either.  We only have two such use (aka, "please give me an
object of class XXX"), which is qom/device-list-properties.  I don't expect
it to be common, I hope it's easy to maintain.

> 
> The conversion of the iommu code results in worse error reporting, and
> doesn't handle the virtio-iommu case, and the migration problems appear
> solvable without inventing a singleton interface. So this doesn't feel
> like it is worth the the trouble.

IMHO that's not a major issue, I can drop patch 3-5 just to make it simple
as of now.  Btw, I have a TODO in patch 2 where I mentioned we can provide
better error report if we want, so we can easily have exactly the same
error as before with maybe a few or 10+ LOCs on top.  It's trivial.

object_new_allowed():

+    if (object_class_is_singleton(klass)) {
+        Object *obj = singleton_get_instance(klass);
+
+        if (obj) {
+            object_unref(obj);
+            /*
+             * TODO: Enhance the error message.  E.g., the singleton class
+             * can provide a per-class error message in SingletonClass.
+             */
+            error_setg(errp, "Object type '%s' conflicts with "
+                       "an existing singleton instance",
+                       klass->type->name);
+            return false;
+        }
+    }

> 
> NB, my view point would have been different if  'object_new' had an
> "Error *errp" parameter. That would have made handling failure a
> standard part of the design pattern for object construction, thus
> avoiding adding asserts in the 'object_new' codepath which could be
> triggered by unexpected/badly validated user input.

Yes I also wished object_new() can take an Error** when I started working
on it.  It would make this much easier, indeed.  I suppose we don't need
that by not allowing instance_init() to fail at all, postponing things to
realize().  I suppose that's a "tactic" QEMU chose explicitly to make it
easy that object_new() callers keep like before with zero error handling
needed.  At least for TYPE_DEVICE it looks all fine if all such operations
can be offloaded into realize().  I'm not sure user creatable has those
steps also because of this limitation.

I was trying to do that with object_new_allowed() here instead, whenever it
could be triggered by an user input.  We could have an extra layer before
reaching object_new() to guard any user input, and I think
object_new_allowed() could play that role.  When / If we want to introduce
Error** to object_new() some day (or a variance of it), we could simply
move object_new_allowed() into it.

Thanks,

-- 
Peter Xu


