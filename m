Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53229606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+A2BC4F;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EtL3ezhX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzf7-00025f-Hm; Tue, 24 Nov 2026 18:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzf4-0001uT-TT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzf2-0005DW-Su
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:54 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMarXa886574
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NYGzcGt5u+ld6Gh1/kKDpuAQc+KMfZEk8DXqSuXx1V0=; b=n+A2BC4F2/zCFzpX
 fx54nzUwpg1t3D+YRMuYJvlSCZJVH5kf7tjGD9cqrA96ADoq9GODEJprDWi0/Pzz
 a6aY9sH8nrpAKsLQhDe1WccU2CKp+5wtfd+MTJbcdPma+4YiT28fQ7/VUmU7Rzvo
 +gOt0Patlw/fF0rdE7XTXphzSG64nfKOJNsETu0OU/ulT6SkgeNybnQboBGC68f3
 ixQ8ZKw3E48BX/BI099aaCs0z4IjAvAn8TVfe9IoTboYewobFKG95C+Gq9DUu6AU
 3/8yMvNbTOYxx6mPYbfV/YQKZ0RboZYqv1uuiFuIGeNyXcn2e6+6Zvksd5mRyb6p
 21rk+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhca3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495af07676so804012285a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561850; x=1796166650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NYGzcGt5u+ld6Gh1/kKDpuAQc+KMfZEk8DXqSuXx1V0=;
 b=EtL3ezhXErNN4NAnw+rr0PjUaj2EPtpd+OvHK5FLHMoyGPlkhDJS+fRZ+pUEoH79yX
 eCngpON6ijotGMi6MJVHVa7aGkBAznTVldcFfb7lZTeHqZLi4aAE7GbucmtTyqGvzV00
 cjBmdrfkUaY69a7g3b2WyNggE16cfN/DDLmS6MSunOIcd4wJhVDbyb8IzsJvwt+F4D5G
 zY+JhIeW0EudQ2BpxDc21wh4D93h4glNC3MUDjcBFMTjE5UJN6tv7Qz9ecsKS3XR3Z+V
 62epX75iqBUMicK0kh22yxituE/oIfRtyzVTskHbwIGtE2iAivQj2ufxelwhoeLYUmN5
 VEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561850; x=1796166650;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NYGzcGt5u+ld6Gh1/kKDpuAQc+KMfZEk8DXqSuXx1V0=;
 b=W+aERpghxHGsyjSPHbVCosDd3cokimz6Jf9fVLzpZ0gL9LsLOYiV+Bym6nGmLgIBlt
 OWyYopnGe8+r1SU8319EQ9hs9Uk69dNetFytzVTe89s8FSRRgsrBjXocAczkW2DTfFa0
 3P/EEKYqhbLV71l4fNmqEe/QKQSz1my2qZNwjin1SzCBb24PyiwXHN9KpR4PrgDVttho
 7/jcWgWsj6ZX1BsKn+EB3D/PQZGiqJA/52bHIBmiVEY/MlTj2Ic937ieeC4LhnNHMLDB
 w36kaza3z8BrRBvBuZuw+RB6H4qIAudYQtGOHhYQs1ujrUzz6tBWyefTEk3vN12S5CR5
 yPUQ==
X-Gm-Message-State: APuU4Z+nqpDUb9dv6KNL4vQCXweJ6+WhASOFGA020EE6W01v2bT0i109
 uWZgAj+iwJ2Xs7ZsR7uePEB5MrVA+wx2ryeaY8EQnGYK6R4qKKdKnnXtUpXGybD1HnN8loJP98s
 A8PMM26lp9BrX1t43V5vXI2x+Wx2LqPjgeZqLU7Loe+ip5CLI/flH5gIKfPg9yLMpFVy2
