Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B173810AB810
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qbc-0000w3-Nh; Thu, 26 Mar 2026 15:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5qbb-0000vi-C4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5qbZ-0004go-J1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774554176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/Zn1mFmKiqlAZWnUfv0oAdityv+s4n+d8Eyp13MmPc=;
 b=CY5wV/Nw3g3HnkO649ksRy/ACZdDb7nBFpO3bcIRRWLmBIWGT/TTmGNFAGZqF1daTVXCQv
 QfQtW1Ud7IOZ0SEsthlyOYfnrXep/vzpZuFsmP8Uj/KFS0DJ0EG0EVVtgnfN/YsYCIDAnh
 hx1WJsW5SAiI22fPWawzk8MWHmlCRZA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-ZshjaVKZMDC7J1BpIHdKkw-1; Thu, 26 Mar 2026 15:42:54 -0400
X-MC-Unique: ZshjaVKZMDC7J1BpIHdKkw-1
X-Mimecast-MFC-AGG-ID: ZshjaVKZMDC7J1BpIHdKkw_1774554174
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfcf23c0e1so357475185a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774554174; x=1775158974; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s/Zn1mFmKiqlAZWnUfv0oAdityv+s4n+d8Eyp13MmPc=;
 b=jjd8VgC96oW3N7PFRCo3eqfFH3mhYnrpAr16wRpCbXfC7p3XDdE0iCjUDjFBRKuYmZ
 QzA9IWt4Kt3dOhXCDqfwPcIJKsF9qZf/648fcZu69c7MVZbq0amsZGLpsBfSs7r/+jQT
 h5Zj9yY254IXOxIGwt6Y1KXoOWF+uIjBorCeIlufVXU/Zc8+GmniLxgNk7G2Bpic+dMQ
 pk+rQ6OJN84yPBwHGVPh+M0P4hz2bgp3EQKD2BBVnvxTXWtLQZdq6ZYxAmfMp1COW0qg
 yflFarf2C/kJ7TthIzPFyHD/V4NIf9DEWGqqbNcLi7YqoYrMCPgyiTvy2kY5Lz2e3lGk
 hGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774554174; x=1775158974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/Zn1mFmKiqlAZWnUfv0oAdityv+s4n+d8Eyp13MmPc=;
 b=P80V2CrtqPV4ZK9ugYufefDCYHb8r8SxnRDZG3OJqDKRkWBengoeR8V87LMoLTKhFS
 k4G1VqMfcpWAbZcVJW31bUSGvzHgIN4PegY9EtzPU9ysRXpjDK0hS3EEn77UaN/R2k1T
 RS5UMYpWN5BygOukjCr6f/IG67tTCp2U2sLTxDVDc/4YhImWuxW9AFMNbDrJ6c5L5/QM
 sFPBk0dQKuHjjXifdCTOoIQcMGBDrGVeY7Oqfj7KgIuaiOojiJ2gsZqj0cCCyFH1fVqn
 yqH3+zguT9W/RmKKVQ/eIseZIzLCeUdun3/iNzXZDF5pi4WGKdkcIypNAItmO0FwxyG0
 8Ttg==
X-Gm-Message-State: AOJu0Yw74byVaSM78f/bWb7T3+1K3DVp7Um/HnPj6vO4NX2X0GYIzRj9
 uKGPDBpL+gjATBnnXp9jX39b6/effG7ASREC/YNKtN4GJlLhBwg9rt1csmlNPqMKCncQv68Bt6k
 Kr42ysxj2szY3wu1pSEmBDyaoIWfK+EmJCLodLW+AN7M4F31dAGJUovaW
X-Gm-Gg: ATEYQzyNL5Wk3m4vji3PmoY+nAXArrZrOf82KFwtLoxWjCHHKqvQH2nTsCsGS+09vWz
 Edb/8NX8wi6RHXs58NTlFJo56DjcTVoVNtxriElRz2m7+iOejoS9L75qWLVCFgzph/yK76P3N8p
 8DMetAvADyTNQvPdS1jYJ7TqgKOZWl8fxwqlC8bKaprmtMyDhZ47k7utQd4iSNyYZ3dk/ghQ2I6
 wKUDL5kaDXoVbJaUufI24LKrph5QNPwRGEJspU4h8L3j71/rJr7rrUYd5kKidqRDjvld1wy2Aeh
 /xSaP+is/6nVYGparGvM/+JLF2zuNxMLCaMwOH70ZI9TOcCzvDiuSS7+KKG7cfnsiQsot+sSoIh
 lFPELX+C2dvq+PA==
X-Received: by 2002:a05:620a:468c:b0:8cd:972d:335 with SMTP id
 af79cd13be357-8d00100aff6mr1231469085a.43.1774554174095; 
 Thu, 26 Mar 2026 12:42:54 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:8cd:972d:335 with SMTP id
 af79cd13be357-8d00100aff6mr1231464985a.43.1774554173478; 
 Thu, 26 Mar 2026 12:42:53 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4ceb95sm318341785a.26.2026.03.26.12.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 12:42:52 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:42:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 00/17] migration: vmstate_save|load changes for
 peterx
Message-ID: <acWMO4KZli736zEP@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <acQ61yMtzZPfLUAj@x1.local> <87mrzvk6us.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mrzvk6us.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 25, 2026 at 05:10:51PM -0300, Fabiano Rosas wrote:
> Sure, if there's anything you still find valuable but won't take for the
> repost let me know and I can send a separate series on top if that's the
> case.

I found that there're quite a few cleanups at latter patches, and it caused
some rebase pain if the base series still need frequent update.

So even if they look good in general to me, I want to leave them for later,
reducing scope of dependency.  After the API conslidated, we can do
cleanups on top.

Let me mention what I did and plan to post later:

> >>   vmstate: fixup the use of AUTO_ALLOC flag
> >>   vmstate: Remove vmstate_use_marker_field

I squashed these two.

> >>   vmstate: Stop checking size for nullptr compression

Picked.

> >>   vmstate: Set error inside of vmstate_save_field_with_vmdesc

Squashed.

> >>   vmstate: Remove vmdesc_loop

Starting from this one, I feel a bit uncertain, and maybe we can leave it
for later.

> >>   vmstate: Put array of pointers code together

This is a major cleanup, I left it and a few ones later aside for now.

> >>   vmstate: Create and save ptr marker in same function
> >>   vmstate: Don't recompute size and n_elems in vmstate_size
> >>   vmstate: Increase scope of vmstate_handle_alloc
> >>   vmstate: Remove curr_elem_p

I agree this is good, and..

> >>   vmstate: Introduce vmstate_first
> >>   vmstate: Introduce vmstate_next

.. despite that I feel like the current vmstate_next() impl might be
problematic (see my other reply), I also like this idea of having a _next
helper to hide some details on the ptr markers.  I'll adopt that idea,
thanks.

> >>   vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC

Until I get corrected I think we'll need this flag, as said.  I feel like
it's better to keep VMS_ALLOC semantics as before (when set, it must alloc
the top field object ignoring stream data), then this one for the array
elements separate (meanwhile, this one is "optionally done", based on the
stream data).

We have plenty of space for VMS_* flags and it's not ABI.  IMHO when we're
not certain to merge flags we can always keep them separate until later too.

> >>   vmstate: Move VMS_MUST_EXIST check
> >>   vmstate: Invert exists check
> >>   vmstate: Declare variables at the top
> >>   vmstate: Reduce indentation levels

All these seem to be cleanups.  I plan to leave them separately.

I think it might be good I send another version directly, I'll do it very
soon and keep it RFC.  If I missed something while reading this series,
please then let me know.

-- 
Peter Xu


