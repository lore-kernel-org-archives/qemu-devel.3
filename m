Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D827D2CDFB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HPz-0000EX-R4; Tue, 22 Oct 2024 12:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HPv-0000DK-A9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HPt-0001Uk-IE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729613248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=td1rQCrzloMzi+hdR7xNOcYCIOavufHDkod9jqnzNTM=;
 b=HYwFn4YUwq+dkwTtc8+gRH9KiDD/ZGFN9FRSMlQ40dFWNlihuKEAEHltIEEb6EcugV0nE9
 NOw1qeBEqguEowNkHqjPl0xXLPOHCko+YeaVBkq+yKdBXOXF2yBJgweQc0jpPNVikJIcDH
 sGwPMDDZy00m9GQc+I6iNG8Q3hVajoU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-RfZ5-wgKP1OK-faGGghk-g-1; Tue, 22 Oct 2024 12:07:26 -0400
X-MC-Unique: RfZ5-wgKP1OK-faGGghk-g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cdeed5a061so61683346d6.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613245; x=1730218045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=td1rQCrzloMzi+hdR7xNOcYCIOavufHDkod9jqnzNTM=;
 b=nkQiNLNMly0yZa9XO5QLxEXOGEVHTQ26Z6w4DB2MFc6HySvSWLWuh4jzATUl+4cc7J
 UjsZ+Y5vcUsuWBfYA/Tcop/h3f3kiD7fqfxJuhx1RL0hAN4SPZLgEurJ0MKojXDp24Yr
 JgDdmqSuP/XMi2lOi2X7qi2mUTE6l8Lgy2CbZD3VBrfAAaeGwOnoNjz1HBY5GG3qiMjx
 QTaCl4IeInGKS1KZjUdzXBU8UZ0mjJLZgRcCiFovmQhp3sb6MEnDKG92RYKNtoKlHqnU
 TLQvJiwAKDUByCAj+V8BUB7Iz35w79zUQOvQZHzHzHBpFJRIEYSM40CX4xEO937V2Kej
 cJOA==
X-Gm-Message-State: AOJu0YyIq5t+CMh7J0pvhsDw7o2Hps9/cU0sSmrfJ6cqID+Fg7wh9KdN
 DOdwSzSsIGGu6OiNIChiOST0buesUQ/APiLYnNHY0mU5nfpwTuDSiZI4UV29OemTglLH6EYPUvz
 MTJyAzbPgHiJPFoJuhWFlTGmqGUlGjYZg3fWqK8YDFtLPpsHBfJIyfndDvbRn6VhGwGMAIUOzFk
 PC06G5XGHhLB79J788V5ICMZuX5QGhnytOkA==
X-Received: by 2002:a05:6214:5f11:b0:6cb:ae56:1965 with SMTP id
 6a1803df08f44-6cde15135a7mr242087836d6.15.1729613243702; 
 Tue, 22 Oct 2024 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRQaN2oXjaRC33aTwTFd2xqqcEX8EHu/4Nphs8RyqXbET890g5CXcC3TLapDgKdFnqZlO+fQ==
X-Received: by 2002:a05:6214:5f11:b0:6cb:ae56:1965 with SMTP id
 6a1803df08f44-6cde15135a7mr242086186d6.15.1729613241850; 
 Tue, 22 Oct 2024 09:07:21 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fb113sm30224026d6.34.2024.10.22.09.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:07:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/2] Migration: Make misc.h helpers available for whole VM
 lifecycle
Date: Tue, 22 Oct 2024 12:07:18 -0400
Message-ID: <20241022160720.1013543-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is a follow up of below patch from Avihai as a replacement:

https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/

It allows all misc.h exported helpers to be used for the whole VM
lifecycle, so as to never crash QEMU with freed migration objects.

I did also add some comments explaining lock requirements for using the
helpers, which used to be ambiguous.  Hopefully that clarify things too.

Thanks,

Peter Xu (2):
  migration: Make all helpers in misc.h safe to use without migration
  migration: Unexport dirty_bitmap_mig_init() in misc.h

 include/migration/misc.h | 36 ++++++++++++++++++++++++++++--------
 migration/migration.h    |  4 ++++
 migration/migration.c    | 22 +++++++++++++++++++++-
 3 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.45.0


