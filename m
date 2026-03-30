Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4811061B13
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7FC9-0007xf-91; Mon, 30 Mar 2026 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7FC6-0007x4-UK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7FC2-0006Kq-Vi
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774887019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpggTpI5iKmAiW58dVxoud1WfIIukmoiW2AJQ+bOEzg=;
 b=EWAkF10IJrpwO5bD7rnRhgUPD5CfGr2Um2YOoABm8oBVo+UXfBEYz20DzAU7pBi8zDUzuo
 zQ9koR7evdJMClY7wg7Y8qppdIB8JpRGYIBdQt9DYVZvML6sWroCAba5/cepF4lZxVAFBo
 KGhvyoUjcRgARM2jUwqAr5FpNX2lFFM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-YmGkXgSzNc6HjAgjh9H_8w-1; Mon, 30 Mar 2026 12:10:17 -0400
X-MC-Unique: YmGkXgSzNc6HjAgjh9H_8w-1
X-Mimecast-MFC-AGG-ID: YmGkXgSzNc6HjAgjh9H_8w_1774887017
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd77bc8186so1766173485a.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774887017; x=1775491817; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xpggTpI5iKmAiW58dVxoud1WfIIukmoiW2AJQ+bOEzg=;
 b=WC3bkrAL5vBdU5Ry9bZjUT3QNYju8GYRjTsP/LutWJzUpn4grOjibx8MaWe3VdR8s8
 55U45SsQoe2hOdXTqg6hZ6LMtr6C5Hqe1ndfF1zUE+csPIRqoNaSBJ8OVayCrSLgSc3L
 wxN5h/gzOpc2UgYbNqBRaf7OAecX8qsAaYGXIHPLxuGeMs2VGb5ue0B5Rh8UyDjzO2uy
 6UVja3qEsSgZeJdJAFQpO/CYgNctxGIpILZDl/S2zsBqy4LiD+dHTRRIECIKyT3KS/MN
 7zEaR+XoA2WIwQeHUcHqJpxiJrEwJUwcYTP4Xqif75Nc06v4QScqR6XDzkSMs/a3KlV+
 eNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774887017; x=1775491817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpggTpI5iKmAiW58dVxoud1WfIIukmoiW2AJQ+bOEzg=;
 b=tG3PPSym3Alts+QpncBMQuF5pzBBBLDCm7azIeR2GPTdFDt3TFx6o5Dmm3NFFrN+Kt
 UTftBmb/TiGYDy0a+Xn6pvR/mNtyrXG/isFd1LjwWET6B0pMRFoF7Lj14LKq/PjOq8IQ
 BHaPkllMbZ5gXCeR+wBJKF/2oZJbE4MFtBBATLvPoEqmeJVl8xj62NWeq2fP9giyjwNy
 VZ8c7ZWdFoCft9HGE317mSFRbFXfU4gWyuy9WkEN6YgYuUHmepST3CNCVTpspXt3qEU5
 GS9dNwzj6OXBgX1NPdse3413I0d+Z9NOpYfpU1nmM1d0gPjkwJiiHpSV9yfk6rbmXjZM
 iLSg==
X-Gm-Message-State: AOJu0Yy58mWCvIk3h+URxbezUFn/YeI5vvijKF87XWPIBiPdPK9y31PN
 OZFZab/ZntZ9FRjp+L4qbMtKjnwlmpO0I7Q3Fa8pK19u0EJlKZrV3iYbKykTIpat8sAhLF7q7Tb
 LXSZhWKBE26eSi3aAVsGL3zOPV6RQbR6ucdUJws2hz2e4QQeR6vDMXdVB
X-Gm-Gg: ATEYQzz+AMR0HKAEeBsTwR1sz5wEuikAMGcjFjPh1/LFnCzXm1GhDz/W6KIO/hGkMeK
 l/OjC8hkOKBbeMhZ2MtyjrCh1QT69QDjRnXNFxMcu+oqWEcsnz3pQZs0gXsoj9ri/srYQvME6io
 rrqP80ANvNtVxXODc2GVwu0deHgg/ZJ51zsBPCSw1vvHZcD1XHThx9LL+7Foy/J3ROJSCUzFR+r
 78ypDm9e8OQaeIBa2tcsEPNaDbHwPeQE/Vv7ES+WX8WsOsTG3J/+3w/EZ3krdsQ0WZxUgDLfRcD
 75bsAMW9bZsqD011H58zON4C4AXNNiQ4CJ416Hpl5iiFza07Hf5AVSv4zHGdaEAam6MBD1HTtPW
 tTdPBbC2PZh8+Ww==
X-Received: by 2002:a05:620a:17a4:b0:8ca:105a:298f with SMTP id
 af79cd13be357-8d01c7fc3b5mr1844385585a.68.1774887016967; 
 Mon, 30 Mar 2026 09:10:16 -0700 (PDT)
X-Received: by 2002:a05:620a:17a4:b0:8ca:105a:298f with SMTP id
 af79cd13be357-8d01c7fc3b5mr1844375085a.68.1774887016229; 
 Mon, 30 Mar 2026 09:10:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d02e72666fsm539538185a.12.2026.03.30.09.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 09:10:15 -0700 (PDT)
Date: Mon, 30 Mar 2026 12:10:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 eblake@redhat.com, armbru@redhat.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, PengJu.Zhou@amd.com, Qing.Ma@amd.com
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <acqgZShXRkqzBU1C@x1.local>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327065006.2567463-1-guoqing.zhang@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Samuel,

On Fri, Mar 27, 2026 at 02:50:06PM +0800, Samuel Zhang wrote:
> The default 1MB RDMA chunk size causes slow live migration because
> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
> 
> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> faster migration.
> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
> 
> Performance with RDMA live migration of 8GB RAM VM:
> 
> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> |-----------------------|----------|-------------------|
> | 1M (default)          | 37.915   |  1,007            |

This is the default. It surprised me a bit knowing it can only reach 1GB/s
throughput with the current code base.  Do you know why?  I thought RDMA
should be much faster than this on throughput with whatever hardware setup.

> | 32M                   | 17.880   |  2,260            |
> | 1024M                 |  4.368   | 17,529            |
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

One thing to mention is RDMA migration is in odd-fixes stage, actually it
doesn't have a real maintainer so it is kind of "orphaned".  In this case,
I actually won't suggest we add any new knobs for performance reasons.

Do you have a strong reason to propose this patch to land upstream?  Is it
used in production systems and it solves some real problems for you?

I also wonder what Zhijian would say on this.

Thanks,

-- 
Peter Xu


