Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C825D60CF8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 23:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDApC-0004D8-I6; Mon, 18 Nov 2024 18:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDApA-0004CL-BW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 18:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDAp7-0004bL-T0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 18:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731971184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H9cTNIP4om+qBqwrZtQTDr8ntVBKBEJcVY9AgF70ZJs=;
 b=DApJ5FSx4L+RewijDsq+6pTLEL0raVWrnlVsybO75lF0CtnpdTDOw1ilHNckeQe3oy5xiQ
 tGvvImJv9fLlG1HQ1HtvcWk6UIBKIyCQ/WF9xcclHmJHe0EkNn3Gl0e1IaxR7x6J79uWM/
 k7Iak2aun0I1OWxFyEqTTvM+y1wyPcE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-uh02jUmjMW-t-8v9LPIa8g-1; Mon, 18 Nov 2024 18:06:21 -0500
X-MC-Unique: uh02jUmjMW-t-8v9LPIa8g-1
X-Mimecast-MFC-AGG-ID: uh02jUmjMW-t-8v9LPIa8g
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83abf68e7f0so37228739f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 15:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731971179; x=1732575979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9cTNIP4om+qBqwrZtQTDr8ntVBKBEJcVY9AgF70ZJs=;
 b=cXSksVIFE8T+BKdVEJ2LE4WKYQvsaWQKf8J/NGoRRFPfpFv79r3ycUPkJ5YIMac6D6
 Aa/tKZluQfFeK0LGWL7WPxUmttcNcmphOjAXowDlHgmZRiRfCceZTeH85Yh2JRqUsjZn
 +NgAvH3QFRjmuBhvbCnLD527Kbyw+68Ae0TrGKA5/DB/6B1yjH61myDgOu6KWH2YsDCZ
 oavKgkWTdwF5GzDRot0Doca2RfUKHi+bSh7NK6XLNET6jvCjC1JuWHln8xI2grYrw/hK
 rcKIk+m99EFBFNMV1z2oDpnbylUhAIVh/v79TJQUJKxxI9H2PfPzr/UzAoGavWKnb//v
 pMng==
X-Gm-Message-State: AOJu0Yw5gbL1ugK5hYQPb+N8CzwhoW44FuTdJ5PUXYeH6zBjKVtneIv7
 AuAWXOAFhB7PjibDwY3SwPAdOaRsZlHtlIZZt9fkZ+/Zu9kcHZKFnGfPwXaWsbtG4CdAatUcjnJ
 LdHo81f4jkBMlRfi6OHtI1GtAuzVEqQ+5EvUTvO2sAHM/jp6jORfcgie+OtRWCYF2OrRMbLWGdL
 rOo3qdeatmARmBS5ETfEVUrtqtyXtQF1DFMA==
X-Received: by 2002:a05:6602:3fc3:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-83e6c2b3bb2mr1349984639f.6.1731971179566; 
 Mon, 18 Nov 2024 15:06:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGIuYQ/rlZPG/foZmwTzkRPoPHBYjjqklscE8CQnr+MSOGaa4o8e/lNre2jm8fP9CiH+ao3g==
X-Received: by 2002:a05:6602:3fc3:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-83e6c2b3bb2mr1349981339f.6.1731971179067; 
 Mon, 18 Nov 2024 15:06:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6eadb2sm2429626173.22.2024.11.18.15.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 15:06:18 -0800 (PST)
Date: Mon, 18 Nov 2024 18:06:15 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
Message-ID: <ZzvIZ4EL92hEk4wC@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118221330.3480246-6-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 18, 2024 at 05:13:30PM -0500, Peter Xu wrote:
> When used incorrectly, container_get() can silently create containers even
> if the caller may not intend to do so.  Add a rich document describing the
> helper, as container_get() should only be used in path lookups.
> 
> Add one object_dynamic_cast() check to make sure whatever objects the
> helper walks will be a container object (including the one to be returned).
> It is a programming error otherwise, hence assert that.
> 
> It may make container_get() tiny slower than before, but the hope is the
> change is neglictable, as object_class_dynamic_cast() has a fast path just
> for similar leaf use case.

Just a heads up: out of curiosity, I tried to see whether the fast path hit
that I mentioned here (mostly, commit 793c96b54032 of Paolo's), and it
didn't..

It's fundamentally because all TypeImpl was allocated dynamically from
heap, including its type->name.  While typename should normally be const
strings that locates on RODATA sections, hence they should mostly never
hit when compare with pointers..

I was thinking whether we could add a strcmp() there too for the fast path,
but then I noticed that QEMU could have some pretty long type->name... so
that strcmp() idea may not be good if that's the case. E.g.:

  virtio-net-pci-non-transitional::conventional-pci-device

Which has 55 chars..

I don't have good idea to make the fast path hit here, so I'll at least
remove this paragraph if I'm going to repost.. I hope it's not a huge deal
to still do the sanity check here, as the container type is so special and
small, so that check should be fast regardless.

> 
> Link: https://lore.kernel.org/r/87pln6ds8q.fsf@pond.sub.org
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qom/container.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/qom/container.c b/qom/container.c
> index cfec92a944..ff6e35f837 100644
> --- a/qom/container.c
> +++ b/qom/container.c
> @@ -24,6 +24,20 @@ static void container_register_types(void)
>      type_register_static(&container_info);
>  }
>  
> +/**
> + * container_get(): Get the container object under specific path
> + *
> + * @root: The root path object to start walking from.  When starting from
> + *        root, one can pass in object_get_root().
> + * @path: The sub-path to lookup, must be an non-empty string starts with "/".
> + *
> + * Returns: The container object specified by @path.
> + *
> + * NOTE: the function may impplicitly create internal containers when the
> + * whole path is not yet created.  It's the caller's responsibility to make
> + * sure the path specified is always used as object containers, rather than
> + * any other type of objects.
> + */
>  Object *container_get(Object *root, const char *path)
>  {
>      Object *obj, *child;
> @@ -31,6 +45,7 @@ Object *container_get(Object *root, const char *path)
>      int i;
>  
>      parts = g_strsplit(path, "/", 0);
> +    /* "path" must be an non-empty string starting with "/" */
>      assert(parts != NULL && parts[0] != NULL && !parts[0][0]);
>      obj = root;
>  
> @@ -40,6 +55,12 @@ Object *container_get(Object *root, const char *path)
>              child = object_new(TYPE_CONTAINER);
>              object_property_add_child(obj, parts[i], child);
>              object_unref(child);
> +        } else {
> +            /*
> +             * Each object within the path must be a container object
> +             * itself, including the object to be returned.
> +             */
> +            assert(object_dynamic_cast(child, TYPE_CONTAINER));
>          }
>      }
>  
> -- 
> 2.45.0
> 

-- 
Peter Xu


