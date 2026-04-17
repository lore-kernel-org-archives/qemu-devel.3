Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57A7F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfag-0003dA-U1; Fri, 17 Apr 2026 05:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDfaf-0003cv-3v
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:34:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDfad-0004Op-9B
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:34:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso2132795ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776418457; x=1777023257; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QvPGVy1UFQ34IVtX4EQSxctnQ9SLMK1Xwke5jIBtyog=;
 b=d75Dds6tLKDmXOAsvAp1jFEUxL0RKDT5yeJUEI0I7+Pm9EjmvzHrb+eIFTX9dOx7lY
 yRv3Nqi4u87Qc/PzQ6QFCVxbjz17Uaj8lTe7Y72Lj2a+AIDrI+LYn1Q/wpAjvFnS4pDT
 ioRayVDbCaN7mCjXDn5AWJt0w4I1C73mVkNgJ97+WDhqfpNgwOCDMx7+ljb+u9Cm98E1
 /drt8rrYU1MYZjqe3BmexEhRBGQREWxVMeGVhhGNb/fJKFhx8BXD359iR9q8d1MiLz3K
 RJE3L2O6dw/sylyLDO0JC0EsAybub7+9Xtz9PmPb2i6RH2W6sz6Ny6vLP6VlwJBme/8Z
 U/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776418457; x=1777023257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvPGVy1UFQ34IVtX4EQSxctnQ9SLMK1Xwke5jIBtyog=;
 b=dti0tBPu72SNLhB5LzwwHDpPhjPC/Vm1lyHhg+/a0R1pgLYnPnHnePoyMEOinzxwsT
 dwe1ayJVd8XqM/G/OwPTb6azkOana6ocOHejTApGnMB1YpQ2yvTqNnksLkqmeSpk6hZw
 +FSYeOfyNG8NmqPUjRYwnoJtfBGCClBClZ8S/LEy5PoVi5D8jkpEgedQe4dr8/ag+j0x
 JySNkfbf+AGroZDFEJHp5wzhvO51Ax6oRFbg/rBB2TlUR7e0KUbBmqjIlWZRyY7eroZq
 nr9LpRkADfefB9QH1HWvQxcWrnTqkSq1w7MNqSbHQH8QLTfwXteIdC77cCXng+7P5q/e
 wYIA==
X-Gm-Message-State: AOJu0YzReYcjI93Wr6vcuQscPZ8s1mWC7vI38gfx/EWEntjBDZyBUSme
 JRbgUO8hx5SFrQEM0ooqgOuoTXH73CSpyosi+9uK2JNhD1ioJf0EyzBt
X-Gm-Gg: AeBDies7HMG7sbPjB4BdEhftzImiwQrzNIsKJY5N/u3/FbO4CrfGGE1rb8NNQejDk0Z
 OX7374kJG3VaRuqOF+w3QFVf1WR8C7dfNQs7xdhgbGfwvD4DjAUsop5sx2KRy6vSlJIifJnUPIy
 VV3GVW1dsSb+PKwWdowKlFrDhdY0J1ls0Wb6xGvFMwykMNpC2MGN913AxhmNL85iojFOOEaOyME
 fw/Xm00HM9uB9QUCh8ztsSOjmXaoc3uvQpmn1hxXgTgN/erSvZ85RAUd2ywtlPD1HG/26tMd16K
 YhbXpokKFSlsAr+GSWrTPf0aJZcEAVZcmilzaWNVwNulKWjeQl8EwHqie5+7JWx9EDYfFvLY2n3
 pxQscFLWYiM1mKdjlCe9g8Q8JcBuE70K4aVSSvuOaSP3gQJey+EPtMZ2AHjY+B6unOS5V3wqRXR
 VzSztgA7PIiSwRbxkqpgSIGBKOV6OR5AuG9uwf1q0MHTHt8ytQRE9+DWTi5JMIG1PaGEYFm9JW1
 7dlTi8pjZqa6UhkG260onPwY+Q0pSF6lg==
X-Received: by 2002:a17:903:983:b0:2b2:5256:9ce7 with SMTP id
 d9443c01a7336-2b5f9fa0f47mr22509365ad.36.1776418457468; 
 Fri, 17 Apr 2026 02:34:17 -0700 (PDT)
Received: from
 trieu2-huynh-trieuhpn-ubuntu24.beeworker.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff409sm19764415ad.14.2026.04.17.02.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:34:16 -0700 (PDT)
Date: Fri, 17 Apr 2026 18:34:13 +0900
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration: expose per-device state save times via
 query-migrate
Message-ID: <4rslvp5v5rx67qhy4bnykx3jdotl642npmjcxjerpah7gc2uuv@fhu4rc27ajdg>
References: <20260416175659.41215-1-viking4@gmail.com>
 <aeE2ve7YrEXHtvrb@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeE2ve7YrEXHtvrb@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 16, 2026 at 03:21:33PM -0400, Peter Xu wrote:
> On Fri, Apr 17, 2026 at 12:56:59AM +0700, Trieu Huynh wrote:
> > From: Trieu Huynh <vikingtc4@gmail.com>
> > 
> > The stop-and-copy phase pauses the VM and saves all non-iterable device
> > states. qemu_savevm_state_non_iterable() already measures per-device
> > elapsed time for tracing (trace_vmstate_downtime_save, added in
> > commit 3c80f14272), but this information is never stored or surfaced
> > to somewhere.
> > 
> > Expose the result through a new 'device-state-times' list in
> > MigrationInfo, filled by qemu_savevm_get_device_state_times() helper
> > and returned by query-migrate when status is completed.
> > 
> > A new QAPI type is introduced:
> > DeviceSaveStateTime { 'name': 'str', 'instance-id': 'int', 'save-time': 'int' }
> > where 'save-time' is the elapsed time in microseconds.
> 
> Hi, Trieu,
> 
> Thanks again for your patch, especially during your spare time.
No worry, thanks.
> 
> Though I need to say this is another example I want to mention, that QMP is
> an API that QEMU relies on a lot, and we're serious on what it exposes.  We
> need to justify whatever new info to be exposed.
> 
> So if we start to report something in QAPI, we'd better be very certain at
> least someone will be consuming this at the very least.  Starting from the
> 1st day this API got merged, we will need to stick with it and it can be
> forever; we can obsolete things, but we need to evaluate risk.  Before that
> risk analysis, we better evaluate why an API is needed in the first place.
> 
> What is much less controversial is, if you could look at how to improve any
> of these numbers reported, say, if we can shrink some device save/load
> time, that'll always be a performance improvements.
> 
> And just to mention Joao's effort was not discontinued and gone, it's just
> done instead by tracepoints here rather than QMP queries (before we're more
> confident that we can leverage some new data in query-migrate):
Make sense to me a lot. Thanks for your kind review.
So, I'd rather go that way which focusing on performance
tuning/optimizing for device save/load time (which also mentioned in
todo list [1]) than expose exposing it via
QMP command that uncertainly needed.
> 
> https://lore.kernel.org/all/20231030163346.765724-6-peterx@redhat.com/
Thanks for the context, I'll also study on this.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
[1] https://wiki.qemu.org/ToDo/LiveMigration#Optimize_memory_updates_for_non-iterative_vmstates

BRs,
Trieu Huynh

