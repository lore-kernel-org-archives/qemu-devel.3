Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FEEC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwy-0007zW-7q; Tue, 04 Jun 2024 02:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvY-0004OK-0a
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvU-0007b1-MG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+5YuaYqczcNUvBp8yw5yH3zRumXmt77AmFK67q+NU4=;
 b=i/ZbrBwwPKTZRO2PaEGlLmzBozPMfF0/lcx9xWC3utIsDcl1ownZ5JJrMbCfmeUrFK5uLO
 AZzScacPJueNURqVRruero+v+frzNxd0QGeN3rUSNTQ2xLmdsfP8q+5KbesW1P5p4XOmZd
 yWvjF4foJCHJBlopbIwpyJLUw8UN2FI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-NXqn4NDrNHuhJ7jlx4RzMw-1; Tue, 04 Jun 2024 02:45:42 -0400
X-MC-Unique: NXqn4NDrNHuhJ7jlx4RzMw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6905050583so97018166b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483541; x=1718088341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+5YuaYqczcNUvBp8yw5yH3zRumXmt77AmFK67q+NU4=;
 b=P/dLZbObOhDlmx2LsEBJ4TapKkpZnpxdYJ8iTUPY9hFYURmN8Bc3KMlmg0DO+fDSHc
 331FLxhoqPdlC6Dmeu/X/WIdWBoytbmDtkfVfwL69UwcWwG0w8ieKaREiB7AGoPUF87n
 2oRH2UKjt6k/+RVH46FUrHUv52/M2Zr+i5iP38uhN1xX8fJuObz4ZaIPVJqeGoObc9cx
 DKVI19yPlVvIvsdlSRKNWuOVIuEMbZMbf3v9nqk3RbGcKtopLIzkR2MnLa7vCYikgDhP
 YBWOwGK7uT15PoaGUI6aMJP134hEbE1J1KOx6684e6rcOPhLDJfj4fXHdXOl9euZZsca
 6RZw==
X-Gm-Message-State: AOJu0Yz9mtsxxB3CxbiSMkjVn0bWWtKB9JYKlujxtUcHHPFoK4hU3oMk
 GxJEMwZgYBUTK3dmV875ofrcKxlt8AACQIBaDFl5GbRWNxYEB0L4XJLlHzEElfkZn/w15SGhJgu
 o3NdW4dCCrJjHX8oXiZusAOzVsbs1PKDX5m8I57cfF3erSuMOJK0VEmMHUMeFqRS9Hp189xK20u
 8d/xAY5ISckDrnPCB6pxpTjeWpnSxf90bIpBP+
X-Received: by 2002:a17:906:6a15:b0:a68:f614:ce4f with SMTP id
 a640c23a62f3a-a68f614d046mr439978566b.21.1717483540779; 
 Mon, 03 Jun 2024 23:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcVM153EwFrp5U0WJ4kJY5b6Q698+fFJE8mRQT0XOIUpiFfoiK1/gwuIyQ8Mrss1H0M6PUiw==
X-Received: by 2002:a17:906:6a15:b0:a68:f614:ce4f with SMTP id
 a640c23a62f3a-a68f614d046mr439976866b.21.1717483540353; 
 Mon, 03 Jun 2024 23:45:40 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e7dc0f95sm364709966b.108.2024.06.03.23.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 31/45] i386/sev: Set CPU state to protected once SNP guest
 payload is finalized
Date: Tue,  4 Jun 2024 08:43:55 +0200
Message-ID: <20240604064409.957105-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

Once KVM_SNP_LAUNCH_FINISH is called the vCPU state is copied into the
vCPU's VMSA page and measured/encrypted. Any attempt to read/write CPU
state afterward will only be acting on the initial data and so are
effectively no-ops.

Set the vCPU state to protected at this point so that QEMU don't
continue trying to re-sync vCPU data during guest runtime.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-18-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index ef2e592ca76..e84e4395a53 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -997,6 +997,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
         exit(1);
     }
 
+    kvm_mark_guest_state_protected();
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
 
     /* add migration blocker */
-- 
2.45.1


