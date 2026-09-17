Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE930C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7G9w-0002Y8-DS; Thu, 17 Sep 2026 13:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9p-0002Sz-NB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9g-0001ao-4T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HHhqj71683050
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YMwRPIQjBc9
 B0H7Gcd70sCpPVswh2gpmygYWKfnkzJw=; b=Msw3FWtyOlpDV+9NMKlljUjfrst
 ZHcR39EfoBLzbSa8BFCsJVvh5r/cy0ZY+Ips1R7Lf1nV8hPcBL9qxaDfb0FnnNyb
 81Q+bz2hmTuSi8OucusCraRKBK4yrB9ceWsl1wA1YLknvoiFLvj6MT6Lsx/U05Kg
 GsyuIbEaroblhpWcdg4BGaDWnd/YdZ9ZBZt9lzPDz4OQNxTP/WxO7Sp2cRa1GuP9
 yq3rfr2BbCG6/lz04RfV4ERmEvMjQTSMGYTFlf18ihXtqj2+JTsgRi5eAbTsde4v
 dnODO59ggDqdQFxbAc540nOZA0PIRice/lWEtMTRpoZceXOCctUwcsUigtg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grmv5g02v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91051512080so18732916d6.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789667053; x=1790271853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YMwRPIQjBc9B0H7Gcd70sCpPVswh2gpmygYWKfnkzJw=;
 b=bypIvyiV+xv0Goh8GdaHg1BfUL9A8/udnZkK87yY/wUBqfa3BokbbKPDpv+b8rhJGr
 K1BPwXgpiUd8qjQ/4FVPEUEF4d42fE8NeYhQcqCfWW8aTGFpRGORLnNkAucMFQ5s6SkK
 iVRIgqNDfkdifST1ITRuLKsAebGDd+IxLjfiOAGLL5g7G8dvEFblcFR64A370ESyEpy/
 UdgPny4+lBfM3hf9CWsLhI1BVfsX4L1fS1cv2oZ0Ajiz3ov70MQMX5YVNfKvqO+FcQU7
 JX+al7LQk4eZWaz85y3L/Lij0WbpHbx2WGj0iazK9vyhv/yLrBgJTLCXh74mW4RrTPhK
 9aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667053; x=1790271853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YMwRPIQjBc9B0H7Gcd70sCpPVswh2gpmygYWKfnkzJw=;
 b=EUJA/70bNpwZ7DmIST6jEPr97rLk0S/5AaeyTSyGa4EUAIp7d3DEeE3cOD6D+0ZkOn
 2FIrIYfZ13p99b/Iq5OtZwxeppC7aJajb+9uzj+uGjpCm7IGesb6XmtfCWpAGZ3puJWL
 O6uKGkPXxzNpb1rNYGnXSZZkoBccUJnNoGhiHQjp3iWQK9iY3DYu6cePKCZ1EMurk8o5
 X9XjG+1VQlxuMEfTyBiUWNTAFFdAPbNXRnvvz+dmatzejfyQCdnU/+7Esb4pCt/TiWEH
 Xp52mKL2xJ3puqwzQrKX8vs8HNivJelvZHCzGXy0EQqo2te6BRqmXoTYj5oxjSYxAqe0
 FPCQ==
X-Gm-Message-State: AFuF++nVcHNlgKYZnQwRXrsZDFblEZxS0Ni8+6ZWn10X1rb1I+OQ+q/q
 KPYifIl6dvcCYfp48ZtBm+aj6cyLEfcuvfecpnwaFv208k0RRNY2QlcdMQ99R+KHqyuE+ZdBIPM
 afApQ8K4bd1BcsgKCOGVtJ6+aCtcp3ae4K9qL8ErPdN+b+uC6rvtYpGZSyTrach9E9g==
X-Gm-Gg: AYBFou3h3hqKwe6koPCl10l6ofxOHTNiiHCdmcjtU1bzrWVZZPYpla9/TnjNa2jgLey
 pKCvnyHcvwyI1Y9hLi0ro7iMb1dl6A6m8rVDw4oXk8Fut2q4W/FJa+ZMSSw4YJOSjTfpdvz6HdW
 ieFpXzKOC8TC9MljeN12rYKDS3qGhPqGFnYaf+NHjfmyPRbp4ksySHjzyZCq00+N61prJhFwDau
 eX4VwLuYKNeh3rrHUx4vHBw62I9JPbvoXS5HAnqx14KA13FTsSS9M8dpRBIfVfpxubB96vJ0Auc
 SHFAoXnvuLGk7GILk5rIIcE0IwGOnMYX4dsscU99ZWg/kTFs4+5uX8YRaYg6Fkho+bY52njNeiE
 Aa9xQmvheuoSD6yAwIAyyovlMBsS3k3fP54kAnMc=
X-Received: by 2002:a05:6214:19eb:b0:90c:d6fc:e284 with SMTP id
 6a1803df08f44-9123d79d2e2mr157563256d6.17.1789667052729; 
 Thu, 17 Sep 2026 10:44:12 -0700 (PDT)
X-Received: by 2002:a05:6214:19eb:b0:90c:d6fc:e284 with SMTP id
 6a1803df08f44-9123d79d2e2mr157562616d6.17.1789667052300; 
 Thu, 17 Sep 2026 10:44:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c56d73sm3118136d6.13.2026.09.17.10.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:44:11 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v12 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Thu, 17 Sep 2026 14:44:00 -0300
Message-ID: <20260917174405.3471736-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MiBTYWx0ZWRfX5B4vDtZgTxui
 L4O5H+JSPomPcjRi1Kci7qD3fJ8kmIKVB7w2zp67wlHwr+et+kSuAvlHg/W9lxzipXQLhIOxPlb
 zhWllt1KUj2tzNbkmWeVQhGTwZiDuQ2RLVerJzl7xO4L36Za7fhz3IVokN5ANAmzpCy9y92/TkZ
 aHSZmxQ7nYl6uo0gUKeKFRaFP2tdezEeI2zr2KaI+AtE2lgXBo+CNi0czCQqiU7+CCytFn0hVtw
 bCixdOjbYyKXjN0At+Bk89Q4mnqaUYwvmunhPk9vIdPprvZb+qYfwk0i7hQQTd/epLof6ivS/dW
 YaOATIQ3Y2zlfGjUSlR872l0ZQSTib4NaiyZT8sQPSEMNRL7z6SbRbegBmDH5lIrVg3Kw1GESI2
 6qA2oOLaX+TpqKoMwQII+cf7a5X1cRlAzMM+RVB6k9MGka7muqRb5bOr+gdC8buaYLH49cjUzc/
 aHweM9J0vc3ud5BnTCg==
X-Authority-Analysis: v=2.4 cv=E+5YNqdl c=1 sm=1 tr=0 ts=6aac26ed cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9
 a=OIgjcC2v60KrkQgK7BGD:22 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: yM0zvkNamPWj4Lx17CUmgM9MftuyGc_h
X-Proofpoint-GUID: yM0zvkNamPWj4Lx17CUmgM9MftuyGc_h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MiBTYWx0ZWRfX23VOTgLpbXgg
 eMdZTGgaRaDLpddAf4d4S7hzS6O1AZ7EQdCnz0nX0aCOUEyu23I7/YM5b4etwD0RAlSAWMJLOYV
 ehUsMfwDeOHejUoRzLEqBLmxNp+2MUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170252
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0fe9762022..41e52431ed 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3104,7 +3104,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


