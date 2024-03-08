Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E850C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riemk-0005Gp-Qt; Fri, 08 Mar 2024 13:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riemj-0005GY-0D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riemh-0006Wd-Mp
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0rmMaJt4MALPwGW3i+DaPD4OmnBD3wO03Edu/ZWJ8Q=;
 b=FE4ryMavcyZ6916J4cggXQFDRK0pldo4TTNUdbTZZlSMhUxd2/qnfprEclQerFQNypGHo2
 W8dG5EtQMO8eYAzx5st6QIWUaxM6hC7F8e46Zfu+oAgya/dVLfd6NWBJApgkNVPFUQ02ua
 tGSqYDPA9ih8rn1LMHv3Y7+VPIelmMg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-vDmTjBYzNmKYQzbsAww_rQ-1; Fri, 08 Mar 2024 13:17:29 -0500
X-MC-Unique: vDmTjBYzNmKYQzbsAww_rQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-568375181b6so122545a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921541; x=1710526341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0rmMaJt4MALPwGW3i+DaPD4OmnBD3wO03Edu/ZWJ8Q=;
 b=snDXnMRLtkvRoRSD6ECFwiebHv8a97ffczmJ1JKwGdXyhgN5J098kbSgSRl+YHMgkJ
 Ws1y5GKNBMs8uDcsLuKeadePKD4CvMCZ1TtYoXe2vhcAlg9xfj+zb8JXlXLBP4k4P1cE
 n0U9hvdxr7gN+gM+aMkFSSwnHjn7YsbrQZQwDIL1J6x+y+Rs9zD9JTA4TxEGAohhVRgW
 trMPfYhPlOQkrADUnckBp66EzxvD9P2zjQeMfV3SRb3xBmgj4dmBijnqUB0m+iDBCII3
 7lCYYdHhd2983gQAZGuPYhQySZQ1hhntkNmyiOIqwLxUTnTbxkTRRszoOlRiWzDjxO//
 MuUA==
X-Gm-Message-State: AOJu0YzgdyWw4NXsgY1yPoE+bt2hVzoRdxs5ND0bBMz4zu4dhVnWeMz7
 ef3oJpvYJj6cUSt+sxL1O+qMYQUDjq2HXx6yauClMfk6yPp7TogEOf0QAOg+AMnTg/Xgn4WBYvp
 vR46HCPm5mFlWWAB86UaUjoThh99mvhEAg1c3c9EhDu2/+LtccDdKx5u36S7JIz0mLKZhqcLlW8
 MJkoFvOBgjFKK/uAJGBCL/F3ifQheqikH7zKPQ
X-Received: by 2002:a50:9513:0:b0:568:3362:cccd with SMTP id
 u19-20020a509513000000b005683362cccdmr40805eda.18.1709921541229; 
 Fri, 08 Mar 2024 10:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIX+EvfcKhby1K7uu2EGAt4ASAvNiB6e5c/doL/0Vyb/gRyefxKShNFntcuwMUtR051N/qvQ==
X-Received: by 2002:a50:9513:0:b0:568:3362:cccd with SMTP id
 u19-20020a509513000000b005683362cccdmr40796eda.18.1709921540948; 
 Fri, 08 Mar 2024 10:12:20 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 x25-20020aa7d6d9000000b005682aa466c0sm24090edr.29.2024.03.08.10.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Kanda <mark.kanda@oracle.com>
Subject: [PULL 6/9] oslib-posix: fix memory leak in touch_all_pages
Date: Fri,  8 Mar 2024 19:11:58 +0100
Message-ID: <20240308181202.617329-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

touch_all_pages() can return early, before creating threads.  In this case,
however, it leaks the MemsetContext that it has allocated at the
beginning of the function.

Reported by Coverity as CID 1534922.

Fixes: 04accf43df8 ("oslib-posix: initialize backend memory objects in parallel", 2024-02-06)
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c379f96c26..e76441695bd 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -467,11 +467,13 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
          * preallocating synchronously.
          */
         if (context->num_threads == 1 && !async) {
+            ret = 0;
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
-                return -errno;
+                ret = -errno;
             }
-            return 0;
+            g_free(context);
+            return ret;
         }
         touch_fn = do_madv_populate_write_pages;
     } else {
-- 
2.43.2


