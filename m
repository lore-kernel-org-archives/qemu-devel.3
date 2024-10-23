Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586E5D0BB45
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 22:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3jic-0004tf-NJ; Wed, 23 Oct 2024 18:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3jiZ-0004t8-Us
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:20:39 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3jiY-00060r-Bb
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:20:39 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso160457a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729722035; x=1730326835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WoT0AsZWAfNmcAWfaTwhWwPukwfCDi3g6QZUl9Vj/yk=;
 b=KckbVljbTPEks9ReeB9Po7YqZcKtnmMjFSfIp/7XJpBNTjzAFHhoOMC7o1k8kMkzQZ
 /DRemF+Qd16JyMENbsJ5EHnpqhGnyzEyMBZiZ0jfvOAXMWMpJ59t9m26tgkMLRpQdFK7
 4gFOh+iMbKPTgxaHjmHZU235YPlX3VoT2yLZ4JUBaze6DD+2JYbFivmMIM2B0CD3JO0f
 UFbA9BBuFCbGJkzeyvlyje9e2kR8WobSOj4Hp8uskB2rUo1zyOTE9CusgnGAoA7WF6GB
 O7JYObdDQKJnIdifpkOe0YlXNSAKHo/gQif6geBHSMWLMpjXCyfMULJGXdA6uKnr9KvG
 1WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729722035; x=1730326835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoT0AsZWAfNmcAWfaTwhWwPukwfCDi3g6QZUl9Vj/yk=;
 b=nEu+wNDQ5MDi4FapAkQfMqiJjR1eL9axr+2Dw99Y0TutOBdShaQyIvrz3p80tkGLbE
 nEKNgyOWEXIeeYvHd5njm7y7AGSxz5oAVGTDlROZ8Gw3AtPBYei0dtJDNcdAirfcy3WB
 lLjpbrYIiYtzY62SJvo0+29Co1MsCTB8q5JFZ071UttvB1MwhoQVgXYEqsHYfwGINOmQ
 KHeLH0/l8Jd2TUr5XBMPYvjXR5ybGVZgSt3j35QxdiSjpYmNtvqx5vLrnHuGtB78s/pA
 r4pTOmR+7LV6zZ+UzPCNNVPdU0Y2qANHgM9qnvlX1XlJYEjNC7a7oa6ICr52ojRRrUa/
 P/iQ==
X-Gm-Message-State: AOJu0YyccnkwXEiqkz3UW5c8PjfqaO3HO2kBLvHw1ShIBm6Wf9MteZ4/
 UinPS8HH5f239SHw98aCqZHVca1OVsqd13dz7v+QeIjWMV8vY/W72Jz8YMFJ3YTx/BLv9PZh8K1
 Zy09T7g==
X-Google-Smtp-Source: AGHT+IEeRN9j1EHuEN8pOfTgW2NRGJ09Gu7naJ6jSILfDZgEsMb7RfFPV/++W3XXFA35G8o/+lvMIQ==
X-Received: by 2002:a17:903:1d0:b0:20c:7485:892c with SMTP id
 d9443c01a7336-20fa9ea158emr42504915ad.45.1729722035580; 
 Wed, 23 Oct 2024 15:20:35 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0dba36sm61897395ad.215.2024.10.23.15.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 15:20:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] target/i386: fix hang when using slow path for ptw_setl
Date: Wed, 23 Oct 2024 15:20:24 -0700
Message-Id: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

Pierrick Bouvier (2):
  target/i386: fix hang when using slow path for ptw_setl
  cpu: ensure we don't call start_exclusive from cpu_exec

 cpu-common.c                         | 3 +++
 target/i386/tcg/sysemu/excp_helper.c | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.39.5


