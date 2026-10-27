Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2B606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BRrtsUiW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=THX9NTSH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmq9-0002tW-Qv; Tue, 27 Oct 2026 15:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpu-0002kC-IJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpr-0002KZ-Iz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHLLX4051095
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YiOX41g7F9vV4jKTVDaTZD5/BQDYJ5mG0H//Po+3dCo=; b=BRrtsUiWII6GovaZ
 VicDk8by66JmmAL3DQ28vBxuUCjk3jDRXkpi7voE2TqEVSxKIjQc+TDHFAHZu8b5
 fmRGjOO57kjXuWYSVqDaqXAdtoWtImcjkgz/JWkNeseTuJcDfbvCWb2rUV1t3Sfl
 u1i+gcBgPx0KL0a5EOY2dITl/qh+EX1kWrVuMyjBAKhgp03VPjTeIOVzxUv7AWVL
 Y3yEN9YOV1YYpFomve4M06j90KNLclrowQpTJpIelN2k91wx6quWqWsnoP4TIBVE
 cCDU8C0gc9U4oTIMURerMkn6U7es+7N7t3idqlGkDjizzLn0fDGoZpTp6LotSPO5
 bBIj/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk12pr8wh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1e62510cso28581685a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129269; x=1793734069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YiOX41g7F9vV4jKTVDaTZD5/BQDYJ5mG0H//Po+3dCo=;
 b=THX9NTSHsTA8X1rq7h8aFCDvO3EstFBVQdPRflMvnroZclT6+iX3fYzI1v8/fpEHjD
 FcKLtowERM/TtIVvCGs06doRSa5Evq/PTNiNMnMiFV8RMOWf0PF7d2+WAYVqer8nOHtu
 JJBCtuBow5rfVIHRWT5VWzRzx5xx9cAEfo7s9kvTL5f4mJiYhNB7UosPOuHOb53yunjB
 ZFc6y7dJeZJJOsneUtC/HMOHq0obmL9+/N2Fs5HsCBZMhoMWwgTJFVTka8L4X3SxJN0A
 Jb127mgu/aKjz5EwfqfkM5UlC91PGWQqK44q+Gp8yQnyFhsDxfJvMclNRgjdhKidWxNx
 12wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129269; x=1793734069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YiOX41g7F9vV4jKTVDaTZD5/BQDYJ5mG0H//Po+3dCo=;
 b=Sh79B0gEFO7pDOZJ1PlsyxHIAnYjMbl+YZd8n/Ga2haN2JCDOmUg4kG/FNpywDOkLd
 ULqgudInkgt7A1d1ZD0MsdtQsGqbBRmVFc0W3M6z10PET7IT9XNX838QghRrCHtanAaa
 2yhChOUI6FJ26fMCAYs/Vj2c2tV9sr5V/IAB3wiogo3btpQd/UeGTDj/a8KbeBdM9hQ7
 ZrCg4Z33SpapXndew+XjRwM8mFq1fYo28jke4QHBPnnxU0FTcGxsd9H7GDhXYsBx0buu
 wUUqP7cdB1qI3s771N4Sg8aTDPmGe4BEGBs2NpjVWWe5VEwMJIqLizhutMgZozO2ECAf
 mI+w==
X-Gm-Message-State: AFq9FYLpCPOWB/tVdii0Vj+O6gk91PtjOKalZiFXv+rnxk2hSkBsDycj
 enUoCDv7mEeq6j0qQ0sTkp27nqvQ6b5e1pcZBy2E7ktc/qOprQyQE3RBvlbsBw0Rds3XhtZC1dz
 sAqpGpQRNYYU4of4OAi0U3gA4gIqwsXgL4CvzQ8AqhI7npk34kLPfA8pOHKjiZH1wPQ==
