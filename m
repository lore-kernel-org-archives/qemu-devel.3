Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E58CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8c-0002Sb-KL; Sat, 30 Aug 2025 11:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urta7-0005pC-7q
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:31:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urta4-0002Pf-Pv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:31:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso9297755e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756452686; x=1757057486; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bIAB4xz818z1X9WhWXBdwn7DV8R/vo74xMKSASLBK3k=;
 b=d1l1WydU/fGjmpNTjQ5LZnHN23ZhsRpcivSjThNuRkzCn7ttpxaj3c7aShh85fk/eZ
 JEKzTqBeW+OdBt3hEcTV62e4LilpWtu3948GKxKaa9oH0lH2ZkRvrLOmhV97twG7IZXN
 m5f1kmLkqW3hdso7infqV9/V7E1Qf2SCD/XutiCJBIdsuYVPIvzdJyAa1292F2xlGCkl
 M0gvK2vCYiiNlT0rMvNODA5eRN9kpBaz5L5Q5bhBWo9kH1Y7adedEW4l73f/ZOS7jXAu
 iGu4mDTJuvuVirs8+vVCyD38wLHdemsw0ks7dhW0k9a9jfrK5l21ccibfNiKEzV/74OM
 DltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756452686; x=1757057486;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIAB4xz818z1X9WhWXBdwn7DV8R/vo74xMKSASLBK3k=;
 b=XLRPWyHdnok82n+uTkWRj4HgoX3CIl7SEr2+QJtJErlnFW8VwlebXEeuYWNhuW22VN
 Nx+O+6xA0dZcgwlfdgVpQAt9k6TfEEf4Wnfk45oBC8etbnRWD+ouCUv3V9cdj9IgVJSS
 4xqHSsZMV5nHN3143yRU3oahggGsx3b03bUZ8tExDZzgIFs+VZqSN39BEYG5gTAdvemX
 1rM6GqO8bWOkjRJBvKq7XlmsKcPkvhuKP1414E8/v5aWZNmZiiPZnSgF3wbvYaf69pTm
 eZhRVop79uNVvVeiYUk2mybaGjZRCsvdXmqo6EhDhFZrydN+iRRtSyO2KveMgQqh9qUS
 26Cg==
X-Gm-Message-State: AOJu0YzJEzQngnJNGJMqBQ6pEMFbysgL7x8RQv1979OAKzdbECYznYUl
 SHFSGXeWKrIvjC1jWSl7hKyvfXTHbvHWtZXB237AmRqV1PfS9eKIwpddQLTI+vD4C2ydygR+EmH
 aF7Um3bI=
X-Gm-Gg: ASbGncuw1ujEOSJW8AdJhIYwCPpiQ6pbaIgZNgcCAuW0/t48y+P1qe9Y2XVZva2qCXs
 wpC75+MMk84zKUVXds6arZF1qCY7365UcAVcVIqt2Uqo8d2ViquR+wGFQidUh0YIG6BKVgaLK4r
 ghzosokrdE15pgeBazcNELO6lSNQdxvN4KPZIt9XtPhQ7Lcl48dMnqQxPbzyxabjMsR9XnCoJ1O
 5U6aD6ee9NRh9e8XtSA565m+WucNvERgybJr6UiAMsgeuVEQU7drarmi7d81lIKAlADZVccROwN
 f972IpyCcgCPif3dVg+VCDWtLxmHIPXncXN+WWtIHovWgUI++R2G/F+JDuqj8GnR7kwcAEBL+wg
 6v3mmrVDBabPZH0d8YqOAUml+q2iR5voGIn7Ds/0DMZuk9YTyzdxfybTnKsC5zBZL+zKxlwP7
X-Google-Smtp-Source: AGHT+IEbTjP/p59KlwMV3inx+4dS6vOb/vdA55KQl6eq4ad+cxRg9b4MMuR4UjJDboe+WVi1bKoVYA==
X-Received: by 2002:a05:600c:6094:b0:45b:7951:92b6 with SMTP id
 5b1f17b1804b1-45b79519537mr52408865e9.5.1756452686366; 
 Fri, 29 Aug 2025 00:31:26 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7ef7cfsm26061605e9.6.2025.08.29.00.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:31:26 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:30:45 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 16/61] target/arm: Rename CP_REG_AA32_NS_{SHIFT,MASK}
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-21-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-21-richard.henderson@linaro.org>
Message-ID: <t1qvkd.29wfunyx0g8b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Rename from CP_REG_NS_* to emphasize this is
>specific to AArch32.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 3dc4c9927b..7ebe404163 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -175,15 +175,15 @@ enum {
>  * add a bit to distinguish between secure and non-secure cpregs in the
>  * hashtable.
>  */
>-#define CP_REG_NS_SHIFT 29
>-#define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
>+#define CP_REG_AA32_NS_SHIFT     29
>+#define CP_REG_AA32_NS_MASK      (1 << CP_REG_AA32_NS_SHIFT)
> 
> /* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
> #define CP_REG_AA32_64BIT_SHIFT  15
> #define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
> 
> #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
>-    (((ns) << CP_REG_NS_SHIFT) |                            \
>+    (((ns) << CP_REG_AA32_NS_SHIFT) |                       \
>      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
>      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
> 
>@@ -214,7 +214,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
>          * KVM is always non-secure so add the NS flag on AArch32 register
>          * entries.
>          */
>-         cpregid |= 1 << CP_REG_NS_SHIFT;
>+         cpregid |= CP_REG_AA32_NS_MASK;
>     }
>     return cpregid;
> }
>-- 
>2.43.0
>
>

