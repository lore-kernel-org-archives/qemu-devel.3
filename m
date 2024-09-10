Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23182EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4qt-0003DK-3X; Tue, 10 Sep 2024 13:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qp-0002h9-Vb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:28 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qn-0004sq-R6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:27 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d88c0f8e79so4562967a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725990024; x=1726594824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxK/kUedWi76nv9Z4j6eZ6ETsIVX17z0F3roB87C/Q0=;
 b=sFSVBUQY5xCEoltEOz8AJzF+cm7OG1v+pU6x0db57yT9SfjpvXndcpCnzg3ih+yP/J
 4Du32UtzUcFa+JiLm4rGsxUPxnABM+VXGa6SLyz//CSeUiadp5l2MPMhn+3niXqTMGsm
 Y1OjGeCY8gyVegIIMCZt6m3Y4Vvioln7h6fT3KZvurMdudKR6db4K3brcgwERgxE9rUh
 BwBTd9MEF5xLDjUFFJ8TmQflOdVxYiXSyapq2nAugQzT6wlcWHzsff9z1W/X35P5ACsh
 08zrcpjrIHWtW4IT3SHtr1k8la4/+hNjvcfa/Q4MdvLV0XrONevNsFROnsa7IzUa+Cc8
 MYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725990024; x=1726594824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxK/kUedWi76nv9Z4j6eZ6ETsIVX17z0F3roB87C/Q0=;
 b=QIX7HMA/Mk/X6ODFiWiD6rfRkMOm5LUXntX0zYiq+uD7rnV9wmc+W+fOKEqEcKqVCB
 HZJQeUGbyYvkXdEJI0eOdqmjZZfpRePvlg7Ui2Q2jzZOUXZLPu3NVExqF4iHIS9ZJ57W
 ojuIkbAYIwqYVzq2qW1hcT3Tpy/B7cHkF2wAPiRsIGZw1v9mL7ZGH2jvUQbVOhox29DS
 XqFjacBmisEAHwbxSYxvj4JCtRSAaMWGnKnEVL61ETtkDTupr+r0xsw5hCrf1EuyqluM
 oe0lWSCOR+jAoytJBbxaInzaz3RsVegoX5nH8jJwHyfbd/IbGtwtxPzvMvkmhxKiVkhb
 /fkg==
X-Gm-Message-State: AOJu0Yy4uqPAmxPG8oPSp8gMQ2xO+K3zYrDqkkW2iD6ANnNs3qULZ5pI
 706S08SK7TS3etl3Y7VUD5suvM/+sOhFDPUbDCZgSGdEGSUkTKMXGSpzE9F86GJm3bd4RLvlbC9
 s0VvWEg==
X-Google-Smtp-Source: AGHT+IHIEh2gOaDV+kP/9BofpfisOSSU+8HsXyUxQbN5hvDsWwuXez7jJ9Dt81kkjIr+UHHAmLwAYg==
X-Received: by 2002:a17:90b:3c43:b0:2da:5156:1253 with SMTP id
 98e67ed59e1d1-2dad50141cbmr5998023a91.21.1725990024249; 
 Tue, 10 Sep 2024 10:40:24 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966d3asm6682751a91.38.2024.09.10.10.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:40:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 2/3] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
Date: Tue, 10 Sep 2024 10:40:12 -0700
Message-Id: <20240910174013.1433331-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
References: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Found on debian stable.

../target/i386/kvm/kvm.c: In function ‘kvm_handle_rdmsr’:
../target/i386/kvm/kvm.c:5345:1: error: control reaches end of non-void function [-Werror=return-type]
 5345 | }
      | ^
../target/i386/kvm/kvm.c: In function ‘kvm_handle_wrmsr’:
../target/i386/kvm/kvm.c:5364:1: error: control reaches end of non-void function [-Werror=return-type]
 5364 | }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e37..308b0e1cb37 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5770,7 +5770,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
@@ -5789,7 +5789,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool has_sgx_provisioning;
-- 
2.39.2


