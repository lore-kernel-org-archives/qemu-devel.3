Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F9C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVbU-0002RH-S8; Thu, 01 May 2025 11:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAVbS-0002QU-Np
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAVbF-0001lF-Ae
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746112394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5vcLj8Vofr3mVe6p+qrpe3lxpLf1u4Vc+s2bwA73Lxs=;
 b=SDDRxwWlhknF32msii6v7A9lI7Cj90m0RxNv3iG6KrXzf3pjJ5r1rZKwA9zMliCFdPgPQx
 GRMxnNYplicxe6SLMYbX7h+4WOpGfz6Sm13dKav5MZvogAesUCehRMtG/EsFEDPVczRqab
 SE083raGMNgukt6vQDf0A+wkxnNOlyM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-UlzGMPRoMF2G2LDGbuBEQw-1; Thu, 01 May 2025 11:12:49 -0400
X-MC-Unique: UlzGMPRoMF2G2LDGbuBEQw-1
X-Mimecast-MFC-AGG-ID: UlzGMPRoMF2G2LDGbuBEQw_1746112365
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c0a3ff7e81so185232685a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112360; x=1746717160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5vcLj8Vofr3mVe6p+qrpe3lxpLf1u4Vc+s2bwA73Lxs=;
 b=rsr6lq3RQBZYFJ3GMt1eWFdQ/Juquf+hHZsnQNy8mtTRUG90SseY+F5wHe89DNFGHJ
 Ns3DcJ5U0VIswtvVrlCmnxe940yvIk6r2sUKnfuxLjB1hog+fgm6g5rMOrwc2aZ2QzEg
 SvId30xQZBu+QY+f4HuIgiSQsV9BwKsvsfXITkS8kAjPDSGkhiQEySqAXLPoIhyKwJ6z
 4oELyDdbyGPdfxAZbG3pMgExmspRxacGqausfRLOYegPpD9fY+yPidJfEwkUGuM6QBlh
 lxcUaY2kXnC1ptHyPKgts1TDJYFZiaZ+IhvmdS5wfyC1SOPqxPkaU8g4OkA4xaROaH+w
 MQGQ==
X-Gm-Message-State: AOJu0YwDbnaGeogQPhc25jU7CDsOKlJ37V9+blRoOyzjHtkGybdaA4A4
 jtJKmbNG0u4OPH5WrFS9qzf1QerBWo3yj+xrxZ5nE0YxLTRt9zodeu17gDNbVQUMKbFPEjsMWd7
 1rCVawsqeHAfJNEPSs4dFVAL/bsrroq8x0yS663PX2qZBp9Cg/0PI8Y8w679iyJw8x2GxjtJSJo
 gjm0JqNfvApdw8NMmqmRhQyY6IQgWfkjn7Bg==
X-Gm-Gg: ASbGncs+pBSkTBD9U7VCCc+jaf7ncr5f1x8jgCu1mAiVRj7x2tk3nSoIvJvNb9elC0D
 X0Vz2eQtWs+nAZhQ1lxoZXF0QoXqs4D1BGEYa8dN9Ux1A8M8ZLnQyt8qLRb2wj73EHo7xT32O9L
 wjsqvDpTEim2DuanDoK1HfOdMyFW9gc4TZorGfDTAMcF4PrbYJwpUFQY3MxDLelbgnJ5sM5LWNo
 Y+TjWyMWDiLnSstwfrDrG+hCevWeIE5vovlZhED3uBnWkC7f27CgA2YxmOfWkleASf/XUt7PSII
X-Received: by 2002:a05:622a:4107:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-48b208946c1mr35501641cf.17.1746112360434; 
 Thu, 01 May 2025 08:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXtkUB0wCHfT/V1L2TgqjcEz5I5kyvejJ0jeXNJ89L0t0/Op+B3WQcAkpi2qB188+mFmO6dA==
X-Received: by 2002:a05:622a:4107:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-48b208946c1mr35501231cf.17.1746112360034; 
 Thu, 01 May 2025 08:12:40 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b98c1a55asm4749031cf.70.2025.05.01.08.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 08:12:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] scripts/vmstate-static-checker.py: Add new hpet entry for
 num_timers
Date: Thu,  1 May 2025 11:12:35 -0400
Message-ID: <20250501151235.636709-1-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The old "num_timers" got a rename.  See commit 1433e38cc8 ("hpet: do not
overwrite properties on post_load") for more details.  Teach the script to
accept the new name.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/vmstate-static-checker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 25aca839a0..2335e25f94 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -91,6 +91,7 @@ def check_fields_match(name, s_field, d_field):
                       'mem_win_size', 'mig_mem_win_size',
                       'io_win_addr', 'mig_io_win_addr',
                       'io_win_size', 'mig_io_win_size'],
+        'hpet': ['num_timers', 'num_timers_save'],
     }
 
     if not name in changed_names:
-- 
2.48.1


