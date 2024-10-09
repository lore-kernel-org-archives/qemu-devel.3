Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3FECEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1w-0004lV-UT; Wed, 09 Oct 2024 08:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1v-0004lL-KJ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1u-0005Uo-1d
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=152PJdeA3wUbcFf7AgEvngUKCcBOBZ12l6LmuLbUvrQ=;
 b=GtPtV7cSKor/u3I9P73IidbSWWWlG5XJvfxscaRLWxif+BmtU79oMmFNQU8AaR2yUA2ugu
 blMorkjCHpSIuc//4inGo2TFHPjeLNXcJCegz4mTAnc8iKeQZdzWE+snozxQcrpQ3Rdwox
 d+8uO2QYqTyGP9gl+TiGMmwsdrysPy0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-_vnbvDF1OSuzWJsqrO8ZVw-1; Wed, 09 Oct 2024 08:43:00 -0400
X-MC-Unique: _vnbvDF1OSuzWJsqrO8ZVw-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-82cf147a566so624968439f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477779; x=1729082579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=152PJdeA3wUbcFf7AgEvngUKCcBOBZ12l6LmuLbUvrQ=;
 b=lh5D3Tm3A7CohqZvR3NRQVQPGm6O1gVBci3UOcifoffmolHhRSheW43Ve1YqkoqAA9
 vW7Lt5ki6twHKKx5mYrx+60Be1veH4dIomVEZcIKShVTVIx/+9iUKo8xcX4q8g4wfgtL
 L4SCTUsdA6VDdSQ3/VsmAD+t1UWjtDgyXSrx91bAyoJU+RUOIt5GqE2KXTRAsgIi3cPU
 s8liZqzicpHitKcBhmNOT9MyU/m3UQTXrfnxfnnSD247wql3fZEHIwBkU93+FSEkNOf8
 exYI+xKGluGhi/DbgfCbbMsOFxrUAsyejCCncGSqdH5K6RjHrDmrNv15GE7BhDngUc8y
 6RxQ==
X-Gm-Message-State: AOJu0YzDa1Xx0rNn+JV25KlKpiGbAldgfp//VmQW9YNCCuxuw2pvkM7L
 SY1kfOvhVZnsRUeAzOpi06Pgy/XrDcyYNYvMdxHoA8dtQk9JHvJ5s9x5pKUMacLRRqk0w82wRFN
 7pAzmBR1GX9ng5ufcJMldbXWI86wKsJF7r81jPWVf8ChuYr1lDai4SbsRqSpfBJo7NvDV0wdq6q
 grj0unw25up4NuiZxU4lHokYKTCA8CRFMApg==
X-Received: by 2002:a05:6602:6424:b0:835:3957:4f7 with SMTP id
 ca18e2360f4ac-8353d5464d3mr253259139f.16.1728477778922; 
 Wed, 09 Oct 2024 05:42:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx71HISxuOWC3fSmpuC7qzDSSxBz883ofSayOmMXB/R/v2lDmP9hHbiJulzWiGt76U8f+1Pw==
X-Received: by 2002:a05:6602:6424:b0:835:3957:4f7 with SMTP id
 ca18e2360f4ac-8353d5464d3mr253256739f.16.1728477778472; 
 Wed, 09 Oct 2024 05:42:58 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 09/12] util/userfaultfd: Remove unused uffd_poll_events
Date: Wed,  9 Oct 2024 08:42:35 -0400
Message-ID: <20241009124238.371084-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

uffd_poll_events has been unused since it was added; it's also
just a wrapper around a plain old poll call, so doesn't add anything.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240919134626.166183-8-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/userfaultfd.h |  1 -
 util/userfaultfd.c         | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/qemu/userfaultfd.h b/include/qemu/userfaultfd.h
index 18a4314212..a1979308d7 100644
--- a/include/qemu/userfaultfd.h
+++ b/include/qemu/userfaultfd.h
@@ -39,7 +39,6 @@ int uffd_copy_page(int uffd_fd, void *dst_addr, void *src_addr,
 int uffd_zero_page(int uffd_fd, void *addr, uint64_t length, bool dont_wake);
 int uffd_wakeup(int uffd_fd, void *addr, uint64_t length);
 int uffd_read_events(int uffd_fd, struct uffd_msg *msgs, int count);
-bool uffd_poll_events(int uffd_fd, int tmo);
 
 #endif /* CONFIG_LINUX */
 
diff --git a/util/userfaultfd.c b/util/userfaultfd.c
index 518d5c3586..2396104f23 100644
--- a/util/userfaultfd.c
+++ b/util/userfaultfd.c
@@ -358,31 +358,3 @@ int uffd_read_events(int uffd_fd, struct uffd_msg *msgs, int count)
 
     return (int) (res / sizeof(struct uffd_msg));
 }
-
-/**
- * uffd_poll_events: poll UFFD file descriptor for read
- *
- * Returns true if events are available for read, false otherwise
- *
- * @uffd_fd: UFFD file descriptor
- * @tmo: timeout value
- */
-bool uffd_poll_events(int uffd_fd, int tmo)
-{
-    int res;
-    struct pollfd poll_fd = { .fd = uffd_fd, .events = POLLIN, .revents = 0 };
-
-    do {
-        res = poll(&poll_fd, 1, tmo);
-    } while (res < 0 && errno == EINTR);
-
-    if (res == 0) {
-        return false;
-    }
-    if (res < 0) {
-        error_report("uffd_poll_events() failed: errno=%i", errno);
-        return false;
-    }
-
-    return (poll_fd.revents & POLLIN) != 0;
-}
-- 
2.45.0


