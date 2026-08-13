Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE4FC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuZzd-0002BF-BK; Thu, 13 Aug 2026 14:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZzY-00028m-Km
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:17:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZzX-00027j-4f
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:17:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFTkDc3707216
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pBblWYEu3w/qqK9BTavVOzUlUmt3HTlRxSdIPsShG/4=; b=WI1UgVggeB3fo8UY
 OksCgZXZKBBXCdAFPg+/lf2DY/8samU/TVsE26g52tngSb5+7ZscGo+eHrwLLxtJ
 zkefDwJCn4cQjALIW1QYwMS0/5sMoGpuOaJkuKl4QR2cqYUI3KAvaDHS3Ch5h6e4
 GSQzrVoYcxzSH+xnokvAjjwDqK6HDTTm+hnhCQt0Z8fyv44xRd8/3MnebzUW/4cx
 4bAqk87QQWbJUUjZLea1NhxpFzVRKRkrx2rEU5H73gQKC/khXqBWgOiCO05EmlqM
 l/kF+E9QgdlWmYvfOrd0FOGZ3bB6QxvrI3uno8criy6uKS3eCmrAySarwHx+juxB
 h4jy5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18c5k6f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:17:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so22902785a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645041; x=1787249841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pBblWYEu3w/qqK9BTavVOzUlUmt3HTlRxSdIPsShG/4=;
 b=icXct97X2VM8KM6h844rdVNPoGnmOXdk7Q/UtHhjQguijxJq2tAy7xSLnxD/7qTCdg
 gqAnL7+EvbfH/WAxxV6ZOt3p/gCgjbHltrO0xv4PzyxHWR2gm+ESkhr39BndRqSSWYxn
 A1KfoNXuq/hsf+b05FafVK8VCOGFrf90qtla5K1TdAlygVlU7Kh4KOG8M90VvP+g4+5i
 kwxL6RJP/0if+4MiITNHfQkl4Ca1o9duSeDPjukbGNqVklolqw2t1CWr1ZSA35c9yD/H
 8506Lc/dkHa97nUPs0J89p+Pc4lPSOhZOQjCsiCJ4lh8Dk1tOuI+6OdJyH1q3Od7iLaz
 veLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645041; x=1787249841;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pBblWYEu3w/qqK9BTavVOzUlUmt3HTlRxSdIPsShG/4=;
 b=C3z+6LeWGmXXZH2O5VFzvvETxH+yDWRHCWCaXcjMJWuHnodQIXiBxu5XzSB/7kfKes
 8nROaTm4fpa5qB0GGtkZ3kkx3xkyd+M5iYjqsE1Z2gEIpBlQC0xEBUqaFyhOH+Pi/KK+
 XyPwc8l1eoz0K/DSt5mUBOQijUTqx0jXqQM14Tta3cLzgSXiKGpHspZ/P5gtdpBB1pBA
 pfY0WmStflBPipOSMG8n6CI1fHjZiBdJJ8Y5NiSUNAs9xZB5A1bIz3Jqx7cubzfAqmZp
 hRDa56XkwduHdI33AtDWUctA7se0JD/8eK7Kib8+hsMkc4jhp8XAwHlgVQMsfxKzNzcI
 dMGA==
X-Gm-Message-State: AOJu0YwbyC9NpZMKUn0oaBprIPARaK8Fu1xy8fybRfmEsGcLEX46Nez0
 8tdnvyo33B6HSvNenLZndkXSp7Ulp7PYq7Zt1nC74M1Ajhu2Pe9L7JKRh+vgksINuogy0NPpvH8
 UslLUbByEeaVFVKcUeryfVuFE1GIEr1IvYH38HMHQ7edqamQDEWF6tYPH5y2wXzz2hA==
