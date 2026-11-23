Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646E606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6mp63M5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ww1K9ApE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSlY-0001Wk-M6; Mon, 23 Nov 2026 07:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVSlU-0001Vh-Ud
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVSlR-0001Aq-NW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795435394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1onM7vQOH4ybeT1o/duq27rl7jDAlFyfvuCyzAHhmu4=;
 b=U6mp63M5SshH1iD1j0+upRFuc3LXQpvnR02eHzmjcAdSx/Tf7/KybxAx9bPD/TDYQbLr9t
 0OcNUumspb4EjgKSt0XFRC8GuWZMNYCQE18//MGU4/oPIQulF76vRPzBMjT4cGR9etjscM
 CDRYOB+DxxuiwR005Uh8MepYyZUrwLk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-BicIy_IrMWKznazUCTWoIA-1; Mon, 23 Nov 2026 12:03:12 +0000
X-MC-Unique: BicIy_IrMWKznazUCTWoIA-1
X-Mimecast-MFC-AGG-ID: BicIy_IrMWKznazUCTWoIA_1795435391
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b4e8af48c8so42803627b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 04:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795435391; x=1796040191; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1onM7vQOH4ybeT1o/duq27rl7jDAlFyfvuCyzAHhmu4=;
 b=Ww1K9ApESDEVYyGxg2UoLS9PtiC8D5WNREBGCJKLIYfXFcQDyRaPNxP2H5y63mh1cu
 Se0C+ZIP7cZxvfbL53+bsEflr8Kg4vrjTYTAxhCcHXFR50wEcpmGkMoBYD1rlytj5A12
 B6U38DrE+6HviVXUZxSk01LQt1YDtKbx3H5yufD7AZnmvUpXeZYJBJyiPAORYMRZ0oYC
 q8lMDXiPkxfyD06QHYV/j7uNAJ2uyhsk6TTZtR52PhKcWLnv4EYYqcGPWL4Vq3jQpn9H
 7m9G6xw+GJ0ZFp2xUAcKEOJsWegfg4RxqQK460/uCi7U5/TsfujliR1YgsaQYENtAgMt
 UqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795435391; x=1796040191;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1onM7vQOH4ybeT1o/duq27rl7jDAlFyfvuCyzAHhmu4=;
 b=W6mIJy3w6qUhVHYKQIGt2O9qag70JaUors1t50NQ/Wst2/DGU4PNtJjvuI33vJp42M
 TOsnWC9qqkTG0W52yKUsunMZun5NlYnTwepw7FgSqR+kcX1Ad7hQPUNlqxBl8OC5CyIJ
 pFpBxDXbLnOmK6TjmmNNvXP/upj16C+quJ9l2Q6r/ryAkyengWuHT4i9C6qDeUbeu6Eo
 j2fSbAFAWlESLhDfL/S9pG/KBx1yquoyWbp2MDD8aBSPQX+wsnR07Pqb/0RmamkiETuZ
 pcgj5XeohSUyOj0TffIxX0pKja2KjceFlRxMtKe3w1EpiITGwRnvgHoM6/kOJcFntJYX
 Ohfg==
X-Gm-Message-State: APuU4Z+jwtfjeZAG9rdZN55mljV7STQJ5I5XBqaUjG8DSqNCd5dV0ZEj
 xE74zYh0JgULvi33chOWfu4YS/dQcCX7yGu4e/0dYHBAr5Zun/NmaxC40qQI7aZjWj32OzVEsbL
 4Kw2gysxh2qob6rZ6vfPn0D4mUKDqKtwMNNRG8EdGxBQVGf7digY0Df6Y
X-Gm-Gg: AZFdTZcYYxdb3stOdL540oj1xcGFVuISCW61U7gTQF5jsUY+A56bqa3z+SF2n5UxmKg
 f0f468z6Fw+0XPWYrkVfnS4frUfUwVwcqHMRAverTptT6gcWVLiaF8KU8YaDUP7HDYi3Sas2v89
 lz8l8d3Qgg+SCnlmG92YYki35nx8xFyGmFrMYruk2UgAyWMX/3RRhL/HajRvbsfKvr5sDl27vBY
 grWO/c9mrvD9tqTtKynUpDoPZcBHd2lXJKbK/tUEfgNMU2hrjnO/0mVPWvghk56/n/Y15gIk+y4
 1CgvpXWLmknshOTMlwmCyxYO8N5oZGJQ2XqpQPTPvYWbCildAywW5RmSDO2m2HKqSMe2IZRzyB0
 1401u1iKB5YYW0y7i3s85N0mld/EdFWi2szij5oGwNlBx
