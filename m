Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE210C3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRHyC-0002Jp-Mv; Tue, 09 Jul 2024 17:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRHyA-00028b-PH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRHy5-0006CZ-OY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720558899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsxXBMowcezJEDRjoUPV7HFIcgDlWTQTz4rGgv9pKho=;
 b=WZSDDjRr/e0G3cikFPjglQWR7dv0wjSodvC4JaXAOYkP3iNnl3syuiPWmHVezPC3dJc9I5
 g8hbUqtgog4Kvd1skbE77c+JIXdRVmIXjvDFkiE7TJS2+bWdleXTSRaPcwQkgFsreEii8J
 i2sz9HXz6vqhJjxK2pXdYEy8tfE5pk4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-wostgBrOMe6z9U5-lM2oqQ-1; Tue, 09 Jul 2024 17:01:37 -0400
X-MC-Unique: wostgBrOMe6z9U5-lM2oqQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5c6702d6ef8so192486eaf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 14:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720558897; x=1721163697;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TsxXBMowcezJEDRjoUPV7HFIcgDlWTQTz4rGgv9pKho=;
 b=cIqaOd+NwhkQhJWNeODZcT/GY2ngohBHdMNmsU4hp1sGJr2uLdEKkNnxu/U6Aw4mXU
 7KLcXe4R+UYpwZl0fLIwcUlO8B+KhVVYa5FPAd52h12qcbnt9P8ZQ1UGE7ysAhof8fnT
 WAVFZbMLS6M7Et1gX52A91VV8E57dRYDLRdOBve9Rakc3Lp9os9bpXf36ZS78gs87SK6
 x223usO7HrAgnwhezk/Sw9G7SzPl1V7dxAbnPU2WwzPe/8Ii7/Vxb0JbiUeaC9OpWUNz
 WaRJYclmLBUhYZfZvQTu1KMl6MKbuONgo18k0+kxBdPey8T6u4mGiAEOcVX9yevf7KbF
 zNHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM4OM8/FpRySy/xIOokqbBNmvO3VjSkT+E2FeRU0kcUEjHraTYeoRqVLXCWZ9QLKLfM5Fl2zdzGon8MWb54AVnrUZK0BM=
X-Gm-Message-State: AOJu0YxP7kvzbghqcFAnIBiw+fSfO+ed0mHiFTWe9bZKaIWyDX2H4fhK
 E+3Fe5qMAkcu9PNio7ckxaCuyq+YLoD4vGo3voGNRwLpa9lf4Qs+6bzfcvGSvq4Ypa07NthHBZV
 4xdrVU7ONaXEw0FRhyOPNnIhMhYEkXk5fLfNuuNl7s53b9u5nhuJ0
X-Received: by 2002:a05:6359:4ca1:b0:1ac:2b8b:a185 with SMTP id
 e5c5f4694b2df-1ac2b8ba310mr161877555d.2.1720558896627; 
 Tue, 09 Jul 2024 14:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCk4wOyxzBGtML3uUOq7JYceLSDdFhVFjS11LYCqMGwVz1evKRb4yHN94+nbu9B79pcdXU4g==
X-Received: by 2002:a05:6359:4ca1:b0:1ac:2b8b:a185 with SMTP id
 e5c5f4694b2df-1ac2b8ba310mr161874255d.2.1720558896104; 
 Tue, 09 Jul 2024 14:01:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f19012068sm133098185a.31.2024.07.09.14.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 14:01:35 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:01:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, devel@lists.libvirt.org,
 Luc Michel <luc.michel@amd.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Message-ID: <Zo2lLLAwcZ8bBvO2@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cynmfggx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 09, 2024 at 05:38:54PM -0300, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > "General command" (GEN_CMD, CMD56) is described as:
> >
> >   GEN_CMD is the same as the single block read or write
> >   commands (CMD24 or CMD17). The difference is that [...]
> >   the data block is not a memory payload data but has a
> >   vendor specific format and meaning.
> >
> > Thus this block must not be stored overwriting data block
> > on underlying storage drive. Keep it in a dedicated
> > 'vendor_data[]' array.
> >
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Tested-by: Cédric Le Goater <clg@redhat.com>
> > ---
> > RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
> > to be the same size)?
> 
> Hi, sorry it took some time to get to this, I had just left for vacation
> when you first posted.

And I totally overlooked there's the email.. until you replied.  Welcome
back.

> 
> I think it's ok:
> 
> {
>   "field": "unused",
>   "version_id": 1,
>   "field_exists": false,
>   "size": 512
> },
> 
> vs.
> 
> {
>   "field": "vendor_data",
>   "version_id": 0,
>   "field_exists": false,
>   "num": 512,
>   "size": 1
> },
> 
> The unused field was introduced in 2016 so there's no chance of
> migrating a QEMU that old to/from 9.1.

What happens if an old qemu 9.0 sends rubbish here to a new QEMU, while the
new QEMU would consider it meaningful data?

-- 
Peter Xu


