Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4418FC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKK0E-0003Uy-Is; Wed, 28 May 2025 12:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKK0A-0003Ue-TC
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKK08-0000F1-D0
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748451094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5VZagvfLSiQsGu/T8LCazDrj1as7y9CALFlWSRvbrM=;
 b=IfjH4hIHpqjZlE18yk6Fom6eOTs8Jmqz/xGBYdJZ84hONm31mgQvpK8X4wfLmWa3qLdouw
 ZSwltpaBDBEw9KdVhHvW0N9wMQneKPLvVc2q0kwKDuyoSyiK7xpNV3pr/LCbBfHguQdref
 kUQv7ITcMrIP91f0C1PPVbEm/87Zmgg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-j3Vunx0jNkGnGmHG2MJ_vg-1; Wed, 28 May 2025 12:51:33 -0400
X-MC-Unique: j3Vunx0jNkGnGmHG2MJ_vg-1
X-Mimecast-MFC-AGG-ID: j3Vunx0jNkGnGmHG2MJ_vg_1748451092
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fab3aaa03fso1406406d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 09:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748451092; x=1749055892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5VZagvfLSiQsGu/T8LCazDrj1as7y9CALFlWSRvbrM=;
 b=d06Q99ErJFvTylKEr3hAG47gwfPqPUizDVDoayM9KO8OmPzkB4xkxRd4xZek4eHFKB
 F+8EZCQbblyh+wjWLrkMn8U+xd3M0s2AeRAkSGM/OCAa0/eOTIjt2wTvmqsYVNuRxWMU
 AEA86LDW5PtfcG9B3GoPTpNd53FltW6weSARrmkG7wv5XR6iIYjoqFKkOnxRA2eFlmo8
 u3itVGSGnwt62wQZ73XlUaLFESTno+x2sxFbBmGib7Du8Z6zAcifHoXJ+j8UYt7Ispbu
 SsSIN8vyzW7Kg2+9Tjqi4q7zZiL++Shs6plrMFMpFuRZAO2TuIo6hMmY8MY2WElGArrZ
 utQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJWBUDEQNZcVnFXWzxq7CrjcpJWUYGT/wnEUwUIxzzDUtd9x/OAePBNyXZvQ0jsRajxUwXxnlHp6r+@nongnu.org
X-Gm-Message-State: AOJu0YyrYI7eWRlaQnKXzasKY6i7oEITvY+Kd2H7d4RZdv1nz/Se3wJc
 2wBDNYbfA/Iou0sVW7c8iU3yUwtqBJywRqGkSKSonAjVy4ET/JgK6lumFD+VmmRPQk1PzeZDQhF
 /a84wo3wogdkZhqT4FG2ZsTT603IsIKqVD7HxsT1tbJYSNKp/x9u0Ldou
X-Gm-Gg: ASbGncuo3G/udJVtHmxjpZ3nK2HE6B/FS5cj6DvZOuRP1iBpYUZa/tre9Rip3Nrfj2J
 tKpfmfKYq75ghfgVeY0Ogm/DNjx58vcxJV5a4CNR+A8+Z9CpD6NOHVvwcVuFc9kR+Pgwgv09a9V
 4yLpczl+GK0QjprU7Oqo9sQqnHPIDP8UsbVNB33rovefAkiSFjRAth34zA6qnEUAEGcPJ4ffnB+
 g88ZZQTpqxrbLvLAqEzZUL3B4iE/YlUHN++HQeOs0CcGeDi14hTGDB9dEILDumL5ZQlFrgipNvZ
 TrQ=
X-Received: by 2002:ad4:5748:0:b0:6fa:acc1:f077 with SMTP id
 6a1803df08f44-6fabf328d52mr40834456d6.35.1748451092509; 
 Wed, 28 May 2025 09:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7N2S2uQSa5N1V9Gi+VwBZ/JfylNuvYqjHmoxte2ew0im/E2AOOdsw9V6YFb/NErj09kTaKw==
