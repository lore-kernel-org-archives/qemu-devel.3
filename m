Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D2F10F284F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6ANu-0004wt-RF; Fri, 27 Mar 2026 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6ANj-0004s1-0B
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6ANh-0004Xq-A1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774630196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxfheb6NaAC86Lci44v2jXBV2v0OIwMTlrOp5Kh91dg=;
 b=AiECFFr5sPJ5IoVOj1JZZa2eCEkpTGtrSn3gko2nIL53k5RwviresJls0vNIqrw6Zgp8/Y
 YafSL8SWqPRoSPY0MNtVMILMEN11iMErbymC01SxNjSVbodFuPHJFah0tzHyzVziBdCcAm
 Usj3igy/ytQGtSAfEAMeYQIrUDEZdTc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PSHAoTZWPAyusvMFDgjVJg-1; Fri, 27 Mar 2026 12:49:51 -0400
X-MC-Unique: PSHAoTZWPAyusvMFDgjVJg-1
X-Mimecast-MFC-AGG-ID: PSHAoTZWPAyusvMFDgjVJg_1774630190
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48722073bd2so14658265e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774630190; x=1775234990; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fxfheb6NaAC86Lci44v2jXBV2v0OIwMTlrOp5Kh91dg=;
 b=BPfT+/jbCstPYcNePD7GXsVh4PVCEmMAGA2xodRZkzkkZ7oy49FBHuwarl6PHsig0/
 CmpWAxe9FrPamw0wZESXjJPfX/dFKorWyHFblMqSijUmZuPljlwlwViWwQ/bRnvgizH7
 K9Djc8rBWCsBynK/cHYIP9bol4X1qKXXpLcjAcBJLAbDOecjNoP88XWGwelHiUu6geKc
 Ab++Hm+eb4l4gDnu8h7ypwLxuWL3ucfd8oyoCQj5Yx3hshLpFTfb+nSApoEG7xG/uV1B
 X1EyYcSY1cqHXUULTKfiBBi5j3BikBpmoD5ly5982VaudACdqBYxgKAvjAIgCwq4AlmT
 8Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630190; x=1775234990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxfheb6NaAC86Lci44v2jXBV2v0OIwMTlrOp5Kh91dg=;
 b=f+9tYl9km8U/n2XViseF6lmXvxe03RuFu2iVzgEjceV9S5dcnKsM1+vcBcpTQTs1DC
 xjYAdxrkXCAHbJPsuNA8NWcksoObhADjVzS5R3CsmCunQ5w3VqEy7F7wNOoLpg3Jorlu
 ZQf8FFWLUEuP9Ss6VJgFa8Iel/9rYComjn6gIgVX/TxSeDBIPOdJou1l26grWcIsToS6
 oDdgYYxG7czp03AHzE1TA/Xf53dl7YOwe0zRuMlZTnKMKA7okDGufr2uucF5ZhTUIMXV
 3v1diAtr2bZw0TeIC9GO1cnU4xNSiFLKdxLbeIcRQ1Fbb7T90wssnDWnIVd7AgNwQIcf
 fQlA==
X-Gm-Message-State: AOJu0Yztzt2iUwPrkpg7AL58ewct8CRjkwEYO5wBkkVghrjDI15ftmi3
 sTED7wdF88/ks0O6I3g7L71guOWVr/F682xYxFHh7WmbiQDKYAFKqAlRvGoz7XOhZsdT+dtbX2b
 DjN2cWTIZjp/tWBdeecOOf3Rvv4hM1QzuISh3JGjZoFLDlQGQOuXtv4F3
X-Gm-Gg: ATEYQzxLZR9AT/TuWUQujrMVFPnWAX8P6Sab6NSWpEBYfd6w+P1Qa3ZQDEuOlqeNg/u
 f5EX5VynDsVWhVrSOAInGmQxKbwGUfBTxgwlsOSdsCiJwT/CUmQQZu1elWGvYIOQixSIsfT4jvV
 1uG9FUEqzxJ0rHxqSpOsYnx1i5QsG1TKmaCyc+6D+7fBCK5BBvIKbcXCjkTF91l39DMU8L44US1
 zzUlzF7wVRG5eLeA8A4N1yrpFcg0M92h20rfL92iZy3uxCxIyXbzWh6v6bfz7djJv2NIpHPeYZs
 VxYKCj+X2rj/GxK9lot4YCBrNuZZqi40StgYT1pt1CjmtSh73+uGABjyXj17MXYUEd/3CF1MqDy
 Z8g==
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-487290a9254mr45234025e9.1.1774630190078; 
 Fri, 27 Mar 2026 09:49:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-487290a9254mr45233605e9.1.1774630189560; 
 Fri, 27 Mar 2026 09:49:49 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9f0afsm184179005e9.10.2026.03.27.09.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:49:49 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:49:46 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yong Huang <yong.huang@smartx.com>
Subject: Re: [PATCH RFC 09/12] migration: Make iteration counter out of RAM
Message-ID: <acaz4bJstLXz2Xdt@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-10-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Peter,

Did you maybe mean s/Make/Take/ in the subject?

On 2026-03-19 19:12, Peter Xu wrote:
> It used to hide in RAM dirty sync path.  Now with more modules being able
> to slow sync on dirty information, keeping it there may not be good anymore
> because it's not RAM's own concept for iterations: all modules should
> follow.
> 
> More importantly, mgmt may try to query dirty info (to make policy
> decisions like adjusting downtime) by listening to iteration count changes
> via QMP events.  So we must make sure the boost of iterations only happens
> _after_ the dirty sync operations with whatever form (RAM's dirty bitmap
> sync, or VFIO's different ioctls to fetch latest dirty info from kernel).
> 
> Move this to core migration path to manage, together with the event
> generation, so that it can be well ordered with the sync operations for all
> modules.
> 
> This brings a good side effect that we should have an old issue regarding
> to cpu_throttle_dirty_sync_timer_tick() which can randomly boost iteration
> counts (because it invokes sync ops).  Now it won't, which is actually the
> right behavior.
> 
> Said that, we have code (not only QEMU, but likely mgmt too) assuming the
> 1st iteration will always shows dirty count to 1.  Make it initialized with
> 1 this time, because we'll miss the dirty sync for setup() on boosting this
> counter now.
> 
> Cc: Yong Huang <yong.huang@smartx.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h |  3 ++-
>  migration/migration.c       | 29 ++++++++++++++++++++++++++---
>  migration/ram.c             |  6 ------
>  3 files changed, 28 insertions(+), 10 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


