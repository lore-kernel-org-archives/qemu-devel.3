Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F94606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMSWB2rc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dmxsGBo7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQm7-0003dr-Nv; Fri, 20 Nov 2026 10:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUQm4-0003dO-1T
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUQm2-00067a-1w
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795189417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bF1iXsmuTiffnRAypKRSFvwYQ+Yu4Gj8caBRkSiQF6Q=;
 b=HMSWB2rcUn3Z/Aeg+/jq4S1pCMMgGugsGIGP+FfJdCFb+/9s+fvrJD+Nnb+5kk8va4udQu
 p6qZpVnQ6nDUn2tMhoOj86mKAAmdD00w7FnX9tU0OGQcWatu02q2PuwEI0fXtiAxrd8p4R
 ocfkwVM3vIx0iZhKcRZ7MCJRSUg+0zg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-zcPEOTdxPGSO_1q7CLAmGg-1; Fri, 20 Nov 2026 15:43:33 +0000
X-MC-Unique: zcPEOTdxPGSO_1q7CLAmGg-1
X-Mimecast-MFC-AGG-ID: zcPEOTdxPGSO_1q7CLAmGg_1795189413
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53639e47be2so20854891cf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795189413; x=1795794213; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bF1iXsmuTiffnRAypKRSFvwYQ+Yu4Gj8caBRkSiQF6Q=;
 b=dmxsGBo7oiVJNnE6Dk16XRvo3k2n4mxsMc4Gz5FpNIqdtxf3V/AVBcndAczP+W6DBO
 RtVuZVREBEg0jU7IgziHUu0luqsjBqtCWZHN64GT+WRlaqVF4fLwpv7yzEfBwz+4RY7E
 R5p8t+yml67l56xVygUUxXbcUk+dAdocL0CwPfiS22OsnIwXfom+cUp9eA7aoqqvXpCi
 DY9A4EU8gzAEBrMEQXO6mtwkaFoRU5DCx/9sa9O01ik3ABGoYP2htBbekdbzAwCWeSEK
 8eQfecXP/UVNoeSywpSkq6E0islMEEIeTYi5JhZ1XzBiQxDO3OuTgKu0n0cen4PcPnVL
 1Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795189413; x=1795794213;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bF1iXsmuTiffnRAypKRSFvwYQ+Yu4Gj8caBRkSiQF6Q=;
 b=aYeCAOGKCimHl4x/ZyWVz/9nfFwE8ct12R7PbF0eBNpSnDih5mxaKlB5jqP/DQLSw0
 CE03KTafwnOvqhlnDqjrEhbjE2Lu8SYYY1B7VFfcGzliYpzKsgzpWmi6PFi2RBExYDB0
 59CSKFGNbZYaqZEBAJtBqjZNmdFJ02bc5ca8SYIbQ4/X138PxFoxy4qF1MQSmhUuXBkW
 lEYvkc5vxfQ4c6Ns/Ihv9zxqnbFP7FJ1MGddTd9syh2U7RwLGtXjo1EDfT5sNrfWlvbi
 LHUGcie3JvPfCmimXckf4IDRi816z0NUJsoLwNqMNyl+9r6QjjVHtUdpX10UEZgAQOGM
 /7Ug==
X-Gm-Message-State: APuU4Z+3ktVUX04bfpQQmfNEIlwBVVXUnD9mxDWPm/gblxAdw/g150X0
 K3tcbqd9Emf7I3HJzp+ST/xxS5/KTWzqA9+3cyLU3fKwAmpQa3V99rcvqo+5fifC1W6z202A3x1
 3x6tqxUIgXynRR5OtlcZM2PHoIfXYTgVJokNNqu0+Ojsd6HFsmuxZIr2s
X-Gm-Gg: AZFdTZeeDmMvExn3fDc7AFEee+/jrxb5N8yFwAkAt+r6PT4T1RV36SkUqmvsgAcDYJb
 Du9ReRyXHOdpcDSnnjYX5/EriWFdfKikKkU/Q2MxlrYXMv9Oclim2Rmpg4cLD3qGqlvUngc8S8d
 DqxT8SquYzLBbIXQA58dept/xEbrhFGmBJ+dJt1m3OrUfwm00JWbxPtYT7zt1ZlMjkdfRxEeDVj
 /SSGgzvyrJ94jKUqHBxJrxTAviaY7KbpLFki3zeFYpyd0IBhKZn0no9xj1DiPtSbH8k0drpC5w8
 WXZOqRjBYs3rMTs/AJINqyAMOIib2OFDWP8C5W183/qiXXdJEF9+BYR+ONNKSF3EBN3k5BJxz/R
 wXD407kePpnARCTPqbDOP1u/ZlsqqkyrE1eL8eje05fTbRw==
