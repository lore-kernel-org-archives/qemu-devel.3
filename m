Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA776C5AD4E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtV9m-0003AC-0s; Fri, 20 Feb 2026 13:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtV9k-00039u-EK
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtV9f-0003g9-Qk
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771611786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/LttNL2Bzddd6snzX9FoV/P7CPQ8jBQrN2ar5SQSrW8=;
 b=crO4vgKmMLDo/9/81a5H8/Xp7bYtYN8hEgqVSJ/nTRY5JJ1DUlt6QVj4wku2v/dgCCESa+
 zHibYzx0VgAiNmH6waJrpj/pu2ZHAgTGPYiB08rIslxxXL5Wc96CmUejxsbnQL3Gk+9IV8
 7egfN/weEVbITxsXuPoEL9zvaL0bNUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-a_o6Rl04Ox219hxuIVCUGA-1; Fri, 20 Feb 2026 13:23:05 -0500
X-MC-Unique: a_o6Rl04Ox219hxuIVCUGA-1
X-Mimecast-MFC-AGG-ID: a_o6Rl04Ox219hxuIVCUGA_1771611784
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso25395985e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771611784; x=1772216584; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/LttNL2Bzddd6snzX9FoV/P7CPQ8jBQrN2ar5SQSrW8=;
 b=ZKXuj2Nyq1TISU44EDTNrr6oyG0EckGjKbwJdGa/13blKI1XUJzdBzJ8UJoaOEU+L+
 1/hZxdY49uRS3xc+6YFpqhafbFNxwut9bLfU6BwW1bkeZOfepy33Hf/roKjTW3rlpwbg
 muqWj6VL+wB97xIV3TEeI8cu/eColHQC8Zlvy+av2POaUzLWS8ayGPUoUnjbSHmTAwIn
 fg8oAiAV+ri9I/GAzObBwhQubf66hasRVEBX8FzIUNo7TskPyaUAooRZjk9ywcIRroAh
 eAHBY4aYUC+Hli6lOxgWJGpVmcyWim+mh+DsbGhu5QE5n5XmY+zSS+eh8TYhUzZ08q/E
 XsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771611784; x=1772216584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LttNL2Bzddd6snzX9FoV/P7CPQ8jBQrN2ar5SQSrW8=;
 b=K5SlsW38YzDeV0yxUjFZRDJScb7ZNBSgx1s4k5Rt5H5505jF9nuBUCs6ka/RB4hU2m
 8QRGqtAepYMt6ZoLSUr+nGFF/F229cBIx7kcN/UpQH2sNRJs/ElU0eAF1/oJyyN/Jvu/
 J6MaSCkA9vZqSYDx4azOLmIBMy2Kcwk+jlHLOU+EmC3+lVM7no9Slp28LHPqBNWR01Fm
 1MFBtklw2Mc3Rz3mR2oKkWnxCD8J0s2Sks1kgUyN0J0Aq0W22K+2SluZCizqmqtIXgR0
 KWhR2I6gM2FTAf4fITZZ2SFBPyMllv3vui+glU1T4LXUQM59MVo3J82FTdl6pofmI2EM
 f3Sw==
X-Gm-Message-State: AOJu0YxHJLc2WOwtpqfIclarmHUriismFTgp+Cn7cfX7tBhhjotmaTGA
 Bv234+nGJEQlbIwIaWwEaKhDLQoL0EhhoZxCMHsQKPefhkTfaqXjFcvI0kJ0EagoXLSwWzPMzqz
 PDOrhXGgngmgMcprNegh6tzREDAd+PUHdgMjrmnp/4N28mjNw5KwpVRR2
X-Gm-Gg: AZuq6aKp+amPp4jul6ZLtROyQWqDlRF1hjtXGQr0UFs73AN3f1bCzz0Nc0fZyD9ke7L
 S/NIrXtlGqFDS62Xj1cNaZ4X7PAPvEQzu1bpckT3qIdmkRT98C+/zdUP7DyEUwln5ShKuhdz6eQ
 jmiq48efWzOEw/2ge7CP6arM0qfazv5i2433Pf2cBA4y62+a0ciWmBHwtSwEv7IX/2I8IONkfB6
 Te4/83V/9jfysOD0m+DazJNp/DeKBC50gvZRBI6FtpejuM6vcUZodpHt5Ac+F0qShhbMKoqazXv
 SIRKJzX7ZpKhQmBykQRSFN38xTx3qjbJiOdjUHYYJ180JiG5/cztybd4Ix6ZB+XtCR2dSr2ymgQ
 dPOSHbzQGw7q/0W6V1ZRfx69bTdoDT28AAMBj4WNrtGqICA==
X-Received: by 2002:a05:600c:8b01:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-483a95fb247mr7138405e9.8.1771611783982; 
 Fri, 20 Feb 2026 10:23:03 -0800 (PST)
X-Received: by 2002:a05:600c:8b01:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-483a95fb247mr7137935e9.8.1771611783505; 
 Fri, 20 Feb 2026 10:23:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439567aad3csm24228623f8f.36.2026.02.20.10.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:23:03 -0800 (PST)
Date: Fri, 20 Feb 2026 13:23:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v7 1/7] hw/pcie: Support enabling flit mode
Message-ID: <20260220132238-mutt-send-email-mst@kernel.org>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
 <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
 <20260220131854-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220131854-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Feb 20, 2026 at 01:21:12PM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 05:09:29PM +0000, Jonathan Cameron wrote:
> 
> ...
> 
> > index 85694707e2e4..3c7ecd8c48bc 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -405,7 +405,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> >          .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> >          .ctrl                    = 0x02, /* IO always enabled */
> > -        .status                  = 0x26, /* same as capabilities */
> > +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* lack of 68B */
> 
> 
> would be clearer as:
> 
> .status                  = 0x6 /* IO, Mem, non-MLD */ |
>                             ct3d->flitmode ? 0x0 : 0x20 /* 68B */

(ct3d->flitmode ? 0x0 : 0x20) naturally due to precedence.

> 
> 
> I picked this patch up, comment fixup can be a patch on top.
> 
> 
> -- 
> MST


