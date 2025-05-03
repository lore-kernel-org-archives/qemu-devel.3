Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECFAC369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mN-00085N-20; Sat, 03 May 2025 03:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mL-00085A-Ed
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mJ-0006eK-Jl
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+32hGB1MElkGs9fcz72cbTbA4s9aHx0U65cRvzJOLEc=;
 b=RDnbk/j7Vvp7PxR9dDlm7Ru9a6roZcGgkYVQI9cM+mPqmhrhB9ia6CwkiOI+IyC43hhNc1
 1avyT+Bi/xmp/VwnzdPUPg/p1kX4nx6rlZ+5kPsnP7T26GRedFcUUuT/4BHrTvpO3NhUCc
 ZNxljsHN2Z08XqwLko8IB6rkHhUFxvU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-QQQj4kfePIOpWbqwCzmZKg-1; Sat, 03 May 2025 03:59:17 -0400
X-MC-Unique: QQQj4kfePIOpWbqwCzmZKg-1
X-Mimecast-MFC-AGG-ID: QQQj4kfePIOpWbqwCzmZKg_1746259156
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso1513752f8f.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259155; x=1746863955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+32hGB1MElkGs9fcz72cbTbA4s9aHx0U65cRvzJOLEc=;
 b=f1yGnQ3W/r4aA+oi8LKqJi0h4VdaTlwEK5m9t9nYb2/ZQzwCVyaCs4u45KIRzZq4Fe
 2ceNFnKn7IPo2o9QDVh06h8obI1ejqQ3kfiKjhBjw1VtbqyXukdF8sGGQxlkrR4CMbl3
 LN5prdu158nvqWaRMNcLBwq7bamYmkSfj342j2W8w4lwiCm5Bq/YzZUUY+a5oHywqI8d
 ScOc7CdaN5IQC4+SeTwdWUnctPrcWAmAW2WF//teg9oWVrNhSVxMxCm6odnw9DDIOZbZ
 2vKRnfCmlX0DubTE8cAg/luKs8Qm4zLZG/JCDvLW0w+n1L03Sk0ZlgmdjQg35FJlq5OV
 WjCA==
X-Gm-Message-State: AOJu0Yy0LkDVVQFMcjprAswFMRwFMxLF11ngQ0IFsV44HE3WG1T0rZ2r
 X19Pm4Osz2kpc5Aqg+LFHWbT7yhSNlFXZRRV6IrUk3PylvDbwXVszf7CJ0un5PdY6DMnnv0V0pA
 zUMX7cYw8LEq4g61VZ5Vgl+M/uotJ4EB6AmprfMMaHnaXonRMLo3bHxz/VhMpGdAe1By1AB57aL
 Q1VZ7lacKrVVSHMAPgLt5WxyNprGniQIw75OG4
X-Gm-Gg: ASbGnct2Z6oaYxPv6ws5wjmjWBRXQFRosJXjDBoNnXawfc+n9uKIo+Wp3RAYrEUMX32
 vpBt6qDZmehz+bpGmN6WZ+ud3//eyoZs1Dvop80EcHWjDRKftTJLoIKWj1vBRsl/fNuYf8yAyiG
 mKVoBeUlqa4vW91QJzdA2/GoE5gC9ctYQpvo7lyBAMlQ4d0mkCHqPGg5EQkx4xjd7sIxWxA3rtu
 6yJwQplk+QkSp4yefpDRIljzUR/SN3lT9vNW1aR1BGUDEShnFPYgMHL7FcLAlHUe7LX1ZX8gJJ7
 uId21fwXacA+9Jc=
X-Received: by 2002:a05:600c:4f54:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-441bb84828bmr43674215e9.3.1746259154829; 
 Sat, 03 May 2025 00:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+xpnmBW4dPJ6A8g+dZeNSp8cTMUKULqKYhfqHe9uKXNilwh/CWvjKcf8WQT8wQ5kYwC/eA==
X-Received: by 2002:a05:600c:4f54:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-441bb84828bmr43674115e9.3.1746259154464; 
 Sat, 03 May 2025 00:59:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a3156asm67172705e9.38.2025.05.03.00.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/13] rust/timer: Define NANOSECONDS_PER_SECOND binding as u64
Date: Sat,  3 May 2025 09:58:50 +0200
Message-ID: <20250503075858.277375-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

NANOSECONDS_PER_SECOND is often used in operations with get_ns(), which
currently returns a u64.

Therefore, define a new NANOSECONDS_PER_SECOND binding is with u64 type
to eliminate unnecessary type conversions (from u32 to u64).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/timer.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index f0b04ef95d7..e769f8bc910 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -121,3 +121,5 @@ pub fn get_ns(&self) -> u64 {
 pub const CLOCK_VIRTUAL: ClockType = ClockType {
     id: QEMUClockType::QEMU_CLOCK_VIRTUAL,
 };
+
+pub const NANOSECONDS_PER_SECOND: u64 = 1000000000;
-- 
2.49.0


