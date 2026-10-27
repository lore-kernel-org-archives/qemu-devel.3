Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E9606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kx05gZ85;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N29mCrzc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlaJ-00052P-T1; Tue, 27 Oct 2026 14:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlaC-00050s-Gi
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:07:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlaA-0002mJ-Oo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:07:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH0c7w2827629
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ikDysv7yiuMd6c1Q7XFHNJ
 tEHxqvI05iAJTgidtdIJg=; b=Kx05gZ85qu0wXWgc3iKx/uEmBQTBEJXytGzFNL
 Lo0S6by9G5TPjuVlfU9vQvQWJuh1lgJ2VGXGu23iFAvfuOS3X8C76vDKB8nC7PL7
 FoTruU8k1Hf5ftS4gKylVZCkaa9Vkw6KSi80Eg2HioP5yAMhVLvE3xljqvgCEl7b
 ywGH5ONhOTpfWCL/RslmStG6E8tfNvjzXI43rNv+VqLFm2jD4vbZ4Xhi1mooWTpg
 ZUful1/JfaoT7JhN8h9+02+9r4CZEBdHoBcd8/NB6gLFURtmA/AdfEk7bQ0/aIw1
 jk3SS/rgdW8YmlAvqfYfozxaQhuy6uIUuNdeMHL1u4WUQDbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1j2f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:07:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so13232285a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793124436; x=1793729236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ikDysv7yiuMd6c1Q7XFHNJtEHxqvI05iAJTgidtdIJg=;
 b=N29mCrzczChfa4EiGpUtO0GzThm028h43OTt3HYSZwcUc59lw5zHdaXc6Ezjtsbtv5
 w2j1KpmT9Bvu/4YS5nO+/HFy8+k+Y3UEcV5OGLfM6uwCxo/7CKwLnn+/yo48Y11yDu63
 FgxnkIYpjzvAVNh2LTclDaQ70tJQ9Tz/9k6+yOAT1nj+/zrEKZ54HrDaDtSQUS+YxP+M
 SBKRa3H+u1SnlnzuIwhJYjRxKnOyjtD14TySjyVrS5ZU/9k7uiq1OlABZaisIO3Y1UDA
 cfEuYBtoKMFlWQoG16QwHINJAV46iAiAJZQ55knjvlTv3M+NcClvx0F+HTO+aiorsrIO
 i9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124436; x=1793729236;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ikDysv7yiuMd6c1Q7XFHNJtEHxqvI05iAJTgidtdIJg=;
 b=GzJiR4c+HA7EHDm7WDMK7Rkq90lhn0/3IT32fjtQDZOYKwFvfl03BwuG99F4aDNtCU
 N9i3fbag3KHxTjYWso6atCyhWJojnMXhQbMOfxrcdPnIZ2pSlAVObpdYwn+ZQCfv1Tk9
 0EhqxLGyLukuEm/tStQnJNmaBkkyTW4mfyqHzGwQhmi03vqeFe8tZC9UzQ9aDkm21fUs
 k+FQhym1zFVTxyySlGAgePBnrEnWdMwvHJzVJHh8WDM4pWE9lcT1M+WYUJN0EI9VzfyY
 IV9268Wy4UiQPl56Rav+rbv5xVGdsvY5tg+rxUHzp8QRIqqhseVofjhrKKsUGx3tgcT8
 rpjQ==
X-Gm-Message-State: AFq9FYLKRjGFWMcrafNF7WO2CR9hvwnxWo2pAbUTV6QroZ6FBV0K0deE
 syF/OSpSEdYv4CO5fbI5V2G5bEsU30tWp5FQnNjxPwvr6yXIFzzqjhJdtPvxzzpGHyT+nrttpnU
 1+bXvFDn3JRGOSG0cZfS0H4XxE/22aJ4DScqCmNiribnJ3OVR94tdQ8Hl3HFxK/FVNg==
