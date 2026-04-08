Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEFF10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXme-0002BV-JG; Wed, 08 Apr 2026 14:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAXmR-0001oJ-OU
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAXmP-0005Uj-4T
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775673452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzswQOhBSXkFDGzYky6s8lS24mIvEW5uQtLSE/oAkgY=;
 b=Nz4GM+UCs4KaRPWIW/0bQVnT2fBao5amdj0MyduqUiveaWz2wGui/sD4TRfZz8XqJ2/QZx
 zz6u76bzdTkHXo6uEPVQn/e5edsaaRJNrBvIPKMSfVcpVUcLMJPChElKjmtBeVY8ikJOZf
 lZRsjPFyEApeRrN98RAcR+F8vr2YQpg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-h7JhRfgyO_iJAXCbrbrYbQ-1; Wed, 08 Apr 2026 14:37:31 -0400
X-MC-Unique: h7JhRfgyO_iJAXCbrbrYbQ-1
X-Mimecast-MFC-AGG-ID: h7JhRfgyO_iJAXCbrbrYbQ_1775673449
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso2391711cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775673449; x=1776278249; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KzswQOhBSXkFDGzYky6s8lS24mIvEW5uQtLSE/oAkgY=;
 b=pERHC8ZPRV+OJgJYfgQgoTvxEW4CWMLhXTQ6jTScpNTwIdwIgVT5AQ+hqDPJAOHBBc
 v8bOWoxiQ91IOkhN9xUFEn+AaFWkLmSMsBDywM4wzAVI+6jUJ/s9JpQc0sk+f7WXCrrl
 8oO3Cs66NfubomeBXXVEYWNBeh55cbZwWQoDkcsdO/ySBMMLcsAgdJg3d0fZaOcexPUu
 Pfy8PcIHMY/5dk55xtVV1401yxmGzOdPJT7cp2b0uo8jTi64L1oWT8yzGaX65fdsdKW2
 O1PFHvk+M7QJvmP/c2MSJd5q6XoZK/i7JHTw89j9e9uHfgoFVl5Zc14Fv5gk/dLa5HX6
 C1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775673449; x=1776278249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzswQOhBSXkFDGzYky6s8lS24mIvEW5uQtLSE/oAkgY=;
 b=QbCPTHREwKZCdarDn7VKi2XfDVlJCO1Ezro4gKewjpclgeSPOCVyVr3uepEzTEDUzT
 96JS6AJz3WZ57FBm9HFRNmWQwjQu9QvKsSHbgRiN8gJ2zqC+dQHfbpk88+rnXV6pvH37
 1m8pIjNmsJfNtmkpogGE33q9z9KiLIqjTeJlI4eIusYSPY/p+POlDw4oJcxQ7zTbF5Uq
 8nTmYzxhZSe4og/wU2aPN1dVj8587g2KKimnOGWov1y5PE2pb6oBDG/IyefK7ZyCahdu
 1PI+JpCcQCwJu/RBGTYat8MQbYxg/A4aRxwiydlYB2iF0nore3v1n7HULATowx+nZJDF
 63QA==
X-Gm-Message-State: AOJu0Yx0WuxYf5y7F+DURrGY0zmxCilw2WZbUN/jzGtNGBYV4ZOzfiAF
 e9yZ11cwDlb0P4n+3ERw9Ybq3YnhYN5ppkRc6l0WRANbcXYEd2nOaCDT7BxaO+a1iZ8tgJgk9fF
 IKPeUIiheMHUlVbQX3YuULx0/4YPo834ZlwS/KpkOgGi6+wYLQ5mlVVk/smNj+OS63HVNrRXq9d
 RLbViJ+qasaoX/rBd/m14wpneCVVPVKzsaD2gHQg==
