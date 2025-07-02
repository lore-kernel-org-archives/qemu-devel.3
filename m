Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52C6C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyqf-0003YQ-TV; Wed, 02 Jul 2025 10:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWyqX-0003Pg-O8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWyqM-0001sy-L3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751468028;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ke9J9I0lOlL+WN5tt+oWmWTzgvnsNB/mc9z9oBFeXdc=;
 b=LDh46DHvLXP6p1mHhrOrqwBUWfhrTJagFa+Tzl4oxBIGMQz2OdVQ3fvAiR4U5jkYYawDDr
 ldalMFFukXQUZkGpFgDz96p0nyiLrpNvEzfnSRhnScG2zAXHviJKR3i1VO9jSRF0DttarG
 Kc4U0J4g1B7dt6+45NGuEp195Lb8/tg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Nc7FYab_ObW0xik6u6ILsQ-1; Wed, 02 Jul 2025 10:53:47 -0400
X-MC-Unique: Nc7FYab_ObW0xik6u6ILsQ-1
X-Mimecast-MFC-AGG-ID: Nc7FYab_ObW0xik6u6ILsQ_1751468023
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2354ba59eb6so76470765ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468023; x=1752072823;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ke9J9I0lOlL+WN5tt+oWmWTzgvnsNB/mc9z9oBFeXdc=;
 b=VXFk7Ory0xhItJu9X1BozFNWYauN78oq1GHTrLPOVYDCs5qomsUjlk1M+XaKuqcnZI
 OEOTD6piTVPuB/6DyIMkr3smlk1zgyaw8JaIqkgYY450NGX0gYA2QFjg1qu9nd4YzL/S
 ct39rDUhGwQMg4ZSEEXDj+qMhKbuRFcUn7MQrm7YwsnBd1eMpEzsSkh1FACL9qfoQIIj
 S7jcXcjtmNai0F/DH3eMqoo33xVT266nBqh+ybd4osKzplHqW1ydpjLdQqp/PtgYmvll
 03EeIhLL5B6MbnTnZQ8vDk62igYCu89MEFcAjkpdvclJF6Z3mIkPuaWn+CwGW3dMuHsP
 sxvA==
X-Gm-Message-State: AOJu0Ywn9szbiZxAbVBK9Bc0c2JSNM+XX22z18AgwFosIIm+VnxfcoxP
 pmn1fFC3JFwzFOCmST89iQyFca6Ljjq38yaWWnlWNIk/VcpYXI5rR0EkNLuf13bLIjdba6Wyk7X
 0QL/0dhdEY8513bdv8VwZKniZcSnZrcgm3RrQsPiLUgWf+dXR0EcHR3Sc
X-Gm-Gg: ASbGncvnDLXeD8z/djLDQ26qR7PdCjQxtgs8lCebMOnYSqSSqxP4gZ3imJ7FyKHs2Xy
 Imx5br+O2SP0znAVdFIwXZwZD3UAC1OLRLezkF4tuio3tNwS6nt6sZM0j1dU1py6lT41D9VUwW/
 mH8kMkKebKM7XmurX/DBBnHB6JG0fndAHiBp9bz+kQxOn/VWJ/03z4qDco+Pc6m6WnkvrOnxfsH
 g0y1O4ezrGRIfNvPBPxlGBI1IJ17jyVxwjy7JySh5zf+7M8xk+SUxAdPcHB8EmZE/qOb6oRQzhK
 VxEl1QTAQtSvezpF+Mlag2Gns7uthd+gLB8=
X-Received: by 2002:a17:902:d508:b0:234:d7b2:2ac3 with SMTP id
 d9443c01a7336-23c6e4ae2e6mr38828255ad.20.1751468022948; 
 Wed, 02 Jul 2025 07:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4AB/EvzoFAVDVArNpRvsyVgApeor0FRF/uKLLEz2bLrDIdzEJdA+MF4Ai0LjF667NNg2yAQ==
X-Received: by 2002:a17:902:d508:b0:234:d7b2:2ac3 with SMTP id
 d9443c01a7336-23c6e4ae2e6mr38827865ad.20.1751468022532; 
 Wed, 02 Jul 2025 07:53:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bca5sm129315375ad.124.2025.07.02.07.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 07:53:42 -0700 (PDT)
Date: Wed, 2 Jul 2025 20:23:32 +0530
From: Arun Menon <armenon@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
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
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] migration: Pass Error object errp into vm state
 loading functions
Message-ID: <aGVH7EhmHZ_HzRvm@armenon-kvm.bengluru.csb>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
 <20250702-propagate_tpm_error-v3-1-986d94540528@redhat.com>
 <87ikkawxts.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikkawxts.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Markus,

Thanks for the review.

