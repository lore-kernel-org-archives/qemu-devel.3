Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC1606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vz//+3G2;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bYj8yRzS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNlw-0003KI-3R; Fri, 20 Nov 2026 07:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUNli-00034e-G9
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUNlg-0000AF-A0
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795177862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6TE6Ky4ywyspvMCHEsHJWDaHFmYAhCGKgVs139TgshE=;
 b=Vz//+3G2sr0buKRPZ0jCGWYpD9ipX5v41lrKQP5Qa3dEdnMJ+K7Ic2s1lXYKjhzMHyvQW9
 h/fQYpbi97s4irUpvikYvkQkFW4VX+xHtmK+6KYsif6Wq/907iTV2fmlwJuom2Ru2CNoL9
 9izNtIq4AYRPwt89RL1yQ6Getb3XHXs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-_1rZKsZNM4GIXfQxQQkI9A-1; Fri, 20 Nov 2026 12:31:00 +0000
X-MC-Unique: _1rZKsZNM4GIXfQxQQkI9A-1
X-Mimecast-MFC-AGG-ID: _1rZKsZNM4GIXfQxQQkI9A_1795177860
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so189287585a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795177860; x=1795782660; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6TE6Ky4ywyspvMCHEsHJWDaHFmYAhCGKgVs139TgshE=;
 b=bYj8yRzSgWIYgkmvanrpwBU7sLdBJoYPjKy87qw5edeCYbs93fdLd3nM3qvfRJJFDp
 W5CtKtUSu8VG6ylkPIQn+HCaLbYakZ00ma43TwYYND81PEzOK2OrxUkyHf0MHOLuNLem
 LAQ5mfIVY+EPE3Gh04e1Qjik2tT7O7L66aBFcSKMVZ4Zsg1oxswMXU+L7u2Hie8dGiRU
 2WIRVvtbdvnx7/vEtjnTl/ubQjpZZmhb4+FKdEnK1agW/pQWglATadTIUDGQ71rgbJT4
 +ginHnPpz1pcenb+YzoHK3UDxO0SgVZQxPLq8Uw6wtaZm5MzGZkaXAjF75v8QK3zem6z
 n9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795177860; x=1795782660;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6TE6Ky4ywyspvMCHEsHJWDaHFmYAhCGKgVs139TgshE=;
 b=VoqjGKI7nSzprLLFQhw7/9j538wRp/Z8mMwgTblAK0uW0yoJsVfW5jPVpgWHV2tH+J
 7CKoiQmS93MQ/Z8Bw6UpkJLPvsJOEy7H0mctlxA0cUlYqaXyeSM/QTEOhibSyzcRJ3Uv
 K+ghXL7HKWtVm1wd5TfSD0NXAmJ8c7PviIVDaXl5rIyygSVVVW6xZN5BvN5ifKBhORaI
 kT2IMjiKTnrhxxWRsmezQZ2hUidiJQPKFLctqNnTqARoLtNEBEASNEuHnYseus7lxck7
 jmB1ImqGuJfU+6Y6TdA3qUFpC9jy0cFyCjr+N8FFD7yhJ48PFnu3Jtlf21csIfy9ZEyt
 ODbQ==
X-Gm-Message-State: APuU4Z/suYbpXu7z3GFX7tAKPDG7yBcB+x4YY7TV5NFXrljAtPPxMcdc
 OdoW+1vP5z7t2n9DRsVDc7UtRqnXyeiyTNSjqeTGOMurLl+DUXQ5LNqLaktcB7Qx+xbopPmcuXS
 wQPiknrgzKT5dK7e2HxZ62PMHi2DWp7XWyFW6CGC4hp+r+OYJTpwwaya4
X-Gm-Gg: AYBFou1WR+rx8nRnBfDxERi60H+azdCrv+XknVAR2oZ/hK5T+4gkUzfqhnmlibv4Zo+
 uoOt86sFZaYh4rgsx2CnjljJOoJEr1fD1YWsvD2oi6qgqscWdM3peWfSGUyM670m1n/I+EREwxD
 Zt84EL5OkLgHK5bqvdXCmEmmVkHKeS91OCtaVOSKWtHFZC5gCRtKpGlj43JhfvUzJQ8TvnGwg6E
 1KYuQSuIAw6oiT6ZO9OWSh1/gTIelPB9esR0SfUMZJ+NuzaKwp2wu4TagOUR2eENzoK9AUeFQt0
 CsN4p9+9dhq35HKWJkL4i0Pq3X7yB31fXjX78RuzUWEnYIeomY/uu7pRUxwoUMukj4Ye1SKSVNo
 TZYwtyFZY4sLb3GOQFoOqqWkSn4I/k239kPBN4jT0On/+
X-Received: by 2002:a05:620a:130d:b0:939:4a44:5f99 with SMTP id
 af79cd13be357-949ba80f3f4mr430092985a.10.1795177859436; 
 Fri, 20 Nov 2026 04:30:59 -0800 (PST)
X-Received: by 2002:a05:620a:130d:b0:939:4a44:5f99 with SMTP id
 af79cd13be357-949ba80f3f4mr430085185a.10.1795177858768; 
 Fri, 20 Nov 2026 04:30:58 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb427388sm175797985a.42.2026.11.20.04.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:30:58 -0800 (PST)
