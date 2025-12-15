Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9189FD5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBP7-0007Rn-Ul; Mon, 15 Dec 2025 11:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVBOv-0007PZ-FC
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVBOt-0008Fx-9V
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765815978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WN8t2QwDvS6NKYGoL2sxfFykDhpA5BocAQ8aXzCz0OQ=;
 b=GyF/bBl/czMQTQdinJMg9bORJja3bEMoeaudJHIAcSAVAKLK6OQZRBXhNAtODpVtej7Mms
 Y5+S7Jl+XgqtFMyLMsrFooyIMHVt2e+2HUzdPKclFo4/z2EdwKFUFlFajkWvdY77FAubJN
 KdXUyZL/zN9iJ55QaUFLIDc0HCj82gc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-cTPcJZ52P9a_7Evr2vJvvg-1; Mon, 15 Dec 2025 11:26:16 -0500
X-MC-Unique: cTPcJZ52P9a_7Evr2vJvvg-1
X-Mimecast-MFC-AGG-ID: cTPcJZ52P9a_7Evr2vJvvg_1765815976
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2d8b7ea5so21601426d6.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765815976; x=1766420776; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WN8t2QwDvS6NKYGoL2sxfFykDhpA5BocAQ8aXzCz0OQ=;
 b=sEZJxG48fgk2KCtOOOcBPqKGURQhFVRCT0hKw7nk6ixYlnWDg9cfvqzLi3aperkHRQ
 fXYRiEdQNKC2Dxpiyo3XGHOAxHOIGE1cRexuYTa74aOUS+lCIoDHrkqB8N6PvrR8HdVP
 vTW+wteGtcf0VseZOQBj+HCxY+yWzA6303sBeIsyALV8J7RM0yAdfZxjEMwvF7DkRNkR
 VAqwBSvQSCA7wtKnjfmlIqY7evGCTMPp8fp4aGlIBOtQ97rtGr7YGW6WnfM0R4JsvUfr
 Ii4aYmpL6jHsZkt13YZFqn05iJa8QcgeXkU186BE6f62rahJqw1pyKaI36+Zl0fYXkVb
 PEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765815976; x=1766420776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WN8t2QwDvS6NKYGoL2sxfFykDhpA5BocAQ8aXzCz0OQ=;
 b=ML/LdtSS8DmZnlxm7r2t+rnQg2hPqYDu01iagOb0wPYa1bWrp8UHIJEsYixRX+hrLC
 c1+5ExDUVj/0/KvGI0uef5+ruwynx3hZFKRShkRvMVcfn/CRCmaL97j7URdtgCaih6ev
 UXrK2vMKC4pOloqGmoOll7kKcK67vnv2EC/fasq3VJTVih6acN1pbqRyI4IEr3CprL84
 uh5Js2Ih9AfsRB9fQBp6T7fSJREECzVjDiOOMGghkCaEraKNgQ4cXScGOBHcZGgHGbqZ
 Dcrlr2hJjqyf2cG8SIQ+GNar26Ekw2JzGrRyd9h7TPgsvkbpIVXCejJcyI9M5Ra3XFSh
 uNxw==
X-Gm-Message-State: AOJu0YyreoCoUvN58rPuy9Pm3cQlc9T9OitLSiMkcP9nfhJHZ56KRe6x
 pwzVTGAwZbvDP9rGruC9Z+vh/IxSDhkwCVvYwK8FzW+VZ5I1FlPDNcOz4p1bEeBpK/P+MGz7iVt
 j+hLzs0MDjo9kdNeaPBVpaL2tuVKSv5vjyoR0EJQdi5EG8X7kqaLrv7Pa
X-Gm-Gg: AY/fxX52WrbsYy3yWQL0BTgiwWn+t3O8Qhnk0ICCBChbsZSBU+unKMrX4PQkBYbAb2R
 m05KJTrjmPxfcG4fiKWmoB+n7pZpxtdAlfneLanCUpiB4GwtY2pfo1mslQku2MZeYvgJYdEHGl+
 P33L7uOJ4mCTaw2rVBfggNmvfKS+pQFPqWf0tylMBc/nyKTFhOKHfvWW8vM8AhgwFCQ2tN5Q2SO
 T0sAnCgWGnL0HNBp277zoVgU+yyomOjOEbIYZmAcQ6Vx6QN5rcdiXisvdngGOmyIqRCZW2HvGpq
 LxCfEa+GvkVYEaj2kCixxWSeKITpnsH/1JzQ0rU3fAA/pv6+T/wRCAhoCIQX6XQf2l2D4TdhLny
 1ce8=
X-Received: by 2002:a0c:edc3:0:b0:884:6f86:e096 with SMTP id
 6a1803df08f44-8887e7a0854mr120467546d6.34.1765815976110; 
 Mon, 15 Dec 2025 08:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtnZbJIWIM7kpz31vP3L8RJ7MVrtMKE65Fsq7jZpp44HD79Pu6dq0YqPQ/zDN7t31dJ7aZ1A==
X-Received: by 2002:a0c:edc3:0:b0:884:6f86:e096 with SMTP id
 6a1803df08f44-8887e7a0854mr120467186d6.34.1765815975607; 
 Mon, 15 Dec 2025 08:26:15 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88993b41f86sm54823376d6.3.2025.12.15.08.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:26:15 -0800 (PST)
Date: Mon, 15 Dec 2025 11:26:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de
Subject: Re: [PATCH v2 0/1] migration: reduce bitmap sync time and make dirty
 pages converge much more easily
