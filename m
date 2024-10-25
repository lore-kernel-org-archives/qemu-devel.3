Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F03D11707
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MmH-0001q2-Hh; Fri, 25 Oct 2024 12:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MmG-0001om-0l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MmE-0004pZ-KB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jVDymogFtNuVLT1QLTECiV9TKaEM7wWr4YXUEOhTmY=;
 b=VkqRujfB2lw/3soQYkkhZCRJYb4dWFtQTofCVXzJ5DAAa6pbILtBTyJSQ0ibwXIcsDJ5Ad
 XPmlpWPpibBSejJG+6kouKdF322CmhEOcEWjdvhLAZ/2meWYDNkXV3ExDTuQFF/wwa8r/T
 kQa42MhA6ZxfPTnzxbpE76cRtweY8j4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-nFehYEbfOteI1kwCn6qJeg-1; Fri, 25 Oct 2024 12:03:00 -0400
X-MC-Unique: nFehYEbfOteI1kwCn6qJeg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2fb5035169dso20398271fa.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872178; x=1730476978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jVDymogFtNuVLT1QLTECiV9TKaEM7wWr4YXUEOhTmY=;
 b=GyRcZFs3sd3nlMTsjRy1Y2t5CDCgUbhFmzZXseMiqCyS9nsEwenxK1QMVHhhSvrGcq
 uHIzA0UkXPzFkjIxFmDi0emMPTMXgJehfx1YWqtxpsGCRNf6YyF7RQzCEAJ3QOOTijkH
 nlR3HKX9427uydsZ9KYXbVijIQn2cnAePEbI88CCRDQPffZ9bCFqEGLvUWdH/rKufqFE
 DMsNpyQFEskUY3QO2ljIE6w6t/yOjXscfS000sbM48tlCE4aYr0vHM2astoD9S0OCDJv
 a4OvF0S+GHN66jPhK9ykiDq6//s+MUPvra2dkfdIz7LHqPpH3S9t3gIaMuNMaulxQPpH
 wHMA==
X-Gm-Message-State: AOJu0YzGaM4hYELlX98vJ91OB71Ob9f9nl3lYYsOqy8OvO4Fn4A4C1gU
 kWxrBXFY7FRmi2fRVaBcby5fAXdrIqMCdgepvVutnl3Oj/O7XJR88oYs/DWkoex5bM5QU7586/W
 r6sS0yaW9gFJbpvRhXsHWIEQ38EksXAC885t7dhsSn9DxLuJPH0Ng7JPcIlFhgqL2dHFhEbQqNr
 YwLqGb3p+e+cYcKN7D8gTZVucyRHQ+Uln7MLFmSH0=
X-Received: by 2002:a2e:b8c5:0:b0:2fb:3960:9671 with SMTP id
 38308e7fff4ca-2fc9d31a99bmr97521581fa.15.1729872177358; 
 Fri, 25 Oct 2024 09:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQUrUv9f0GtDtwEjkNavU5VZBRD5UB8MEcTlzGgKrp5gIfxBE8rhtDEevdwt+08r0o9gUCXw==
X-Received: by 2002:a2e:b8c5:0:b0:2fb:3960:9671 with SMTP id
 38308e7fff4ca-2fc9d31a99bmr97519301fa.15.1729872175334; 
 Fri, 25 Oct 2024 09:02:55 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f2971e8sm84354366b.125.2024.10.25.09.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 07/23] rust/pl011: Use correct masks for IBRD and FBRD
Date: Fri, 25 Oct 2024 18:01:52 +0200
Message-ID: <20241025160209.194307-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Port fix from commit cd247eae16ab1b9ce97fd34c000c1b883feeda45
"hw/char/pl011: Use correct masks for IBRD and FBRD"

Related issue: <https://gitlab.com/qemu-project/qemu/-/issues/2610>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-9-051e7a25b978@lin=
aro.org
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 98357db04e8..788b47203b1 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -19,10 +19,10 @@
 };
=20
 /// Integer Baud Rate Divider, `UARTIBRD`
-const IBRD_MASK: u32 =3D 0x3f;
+const IBRD_MASK: u32 =3D 0xffff;
=20
 /// Fractional Baud Rate Divider, `UARTFBRD`
-const FBRD_MASK: u32 =3D 0xffff;
+const FBRD_MASK: u32 =3D 0x3f;
=20
 const DATA_BREAK: u32 =3D 1 << 10;
=20
--=20
2.47.0


