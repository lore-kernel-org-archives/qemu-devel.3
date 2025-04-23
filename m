Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB766C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wbs-0004bL-2l; Wed, 23 Apr 2025 05:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbZ-0004BM-TR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbY-0008Ki-Ea
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wys6oGMBvfWbWyix7p7tJeGI8s6vQorlbbzSEr7OX2A=;
 b=eilO98Ci0JYwnHdHX/Gx2qiVPartBgy36bTBQcKiGjy7bY+G2SdNKsoTsj1a3ZkkcsrYkG
 YiRZf8fcTHAasKkmhbwqpZ1IzNgEm8xab1gR/yiAKhLKC55F45Wzusm8U2aNXgdBIi4MOz
 kmv91XOmCCt+UDQclcJasCC5qp7x32Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-w8YJDUFcMuG0zkUfM4Jn-Q-1; Wed, 23 Apr 2025 05:41:17 -0400
X-MC-Unique: w8YJDUFcMuG0zkUfM4Jn-Q-1
X-Mimecast-MFC-AGG-ID: w8YJDUFcMuG0zkUfM4Jn-Q_1745401276
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5f437158fe3so5709646a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401274; x=1746006074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wys6oGMBvfWbWyix7p7tJeGI8s6vQorlbbzSEr7OX2A=;
 b=SV9DesDhW0fW+glhp6790uX1C0fMWnHmqB+uUaep1aoz8BCJDmqhUB7cSfSMveDOk/
 999qD0rbyCuRk/MbbYeCBzXA9smtg93JKWipok17HEYJngqnIM5wiOSqR2RkvjdSBJXk
 7yxmkfSlzXNSO41GTvZwXgJG3ZHU90fqE9iDeyDdHS4eXNbdXSv6oaZjjoC9psbH44a5
 +K5fi+VphfubE9/fQ/NqqM+fUb9L2qkHpVOx0EQkEjz4xccr2y+d6JwhV+GQin8okDXj
 1DczZBzDiFeS6ycKFZEoqkccOyIxLVScjXs0Gk1Tw6Y2KVmlUYAyqKF+IU9hBHrQpT0B
 wNQA==
X-Gm-Message-State: AOJu0YyP5S0Rc1ifJb3V38SW9zbzD9cjZoYICs77qtPlpjiRbS87e8/J
 6UzotbZf2LSlfLEAmY0P8z34lslV64ypvsDOmNRzmR0LkaQxYVzo/kJB4cQ+jc1bqSdKm23uymg
 MIhlAfHSNF60hojNQ9Y2UG4MABJyRP2+9wJBt5jFfl1CnvHBeedSVHTc0AiyXUHuc5szYngmq7s
 DEJMElUad9630CeHGHBso5PZkjfmgYifgaMDuJ
X-Gm-Gg: ASbGncuF12cglnn5bGbyPjAdWlR/taPrdvC25BoCUxBLjl4zjffEEHCiiAa1oo/+FAW
 LFSvbfY0g3AP1KeZxk654FoBAZYpbPKCNUo60jJTk2IeCZ33DKYsHzi+n+xbaNpw8WnHes7OF1c
 qzcQHkmu1vG76vljptXB0IpXNfRHVCpmNHMNrsq8IQNNOmZlYtOobhNSq4fz5bZXmGYm2uvapJd
 df1W6gGZvtJsf+4s38e9B26ydnWHZEOH3x+shfqu5/n1p/54+zVijJKjbbBIoMtvJt6k2FPNa0I
 VCOIBRSZT4GF26/C
X-Received: by 2002:a05:6402:26d2:b0:5e5:ca1b:c425 with SMTP id
 4fb4d7f45d1cf-5f628563075mr17138896a12.17.1745401274425; 
 Wed, 23 Apr 2025 02:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFcxinhXq7dGZXWmOg43Lc5POU9GDBuaDhcnx86ISIA0OBK51Zgn2jw5gC4G6V2nlyU7+mgw==
X-Received: by 2002:a05:6402:26d2:b0:5e5:ca1b:c425 with SMTP id
 4fb4d7f45d1cf-5f628563075mr17138882a12.17.1745401274067; 
 Wed, 23 Apr 2025 02:41:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625833a6esm7222772a12.53.2025.04.23.02.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/34] target/i386/hvf: fix lflags_to_rflags
Date: Wed, 23 Apr 2025 11:40:34 +0200
Message-ID: <20250423094105.40692-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Clear the flags before adding in the ones computed from lflags.

Cc: Wei Liu <liuwe@linux.microsoft.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_flags.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 03d6de5efc3..fedc70a1b80 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -293,6 +293,7 @@ void set_SF(CPUX86State *env, bool val)
 
 void lflags_to_rflags(CPUX86State *env)
 {
+    env->eflags &= ~(CC_C|CC_P|CC_A|CC_Z|CC_S|CC_O);
     env->eflags |= get_CF(env) ? CC_C : 0;
     env->eflags |= get_PF(env) ? CC_P : 0;
     env->eflags |= get_AF(env) ? CC_A : 0;
-- 
2.49.0


