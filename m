Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1640606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Syjjq8Wi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iguWMUWf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvge-0002qi-HJ; Tue, 24 Nov 2026 13:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgX-0002mM-HT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgV-0001Hx-V4
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:09 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXZi82132763
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dr70/htR8VRDs/4FiPahTyDscBP9od+WUB8ZQVoToOk=; b=Syjjq8Wiha5c54ZX
 xq4AoVQtvLu59gYqXq1cYdgiTUVdftvC6mlsVea52Wz/ShufhtHd7mA5tUfgf/yX
 8+Tas8KVWJEIXv2vvaZEtJ+sJOsNaYtTchm2OuM4bMQ9YwL9DEI7KymZKE7H65Gh
 YaLjTbc0L3W0I292ddCEv9ijQN6vCXG1V7k4POxOlBTchcx1PZ8QW1dXD6b1Kbak
 kdFihmLGVg1fC2V38PHNI4EvgWWGUK3ZYFEiAvbQlN441iyh/16EP3/ZrxLqvDF/
 SWTsrRtI2sXTu5wsSBJmN+MeVuRN8aVr7pvmFPuxqi1f35hAeh3w7+tegXvi6wxU
 5QhsSw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b801pyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9213c7a506fso31252106d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546566; x=1796151366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dr70/htR8VRDs/4FiPahTyDscBP9od+WUB8ZQVoToOk=;
 b=iguWMUWf04rjHlQ/TUEWj4xpQPMZ3qK4h6dGqSk8IYOzVZB2Bh0sjelZOxVhun1BWj
 fhCuNmBzGaABa4VSztONMcDXvcaThj2cGE+rwWJlTuk8Te2Zmsh2v0Xo+vlRk7XR+Kap
 pGvMA1BCA7VK80RHOVPsyfdM87JHUtH16bxoGBBK6YK35cyCyij1PV6cB/tDAc5U4/hg
 lx70nXs0mTp7eIijuxmLrLJcftMcddS09LGDqadPS7E7z7ts6lt/1KeT2++rr4WM6ZLM
 u3YAmWPQ0kSDfNKF9AmlhlVL3Q92qMIuox+1JsvhNtBfYq0cS0pO58QimGowUJu4apVl
 6n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546566; x=1796151366;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dr70/htR8VRDs/4FiPahTyDscBP9od+WUB8ZQVoToOk=;
 b=DRNHwByFjufWJHhof8IC5dR88LnMoJfSbhDs/IrayJqVyFjzWN2QFIrSMODhaq+bnj
 gq3dSK1b0fGZrvlH84bm5HBKlx8EvzXqotQ3CmNcQILSNDRwY8Os8bYYNtElaPuWssDX
 GfKeTsyP5+A8Hs5BbLi+utV9yE1jCwnxs2Ja9+43sNP1La9WlhSMhzei3FkkoxLD18pD
 ZHeUQA36EXK6xbYiFHbvw/9TWP2TNhydiPA755OZOAIaV2s+1yvhMjLEU2yHVeLfuWed
 Eg7gCJKXBy++UJhpg6p6X6IMBx2LZa01DWir5YeYkMwnNmDyoEOK61KakhT1EGrS0hg0
 klWA==
X-Gm-Message-State: APuU4Z+yd5OyYeIZ34cQWK02guAEx4i9IY39mNmcp5mxeR7T9WHTqBgO
 8j/hOc69mh8CAR9tGC3xxLAOYDrCdJNyXvI3wE37D9T9Hun73UVGl+x/1VktoiU93QI+GYQAaKa
 hpwkRiKD47HiuvVbSdJmrs8+Ft8YexkiedKAeBjV8YPGW8gUilzlZzFNQRnKrz9KLmbtW
X-Gm-Gg: AZFdTZfuDCDWY+cLpbttHwUJB9E5eTId1QlKF/z05L52WUlvETANQ6hhp+m6gbiwb3s
 ENv+V9c9hkR/JU84uBwOmnAZCcliAlVndYrfVDUBVtB/toGB5Zo/HCXYNc8pOgoueDf67agSNkR
 rUMI4Hyv1V6Eq19fnWiW0d/UP0lgnjzCcZGx9aUvQPTrh9jDiblHp4xQg6Ny8Kd+q9JfTYv1nyL
 o0dIT47gwHBPd3Sboi1F6QeFvkZi/VwsVA4XHwKAA64Ea3EH9OPLk3We8/pAZJlNaSNFxQLe896
 Ifbxe4cXuULOGZ+xmIjp9qbS8Djl2s73lY820PSHkld+mprL4kItEG1DrTJZV2gE/0ZpyCXvSoQ
 0WWffoT7xQwdfEcclWp5dBUaM/soH8UjIxjWQuBb7dq+W7IfF45mO1Bpd9/TAky4+phak/BUiWV
 PAuaEHa71S5OZ4BA==
X-Received: by 2002:a05:620a:130e:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-949ba9b452dmr2991978085a.21.1795546566337; 
 Tue, 24 Nov 2026 10:56:06 -0800 (PST)
X-Received: by 2002:a05:620a:130e:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-949ba9b452dmr2991974085a.21.1795546565880; 
 Tue, 24 Nov 2026 10:56:05 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906c089dsm248655155e9.1.2026.11.24.10.56.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:56:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Wang Jianqiang <wjq.sec@gmail.com>
Subject: [PATCH-for-11.2? 1/3] hw/block/pflash_cfi01: Register VM change
 handler once
Date: Tue, 24 Nov 2026 19:55:54 +0100
Message-ID: <20261124185556.81132-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124185556.81132-1-philmd@oss.qualcomm.com>
References: <20261124185556.81132-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX6/mvLrmqoRzw
 6ZXS2SqYltGTijKZxUOXBZrviFgK6RO+eseP2GKB6l54zEBsTD4evIYbYHolJixpA1PdXEQlXNN
 ZVtPc+wwbjrsdQaO0kPCWcMZOf9LV37V+y1qa2Vvzr9lXPJAsmPA2aDmLlNqV/mXStO9NmlAmE1
 jayzQzeRZfZOPFQO6y0gZVLB6iC5rRcvxHHdEYefCVH1TEY5dewxDfPJYmb7Yv7zH1E5omxHK1b
 oXHcobBmf6Jo8ojJ3Winv3ag+XvyY6zfk305xWUhQfXFecyJNZqTJqSmU5Uz5NPFmeZjdw5VG5f
 x1xVnDhVnehHez3mCjpe3C0Ps/k62J14CtdUyqbNjw1VUAh66BhyYG+jRn/P8olS3DgidzN1PPs
 WEzwg3JrgySWzJf/mZZ3PiHRgOxsJd/O0/Ea6yO+Wla8RKYmfXd4vwZyQpbTswf6dbUiLVRf6wP
 3HAPp5597vAj46eUH9g==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b05ddc6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=DDtf8uVxd8VoVdHOe-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 4SGKBAzeUliBHA_TUkEf72mla4wdEQ4c
X-Proofpoint-GUID: 4SGKBAzeUliBHA_TUkEf72mla4wdEQ4c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfXy/GGkR2yvquG
 sRJ4KirW7gpvo4aouFSjOwwPtbuUDNdTxdWI6Xj1jdYkTXW1WVuPJI2sH5mx+9/AzxmkxO97hD3
 N4K0pxd5Sb1Y7GJ2VKYvKWvPkGIs1aM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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


