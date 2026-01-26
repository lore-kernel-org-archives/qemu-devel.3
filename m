Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FC1D19519
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkTS4-00029Q-PM; Mon, 26 Jan 2026 15:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkTS0-00027u-Pf
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkTRy-0001tk-9A
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769460281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZVAnHt9mHF48fKkDLpgRAT+I+jRACvGkHTaXgd+PTw=;
 b=S4t4e3DMApams1G/upI8XRu0TYZGvM1ISdbJdtJs4v/0m3IPKkr+BpaJ/6z4O3xAnQSzpG
 lbCo0WzNcPJ4Cok6S1M02WykmEtuc+o2X3LPchZimVU1VDXhArKgQ6vEjX2UUugVpKiDDe
 Gi00lE8cH+cIv5fvfz9On2jzpY1JOe0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-qeOgpQerOjiwtW3K46b54w-1; Mon, 26 Jan 2026 15:44:39 -0500
X-MC-Unique: qeOgpQerOjiwtW3K46b54w-1
X-Mimecast-MFC-AGG-ID: qeOgpQerOjiwtW3K46b54w_1769460279
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-502a341e0e3so139599491cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 12:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769460279; x=1770065079; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cZVAnHt9mHF48fKkDLpgRAT+I+jRACvGkHTaXgd+PTw=;
 b=YFn5J5EeWtiKUzNdcL4rNECh/XVFjy1eotNG3neaqZxnJ2Itv4DCWYYskw4ocmy1Gu
 oRssk9zTr0tZHkbs59qt72WwpHIwWUqQdgzctqEcn0VcPHsaNFE6FgF2aegjA+ugGRdj
 aciLoZHlpYk6/IY/5ZE2DmZtoodNYv4b0cpynOlKvNPEjUGsgRpF3Kju98VqccG1fAJh
 jmEX3/t9mfT7d3mtl91H5VTx69p25hCTj/gJAVA0znVET2bKr7rMVKuE3rpktDVgjUOC
 4/Oxt4spAgEezA4d3Hsvem1KvevGMC3vnPyOOTCMC7HSD8PPVIWKq7cxktPJcPpbihxu
 GXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769460279; x=1770065079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZVAnHt9mHF48fKkDLpgRAT+I+jRACvGkHTaXgd+PTw=;
 b=R97xin7bkokOzB7FbaWy0oZAIeZ4qu3mz0XGOuvA1AK/qU+NampfLU1rLUd9b3qxl6
 SHPZb2BbrKcaZGgTFrHnc8NjJo++6I7EFTxvDHfNVLQnqFRmlnL9WEFen4m7OGgoOSBz
 q1ugJtCBvqruqHs9jgDfDx3L/+ZXLaVlmwN+fNSQqtSRvBBh17qUvF3+c4qdrM4i++HJ
 FHo3RyGoNFvN+zpWvDkRZR/iQZfbHAZqaUPjr8mYwHy2PjPncgnJEAEMa6QMqtk5q5a/
 WVILG/CwuNtHjp1AY2St5lnkm5s4GrbriOaM03vyXjfkQGT/JtqejUfxiT9wBkYH5K0E
 v8Cg==
X-Gm-Message-State: AOJu0YzHzDGnylq4io3vr7Q4HyNcvijRDSsq36fCcQGWNis8p/oyiM0N
 zU4cH2xRAFjzWFcsGWMkPzFormuJk9jUyZNA+3fao+TKsbCsYcfjSELt1dC4UuDBFFC3d2usT5Y
 eex1fNkgS0ldZHOhk5qgN0JvWY/rx8ISfOcPePCckbYhZPTaUFHOMrrKI
X-Gm-Gg: AZuq6aKEtV1FuvJbamVFoZ314ZkoFM0qLqheWZM+kO6JsWqqA/R8mbT7WfmT+F03TQY
 gVKrhNYaG/Q7yvL/v1t57CRIh9rdtdG/04PIpls3ZsiHRScV0B3+W9Pbf2VldAkHOUSxqktjryP
 euFuetr5VvcRsN83fHdqFSjrJp3NZjngJvsrbrSLVQm5+3zSd/LcobkoDNHI6Nv1/fswx6Da8ll
 4Q7KGT2KP/XjzH3S12zxoVeuT57nbRBH7rUDbRZzBNJepIdZYbbns8TjLkki8PQqGcbejkxTuTF
 mciDFXJBO839kNw8q2plaiBPXX2TL0Q+q+FDJDchp5jpXRHMFYwIKWYbUrOMX9/LOb9PGT61R+N
 vLvQ=
X-Received: by 2002:ac8:5707:0:b0:4ed:ba76:a008 with SMTP id
 d75a77b69052e-50314ccd5b4mr70419171cf.73.1769460279105; 
 Mon, 26 Jan 2026 12:44:39 -0800 (PST)
X-Received: by 2002:ac8:5707:0:b0:4ed:ba76:a008 with SMTP id
 d75a77b69052e-50314ccd5b4mr70418871cf.73.1769460278659; 
 Mon, 26 Jan 2026 12:44:38 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f72352sm88591821cf.21.2026.01.26.12.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:44:38 -0800 (PST)
Date: Mon, 26 Jan 2026 15:44:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 05/10] migration/colo: Unwrap qemu_savevm_live_state()
Message-ID: <aXfSNCVljE4XJ-e4@x1.local>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-6-peterx@redhat.com>
 <87cy30igmy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy30igmy.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 23, 2026 at 10:48:53AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It's only used in COLO path and only contains two calls.  Unwrap the
> > function.  It paves way for further reduce special COLO paths on sync.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/savevm.h | 1 -
> >  migration/colo.c   | 3 ++-
> >  migration/savevm.c | 7 -------
> >  3 files changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 5d815af742..528607f09e 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -64,7 +64,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
> >                                             uint64_t *start_list,
> >                                             uint64_t *length_list);
> >  void qemu_savevm_send_colo_enable(QEMUFile *f);
> > -void qemu_savevm_live_state(QEMUFile *f);
> >  int qemu_save_device_state(QEMUFile *f);
> >  
> >  int qemu_loadvm_state(QEMUFile *f, Error **errp);
> > diff --git a/migration/colo.c b/migration/colo.c
> > index db783f6fa7..e05736ecf0 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -471,7 +471,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
> >       * TODO: We may need a timeout mechanism to prevent COLO process
> >       * to be blocked here.
> >       */
> > -    qemu_savevm_live_state(s->to_dst_file);
> > +    qemu_savevm_state_complete_precopy(s->to_dst_file, true);
> 
> Could maybe drop this complete from the name eventually.

Maybe it's good to keep it?  As it describes it's in completion phase.  For
instance, for iterable devices we invoke different hooks when it's
completing (save_complete()) v.s. iterating (save_iterate()).

> 
> > +    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
> >  
> >      qemu_fflush(fb);
> >  
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index f1cd8c913d..529cf310e0 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1854,13 +1854,6 @@ cleanup:
> >      return ret;
> >  }
> >  
> > -void qemu_savevm_live_state(QEMUFile *f)
> > -{
> > -    /* save QEMU_VM_SECTION_END section */
> > -    qemu_savevm_state_complete_precopy(f, true);
> > -    qemu_put_byte(f, QEMU_VM_EOF);
> > -}
> > -
> >  /* Is a save state entry iterable (e.g. RAM)? */
> >  static bool qemu_savevm_se_iterable(SaveStateEntry *se)
> >  {
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

I took this. :)

-- 
Peter Xu