X-Received: by 2002:ac8:5a42:0:b0:55b:b758:9c4b with SMTP id
 d75a77b69052e-55d76a2987fmr66656951cf.13.1795189412932; 
 Fri, 20 Nov 2026 07:43:32 -0800 (PST)
X-Received: by 2002:ac8:5a42:0:b0:55b:b758:9c4b with SMTP id
 d75a77b69052e-55d76a2987fmr66656461cf.13.1795189412274; 
 Fri, 20 Nov 2026 07:43:32 -0800 (PST)
Received: from localhost ([2605:8d80:6d65:87a7:10d7:f219:658f:435a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349d0e35sm28024766d6.20.2026.11.20.07.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:43:31 -0800 (PST)
Date: Fri, 20 Nov 2026 10:43:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
Message-ID: <awBqoiy3zjHiXXEG@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-6-peterx@redhat.com>
 <awBYUwFhba1AYpZb@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awBYUwFhba1AYpZb@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 10:25:23PM +0800, Zhao Liu wrote:
> Hi Peter,

Hi, Zhao,

> 
> On Fri, Nov 20, 2026 at 07:49:22AM -0500, Peter Xu wrote:
> > Date: Fri, 20 Nov 2026 07:49:22 -0500
> > From: Peter Xu <peterx@redhat.com>
> > Subject: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
> > X-Mailer: git-send-email 2.56.0
> > 
> > We dropped all of that in C, drop that in Rust too.
> 
> but rust is using the different way to address this case :)

It's good that someone really knows Rust chimed in. :)

> 
> > The goal is to remove
> > the VMSTATE_VALIDATE() together with VMS_MUST_EXIST.
> > 
> > Use post_load instead for the check.
> 
> ...
> 
> >  // HPETRegistersMigration is generated by ToMigrationState macro.
> >  impl_vmstate_struct!(
> >      HPETRegistersMigration,
> > @@ -1109,7 +1111,6 @@ fn restore_migrated_state(
> >          .fields(vmstate_fields! {
> >              vmstate_of!(HPETState, regs),
> >              vmstate_of!(HPETState, num_timers_save),
> > -            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> >              vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
>                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Before this patch, the test method didn't work since vmstate_validate!
> has already done the check. But, IIUC, when vmstate_validate! goes away,
> this test seems necessary for rust side since it can help avoid overflow
> caused by num_timers_save (maybe it can be greater than HPET_MAX_TIMERS?
> before the commit 7be175e65f07).

True, actually for the HPET C change I did flip to use the num_timers
rather than the on wire integer to do the loading, assuming safer.

> 
> >          })
> 
> So LGTM for the change in rust hpet,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 
> And I find C side (in patch 3) handles this differently via using the local
> "num_timers".
> 
> In this case, I think we still have the option to keep the logic
> consistent between C and Rust :). We can add VMSTATE_STRUCT_VARRAY_TEST
> for C side:
> 
> #define VMSTATE_STRUCT_VARRAY_TEST(_field, _state, _field_num, _test,\
>                                    _version, _vmsd, _type) {\
>     .name         = (stringify(_field)),\
>     .num_indirect = vmstate_field_offset(_state, _field_num),\
>     .version_id   = (_version),\
>     .field_exists = (_test),\
>     .vmsd         = &(_vmsd),\
>     .size         = sizeof(_type),\
>     .flags        = VMS_STRUCT | VMS_VARRAY,\
>     .offset       = vmstate_offset_varray(_state, _field, _type),\
> }
> 
> and make C hpet use this:
> 
>         VMSTATE_STRUCT_VARRAY_TEST(timer, HPETState, num_timers_save,
>                                    hpet_validate_num_timers, 0,
>                                    vmstate_hpet_timer, HPETTimer),

One thing to mention is, here the test() function is not for validation,
but for checking if the field exists.

It means, assuming dest QEMU has num_timers=8, source QEMU has
num_timers=4, when migration happens with your VARRAY_TEST(), it won't
sanity check it, but since it saw 4!=8 it will assume the whole VARRAY
doesn't exist.

That's one reason why I want to get rid of VALIDATE(), because it's abusing
field_exist() IMO, and we don't necessarily need such abuse when we have
post_load.

> 
> Alternatively, we can also have Rust use num_timers (as u8) for timers
> array VMState, but this will bring back the conversion issue between u8
> and usize, which is the commit b3bf86b8936d & 6e85cfe44c0e want to fix...

Ohhh, I decided to not dig into this part. May I make a request instead? :)

Could you help me to come up with a Rust patch that does what's needed for
this series to drop VALIDATE and VMS_MUST_EXIST and replace this one (drop
my Author), meanwhile matches the best you'd like to?  It'll be much easier
to me then because my Rust is rust (this is not strict; it never shined),
so I can just pick it up when repost.

Thanks,

-- 
Peter Xu


