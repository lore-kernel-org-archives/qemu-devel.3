Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433C6C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDe-0000ki-0u; Wed, 14 Feb 2024 06:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDc-0000jl-J4
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDb-0006qU-7X
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7/1YIgENNn6T5ST2SQ++m3V36j5nIhY7SM7UOSEqks=;
 b=W0RHdvjy6E+xaFVfZ7ovjnGzYA+qCCuQ/pe+F21CURcFGPl5aZX9GuacE8WMd7IBLPrHDc
 uKloMnPaVVkFJB80jx78j8hjqAaUjijlWOwRjfqi7FA91xwbEfAP1u+J1Xgi7vBTEzT4lM
 Vysx4MMr+F+sxFPVMll3maSmYbfEGdM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-1ojCe2fGNKqBt0ZrSfiIug-1; Wed, 14 Feb 2024 06:14:20 -0500
X-MC-Unique: 1ojCe2fGNKqBt0ZrSfiIug-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3d3e8f1635so32560766b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909258; x=1708514058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7/1YIgENNn6T5ST2SQ++m3V36j5nIhY7SM7UOSEqks=;
 b=bgE/Pcqtg8qiBqEP8CbwMsFY22h/Oia11OVZ0R0NS92rL1L/VwaaZV0eQf/imCm7uH
 HxgWCL1HHIVLE2djTapz6+5Eq3/5efgFRhx+Aq93jW4KGhemtjwM9NnnZG0AUL1MUo3F
 sAyi1ayH/+I9N18aDOzzfay4WHhl/T25CtjSGg8oo+E15ZU9BXVQDezox5LGm4Ml1xxY
 S1s4dgAC2CV8fJDk9Vv16TCKHVUzC2Y6QEx5xScMszAe4B3mebwnV+L5CZpylhlD8/eP
 h8ovkci6sGlwAGxhB/C/6TyIo6HPVHqWGJ6sJhqd3WPr9XMFhfbE2UO0I071FEpMWHbv
 ybTQ==
X-Gm-Message-State: AOJu0Yzq/qydUNZONY7Jucv1GP/ISRJ0518RHLlSU51cqYERXSpO+o2f
 DEZys6ypYV0zhUuTP/0nGyresmGgemLvp3rtzaIVW80aGkaTcbz2croGHV6nbtc3dozmJGewLUF
 X4nbs3uK+IhorlcA1BCXKUJ5mCqbO3Y2gWxhBJzcw60MZ6Z3Hrscqq9nGLwrLYC0bJuQLeMOGU/
 6OprDBCVTMlSdxPJRnGXY7fCZeAI5a4w==
X-Received: by 2002:a17:906:4f0b:b0:a3c:7651:209e with SMTP id
 t11-20020a1709064f0b00b00a3c7651209emr1569141eju.19.1707909258776; 
 Wed, 14 Feb 2024 03:14:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlUivMwdUfkNOyrB5mJPxZRRZyG5wyqR9v0ySHCB/7gj15CNTVQDJcoglSlDT6Sgn8Yt9bTg==
X-Received: by 2002:a17:906:4f0b:b0:a3c:7651:209e with SMTP id
 t11-20020a1709064f0b00b00a3c7651209emr1569119eju.19.1707909258415; 
 Wed, 14 Feb 2024 03:14:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUBdWKDM7AE3wIqXkW7Xv5fgLZWtnrmO8/iuLtFveztewupLJv6jyYXWfW8OakQbEjqz0R0huLv1Oh2TW12E6FzkyxEIX8oZRwOPR4lj3wk/uGbGbGQt+Kts1Z7wZw0tY2EU/DmCxLBg6ZE/D3eNVgUckJOXC7pz8ZF4LTCzulZWr8eeJyhF/LYeqEO87LubcDq1W43f6uSa685Jnrf5yWwHfJpcCU=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 xa7-20020a170907b9c700b00a3d2490799fsm964986ejc.20.2024.02.14.03.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:17 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 19/60] hw/i386/x86: Reverse if statement
Message-ID: <f22f3a92eb728497dcd0f43e31b9148992db99bd.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The if statement currently uses double negation when executing the else branch.
So swap the branches and simplify the condition to make the code more
comprehensible.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240106132546.21248-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3d1bdd334e..505f64f89c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -520,10 +520,10 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     CPU_FOREACH(cs) {
         X86CPU *cpu = X86_CPU(cs);
 
-        if (!cpu->apic_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
-        } else {
+        if (cpu->apic_state) {
             apic_deliver_nmi(cpu->apic_state);
+        } else {
+            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
         }
     }
 }
-- 
MST


