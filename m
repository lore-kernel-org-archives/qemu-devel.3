Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980BDEC145E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQmM-0008G7-OX; Tue, 03 Mar 2026 09:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxQmF-0008B8-IU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxQm8-0006gf-Cd
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772548260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R9d4Y6NPoPDYmRchgPDfuVNI3XHGFipLJxx0ymtlWqg=;
 b=U1nEEUpKZXqHg+xmW4UgoEMUSXq8L9xaDS0+YFm394C/Ru9zBZRxhBfqxEIubNYxpyutyO
 +I9BPnSsY/5J6JHqVdE7D8VL96u8yDE4+RbLYq7cRHVvN3lp8+5oBf6NZlHIjwBS6emW1g
 RhYmG7ZcY3JFF62LvVFHZsOODd/EkUU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-a28aClu4N8SdjVsOTwL0Iw-1; Tue, 03 Mar 2026 09:30:58 -0500
X-MC-Unique: a28aClu4N8SdjVsOTwL0Iw-1
X-Mimecast-MFC-AGG-ID: a28aClu4N8SdjVsOTwL0Iw_1772548256
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb4d191ef1so699705485a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 06:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772548256; x=1773153056; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R9d4Y6NPoPDYmRchgPDfuVNI3XHGFipLJxx0ymtlWqg=;
 b=WhZIbmmFt0E+ZPvct9R1qnw5RKoO6IDQfRjeafoHstaoxZmpNTTB86kwuUuf3JGBOD
 H2ayHiL+9pczlCK8aA69kVwkwgvN89guL1nl13F6mA6h0yLmgVH4oYkWYJ0fti/mFWUW
 VaNc0/FW0/ZqhhhEOsEBoJPRiH4KtQEK3AoFxgPUTarXkR97doAfEAeGmV94KR+WHHvA
 MTJQLN2pB33jfv6J4tPXugVxArb/s5fow9hhhNGoug1BM41/FRkK0ED0FR7Z4a6s8lTe
 07iOHk4+ELrkOiPqz4Ry84dcADd5F5ClwFZWQ0PFval6rOMNoBu16LkwTcMGmHqPpl4H
 R7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772548256; x=1773153056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9d4Y6NPoPDYmRchgPDfuVNI3XHGFipLJxx0ymtlWqg=;
 b=wEjrxvm6PREE+n9f9LNbaafqKRFutrHpCcglhaTHqxCIdjMVbInGcC7TMKTFuri4/Y
 9QMgY19ycJK5MX4o8sEkmckjcqnUl+bG+KH5wLM+5K6abhwtnY/lREmYboLc1plfJb0k
 BAng7Ho3Jh6pi5g5TV16EIkmH6CdI9Ij25Ew8L2aHrRb7hrMWPKR/VK6qSWoEtA4bwsu
 cnnJJV+joEERkkOz8W6pY2aPNlrqwNShb2WepjOp//Ytxl7vq9cINymR4Rh0XBoF+vBF
 6WF+YTJcdDc6IWBiWXlqTutlICc+zLd/NAoQ6237rQ+5MtXpDI/0KJJZnkjxntVSKccR
 UYrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3pesOSAy6oUWv0ZMZDpDw3G4EAFLJtImW2+AnuLPZic+viC+1Mq283T2MDP9OVkYXYNmEOFT33cl3@nongnu.org
X-Gm-Message-State: AOJu0YxvuoM4bHFox1JBV3W8X0EDLf+3seU2vqj6TpZDygTihB5nJ/ku
 r7GdlAaWO4079vqyZbgHvOU+TI4RKs9s07UXZB+xStlLBYtn34+nj0gBprvCk5IzN6vVPAVS2uE
 LV7cDAIvpb0GyKEZ9oyvu1WCyjhi+Z/4yjsKcFPm1wvxeKpVCxZ2zRPbV
X-Gm-Gg: ATEYQzwZjVwE/UxqrTcaT5yCiFDzGHk7QPFl5iXRz8xautY8roZ3DR1DVB/DuFsfWRq
 CrLQ7PrpW4yMc935OY+UnT8sG1EZrkT5hLvStEj4i6qWpwH3Hb+K2YDZphA3NScTg2flsi51Tz4
 GYrDDnEh+iDUhlmFoI25bdX4/wMD7yVzXyr73q1sBUTvKQWi42oCAQsyQ/4PUv7+sJEIFw1GrDa
 bQ1uYW8NwylJ5Gv9mHdM5CNEo3ryY6SbXtYW8bERnnpJhbFoS+UGllusg7vjHYiheAV3tnXURT1
 scjmj216ZSHclueI+7h+E6FOUbIiULUglKkxsWpmG4u4faZ3k1TUcWDSoxh835KxuIhDu3inz4L
 vXhVwx6PHlJZhWw==
X-Received: by 2002:a05:620a:40c6:b0:8c6:a809:862a with SMTP id
 af79cd13be357-8cbc8f15f3fmr2039584685a.45.1772548256414; 
 Tue, 03 Mar 2026 06:30:56 -0800 (PST)
X-Received: by 2002:a05:620a:40c6:b0:8c6:a809:862a with SMTP id
 af79cd13be357-8cbc8f15f3fmr2039575585a.45.1772548255753; 
 Tue, 03 Mar 2026 06:30:55 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c716cbf5sm152875726d6.16.2026.03.03.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 06:30:55 -0800 (PST)
Date: Tue, 3 Mar 2026 09:30:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 01/16] migration: vmstate_save_state_v: fix double
 error_setg
Message-ID: <aabwlCk-_jv5vH-q@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Sat, Feb 21, 2026 at 12:01:59AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We may call error_setg twice on same errp if inner
> vmstate_save_state_v() or vmstate_save_state() call fails. Next we will
> crash on assertion in error_setv().
> 
> Fixes: 848a0503422d043 "migration: Update error description outside migration.c"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


