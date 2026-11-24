Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B737606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pW5/srW9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QMY+sQqH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwN-0001gW-2h; Tue, 24 Nov 2026 18:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvh-00016x-Cp
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvc-0007e2-Bd
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:03 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMarZF886574
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /dSDpM098GRFtt73hClqMhsIqOpuThtQ4dFm8mGh/Bo=; b=pW5/srW9JR9m9htj
 CURvqLgIE2gbVWMTCwH4Q1NExSRuWOjQFIMiyTpv0iDzLLkq9hEDx/qHascZDIpf
 qsFw1io0W6kOSYhWp2jytLPbNevL5nE6t/DCxMxqNbgCx40+rIjZaysCtpefR8Si
 51IWlbe0MTo2yyasGceeltWP7uN0GGif5AY4SJZMZcCCAIVYPY8d4gFrkBBwjRR3
 ku5wQYjsC26XkFjrGJ/Y+j1CgqFTSyZOa/4llTxaqa2IT+89goTVltI5gtYW+tly
 +nhHBL0LG2sb/kCVTj96gAOJiz4VWpqy04YQ4p7zM98VoxOxBRtNkcM2cdub+5Qy
 75s5Lg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhcbcc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-948d83322f6so300783685a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562876; x=1796167676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dSDpM098GRFtt73hClqMhsIqOpuThtQ4dFm8mGh/Bo=;
 b=QMY+sQqH/YtC6UXXuzJkCqbCNue0iHovGRzivAC64wWZ4ZsQQtgNQq3PZ12gNypQOM
 dF6UBH5YoTEajvWze2WgvxLHAiTDOMLiTeVQ+Qpjf07j0kzljjt6am92hW1kj5QUrMJz
 6q9mJbShaKurzLqT/y4XUo2wwF88SHLh7RQ9y5qP/HKJi1XcVc75KAJrpBkWbb4dYan1
 WkJUf4A+6SvtVCpR1aKaFUVV18LIQDNwxFRJACDs2mtdsShn/ohDWw1yY4c+N2DMzXlx
 5kZFwvgUBsFzNwsO73ZpPIyWC0Dxawro9Tmnh/auH8Fsl+bmyUqciz78EcrPmoAPCe9E
 gfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562876; x=1796167676;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/dSDpM098GRFtt73hClqMhsIqOpuThtQ4dFm8mGh/Bo=;
 b=OP9SnAtpo8C161uOJ3WNhlfjQlahLP51+0Dh7CCZg6DOtHs0iyPZ3rPx5Y9RkuCWwv
 bhET9ApJu4hCV9PhqvBDWUDOupYvnLA47q+53n3G7NsIpSZ2eMIuXZpyQOhKIrQsqZW0
 rwqHqR7Xs4TZG489MMVPJ7/qm4roC/crqTdZhce+vkAu2OZYrieZ8OpVPH8x+0sR+3Hf
 NCNEtXcBY/t/DwuBSH2ZR92K22PZZi+KGL846W6csMXPQsUdOa9rLsUkpIc4Buquxv7h
 YB3m1Cr5YFOgpNZaDQ572fsZbTjwQx7PpuCzABMLQnxvyKUGsq740t7HJElE40I3ItGL
 QXaQ==
X-Gm-Message-State: APuU4Z/EEq9psKpYdgs8dLhsRHSBnXxU9kiv8XBYm697F/UenoeE3zYL
 ywoxGJXMZhBMoYUMFDkogovC9AfTaFXW5e5ohmIakuARB9897heeYsPP/bBgUGCMn3JXHNT/uHJ
 TeXqewdiDTtyUrQmhSqfXwyNlvXNfyUBhh4+XuSzM3mOdN1LkCGyJpE+aWwF94dfyXaxF
