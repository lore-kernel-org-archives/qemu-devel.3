Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4641C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUqk-00046i-GI; Sun, 05 Jul 2026 17:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqj-00044V-5n
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqh-0008NX-SU
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiqaM2344115
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YpvyPafEgMLcx7hXhSA7L2Lp32OYcohxo8F966bFstA=; b=DWFkCGj8MrbUqvQ7
 W1P5Bu68XZYid2cdYmyGQGFUwLJMgomf/dorpnxJvcKms9Ov/HMSgcnv97p6uXE4
 riEH9mLj5Ilu6U3eCAsb0wLpOaDtCIJqdsEe4CecMkB9giUPJasvnvG9ZlD9OKX4
 ghj1pvPorkuEVdabQD3d10y/HEDA5Rz0L3y44b5v5QAR97U8PyimLcfUsn7rbjiq
 T1mszzUap+Q4w2xaLR3I1O3CV7W6rBuVIMlKF1K1fgGM/PIZY+8l3DuZcNV2+c0+
 0phxRQkuVKnUAc34Ex2pzGO8u8/QSDLmt6xmcwQUMB2CL+NheEXR8n8j661pq9Qt
 FxSldw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvkjde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so357666285a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288682; x=1783893482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YpvyPafEgMLcx7hXhSA7L2Lp32OYcohxo8F966bFstA=;
 b=d8FWnATkRsm0zHte/y/kNsUUBvuHfykmzmaU9NKQxSVC7agpThcLDgySMMe6XNzLEC
 V3pD6Xh3093YtyHaNL4Rm4KHnrDyW8WktPCZgHGWkk6mdztyPvyB+WQ3CjhSF3rJQfKT
 Ja5Slr6Hqjvk0nrAj8sRQrFnIblfpjlWD4mUXYXJJUX/GAgMJ4GrPBb98rbPGHPhFgTB
 9K1dN41Kxmuku/EU1jNi98m0ucZPDkvcVW3ARJ3IxH7yk9ODiico+kF2iWHJRUBWHGyr
 g926kxASynxpIUcgvJ1iG5JANYeOyJJmmkXY2pWGLRVuLT6pAgpG3PYetCumDaa+I4My
 qgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288682; x=1783893482;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YpvyPafEgMLcx7hXhSA7L2Lp32OYcohxo8F966bFstA=;
 b=A60lfsbTvET0rYq3gqGcjS43bCM6v1ypnnQ4SVtpB+MB5cD0qgDG5Y7HgSm3nSapla
 /GER/OPbgiSv+9ueHGjGNPt0//9PNQEUlzU6on1tUB/efh47RfhRWSYG3mSvfJ6fqAax
 s6sxohRuj6QrSxJ+xi7nPOuouaJGlK7mC//L3dsltvUy9uqdM4BFNzOMsCLjBL3Lp6Sz
 2MtMttYkwJAKRjYAeWolEt4KnH6nxEUrMWGQUmz4jCNHv+btMtBTYMRa4nqoyYUlXzOD
 OuZ+idQqrR6HJ0UI5j6jo6ooLevRWYCGHTw+HGHJTDb4flyF0uIZKaJbbMMOC9U6bwxa
 DYdA==
X-Gm-Message-State: AOJu0YxTVmD7UukEoHEkX467jWiVy6a1wOc9Maev8FyaNusqc2KIJFdf
 apD36CAUaJanUTrxYARJTl1fRB8e4zfCrEwEamjMGUQS+Eshg/xAVbPAB41lFIdTionetcMEkQZ
 gVIswQmUK6m86ZPCj/1odvj6Imr4+vCr1qYewDnPeuyPcWll1xZjmkJ6+JEh6nOd0mg==
X-Gm-Gg: AfdE7cl1rT2gTCBUj441dPUr8DslsN8VYQabUdiHl0CvhtsSlgx/t/iXFIutSQNZIZe
 LNM/rAeukEUwpQB5xdy/iDUivhhAzXJyTgctEeNA90n/0PyhY3ASIw2xs3BIzxMyu+iOLFmNeBx
 zsLRWU96qD04/kBeO+3vpLEEHROsCdcN8HEPVCiwYsfzRpy8i/LNgQCv6QlWqBQRy3uRJtCm8kJ
 YurnSbs/Ba4L5MsaF/abuSzKrZIteBMlc4u+xrGgrw9s43ktJ6HgVmeHm8UMRZBRYThIzXL9aZj
 NWVKV0Yn9wVXS3uVBd9L6pWH+avsx24l6UF2c1aKjeP0mvfbmnW3mQ3yL+siDv9pZA6AV6MfqxT
 xxNUFuVeUCZqqjkGWVgxX92QtuBNldbGGeVApoxx0mT4XtcMmaJCvsar1HK39vAcmIbbw
X-Received: by 2002:a05:620a:2a09:b0:92b:641f:ea5e with SMTP id
 af79cd13be357-92e9a1b965bmr1067066185a.0.1783288682377; 
 Sun, 05 Jul 2026 14:58:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:92b:641f:ea5e with SMTP id
 af79cd13be357-92e9a1b965bmr1067063585a.0.1783288681953; 
 Sun, 05 Jul 2026 14:58:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm17718353f8f.30.2026.07.05.14.58.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 04/32] accel/hvf: Remove left-over comment
Date: Sun,  5 Jul 2026 23:57:00 +0200
Message-ID: <20260705215729.62196-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4ad36b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YR4D2mM5xzZxOhM6trFMXzfDjv2DFjZm
X-Proofpoint-GUID: YR4D2mM5xzZxOhM6trFMXzfDjv2DFjZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfXzdFNI5W7W2DD
 YKTyWGamH6N+Rqr+/lMBVm5sff/fftRLqTEuuIMLCLFl3xmniFZEuUVW1RVb3ZbIhcYv1CypzlJ
 9xyB3Wbexy+q3r0GRDhAlYeG4TT7x4bg1vj9qJy9oJBNMr7DBMDeo+D6ICRQNM45wYgU0ei6cPl
 xlZBMBniFkgi0Xj09C2L1NOhAwd2T7HN/THUoSLur7+PCNWOLIo0j/x2Y9XzEAlRGqzzblhx352
 mQphaXQMnaoAus9yiVVQ+kmaxto4M3Jz282GtYIvtQU6FVM1I6hz1VsaGymjlrI7IuiNEdIQMtC
 /TBrKb9/K34GdfutSLx3NsB4HqFw25DMhncU2kLrwlty4njjATmCUNzXgV/JdeDTpUL0TGvHJdc
 BYVjnwRlRb8NcMmB0MkaPLb6x3k/qCy16JTr1/y+pj4qkukGtDdKFtRV24wmc8KIxNMNvUWSTJJ
 tSHFexpUTE1ZkmcS89Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX2Yvf/xfgs3Wz
 qrefHITV75Y6eEfRmZ0/kwYnJWZBogoAJ0UtYiDPjwuFO4jnXbZGQFHfIyy2GJVLV6rsrPt9J0T
 AYi4nWC0bZnOidSHRMJxL7TzSpQls3s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
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

Missed in commit 6bf331164c5 ("accel/hvf: Drop hvf_slot and
hvf_find_overlap_slot").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..dd2b45b7cb5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -62,8 +62,6 @@
 
 HVFState *hvf_state;
 
-/* Memory slots */
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.53.0


