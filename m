Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD1C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJd-0003HV-Fp; Tue, 28 Jul 2026 05:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJX-00035R-M4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJU-0007UO-TU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S825F52071463
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QAOIwRE11/Q8kQPyymOxMOhHchhX1mFWjXH0lsGyb5o=; b=hj6BSf2i9BLUV2gy
 rH1blv8Z5e3EqJto5nB9hXH/VBrhU8ScbwbXOhGeZ5NcvqIDSSjVtYhGw6WlwC/q
 2N6Mz/YHqv+b1lCiPEX0blANc5d16F2mMaA+z4qUxYO19b6egMXYEejReZVgpM0W
 e9/RTSBtFx9FeDl7IG6kuPWb0YkVQexiIdPyNBBl3ag+U0MaIsxnmnjXEWVPdbHH
 MKdA1v6ZSHEBo6k/GyDhjiucikJ+/qFHPNF0+WTuJqOcVE3CUDleJd2fSpYv1iCq
 B74sczuXzxLT/hGPpSe2LVrDLZyDSOH0gEuG/8qnC5BEDzdMCOgka8nFlVJPOvXS
 gF36xQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjgjaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d30035dso34156691cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231685; x=1785836485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QAOIwRE11/Q8kQPyymOxMOhHchhX1mFWjXH0lsGyb5o=;
 b=TMpZqnaOWIKF/ryY42iCI6NYGa5lMypQXgbH31Hhk41TIuGcPpAH5TTbGOjnukmzln
 JzIxc8B+Cwbt7ac6xQypZsLskzAj5NYY/fOApK8hX5WeMYpWbboByoJJsSJP0ERD0ga6
 YTQyOTgMRR/0NqGOSLYmGe4z8hNBQ3EjT87tJrxpV0R2hbZzNNFvjo50ZJgwAp/oJIH0
 4m1tdRw/YcjD9dxEEJFdxIHs/3CQt5J4pBoMv1J2l6DBVexSP08hrvTvY0e/J22SabTO
 3tIhoGwVyorR5vsLOKacqA+UcXiprAE98wYbRQJV7Xs9/NKQWehOxC3mtefq/CPHZKXY
 /qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231685; x=1785836485;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QAOIwRE11/Q8kQPyymOxMOhHchhX1mFWjXH0lsGyb5o=;
 b=ULiN5Fid1sNwypMnc1qJB6cWBOoMmGWZcqIPmHRI36ITSVExTbhRLCvJq9xlEC4tpW
 q8/Tcoau9e4kUG1sGqn+FRwmmIkIwFAOYY+AaGl/SVe6iNjziQLep8EFr5Qwd675tcGB
 /gHVSw0AlLf/F13olZMU7TeUV1L7iKqkcDEhCU63MXtolTMLLDOOhnuLgs8vfh3l1pgn
 f/pf8r29ofMrDEBs+IxnCTO11cnL0XuH2NO5N3vgop3/7XoNWSGsDrIMCwM9Hivy8gEo
 dhkHzkKRwmsx4x4+LZtxdWXmBpNdc5KF+cotdW2P3fwv4b5H5b3lWiS2/PrUj3/wQJZX
 HOfg==
X-Gm-Message-State: AOJu0YxQ1phcIbDas2DbljNEIrPWALyVtioiEHpP252++ILpPHz7GlOG
 Q01SSOGITVZdjatzcrYST9L4T1sdN7qlaahigBdUm8Urm1E76KSIaDrpKCCrj9IIFqkmZv3D+sX
 yXiIRrGm497Q0GnjWfDRhQ2UbCFXA6gB7+/y2gwGPJTVaaHoIUdehM9DScBAfc2JVqg==
