Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE47C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORx-0003UC-CG; Tue, 04 Jun 2024 03:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORw-0003SA-32
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORu-0005f7-DU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCpaT2bnUFA6x8rHRoclpeCn7PmIy3X6pqFoqtygESw=;
 b=Del/ih8iKfEPiq9DfG6xRow8KN2FUaJTdY3VFyQ/YBaniQPZY/1YBfQqTDPKUkJgwXtkIR
 CEnfNzwWjE8d/gqG9hGA5gcaHkA5QSAJ7DwoAOguU+mcBdZnIueJ5CocBr1gEb4ES1GYDg
 O2OcBpV+vTFwGMm6+7SUfrVGkPOawKI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-PTHoBow0Ot-vOrveUVg6iw-1; Tue, 04 Jun 2024 03:19:10 -0400
X-MC-Unique: PTHoBow0Ot-vOrveUVg6iw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68ce1ac733so131341166b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485548; x=1718090348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCpaT2bnUFA6x8rHRoclpeCn7PmIy3X6pqFoqtygESw=;
 b=rjrG40Mo9xtdhVzkjgRoQOTPjKC0zNVSEfRrvAGjxpip8/dcFvxUKALZ/NYp25G1bg
 spE2dQjXGOK75rvn3J0fE0W2dF42PqMqYKWUpOyWql4ux4n/vmwcdBo9/Vq1frvi9ANT
 OrIQGorzh+sE2ugwhiPq0fQ9jgHbT2OJjJbZaobbQ9GSjHNEsHJV2jUPjYJhAJaQpYtu
 s8esD73409VsphxbJyUg/DUVuE1LE3ucTwAMPZ6FeY0FsalMmzHIk5iXBY5P7b2n3IWv
 /T06vgdkWwVZc+mh3GbeaAcpB7sXXerCK/9iYqkge+tJd6R4pDH6sYsQ86nV45anCXNU
 C0YA==
X-Gm-Message-State: AOJu0YwUbX1DzpsbhHUF4J6jb2Mxx03pdFvT+E5JQusUxQJjiyObvNIt
 sREW0f41YcJQdprnMiz/0flSUbuiU8zfn94rUb9lQEBTZxhbXBaQzuEp/QupaiUWD1SFeFegxVm
 WR3aPkfG5qX1iS+oT7XGvq+xUmlX6Z/ReoIR1aBzNEo1RD1tT//bZI01YpodlFJIJEDGdGic69N
 9fi3DFszzUmF2HUup2fcwyN9pEzRPxdLdEwEkt
X-Received: by 2002:a17:906:fcb5:b0:a68:bd86:bc7c with SMTP id
 a640c23a62f3a-a68bd86c3b9mr478160566b.14.1717485548596; 
 Tue, 04 Jun 2024 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVZEq2jBNSX29dg7vxQjGg9fkdmXnO5CcO2BShBZ9Q0fIGKQVQuQNa70xvmHDXWBbIrAhKjg==
X-Received: by 2002:a17:906:fcb5:b0:a68:bd86:bc7c with SMTP id
 a640c23a62f3a-a68bd86c3b9mr478159266b.14.1717485548208; 
 Tue, 04 Jun 2024 00:19:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a690f020b9bsm246164066b.140.2024.06.04.00.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:19:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 10/11] target/i386: document incorrect semantics of watchpoint
 following MOV/POP SS
Date: Tue,  4 Jun 2024 09:18:32 +0200
Message-ID: <20240604071833.962574-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/bpt_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/tcg/sysemu/bpt_helper.c b/target/i386/tcg/sysemu/bpt_helper.c
index c1d5fce250c..b29acf41c38 100644
--- a/target/i386/tcg/sysemu/bpt_helper.c
+++ b/target/i386/tcg/sysemu/bpt_helper.c
@@ -215,6 +215,12 @@ void breakpoint_handler(CPUState *cs)
         if (cs->watchpoint_hit->flags & BP_CPU) {
             cs->watchpoint_hit = NULL;
             if (check_hw_breakpoints(env, false)) {
+                /*
+                 * FIXME: #DB should be delayed by one instruction if
+                 * INHIBIT_IRQ is set (STI cannot trigger a watchpoint).
+                 * The delayed #DB should also fuse with one generated
+                 * by ICEBP (aka INT1).
+                 */
                 raise_exception(env, EXCP01_DB);
             } else {
                 cpu_loop_exit_noexc(cs);
-- 
2.45.1