X-Gm-Gg: AYBFou1JENDoFRJQl0ux8Sn1bfA2K9NFGn1fYMhPEor6z9CjVDtbazAWTOwsyJuE2R7
 gAlSf87MHK3pkO10aCJurXCUguV29YAOXwsC0Ll++Se/X1uUNclph0lOsdJMk0ju98YiyE0szMf
 FHYKzQ1/YhBgjAx6DUqYh/MiDAC6JtinrJH6PO4r1oT7tCvLOvx81+0/etyZWfn+wX5tOYX3BFJ
 nRqAjd/JKm/DGJV795DHt5zd51t2mb1o3SEua0KNWhnKZlp7Qs5pR7W5JbId+Z5lxCZKbNnDBbF
 WR7wuruWorUxfgoWbS6hmtK7EjwxRhGlbbGgptZTFdZ0grDerRAzgFpmf6MF/yyxMoSiPD+tapb
 wNhKll1Qok6IkdOCiGAhfAIHVy/aR6zmJkls/IqSLYH9HyRHO54X7w0ls/qXoxVJLgXTGwHbO+2
 9T4K0kUvF0hb6bjRtdMvbUldeYzmbA/w==
X-Received: by 2002:a05:620a:29c6:b0:93c:7948:6e84 with SMTP id
 af79cd13be357-940ef98017bmr1690853085a.52.1793124436343; 
 Tue, 27 Oct 2026 11:07:16 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:93c:7948:6e84 with SMTP id
 af79cd13be357-940ef98017bmr1690846085a.52.1793124435781; 
 Tue, 27 Oct 2026 11:07:15 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm20852886f8f.26.2026.10.27.11.07.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 11:07:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] accel/tcg: Fix icount accounting on CPU reset
Date: Tue, 27 Oct 2026 19:07:11 +0100
Message-ID: <20261027180713.2386-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0e855 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=MsNehsgBPqlmu5rZ2XQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: IM1Uf9ERuY4YN2o6VmVeUDndHimWtDPv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX7uIpgx/wjEl1
 UfcCu37cVhhvEB+NO3PKbti0XLw09o7I9rwKxpFV0JCJ9e6DS5A1YfANftX3xIGORDINVAStQ3L
 KL5uzvJcBrUqMkQN4GQpQfdz5cyEjRo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX6yclASE4EGOQ
 nmev021prf2gxs86UzNK30wlzr7WlQ4Q2xtoPj4YB8o1y/sngVVTt9XwzXIKaocO8fajEWmWWCE
 OXnLv4vG4leDLTl6sZjYut6UcG1LBqpAaPHLqQ+vdtrWLxnj87Lw3lgeNNRIb69nMA9rPl1MbFB
 s9+ffDqyI2zOmauyKTXOFghGboNbg2R3WlCRj3tqp9fKq/fvbjQPJ1kHt+YK/8a0ci2bW07EWsr
 b00Bw9fXB2tftxnpS0mPSOTU8aLFXhmB71iInkVLXcMtYi1vcOeOH4TTNK9H63ozqusxSIBuBvV
 kJVZLZq5L6ZRRadDquCiawUERAuLkN2ngp/P+U7UV4gmjh4/oL+xlrjyJ1DaJiFZfYWQiA59F+9
 5Xx7SDhILBzM2ACCF1olAwYCB/UyVupjXWSpjYSP8vGmHdwJfoL6d9FaRoW0E6BFLt7Y0AaCuce
 wLVUYkwTZU7TJ4ifRIg==
X-Proofpoint-GUID: IM1Uf9ERuY4YN2o6VmVeUDndHimWtDPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270072
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When TCG runs with '-icount', resetting a vCPU from inside
cpu_exec() can advance the virtual clock by the whole unused
part of that vCPU's current instruction budget.

Fix by accounting the instructions executed so far immediately
before the common CPU reset path clears the decrementer. Resets
outside active cpu_exec() remain unchanged.

Philippe Mathieu-Daudé (2):
  accel/tcg: Extract icount_cpu_reset() helper
  accel/tcg: Fix icount accounting on CPU reset

 include/exec/icount.h         |   2 +
 accel/tcg/icount-common.c     |  16 +++++
 hw/core/cpu-common.c          |   4 +-
 stubs/icount.c                |   3 +
 tests/qtest/icount-x86-test.c | 119 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   2 +
 6 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/icount-x86-test.c

-- 
2.55.0


