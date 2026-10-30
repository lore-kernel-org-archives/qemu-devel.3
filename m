Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D3606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chaWEVIN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTtPvr3r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpvt-0004zv-HN; Fri, 30 Oct 2026 12:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xMpvm-0004zf-TQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xMpvk-0002hS-Qp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793379494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uMPSPrtNCbXLhmICPJKWwUUM3mrWnAnh89U7IW5m6X8=;
 b=chaWEVINO+1EPfBSV5jslyBcnij16F0bMrauzS9ds0aPeWGwATsXEiOYvZVPaLWBJT/DjN
 ff09pCwDCOX4hjo9jnu1cm99DBaM6eCOLmct8dr3S4ri74G5huCSuxsSLRTM6B4ul9x/WR
 j4a/DaLC3TuWIaXHg8jwWoXNgFTszwA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-G_qDONkqMy2vMfeLNvdCCg-1; Fri, 30 Oct 2026 12:58:10 -0400
X-MC-Unique: G_qDONkqMy2vMfeLNvdCCg-1
X-Mimecast-MFC-AGG-ID: G_qDONkqMy2vMfeLNvdCCg_1793379489
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a70b42bab0so10209445e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793379489; x=1793984289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uMPSPrtNCbXLhmICPJKWwUUM3mrWnAnh89U7IW5m6X8=;
 b=RTtPvr3reTvz9BL4YCprLoSZvkRqAHBBHrY/SKWLx+XIkJeQ2ru34JnZpwrC3Oi4rx
 EA5Nf2O15tGG6AWFtjbbU9ybKKXr21GacCJRtd+XRDCVQnpXZg4TjMUXA7fqPUb8WJ9r
 mxL4aZZhgJg6BF3Gp/X62kSQAsp0w6Jpe64d2GIfkET1KUGopKP01pHRXTHFtkq3h3lX
 +XxyY1Q7Zw0TuJdTuOA6VGkeNeIqPAWLwcar7x+m4gCcPT7PJhmCKawuP7s1tU4gJZxl
 9Ys2Rev3bNzDZ7TcSXu0XeGmy60FEctgXKKr8lmmxnDQthk+3MIKNTXtGdJk/OB/q8Ee
 RsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379489; x=1793984289;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uMPSPrtNCbXLhmICPJKWwUUM3mrWnAnh89U7IW5m6X8=;
 b=wBG3n3ZwQYaQCTkTlKKhb6EJw0n3Gd1XO7gxIsqtr/by04Zq9WVpMQty+nAvW2A5fm
 KuPpv6d15jyMRhS+rb4cp0mD5SzG+qdZmctdKrYqmAvfzIyEMDErl7VFcRqg0U5d2/ts
 eJeKIiR3ifN3GxbZrEs5u2ruIg2YL4KUhp8r2UeUjXHB4tBJKvFOjnEURAehmgskChwg
 Wpf4TFGTK/QMDljGfhpL+umnw9j3KxGnnRt/1fuSY6tNP9MmKoiB+UABn5IkuNT9Bi+A
 xIZm5+oJ/q9mLim0a37N7XN4pj3f9+c4R8qwhjxbmShchK6mw1pHaYKH2XagWcr/NvsZ
 +7Qw==
X-Gm-Message-State: AFq9FYKcjgH9h4DBZSOdpV9iU6KYtvv3DGOYAU/ktKdvhjLWqSvDN0bp
 pzREeiAuuFBEmZCvT/79e/7GqOC0T0gjlxNNI54jZTfsAsesbIvogPnR9+DbzcJKOQZuxQA/HzY
 T5/KmeC62P3BPFDoNbxQ5cpZWL76wTUHSixZRj0cdIh6BWbulqhMqWPjBmFms99mbYAmQRPayOd
 JpOqZm0+bAPGlUfdM0y2nPcmct4vd2MWso0dV9NMHaOA==
X-Gm-Gg: AYBFou01KIyY1ogcrkY4zK9vXQiWvnTKAEaPg28VPraHP5u8F3MqkBtJu3Vc3uMz+4v
 UqLwkjGtFn0wiF6BcaBx4NDyyWIyFRxPlsUmlVB5SGa/w2EYN4B+BYt79T+hUCIOXQqwAHv17/b
 q6q5b6muJV4xDKiphziHhsAOly3REW467DuXY8ph420LrbasN5+e9hBW60zIcequ/kuJ54vXSJ3
 9EOvdxf8rP8gIdkJiQA8iHYcDSqlBaQFaJc44ndn6BvhPVOMM5DTCKbzGp9v3MYZ1nTCFOnW8oA
 p6LZ3V/7zpC75+0Gdagq3JfS3/+KRxa96tlTxZWNdkmndRsDZ7wjJLJ2iJkKxXfSVVJMXBC8R8s
 s6IpIVovHTEqESGvcKpicABUeMOSyoYF9ssU4mKvqLccp4w==
X-Received: by 2002:a05:600c:8b48:b0:4a8:a341:2377 with SMTP id
 5b1f17b1804b1-4ac16acd9d1mr67269115e9.3.1793379489320; 
 Fri, 30 Oct 2026 09:58:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8b48:b0:4a8:a341:2377 with SMTP id
 5b1f17b1804b1-4ac16acd9d1mr67268855e9.3.1793379488948; 
 Fri, 30 Oct 2026 09:58:08 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm166141075e9.11.2026.10.30.09.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:08 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Tommaso Califano <tcalifano@redhat.com>
Subject: [PATCH 0/2] hw/usb/dev-storage: fix hang with CSW queued behind the
 data TD
Date: Fri, 30 Oct 2026 17:58:04 +0100
Message-ID: <20261030165807.79423-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes a hang in the usb-storage device that triggers when the data
phase of a READ command fits into a single bulk-IN transfer and the CSW is
queued behind the data packet before the disk read completes.

In that scenario the SCSI request completes synchronously from inside
usb_msd_copy_data(), so usb_packet_complete() processes the CSW packet queued
behind the data transfer while usb_msd_command_complete() is still running,
before it clears s->req. The device takes the "still in flight" branch, parks
the CSW again with USB_RET_ASYNC, and nothing ever completes it: the device
deadlocks.

The fix moves the s->req release to the top of usb_msd_command_complete().

Patch 2, from Junjie Cao, adds an xHCI qtest that reproduces the same
scheduling (data TD + CSW TD on the bulk IN ring, single doorbell, read held in
flight with a blkdebug breakpoint) and reproduces the hang without the fix.

Fixes: db4be873d312 ("usb: maintain async packet list per endpoint")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4658
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>

Junjie Cao (1):
  tests/qtest/usb-hcd-xhci: test a CSW TD queued behind the data TD

Tommaso Califano (1):
  hw/usb/dev-storage: fix hang with CSW queued behind the data TD

 hw/usb/dev-storage.c            | 10 +++-
 tests/qtest/usb-hcd-xhci-test.c | 89 +++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.56.0