Date: Fri, 20 Nov 2026 07:30:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
Message-ID: <awA9gHtzrNgyWWkc@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
 <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8UWw+CpaS8wyy0A_MSeXhJ3NzJGcLm-iHkzmw5t9Cd_w@mail.gmail.com>
 <av9be5IWLpQJu-F_@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-fmyi6iWBbXmUUWkf=-9duEySHyPE_ELz8FLgcrhcGAQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-fmyi6iWBbXmUUWkf=-9duEySHyPE_ELz8FLgcrhcGAQ@mail.gmail.com>
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

On Fri, Nov 20, 2026 at 11:11:07AM +0000, Peter Maydell wrote:
> On Thu, 19 Nov 2026 at 20:26, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Nov 19, 2026 at 06:53:19PM +0000, Peter Maydell wrote:
> > > I don't think you can deal with the pcie_aer usage this way though,
> > > can you ?
> >
> > Attached a patch for that, please have a look.
> >
> > IMHO it's a matter of if we think VMSTATE_VALIDATE() useful.  At least for
> > the current form, I don't like it, especially hijacking the field_exists().
> > I hope post_load_errp() is enough.
> >
> > Thanks,
> >
> > ===8<===
> > From d92c2548ea084091d3baf51682b150dd4e0f2316 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 19 Nov 2026 14:53:47 -0500
> > Subject: [PATCH] pcie/aer: Remove the usage of VMSTATE_VALIDATE()
> >
> > Paving way removing it.  We can replace it with a post_load_errp() instead.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/pci/pcie_aer.c | 40 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> > index 43b14c1f22..87248556d4 100644
> > --- a/hw/pci/pcie_aer.c
> > +++ b/hw/pci/pcie_aer.c
> > @@ -807,21 +807,51 @@ static const VMStateDescription vmstate_pcie_aer_err = {
> >      }
> >  };
> >
> > -static bool pcie_aer_state_log_num_valid(void *opaque, int version_id)
> > -{
> > -    PCIEAERLog *s = opaque;
> > +typedef struct {
> > +    uint16_t v;
> > +} tmp_u16;
> >
> > +static bool pcie_aer_state_log_num_valid(PCIEAERLog *s)
> > +{
> >      return s->log_num <= s->log_max;
> >  }
> >
> > +static bool pcie_aer_state_log_num_post_load(void *opaque, int version,
> > +                                             Error **errp)
> > +{
> > +    PCIEAERLog *s = container_of(opaque, PCIEAERLog, log_num);
> > +
> > +    if (!pcie_aer_state_log_num_valid(s)) {
> > +        error_setg(errp, "PCIe AER log num too big: log_num > log_max");
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static const VMStateDescription vmstate_pcie_aer_log_num = {
> > +    .name = "PCIE_AER_ERROR_LOG/NUM",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .post_load_errp = pcie_aer_state_log_num_post_load,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT16(v, tmp_u16),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  const VMStateDescription vmstate_pcie_aer_log = {
> >      .name = "PCIE_AER_ERROR_LOG",
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .fields = (const VMStateField[]) {
> > -        VMSTATE_UINT16(log_num, PCIEAERLog),
> > +        /*
> > +         * Only to use STRUCT for a post_load_errp().  New code should try
> > +         * to use something look better, e.g. subsections in order.
> > +         */

[1]

> > +        VMSTATE_STRUCT(log_num, PCIEAERLog, 1,
> > +                       vmstate_pcie_aer_log_num, uint16_t),
> >          VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
> > -        VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
> >          VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
> >                                vmstate_pcie_aer_err, PCIEAERErr),
> >          VMSTATE_END_OF_LIST()
> 
> This seems to me to be worse -- instead of a macro that clearly
> and fairly succinctly says "we're validating something here",

The macro itself isn't clear to me IMHO, as that's the only entry that
doesn't represent an entity of data stream... that's another reason why I
want to remove it.

> we now are using VMSTATE_STRUCT not because there's actually a
> struct in the migration data, but for its side effects in having
> a post_load function, and we have to create a dummy struct type
> as well. If we want to be able to have the validate check
> set an Error, I think I'd rather that we changed the API
> of the validate function to take an Error**.
> 
> I don't think "validate, and it happens that I need a custom
> function to do that" should be this much more complicated than
> "validate using one of the standard checks like
> VMSTATE_UINT16_EQUAL".

It's not a custom function, it's part of what post_load_errp() should do
really.  I am also not convinced we should have pre_save_errp() checking
these things either: if a device state corrupted, we shouldn't wait until
"start migration, transfer ALL ram, stop VM, collect data" and then raise
an error.  IMHO we should add the sanity check into device code and raise
the error asap when the registers may be touched, or some more generic
form.

That's why in my post (to be posted) I completely ignored pre_save_errp()
check.  I want to make it only for "do things we need to streamline the
data".  It really shouldn't do much else.  It's good it captured the arm
bug, but do you think we should add these checks into generic emulation
code rather than a VMSD?

About VMSTATE_STRUCT being ugly: I agree.  But I want to point out, that
will be the only one instance written like that, that's also why I created
this temp struct {uint16_t} only there, because it's not useful elsewhere.
The only thing I did it here is to maintain 100% same functionality.

I already mentioned in the comment in this patch above [1], that the clean
way could be using subsections, since they'll be saved and loaded in order,
the device can decide to load parameters in the 1st subsection (having a
post_load_errp guarding sanity checks), then the 2nd+ subsections using the
parameters loaded after checked.

So I would nack myself such VMSTATE_STRUCT usage in new code and suggest
what the comment say.  That'll be one shot just to remove the VALIDATE code
completely.

Thanks,

-- 
Peter Xu