X-Received: by 2002:ad4:5748:0:b0:6fa:acc1:f077 with SMTP id
 6a1803df08f44-6fabf328d52mr40834256d6.35.1748451092170; 
 Wed, 28 May 2025 09:51:32 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac0bb99d8sm8427296d6.86.2025.05.28.09.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 09:51:31 -0700 (PDT)
Date: Wed, 28 May 2025 12:51:28 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alexey Perevalov <a.perevalov@samsung.com>
Subject: Re: [PATCH 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
Message-ID: <aDc_ELugLDXPgRhr@x1.local>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-3-peterx@redhat.com>
 <878qmhjlma.fsf@pond.sub.org> <aDcm9turgPlQ75BO@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDcm9turgPlQ75BO@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 28, 2025 at 03:08:38PM +0000, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > Unfortunately, it was never correctly shown..
> > >
> > > This is only found when I started to look into making the blocktime feature
> > > more useful (so as to avoid using bpftrace, even though I'm not sure which
> > > one will be harder to use..).
> > >
> > > So the old dump would look like this:
> > >
> > >   Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59
> > >
> > > Even though there're actually 40 vcpus, and the string will merge same
> > > elements and also sort them.
> > >
> > > To fix it, simply loop over the uint32List manually.  Now it looks like:
> > >
> > >   Postcopy vCPU Blocktime (ms):
> > >    [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
> > >     33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
> > >     40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
> > >     22, 3, 0, 0, 0, 0, 0, 0, 0, 0]
> > >
> > > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > > Cc: Alexey Perevalov <a.perevalov@samsung.com>
> > > Cc: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration-hmp-cmds.c | 23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > > index 367ff6037f..3cf890b887 100644
> > > --- a/migration/migration-hmp-cmds.c
> > > +++ b/migration/migration-hmp-cmds.c
> > > @@ -208,15 +208,20 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> > >      }
> > >  
> > >      if (info->has_postcopy_vcpu_blocktime) {
> > > -        Visitor *v;
> > > -        char *str;
> > > -        v = string_output_visitor_new(false, &str);
> > > -        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
> > > -                              &error_abort);
> > > -        visit_complete(v, &str);
> > > -        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
> > > -        g_free(str);
> > > -        visit_free(v);
> > > +        uint32List *item = info->postcopy_vcpu_blocktime;
> > > +        int count = 0;
> > > +
> > > +        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> > > +
> > > +        while (item) {
> > > +            monitor_printf(mon, "%"PRIu32", ", item->value);
> > > +            item = item->next;
> > > +            /* Each line 10 vcpu results, newline if there's more */
> > 
> > The list can be arbitrarily long?
> 
> One per vCPU, so a small arbitrary.
> 
> > > +            if ((++count % 10 == 0) && item) {
> > > +                monitor_printf(mon, "\n  ");
> > > +            }
> > > +        }
> > > +        monitor_printf(mon, "\b\b]\n");
> > 
> > Uh, backspace?
> 
> Agreed!

Agreed on.. using backspace? :)

> 
> Dave
> 
> > I usually do something like
> > 
> >     sep = "";
> >     for (...) {
> >         printf("%s...", sep, ...);
> >         sep = ", "
> >     }
> > 
> > To add line breaks, I'd use something like
> > 
> >         sep = ... ? ", " : ",\n";

Thanks for the suggestion!  Definitely better..

I'll squash below into this patch when repost, comments on top always
welcomed.

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 3cf890b887..6c36e202a0 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -209,19 +209,18 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 
     if (info->has_postcopy_vcpu_blocktime) {
         uint32List *item = info->postcopy_vcpu_blocktime;
+        const char *sep = "";
         int count = 0;
 
         monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
 
         while (item) {
-            monitor_printf(mon, "%"PRIu32", ", item->value);
+            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
             item = item->next;
             /* Each line 10 vcpu results, newline if there's more */
-            if ((++count % 10 == 0) && item) {
-                monitor_printf(mon, "\n  ");
-            }
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
         }
-        monitor_printf(mon, "\b\b]\n");
+        monitor_printf(mon, "]\n");
     }

-- 
Peter Xu


