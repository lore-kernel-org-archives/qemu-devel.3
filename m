Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A260703C1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=QRvJP9EJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1Ay-00073c-4O; Thu, 05 Nov 2026 12:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Aw-00072z-9O
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:58 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Au-0007g3-OH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so15705695e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899375; x=1794504175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rUHBBG2Y2pP08Lhunqks2CGSbRSyJYpgkO1393TgZeY=;
 b=QRvJP9EJ+qvhdw8KbuWn/a9w+K2UIKmea0nLXNupm2ANVm7FHAzhIkGgHTVzZeptSZ
 q6/RQ6Tqqr8eJ3v7VCl578Is0O4vq2rULT1Fox0oe2cBt/YZxzWr3FBkAriyN4UL+fQD
 k5iZlsUU1/D6G7ucsR18RUBxHb4dgmsHiyLe/l0xwj4tFrsxZo+1CZSXupmOexkMJolB
 QOT481D4zU07Wtuq50Z//oGgq/HOQ89b6Wlc4yNRCFFUVqkqQbZHAe+px3oPg4xZeZZA
 J658xdZ2bgSZIRpW4cKRKmdFmYjMc3xRoqv8Ktv55wH36+Oda/sPnbZMaBfOGVpyxHbR
 OHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899375; x=1794504175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rUHBBG2Y2pP08Lhunqks2CGSbRSyJYpgkO1393TgZeY=;
 b=LXuRd3MZOs7LVnQPrrpE6KaR4cIuUy8kZqromme8ylAjpmigYkVoJyWt95QmjCdqvA
 JwsFwdlNdPAMFH3D8uqDyt+v9UNnZ9CT/48JNcJts8DGsRigMUdvOOqmPbEMm9ZjeP31
 d9jgClen1526YJXyS9oHZM+UNoEkvSQwwMiKiITE0xev1yOFe5kwCCGNulu/0WDhz47H
 5ESVy/TY64uOlTz6PTwgIln6go+jladEui4YJC7KgP1RPocd1vlmQ0FYC3Al63Tnr9c8
 ZZUJNQ+9WlKPA1SAKErG4UK9vtWnR7OM3LzhibkE/MoEvUdamdJk1/X9je82XcQOwuZY
 NJIQ==
X-Gm-Message-State: APuU4Z9aQpjmnV+AzQVuJFovND7rGT74R+XPNNf6ZYUuFV/27h1TwMFH
 F3LdDu/6LQkHdGFkS2sAK7CYcS5YrSYfGF2ar3IfAn7lrwXOC6vGBUWVpz/Q8+2wU0zg2MbTVKz
 yWMCb
X-Gm-Gg: AYBFou04Ik4xMNgbxaYzdqvVAP9TcMOkKBs2a8Ll9yW0L7QyZ7OsTmuw0W8PxYWGfer
 m40E00Rg3u4uzPJCAkUew7sk9UyaCrmOLpOef5KHMyy+5UXgERgb9KryVpXyRjQwLFbStnjb2Rr
 6VO1jbFnQRGkcazi91lbDIJNpjHCt3+sLK5xlDe7QQAmypkAmSiXmN0JBwjk0TPZjiOVGHqf/9f
 uf5ha3+hK+IOGA112lG0pikBZdZyRg6MF44Fla+5UVWuLKHj1zyWzXqDxmUQOtfNmQMFg1Ku8aT
 rE3Mg62A4tJ1VAkboHvz0BYcI4Hb8hVGMEO5Psy1DMIPpB6E6VF12yJmZP8wVdsx3iV19cl9CA/
 tG0sDXisfYMpj1anRQBN+eGadNGlLVb5PGZx5PPpCaEuw+EaAkhq4gfh294/ARGCaC/3FaM61Q8
 Ts3vgUjG8VV/F0dnqc+p0u08S1s6W/a7624bWLl3SlWxR0oYmnrnOkmjhHx6rQJDsWHl0S37DbK
 S43mPQkF5YaNSgE3fz24tfgScFJpMmXW9TtcCN0kq830NkeOoI2ec3kCdq6kWykPKpIxuaU9t+c
 HhRW77u9DJH55llalr4WJh1JXQ==
X-Received: by 2002:a05:600c:a118:b0:4b6:b2cf:3088 with SMTP id
 5b1f17b1804b1-4b6b2cf3423mr4975835e9.14.1793899375347; 
 Thu, 05 Nov 2026 09:22:55 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:54 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 6/6] target/i386: batch the Hyper-V SynIC page remaps on
 load
Date: Thu,  5 Nov 2026 18:22:44 +0100
Message-ID: <20261105172244.2804598-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Restoring a guest which has programmed the SynIC maps its message and
event pages once per vCPU, and each map rebuilds the flatview, so the
cpu sections cost vCPU count times the number of regions in the
machine.

Keep restoring the control bit and page addresses in post_load, and
move only the mapping to post_load_mr_update. VMBus still finds the
control bit set when its post_load creates SINT routes, and nothing in
the load reaches the pages through the address space. The saving
scales with vCPU count.

CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
CC: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 target/i386/machine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index b5c6b127c9..ebfba102f8 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -863,16 +863,22 @@ static bool hyperv_synic_enable_needed(void *opaque)
 static int hyperv_synic_post_load(void *opaque, int version_id)
 {
     X86CPU *cpu = opaque;
-    hyperv_x86_synic_update(cpu);
+    hyperv_x86_synic_update_state(cpu);
     return 0;
 }
 
+static void hyperv_synic_post_load_mr_update(void *opaque)
+{
+    hyperv_x86_synic_update_mr(opaque);
+}
+
 static const VMStateDescription vmstate_msr_hyperv_synic = {
     .name = "cpu/msr_hyperv_synic",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_synic_enable_needed,
     .post_load = hyperv_synic_post_load,
+    .post_load_mr_update = hyperv_synic_post_load_mr_update,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
-- 
2.53.0


