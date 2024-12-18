Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF6BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhr-0000mq-5c; Wed, 18 Dec 2024 05:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhp-0000lh-5Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhn-0006qq-7C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jzX2pyO/iqHI0cjENwYLEKZ3ZU6j0kw5XT1+VOMzPg=;
 b=BWtEpBBewq98msbsny2AYNjC3Sflz6Rpg50fpq8ii5KJKdy9jOMsYZe4HpBKxWc9oVfuGk
 mNsM3W3AphNorGcvDiTcdqGOhOZKIjYAsL/kpwQuFl1LIUDdyoNuTuURzqUdUUnx1D2glm
 NB6fx/Jt9F0Egt6SeD1gwLOxZ9ICYSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-_4-4_-v-Piu2l-r7D0tT5A-1; Wed, 18 Dec 2024 05:53:36 -0500
X-MC-Unique: _4-4_-v-Piu2l-r7D0tT5A-1
X-Mimecast-MFC-AGG-ID: _4-4_-v-Piu2l-r7D0tT5A
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362b9c1641so27884155e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519216; x=1735124016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jzX2pyO/iqHI0cjENwYLEKZ3ZU6j0kw5XT1+VOMzPg=;
 b=sm7kb9OelrL+8HkA+wrl96N3V8J+rlNRZhGwowG4TmJ/EV1tseE5mwSz/PV1Q3HhkM
 arOCPEyRWsVjeM4zyYgFkpoAPTq0Gtr2S72Xheahy89NOg5b2I02MjqL1tTsfMwYb6Qh
 nQEiQa7YP6f41TAJj+yDMz388sxEFaO5i1oKt/A5LsPidYxikpElxHYejmtL3ePbCJ11
 xM4k3QOifzVdoXtVEBOJTyqp+sio6mG6MgSgj23RUO/kk0A+nISUWEpfV2fnSJ+ynjnA
 10iFiHt6xmC9/4Ztf0Tjl8ZTCT415oDCudNqZPNFYGzNuTjOZYd5tICr1zH0ern1lzjf
 5Bjg==
X-Gm-Message-State: AOJu0YxScXJPK1fa1hJSIZm252dVmOaqcgGa/+YTtzFRbbN1iBedfZnS
 qemAG/h24rvO7xY8MlbNvzWj9Q/zUr8Yi3i97pm2QU40hUZP1xXtrXTALCPB4JG68Tn7mK1V6if
 sI8mxCzCp+zp8vWjIDmrWTEF/iIO3BN47YVScI3Vi+oED0PhEmNqIqlPukpoo9i3b8LxLMpUjP6
 +jl2/2UfUz+jXeyW6WaOrlnjt0aJyjrvWNk2M=
X-Gm-Gg: ASbGncszFuG5ccEiu3apw4saAxrZxpvE2aRzT1/xRWypum4uy1o0woifWzt1YyZx45U
 4oJsV4OrMF/FMwhxmpfztOl5cQS+m+NniNyA2mxEfz+QyBUMn5OKKLxZsFoXMRWDvwAc8S2lU6T
 c+9marESBjTeiHXVbpzxVJ23P5lsM+E/U4jzzWTzi1GZxzZypS3RsCZXkrty0DjKXd+fn+nxzch
 xFA4KhCN+5mQHVb2wTmsprdXxX0Mx3C7XxQF5epx02N+sBMHyKTUDcOeIOK7Se3DAKUzbQN00uP
 rtvZtdwPiaS3jxv65Dj6pcQ6p02SnjFReNgU0Q5wdQ==
X-Received: by 2002:a05:600c:4f14:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-4365535fe63mr20045045e9.9.1734519215758; 
 Wed, 18 Dec 2024 02:53:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlycrOknbfAPHpV3mL2rVWzzSXJoEXGLBTlnTJeXlmduzWviJD86gsYpPZfSZJtT41UWv8uA==
X-Received: by 2002:a05:600c:4f14:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-4365535fe63mr20044745e9.9.1734519215384; 
 Wed, 18 Dec 2024 02:53:35 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-388c8060fb3sm13556545f8f.94.2024.12.18.02.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:34 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 12/15] s390x/pv: prepare for memory devices
Date: Wed, 18 Dec 2024 11:53:00 +0100
Message-ID: <20241218105303.1966303-13-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Let's avoid checking for the maxram_size, and instead rely on the memory
limit determined in s390_memory_init(), that might be larger than
maxram_size, for example due to alignment purposes.

This check now correctly mimics what the kernel will check in
kvm_s390_pv_set_aside(), whereby a VM <= 2 GiB VM would end up using
a segment type ASCE.

Message-ID: <20241008105455.2302628-12-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm/pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 424cce75ca..fa66607e7b 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
      * If the feature is not present or if the VM is not larger than 2 GiB,
      * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
      */
-    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
+    if (s390_get_memory_limit(ms) <= 2 * GiB ||
         !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
         return false;
     }
-- 
2.47.1


