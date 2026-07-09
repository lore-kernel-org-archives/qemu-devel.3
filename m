Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC480C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whroe-0003CC-1X; Thu, 09 Jul 2026 12:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroc-0003BX-B7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroZ-0003ch-3g
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669GPvMw2318971
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6+NumQOKfMH7xgRpkQrLTiQfxEVRG2QlSf2brndq35M=; b=m29ZE4epxMhU/NYt
 fFJ6XqxlovGV+rJBi12DeD0YjMDcX9qZoh5tOI0HmulkBuy74KSWGkI7YBedWpan
 Vg1AoLV08tUWJBPl+dfIfC44IPkG/tpgxX2KBNO1zrIM2TiKcLouLEYJnpcrz91t
 pBywulBYfGgReNmzpB27pN9hcmZRVyN9AE3Gqz/HcazpCLJue4XERzl7DNVwZXL7
 TjBahXOrf5yxlnRNqfji66tNY8Vyp5+UcQ8lIgTJOVIcBEyPm+X+u1b++8d47ffp
 pL7NiwT4X39xh4ptnvWr+h5ISAsq+5A30FMHR5WhKjKXctWI3d+62vR9E8RkP2v3
 KcS4SQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mr3fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:41:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so26724991cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783615289; x=1784220089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6+NumQOKfMH7xgRpkQrLTiQfxEVRG2QlSf2brndq35M=;
 b=jv9sB1DBRAa0KnSPyGQLoj5SXmUicPURDO0bsXwqkVKPVlwYm9cXvLKF5yc7NlpozW
 6jmojYh755+I5qHqUk3fB5qyeiWAKlsnf5QTmwBomLx6G+1ojDzxTJShAS3ML+1xpAlu
 F+GPpuqwrYqEg5LNMzOa2Qa5WV38HkCYuEBzbMnrrq1FDwLjqMgZDJTdJE/xklvRy0iq
 tLxzBCth9uSr7EshPCv2MRWLZyq6YUDXBG7C2ipBghDrU9/Nzqzm7ZJH9Q2rzO2tveJx
 h2aDE5VF6XwtyS/cHTFAwIYt+r5grKchMS1ed0bGif0Zy5L/PNvYwAFz7QZw95Gm2aIU
 6uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615289; x=1784220089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6+NumQOKfMH7xgRpkQrLTiQfxEVRG2QlSf2brndq35M=;
 b=eWfgRSoG87nrJ0x6wZh83UuNaZIdJvAVCTOjlSgKASxdrp4Q6AaIOpq2Nt47DO2nLT
 +7P2CzVAo6aw1bnJcWleoexYfSULPXOhsZuxzU6QXm7fToTw9757n6NzFf3xa/ZF0aN3
 siDRrOQfbybM1/3oG6BDiwj9Vs/erwybIX051Pzo6KbEXuJetJlacP0HM3WaxsRyY95r
 v7k7+5qal0g7d4Mqr6427pWgBV+EzXamRrR4znYD8zBVJg9NcFjQOl0uEYyqAypDgRix
 YFJjzNC+Ur9SFDNzqZMuA7MjptTiV11Ftar1zVbItVQTqL+kct8oZkCdd4SYRS4xJ6Ck
 yoAQ==
X-Gm-Message-State: AOJu0Yw8DLo9lCi6W9pivabwDMxSIf1Q/LJ3Io7timru9nqeBBxjjp1m
 bJym1OrwVoYv6NUjpU78rtu8ZtGMNX5AMz70WwDafSVfdgxSn71pSppbfbL/g3AwMadmuLT+y+m
 J05ZCOC2e6pfdu9Ocv8yGUoQ6S/C0WvOpva7LsFzVcGUdFIou9Gu8Up5PXOqWkgdX4A==
