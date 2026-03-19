Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009511091912
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IlT-00008G-Mp; Thu, 19 Mar 2026 15:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlS-000082-0M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:38 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlQ-0008Qb-CK
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b4fd681c2so1104111f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947434; x=1774552234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usTdj5QCO2BS7JbYt223RkU570yU80bsvLKdRRzFES0=;
 b=CKYkmoutwWRAqf7r5cvAJqp/ajKSL0SdtdLJY74FNRQQ+lcbUCWgGgkcUweqfVPcmj
 AjlQun+/mF4vwKlMa2mvf+hH06KHAiSJYD3ZI+ujHQ3TeMHhZMowb839L4mOvmVB6mRB
 8/ePkA0zFYyRBFhChXxPpOG1yN9/BRkMgRnkLWk9tJIfh1c37ig4wy27ddxr3z+eMEVw
 r/yNgFD+vlTrK8f7H3MR+JdrKcJ6/xLT3a6Q3geg75c/i9KFlsyzjBe0do3lWnEbaQNS
 PIottVeAJNZMNIv97Dkk3o6tta9yHVNxQiV9rqbTgRdMOf3AhfTaybaeANgUPcrfjCjB
 yNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947434; x=1774552234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=usTdj5QCO2BS7JbYt223RkU570yU80bsvLKdRRzFES0=;
 b=d8giiBw4lY8FKSm1zjEpnHX1R6iZ4SYQdJIInKEs2uejcefEYbM4up7Wwr9zIWMPzG
 dGNtlP5z02R9odzBVy1N0DZonLgg6kmNDZFyVvbBPY9KHHxZRHVhSLAQxdCP2kZoL9Dk
 Tzpko285GarqBbs9UmIV5JwhhE+I0Nm2MbKCUo02kpncYZpASF+Zew4kB9xqPJtaZujb
 dXbD/FE3GIAfQSwJDGsYmffDzGYlmSL66sOz5vVQVtTCPhA4pKGEX6Bmmgll0/NEpb4E
 kmNq4iYonrsZGbPcX9FNYR7xQ9oE4JwB2HXWvbe6196HRx5MFmaFUECEhq8VR4fNNh5w
 T1Xg==
X-Gm-Message-State: AOJu0YxmxIxGF5ajJ6mA3QUUVeGlB2yiWWlL7M0bRHtEPPFtOF4Eu+st
 7dJaNZXV1BaCxnK5/anDtbGykgNQxmsgVrpRnai/fotBuEl6nlLNaBBxzSVFWBG0t7thJucVfj2
 bFWTeWn8=
X-Gm-Gg: ATEYQzxY9Ts4Hd/euKdjhWeiPCecKtFFXqjeW+XHCHuozOHBlEmOtUmxcAnHnPObGUv
 BbbsCN+6AQQPMewIeVmUB10rHs1SevYR8hbakdYfZMH048mvBYF+xlNHTzxzC8oALPHHC/poubZ
 iHGPk6GXLZmIMhl1jWx8yn5+VEn9q0tmMtD5EizCrYi0I6IKcl/wqElu6u9i/QQgtocMKNEovVE
 qweQhJNkNwlcDdFLZpxIUj8DGB1RWlIU8O5MZUonv30qbjuUOYleJC1cXHKFuNgi9OszIOXTdMG
 sH/4s9Y4PMPD7/h5jQcdV+3zCFTNqOxdBj8Fpf/Z0bk0hh/YKWBfLoyu0Rr5sJal8z0O/iSqc8+
 bz6alZiHBK9qFc6U4bWdcBoyIKsxuw6xm8LLAmP+5Uik8er2sOeyU47LwxiTQvKkZk9CaXDNSNk
 z+qOKV9LG6JSRfX8exbOQ6hoE2ihti1dsJBYlIM3oN5GYkbhjwSvpDLN2qncd0zO/Cei25f2Sy
X-Received: by 2002:a05:6000:2f84:b0:43b:3d53:93ae with SMTP id
 ffacd0b85a97d-43b6423f844mr803015f8f.12.1773947434269; 
 Thu, 19 Mar 2026 12:10:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm601578f8f.26.2026.03.19.12.10.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:10:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 2/8] system/memory: Constify various AddressSpace
 arguments (checks)
Date: Thu, 19 Mar 2026 20:10:11 +0100
Message-ID: <20260319191017.12636-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 5 +++--
 system/physmem.c        | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d9..858dc40dc5f 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2829,7 +2829,8 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
+bool address_space_access_valid(const AddressSpace *as,
+                                hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
 /**
@@ -2839,7 +2840,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  * @as: #AddressSpace to be accessed
  * @addr: address within that address space
  */
-bool address_space_is_io(AddressSpace *as, hwaddr addr);
+bool address_space_is_io(const AddressSpace *as, hwaddr addr);
 
 /* address_space_map: map a physical memory region into a host virtual address
  *
diff --git a/system/physmem.c b/system/physmem.c
index 4e26f1a1d42..23ea6b69255 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3652,7 +3652,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
     return true;
 }
 
-bool address_space_access_valid(AddressSpace *as, hwaddr addr,
+bool address_space_access_valid(const AddressSpace *as, hwaddr addr,
                                 hwaddr len, bool is_write,
                                 MemTxAttrs attrs)
 {
@@ -3663,7 +3663,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
     return flatview_access_valid(fv, addr, len, is_write, attrs);
 }
 
-bool address_space_is_io(AddressSpace *as, hwaddr addr)
+bool address_space_is_io(const AddressSpace *as, hwaddr addr)
 {
     MemoryRegion *mr;
 
-- 
2.53.0