X-Gm-Gg: AR+sD12D39p5qhLseaDLAFab2mn645/5My7QgIfcc1pZRaMOPWh7acWNJKKVXhdZm1X
 uvcovPCXcK+IXvEBniC3lJunqysmvj/yDPhWEpqStPlRzN6Yr14SXB4jvCtFP2k+hNWBtyp8uCm
 3RTshfne2UJtXkLjcTitmMSd6xgAn/bPyEbc9dH/+ZAwVHoXIbCT2r4dkx7ib1jkxPnFlJCTp5F
 oV06WT32DeUCv/JTntNexOjM3HNVtKhw2PMGOkC0S94puqUM9rZSZCjDXg/bjV7wWRrBW6NtHY6
 wZpDSZyl4YMosfehhh2qZMz6PzjNKhs36dzSTzZRjabn9mra4TGByGH2r+aWy04YLsCVz3eAt2R
 aUGckm5WjGdLM9swDjG9uyqoMTLO83NCkPhJo6fZvaQ==
X-Received: by 2002:a05:622a:1a82:b0:51a:bec0:1040 with SMTP id
 d75a77b69052e-52d73c107c8mr83566201cf.12.1786645040767; 
 Thu, 13 Aug 2026 11:17:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1a82:b0:51a:bec0:1040 with SMTP id
 d75a77b69052e-52d73c107c8mr83565161cf.12.1786645039982; 
 Thu, 13 Aug 2026 11:17:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982165351sm77726135e9.10.2026.08.13.11.17.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:17:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/16] cpus: Improve cpu_pause() docstring
Date: Thu, 13 Aug 2026 20:16:28 +0200
Message-ID: <20260813181640.6537-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXzFu2IyizPsiv
 btLgjZkTYBKaj6up3X2VSa7HC3HRG9JT4/fYqnvPsQABOaRF1+7EUGJa6TvetGxafscQOql1Sg/
 HUKczGhCmVLxzW48uQLo1bFw/Zt4wFk=
X-Proofpoint-GUID: LDxBX5NJyxfakU2cg6-jRCOX4fEWQSxh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/PMlM+KTalTE
 oBiV/8e+JZitpa91Bq4Bp1ylwwDP6Rmae+QyU1CC8quSNOgFD7WCXohiaNEpTLHPz2yzLwP5lKK
 IY7kdv3VjJR4gJ0GbAiaLIUUZlo2FKZrDvZ7+IccR7icigCU7ppAoM2katyhmPdyfzm0DPCUFDI
 Ev0EVIuoS7zW1u/wESP9uG7zddWTHhVpDhueWBVH+RMZFJmNN5Ov/NMsN7Dn2GdexiOllXbg5Du
 m10hEcAjX7mZCM37X1IymZYSx1N6BI+qtrH34vIyJEHBGmaLPdd8wMyfLhjTX/6D6WCctC8SbYe
 BHHqPvbr4YBXQI5ITry6QavuMSHVjAQbzZJbFg0G7FHdSiU+v+FUKJc2daQ31Xssqe61tWN0yNM
 cZh4YvxNQVDCm0aEbKncUpcF2gYFm+TDrepDrljpZUbcLZHlQFijoSaAWVOffWvyphDsWw+D92y
 EmLGQAUmY+riRu/KCYA==
X-Proofpoint-ORIG-GUID: LDxBX5NJyxfakU2cg6-jRCOX4fEWQSxh
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a7e0a31 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TUGipdnbivDJOOLMS8gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130132
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mention cpu_pause() might not be immediately fullfilled: when the
requested vCPU is not the current one, the request is asynchroneous.

Mention the method goes in pair with cpu_resume().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 81af7b9ee1a..f1ac492714e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1045,10 +1045,13 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
 void cpu_exit(CPUState *cpu);
 
 /**
- * cpu_pause:
+ * cpu_pause - Request the CPU to pause execution
  * @cpu: The CPU to pause.
  *
- * Pauses CPU, i.e. puts CPU into stopped state.
+ * If @cpu is the current thread, immediately pause its execution;
+ * otherwise asynchronously request it to pause.
+ *
+ * Note: Use cpu_resume() to restart execution.
  */
 void cpu_pause(CPUState *cpu);
 
-- 
2.53.0


