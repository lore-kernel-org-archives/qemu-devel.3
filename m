Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE5E81BDE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpU4X-0002eQ-K0; Mon, 09 Feb 2026 11:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpU4V-0002e2-IO
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpU4T-00034T-0h
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770654307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RZV/8B5PBNcqWJMXeyKMPCFmPb5pzeuKPwRo8B4BG4=;
 b=aLOXaopHu6Jab+5qru5cAT0lv8cV5HJRQ0yJ/5AvrHRK4cPt0ENLoxvwQJ4xxl/meWArqF
 q2RrZCgK8TTUyg04a+gXeOrmiea+6fkJTZkBfyLPOndElN9gNtFYkD7tN7+bP/JxMiuS3n
 HnvWfjcw5q+I6i7AgMPJvdOc8Yp+rks=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-i-CmzN2ZOS-QGc2arXScyg-1; Mon, 09 Feb 2026 11:25:05 -0500
X-MC-Unique: i-CmzN2ZOS-QGc2arXScyg-1
X-Mimecast-MFC-AGG-ID: i-CmzN2ZOS-QGc2arXScyg_1770654305
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6b315185aso1513730585a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770654305; x=1771259105; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9RZV/8B5PBNcqWJMXeyKMPCFmPb5pzeuKPwRo8B4BG4=;
 b=nLEBAFBs2rvDqLkRJOVISi3K+FrpRgx0DseiTSeBUFWxO8bwg907DsQQLq2TZCYAy5
 buEFZMvxG1Q5fpMG4rYJDLJjTT2pVexTU504jCDqm/ImmH7en0r0AlfZ7POXHRQugU6S
 7bMagR4YXx/R4PGEfxs64hi0zn+nsJC0bE172sk1B7SMp6lIo3RRf7UJnDnnHR7yygkh
 i+KpmgoUbmfcLreKA5xvGT7/L87viiznvIJXKpVfh9OqKAxih8FLDGmBjHJA09GYeDPz
 3X3MnrvYzkZ4Q69Ke1pSRxkvliMB6BnAdq/NhiY8BzVIE8rnlD88M9z59RrygCljAl3U
 ruHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770654305; x=1771259105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RZV/8B5PBNcqWJMXeyKMPCFmPb5pzeuKPwRo8B4BG4=;
 b=f/mn1lWnvamsUnivV7jpIRR4fmSLas9NLMvoDyhEsmgpeqLK5a4U18M/Z7TZI4fFoj
 5N0YU6TwChvO7QCA6KMQvWcUCNhAaO/mgkP0v0o8LrSbyvT/CeTKGrxGXjXXly5HtM65
 LVQ8UgJgG/fp4dtqLvRlR3DE3dKEcRMDpr8QgHqJK7ZkOj/eDIpzFaR/pQKHX/rbcdNF
 3scSIKt7CRZ6KK4/9/27WahZP1htw6aRfjy2L4SdZpIs8s5j1/KQYNC9aXbueChYghiu
 X6reE82mhcTZJ+8dpeIkEe+VsdedvxLT/h3+6P4LxL98puJj6j5B7tsmpjrv4/UPSvjP
 axJw==
X-Gm-Message-State: AOJu0Yw5lveaz0gZEdSLJzUQTvCu+lODGo4kikRqs2NXrFPFkkvGLUXS
 hXtKqaw2eGG/5uNhwfqJ4JAzKvbHvoDGp3/NBmqROt0Csbn3sFvLu9l5GVbF6BZ0wuZURkhl4xG
 4ZaVWMdtuPWp4e1ZrtbZ6XJ1rRkUg2eyzTbXDYbVBHsidl9NAdk24p61f
X-Gm-Gg: AZuq6aIv2skgA+KMMdnhKtP5aZyM1zmVCqLPvMN1eOELgA/qF3Z+kcLJcBF9hBgpHeR
 vqW5WDEkYoDGK6PvZm62uCa9rxWxr7S95pl6UhQGsvmy6faudfCfnjz79b0CXQEiLCIPtdjhyXy
 ESYEcl0CiJxm7ldyiZFsIsLVcvSPeGDypua3Ejoqm2zT0HraI7bFEkwL5Xa383ZkYKMVn4aOXI1
 Ks/EHnC3HucYk8xh63I7+r+mAOuEbo6YFkvDG9Zh+j5OvRETCJ3VOcPHr7lw2fVSBZOQL627bYW
 YWhScufu0G3Zwc/xlKx4z0da9ccARJgbzbeAW7vkztG3ljsc3U18/SQ9u3+K9mo7LPmPEQUwDbs
 AWx4=
X-Received: by 2002:a05:620a:3948:b0:8ca:2a05:6d00 with SMTP id
 af79cd13be357-8caef7e1c2amr1713456785a.32.1770654305299; 
 Mon, 09 Feb 2026 08:25:05 -0800 (PST)
X-Received: by 2002:a05:620a:3948:b0:8ca:2a05:6d00 with SMTP id
 af79cd13be357-8caef7e1c2amr1713452385a.32.1770654304889; 
 Mon, 09 Feb 2026 08:25:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9fdfa05sm835267185a.46.2026.02.09.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:25:04 -0800 (PST)
Date: Mon, 9 Feb 2026 11:25:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v5 09/16] multifd: Add COLO support
Message-ID: <aYoKXyBVN1UTIWNP@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-9-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-9-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 03, 2026 at 11:15:15AM +0100, Lukas Straub wrote:
> Like in the normal ram_load() path, put the received pages into the
> colo cache and mark the pages in the bitmap so that they will be
> flushed to the guest later.
> 
> Multifd with COLO is useful to reduce the VM pause time during checkpointing
> for latency sensitive workloads. In such workloads the worst-case latency
> is especially important.
> 
> Also, this is already worth it for the precopy phase as it helps with
> converging. Moreover, multifd migration is the preferred way to do migration
> nowadays and this allows to use multifd compression with COLO.
> 
> Benchmark:
> Cluster nodes
>  - Intel Xenon E5-2630 v3
>  - 48Gb RAM
>  - 10G Ethernet
> Guest
>  - Windows Server 2016
>  - 6Gb RAM
>  - 4 cores
> Workload
>  - Upload a file to the guest with SMB to simulate moderate
>    memory dirtying
>  - Measure the memory transfer time portion of each checkpoint
>  - 600ms COLO checkpoint interval
> 
> Results
> Plain
>  idle mean: 4.50ms 99per: 10.33ms
>  load mean: 24.30ms 99per: 78.05ms
> Multifd-4
>  idle mean: 6.48ms 99per: 10.41ms
>  load mean: 14.12ms 99per: 31.27ms
> 
> Evaluation
> While multifd has slightly higher latency when the guest idles, it is
> 10ms faster under load and more importantly it's worst case latency is
> less than 1/2 of plain under load as can be seen in the 99. Percentile.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


