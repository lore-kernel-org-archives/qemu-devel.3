Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664DFC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 07:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uipw7-0006hv-7b; Mon, 04 Aug 2025 03:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uipw1-0006bo-TD
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 03:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uipvz-0007CX-JM
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 03:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754293717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B25LFxL+iEwyHVpO/Bhv5oaJoMrJbqxD3INU3vVjQys=;
 b=UWlIAcwc4LjOh43gVsVhGDZDjJsAA9NMBvL/O/24xjeZDg0DBk7brvfdJb8VusAeN1jCkA
 z9MobpnwEqSfXFOPh9n6gTfd/OncCkk+kfEBrnYKmamLrL/3T6twfVIIVmGsPnSyebUTuq
 wqUWRt30j2FNhSbtLzJ9lvzntROl8iE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-CNWp18ngN1CjS0wDn-HXRg-1; Mon, 04 Aug 2025 03:48:36 -0400
X-MC-Unique: CNWp18ngN1CjS0wDn-HXRg-1
X-Mimecast-MFC-AGG-ID: CNWp18ngN1CjS0wDn-HXRg_1754293715
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b78329f007so3627328f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 00:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754293715; x=1754898515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B25LFxL+iEwyHVpO/Bhv5oaJoMrJbqxD3INU3vVjQys=;
 b=PfGa5fLbt4R9zHsF2InY7Gh53cfyWUuuF3ePKFVO6l054qU26uhnggdq6GJWYFBD5X
 6c0LNvqZrt9Fxff2vDKf/hSg7ljIjENUAYHhbudodqEBs/GW680t/UVvSLEQgGCi2XUN
 t+QxVv9gfowc/8TQf9i7tq8C3N+XuBOGD9aSLue4fVUaK6CmHFLTjoyE52hTbzsH2r2N
 P9lJ5sbA/MRfs2zmgNcAMpTsiFutif8vLnpil81BkRbO85fv6CRx/FWQLlkSwsADAp2m
 5SJAW4QZloU8pcoWzmtekD3cEcD6pzDotcuhA5/a2wZrxNgSX+dLSwxJFFfQ5dkOxVG1
 jZPQ==
X-Gm-Message-State: AOJu0YzKxR5e+ksTjVu3HGH/qBIYHFD+XR+9pnX0d/UYlP6mNTh1hP6c
 fr2GTvB0NrKA9xY7zknuT+vgKAsxHJNCNtyvR66oANB90LNPaoA7rOQLx3wf8q39RRUV7ZNO42s
 qfvGtkhDrKddcMqvHJZfQwU4C6l+lT69XvYFq5bo0Nq4tzp7s/zZTnviC
X-Gm-Gg: ASbGncszHF0Lmb5j+VYadXnbJSh+j6D9yoRNbMu/BcLPbnzCC22qRe63f6teB9W/hup
 a+ydh6+GcriBKziaQmgcpFIytriIgyBZaKZEXB+2UKQaIYyX5DOI6/lfz1ROA5SOfwK+H1BIVML
 eZlvTIKaPX9K9GDZ7/1quDlZWObdZ8b1kPer6wGyiuckei0yarlSjMy0tnV96suFf8Fk3zFtGad
 uWKSVBbsEu5qbkZId3R5BrSALyB5lu3uUfpp8usrqe31i2iOSSWDrK9Ed7OaATrwAX46YYT/x1v
 vZd08H7CgMHkqEN2sptQunu4aSfxb5voTBaCMHTxl7RLb8JWrpqN
X-Received: by 2002:a05:6000:240c:b0:3b7:9173:692e with SMTP id
 ffacd0b85a97d-3b8d9486fa9mr6335722f8f.25.1754293714667; 
 Mon, 04 Aug 2025 00:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9IoXCwiBFObzmelMb3kFfM2TAiqhfPyo0P44QV6Z/JXM+7rzA6g2MTdF/jVsX5REo+qnRcw==
X-Received: by 2002:a05:6000:240c:b0:3b7:9173:692e with SMTP id
 ffacd0b85a97d-3b8d9486fa9mr6335670f8f.25.1754293714057; 
 Mon, 04 Aug 2025 00:48:34 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469319sm14386762f8f.54.2025.08.04.00.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 00:48:33 -0700 (PDT)
Date: Mon, 4 Aug 2025 13:18:15 +0530
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
Message-ID: <aJBlvymcYCeixPGA@armenon-kvm.bengluru.csb>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-23-28fd82fdfdb2@redhat.com>
 <f1a331ae-f520-44d7-82a7-c5dbef3440a2@rsg.ci.i.u-tokyo.ac.jp>
 <aIz5Hr7wDthdxgNP@armenon-kvm.bengluru.csb>
 <8905b290-24bb-4f90-a857-64d2a0f71a27@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8905b290-24bb-4f90-a857-64d2a0f71a27@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Aug 03, 2025 at 04:15:16PM +0900, Akihiko Odaki wrote:
> On 2025/08/02 2:27, Arun Menon wrote:
> > Hi Akihiko,
> > Thanks for the review.
> > 
> > On Fri, Aug 01, 2025 at 04:35:34PM +0900, Akihiko Odaki wrote:
> > > On 2025/07/31 22:21, Arun Menon wrote:
> > > > Currently post_save hook is called without checking its return. If post_save
> > > > fails, we need to set an error and propagate it to the caller.
> > > > 
> > > > Since post_save hook is called regardless of whether there is a preceeding error,
> > > > it is possible that we have 2 distict errors, one from the preceeding function
> > > > call, and the other from the post_save call.
> > > > 
> > > > Return the latest error to the caller.
> > > 
> > > This needs to be explained better. This patch makes two changes on the
> > > behavior when there are two errors:
> > > 
> > > 1) Proceeding errors were propagated before, but they are now
> > >     dismissed.
> > > 2) post_error() errors were dismissed before, but they are now
> > >     propagated.
> > > 
> > > This message doesn't mention 1) at all. It does say 2) is necessary, but
> > > does not explain why.
> > 
> > Please correct me if I am wrong, does the following look ok?
> > 
> > Currently post_save() hook is called without checking its return.
> > post_save() hooks, generally does the cleanup, and that is the reason why
> > we have been dismissing its failure.
> > 
> > We want to consider
> >    - the saving of the device state (save or subsection save) and
> >    - running the cleanup after
> > as an atomic operation. And that is why, post_save is called regardless
> > of whether there is a preceeding error.
> > This means that, it is possible that we have 2 distict errors, one from
> > the preceeding function and the other from the post_save() function.
> > 
> > This patch makes two changes on the behavior when there are two errors:
> > 
> > 1) Preceeding errors were propagated before, but they are now
> >     dismissed if there is a new post_save() error.
> > 2) post_save() errors were dismissed before, but they are now
> >     propagated.
> > 
> > We intend to extend the error propagation feature (saving erros in
> > Error object and return to the caller) to the post/pre
> > save/load hooks. Therefore, it is important for the user to know
> > the exact reason of failure in case any of these hooks fail.
> > 
> > ====
> > I do not know much about the operations we do, or intend to do
> > using the post_save() call. But my guess is that we are going to
> > revert things or cleanup stuff, and if reverting/cleanup fails,
> > then the user should be notified about that.
> 
> All what you stated sounds correct to me and explains 2). But there is still
> no reasoning for 1).
> 
> Previously I listed three possible design options:
> > - propagate whatever error easier to do so
> > - somehow combine errors
> >   (languages that support exceptions often do this)
> > - make sure that no error will happen when there is a proceeding error
> >   by having two callbacks:
> >   - One callback that is called only when there is no proceeding error
> >     and can raise an error
> >   - Another that is always called but cannot raise an error
> 
> https://lore.kernel.org/qemu-devel/1ff92294-5c8c-4b33-89c1-91d37d6accb0@rsg.ci.i.u-tokyo.ac.jp/
> 
> It will be a good reasoning if we can show propagating post_save() errors is
> easier (or more important) than propagating proceeding errors.
> 
> There are alternative options. "Making sure that no error will happen when
> there is a proceeding error by having two callbacks" is one of them. You
> wrote:
> > We want to consider
> >    - the saving of the device state (save or subsection save) and
> >    - running the cleanup after
> > as an atomic operation. And that is why, post_save is called
> > regardless of whether there is a preceeding error.
> > This means that, it is possible that we have 2 distict errors, one
> > from the preceeding function and the other from the post_save()
> > function.
> 
> But it may not be mandatory. In fact, I searched "post_save" in the code
> base and found all implementations are for cleanup and always succeeds,
> which makes sense; most (if not all) cleanup operations like g_free() always
> succeeds in general.

post_save calls do succeed in general.
Now, we are introducing the post_save_errp() function which is an alternative to the
post_save() call. We are adding the feature to catch errors in Error object,
thereby clearly considering the case where post_save_erp can go wrong.
So we have already deviated from the old design that all post_save operations are
infalliable cleaup routines. The only catch is, these alternate functions are introduced
a couple of commits later.

If that is the case, then we need to handle both the errors, and propagate only
the most significant (which in my opinion is the post_save) one.

In other words, the reasoning for 1, 
	1) Proceeding errors were propagated before, but they are now dismissed.

is that,
a failure during the preceeding operation means that we failed in saving the state
but a failure during the post-save call, means that we failed in cleanup or restoring
back the system to a stable state, which is a more serious one, because it may lead to
the system being in an inconsistent state.
Can I write something on these lines, to justify the change?

> 
> So perhaps "making sure that no error will happen when there is a proceeding
> error" may be feasible, and it may not even require two callbacks because
> post_save() always succeeds.

I am sorry, I could not completely understand the part, where you mentioned that
we need to have 2 callbacks; I am assuming you are mentioning something like try..catch,
finally blocks from the other languages. 
post_save (that can not raise an error) being called in the goto block.

So if the main operation fails, we say goto cleanup, and then execute post_save which always
succeeds. If the main operation succeeds then we call post_save that can raise an error. Please correct
me if I am wrong.


> 
> Regards,
> Akihiko Odaki
> 

Regards,
Arun


