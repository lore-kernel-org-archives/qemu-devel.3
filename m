Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39800606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+LymvkF;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JKuqQJSw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWJtP-0002II-2l; Wed, 25 Nov 2026 15:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWJtL-0002I7-Sd
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWJtJ-00047R-S2
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795639615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUS3QDRlRraN6PDPlZyn3xhWGR3Tsku+oV6bPsOf71U=;
 b=J+LymvkFsq8O1tBIlZaExPRmbae7KXsXzpDijg06m3JuCpXAQ4uucr9eVvdxQyrrawtBZO
 8zVJUNqlQP8RoNNWlsd2uHYvhyCdoqmEBY1EKAuoaxOCfcDz+l0BIz0FcGqmpXpwx8/H8/
 dGMxI+cga+LCgwHgjf2+FzYmSxEYJ0A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-8IyOnbygMYm8ysbt0qzRew-1; Wed, 25 Nov 2026 20:46:53 +0000
X-MC-Unique: 8IyOnbygMYm8ysbt0qzRew-1
X-Mimecast-MFC-AGG-ID: 8IyOnbygMYm8ysbt0qzRew_1795639612
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5383d650f2dso109581891cf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 12:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795639612; x=1796244412; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NUS3QDRlRraN6PDPlZyn3xhWGR3Tsku+oV6bPsOf71U=;
 b=JKuqQJSw8v3YxhFLM9IXusy7ojqxKYj6Vxd78g3a3Pv8FqgjUMc0uDFVjnBTSNdxIO
 ej6L85Hkg78ISVRrwfSvjJju4LgjVkHCeKLExuXHAh4AJRnHnlzv/ZTJ2cZrEYhjZ5Jt
 /psNnNfwbUxP6qbarzQRiy3dr7mDQQJLEeUJ5fMeGgaRyOjrz76tBsawJ4vAKIGX7WLo
 0ScJhna0WojtJkZLU22OW8a17IwL5JiL/JH0coMO8qSkZ67wmhbjgAFyQDvBSRdQMvWv
 V8F2RciIuTJ3t0A0Laae4nrRlVW/yS1Np/v78jvzO2/dNZYoTVRxhBte9OemFnHeVF9v
 /VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795639612; x=1796244412;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NUS3QDRlRraN6PDPlZyn3xhWGR3Tsku+oV6bPsOf71U=;
 b=BzCM77ZR9sr3HJRJLYRPQi4wo0u/VOChld6NNXoObphcKSiIDQX8ZYBUCy8HoW/KSv
 0jPjlORggrgdxA1mup5UAs+unz67CLHao0Ffgg3PUHUfmx783GYg+p9VFxXrY00oGObK
 N8z/0F4iYbRSSXW0FZdrWADMuJveS/2AO9X+VMQrzEFR59otn91MTeBs2el/2z0VJfVA
 KtvhlwfTNAJmYrcnPpUmw4hTRE358daIrNrlwft6xTJ+OrBiKw23UYQPfD/Xw10ILNsu
 O8FiFjDM6lOK8oL6wLELE/nQpchrws+YfjJVyuQ9TPI7qYCTObYWytR3ySJAaegnyH0P
 3+lA==
X-Gm-Message-State: APuU4Z/mOJWm8Su9sT/iSMbGUieON/hYnpaHj+M5x/ceWEA8ebRDf7h4
 ef8KlldeltBEho80eUMWAUWwe3adq1EbAMvi9CsyeC5Kn29QH+Z9pd6A4dFH9VoDpVJwn/V/tbF
 ff230+BYg1xvKRvpc8gMyFGzjs4tXNKkE+mQeJ8U6XDfU5Q3m8C2/FqBY
X-Gm-Gg: AZFdTZeZObId1ARSObfaE2G9ZTk+8L1zx9rBkL5UPHXcIfHGgIQPqkw9yB6HZF+dg+P
 6mM5WJvprksSIeS5B5RrFrg/aY+NRX7j2/VstKJiVFUb05iMUYlco7fV6MXqLHI1cmYWDCzfAlB
 wC49FkLkKklL6nTMt0E6EyFnLmzGulzrHALVU/CuXXpeSNRWRaA6cHn3/9tULiUCKBN+TmFs3T2
 Uam0ZbiyluGeIfP4FqEGXsk9pw+FrUvmqfBUllPpOH94mpPkxZFzo6vg12px+62J3QSxtMfId9H
 CLK+5bY5D024GmcUjjPmNYMEB9kjgKZO+Dz7OuK2oY2iOr7X7Cliw71NHR6SUA/yOOk3/3hBfD/
 Bw5CPjk3Gg+mOyKE2WI+MMd07yRjc0OhKzmMZEeVyn9gg
X-Received: by 2002:ac8:5f85:0:b0:55d:32ed:38bc with SMTP id
 d75a77b69052e-55d76aac74fmr354236341cf.76.1795639612278; 
 Wed, 25 Nov 2026 12:46:52 -0800 (PST)