X-Received: by 2002:a05:690c:c04:b0:8b4:c8c5:6b11 with SMTP id
 00721157ae682-8b5204f087fmr54864727b3.36.1795435391260; 
 Mon, 23 Nov 2026 04:03:11 -0800 (PST)
X-Received: by 2002:a05:690c:c04:b0:8b4:c8c5:6b11 with SMTP id
 00721157ae682-8b5204f087fmr54864177b3.36.1795435390614; 
 Mon, 23 Nov 2026 04:03:10 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb34a38bsm778661685a.13.2026.11.23.04.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:03:09 -0800 (PST)
Date: Mon, 23 Nov 2026 07:03:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
Message-ID: <awQrfKAyGDxxI3Gl@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-6-peterx@redhat.com>
 <awBYUwFhba1AYpZb@intel.com>
 <awBqoiy3zjHiXXEG@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <awO3EjQI/8QJsyZ9@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awO3EjQI/8QJsyZ9@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 11:46:26AM +0800, Zhao Liu wrote:
> > > And I find C side (in patch 3) handles this differently via using the local
> > > "num_timers".
> > > 
> > > In this case, I think we still have the option to keep the logic
> > > consistent between C and Rust :). We can add VMSTATE_STRUCT_VARRAY_TEST
> > > for C side:
> > > 
> > > #define VMSTATE_STRUCT_VARRAY_TEST(_field, _state, _field_num, _test,\
> > >                                    _version, _vmsd, _type) {\
> > >     .name         = (stringify(_field)),\
> > >     .num_indirect = vmstate_field_offset(_state, _field_num),\
> > >     .version_id   = (_version),\
> > >     .field_exists = (_test),\
> > >     .vmsd         = &(_vmsd),\
> > >     .size         = sizeof(_type),\
> > >     .flags        = VMS_STRUCT | VMS_VARRAY,\
> > >     .offset       = vmstate_offset_varray(_state, _field, _type),\
> > > }
> > > 
> > > and make C hpet use this:
> > > 
> > >         VMSTATE_STRUCT_VARRAY_TEST(timer, HPETState, num_timers_save,
> > >                                    hpet_validate_num_timers, 0,
> > >                                    vmstate_hpet_timer, HPETTimer),
> > 
> > One thing to mention is, here the test() function is not for validation,
> > but for checking if the field exists.
> > 
> > It means, assuming dest QEMU has num_timers=8, source QEMU has
> > num_timers=4, when migration happens with your VARRAY_TEST(), it won't
> > sanity check it, but since it saw 4!=8 it will assume the whole VARRAY
> > doesn't exist.
> > 
> > That's one reason why I want to get rid of VALIDATE(), because it's abusing
> > field_exist() IMO, and we don't necessarily need such abuse when we have
> > post_load.
> 
> I see, this makes sense.
> 
> > > 
> > > Alternatively, we can also have Rust use num_timers (as u8) for timers
> > > array VMState, but this will bring back the conversion issue between u8
> > > and usize, which is the commit b3bf86b8936d & 6e85cfe44c0e want to fix...
> > 
> > Ohhh, I decided to not dig into this part. May I make a request instead? :)
> 
> Happy to help :-)
> 
> > Could you help me to come up with a Rust patch that does what's needed for
> > this series to drop VALIDATE and VMS_MUST_EXIST and replace this one (drop
> > my Author), meanwhile matches the best you'd like to?  It'll be much easier
> > to me then because my Rust is rust (this is not strict; it never shined),
> > so I can just pick it up when repost.
> 
> I find it's possible to use num_timers directly without going back to
> u8 type. Since the commit 1f0b40dccfe5 ("migration: Remove redundant
> flags"), C side has already dropped VMS_VARRAY_UINT8/16/32, so Rust
> side can use usize as the array length type (without migrating it), like:
> 
> unsafe impl VMState for usize {
>     const BASE: VMStateField = {
>     	panic!("usize cannot be migrated, use a fixed-size integer type");
>     };
>     const VARRAY_FLAG: VMStateFlags = VMStateFlags::VMS_VARRAY;
> }
> 
> I'll think more/cook a patch based on this approach.

Thank you!  For me I don't need everything, a minimum patch to make the
next patch pass would work.  But anyway I'll wait for that.  If your series
will be separate and stand on its own, I'll just rebase to it.

-- 
Peter Xu


