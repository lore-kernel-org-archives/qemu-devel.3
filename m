Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B274C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwc-00081M-LW; Sun, 09 Mar 2025 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwa-00080H-RG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwZ-00040M-Dx
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAGa/1zAiQKppBasu/YtxlNDeSsZyMqPAmmwgiPHU8k=;
 b=H2xM+jc/t9jCkKmsw3A1dNrBzjMHfPXOL5mKDq08N2nueGSK4GlmK91EzwRSn93kufLTX6
 xkB9btr+rbLpRzqtx/54CYBb3JVeudxLvCy7WV5u2TJMljveYSee+9soSyafXovy/iTzjT
 pB95uPBzYKiSq9CrafsTX2PEojYtt2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-_KOHpi6HPxygD5QJ6_A7TA-1; Sun, 09 Mar 2025 06:31:36 -0400
X-MC-Unique: _KOHpi6HPxygD5QJ6_A7TA-1
X-Mimecast-MFC-AGG-ID: _KOHpi6HPxygD5QJ6_A7TA_1741516295
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso986925e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516295; x=1742121095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAGa/1zAiQKppBasu/YtxlNDeSsZyMqPAmmwgiPHU8k=;
 b=pipD/3qzXI6Yv6hLz3ZFOCspeiDdQ257vCmCVKOhCDN5pWnwnekiDzjnDoIqP5p82X
 7cf1JmnysyAzN4mUTu7AmUUGX3O2pB6uwtUehFlvehdy0M3nCHbUcMDeJwThNWg3+CLE
 OajIHWdMs+uAm1q8xx4/TMqpaIbBcvzxWZxJeA+tB2M12mTIZVR5ALTGtoDJUorsMo1y
 Pt+Hz08rNKaTWh5XBWqekdYmOQCM6OCFytFU15luGg4BLfOQwOcnXGJJZLwDoAX78tvS
 qHbMQNmPPAia1qBznuoNaGlZEDpdxy1+392Eg0v7ZnrBmet4jMVc1cjyFHsN45gmo7QJ
 Zm5g==
X-Gm-Message-State: AOJu0Ywf1IiWMn6JZzCnSlitI8ewdLjkzANmbpZFt86lez6XIQW/pupZ
 QmhZlbOhmfJcbMQeSo65TBd9gxiRJgD58wMlU6XOq8F9CKF1N+hL78W203+dW+be0EZzhiiE2dW
 uDQoJGfgRtvOOlDhbwq3IrWeCZs1z3kHyIJh17ANI4jjFQaqItWuCw5nuRvX33/ye3LhHGUygqq
 0KHc9qien/67sonlOHK6uktsYcqIKoVXgEG44HDI8=
X-Gm-Gg: ASbGncvSHBcgV6pcF4aqx9bmyAPHLRR+5bx+lccpOS70H0dGbG46yhEAc6Lg6Ngs+EH
 5kNOM7Qi71dPb17/7/6nU9ygFbR7YLN5cbfYNdRQdWIjxpk4fliSlSseohnHHxEa3ZLAoiYj851
 Sh6SnTkRR5JCY2jHlLwBOT5G0fOB22mncYP6Sn1AbIYDGglRRYkPtfLsbMG6/uMpJJe3pUPlkzj
 cPenHACM22oN+ZDnMI6H8Rvqe9/QS7/PPk2HNTzkxqKHwkFZjg4Zle1P0+mgNWogVLDEADX0FWa
 b++n/3KZQguqZ37TmJBSkw==
X-Received: by 2002:a05:600c:1d26:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-43cf597d965mr4130165e9.27.1741516294832; 
 Sun, 09 Mar 2025 03:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7J2vK48uHu/SyE8clHo8n5m1IDtVJBUbnFxAXVlukOpXGOEF0/8uDv84yaUwoY0fbFjO06A==
X-Received: by 2002:a05:600c:1d26:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-43cf597d965mr4130005e9.27.1741516294346; 
 Sun, 09 Mar 2025 03:31:34 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cec487fb2sm37825215e9.37.2025.03.09.03.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/25] rust: vmstate: add std::pin::Pin as transparent wrapper
Date: Sun,  9 Mar 2025 11:30:59 +0100
Message-ID: <20250309103120.1116448-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 24a4dc81e7f..1e7ba531e2a 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -330,6 +330,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
+impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 
-- 
2.48.1


