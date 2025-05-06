Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89811C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 10:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCFcQ-0006gk-Vh; Tue, 06 May 2025 06:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCFcM-0006cO-RV
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCFcG-0003j8-Kx
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746527612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHMsoHwcRmM8GyjVZQfP1pBWTwp0nvQsTIV6VbWvmuc=;
 b=bcCbhjSOI9UU8zCGQNJcOPMoc0woUO1M00JeHCdZjUyJ+YBPhcvB097qdLJru7zhug/3uJ
 It4/bW/l5/wivtil3nu8iMOJkSnr+62CtMxPx1+FeRZWsx3v8RlP5pUVfufbK+oKHwRHcO
 caTXOehVLiRjb4mkA90H71o1sbOLoig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-pY71UXW_NP6heg18-bgjMQ-1; Tue, 06 May 2025 06:33:31 -0400
X-MC-Unique: pY71UXW_NP6heg18-bgjMQ-1
X-Mimecast-MFC-AGG-ID: pY71UXW_NP6heg18-bgjMQ_1746527610
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so33298305e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 03:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746527610; x=1747132410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHMsoHwcRmM8GyjVZQfP1pBWTwp0nvQsTIV6VbWvmuc=;
 b=n720BnVCSo5agQGtwTCwqSz/m93n2yvAgmQFkTCOxmdMpvXZpxsoo8iZYeIbJgWTXt
 LyuyHdGYDMovR/yHLodfYOf7JcIB+5RaIIIoBv6M6PFNmDMQETpBPqo+iI1ZGJQdUsbI
 uvJysQvp/t+WgqFRAuCtwccDUFahITdnPYtWaX9cFmjX+tcoIXLSEyCtVXkM9XJ3lhUS
 WX5gAgFryXoujys1F10ir7EWoxWVo+KMjtM4r2B6amhYFm686r8zxzykrhFv9o9NudR0
 i4qiqlNyCH0LRSAjM7FyusSSpDfecyyC9Qvg+8AThVulMTiz2HXu6nWtblwnZNFwtqLy
 u4Fw==
X-Gm-Message-State: AOJu0YyyizqMjs6Z57ItA155Xx1PSvpRk11ZLCDQToo6Vc2UvXn6s7oo
 t1venOPArtwsDAG0KzSxkDBfSRMZ50uXFuUIyPcj38D5RPSdd+ZBOMzXtebvKhK03j1ZTx1qBkF
 Zi6TWs9pCvtcXeVXfi4tWOYW9pJQEcKuoq5wQuyp0Tohmahre0gGHOc5cTRJVzFBgJ02kCNdew3
 nyfg69E1VXPuZjKgz36Iabku4ToHc=
X-Gm-Gg: ASbGnctq0KIPQ2alyEmxu5SpGr8kr75UNURvw77wixFTrrSP9D0ymZIEv41AiLDpX13
 ruEDyjq8Z2i2t8UTpQbQkhYAJoz9h9ijsQmo9Aw1LXx31RfFQLLJwWFHRtvYWsr1xat7t
X-Received: by 2002:a05:600c:5105:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-441d100a80emr20486465e9.26.1746527610301; 
 Tue, 06 May 2025 03:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNHhif8jfiVQ97z+BXAWrm/CsBCuRtiWnMWXYZ+vontZg7flbaekF43yuJIawFQ6RcncEFZQ7f6xv1OU+FVVU=
X-Received: by 2002:a05:600c:5105:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-441d100a80emr20486255e9.26.1746527609952; Tue, 06 May 2025
 03:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <20250505100854.73936-4-pbonzini@redhat.com>
 <aBncq8KFTgzcT3jv@intel.com>
In-Reply-To: <aBncq8KFTgzcT3jv@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 May 2025 12:33:17 +0200
X-Gm-Features: ATxdqUFKc370bpFxdrNgK4Lj-P5sRATe4xaagwdtzVix-xsXOtI0wcrxeuK1TBo
Message-ID: <CABgObfYAw92Fy8PUPEf5=vJG2N_O3-pt754QoFLLgfQu9JB-0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: vmstate: convert to use builder pattern
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 6, 2025 at 11:35=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> > +unsafe extern "C" fn vmstate_pre_load_cb<
> > +    T,
> > +    F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>,
> > +>(
> > +    opaque: *mut c_void,
> > +) -> c_int {
> > +    // SAFETY: assumes vmstate_struct! is used correctly
> > +    let result =3D F::call((unsafe { &*(opaque.cast::<T>()) },));
> > +    into_neg_errno(result)
>
> Thanks! Now I see why you used io::ErrorKind.
>
> > +}
>
> ...
>
> > +    #[must_use]
> > +    pub const fn pre_load<F: for<'a> FnCall<(&'a T,), Result<(), impl =
Into<Errno>>>>(
> > +        mut self,
> > +        _f: &F,
> > +    ) -> Self {
>
> Do we need to assert F is not ()?
>
> const { assert!(F::IS_SOME) };

A NULL callback (i.e. ".pre_load(())") is a bit weird but acceptable.
So the assertion if not needed, but indeed there should be an "if"
that stores "ptr::null()" instead of vmstate_pre_load_cb::<F>.

Paolo