X-Gm-Gg: AZFdTZe73QmsQVyoNQf9jWSef0F4rVVnSvAocb6wuChABCoiY3DQyHoD4cwkCvZBBKY
 7NQzdBm7aCczWX5jnumQsLcZQqxi1w2dJSfT/RoVPcXFl5yIVbA6HwdqOFmUJ1lFEpMlOv4B8Zo
 JicIL9aPPTZyGOmmkMVAb54UvmIXiGI7kfmwhznNSSBojfaWIayGvMYvx+6FugD+6GaVTBIBDHI
 G3uWoCJhwwIW/kiK+xjIljlGy+y+K/pHJHKVhn4fGLkvtXikka4F6LrzyaBqxfndLxnivYrt9tw
 hA7PZf5dbpZvS6G6VGlZ5lAMq0+crQRvHs4ExE3O81RgeYE46TcRC1m9yZfM3gzwcF/BY7uxaVj
 g6l4nuY5q2fssyUyc+2sLHnjMVP35ommOcBjePNeQRZfgUfazo/4vJCF5i7mvtF+HR7y4fIVkfq
 3J6R6fssJmCWuW2Q==
X-Received: by 2002:a05:620a:3715:b0:949:a139:2f2a with SMTP id
 af79cd13be357-949ba7ccbe4mr2766679285a.9.1795561850472; 
 Tue, 24 Nov 2026 15:10:50 -0800 (PST)
X-Received: by 2002:a05:620a:3715:b0:949:a139:2f2a with SMTP id
 af79cd13be357-949ba7ccbe4mr2766675685a.9.1795561850035; 
 Tue, 24 Nov 2026 15:10:50 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm31543194f8f.2.2026.11.24.15.10.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] hw/block/pflash_cfi01: Register VM change handler once
Date: Wed, 25 Nov 2026 00:09:13 +0100
Message-ID: <20261124230917.88704-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b06197b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=Oz4jNdGFPLS9ddvAwioA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX6wwsx6blGPPR
 1CVog4ccSqMLh0sCtDdYxWUoQENaHSURxty4eO24BtdiP7elOd+bpqx20p1XSu9lp9JUPwT7rrl
 qRNu5o12HP8iMoeZwqDCjvVMP7uov2I=
X-Proofpoint-GUID: z3FW-mQshmTQSVpX2jK96HtU3B2mjXy4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX+t1H5MTiTCZH
 enhT3A0Y5UbovKEsfnlGaIVfTL0hk5s97YdH7brtbneoLIIDjpkAuDraQ5OxW1+KcqkuYjPXY1W
 Nhdcgq5b/Dii+YlfKyMaVYBIgp3MbWC/9PPeEaXJiZKMVo9inYy+kBQXu90q9h7yQ2EquvfOoOS
 zcaV34pk21CGHEzX1PVud9UWbKFJnpQBSN0hnsk7HYDoVrlHmRuuG1Fbd42b9sxfopep7sKSiqH
 MYP61QVIb2MWbvGEEw07YWt7qPSIOcnhufRw0xvGuM9v8e+JJeNZO0tnvMjOqMUnsL/J2NWLNnO
 iK3gSyE4EggsgRXBOv/agurcbTgQt5ZPZKPDnbS6/KC0ttYFMCAPYKK6+9A7o5ylvTOJGPyZ78g
 KJsNb94/1BbmGOhmBMhdR1hjf5Gkrn4W9wRYNOKRKoX67Zc2H9IrxVtORBT/OXmA5MVZvFd4f5u
 FA18sxB6Ueuse9Zmm+w==
X-Proofpoint-ORIG-GUID: z3FW-mQshmTQSVpX2jK96HtU3B2mjXy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each pflash_post_load() added a VM change-state handler and
overwrote pfl->vmstate. Loading twice before the VM resumes
left the first entry on the list, and resuming then ran a
freed entry. Register the handler only when none is held.

Cc: qemu-stable@nongnu.org
Fixes: 90c647db8d59 ("Fix pflash migration")
Reported-by: Wang Jianqiang <wjq.sec@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2635
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124185556.81132-2-philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 486fc6350d85..78cb221ddab0 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1039,7 +1039,8 @@ static int pflash_post_load(void *opaque, int version_id)
         memory_region_rom_device_set_romd(&pfl->mem, false);
     }
 
-    if (!pfl->ro) {
+    /* A second load before the VM resumes must not add a duplicate entry */
+    if (!pfl->ro && !pfl->vmstate) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                         pfl);
     }
-- 
2.55.0