Message-ID: <aUA2pYf68psZazPu@x1.local>
References: <20251215140611.16180-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215140611.16180-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 10:06:10PM +0800, Chuang Xu wrote:
> In this version:
> 
> - drop duplicate vhost_log_sync optimization
> - refactor physical_memory_test_and_clear_dirty
> - provide more detailed bitmap sync time for each part in this cover
> 
> 
> In our long-term experience in Bytedance, we've found that under the same load,
> live migration of larger VMs with more devices is often more difficult to
> converge (requiring a larger downtime limit).
> 
> We've observed that the live migration bandwidth of large, multi-device VMs is
> severely distorted, a phenomenon likely similar to the problem described in this link
> (https://wiki.qemu.org/ToDo/LiveMigration#Optimize_migration_bandwidth_calculation).
> 
> Through some testing and calculations, we conclude that bitmap sync time affects
> the calculation of live migration bandwidth.
> 
> Now, let me use formulaic reasoning to illustrate the relationship between the downtime
> limit required to achieve the stop conditions and the bitmap sync time.
> 
> Assume the actual live migration bandwidth is B, the dirty page rate is D,
> the bitmap sync time is x (ms), the transfer time per iteration is t (ms), and the
> downtime limit is y (ms).
> 
> To simplify the calculation, we assume all of dirty pages are not zero page and only
> consider the case B > D.
> 
> When x + t > 100ms, the bandwidth calculated by qemu is R = B * t / (x + t).
> When x + t < 100ms, the bandwidth calculated by qemu is R = B * (100 - x) / 100.
> 
> If there is a critical convergence state, then we have:
>   (1) B * t = D * (x + t)
>   (2) t = D * x / (B - D)
> For the stop condition to be successfully determined, then we have two cases:
>   When:
>   (3) x + t > 100
>   (4) x + D * x / (B - D) > 100
>   (5) x > 100 - 100 * D / B
>   Then:
>   (6) R * y > D * (x + t)
>   (7) B * t * y / (x + t) > D * (x + t)
>   (8) (B * (D * x / (B - D)) * y) / (x + D * x / (B - D)) > D * (x + D * x / (B - D))
>   (9) D * y > D * (x + D * x / (B - D))
>   (10) y > x + D * x / (B - D)
>   (11) (B - D) * y > B * x
>   (12) y > B * x / (B - D)
> 
>   When:
>   (13) x + t < 100
>   (14) x + D * x / (B - D) < 100
>   (15) x < 100 - 100 * D / B
>   Then:
>   (16) R * y > D * (x + t)
>   (17) B * (100 - x) * y / 100 > D * (x + t)
>   (18) B * (100 - x) * y / 100 > D * (x + D * x / (B - D))
>   (19) y > 100 * D * x / ((B - D) * (100 - x))
> 
> After deriving the formula, we can use some data for comparison.
> 
> For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and 16 vhost-user-blk(4 queue per blk),
> the sync time is as high as *73ms* (tested with 10GBps dirty rate, the sync time increases as the dirty page rate increases),
> Here are each part of the sync time:
> 
> - sync from kvm to ram_list: 2.5ms
> - vhost_log_sync:3ms
> - sync aligned memory from ram_list to RAMBlock: 5ms
> - sync misaligned memory from ram_list to RAMBlock: 61ms
> 
> After applying this patch, syncing misaligned memory from ram_list to RAMBlock takes only about 1ms,
> and the total sync time is only *12ms*.

These numbers are greatly helpful, thanks a lot.  Please put that into the
commit message of the patch.

OTOH, IMHO you can drop the formula and bw calculation complexities.  Your
numbers here already justify this patch very useful.

I could have amended the commit message myself when queuing, but there's a
code change I want to double check with you.  I'll reply there soon.

> 
> *First case, assume our maximum bandwidth can reach 15GBps and the dirty page rate is 10GBps.
> 
> If x = 73 ms, when there is a critical convergence state,
> we use formula(2) get t = D * x / (B - D) = 146 ms,
> because x + t = 219ms > 100ms,
> so we get y > B * x / (B - D) = 219ms.
> 
> If x = 12 ms, when there is a critical convergence state,
> we use formula(2) get t = D * x / (B - D) = 24 ms,
> because x + t = 36ms < 100ms,
> so we get y > 100 * D * x / ((B - D) * (100 - x)) = 27.2ms.
> 
> We can see that after optimization, under the same bandwidth and dirty rate scenario,
> the downtime limit required for dirty page convergence is significantly reduced.
> 
> *Second case, assume our maximum bandwidth can reach 15GBps and the downtime limit is set to 150ms.
> If x = 73 ms,
> when x + t > 100ms,
> we use formula(12) get D < B * (y - x) / y = 15 * (150 - 73) / 150 = 7.7GBps,
> when x + t < 100ms,
> we use formula(19) get D < 5.35GBps
> 
> If x = 12 ms,
> when x + t > 100ms,
> we use formula(12) get D < B * (y - x) / y = 15 * (150 - 12) / 150 = 13.8GBps,
> when x + t < 100ms,
> we use formula(19) get D < 13.75GBps
> 
> We can see that after optimization, under the same bandwidth and downtime limit scenario,
> the convergent dirty page rate is significantly improved.
> 
> Through the above formula derivation, we have proven that reducing bitmap sync time
> can significantly improve dirty page convergence capability. 
> 
> This patch only optimizes bitmap sync time for part of scenarios.
> There may still be many scenarios where bitmap sync time negatively impacts dirty page
> convergence capability, and we can also try to optimize using this approach.
> 

-- 
Peter Xu


