Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C882FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhayM-0006yF-MG; Tue, 05 Mar 2024 15:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rhayK-0006wL-ET
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rhayI-0002hX-TH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709668865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJmetmmHBBd7lc0llKA2E3eYTU5U6W9GNScdk7rhHC8=;
 b=QVWFLdjJOIpfeiEV6TUR3MeaM7EdDURjFn/ZJfxi7MKvitn/IpgrBg5zbiIUraBZcMhxj+
 LLjE9V9KLJJud5ghWGXGPVyMleBLwFrqudbJb2XPMjFVEZOQ8YXHO40giBUJOpWcxMT/h3
 G8KfAEgvhuk6WHp4Z6m35On+8ZTFgKs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-CMq0n3VeOaiRe_HPoBBgnA-1; Tue, 05 Mar 2024 15:01:03 -0500
X-MC-Unique: CMq0n3VeOaiRe_HPoBBgnA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e40126031so35628045e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 12:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709668862; x=1710273662;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJmetmmHBBd7lc0llKA2E3eYTU5U6W9GNScdk7rhHC8=;
 b=TzHeyDjXkhAtyAnAGJbeCJBN84DNnXZXPbDeQTXewjylZzXuUtPmvY2gP8t/rJlLhj
 fLpxiCl6cdstrU9RdisbRWOO1ESP1l4GMOM/yBbuEuhN3XHj7m1LC865C36VsUdv1UwU
 /ONMJL1cN5imlHGuQL0PC2DWO/rar7wF4rRQa7jtf+kl5ZNw9clYgArIcoOzseyOmM2L
 mjHqrM8Pkhu//zzPgwhpVzdjdu8KdiNoTY1ZAA05oVtUN7nXqi7Cxvmn4PxiAABZ1ot0
 Js+QGlPFHvdkJSFcA8TUsdmnyTF0It+IPEr8Ab2NS3AUYWdoEB4KvBKD6ck8wycaHyU/
 ywHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBiI61KEEJXBPCbMsRoA6dknz+DKQe50rwvqI6aGXI1+Xr79hpZqec2v2WqEw2Leq6RPfDj5+sJLiale4S0fdwdDh1FnY=
X-Gm-Message-State: AOJu0YzaifWBxNtSF44gGYPuIAtjL9qlPyiZHZbkhMGXISk3015+yd6K
 u2HWkP9CEDRApu6YyV+QPm3VQHaf2ccTPiUDjF7sgNSA5ijCgpWlwYwUlSSHAlmOjtdSDjdlMm9
 ubSviIGrqLsMEw886Wj7KTOqX1iTR0hZKOzeRIZYSNT+veVZ3imcI
X-Received: by 2002:a05:600c:1c89:b0:412:d149:254c with SMTP id
 k9-20020a05600c1c8900b00412d149254cmr7460390wms.17.1709668862227; 
 Tue, 05 Mar 2024 12:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuKoF9VDIs2HJoL9qc5gsaif4+qF/9QmM9CEZ8YBvrgEDVyIdA6rsqsocEksNWJxnxwLQ5rg==
X-Received: by 2002:a05:600c:1c89:b0:412:d149:254c with SMTP id
 k9-20020a05600c1c8900b00412d149254cmr7460370wms.17.1709668861642; 
 Tue, 05 Mar 2024 12:01:01 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:43b5:b64b:d91f:f9c7:9745])
 by smtp.gmail.com with ESMTPSA id
 je1-20020a05600c1f8100b00412f2136793sm442615wmb.44.2024.03.05.12.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 12:01:00 -0800 (PST)
Date: Tue, 5 Mar 2024 15:00:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 1/4] hw/i386/pc: Remove "rtc_state" link again
Message-ID: <20240305150043-mutt-send-email-mst@kernel.org>
References: <20240303185332.1408-1-shentey@gmail.com>
 <20240303185332.1408-2-shentey@gmail.com>
 <CAFEAcA9tzgAetYu8QcR+CgN1L_1ZcCS3mYHbD9oPe5py7Tw1iw@mail.gmail.com>
 <23F8A871-DE41-4B76-A78E-C3C517FF6319@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23F8A871-DE41-4B76-A78E-C3C517FF6319@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 05, 2024 at 07:54:40PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 5. März 2024 15:57:08 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
> >On Sun, 3 Mar 2024 at 18:55, Bernhard Beschow <shentey@gmail.com> wrote:
> >>
> >> Commit 99e1c1137b6f "hw/i386/pc: Populate RTC attribute directly" made linking
> >> the "rtc_state" property unnecessary and removed it. Commit 84e945aad2d0 "vl,
> >> pc: turn -no-fd-bootchk into a machine property" accidently reintroduced the
> >> link. Remove it again since it is not needed.
> >>
> >> Fixes: 84e945aad2d0 "vl, pc: turn -no-fd-bootchk into a machine property"
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >
> >Ah, I did wonder when I was working with this code whether that
> >rtc_state link was really necessary.
> >
> >We could now remove the rtc argument from the pc_cmos_init()
> >function, because we can guarantee that it's in x86ms->rtc,
> >which the function already has access to from its pcms argument.
> 
> This series goes one step further and inlines this function. It would be a nice to get some feedback before the freeze.
> 
> Best regards,
> Bernhard

I like it, I tagged it for merge.

> >
> >thanks
> >-- PMM


