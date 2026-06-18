Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9DBCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBtL-0002hF-SY; Thu, 18 Jun 2026 08:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtK-0002aT-9s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtI-0000WI-Pe
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAtNCO1374287
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UDPDfIWhoce2Ph4ljd90ZnLHH2Z1R5VRHULjQr4fJbg=; b=f17sGzGK9aWoYObe
 9m8YdE6HhEdYKnd65M/GFRQNXuLcdjxcVJyZyZAT+TMNMJBpSyC+nyxuxvBdgA3F
 f8uIoiO7h54IQdm78a4boofhJ9ZT48qRPjSgzwa9RsuGWnb3xEbaPkFPFEMdh32m
 HnUbNjRhi8D5pjGbQgum+JGTY8CdvXz5OAsTPS8YWxgu+YcfI9mOuGxA7RtAyLhm
 NMRvFTppNJTczKKi40/d2N/8Yos0avO2Jem+SS7aSmTRVFkFFuSVKBbBZsr7GHHc
 GqdWv2KUG/aGz+AB5WvKk/8dwdDbbq846uRaade35L+IyO2yg0kcMm70lz+nXoHN
 uLP3QA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rtu6s2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-918622c3c7bso254189785a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785839; x=1782390639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UDPDfIWhoce2Ph4ljd90ZnLHH2Z1R5VRHULjQr4fJbg=;
 b=J1dlGyW4n8ZtAiX1vUsVIVT/gnP5rquwksD4n2xN3LPClh0Yg9214E5jc3szzpTKR9
 PCcYfGmmGloV+Q9fTfmyq0WgACS+0QL2YnIeBL3VQ4zc5sGVaBGx3lyiZ8IVwJIHIOmV
 QgN1boPWtSa4I+zNlUE3OY0AzS1HYdfgHXu6WHx7u0jc18iuCWpq4aoK3sNC/YHDM1x3
 2Rps2H9GFTPm5fyDhubCKzaj6anzZgi1JtLTBbZy90KaEUsYy+ey9ec74VmN6kK55QHb
 pst5+5NfC4IUkm0jGYPUpN+ebf6x6oBw7t1Tm7LsP0bMHZnF+FWAVD00sB6CDyliG2r3
 6s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785839; x=1782390639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UDPDfIWhoce2Ph4ljd90ZnLHH2Z1R5VRHULjQr4fJbg=;
 b=LMrktUPTPMyMlWKlGfgQSe61UlmdCmTcMlOrIPYTAFhZy1pbSg+nSRPva6CFM6xn6B
 uOAKbwx9BeSRS7sIaZqdv9m0f8leqzkhTIw/lWWd6+6IaHC1XpxiBzCHSblYCvdKXr6Q
 S91yDRQzyUqWlL/UOy98cPjqFdkQOj7UWjokGV4NJtx1T6TJ+FCJE5Omd9KwfWbDiU13
 GmXKJj1HG4KFKBiVgsiVmOeBzCTaBstQ8o+5BH/oEDt/2y5u4diaOqwkY1fQz7VtHGK1
 jucWZ9XIm0wXfg6GaITzyXIZULC7LXQyaPly144CcWuYTjvslMar3TUiSnMymEmE79A1
 2vZQ==
X-Gm-Message-State: AOJu0Yz1/kYjNMKrb/w3HgPdwaP+SHP6h5pEBu1wD6PUWPvi/VKTZDEg
 t4wDXUlDH8xCqwbOV+skcBpV0EpRXE7CLfkUwMQAGsQNSx+vYG/NXh2HqT9j1jGyQK1RFV8PMCQ
 XZER9eOTBZpmxzhi/5jdokIswsXpn4CbdaOhQeKX/qsaqcrViJdsMC2tQ+W6pjGD8bA==
X-Gm-Gg: AfdE7ckSEZliHBai24VGHPjbrvkoB5wzbug1xkK7H3GD79j2YCD8xj2vxgBxLlyDv4O
 x/ovLktwPknW+eQsT4J6/Br5+qI3BAR2NZ6iicWXFtFHQ0TTho3hRvyHB/jDeV90/5VavliUqQh
 6+OM+h9eZEJw1QKrY4qnjxMAkBBzOoOu6g1RoLnq++DXzsr6BqH5GtLamR/qalWKGWBN35MQdr3
 7VBxf9cwPGRgYu8/FJfPWyuDlkBmyCdA39OEaB7rUE5bIk3SrEU6ZUihG53eNAfm0yr73kmMQul
 ZT6me30/swCVf/MQy9FCO/iOFgCcHaujXwYxt9yEK8goepxOxhKozusllLA3dPc2AN6UBAHUdlH
 aScTY5zQH0H1jeD1o5qhOJzM5u5zcnPeZ419gICa1RPs4kflkFoJiiIsawAJmmT7cqi04
X-Received: by 2002:a05:620a:2992:b0:915:96e4:e49a with SMTP id
 af79cd13be357-91f25f93641mr503844085a.1.1781785838738; 
 Thu, 18 Jun 2026 05:30:38 -0700 (PDT)
X-Received: by 2002:a05:620a:2992:b0:915:96e4:e49a with SMTP id
 af79cd13be357-91f25f93641mr503835685a.1.1781785838281; 
 Thu, 18 Jun 2026 05:30:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49234daafc7sm127247985e9.10.2026.06.18.05.30.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/48] target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
Date: Thu, 18 Jun 2026 14:27:55 +0200
Message-ID: <20260618122825.90331-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a33e4ef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ylpU6RWR4UZmXHDhewcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+Et7rzE0U9xY
 UVgMAsFA05wARSWT8exiEJKWmEatU5qdVZtxLc5ITQdEx+64+9JaVv1MKoQxTTWSKrHB0P8lohp
 nH4iNHD8hwunptUK3x/AtbMBNOrLbYQrvyHqijDchkerBnxQ21ywwhBR/WzQVkPsREMBbASg3Pg
 YLLbgF2rbLkflFGKT5FXukY2FyIwNB60d+UW9Qmupl1tNbxcmq5Y3pU4n6d1TfIExnY3vsZLQDd
 vgSX7dGlaxRyqcWbmk38xIEA6Om7U9I7429A6pBlua/HhTlpaaeI4Bo+wPgASh8Dd6PvG8g/34p
 34sGoUkrhHPDnp9PQ6FQQBVcLHgx2Z/7t172pRrbDiifAhMzOKJCYqJvvceqgs10po67NY/LSKq
 md+OnxLGcMxCaSC7F6zET4CVW8b3/rYQub4IJm8ZLcEmCVFAGt+OxwaYyLbYyhNWeJJeRfoVDNT
 X/rZ+VSYE/PacthQCbw==
X-Proofpoint-ORIG-GUID: AWz1G5uIeUxyK0Ma4uRY1xCcl0--yzSO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX5GyHuB1TqTET
 Ir+ngb7FWWaOcu058j0ULK3KdnSKaFiFj9O+C166hgSvlvZ/Ng/NWCPNGuV0H8QooapDGWh8PpW
 rnt0n6vK7TZOj5Qu8ZNAmvJGplGpLcE=
X-Proofpoint-GUID: AWz1G5uIeUxyK0Ma4uRY1xCcl0--yzSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 34c45d53026 ("target-arm: kvm - re-inject guest debug
exceptions") removed CPU_INTERRUPT_EXITTB from KVM, but it
also appears on HVF. Better to restrict it to TCG.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20250630130937.3487-2-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22e71a28042..a234aa031c0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9633,7 +9633,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
     arm_call_el_change_hook(cpu);
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled()) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
 
-- 
2.53.0


