Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50959C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpraA-00050z-CI; Thu, 28 Mar 2024 11:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpra4-000503-T9
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpra3-0004IS-DR
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711639333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iGQFWuFF8bsnCO88KZ4IuKA9T1NHdA4CNms0tKqUIM4=;
 b=EzkYxCIzoHUdz+ftHBWaI4uaMTKGrS6zS4d6dVlujd5uLvwlRqQ1tDXEbycvYSluyYv0uP
 XyAXTDALlXrUaGwLT4gJ+9E+l2ygLAc8Kn7h2bz8Ek9Wlf+yZuwbeh3NPGOKY3toQk0liK
 clnTp3NsTP4Brtq7j9BMMRdSfmWVUW8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-NpXdAbdvOBqtLgbEuuhdfw-1; Thu, 28 Mar 2024 11:22:11 -0400
X-MC-Unique: NpXdAbdvOBqtLgbEuuhdfw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78a4d4ab610so3325285a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711639331; x=1712244131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGQFWuFF8bsnCO88KZ4IuKA9T1NHdA4CNms0tKqUIM4=;
 b=A6jhAzUTxT2NfJWzK0OHL6piL4KEG4O1RQNhU/yso9c5H9N5cxt7Frv7OEgKoKzLRX
 EZbcGa8JlZd3quAUl0ey8+gLkyBofm9eCtOBUK+AFiI1g/WFfPbqyG3mh/hk+4zEo4xl
 AlE2SQh2XbuQhxH1/ZFJbyYB6lWaYZDjnOkOKMzAZx8RgEa5pftDWg0J33/SqYnbXaA9
 cayw6VqZeNnkb578irlNSfLHpZBRO19/uCe0Fh0I5iMajw6RAzC9Sxq82L628SrB/xI5
 m2FkavQ2tDMpXD6kDkeLHXR6leCTpKbaLInhSfFy0AiUFIHocEPYXazvy057CQQMHXDt
 sYYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1xRwl/kERLG26HKPES+BhSGGNckm7ZkVuUxEMrb1glsASzpnDa39nbD2Zot6GaxrJRdSQyQOilhT5PDMcDXFFCFoePD0=
X-Gm-Message-State: AOJu0Yxp9oLgWOZkGU9ZF5a5WU5Yn4Zd0HtrOuqLajmp6RUe/IkO9dFP
 vjz36kxDeUtSa4jmTfJlr/oVBoaFvdq229y0nSTHTYFuoXSsN0k+jhomIA9q3v6lAgr+WLu0GmH
 nOkH45NwsqwrDZUMHCIo3vQGDlyEV5OmiQpnR015mXwKg1pD0afXt
X-Received: by 2002:a05:620a:2901:b0:78b:c4cf:e0b4 with SMTP id
 m1-20020a05620a290100b0078bc4cfe0b4mr482644qkp.0.1711639331014; 
 Thu, 28 Mar 2024 08:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENIveWPOF37TKpBMmQWu9hpVT0OkrFZatoYL7kJqE6+EpjlVN6AzmkXtl5f9/sIfT71Ji65w==
X-Received: by 2002:a05:620a:2901:b0:78b:c4cf:e0b4 with SMTP id
 m1-20020a05620a290100b0078bc4cfe0b4mr482601qkp.0.1711639330498; 
 Thu, 28 Mar 2024 08:22:10 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 da35-20020a05620a362300b0078a35fc488bsm596282qkb.52.2024.03.28.08.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:22:10 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:22:08 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 0/7] Live Migration With IAA
Message-ID: <ZgWLIJ0U1c0WySio@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <ZgMwSO_eRIgXZ24L@x1n>
 <PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZgR3i5-jc3n2eQA_@x1n>
 <PH7PR11MB59411F5377A4E087D5FEA719A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59411F5377A4E087D5FEA719A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 03:02:30AM +0000, Liu, Yuan1 wrote:
> Yes, I will support software fallback to ensure CI testing and users can 
> still use qpl compression without IAA hardware.
> 
> Although the qpl software solution will have better performance than zlib, 
> I still don't think it has a greater advantage than zstd. I don't think there
> is a need to add a migration option to configure the qpl software or hardware path.
> So I will still only use QPL as an independent compression in the next version, and
> no other migration options are needed.

That should be fine.

> 
> I will also add a guide to qpl-compression.rst about IAA permission issues and how to
> determine whether the hardware path is available.

OK.

[...]

> > > Yes, I use iperf3 to check the bandwidth for one core, the bandwith is
> > 60Gbps.
> > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > [  5]   0.00-1.00   sec  7.00 GBytes  60.1 Gbits/sec    0   2.87 MBytes
> > > [  5]   1.00-2.00   sec  7.05 GBytes  60.6 Gbits/sec    0   2.87 Mbytes
> > >
> > > And in the live migration test, a multifd thread's CPU utilization is
> > almost 100%
> > 
> > This 60Gpbs per-channel is definitely impressive..
> > 
> > Have you tried migration without multifd on your system? Would that also
> > perform similarly v.s. 2 channels multifd?
> 
> Simple Test result below:
> VM Type: 16vCPU, 64G memory
> Workload in VM: fill 56G memory with Silesia data and vCPUs are idle
> Migration Configurations:
> 1. migrate_set_parameter max-bandwidth 100G
> 2. migrate_set_parameter downtime-limit 300
> 3. migrate_set_capability multifd on (multiFD test case)
> 4. migrate_set_parameter multifd-channels 2 (multiFD test case)
> 
>                   Totaltime (ms) Downtime (ms) Throughput (mbps) Pages-per-second
> without Multifd	23580	            307	         21221	       689588
> Multifd 2	       7657	            198	         65410	      2221176

Thanks for the test results.

So I am guessing the migration overheads besides pushing the socket is high
enough to make it drop drastically, even if in this case zero detection
shouldn't play a major role considering most of guest mem is pre-filled.

-- 
Peter Xu


