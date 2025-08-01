Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C461DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv4F-0001Xg-RV; Fri, 01 Aug 2025 15:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhtYL-000474-R7
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhtYI-0003eh-Py
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754069296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NynhsrLk2p/fugfN/aOkZxkbQFH8luM5S8LSxDG+mT0=;
 b=PXA7qIOkzWtt3ImbNh5s60Q/HCidujT9m+7P085EBmJDEQYtBjpccLiFwnQr4YnjngVEuw
 GdDx3ZIwgSMjlG/G2Y8eFOwDuBIqPXbx4ggmqx792YRNOs3T0ZhylhxrTI4q8RA8npMji0
 DmjcFRYBCKJk9hcIBQKj6AWnfsOlj8o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-8-9PzsI4OqOl40Fw0A4dCw-1; Fri, 01 Aug 2025 13:28:15 -0400
X-MC-Unique: 8-9PzsI4OqOl40Fw0A4dCw-1
X-Mimecast-MFC-AGG-ID: 8-9PzsI4OqOl40Fw0A4dCw_1754069294
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-74ce2491c0fso4113895b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069294; x=1754674094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NynhsrLk2p/fugfN/aOkZxkbQFH8luM5S8LSxDG+mT0=;
 b=cF5JjjiaA9/XdnMxR1TsbiQoohd9buFRjtl13EwKzPk8pjUwkI74oyw3w0lUYleQ3c
 cgdTFrlRZEBAzF/m1Yqa1AceZjECMJdrWmj+Vrj2Kq44hKadbSVj+JOOf9Zempj4rbEp
 /Zc9xVj6FsavpurTV4quUT4KuvcEpi05LCWleooauGTC7TMXvIs69jkarb+7gOU9NAWK
 TsuSVFXpfyz7u9g4GYK7yPYR7WrfzD2NNeghWDQTPL8QP2fna6CH9PvrlroeQQYBLMrl
 4bc6xn5CwLzYWbJUUWFFSTz1+fmI79cSuKK0Zspz/65su83qAfZD+0n6Id+wqXXP02/Q
 G2eg==
X-Gm-Message-State: AOJu0Yza+8DybBgqatFBGB2kRD1JYWrh6WeT7APpsvby1QfUuDJ3Pf5A
 zY2oMgq+xiYMkLUECwFLDoF98FDOH4PoXBbwOwiteX1eQMhO2KXMLdSUaX7mxJWMxFxfQbPEKt4
 47apBQF710lp/0op0M8UZ+YiKyt0c1xJ3petgokAbyycOO4zM3vrOHZbd
X-Gm-Gg: ASbGncs1cq1eCovi63jwAIb7woEJ+cNw+5VLaryXN7cX4Ih5WqWXDgrooGdEJLHSc5g
 +CrmFSnDA8offqJUYmaU794/DtFYtLb2L38pVQXoEctCCP5CP4RDEJmNjMyuAhT80rrBHkSYzeR
 9cUx0QEgao01EhVWJS5PpvqhB0yaw+b1qsnVYgDDyNufDb3jxcDz95adpVLBv1eDDAjHSiNmjaI
 u0fsABGPoIAhZQHdgD8m2fmP1EF0GtxPfWavJmJGQ5PAE8qr7t9qmJdNng/TqwdCUY3lZ9nWhKv
 C5wnDxYCwbcMghGkC2a2jdNGkxQTXGy6wBgFPhc6/hQO3BrHnOc5Aw==
X-Received: by 2002:a05:6a00:3c8e:b0:76b:deca:2b40 with SMTP id
 d2e1a72fcca58-76bec332ae1mr244473b3a.10.1754069294094; 
 Fri, 01 Aug 2025 10:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE24TjjPMkr9e95mj+cqJzkgKnNe5BrtCH0KuOPt4xbMCc95mMbhZfxJf7j6Nz9LUfGfm7DeQ==
X-Received: by 2002:a05:6a00:3c8e:b0:76b:deca:2b40 with SMTP id
 d2e1a72fcca58-76bec332ae1mr244436b3a.10.1754069293675; 
 Fri, 01 Aug 2025 10:28:13 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcbf0sm4600501b3a.69.2025.08.01.10.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 10:28:13 -0700 (PDT)
