Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9B5CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBrd-0007zL-OS; Thu, 18 Jun 2026 08:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrb-0007yp-DX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrZ-0007X1-QN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArgTX1054960
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82dFeWG41NySdoeq2EmNII48adA0h4g+cc+/YSVjXaw=; b=px1Prf9VE1i6Q0wS
 IZqHz89mOf0/ZKxKMdBeX7f49u8fzuYexN0NLTJPEp4ty1tp4Y3lEKqAn8HaZILu
 JJLPvY4K81JgplIbw9llao4QUXflCG7NxZ77e/5FlsrnXh8boDLXEO0WwyThcH2f
 N7hnAHrw71xYMtGjAZ+BJNwf5xI890L945q/7br+M/tUf/0PytNfhlkmm+yWakP6
 9PcHkhEL7HkQlWGCn6uPmdx9dJ+cByd2mtwhLaNpTszE4iH0uoz+tLBAjWYP/0BH
 olQAiArSYLIvMG3nkojx5nCom7vFUOntZQX0az8DXeJL8Si0TsyRAXR7RUPsYUra
 bbU7Cg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccf8c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cebec24b12so669096d6.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785730; x=1782390530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=82dFeWG41NySdoeq2EmNII48adA0h4g+cc+/YSVjXaw=;
 b=VbzSWILkNQycJKfQsuSJN0tAZK2pHNSEfTCuDTGPnXPyKZ2FkeiJIUlKKyOTgn72Mn
 YqiVI00U/EUh03UGuHN5MWNywjYq5NJnCSOoy+rfJB3Wl3DOsqb3t64VhgbqgkqG7PPd
 3Pgz+MUHUYQLyet5Zyb/1j+OSwWtz2qUQNqdZqgXKd4MLYigECZGch8B5x43nptamXCd
 Kaob3yimJFih0zpeoP1Ruogq03gaFt40flwUcBFFa3egRfdhzTFIwGo+Dn1ik7ravDf/
 BASwMkNESAbNEoF0SRdmuxPVMBxzrt6hgn8RIBGoNXLcZ4JxF/WlSrQVrgvUHodHgaLZ
 rGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785730; x=1782390530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=82dFeWG41NySdoeq2EmNII48adA0h4g+cc+/YSVjXaw=;
 b=AmVxbmaLSIJYLHTR/E3rEN3sFgDqSY2j6J3yg3PoipxhOt11vPsGzeHnB4owvG0duP
 p3XfV8LuU/fxpQBvd4M2KyUna0U5YdZwA9usb07HCSR5K0w2UUgFbgUTSN8F8vDXM60v
 foqvhJumZVoUwM5Y28WDJkiltayW6zFFSJKMv+ypoN5E3RpI1hDTXiHbUuxpOIa+p4Nz
 WfitFJJtsD54PPL7XTFzpBSOWnZE7plWA4JTqxRiQDXZAyaLAKWjmWf2QCYhL++XDzI8
 t9nvVcJ/31yg8Y/lh5t6/VEzrqzrrGRDY1slLYOAojyWRWAnoSBmEvZHUjo9+hrihvEm
 58mA==
X-Gm-Message-State: AOJu0Yz3hlEQdwv6ichYezHxH1Oqx5Qr7fjXwR4uy9nfUZBiI4JW0I2S
 /914CKq5k9CXlz27C/0WSeH/i9yW9XHfUy5R4wdvsd0gRFHCPrx4Wv3BUGORVQhrMwd+WFlFLgX
 f8YFGRcRAg9Uu0i0VgxOTd1szbJvHvmjiNVbOZlON4bW5LDFiD9D/NH0LcyWI3wSVNA==
X-Gm-Gg: AfdE7cmUsADbKosWurMrIceIO+0/hc2TewGHJ3DD9NCeOvfLyTDi0xwOv0e1XLD0Lbl
 CfygfOec0qob63CBKqW3KyTHmh1k0WG3ixv1n9sQgKzSJUPQaPG4NYhajnR7hrlLxG1c1lgZmyO
 H9rt2AdtABGe1AjlmzTSsSaFRWL4433K/GSq426V74tFWak+We3sbYT78WsVhc0WIq2D9opQSG5
 BBPHWS5YDbmNfdF37/0snRmRYzs4MCCtHyNEHwkq3l4VK949n2xZBpbwH8c0R5oXHMmJuAEhv4m
 li5sqNyYRBV5UMwrJNAMKQS9yM82h+8fajDpQCxxx4BvQ5ix8RUZifAd5uUfpNuK7QZZBOcLNIR
 XMGu0bIop6vgRWxAJFzdhVpcRegkGUMuSCOmzxpoeZUfpik8iZ8V6XeeRj8vI3ywtoylg
