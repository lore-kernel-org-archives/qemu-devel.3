Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B7EC88E59
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBl-0000nd-6p; Fri, 11 Sep 2026 05:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBN-0007ye-G7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBL-0008Vx-VO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oztlL0t0JZ8ezWj98qmIsDqrr8kTq2UUhazLUKK+7WQ=;
 b=LASEOESDKsYyHqAAZ5rwyWne9ABOse3jNKmE+jf5TCWmp7s7c1Kc3/uFNETs+DEQ+uBU/V
 YvbkhlGQR2orCEeuo1s4bblRHMTiH7SCgc04S8R7GZt46nyIGTUKhEysAc06/2ugEO5O7C
 5FUw42yjq30U13so30hK87kIE/LrrDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-zsm7V7omNduBTucJqiPaJg-1; Fri, 11 Sep 2026 05:04:25 -0400
X-MC-Unique: zsm7V7omNduBTucJqiPaJg-1
X-Mimecast-MFC-AGG-ID: zsm7V7omNduBTucJqiPaJg_1789117464
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso11798325e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117464; x=1789722264; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oztlL0t0JZ8ezWj98qmIsDqrr8kTq2UUhazLUKK+7WQ=;
 b=Ikco2GRT26Upo9vFhVoxhuDFXPU+kvTZyPNtwD4cQ3QFEoG9am5n0xWG9uyvQU8a0F
 kD4UNGChs9RCJEVdwlvhmLR/10idqA5HfelF4O2VgpfIZ0DfWb+xoQd4OFRlpFrF/bVh
 M+3pIyk5tCfsEHfBwaWPLjbF5ZN9r2Qs+Y5GCUd6Ampbi0aa7Owljg3tbSW/TfT68nwQ
 iSm5OVrWlrciaeXBgiqRsIWCvZbxR6SeFMga7Dpe+oIh5w1e1A52owZAe8JjH9knovLR
 A/VGzmzm3ZjfYIwzi6EEVtZPbNe1/ZbzKoPuJKN+iwu8Q462dIJqXKkDt1gws1Fs20DM
 CsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117464; x=1789722264;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oztlL0t0JZ8ezWj98qmIsDqrr8kTq2UUhazLUKK+7WQ=;
 b=NfEdPT9x2XqssRzDm2fR3IK9E+lw5LBRneFwOUT4HVfguseHTeRA2qev7sRbeq1kl5
 tKyZmwcmbduR0fiXQ9MnMwZ2SVvJ0pbSgYeRy2h5kBY2ybjIR5paz5e9TrbX30/Iiiuj
 i6MpobuDN85iMEXQan3zHU5hQ47O1d5/q3kqPonrzlxq3rm2VNEv6t2C7UxFSHRkYeG3
 qLfVQNPIK1b7o+0iLcF9h74PNNRbQTrFm45ARExumb/PQfWPMhIdXbSfmdQ9mkbZxZbC
 slLBU03LmJBGimh4VIfZ1wSX9ApbGmrNlyGHOVNCrpYtVy2wPEhIfQWUXgaWO41KLVtE
 XZ9w==
X-Gm-Message-State: AFuF++kEyat01bYTszUXZyvkeLgG+2tANXTvEaGHi6GDvOYiPa/yAgbM
 t9aH4VhiygsLivnSngKXuoJlvP05tn1Ztda03rP7C/a1cnl6QSLVYET8jnqnyd1JYPSdjtjgd5R
 uQqZRYPiSams76wYOmwAhS/H5IIR2XPJG4aFps6WBsRuyCy4R8O/TDJ0VeYF6JScCd/qc0JXxZE
 pTzJ7GGesFDdnhlAQoIcFFooOv6GAHRvptnA==
X-Gm-Gg: AYBFou3jCq7xm+j5H3R4HGB/ga1sPD863IJawXziolOBq8Yk/RZsSCaBrySAyBTVXuY
 UrY2bkKG/H7DODceoxdspvCaw494j/d77J0Z9nRAinnaOVstkI/z9FHU/5zur3YKazLN1wYAEtc
 C1a2yNDNKgliYxVX1UQ+WzK7YC+OezuQ1MYvW4zgF0vMvolFfEZvS3lzUfxDY+t+MhuGilxn9DN
 ebAHTSenJxRHqi5uS95a84UT8yaEMJ3uPnO7H6CYIdxOCG3k1bhF0GJu+yla/ixvioux+K7OL1A
 1hZ1JH06fogRMjQcY90MXqLS3NqQaZK0/52bqDIj0bxOGOiiR/SJAF7G+aeJKJJ1YJXmTN6K9Zj
 PGmkEBx8DdT0fwoTWlF2ERd4=
X-Received: by 2002:a05:600d:849b:20b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e61082867mr29138595e9.11.1789117464345; 
 Fri, 11 Sep 2026 02:04:24 -0700 (PDT)
X-Received: by 2002:a05:600d:849b:20b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e61082867mr29138055e9.11.1789117463833; 
 Fri, 11 Sep 2026 02:04:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60abab54sm60681385e9.5.2026.09.11.02.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:23 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL v2 75/75] MAINTAINERS: add Junjie Cao as CXL reviewer
Message-ID: <2f8991c0b9c400f55897849a538580039b61865a.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

I have been reviewing, testing and contributing to hw/cxl for the past
few months, and would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260908042310.493882-1-junjie.cao@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec313c3259..d5eac4b42d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3334,6 +3334,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
+R: Junjie Cao <junjie.cao@intel.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
-- 
MST


