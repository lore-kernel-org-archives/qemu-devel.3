Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF48C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYmd-0005jP-9r; Tue, 06 Feb 2024 22:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYmb-0005j0-OP
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYma-0002DN-41
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707277171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4hzoFADmRnItH2GaPBNPIhsFjSsC8cJGyUVCxUIsZIM=;
 b=J5+DVJmDt13LpzRt5qYxPdQB8Q39T0FPBGCHsb8Z8Op91vhVPvYbUktT1EfwabjIITVpG0
 7czQzzp0rpg5Cf4FnNGw2b/1Axzf6VNtniNyFG45CuWpHMk5VNoJhB/7NZ7kdFwziBUymU
 v5wfRYr0hc/oZ44W4sti3hxiPSYMim4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-_NtzlT8iN-OQrnjGKU7icA-1; Tue, 06 Feb 2024 22:39:29 -0500
X-MC-Unique: _NtzlT8iN-OQrnjGKU7icA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5dc1aeb6a58so85338a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707277168; x=1707881968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hzoFADmRnItH2GaPBNPIhsFjSsC8cJGyUVCxUIsZIM=;
 b=u3ljtsC93XPIY8Wo6Fm9FlXspRBR7d1eCRWlA01RyII6tRIn7QqK2JU6UypPas8jNA
 uwipqkpxOpj8ZMfWBnUPgy7x/nDbrSAlVG0cFm8BBXjnaTCd9DLIQ3RU6FmIWFcZ9Uy0
 /62bi8hM14JOd2wAkJ82wSUHvWJiTFeMgal6Lq5IlwTlplmzawn8VG0xLPiSvsi8NBFt
 +BYnSU1GT0+Umyv71U/DABi0dSqPTwzakv14+Cb79Nv/gdTLGNXKPx8wN8RURprUuFWk
 /CTSiBqJZRq+rLMyJsJEE3M4TUIe2rmXk5cbu4EZ+K/zlrg86731l6XDcdWlddXvign3
 wwcw==
X-Gm-Message-State: AOJu0YwQ7EIjjC0TSZdGMO+VniXLrbXWKMOzwjBmFgECOgIQ2U+3ULWB
 i+1+o5H0auY8OKBg+ekhTWH/WODfhg7yJ4g93dILrAY9OIiYvhnoh8fTvUs7R76nwykEPRgLY3s
 UFLN5CtNiuuMJkOqW0zmo/b5qQ8lUbcKOwMgJvbjl4ZJ3K6++mD1B
X-Received: by 2002:a17:902:d4ca:b0:1d8:f06a:9b6f with SMTP id
 o10-20020a170902d4ca00b001d8f06a9b6fmr4772430plg.1.1707277168264; 
 Tue, 06 Feb 2024 19:39:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv+d3zBJ8/gqodF7QCi+YOgJw5SRsD4FBURaesMgohM8RkcrtXnX+tUUgS/Ou/tQ+QYgJgjg==
X-Received: by 2002:a17:902:d4ca:b0:1d8:f06a:9b6f with SMTP id
 o10-20020a170902d4ca00b001d8f06a9b6fmr4772415plg.1.1707277167905; 
 Tue, 06 Feb 2024 19:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX0CJHedVAjpHePgdvzyohMYfpkGJHzYFLm6Sa1sODAjR8ZJkfmATZYaAeW9Xfw/ECltKkVvmGL77BtQHLD6co=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mm14-20020a1709030a0e00b001d7726c4a40sm294270plb.277.2024.02.06.19.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 19:39:27 -0800 (PST)
Date: Wed, 7 Feb 2024 11:39:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/6] Introduce multifd zero page checking.
Message-ID: <ZcL7aIwo_Z8gn6h3@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Feb 06, 2024 at 11:19:02PM +0000, Hao Xiang wrote:
> This patchset is based on Juan Quintela's old series here
> https://lore.kernel.org/all/20220802063907.18882-1-quintela@redhat.com/
> 
> In the multifd live migration model, there is a single migration main
> thread scanning the page map, queuing the pages to multiple multifd
> sender threads. The migration main thread runs zero page checking on
> every page before queuing the page to the sender threads. Zero page
> checking is a CPU intensive task and hence having a single thread doing
> all that doesn't scale well. This change introduces a new function
> to run the zero page checking on the multifd sender threads. This
> patchset also lays the ground work for future changes to offload zero
> page checking task to accelerator hardwares.
> 
> Use two Intel 4th generation Xeon servers for testing.
> 
> Architecture:        x86_64
> CPU(s):              192
> Thread(s) per core:  2
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               143
> Model name:          Intel(R) Xeon(R) Platinum 8457C
> Stepping:            8
> CPU MHz:             2538.624
> CPU max MHz:         3800.0000
> CPU min MHz:         800.0000
> 
> Perform multifd live migration with below setup:
> 1. VM has 100GB memory. All pages in the VM are zero pages.
> 2. Use tcp socket for live migratio.
> 3. Use 4 multifd channels and zero page checking on migration main thread.
> 4. Use 1/2/4 multifd channels and zero page checking on multifd sender
> threads.
> 5. Record migration total time from sender QEMU console's "info migrate"
> command.
> 6. Calculate throughput with "100GB / total time".
> 
> +------------------------------------------------------+
> |zero-page-checking | total-time(ms) | throughput(GB/s)|
> +------------------------------------------------------+
> |main-thread        | 9629           | 10.38GB/s       |
> +------------------------------------------------------+
> |multifd-1-threads  | 6182           | 16.17GB/s       |
> +------------------------------------------------------+
> |multifd-2-threads  | 4643           | 21.53GB/s       |
> +------------------------------------------------------+
> |multifd-4-threads  | 4143           | 24.13GB/s       |
> +------------------------------------------------------+

This "throughput" is slightly confusing; I was initially surprised to see a
large throughput for idle guests.  IMHO the "total-time" would explain.
Feel free to drop that column if there's a repost.

Did you check why 4 channels mostly already reached the top line?  Is it
because main thread is already spinning 100%?

Thanks,

-- 
Peter Xu


