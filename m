Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D957CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQjW-0002HD-V4; Mon, 12 Jan 2026 17:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjV-00025u-Ib
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjU-0002Zj-5q
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so38105675e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258194; x=1768862994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0IKJQe1LVW9IIRn3Ctbal0fFARK5xdhDlKuLnfzQFJg=;
 b=XB890kkcK3B/YWn+h8KOI6JKhUPlM1LoA7ULW5ggIPNKzzaS61t1tGIkQDEl+0JlhL
 /KGX/kqxgf4xTS8rt52oLONfcjk/bfomlU007SIcw/mi+fb5bpDULAAZgwWdNaAvDrTS
 CFDs0ETVh1hGcEVk73ZRvpd0jr3zS521a816HNkj/tAwSnLI4pQnUwVFkMVB3QnmnqiC
 ZtbGr4KkrY4DvmK0krpgzUUbp1JZINk+oIlHWtPNhU1lg9YvYGL1J+HpG7wqScaBvNLT
 jtLhTA4Yqq+vGwZZiuaFZrs1Z9gWhxjoWp3tqmYmmfgg0x5sVVZa0+aedadeVG18dbzY
 Qm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258194; x=1768862994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0IKJQe1LVW9IIRn3Ctbal0fFARK5xdhDlKuLnfzQFJg=;
 b=KblVfNOinSfnU1OaJ9Anx/jVpUHXc7HF9uhihi3PQUaLz4aH6P7w0nfeMgBgvgKnHw
 GqKXBAtTTByoDVHxP3b/6+5KuR+Zpf60UulONaaC4UVq4uZchr1M21q4yMJytEa7oP+d
 ufyZ13SI5/BAbDrNCzWzlf+c/Px11Ux4GpiVInDr/3rD9J1zWkj8h6Nedk1pT/IYH1OW
 qcQXavFZ2YeWvkMwVMVmR8zHMWA0KfystOhOEOiyetPEDNr/oErfXkRg3SM8nMF5zD2a
 0RFz3cYsuTtQCdszKImu2edBZUhnI8osLjtjNX4m296Nrsuqnz5s6gRlB2AMW+mSvAEN
 Vqsg==
X-Gm-Message-State: AOJu0YzG91JtCAz1wXRvuo3CaVUHcUIjLk2pB2I6kawMJugltVdqg/5p
 OU/BgW17qo+nkFcg1fMOOgMPdZwCc/iZNxx4B9aXsi5GM4BrrPH0Z9Ts/SnanaH5DByF9opxhgA
 f0+doIzw=
X-Gm-Gg: AY/fxX7jutmGR2HvPI3hFJ6hzikEd9xAtRWwR1pfSJ3ypUh3FRHHYnk4v54TdmDViwx
 99W7JOEEF6nOPP5iT3TYRByCYOSCNCbJUNY9P9URG1TSXf9duux+vFXfo4hSdmbhlqnpz3/+l4i
 dp1G88i0HFixqXNQSZ/cm+h/jLmu/w2M8U12atEW3uKs7rVeRidMQ4wW3p2nveVhP5dTtFW290M
 b0YtYqT/lI0ptiH4B4n8rhKHQ8xaydLdgNKTD8JG5LwIRyvykc56j5VtD48SrR3ZhBlEj+yQjSK
 ORlniJz8PEf8S3I+U0PEUXdq5ILfK9uuzwci+hhu+QTcVAb3U3ieKUJ3AIKXFFakrnTYrGGhkoC
 wR+Nq2NvPkQSZu8z/9YRN/Z/zj//0rb+dyQAeq8s4cJw+KzeMpgXtdCfCe8ObEEwcYJAv0BwRbN
 ax83hjg1wtUC4eJSDoWLCTDQVV+DASwIfPuvtPg22132QD8wvD9hgQ6Wty/y/2
X-Google-Smtp-Source: AGHT+IEbZ/KTpp/JDuTTEDzykXB5ijXM5YmUv7x2cy4NgZHzp4L+8inga+mSPDwGkXf+wZ0CRqEXdA==
X-Received: by 2002:a05:600c:500d:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-47d84b3bc37mr170024395e9.29.1768258194148; 
 Mon, 12 Jan 2026 14:49:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef868sm369937045e9.11.2026.01.12.14.49.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/61] system/memory: Inline address_space_stq_internal()
Date: Mon, 12 Jan 2026 23:48:03 +0100
Message-ID: <20260112224857.42068-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

As its name suggests, address_space_stq_internal() is an
internal method which can be inlined like all the other
ones in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-7-philmd@linaro.org>
---
 system/memory_ldst.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index b45bfecd137..d5776678edf 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -422,7 +422,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
                                DEVICE_BIG_ENDIAN);
 }
 
-static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
+static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-- 
2.52.0