On Wed, Jul 02, 2025 at 03:01:51PM +0200, Markus Armbruster wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > - This is an incremental step in converting vmstate loading
> >   code to report errors.
> > - Minimal changes to the signature and body of the following
> >   functions are done,
> >   - vmstate_load()
> >   - vmstate_load_state()
> >   - vmstate_subsection_load()
> >   - qemu_load_device_state()
> >   - qemu_loadvm_state()
> >   - qemu_loadvm_section_start_full()
> >   - qemu_loadvm_section_part_end()
> >   - qemu_loadvm_state_header()
> >   - qemu_loadvm_state_main()
> > - error_report() has been replaced with error_setg();
> >   and in places where error has been already set,
> >   error_prepend() is used to not lose information.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> 
> [...]
> 
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
> >      }
> >  
> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > -                       void *opaque, int version_id);
> > +                       void *opaque, int version_id, Error **errp);
> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                         void *opaque, JSONWriter *vmdesc);
> >  int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
> > diff --git a/migration/colo.c b/migration/colo.c
> > index e0f713c837f5da25d67afbd02ceb6c54024ca3af..808c980b4af3199968771cdc6cca3c2451a2f4a6 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
> >  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      uint64_t total_size;
> >      uint64_t value;
> >      Error *local_err = NULL;
>        int ret;
> 
>        bql_lock();
>        vm_stop_force_state(RUN_STATE_COLO);
>        bql_unlock();
>        trace_colo_vm_state_change("run", "stop");
> 
>        /* FIXME: This is unnecessary for periodic checkpoint mode */
>        colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
>                     &local_err);
>        if (local_err) {
>            error_propagate(errp, local_err);
>            return;
>        }
> 
> Avoid error_propagate() when you have ERRP_GUARD():

Something I missed; added ERRP_GUARD for using error_prepend() below.
I should have changed the preceeding error_propagate() calls.

> 
>        colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
>                     errp);
>        if (*errp) {
>            return;
>        }
> 
> See the big comment in qapi/error.h for additional guidance.
I see.
> 
>        colo_receive_check_message(mis->from_src_file,
>                           COLO_MESSAGE_VMSTATE_SEND, &local_err);
>        if (local_err) {
>            error_propagate(errp, local_err);
>            return;
>        }
> 
> Likewise.  More of the same below, not flagging it again.
> 
> > @@ -686,11 +687,13 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >  
> >      bql_lock();
> >      cpu_synchronize_all_states();
> > -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> > +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_err);
> >      bql_unlock();
> >  
> >      if (ret < 0) {
> > -        error_setg(errp, "Load VM's live state (ram) error");
> > +        if (local_err != NULL) {
> 
> How can @local_err be null here?
> 
> > +            error_prepend(errp, "Load VM's live state (ram) error");
> 
> Since nothing has set @errp so far, it should still point to null.
> error_prepend() crashes when passed a pointer to null.
> 
> > +        }
> >          return;
> 
> Returns without setting an error, and leaks @local_err.
> 
> Can you pass @errp to qemu_loadvm_state_main() and call it a day?

Yes, I am going to do that in the next version. Making sure errp is set
in all paths.
> 
> >      }
> >  
> > @@ -729,9 +732,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >      bql_lock();
> >      vmstate_loading = true;
> >      colo_flush_ram_cache();
> > -    ret = qemu_load_device_state(fb);
> > +    ret = qemu_load_device_state(fb, &local_err);
> >      if (ret < 0) {
> > -        error_setg(errp, "COLO: load device state failed");
> > +        if (*errp != NULL) {
> > +            error_prepend(errp, "COLO: load device state failed");
> > +        }
> 
> Since nothing has set @errp so far, it should still point to null, so
> this will never prepend anything.

I might have mixed up local_err and errp, sorry about that.
I am going to revise this.
> 
> >          vmstate_loading = false;
> >          bql_unlock();
> >          return;
> 
> Returns without setting an error, and leaks @local_err.
> 
> Can you pass @errp to qemu_load_device_state()?

Yes. I am going to do that.

> 
> > diff --git a/migration/cpr.c b/migration/cpr.c
> > index a50a57edca754b50e68fa9c294b3c89791e62ba8..0fb9fadac905c83689eed2b1193b282da679b6ef 100644
> > --- a/migration/cpr.c
> > +++ b/migration/cpr.c
> > @@ -235,7 +235,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
> >          return -ENOTSUP;
> >      }
> >  
> > -    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> > +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
> 
> If vmstate_load_state() fails, it should set @errp.
> 
> >      if (ret) {
> >          error_setg(errp, "vmstate_load_state error %d", ret);
> 
> Setting it again will trip error_setv()'s assertion.

Yes, I see. Should be changed.
> 
> >          qemu_fclose(f);
> 
> I doubt you tested your changes to the error paths.  This is dangerous.
> 
> I did not look at the remainder of this patch.
> 
> [...]
> 

I am going to revise the changes and send a new one. Thanks for the review.


Regards,
Arun.