X-Gm-Gg: AR+sD12fxvU4Om+JyEgwe0q/5HRSjgk/LHCSh7f+xORmf1jS6jyc7I8WlkxUFdDXNlo
 G7gZHTd2+sjB/hSuy3VypvEETwQXu98f9d7Z3o7N+rr8Sbrshe40gvCDdlyMiAhefzj30XL0hl8
 lMPKCO0m+Q/HFYfJxM45StnPtQBqYfYa3B1GtCzoemOS5D4EGnAIDPiqbH7TvxDdtT5L9LdOvel
 hHk/VkQ9XCNJ0q1eBxQwMzpCHQjvUepXwQhTl0evOF9Hry/mLCGaSrSTPcZGRQzA4DZKbz7QPAM
 Fw2jp9n7502XB0N3dMNALvsEhwRCI2aQ3Vm9PoHq6ysh/GtedoIIFz16i9Lu69tLjfCr91t+j1P
 EgSRUK1nW+GStrbpU4VSOunA1pthWZNhwzQMgt95ZdmFWpU+wpOiZfKC+5A==
X-Received: by 2002:a05:622a:118a:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-529d6feb6fdmr12488811cf.28.1785231685251; 
 Tue, 28 Jul 2026 02:41:25 -0700 (PDT)
X-Received: by 2002:a05:622a:118a:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-529d6feb6fdmr12488551cf.28.1785231684710; 
 Tue, 28 Jul 2026 02:41:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cb67esm67603185e9.8.2026.07.28.02.41.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:41:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] hw/net/igb: recalculate rx_desc_len on migration load
Date: Tue, 28 Jul 2026 11:40:53 +0200
Message-ID: <20260728094055.12684-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iMzrI7SrgNucSmkU2Ee7HEuyXf46sv3Z
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a687946 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=s6qeQGAgE-pMEjVXHjgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX/lxguR7zNpuz
 zm3qkTIzJUzrCLFIYcY358IlEytpaO+hRx2cN9dQ7WdVVH7C5TVC9MQSPY5N1PWFZ3jjPOcctIk
 RYekYQMaqfqJGVHOezzhfrzOe0oTwe8=
X-Proofpoint-ORIG-GUID: iMzrI7SrgNucSmkU2Ee7HEuyXf46sv3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX5mLMzUNk+Gkw
 m59WqCG2l0jbDkxxmBVZXFdsX/sS4w4LjHvX3q8sXTzkVrsdTdbYOX8Uy492b5DtmyWskf1AqcV
 nCHaiQVS+r42ygEEYRRhWBeOuyBQ5vxkPnrOxRx3PH6e2O0IkYcZH7QgAMsAbDz6wCVMPCbVnff
 RE53r+zq0R5cYoPOHG5SoIejtsWwJYSz7D98C8xREkJBvnFQpZs+ntQ4KnZmLr4mEZGIyXROsGk
 0HH6rFivHgbpx1NeM0Ky34qtdEn0Rp/G+oYjNrmoLKlvrUYY68C89CaFrxf1wwjVPZdAzvZIXOY
 0vuchPc+Co+UcxS0m+LspAbnJF60OrWfzNWZ7ZjK9Yq3Pxi2eO3GpX7Kh/zLzP3I30i8r6zeoOr
 SekmNgbz95i3wLopppwoSSMwfRGofmmTxBQ3GkF1lid64gCT8MghB4WPi0rbQxiLeRsdHt5/TaK
 3NDyksYoIgJgFsE6gUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280084
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

From: Laurent Vivier <lvivier@redhat.com>

rx_desc_len is migrated as a raw uint8_t from the stream but is a
derived value. Currently igb_rx_use_legacy_descriptor() is a stub
that always returns false, so rx_desc_len is always set to
sizeof(union e1000_adv_rx_desc). Recalculate it in post_load to
prevent a crafted migration stream from setting an invalid value.

Cc: qemu-stable@nongnu.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260722112449.1386162-3-lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/igb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 45d8fd795b8..2a488390735 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4548,5 +4548,7 @@ igb_core_post_load(IGBCore *core)
     igb_intrmgr_resume(core);
     igb_autoneg_resume(core);
 
+    igb_calc_rxdesclen(core);
+
     return 0;
 }
-- 
2.53.0


