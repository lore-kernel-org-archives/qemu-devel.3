Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434CACD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVrc-00058P-HO; Tue, 16 Jun 2026 11:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVrb-00058E-OU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:38:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVra-00066R-EK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:38:07 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxfNC3970149
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KumyMv6nTCKiIyWevotr/ceX97A5tyESiFXKIabKKHE=; b=MxPrCUFanPc8LKBL
 TT9UH9ejBzMTILzKyPNqh9+hpiJyQRu/F7vRvEFU3gURok4JDjEbfD0QsHb6mKP4
 UWLOlvYRVyWASpTpdYsk0ESo29xGYbX372ai9XBQMXVAg9LLkLYGjLJMI4iC2coD
 amDgaaIWox7awqmtZ/vOgBWG1rz8woejxvHaQI7tmRs2fApdoD2N5LLdZ9+H/kMi
 rMQTe8kAXbR2sP23KyDueryl/2+I3e7eOAldGr3i3yopXv5JigHnnvg4soVlS8LP
 oeMH4yAe0PdKPjOzIf/8oI0dIIQOfvjRjjOEVsiunKAqm7HRc0GoHXBaMex54SN4
 sw7LCw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkhh6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:38:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c69c788ce7so2091348137.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624285; x=1782229085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KumyMv6nTCKiIyWevotr/ceX97A5tyESiFXKIabKKHE=;
 b=RFd6q7SfhgUwTW2XScJTlBOGO6sJdPqHdZjYFvoxd4FUlP3eMC8yiWXvQPQczpJYkp
 sW/BFlYP6KtRdlaRUzsWyOoLA/jfnJavwYQsUlt/WDqMSsd+kGb3jS5QInGU+VDUyHIR
 3AxSwvxgXsomTc3o0lOmumdCMoDi4dfY4bcSb4jAXNZSBUHLsPGfiB2rrz1NFT6AIn5v
 HfKreWG4dz/cWsn9Qzw+l6oXS0Fs4U/AWDSnpMYjP50HEKPbe51vGoU+cUNcFg0CyF7Y
 z2FjOgHuno5l8p986UN3Z0mQmY7WfrKAcvXZatrgrfh03OEfnvnhM8FRwPE0JOQLmbE1
 4o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624285; x=1782229085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KumyMv6nTCKiIyWevotr/ceX97A5tyESiFXKIabKKHE=;
 b=TNCeIm4TVPPgpuGdbZqMAi/JjE43GibrGPIp8F6HIpwibnolyhnjp80Z1wbiZuihKV
 joa892A4JNkCWZTSdpmuomgpIra8k/gEiMVxqtse1vI/rWS3F2/T/SocRyyqYKLZfAZ8
 3+UW2BZYQZs6AZabsDfYVM4egJKi2MiNKdivwN7y9NGFw6qVUIzVSAkf0aDoAxLbhEV4
 Z1HB2JR46UF5WeB/7impw4WZe07hnwycGocwimC1t5XqXDOBXn7a1Eb1ojqOhvUSc15R
 QPbcpkgdsYDaC3o3UCZR2EnRwKH67t7731x52HcyC1vgquS+67gR6FOLTlWhzeNkM9qC
 NfXg==
X-Gm-Message-State: AOJu0Yzc6jsWJPY3L8y7IC00ynQPXCuY8YIlle7J8ch5QhV8dudr75of
 kznz2IJeknk8nfRDC2h9mS6wN83GZqAizd2SOgfNnHYzEmbeQlJt294hzLWm6t9DzwRw19ZrQ7I
 CFnPTPl8P19IwfXkkL7ZEK/WPdyI4DnM3FhAF7Ta505jAjltlaV1/tL/E+QTZFlOIXA==
