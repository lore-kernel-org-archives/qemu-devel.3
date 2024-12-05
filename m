Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7024EE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9WT-0005Qn-T0; Thu, 05 Dec 2024 05:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WR-0005Qb-V4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:51 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WQ-00030H-D9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:51 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7251abe0e69so785397b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396148; x=1734000948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tMqvex4RuMXL27s3iBwmhMpuv9eZ7sBnrBfQ8TBDz4=;
 b=iu0DCLzotKD9gLy/bhkZG9kRZ1Ae6pS0JTqbzf8S25CgJ/Olh40DO0kYjc010pd2oc
 DdSwXL3aLkP8CLe33uE9Qsb67Z9P8wXauqYbrunjwyPiw7QF4HW4xgwKuG/uzE7KppbB
 nOokg5bhkdTTuFyS8ymHQnMecbr5pewnFW9LkVHDHViDMT3jxy/lHJRngmhr3Ck/fVbt
 tPPojh6wnbFyicfos+XUijZALem568hkNOqdTZBNcmlVcohxGLg57IkBljhZpTraf8W9
 3kz55MYRg0HLSbhdPg4LPyPd+XsgnkZFbnG47WARZbY3++9PTfnsxwn+2u7orhwbL56Y
 Gjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396148; x=1734000948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tMqvex4RuMXL27s3iBwmhMpuv9eZ7sBnrBfQ8TBDz4=;
 b=cewu6Xv+3IgHXPy2FxubB3TQnEe77wXhrvfkPIlVkYrdrB9LaLKplk2TPLDOUNBEX0
 3agou5vemE9271ElTkxJmZftrvU0oDJayKjGqcLWYLxYpq/+tZTNnSqTEHF/oGn57ZgK
 hZzcO8n/qci+m0AOPrMJrVrUYr8rBclP2UD0+Hu8qSqVjxGyONsokVBuTDnMsx8Gl52w
 vil+/shNY2uyc6QmBx5/gew6ttZecvgQFzi+0+NaDIKQT0OR3XqKm4gCLNzv+sqFU+TP
 f9wMqlOrdPra/qlr0hG/QEvbzdhK/D1S/LHSiqxYPoNqF8VUm3yWTGrPfSArmEGh7sor
 8GNg==
X-Gm-Message-State: AOJu0YzgwmJRkGoAIC/scdr0z50taSXK2IB/avg3htG3cTrfkQ0TkaO3
 +dWI1PdHri1AhjoSJxhLHIGctljYV1/6h8+sM2pLV/c3d1mRq1bHmPL5vjhUIQ==
X-Gm-Gg: ASbGnctU9qGrSFzQArMZbWMpdVJWHtyVCkiTHiqJ16CQFIIJzpxdIMETWu8ADMmLdgg
 lFCFuovdW0J6rAmo4vogY4d8oZL06JcnX5qBwz6Pu88+2c6m1C2Ldebiy5G7xIL2cjDj/1Bw4DS
 1NqcSntXBN+UQsxO/2aGkEkJlUihyR9cxhRI0Q8dar9NASV1hbwvZ776o7CwjLgxjytV7vkyKSG
 afcGK7EngDSk8kXDa7gxsPxEwmkVhNIaDY1xOZG4NoXSKYmLDcaDYDVcA==
X-Google-Smtp-Source: AGHT+IGuBl5B3xYJCKb26/PT8A5rK7R/EKMrmjFbYf2cLJe6zSsF+2i2sxeAwY8T+RQW7k9qrhufKg==
X-Received: by 2002:a05:6a00:21c4:b0:71e:76ac:4fc4 with SMTP id
 d2e1a72fcca58-7257fcc65d4mr13594675b3a.21.1733396148531; 
 Thu, 05 Dec 2024 02:55:48 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:55:48 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 01/10] vfio/igd: remove unsupported device ids
Date: Thu,  5 Dec 2024 18:55:26 +0800
Message-ID: <20241205105535.30498-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since e433f208973f ("vfio/igd: return an invalid generation for unknown
devices"), the default return of igd_gen() was changed to unsupported.
There is no need to filter out those unsupported devices.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4047f4f071..6ba3045bf3 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -64,16 +64,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* Old, untested, unavailable, unknown */
-    case 0x0000:
-    case 0x2500:
-    case 0x2700:
-    case 0x2900:
-    case 0x2a00:
-    case 0x2e00:
-    case 0x3500:
-    case 0xa000:
-        return -1;
     /* SandyBridge, IvyBridge, ValleyView, Haswell */
     case 0x0100:
     case 0x0400:
-- 
2.45.2