X-Gm-Gg: AfdE7cn/oYtjiRuMBm5d6azFoBfFaIOoAhxvQ7AHZ684SJoqigjI0zXnhqNADJdxHtn
 HJgzK4/JPqr0dbqI/YVSznNl7mbUQHMXA91GCPiQYEERUcUjHW4pIUCpsAJJVCqgcRNNYLMkFz6
 IEzckppU1WIuGjHSq/F19vaTJ+6oOe4ugdyOGcGYgZwmt57fho6NMIY5ClCx+x6emksErO0TOpX
 1BwWH4cP5rdqJhOMlCTbKUUEuq98lYS3eRsZs039+Tc5fehM+oxuLVl++LzFfPcapFwiJlqxRv+
 GkqvMA+cYvHJ6sGchtI6GVQO/4vKpbSzukA4xZOIqDIFU8K9yRoAcxGGD1J9GjjtO2jn02FpWvB
 8nFcpmALdGaCxQaTaOS5EmzpEEZJza0Ba7m3PhqWlrbCXRkwtPQzDoZM+XNimpPFw2THk
X-Received: by 2002:a05:622a:1352:b0:51a:8c9b:6496 with SMTP id
 d75a77b69052e-51c8b40fd3cmr83837151cf.58.1783615289155; 
 Thu, 09 Jul 2026 09:41:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1352:b0:51a:8c9b:6496 with SMTP id
 d75a77b69052e-51c8b40fd3cmr83836691cf.58.1783615288706; 
 Thu, 09 Jul 2026 09:41:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm51352319f8f.33.2026.07.09.09.41.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jul 2026 09:41:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/3] hw/arm/aspeed: Add missing Kconfig dependencies on
 optional components
Date: Thu,  9 Jul 2026 18:41:02 +0200
Message-ID: <20260709164103.37614-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709164103.37614-1-philmd@oss.qualcomm.com>
References: <20260709164103.37614-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jHrL0qgZWxa643hnoVFp89wjsupvP-Bk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX6ggPlolrboI8
 WmepH/cEPqDzTXyBg4EMKa5is3UAxQCJeIuVqPQJZ2YGsoyzPzdO+nYtv183gpuJLzks1tqARav
 uo6FdvrNyx9cvPIji+GlUFLUzbpl9Oo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX6VNsYhHt0AmX
 JRW2N9dswMOBFBdr+t/7+ln8JUTrJrAT6u1kcb25NvJGJD2WaY85kPK73subSiI8VTMCmIHeOCL
 UQZJt+PdeCJd86DqzXJAMh+QIYLUtjXmtwZabItk6HkCgWaiRRZ9sCBa3TGdnz087tYTYxlqL3R
 1VmbClSA7i99z8it/WXkoDutj5QMObHYWtT7kL31Zh0tP4uf7NeuKRdv421MNgeGRKPfKf3e2Ol
 84+RjkRiIglWBUvc+XRYnQR9ukcEpm8DVjCVDnbaFloMLeD01xXoO7CMK+Ei7YWf/YllfPzDFqi
 1+5c12vQBf+O+Q5ncITQMtUlkKTgc4u6fqn7gFlFYVZWEeRA3+dj751UcsEz5VRAAtqiWJBQYjm
 0BGwoPm6EDAgdWemLhZl9OAIWkcYxVdWJxB+SvYzhAakIWJkTqX8NXiFmRqxL5S3PuWjbR3tl9/
 0sne3P4Evc7FCnWIlVw==
X-Proofpoint-GUID: jHrL0qgZWxa643hnoVFp89wjsupvP-Bk
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a4fcf39 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=44yfr59QGiQIZl82vZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090163
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add missing Kconfig optional dependencies to avoid the
following runtime error:

  qemu-system-aarch64: -device loader,force-raw=on,addr=0x400000000,file=./u-boot.bin: 'loader' is not a valid device model name
  qemu-system-aarch64: -device e1000e,netdev=net1,bus=pcie.2: 'e1000e' is not a valid device model name

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6f5b2add66e..5869f0f9e89 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -533,7 +533,9 @@ config ASPEED_SOC
     bool
     default y
     depends on TCG && ARM
+    imply GENERIC_LOADER
     imply PCI_DEVICES
+    imply E1000E_PCI_EXPRESS
     select DS1338
     select FTGMAC100
     select I2C
-- 
2.53.0


