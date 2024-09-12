Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDEAEE6456
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodol-0001Ut-T5; Thu, 12 Sep 2024 03:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sodoj-0001L8-AX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:00:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sodoh-0004Km-U6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:00:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so493639b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726124434; x=1726729234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aIlixRNtSXenIZ5H1YZipFaAIbAh7HofSUtCCsFCI0I=;
 b=JmMvceBIbKnb0sPJUpbq/kJ5/SL0ir0KxesVhl4taZ3eKcruWAHJe1wM00M7gDdLnN
 YB8JjUrgrrzT5LhyLXku162a2EZuXV1ova+aJ4zGSziIkLKvpSdBSZC58AeySDrRmr0Q
 RnTldW1Ula1fH/oQaTKa3V2nZicWKI6ZFkSGLbY++2V9vDHjZt2H6y32O0VxNnJxHlJH
 8yEP8Y2y3Hn8MVNdkbp68Z+S27aF5ljRbEGWKiANo2SKWLmJ84R/KA8nBGiRsVIbBWBq
 I1zcemcNBmAMf+NgBdMxiSKSQxYKiamN8ONYC/DFGY9dl4RxQgB+Q9+BLOaeROQz6xTb
 Pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124434; x=1726729234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aIlixRNtSXenIZ5H1YZipFaAIbAh7HofSUtCCsFCI0I=;
 b=bLogWHsOYqbq8yT8qd3JZvpdyRnD3XJjlmsQkga14P5KRyV9afipmu5Z4prxqCGJJD
 EqQ9NkdjP5iHl0Tc0MCRWFYEjaHfxxhR+2I/Kv3E5hANNsVut14ohHGRRHwyRk1I0k8T
 WM4UfOg+UwGbbpKJdbMqj/NWvmgKuYd88X9ERx6pX5xFEoXm2zifVb5yKSVrQv05hQML
 usjSt9SuqBUwmZoU6PKrfKNqO6GhlCF5qwIyzkSa8WYx/vji469Jk5sH1DlwjBVbCvqN
 LBRb3X+DMFLSFGnXNZti3lXhiYt34ESHwese0Wx1cDhwg5cN2EP1KAQPMCVLxi6LJpf5
 PtNw==
X-Gm-Message-State: AOJu0YyVM4Liq/4sxkRklL+hX+b8CZEVYV2dRr6QIBvhcaJw2rzhK6Sk
 ql67d8+M1qeDkjuxUTto0kAT7idCpLkVUxxixhe21cAw/sX2oKZCdQKjKTd8HKxyhjEuJOOUUQV
 0QN/4mN2OYBLeuK2Rmds1h6jBzJRcQdKceebowCZShWSX1jx3tZ/ksJ5PRoHbR4kUf3r5XsoMjj
 l8eBLfhETB/yLAfneuBUHkk53MA10JUlxAaew=
X-Google-Smtp-Source: AGHT+IGcoiqe7yjJ1VSKpWBid1ZYfT9PPGdZm6udjkydV/x+RG2SLIRZh6CFKutpgRA3uKXD3b5Y3Q==
X-Received: by 2002:aa7:8895:0:b0:717:90df:7cbb with SMTP id
 d2e1a72fcca58-719261e77admr3138217b3a.22.1726124433292; 
 Thu, 12 Sep 2024 00:00:33 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe5309sm4001479b3a.84.2024.09.12.00.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:00:32 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 0/1] Keep transaction attribute in address_space_map()
Date: Thu, 12 Sep 2024 15:04:03 +0800
Message-Id: <20240912070404.2993976-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x429.google.com
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

The follow-up transactions may use the data in the attribution, so keep
the value of attribution from the function parameter.

Fea.Wang (1):
  softmmu/physmem.c: Keep transaction attribute in address_space_map()

 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


