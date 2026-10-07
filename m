Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE54CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWiP-0005G0-EF; Wed, 07 Oct 2026 14:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWhu-0005Bb-Ou
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWht-0002q4-1P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IBDIT1494288
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kloc7gsgUa5OSwcxDAb0SE8OIoaEqfgO7pIFkRL6yfY=; b=Iy6HQNAV91lrxL/k
 cRk9tG6uIG2wNXjV7OlWBZRB+l5LNZgnVfm0muFJFnDyTyDX/m50AsEMxvvOpuoL
 j/g2K5FwiexNpIYPLR/wxoPVJCF3ZFvkBFzkKtxc3AJfFnx0eXN3KzZUzOqF+Di9
 MnMgIuyyMr8frNjjBEvfFVFIf/iRMEWGJAqmu0dFYWbPI3X3lrukzIcLwqPD9hLB
 ZL/E8vl+zGoKhoVXti0rZMXnx218EAPP9GM3rGpfx/rL1co5Fv/lkCrkzl765S1i
 aGzanEE7hJNG6IB1eT0wNLZOEf7PA6t4DA8aiOdNpWoa/8gy5SryFbqPu3eRhMVS
 fgsYWQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5b1hm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:49:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515266f6eeso1621900eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398975; x=1792003775; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kloc7gsgUa5OSwcxDAb0SE8OIoaEqfgO7pIFkRL6yfY=;
 b=RPphFF5FRtiGcSonjRLVD/ZwZcwuN0BduhiV5QImhseUvT3Ulq72lhqIkpZbUdCsuZ
 848wOSd4PCRH4ZjCLVT7h313sTlTvN03yJNYEF/OBNcfGQWFDz4DQ4guNB+JCjc1QLon
 biZTbneCTKXB6AHLL/WQsv7sG+jWuIJEx3rhv7O0frTYxNH+294j2GPuwj3LQYwfaqvM
 GLdMbJorQFakjKkhNo/Xf+2oQW8e7LAawh8MA21mcxfuJYT1Ly8jyaxL2GtiZLmHsbWV
 jADWB7PquCWoUQr5k+ar/YggANnn3xotBoSyjK3fwR6/f5i5pyZV7FVTeMsPj+Cn5o6O
 KJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398975; x=1792003775;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kloc7gsgUa5OSwcxDAb0SE8OIoaEqfgO7pIFkRL6yfY=;
 b=lpcmdyII63UsPaK9t4Jk6csmwzmh0T40g9BWehon3dOUp3R5cs+8x/Ed01E9o+n9j/
 lpjYcPitQf5+UWyIRHbkX23fmBXL+lLpY8JgxpELUW7hS3kLziOYuf/NtYqNpL0kVHAS
 XpxSrYMRoNRC0B5m5kNUHCPSMZxeC6PV+wjgaRhb9+rFXmSIUkOFAfhtK0dV2j1dpdMy
 bmBhqbFOrjLncFbvMG4vH1jYVMCFPSJDWL9ecYr1ZmM1xsCGLLchUfoWpulvmkmqSjtu
 J2Znij2JghajyMpuCs4uB5lzdqbXAZmJ2mqQ2xbwdng/CZi8fxY4XjMhyAr3PIZSkJQV
 OZRQ==
X-Gm-Message-State: AFuF++k0Z8qmKxr7KZrpcmxnVnGv5R1hervt9BE9qXjviPvCkOlcr8Nb
 2kz6699Yq8LrcZ3GhfMByxvN4GJyEMcxBgV9zkzg2MK2S64FQgmnIRPY71VnEYYheW5BpLPcp4o
 k4yWnMzzP/qCbD+w9aR9oFmjhuc/M4phpb8+El3WKnTjKQeNgzpJEnkqCeyV7boH0LA==
X-Gm-Gg: AYBFou1iUTrBcCh2mnyi9eJYSLWXE+bTt8gfgxc7Iav4EPWpUZS+iykJJWu9OS79iNt
 5usxaCiX+G0GNPl3hywVMN/tlV7O6tlMotmFGFQ69SBM7uYfAKg8mSbs8q5VkxDG2bkfZXMF8zy
 XcVHlWpWdZTV/ZQyr/gPkTrROOvDD4Ywxx7uDStx817KjBNrSWdyN0SPzEdOCViZByIxQCfiiLT
 jqHAxgk6RsCjfJBOObqUoiRJbqnidV0wt6u6JEBGVQWYMO4lC3EAVspQDHuDqOBxHoXtsscUhi9
 Fk//0XIcHd1Es22gqCRyy/X0SMhbNvjqvWm4yVLnEbxJzBBh090n9n8/96Laavc0GsTiqNRxCb/
 yJ0G6Fxmp+md//OviZdnErkzzfgH+5ZX641y9xi/E9BZjZ6Q44R330vI3cfM8
X-Received: by 2002:a05:7022:61a5:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-162076c4c3amr4559029c88.28.1791398973962; 
 Wed, 07 Oct 2026 11:49:33 -0700 (PDT)
X-Received: by 2002:a05:7022:61a5:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-162076c4c3amr4559005c88.28.1791398973320; 
 Wed, 07 Oct 2026 11:49:33 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1616b01c2b4sm7259158c88.20.2026.10.07.11.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:49:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] target-info: use TARGET_ARCH_VARIANT
Date: Wed,  7 Oct 2026 18:49:12 +0000
Message-ID: <20261007184913.27052-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfXyjDtLuLm6P25
 2TmALsyJVODbCA8BZzSSMcpqzubovLnCIcba4nVaKWp/LWOp2enNEhzTS8guWYdu/Sav4pQYXIV
 n8H52Vo4iSNUYYROjjLQyshhwvQ54tU=
X-Proofpoint-GUID: Bfttfz5_9qYsDXGQS0VIC5yGFT36HouU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX+SYwq2p1Ximt
 E2XMsn8FSR/ixbhu+SANd8mnZzBLGe/iHIwRsUaAqZDsLeN/Y6X+WdYcqBuJKvpNRgkgor+7PO0
 C/edF4BpXXj/4RcNk5YCgS+hj0Xn30sk0/gKMDRuPx5PEfNnwf4b+WNitWv+aipe0AYLe+1F+0S
 j7C6wH6/rpTdJxqUGwWBAz7tbRl03rr1azt4gLbXD4x7gw308/D0H1ysXmh6VSIu2RnzVAT2nzL
 h/h4eQNOnEMbWkBXAlYC4gyhGEcQlyIni3wn+rKCb7XzLXA1p972IV33F0wkvXOTrZ7Y2cb9X+z
 pSkv58L5Ili7yYq2zeQmWfdQe5oJyDhbUy5nsJ9kRE+x5JS7e9BW4uInNVxRMBLUPOwqEKRTC3K
 kdxd4P9gOkvFXh2NdE2m/9VPKr/1/NsmwD5OBfKIK9fGUk+OV66voTGEBu31jDk2AM/0YUfrxMI
 vNNSBJuP9MdlbbUp6vA==
X-Proofpoint-ORIG-GUID: Bfttfz5_9qYsDXGQS0VIC5yGFT36HouU
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac6943f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=gua6CS0tsYA4MX_G184A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

target_arch() will now return the full variant, per SYS_EMU_TARGET enum.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Yonggang Luo <luoyonggang@gmail.com>
Fixes: e934c624f3 ("target-info: Statically initialize target_arch")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4640
Link: https://lore.kernel.org/qemu-devel/20261007184612.24073-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target-info-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index d121b8c0170..b0079d44dcf 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -26,7 +26,7 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH_VARIANT),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
-- 
2.43.0


