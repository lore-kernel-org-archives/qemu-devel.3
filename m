Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DBDC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXCDG-0003vK-AX; Mon, 05 Feb 2024 22:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXCDE-0003v0-VG
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXCDD-000128-7y
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707190409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oEqFbU+SpliBLTlCaWMDFxi6I19jMwyWrtheII3vEA=;
 b=axURjGKeJUV9OfiVzx1mWGcy9MeiUQIXNE5kt7xRy+wJt07k+AKuF/PL6xXKoQiMROPq2N
 hiVuyh/xPBa1CDe9wgheDCwhDyYqqmZa+Avusv+7Y3OMAJPmgCbAfO2b73+bzqVeazRio8
 f+BI3HdZV4fyv+IOLZEt8ooEy4XLWWI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-7RD8Kpr7MyOT_Towlbu0SA-1; Mon, 05 Feb 2024 22:33:28 -0500
X-MC-Unique: 7RD8Kpr7MyOT_Towlbu0SA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so1626018a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707190407; x=1707795207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oEqFbU+SpliBLTlCaWMDFxi6I19jMwyWrtheII3vEA=;
 b=eb7t20Dxm+gIjHp+avyjCgVNCenpaMY/IPvK1d8AXb4NwThMxNkeyL502chJONiGG/
 AHc7lDmTX9/bQ7ZU8ImzIWZscBVZy+AwIgmWjuhhTZVN/y4URz61PxlfO7+IxTTMV6kg
 ePrqA2VwwKcCYpt1DUVXL1vHMSc770znLgt3A/40x4OkNwpg5creAnukxxvGCRUPhF6P
 DxSJ0CrH+go1i/V8kHtW5aVXXWYHBXZbM55SmGnkmWbCw19Kkj+tSQHfj5AS1eXNBVpy
 frt3CWBc3JYl8MEop5qGryAqiKbU3t0SNHNiTzhxJHSKnWf3DNE+Wp/+kexL5BGWf/XD
 Ah0g==
X-Gm-Message-State: AOJu0Yzj28Cy/s6vQvLFHJyLi/8JLDaHiNjSIZDuncQjH0c29aNzouqZ
 +WdddyfIblafyE3OYK+xFjTXjlnFdAvHnRggvrrFiQoa7fJzTBBym4x7Z7WCyejoWbCFOFLiCes
 qtRspv8KiJx/txAcu7VCd9F7b7sTeaOcGjbq48skRZXdsrz/aWkcU5SZttVsXHBU=
X-Received: by 2002:a05:6a21:99a0:b0:19e:3390:4a42 with SMTP id
 ve32-20020a056a2199a000b0019e33904a42mr1468032pzb.3.1707190407152; 
 Mon, 05 Feb 2024 19:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRZot5g2Gdnallnc5DeiktKJexWtADBQ81SLwKFtrtWrRsMNmW0QvvnGY0HDtXfutGN02Zzg==
X-Received: by 2002:a05:6a21:99a0:b0:19e:3390:4a42 with SMTP id
 ve32-20020a056a2199a000b0019e33904a42mr1468027pzb.3.1707190406865; 
 Mon, 05 Feb 2024 19:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVax0746k/77xQB2TRhNqljwxhbj8qlmJpqBvW8zGgeAeR3NeLCwIPc2ZKgfGA2CQ1qUdzr7uMhYE5xymNGZoLnMVs822LeNiUqy2K/Hha2ZKBDdWZJUhY=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v7-20020a626107000000b006e0404f419dsm697363pfb.125.2024.02.05.19.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:33:26 -0800 (PST)
Date: Tue, 6 Feb 2024 11:33:18 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 5/6] migration/multifd: Unify multifd and TLS
 connection paths
Message-ID: <ZcGoftzEOhzPUtpo@x1n>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205194929.28963-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Feb 05, 2024 at 04:49:28PM -0300, Fabiano Rosas wrote:
> During multifd channel creation (multifd_send_new_channel_async) when
> TLS is enabled, the multifd_channel_connect function is called twice,
> once to create the TLS handshake thread and another time after the
> asynchrounous TLS handshake has finished.
> 
> This creates a slightly confusing call stack where
> multifd_channel_connect() is called more times than the number of
> channels. It also splits error handling between the two callers of
> multifd_channel_connect() causing some code duplication. Lastly, it
> gets in the way of having a single point to determine whether all
> channel creation tasks have been initiated.
> 
> Refactor the code to move the reentrancy one level up at the
> multifd_new_send_channel_async() level, de-duplicating the error
> handling and allowing for the next patch to introduce a
> synchronization point common to all the multifd channel creation,
> regardless of TLS.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