X-Received: by 2002:ac8:5f85:0:b0:55d:32ed:38bc with SMTP id
 d75a77b69052e-55d76aac74fmr354235981cf.76.1795639611681; 
 Wed, 25 Nov 2026 12:46:51 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7c654585sm158982371cf.5.2026.11.25.12.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 12:46:51 -0800 (PST)
Date: Wed, 25 Nov 2026 15:46:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-12.0 3/6] hpet: Move VMSTATE_VALIDATE() check into
 post_load
Message-ID: <awdJOaZhYsUMd7p0@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-4-peterx@redhat.com>
 <CAFEAcA8NenDCC2Tvv5Z8pU8MiA=QSXf2xwfbZfMYv96y68Vc9A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8NenDCC2Tvv5Z8pU8MiA=QSXf2xwfbZfMYv96y68Vc9A@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 03:46:40PM +0000, Peter Maydell wrote:
> On Fri, 20 Nov 2026 at 12:49, Peter Xu <peterx@redhat.com> wrote:
> >
> > To pave way for removing VMSTATE_VALIDATE(), move the usage of hpet into
> > post_load.  To make it safer, loading the timers with the num_timers, then
> > only check against the wire number at last.
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/timer/hpet.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> > index 42285cff76..85cd26a454 100644
> > --- a/hw/timer/hpet.c
> > +++ b/hw/timer/hpet.c
> > @@ -254,25 +254,28 @@ static int hpet_pre_save(void *opaque)
> >      return 0;
> >  }
> >
> > -static bool hpet_validate_num_timers(void *opaque, int version_id)
> > +static bool hpet_validate_num_timers(HPETState *s)
> >  {
> > -    HPETState *s = opaque;
> > -
> >      return s->num_timers == s->num_timers_save;
> >  }
> >
> > -static int hpet_post_load(void *opaque, int version_id)
> > +static bool hpet_post_load(void *opaque, int version_id, Error **errp)
> >  {
> >      HPETState *s = opaque;
> >      int i;
> >
> > +    if (!hpet_validate_num_timers(s)) {
> > +        error_setg(errp, "num_timers must match");
> > +        return false;
> > +    }
> > +
> >      for (i = 0; i < s->num_timers; i++) {
> >          HPETTimer *t = &s->timer[i];
> >          t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
> >          t->last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - NANOSECONDS_PER_SECOND;
> >      }
> >
> > -    return 0;
> > +    return true;
> >  }
> >
> >  static bool hpet_offset_needed(void *opaque)
> > @@ -332,14 +335,13 @@ static const VMStateDescription vmstate_hpet = {
> >      .version_id = 2,
> >      .minimum_version_id = 2,
> >      .pre_save = hpet_pre_save,
> > -    .post_load = hpet_post_load,
> > +    .post_load_errp = hpet_post_load,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT64(config, HPETState),
> >          VMSTATE_UINT64(isr, HPETState),
> >          VMSTATE_UINT64(hpet_counter, HPETState),
> >          VMSTATE_UINT8(num_timers_save, HPETState),
> > -        VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
> > -        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
> > +        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
> >                                      vmstate_hpet_timer, HPETTimer),
> 
> What's the failure mode of VMSTATE_STRUCT_VARRAY if the destination
> tries to send us the wrong size of data for what we're expecting?
> Hopefully it gives a useful clear error message.
> 
> >          VMSTATE_END_OF_LIST()
> >      },
> 
> We need to keep sending out the num_timers_save value on the wire
> so we can send to a destination QEMU that honours the inbound value,
> but it's tempting to suggest that on input we should just ignore
> the inbound value, as we would do for any other QOM property or
> command line parameter that needs to match on source and dest
> for a successful migration. If they don't match then it's very
> likely that the migration already failed on the STRUCT_VARRAY
> field before it even got to the post_load hook.

Indeed.. if num_timers don't match, I expect either of below can happen:

- When n_src < n_dst, due to the fact that loading VARRAY itself doesn't
  contain any footer, we'll keep loading the stream assuming whatever comes
  next to be VMSD of type vmstate_hpet_timer.  There might be unwanted side
  effects like VMSTATE_TIMER_PTR() causing timer_get() to read some data
  from wire, apply it to the local timer as timestamps.  Finally it'll fail
  likely due to check_section_footer() fail for vmstate_hpet at the end,
  noticing the footer stops matching.

- When n_src > n_dst, no unwanted side effect like timer_get(), but dest
  QEMU will expect vmstate_hpet section footer but see some timer binary
  streams, hitting the same error on check_section_footer().

Likely, the post_load_errp() check on number match isn't helpful indeed.
Should either be dropped or I play the same pcie/aer trick to maintain it
like before.

I saw it's confugurable for the hpet device:

    DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),

I think it means it can only happen with a wrong QEMU cmdline setup.
Basically it violates the guest ABI, and shouldn't happen in production.
I sincerely don't know if anyone would ever change num_timers..

Personally I feel like maybe I should just convert the num_timers_save to
be NOT_USED, then drop the check directly?

-- 
Peter Xu