X-Gm-Gg: AeBDieuQXcGQwkecGpPCHOCLmt2hSJhuVIvGcLUOF4GKuIJSh2S4Plqq2lQJpOs0YGk
 ZuJsS2EGsb2OONM+9hehRtsdXtUXgR3AZVcLjqqTHLX7ITrNhwJKJLkR70b3hCztffLfaP5pZTq
 ySpBBj6OLvyn24gjL9Q8mMI1ROwRTyGp6cdvIArWrEKPQteaZlivLlJJj/m3fGy6OwPO9U/9G9A
 uqZD8YznySP4GxSGMFEi4+EoH3Uxs6j1ypmwBNHG0hvYfqom7lbPJVYr738obMSea2IvJaTsHWT
 DcOSMLSIyd11EZs679A2G0yVzRU791kze/gZGtHUOjyAbce8iew5qmHC8NCF7omRu7m1I3Nnrbk
 87EJvkJ+nHbBNRV/e2tGN+ZikX9R55FM5bNyWK06yQUx05j0=
X-Received: by 2002:a05:622a:4c84:b0:50d:9c1f:bbe3 with SMTP id
 d75a77b69052e-50d9c1fbfdcmr170766921cf.16.1775673448945; 
 Wed, 08 Apr 2026 11:37:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4c84:b0:50d:9c1f:bbe3 with SMTP id
 d75a77b69052e-50d9c1fbfdcmr170766211cf.16.1775673448331; 
 Wed, 08 Apr 2026 11:37:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b1a3fc7sm214148651cf.5.2026.04.08.11.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 11:37:27 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:37:25 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 00/14] migration/vfio: Fix a few issues on API misuse or
 statistic reports
Message-ID: <adagZR0_y6-1sLyS@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On Wed, Apr 08, 2026 at 12:55:44PM -0400, Peter Xu wrote:
> Tests
> =====

Re-inserting all the commands I used for testing below; they got ignored
when posting the cover letter as comments.

> 
> Tested this series with an assigned VFIO device GRID RTX6000-2B, FB memory
> 2GB.
> 
> The test covers both correct reporting of system-wise remaining data (which
> used to only cover RAM), and the expected downtime.  I verified that using
> the expected downtime I can converge a VFIO migration immediately according
> to the value reported. Test process as below:
> 
> Start the VM and kick off migration until it spins at the end, not
> converging with default 300ms downtime.  It's common for a 2GB vGPU device
> due to both huge stopsize reported and dramally small mbps reported.
> 
> As a start, update avail-switchover (I chose 1GB over a real 10Gbps port):

  # virsh qemu-monitor-command $vm --hmp "migrate_set_parameter avail-switchover-bandwidth 1G"

> This will stablize bandwidth.
> 
> Libvirt's domjobinfo won't be able to see the real remaining data because
> libvirt still doesn't support the new "remaining" field, however we can
> still see expected_downtime will be reported correctly now (instead of
> reporting zero, before this patch applied):

  # virsh domjobinfo $vm | grep -E "Expected|remaining"

> Data remaining:   0.000 B
> Memory remaining: 0.000 B
> Expected downtime: 1910         ms
> 
> If we peek through QEMU monitor, we'll see with the change the system-wise
> remaining data to be 1.9GB (even if RAM keeps reporting 0), and expected
> downtime keeps the same as what domjobinfo reports as 1.9 seconds:

  # virsh qemu-monitor-command $vm --hmp "info migrate"

> Status:                 active
> Time (ms):              total=336919, setup=10, exp_down=1910
> Remaining (bytes):      1.91 GiB
> RAM info:
>   Throughput (Mbps):    460.09
>   Sizes:                pagesize=4 KiB, total=32 GiB
>   Transfers:            transferred=12.7 GiB, remain=0 B
>     Channels:           precopy=12.7 GiB, multifd=0 B, postcopy=0 B, vfio=0 B
>     Page Types:         normal=3306906, zero=7745576
>   Page Rates (pps):     transfer=14010, dirty=8039
>   Others:               dirty_syncs=247045
> 
> It means 1.91 seconds are required as lowest downtime per math.
> 
> We can try to set something lower than that, migration will not converge:

  # virsh qemu-monitor-command $vm --hmp "migrate_set_parameter downtime-limit 1000"
  ...
  # virsh qemu-monitor-command $vm --hmp "migrate_set_parameter downtime-limit 1500"
  ...

> Then if we update downtime_limit to be slightly larger than expected downtime:

  # virsh qemu-monitor-command $vm --hmp "migrate_set_parameter downtime-limit 2000"

> Migration will complete almost immediately.

-- 
Peter Xu