X-Gm-Gg: AYBFou3nVop55jD9HCsPO/jYgvHzF0PhIv0H58y2+4HmMmNA0BwdJlx0GJH5nNURdsZ
 tY9xy+I+eNa7vXAw4nsXOWkR/u8k3+T5z/4AwNcxxvC5dva0Y8zPgOisQYPZs+OZn7R1md6BCcN
 yuGRuhf+r0ElzS8TTyyFvrKPeNrz96Mcl0a/ay/Dn/pJblR1t7GywIB2lpMma3hHYuCQMgJ6M0c
 aq3HaQicCv294AHqz5x2Hbw4R1cEiwVQmhvzJ6f+u1vGRy/YnpyskNwgUiYq+jgE4x/S4FJlqyF
 +EOcfLFQm5Q4/5B+mmu0+YCBQXsU1voxLHmpHdI2PiOCZuE9Vd05zzs9f4t3PXyvWB3o3zVd/+B
 88TxZKQyf5WwEJQIQzJJ9mzyo/Ma/mqc+pSAi7FfOUdBZM9RETS23utvh
X-Received: by 2002:a05:620a:17a0:b0:93f:35fc:5260 with SMTP id
 af79cd13be357-940ef94c10emr1668395385a.35.1793129268949; 
 Tue, 27 Oct 2026 12:27:48 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:93f:35fc:5260 with SMTP id
 af79cd13be357-940ef94c10emr1668392685a.35.1793129268471; 
 Tue, 27 Oct 2026 12:27:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm23687889f8f.43.2026.10.27.12.27.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/59] hw/vmapple/Kconfig: Remove unused GPIO_PWR dependency
Date: Tue, 27 Oct 2026 20:23:17 +0100
Message-ID: <20261027192341.9197-37-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 04fnQtCThK2t0EXbIE-Ki2mpwzy83nBN
X-Authority-Analysis: v=2.4 cv=DtDDa2/+ c=1 sm=1 tr=0 ts=6ae0fb36 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PcQS0Q1rpfHm3DHufJMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX54Q/+jEHsJTf
 /9pYGqMmzqKFFs5MlYNVfF16oRwsaJ47h18xUnWbWzMCyEZVhg+oYEDcDRszPVPuLHkG5eXH89/
 /HuRWfDSdPTt+OnIDzTzETOywzzsHFRQJEhYCi6s36PxqNJBoQHIPqmb99oVUZ0gjDdyFjcaqFa
 XJIOUESLGe59NXA0KzbEd2nuuDsJV+bBeVy6iwtPYz3Po+7bakMUtx4gbgacfEjxqY/kWENHtCc
 hOyX+dRxdqQhmEeiD5Q7Iepj+Fx0F1apWX4jAMe3h+hEx+XlvltV1sV3MWsZWK4Scg3wnYuJaB+
 BqYLQU0C+HgPu7Oxbz/NATKHvM5XKpXbbCWJ2TfACkWYcTj1dgyYrQCTTLIEMh0oN5LqftT3W/1
 auBeGyxeSCgchPbwvwvvhrbYg3J3q+IJ3m0/dXg+sJ4XOyotuxl4l/zxeKForrxDwtJbOJwk72K
 WcrDovfNKmyBG0bo/3w==
X-Proofpoint-GUID: 04fnQtCThK2t0EXbIE-Ki2mpwzy83nBN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX7OzgJNe4C5xA
 t9+1fKZqQOMP6hOqj+QnOJi3uhwNRJ8ERtLzFM6tq1dTE5cFzbQUZhd7N07q64OI/UjVtX483Gn
 9fAUbNftdR1yofvW+xvjnW43cxcFTd4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

The config option GPIO_PWR provides the "gpio-pwr" type which is
currently only used by the ARM virt machine. Remove this unused
dependency from config VMAPPLE.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-34-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/vmapple/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 2382b2976722..b8aa7d8eb073 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -25,7 +25,6 @@ config VMAPPLE
     select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
-    select GPIO_PWR
     select PVPANIC_MMIO
     select VMAPPLE_AES
     select VMAPPLE_BDIF
-- 
2.55.0


