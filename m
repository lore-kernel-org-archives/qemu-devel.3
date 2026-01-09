Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152FED26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFhj-00045Q-Gd; Fri, 09 Jan 2026 11:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhf-0003xb-Ix
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhd-0007KL-1E
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so37099065e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977467; x=1768582267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6wRQ7EoY84wSQD0D7CNjpx8CjZayMzdWIMhqkkeAcM=;
 b=lMwEVVMKJE9ApRsGJIGs7qDqaIVYDauDAIJw4/3wXPhSZtfzJp0DgoDHc/WEIvGzp3
 jiJDOcsVnWBxKwkz2luLVryv5F8NN1SZVbhuTS01FbD92+Vwc0wyjNciZ/DzeOBKAOTY
 V29kf4AEti6Dzc4FkP9hYnFgqU+fNTkH5lLCN3pbYROD2DGkp1aDil8+/0UpmBW3BPy4
 Nb/Ot7ca09S0wflD+SK/GM2hhXjpmM5OvuDExaE9WmlXwB8740OQ7U6DSalpNHbxhcFD
 K7GSwhfnUJUow2bfNOg9Pvq0DTbh4HPpKGT8cl1DZ+RGlHoTP5nMLzLnRCGN6bgMwyNd
 vGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977467; x=1768582267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k6wRQ7EoY84wSQD0D7CNjpx8CjZayMzdWIMhqkkeAcM=;
 b=dE0Hnk8dkme1ZCC9Pt2lbskOCmpjOv59ubAGU/E1jCjIToTZ4trvkce+kaD3U9YSw7
 PRIxvE8rb9oU596zV5cx6M0bJhTJZX3PnI9tjlVIZHA5DIfWvmguOZGrE86waos3RlqU
 hydhnB4VRDps4FsW4zLb7wTKoRVl4lcu+BhtdhVuR7pQBhbesTXnZpgRBIPMB0uDTqG1
 Dw3dCRbSJtUsROScZerp6sHhHi1wDxnUl2JF4aHsWcg1F0skvpf8UVZQNm5N1tL1AkTf
 WIbHaMrl+Jh3WZG8RibVLmCK901poyngjfemuzgJ1zXLK3f0fkQiwMcy42zCwehx+xGf
 9ZIw==
X-Gm-Message-State: AOJu0Yzed1AV3bN3TQbEvyrML3nbX4BNH8evvQ65engIXR+2Q2IHRTIZ
 fuDEm188YTsuSk9oAgrXO5r/iJenw06QUuHq/oPzBGd9t0LutL4lNQ6b+1CJtCLNhQOQsXgXUDP
 WsaTsRrM=
X-Gm-Gg: AY/fxX4aocsPo9DFjXKiV2Ui344rYvrmoun+T0txWsu2xlqwqx4tSxdy95D0Jr/iB1N
 6R7WZCdvsdeevtabyzxI8jwNDMYU4Z/ekM3lQlmzK/BGYjGCdixPzu1AhEQgOfSC02WNtYMhwub
 p3tyWBvy1+mpZE1rpQcL5/D7UyAe76Ei2oErJdEv0+ux0JGz+pvYyBwPp4hiMtkaigh04JX4kfL
 yjq5xa+LKXFU0l2LILBXoHCU6vKaCGWvF43K/6rBickU+p9SUrIIKdsRBWHHi22m8gYjHCf3pte
 HPzQKptjYaRw2zyW1j2jRnfJuMyhp9YLdvQ+2TFpiAXBR/o7KynzfjW9PaWdG8OC8oX5iCGXcVL
 WuLC7xOClTPkFIwdKIdkIXcxFd7VDZUvGYG6bDfZN+4ks/xxohr0Z+8IuuAagOyc3TB5pyb3Dbg
 ol64wUw9mRscs/l+GgA6kfLpx8atwc91gmufZvdscPbxTh3yhcGAVIG3UZeAv6
X-Google-Smtp-Source: AGHT+IGSKFpoHh6csrW5QCNqs0FMb8ZHO0llm5SQY0+OH5bhNsdKPG/YinwobrdG1LMHr3CAsxvkMg==
X-Received: by 2002:a05:600c:3e8e:b0:47d:2093:649f with SMTP id
 5b1f17b1804b1-47d84b187b4mr104497875e9.8.1767977466606; 
 Fri, 09 Jan 2026 08:51:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8678cad8sm71386885e9.3.2026.01.09.08.51.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 01/22] MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
Date: Fri,  9 Jan 2026 17:50:37 +0100
Message-ID: <20260109165058.59144-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Missed in commit c611228c0ed ("include: move memory_ldst*
to include/system").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6602c9891db..2d8583cbb52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3260,6 +3260,7 @@ F: include/exec/memop.h
 F: include/qemu/ldst_unaligned.h
 F: include/system/ram_addr.h
 F: include/system/memory.h
+F: include/system/memory_ldst*
 F: include/system/physmem.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
-- 
2.52.0