X-Gm-Gg: AZFdTZey5kNQH2zFC/x1yKJEpy2Qq0zC8x4lBcShpGaI6d9VJ0EdUgcfoQKHUgbriZN
 qHxQKfXy/SlsSTWMRxZ8juhZXfJxciZxyehNHAaq7lhfgsBlTlurGixllx0uDKOXTHKeExvp0kl
 In02Mwu7j7GdVCG7k5vCdWiSvG3zF/h3JEeY7WNjQGEc4ZRxKNUMfH6tHW/Cj5JMeJcBccxz5My
 FamSjtP8g/F4dmzHFd5kLv/fHrH3xdHeyjY3RaZD++jlM91sGI54FGIMIASV6FTtuBANuFTzAKf
 5AEUDTzeDH3RPdRZ0tDYoJ3S+zMLtpH3/MT/98MZy4kePvlg7kv/sq6LfWrygh9Z3QPfuTFCwbE
 WDFt9/ZoH7syzvovxL0Ve9d3w//a5+50v+y7Xy4ocX14fp9D8Db9TFmMW928gjmWKK1tCkh/Lk/
 hi0UpztaJ43XiOuQ==
X-Received: by 2002:a05:620a:6c18:b0:949:61fc:88a1 with SMTP id
 af79cd13be357-949ba81a55cmr2588837485a.10.1795562876360; 
 Tue, 24 Nov 2026 15:27:56 -0800 (PST)
X-Received: by 2002:a05:620a:6c18:b0:949:61fc:88a1 with SMTP id
 af79cd13be357-949ba81a55cmr2588835685a.10.1795562875906; 
 Tue, 24 Nov 2026 15:27:55 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm867704615e9.4.2026.11.24.15.27.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:27:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] target/m68k: Fix TB_FLAGS_TRACE* definitions
Date: Wed, 25 Nov 2026 00:27:08 +0100
Message-ID: <20261124232722.90234-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b061d7d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pcZqCyVeAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX5MgcFNl4ZRY9
 dV1QNldPy7T1619lIpWHNUlQJDTcmjgZEjJQ7nhjYk6bNSldNpU/bEBVYilHHU5RvF4qpIvLq0b
 ffBnx6Vy+uLTwldef7Pqspvwbg0XVS4=
X-Proofpoint-GUID: HhVhFmn3OUzKf_BXxFCYPimWu1aZzTiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXz6ZsVnNyuTxb
 xMIvgwEanQqT1aM6eDJseSGmfuiFafHq9AaVa+St0aiZSf0gEvcgZcr8mOd8IkM3CMp8k5qtJeq
 IcFfX3HrsyhohYIRnajzTfVa06j0WLRFBN5sfySAKj+2Ci35ivwzoQ1aD26jkOxWKTVIMw8oMsX
 3RYkRG/hP+zVkxnRL/P8CjoAnkxMPWbytjpr4td0s2dhh6o2JKzm4eD1xtk+7r+LETbHVJZ0rcE
 KSoUGI+IkQl+7oNV2G4qeKJSnnzRTFWVS4dUHVAxkmXKmfLKMPQ++BhH/iOYbSl94s6EsZ+zoJ/
 oYSsi+oDEQTegsquJK0HjwW9Ab9XAs6lTx0t7TX/5U6zTkCxp9GxJpoCOPe7RwACK2ujwSelFQP
 W2vpi+MPSRcyNerjHHlRPBeVBm7Huamdpr/cDFBBorBxN0MF9+isNPyFu/CCUC7ivl/1zjBs42K
 1+jBZPcGENdnDh/YBzA==
X-Proofpoint-ORIG-GUID: HhVhFmn3OUzKf_BXxFCYPimWu1aZzTiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

TB_FLAGS_TRACE and TB_FLAGS_TRACE_BIT are swapped.
Fix to avoid m68k_get_tb_cpu_state() set an invalid bit.

Fixes: 5e50c6c72bf8 ("target/m68k: implement m68k trace mode")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261117080747.8035-1-philmd@oss.qualcomm.com>
---
 target/m68k/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 781c98f78400..5adca8ed49f7 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -606,8 +606,8 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_SFC_S          (1 << TB_FLAGS_SFC_S_BIT)
 #define TB_FLAGS_DFC_S_BIT      15
 #define TB_FLAGS_DFC_S          (1 << TB_FLAGS_DFC_S_BIT)
-#define TB_FLAGS_TRACE          16
-#define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
+#define TB_FLAGS_TRACE_BIT      16
+#define TB_FLAGS_TRACE          (1 << TB_FLAGS_TRACE_BIT)
 
 void dump_mmu(CPUM68KState *env);
 
-- 
2.55.0