X-Received: by 2002:a05:620a:45a2:b0:916:1612:17c8 with SMTP id
 af79cd13be357-91db9c8d5ffmr1161071585a.17.1781785730321; 
 Thu, 18 Jun 2026 05:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:45a2:b0:916:1612:17c8 with SMTP id
 af79cd13be357-91db9c8d5ffmr1161065485a.17.1781785729717; 
 Thu, 18 Jun 2026 05:28:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a154446sm30219185e9.0.2026.06.18.05.28.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:28:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/48] system/memory: Constify various AddressSpace arguments
 (flat-range)
Date: Thu, 18 Jun 2026 14:27:40 +0200
Message-ID: <20260618122825.90331-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX4TooV40sL/tH
 413EdhE5WsNMgTW8JK/MtBK0oZVRLHJuobrAv4lOhTiRe90XOv9Fad8XaLfuEuC+wgfFqV2UJQj
 7rZqn/K10GIaP4fQP5CBwPbP0npHUEYuiRCL/JenGNgI9UDhCQdLWF63vR4rbyb66cczxZ74AER
 H07Nx3a4ap8+UbsvImhu0vKVmepG41bcryaOyOSNQjph6cfUoyYWSPgqeA7RJlCdGBV/t3vEP1L
 s/6iX9fB9JsGbd8q8VOpqi9BNORD5PRK7tqlDzqoMe2AtG4TF12c0E47JgHnG+ktY55n5xQnKNg
 6EjWopWtBh9Kd32uMLS77BC8LHvj2u7oLE588oy3kBDQ7EKMuGduX2f+upz4WVgxfxRhH6Nv1v9
 VAZAz6f3mN/UjSBsm6DsEU+nbX3TUySZhnGveFna8WAX6CSVyRt3IYgBVxVzVApdGKrtJmm1b96
 j4EbDBrUXxcQWcfCTjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX3Ouk6JpivReh
 EujgoV/SnjogqQL4GY65b2+u3misD14/MiKCLnr6pR+yPqt3zSNLWsfPBd0nsx3+5RRLNGSm5xB
 abPWjhef+CoLg3rVHHWhNoC0H5Irkz8=
X-Proofpoint-GUID: OpQMR3vjo6V7teMd58eDnNnUfuB9PRjd
X-Proofpoint-ORIG-GUID: OpQMR3vjo6V7teMd58eDnNnUfuB9PRjd
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33e483 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PVUNuLZfzPDvKcjOmkIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020359.18627-3-philmd@oss.qualcomm.com>
---
 system/memory.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 28807cf0519..93c714104b2 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -889,7 +889,8 @@ static void address_space_update_ioeventfds(AddressSpace *as)
  * range `cmr'.  Only the part that has intersection of the specified
  * FlatRange will be sent.
  */
-static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
+static void flat_range_coalesced_io_notify(FlatRange *fr,
+                                           const AddressSpace *as,
                                            CoalescedMemoryRange *cmr, bool add)
 {
     AddrRange tmp;
@@ -913,7 +914,7 @@ static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
     }
 }
 
-static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
+static void flat_range_coalesced_io_del(FlatRange *fr, const AddressSpace *as)
 {
     CoalescedMemoryRange *cmr;
 
@@ -922,7 +923,7 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
     }
 }
 
-static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
+static void flat_range_coalesced_io_add(FlatRange *fr, const AddressSpace *as)
 {
     MemoryRegion *mr = fr->mr;
     CoalescedMemoryRange *cmr;
@@ -940,7 +941,8 @@ static void
 flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
                                                 MemoryRegionSection *mrs,
                                                 MemoryListener *listener,
-                                                AddressSpace *as, bool add)
+                                                const AddressSpace *as,
+                                                bool add)
 {
     CoalescedMemoryRange *cmr;
     MemoryRegion *mr = fr->mr;
-- 
2.53.0