X-Gm-Gg: Acq92OF+Ulqbo/+IP7G6oOia4f0RRJ7U4AR7u9A1YBHZ4u2TMTkSRYrJBcgRO6sH3nA
 bzYT0amsQxHihUMfZ++RS5Uv7p1k4t/++7Dz4YcvTRkxHn6V+EqdC7eFLtF1RJoCMgt+3Z0V3Vv
 BCICt53n3hRS5ZHQ2iDNDXum1kyHAdTYrr23zhuUQkf+Rn0dt2rBTQ/VndmCzwvd0Nny63AfLnE
 hPQU64PE2ULbBnCbAb/dLAPB9yEHtNQZvYP8fQYYbFSwnWuF+UOUW4GMzoCwEL4y1Bmh+Lbrn5m
 L4Q0unrjNUdlOFLkJaSp/eLZHxJd6zn9SIbQYFS8skxoYhPh6u8pfVvaGwI1lNbAmuvbXanKK4O
 oEiFacq7hMYQyi7Z2nJBclU0fOUHV6HyepL9c/EsKH3yvmvrnc71QAiNOYUifNWEdxWKiw9wZ69
 2mrwg=
X-Received: by 2002:a05:6102:3fa8:b0:631:26f6:7009 with SMTP id
 ada2fe7eead31-722da69ea02mr2508384137.26.1781624284705; 
 Tue, 16 Jun 2026 08:38:04 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa8:b0:631:26f6:7009 with SMTP id
 ada2fe7eead31-722da69ea02mr2508342137.26.1781624284253; 
 Tue, 16 Jun 2026 08:38:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea95c51dsm306715485e9.1.2026.06.16.08.38.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:38:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 1/2] system/memory: Remove unnecessary CONFIG_USER_ONLY guards
Date: Tue, 16 Jun 2026 17:37:53 +0200
Message-ID: <20260616153754.93545-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153754.93545-1-philmd@oss.qualcomm.com>
References: <20260616153754.93545-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OsOhmVX2uQRyuBREu3K2yXm0_IUQAXjh
X-Proofpoint-ORIG-GUID: OsOhmVX2uQRyuBREu3K2yXm0_IUQAXjh
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a316ddd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KiMNzvkSgtQTp0lk4wUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX6vb1RBu8mkQy
 J1GcZJ5a3L/wdb+XZ6xMSoXK76XGuztluWkapGkylSo1lPJXLM7dEMgS8DX4sH0LFApbCqM4U1Y
 qAGpDDEwUY/Rt943Losj/zLw+KAraTVDY5TgbzTDJxfh+D2HPBg/uoFA5y3yVS4J6hcgbvSDZs6
 FcCJcu1CnnYJuoxkN5o7eh36WMwr5j+NoCZgYSBgqWcJxE4K3R0rmqT+Y9hr0ZjJ3GiyiScNNHS
 zxpTMfR7oVjd3cgznTUYZsVqy8oeZD6h35zb8KOQVacRF1fGZtjzzR2st6eesIDfg45fWZOe6KJ
 ioKHGgukWNlIOoJqV3onoa9u+2J5ygTAKmQMLJcxk7GIDJkW4aZWU3l466MBdZINr6BWiTxeOoA
 5WliyT9J1FEx2xyq9Ul/VFyBLgej5kjFfiFAGMswrw7waO8ZVklSa4sYpEfbc1oezpgaVJKO0wG
 uk3H/tyhn1NbVC1UCog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX8m8IRuIzxPhH
 HzOyT36a4oK1dk5kSymAyji6P3suK2I2ckbuozjgxPpSwjnHN0JTvkDxsqHQdY/Z+ANzPvIjvtm
 GjKZdktlumo5O8ul8CyKnf2B8eLwOuo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
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

This header is only used when building system units,
checking for CONFIG_USER_ONLY is pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/system/memory-internal.h b/system/memory-internal.h
index 0066ffdffb6..c7573a68b5e 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -14,7 +14,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
@@ -57,4 +56,3 @@ static inline MemOp devend_memop(enum device_endian end)
 }
 
 #endif
-#endif
-- 
2.53.0


