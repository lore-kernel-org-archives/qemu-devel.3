Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAE3C3600B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU0G-00065u-IV; Sun, 23 Mar 2025 18:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU0D-00064f-JZ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:41:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU0B-0006Co-3T
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:41:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so2990218f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769665; x=1743374465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3Zk7MdXWZU4ANE3vptmnFw5A7ucP+LsDCikXZArmmk=;
 b=kBTiumsq4Tdnaq5heDD6ruR6YSU5vRCFvG5d6LT3IRdRdRAn+SdRkTiQOlzXG/PGnk
 iPKztdq7C1o3Xjcbu0oHs8OI9vnvs2TUBOWO6IBdp4ZlGFgvwEw6S/JAncSXR30PuPJp
 23/TK9uXnjg/WhLhVQNz9qCe9lhln7FRharoYIafsYNGG8f3Ko+SpP9+BNHMa/Ibc5h4
 DprovfLeMwzBmLBFZ5r9zUQIUpd40JRK4LO66VLdanHqaUcPJXSwlLc1YAwSPONAoKLt
 wvl/ANjH0XYwRLW9SwIA83BEkEtR8RWv8q4zeAp6K12R3FHlVJJaBMKSP+H+IYxHG2lj
 asSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769665; x=1743374465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3Zk7MdXWZU4ANE3vptmnFw5A7ucP+LsDCikXZArmmk=;
 b=rD9MMcsqlfqa94Okajx85um5lk6y835jFWF3LeZro/udAxdtGm+qFXcfI+JhnWdbUt
 SYOerPegPtpf66koXEmi5ZlCkoeMMt1PefWq0xLS6cx8iNMGpg16fl8eI0SPw16ySoqA
 XV6NXtrwUKQnM7tmdfUtUJkBmg9p3RndNtwXD+pV0k5yEnLlM9NZs0Vki5EbfDs0NXWl
 KFjmNFL6U0zRxbHUs3LLQf/7+O+pQRO5TiuWav+SSeTZsnf42OE4WkhlfoCGTIrUtTla
 5Tk/oulafdNwHLQYbpnlq+o1FIMhOLvp27gV+20rnj3HFewPPPCkoMruL5u0E5hUlNMd
 82dw==
X-Gm-Message-State: AOJu0Yw2WYij4oW3g/qEZ0pfzbyg7Uw+MjrVSKuMn5wJ3Y0fEG4vmD6S
 SfFtyU3SGmCq4IEzPV3H29b9Gq46aihYpoiu0eL9jp1R7OhItZ+vco16Ej2I9EiCw+VtvN6x1P+
 e
X-Gm-Gg: ASbGnct8nbOoyBo6xxnMU9Sm2tnpZll+quPWEa7O3PR8bcbH6oeg8W91uD8KVXpfHWh
 oUrDolxho4DnaF8H7UYwBv+malwpBzJPfZf/GZb6qZAjHpwe4SqslAjcUcDe+2B0IqRu/bTWMA/
 dUF4jG4khyll9or5RNdC2W2uIDxasaTTA0DJB7MZJYiywCV465vheEBjFV0uM9phE0zMKYGdqds
 UPWZCM61d/MftYJDr8Bs4TV9ssNx8PB7fdfpUiQIVtWMg9fb14ZItpL14srnkN3lhTlUvyyTxPf
 WrtiG3WXuJ9RRddYaDoLgruw5hA8e7ZZ08SEn/lDVddpJ+d7qAVCjSnW1Zu0VB4jpXfKtlAICnK
 JFrlRz5fHLRsxOxGGz3jCmoXH
X-Google-Smtp-Source: AGHT+IEXtZI/oI3Z9Oa+kgpS7jNe6nuckG2er4saJTC4nC1kDuxWn0roHjppUBlEdZDYz7XFDzcBeA==
X-Received: by 2002:a05:6000:18a3:b0:38f:2efb:b829 with SMTP id
 ffacd0b85a97d-3997f940da2mr7788944f8f.50.1742769665186; 
 Sun, 23 Mar 2025 15:41:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fcea65fsm103407795e9.7.2025.03.23.15.41.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:41:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 5/6] target/sparc: Register CPUClass:list_cpus
Date: Sun, 23 Mar 2025 23:40:34 +0100
Message-ID: <20250323224035.34698-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
References: <20250323224035.34698-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Register sparc_cpu_list() as CPUClass:list_cpus callback
and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.h | 1 -
 target/s390x/cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b7992deda6..1aac967a0ce 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -902,7 +902,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
 
 /* cpu_models.c */
 void s390_cpu_list(void);
-#define cpu_list s390_cpu_list
 void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
                              const S390FeatInit feat_init);
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f75629ddc2..ac05e82f0ac 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -378,6 +378,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->list_cpus = s390_cpu_list;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
-- 
2.47.1


