Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC64EE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOMk-00052k-Cm; Wed, 11 Sep 2024 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOMh-0004tQ-Cz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOMf-00044c-9f
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7eWEC+J3I9Lev0M7HtiUi/IanEUkElHv0I4GaiCIw8=;
 b=eISEn2qVf62ZM2n5aB8zkDG75esudLUoEsfGXjIE/wtIlmAxURar5yHVvCEMHhOsaJ+G8s
 VHk5o9SRmp1zCpVt/T+U7Kh7AHyhFZing5eFtEXTII8SThdGZJ4b/4A2DEwQ8L10kKhrbM
 jD6aTv1pJ2iDxYnerS+eule4ZydXg1g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-RJmG23MwOHSOHOvb3rg9Qg-1; Wed, 11 Sep 2024 09:52:17 -0400
X-MC-Unique: RJmG23MwOHSOHOvb3rg9Qg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c25c45afb2so4829621a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062735; x=1726667535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7eWEC+J3I9Lev0M7HtiUi/IanEUkElHv0I4GaiCIw8=;
 b=ufvTDFT8p+uem6p/jSuqxLqNhECafJ0omcHXyLC9RKReXkD0ODlxlM5dG6QgCNLzed
 2Ty7OtTVdWfBArNqWHzNF17w9bpqLAjSPw6i9wNwRkA119tqrWsTnHYPt31pKLgpB2HD
 alB3YwVWjJK98L7YpaM4+f8zj9ZJEf4UpTpvp96M98iZw2QiGu6TTlx9mGGSTiWBhTkV
 ClylMeDGRNeXAx++Mzqk6J4z2zjogQEenTeOmZUDHjneR/J0ydX+ZTscqHFiniW99W1k
 MIvSjof5rmsQP5c5/B3J6K40mIcyBCrmIHiHHCIPrLVQGnfW/IcwmBrcVvBh6Wx96XCv
 CUvg==
X-Gm-Message-State: AOJu0YzxMOlEUki71X4br/AsIcSMp9flIeQEON2Q0xiqbUuzHAIedKpc
 yNx3kSu7kcZ21GNnGgvRBAhsYfSRUT6sX529W7eHpGbFy0sMlR5rtkdWs1uRVc0hYQ+OF2IN1br
 KEybP6AhESmn05rNzA3STt42iX0QocEnZDFS8CZPKWxCIYrn4QGyQxaSeE6+BB5MhB7DQnDfmK9
 gKIJvcNg3yiaucu0rXW8+UOsV/LyXSng==
X-Received: by 2002:a05:6402:528d:b0:5be:fd66:edf3 with SMTP id
 4fb4d7f45d1cf-5c3dc79b7a6mr12720156a12.18.1726062735419; 
 Wed, 11 Sep 2024 06:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzLNZKPzU44WOHzWzxWuIOTk/S6psIjrahnWH+D/HwRtJ/7DEgGqSrj3xM9gxcltyj57xeeA==
X-Received: by 2002:a05:6402:528d:b0:5be:fd66:edf3 with SMTP id
 4fb4d7f45d1cf-5c3dc79b7a6mr12720129a12.18.1726062734725; 
 Wed, 11 Sep 2024 06:52:14 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41be4sm5361685a12.18.2024.09.11.06.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:14 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 peng guo <engguopeng@buaa.edu.cn>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 15/18] hw/cxl: fix physical address field in get scan media
 results output
Message-ID: <d29b7f3dd4f95da7173b3f0fb58a7d4dbb093f92.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

From: peng guo <engguopeng@buaa.edu.cn>

When using the mailbox command get scan media results, the scan media
restart physical address field in the ouput palyload is not 64-byte
aligned.

This patch removed the error source of the restart physical address.

The Scan Media Restart Physical Address is the location from which the
host should restart the Scan Media operation. [5:0] bits are reserved.
Refer to CXL spec r3.1 Table 8-146

Fixes: 89b5cfcc31e6 ("hw/cxl: Add get scan media results cmd support")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/linux-cxl/20240819154206.16456-1-engguopeng@buaa.edu.cn/
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
Message-Id: <20240825102212.3871-1-engguopeng@buaa.edu.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3ebbd32e10..9258e48f95 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2076,7 +2076,7 @@ static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
 
         start = ROUND_DOWN(ent->start, 64ull);
         stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
-        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stq_le_p(&out->records[i].addr, start);
         stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
         i++;
 
-- 
MST


