Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62150C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 11:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tav64-0000dB-A3; Thu, 23 Jan 2025 06:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tav5v-0000c6-Fw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tav5s-0008FV-LW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737630587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnuyH2luA4bChje1E+esllTtAtA1XOQn3dUGHhmAv7E=;
 b=Cu8LHCU6I9aXbilPx8Bo50yzbnni3ZiivvE0SAudDgOxpSwabvo/fFbQQmI7k8WAXQroBV
 9FylEUcgqySI387vkSyVTA93Z/oYD/DPyWrEic9qnpS9TohVabMn5sUGRygfM7DcZj3bfk
 xwWCVikiQin/+SxXTk30Ca8ENt+TEOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-by8WyXFnPFeWHBEENFzk_w-1; Thu, 23 Jan 2025 06:09:45 -0500
X-MC-Unique: by8WyXFnPFeWHBEENFzk_w-1
X-Mimecast-MFC-AGG-ID: by8WyXFnPFeWHBEENFzk_w
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so4375765e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 03:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737630584; x=1738235384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PnuyH2luA4bChje1E+esllTtAtA1XOQn3dUGHhmAv7E=;
 b=jv6DdRWDDtmqDlaFJDqHDD2s4L4npSSAM2DreLKkBNxD4457arMZfOwYamQScePA3J
 Fy9ThwEEEIntATuJ1Xnuft5hlXh15fowA7LM0SxGiqmitHabh6vZf6nKYpbMJ8r2LC0Z
 ZSpD2lWwDqBncGZ2DxL02HX5tu5dsdaqcJy19+3aRPeztw5HTydushpyqQQm05veDMWL
 zQ5zAu5xFefkC13LHgHQjIUM2WgEARWlqgbpC3hCgPTfnBATUkIZ0W0Uu7xXWeO2fIc2
 o99+VOKrrrYtEti9y4bUPv0Y47aPDfbsEni5P9v7unc4MeOnA6GlItt03kCXytO1jnen
 5p2A==
X-Gm-Message-State: AOJu0Yy5yoaKyRwqJTNXMRkpylLaixEcGnZLB6C7XyI7TFTlzgVMon5U
 MLZWCIVA91TMDhfl77HY7EfL2J6dWE09LxDIyq62gzA2kQIjbzk70XP93aOWTR0e915xOaFO3oV
 QnWOhTK5kLHyk3vDDTshjT3GW+Lt8MnvkO595WKSfqhG/1vCt48Ba0KOSjhcCk/T/V3I4qRKVN8
 9466mAiEiDJKgPKBjGY+ZvmjGPOTI=
X-Gm-Gg: ASbGncumtfgeah5eR4FbA95eme7HrEUBBQeoNCDhyXlUtEX5tBTiXpSfzaq1RYG602k
 Q/g7UCpA1MXYVTzv+2CmZvDL3js8DP+I14Mt5HxyrQCnACsd7S90Y
X-Received: by 2002:a05:600c:348c:b0:434:f1d5:1453 with SMTP id
 5b1f17b1804b1-438912dbfedmr262877295e9.0.1737630584393; 
 Thu, 23 Jan 2025 03:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaSZX/kk7T7vHVKSEuXbuPOWi3eNDzuCMhQyHuoofvZ1W9FdmZXg7+PpJEvvAv9IQOGEZ0ECdjwBX/QFysDVo=
X-Received: by 2002:a05:600c:348c:b0:434:f1d5:1453 with SMTP id
 5b1f17b1804b1-438912dbfedmr262877105e9.0.1737630584109; Thu, 23 Jan 2025
 03:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
 <Z4_Bh3ytv9REBero@x1n>
 <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
 <Z5EYbBXkjTu98rHk@x1n>
In-Reply-To: <Z5EYbBXkjTu98rHk@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 23 Jan 2025 16:39:27 +0530
X-Gm-Features: AWEUYZlUn6AtQIz2werErfbNHtY518BEveJvEd9KCzNU-mymHM4tUdb_ZufuBKc
Message-ID: <CAE8KmOwvp=LJ+79t9VVsZqf4APqSYxqCQVmYSg_5QaVD4vzLWg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 22 Jan 2025 at 21:40, Peter Xu <peterx@redhat.com> wrote:
> I believe many of the tests can be avoided, but still below is a list of
> minimum tests that I think might still be good to add:
>
>         # /x86_64/migration/postcopy/plain
>         # /x86_64/migration/postcopy/recovery/tls/psk
>         # /x86_64/migration/postcopy/preempt/plain
>         # /x86_64/migration/postcopy/preempt/recovery/tls/psk
>         # /x86_64/migration/multifd/tcp/tls/psk/match
>         # /x86_64/migration/multifd/tcp/plain/zstd
>         # /x86_64/migration/multifd/tcp/plain/cancel
>

Okay, I'll start with these for now. Thank you.
---
  - Prasad


