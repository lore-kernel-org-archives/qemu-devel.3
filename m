Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F748108E1E6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ax4-0007rv-9o; Thu, 19 Mar 2026 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ax1-0007nZ-Np
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:50:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ax0-0007mF-2U
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:50:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso8422555e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773917400; x=1774522200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIUuROQk5KA90LD+TLHw5mPzwSqERhsxnRpUgzujJ5I=;
 b=V2eEFCB7HezZ5PxrYNFH9i4Pdutl+ax1RaaHAN5YXHlHoL7b2CS8nVeiVv5j4fq6E9
 OEpCrEmVfZqO7+iTvMzcT5qNFuKh83Q3oGT2n87+zBI9tjZnDRvZhmt+A3ChoCZX2rKv
 EgKLjkC3r+UtSDUSoJNeIEi8J9oY50ADrpWBhELYJcI/WtUXcUwfXEOZOPHPi4usiEri
 TsZaG6w37JC500NrJAjgXV5vnjCKAwtov1wSCXxES8nAiHETogMITSrpeivN4s77dU5c
 CJx3hgbmxqKEbFlAkVpyij/tkYXCtUzEtkRxapqU9HcFk8CxY39TdZNv+bN6NaonXEee
 NeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773917400; x=1774522200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KIUuROQk5KA90LD+TLHw5mPzwSqERhsxnRpUgzujJ5I=;
 b=P7iMPtq9soHhc0RdWpRFunXF44cCF81s6D2kvNBUroHFThP4hcLWIaV0lb6Jz7fHvX
 XTqK8W9iHyUOPweeLgqdcIxmNEHTiCmQenwMapvaNPd3o+G0ow5NsKpq+QrSeNHmTvG2
 rrQE6ApL6vcsvaEGNKE3kGNPRW448vECibMGiHnDttYFFNnbYVC7QpvHGsORr8JInd51
 +VRt9UUTKpjN6EU88ELSDJWhdWWKnRhw/e59INF6H10mL5OjhMktFL/kDBJxe0nq7Guf
 0vDHEo9j9uh+cSXxfNefWnQWP6Cv6xI0Qm79CIJQnxGW3XFNImjoWSoZWde66R9nSF6y
 73GQ==
X-Gm-Message-State: AOJu0Ywg5FKtVGF72tSuJOCjOXw8/6BDeinO+vKX7wQ568KKcuwspszA
 gD+b/2bSo5MU8hAf7IfokO43JBxi6RLYi0nWv4P0P6vk3Yb5tBJh00668yQ+pAODzWRS9wY7tbc
 o13Y+nf8=
X-Gm-Gg: ATEYQzwNGOON1tbPz4OzNNuVx6g9eA81+jnARJ7stBgx28tbvlcdRmF+0382gEowgFF
 QSF/xyZgT9ETHThTpRAUbTPDl7150Wf/uNRNTmC67dy6jX4CQ0zzX8mIpA41gEwieycFL/bohsG
 Lcd0ndBsZm8ZLA4n/HJ9io+mU9IFgFRm1DcnNjTp+xJvcGICm5XbQqQ8qNAa3laXWVX5Wu9foNe
 sq0tW5k6JiU8fiavAbleBcigJDAU86VKXkJPiZa5OHNX7KgXB9WWIQLET+RAkyyGTMFjSENRGQG
 r7k7ZkuY+mxr9GAnI6W0e7DSMgz60dSnbLzdRsP8VpmSEv2uua/fSwvkp3Dv19PeDHB08KPp0zk
 rfrcvkS7VShOeEiiWpugg1TuE8JgTm0qJFNbOYtDerb6zSEyLf1ot30bEx4QDHR45WT+TRHyXOP
 l3ucqzqqIdLNRQ4p3Nsb1JZ6aXjuQfMZ9gdGs+d6DZLeBrLbmKcP2wWZ40aIdQ8wV91gehYwZVj
 qLsbJjXHpI=
X-Received: by 2002:a05:600c:4fc4:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-486f4476ce8mr107800265e9.26.1773917400148; 
 Thu, 19 Mar 2026 03:50:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8c292e2sm56213525e9.2.2026.03.19.03.49.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 03:49:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] configs/targets: Restrict the legacy ldst_phys() API on
 LoongArch64
Date: Thu, 19 Mar 2026 11:49:44 +0100
Message-ID: <20260319104944.66690-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319104944.66690-1-philmd@linaro.org>
References: <20260319104944.66690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The LoongArch64 target doesn't use the legacy ldst_phys() API
anymore. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable
to hide the legacy API to the qemu-system-loongarch64 binary,
avoiding further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/loongarch64-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 476407f9413..a425b3dbaae 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml lo
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0


