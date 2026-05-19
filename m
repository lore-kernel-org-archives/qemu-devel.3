Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F15CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRJT-0004EY-6W; Tue, 19 May 2026 16:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRJP-0004A1-6L
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRJN-0004Zk-Nt
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3qRtpAWMe94qSpwsZC53ugDx4Yk63PMuVW83KrBV0o=;
 b=Nsmv+3c8ijWIiPiMno8X51ErzaS4PEFnw/miCYpquJ+sBRlj4n9Mq/4R+dQXqhQVT/j2yz
 FVRj1hHepO1vGJ3ElzWpILetnEMZ736vFWTU/bkvpAR5CqkVfxNtHOuxQ4LD/ZfwlsMsUI
 C/EcKq/z7Yni+5L+wfCVbcQANhITP4Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-yiJ-oMTNOwOyXIu3nmLvcw-1; Tue, 19 May 2026 16:45:07 -0400
X-MC-Unique: yiJ-oMTNOwOyXIu3nmLvcw-1
X-Mimecast-MFC-AGG-ID: yiJ-oMTNOwOyXIu3nmLvcw_1779223507
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-90cbd806004so1024304285a.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779223507; x=1779828307; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F3qRtpAWMe94qSpwsZC53ugDx4Yk63PMuVW83KrBV0o=;
 b=UFshT84NFQiL9HIZfvNfGYuDIGIf7UIjqla2Gt9FlLm6fKuDWj5+1U+cslVcXeRsc8
 kIuFk/42QMeWvCAgYATW2clewnSgpBGma1RxywklQZwXyivBZlHwupVozCBX/C9d9BhI
 7cdILjgVEDGrH+qYZnZ4ExNu2Tvq5XEj1RsHHxKSp7g2PBhpI2UMt6qnbDZY55VrVPfR
 GMAADYG2CCURH8aH6f+BXB6AB9Xyt0DE4JTgI8Buku6/DESsK5Jv7n8rN0BBmSdR2WNp
 wxqNdgqma9shxENb9hxDZkRNUdUzlWmdNRdqXr4J7WN+nvgisxTpl4rIUwNWnA1fqdlP
 Y6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223507; x=1779828307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3qRtpAWMe94qSpwsZC53ugDx4Yk63PMuVW83KrBV0o=;
 b=qftqM42zdkUFzpdNKF1uggQVV4FDGRpNhx0BWCb4iccZaLk4dFfVGsVh1AjuF7xqp2
 u8DyX1YcS95Ei9WeeDCJgp1h0u2QSq+7c3GQrhztIzGxLjRhSXaJrU9LWQwrMtkdWSoo
 6c9aD/hvcDoohZInBUqT6aQPj0ZPcZzOHjx/TOvv+g6aelT724RPhK9BKueKQhzdgWkg
 MFm7Jsefb9tDvQiT1ORUonDG8IC/wq2bjM7ezjdj/RK5x2wDm/5zbG+jZXU1RU57gvdl
 /EPkZKASH8x3P5j7veij+cgzIfN5KzeXMcNfErKSELQq2e9F8yqxoMylBFSniGr8bo1+
 fI8A==
X-Gm-Message-State: AOJu0YwbKyLzEJqlcbUMoK2s8e4U89IUYQ/XKbyF4+rLJRtMHjuum9p/
 XDqu3knUdrPsx8Um9YtTzLykXw3nc7LB3+co9U6iWkgEZR2UksA/Gp1ecj87eHT8D2s7LptI6o6
 aeqqbUcEvwBLDdiZD7ptmx7usJPDOUGHycM83OmqMEHwOtdvZ2uhYyYtH
X-Gm-Gg: Acq92OEJZTUsyhluwa+9OwJgpDGO1AgGIM//gvAd1mrCOCSUweKUCzPEY7P50imlA5/
 WZhWou+B7nYTbywLyJcmVdx4gTramH0oWfw3K7lk33XuDzJEaPY5erPjIicEHiE0qWPaj8yYihQ
 TpO25lhRA91zlKcRx7scW4k43H7ZVJ7JDujlexTnhBuBDes4ewJtclo7ZjWYM7vTh13IkNW3GvD
 BiWUe44s5abWm5bR7W0kFRIJQ/aLEbiiVheB9Pywf0OnQQq2jMtWoyXucsBkwJj9FlpshF3aiYA
 +BnfLu5dIj7pRFXIbUQrgufzZkI+49yNOu6ViBrK3Lu1v6Jp1pD2TVW6UM1qFWyRCD5m+A6akza
 unzC4mYYMhUHZ9mMqC5XrzLPnGImEtV6hdppk1QyGvTCH3Ik=
X-Received: by 2002:a05:620a:3708:b0:8ed:d906:a8fb with SMTP id
 af79cd13be357-911cd37490fmr3330581885a.15.1779223506744; 
 Tue, 19 May 2026 13:45:06 -0700 (PDT)
X-Received: by 2002:a05:620a:3708:b0:8ed:d906:a8fb with SMTP id
 af79cd13be357-911cd37490fmr3330575385a.15.1779223506297; 
 Tue, 19 May 2026 13:45:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba1825dcsm1947369585a.2.2026.05.19.13.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:45:05 -0700 (PDT)
Date: Tue, 19 May 2026 16:45:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 02/15] tests/qtest/migration: Make file-tests defer by
 default
Message-ID: <agzL0OsyqvojtWM9@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:01PM -0300, Fabiano Rosas wrote:
> All file: tests use listen_uri="defer". Make this the default in the
> common function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