Date: Fri, 1 Aug 2025 22:57:58 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v8 23/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
Message-ID: <aIz5Hr7wDthdxgNP@armenon-kvm.bengluru.csb>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-23-28fd82fdfdb2@redhat.com>
 <f1a331ae-f520-44d7-82a7-c5dbef3440a2@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a331ae-f520-44d7-82a7-c5dbef3440a2@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Akihiko,
Thanks for the review.

On Fri, Aug 01, 2025 at 04:35:34PM +0900, Akihiko Odaki wrote:
> On 2025/07/31 22:21, Arun Menon wrote:
> > Currently post_save hook is called without checking its return. If post_save
> > fails, we need to set an error and propagate it to the caller.
> > 
> > Since post_save hook is called regardless of whether there is a preceeding error,
> > it is possible that we have 2 distict errors, one from the preceeding function
> > call, and the other from the post_save call.
> > 
> > Return the latest error to the caller.
> 
> This needs to be explained better. This patch makes two changes on the
> behavior when there are two errors:
> 
> 1) Proceeding errors were propagated before, but they are now
>    dismissed.
> 2) post_error() errors were dismissed before, but they are now
>    propagated.
> 
> This message doesn't mention 1) at all. It does say 2) is necessary, but
> does not explain why.

Please correct me if I am wrong, does the following look ok?

Currently post_save() hook is called without checking its return.
post_save() hooks, generally does the cleanup, and that is the reason why
we have been dismissing its failure.

We want to consider
  - the saving of the device state (save or subsection save) and 
  - running the cleanup after
as an atomic operation. And that is why, post_save is called regardless
of whether there is a preceeding error.
This means that, it is possible that we have 2 distict errors, one from 
the preceeding function and the other from the post_save() function.

This patch makes two changes on the behavior when there are two errors:

1) Preceeding errors were propagated before, but they are now
   dismissed if there is a new post_save() error.
2) post_save() errors were dismissed before, but they are now
   propagated.

We intend to extend the error propagation feature (saving erros in
Error object and return to the caller) to the post/pre
save/load hooks. Therefore, it is important for the user to know
the exact reason of failure in case any of these hooks fail.

====
I do not know much about the operations we do, or intend to do
using the post_save() call. But my guess is that we are going to
revert things or cleanup stuff, and if reverting/cleanup fails,
then the user should be notified about that.

> 
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/vmstate.c | 18 ++++++++++++++----
> >   1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index b725202bfcf69c3c81338f1f5479aa2ddc5db86f..25a819da069b982d4043f287b4562ea402d9eb0e 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -418,6 +418,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                            void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
> >   {
> >       int ret = 0;
> > +    int ps_ret = 0;
> >       const VMStateField *field = vmsd->fields;
> >       trace_vmstate_save_state_top(vmsd->name);
> > @@ -533,7 +534,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                       error_setg(errp, "Save of field %s/%s failed",
> >                                   vmsd->name, field->name);
> >                       if (vmsd->post_save) {
> > -                        vmsd->post_save(opaque);
> > +                        ps_ret = vmsd->post_save(opaque);
> > +                        if (ps_ret) {
> > +                            ret = ps_ret;
> > +                            error_free_or_abort(errp);
> > +                            error_setg(errp,
> > +                                       "post-save for %s failed, ret: '%d'",
> > +                                       vmsd->name, ret);
> > +                        }
> >                       }
> >                       return ret;
> >                   }
> > @@ -561,10 +569,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >       ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> >       if (vmsd->post_save) {
> > -        int ps_ret = vmsd->post_save(opaque);
> > -        if (!ret && ps_ret) {
> > +        ps_ret = vmsd->post_save(opaque);
> > +        if (ps_ret) {
> >               ret = ps_ret;
> > -            error_setg(errp, "post-save failed: %s", vmsd->name);
> > +            error_free_or_abort(errp);
> > +            error_setg(errp, "post-save for %s failed, ret: '%d'",
> > +                       vmsd->name, ret);
> >           }
> >       }
> >       return ret;
> > 
> 
Regards,
Arun


