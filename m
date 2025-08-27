Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12A2CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dH-0006nE-MI; Tue, 26 Aug 2025 21:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4ce-0004qI-Ig
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cS-0007L2-Ph
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so5591021b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256756; x=1756861556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q73+ly4FjnvQ2ESSfwdG4UgRILSHXmkXXwonIPerI+k=;
 b=UwQY6+t2v7KzwNhBiTkYXx8VgKCTmT6DRaiEnJ8IDdVN0qYOPDRhqy6bPwWX1rW6qu
 i1ol+7DpdYLzGAu38Sll9wOwebuJgSM0algUaednd79LXz5h20L9HR6Sr4GU/j8ehV/9
 ZmH5vSfkuh4TROYlFk34qnCefwt78JcNJJeUDZxOs6ZtGtMdbINBCIkhZKxvkGhcq6m/
 PWL2+Q4tglxcQ/XyJt0gfHFdZoEN/SZ3Am+IpuoOWAN6OMNeoRwNiwrEXJ7XUuRE1f0L
 0OVivbgAvqx8toxpJ3Hr1QVMd7O3wOo9xQEa2VIXNI32sYLfQL9JCS4SNNZJipOcoYAq
 gvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256756; x=1756861556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q73+ly4FjnvQ2ESSfwdG4UgRILSHXmkXXwonIPerI+k=;
 b=DOcyBPDNPb5Xt094YrrzQxZqTYAH/Ms3LXk6aUBmBHHw12cDSTYqQpd6uahr5kobfW
 s4BwY5l1tMbvQUZTfB2kAxma4q0xQeiEK+mQOwtx4w2s79N1y9JIcm7H5Z/IH3gbOrrg
 9LY/D4TyfBXXKHhA1djudwwgdN53pFFZrPt8UJIa7/9vcjJB6EQRlVMNpJwJNiB9gIxu
 NGJrAqJLm7PjmMpq6c3CV1Ob7PeSV0LVAnslGjVShtYBx1OcCdeHzFHOB8/0fHDbxwnw
 8k5ElVWXWQH0KlA8CAsB11tFtcawERGCVHyVhyTqxA8c9WneouKI7lsJIfWRlTJ1e6m9
 BAZw==
X-Gm-Message-State: AOJu0YzeYc8BDzVbjPK2KH9/pMCY4YuRG2yaW0Va+xFYoaXiRZcjXyPt
 OXJ5RCMqMNzugKiNMyQ7TWA0LecbHk5HvKuFUnGp5Wah/705NCJVIpRx8jCEpXH6ljix+mZRmY/
 aND0LWvg=
X-Gm-Gg: ASbGncujNL0wEqmbSIQDq2V3Zj2MH1RKNOBJ/KkxyavAo7Yre1lTtMOoWmgb6nWjniL
 5VUd3I+mqZX9UJpcWyVvC27d709gA/YNmY31K7Q4hiaKbf7BusapHoIsS5/icvDrTtJC0PEG3Oq
 CicEJM02twg0HDsJZmg1QwMPbRWxtDX6Kc5F1UY28QtA+WOljTGDNk0sFnYc04+zWviaGC1ufkR
 /N3u1hgiHfGBILg+110ooADRKsh+vyOAc7kZF3Qcrkr/bjJ9+v7wiboM6S468fTk5cEujPkLpm/
 yKnlQqjOhmZQtaHUhV6f2HjiB0Ke8yai+ttt2RK7SEmkfLFAPA5LAKlDIdIZEcUZ3HgpYTT+hKo
 xR29jCVPJYlLcoQtkuBuAPlQM2A==
X-Google-Smtp-Source: AGHT+IFLzPHGqNmsFcWOoVNdSenEulSR80ObvM5WYd1ZiVGYbsHoq4pOOE9wsy/jYbT8cPk52uHEgQ==
X-Received: by 2002:a05:6a00:4f83:b0:748:ffaf:9b53 with SMTP id
 d2e1a72fcca58-7702fadb5c7mr20099354b3a.16.1756256756027; 
 Tue, 26 Aug 2025 18:05:56 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/61] target/arm/hvf: Sort the cpreg_indexes array
Date: Wed, 27 Aug 2025 11:03:59 +1000
Message-ID: <20250827010453.4059782-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 37d8f795eb..5f19347bc5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -925,6 +925,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
+    /* cpreg tuples must be in strictly ascending order */
+    qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
+
     assert(write_cpustate_to_list(arm_cpu, false));
 
     /* Set CP_NO_RAW system registers on init */
-- 
2.43.0


