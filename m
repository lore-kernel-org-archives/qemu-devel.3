Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3769C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYw-00024W-D3; Sun, 01 Jun 2025 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYp-00020I-Eu
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYo-0004cK-2V
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V57bXBa/NJD+DZ1mz9DxqFOQwYrQd//dPwL/338ok+k=;
 b=c/MOnOrjy1BX+hFJPLbY8mOF2yenMLIlanelw/YV6tB9xvkxFLickBtbVpkjXLCk61s1ZY
 mPh7Am6IiNGSaNFP23mMW/xF2bicDvxvahxrNoFGfXQJCgDAh0Rl4dxuWRBu1PG+u+qD2S
 HVGlesGhqtFn4sexgWYLqIjDLqKVT7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-6k-3SxwUMHiP3AIYL6VDXQ-1; Sun, 01 Jun 2025 11:25:16 -0400
X-MC-Unique: 6k-3SxwUMHiP3AIYL6VDXQ-1
X-Mimecast-MFC-AGG-ID: 6k-3SxwUMHiP3AIYL6VDXQ_1748791515
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so4823335e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791514; x=1749396314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V57bXBa/NJD+DZ1mz9DxqFOQwYrQd//dPwL/338ok+k=;
 b=sjhYTXhAKWZ6xSbNX2KwUMG6XiLrGXl7xd6ogPy7oiq/XPCYV+O86dmFggHGlK/h6V
 NkpuNc7zg5sNvCXn0ce5604l9WJ+90WOSfb/8RGRGjXT3fh3NGj8Of369lVJjp4dSIeC
 DQ1+FIygVScM2kZFNIJgGIEUYSFZDb+7iJZRFxWltyzzYsCij7EpNAzwVrSJ7P6RN9cm
 1UiTGbFwuBgkqPgnB5dhapJfQwjIHB/A4cNZ/2XsE5e1lQrnSBBsFEA+1gtEbcxTeexJ
 glSHPqtz7XGp7jL9i8rVg01aufmr115Ezs7O8PBPJpJqHnrXwb22x+cmVBnLyCRTkXOG
 y8SA==
X-Gm-Message-State: AOJu0Yw9WjXqqjeleU946QEEDmQGyfJYEMleEDz60jU0eTWmYBbm5ETf
 /swictV+LJwkk8etDWaA65XTJRdgZlRJARguDAYRejNE5a0PQ0Z5Zx1tiDcO4mjpu7i4VMb2rdg
 hOONQwjxOHzkdsC93+/6eU8TJwJwM45ME4G2umOTWGQ9qZHOxDtQaJdA+5ojjQIvAbXkZMjHj77
 B+sG8eZqM7HGgycTkO80FX+z0xgnT0CUJ0kw==
X-Gm-Gg: ASbGncsHYntx/V6Lw7TSDdEztJC+HxAZldGI56R1KrHFh9MVBB6C7HudmlLwqN/G+11
 x5Kb3oQ0d+a7uV0kF4Ts80GZ7vn6RYMXj1ZDaJL5oIpwkJhO9xtAl3NXgV7vnQK8dLNsSXs/Hx0
 U418+nYtZFN22Yfysqc/T8Fi5G7GZiJcgRUOP5Ck+sfmvlXrywytqo+BRBo4xXo77EY7dkyHFfK
 oJ5D9Xq+fPTvr2nPN4coRly68SXeEass1hCTPzw+6X8mMcxGFK4yawvOOhT30gGDlhDjCUfQIwu
 qQr+Fg==
X-Received: by 2002:a05:600c:4711:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-450d6533b86mr102794445e9.16.1748791514290; 
 Sun, 01 Jun 2025 08:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9CwCKb258FusvueO+hapmr2ms1xdUB60Y0rCUDWlNnSfmvWLJ7l9kOymMYncq8kCoaUxOw==
X-Received: by 2002:a05:600c:4711:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-450d6533b86mr102794235e9.16.1748791513893; 
 Sun, 01 Jun 2025 08:25:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000f3esm88939575e9.23.2025.06.01.08.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:13 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/31] memory: Store user data pointer in the IOMMU notifiers
Message-ID: <7e94e45296d68982d448ae57e195efcf8f66649e.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

This will help developers of ATS-capable devices to track a state.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-9-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/system/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..fc35a0dcad 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -183,6 +183,7 @@ struct IOMMUNotifier {
     hwaddr start;
     hwaddr end;
     int iommu_idx;
+    void *opaque;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
-- 
MST


