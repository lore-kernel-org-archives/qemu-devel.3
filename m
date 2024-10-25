Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB0CD149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Oac-0002eu-If; Fri, 25 Oct 2024 13:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Oaa-0002dx-Bp
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:08 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OaY-0002Kj-QW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so1800215a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729879144; x=1730483944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fbyh6bxZX5/ZKOxQuoyjNuxtRkdNVIccxb9KcjXQqaE=;
 b=U7A3P/phcLfX3Q3cZBZW+l9PyQPCcu0e5NlEQ98b3bGkar21XNxElssXrOdFub4eLM
 ArElI9CBdhpM48YTaSWEROpdkA2P0a8EaNI7oWK+PhV9zQ7izw+/4gqKf1Yyfr/paeAs
 5pAsIOabWoDjXaDeGU/w4g6yuanV2snpVS48hgspp/YcfUJ3HidM1AAowqwucFLNWAjl
 urJHcTzelwl9PYyhgB+iDCaJ301EvLBZbVRD7J56Q1DBWvFrE6bjpaw4wwgGrfJOtVIr
 sFf0prLLPq7use9ZkbhrlmxAvQjRIYRocy55UuQuSDR9YsjVuV7r8jhgZMKVTckJldrU
 J8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729879144; x=1730483944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbyh6bxZX5/ZKOxQuoyjNuxtRkdNVIccxb9KcjXQqaE=;
 b=ZUfW8wJsy4kUK0wbQsCqt+sVApNy95OaOzBk/vYtdjc5Cy3WBQb7C8/yuiVhxpnNOb
 cMJwH8pWW7+j3DElyp8Uc3Qo3prgQcUEQ9skBtE4Sup6zE9YmshzC1UbnpCmilF6tlBa
 jKf/VEL7iUsG2wAptXxwzzKopdtYT3VyID1Q3reiJihR7c/kVdIuygvVNHHWM+fLlpGw
 GWKt/x/9UplH/kQ7sl7/wdECKOjBIWTbA+ve67/3Bmgc96yvU4XF9IerMKqIC88WiTtv
 Bsez7S9laO7mN2QbVMPAY9kZ11ualk8nnB/b5MkIFvIyHc1VA7wDROGvBkkOugRznjbt
 vTkg==
X-Gm-Message-State: AOJu0YznFKhygzlD+GkAOdqsht3/jMKjRr613VQwamMoNFEYWPp/X8qf
 R57jIOrQrg5dcqjsYjIh7mOCKrj72Wt8/H1kkpj5RIf4Ryc6QSVGNb77lBlIlMxLie/7wqrWXFW
 O7AEGpg==
X-Google-Smtp-Source: AGHT+IGMQq5ldXkY1Hy1IrA/bCR9xrgBRx1K1CwEMkLI7NaOoGBodIErxAVVHIHlhDkqUeIdcw+ryA==
X-Received: by 2002:a05:6a21:168e:b0:1d8:aa64:874f with SMTP id
 adf61e73a8af0-1d9a8511c6dmr66649637.43.1729879144617; 
 Fri, 25 Oct 2024 10:59:04 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8679eecsm1358056a12.26.2024.10.25.10.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:59:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 0/2] target/i386: fix hang when using slow path for ptw_setl
Date: Fri, 25 Oct 2024 10:58:55 -0700
Message-Id: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

Most of the details are available in first patch. Second one is there to ensure
we'll have a useful error message if start_exclusive is called from cpu_exec
again.

I'm a bit puzzled that we never triggered this hang before. Is there something
wrong with the potential slow path for ptw_setl, or is it simply very uncommon?

v2:
- get current cpu from local variable instead of current_cpu global var.
- change condition to check cpu is running as current_cpu will never be NULL.

Pierrick Bouvier (2):
  target/i386: fix hang when using slow path for ptw_setl
  cpu: ensure we don't call start_exclusive from cpu_exec

 cpu-common.c                         | 3 +++
 target/i386/tcg/sysemu/excp_helper.c | 5 +++++
 2 files changed, 8 insertions(+)

-- 
2.39.5


