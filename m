Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jOeCwYVb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CFj6uyzj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUiF-0006F2-GM; Thu, 12 Nov 2026 08:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUiC-0006E7-3v
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:19:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUiA-00075C-FN
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:19:31 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC91IgZ4149283
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=FJuPyRewKARtbvXHeQvye801NwPP0zClBTk
 qanBUoWo=; b=jOeCwYVbbJ8/oSsUPFMrUIc8VFY7y5W3WEuEVCfhqgB4ivj1M/H
 OJEf9Y3DVu7oGQMYE+6lWlJKl9Qz8o6taYzBTwxGhOEXRMmi1Xp6BjtboOwa5+uU
 Hk3UetiYUMOIt7d2arNwslFzYsL5U3coTa1HMjxATzVGPJLRXUJz8sT1kzKX0ajB
 C65+tkm6Ws82fCAtEmJBuGL1+RdH1DF51+EaCBcbMoLaVQmFqAceNMH4K0xRsCGK
 QoCy4UTaGyZUgLdUGB5+vgIeSH6wPRpPHzdF1iTW9+XHIWZrjKnpB+e8o2q11WEl
 3SAs/E06dRKtsUmDEmWGnOk8JbKmhe0DBEg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc63j0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:19:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91eaad6eaeaso80872536d6.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794489568; x=1795094368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FJuPyRewKARtbvXHeQvye801NwPP0zClBTkqanBUoWo=;
 b=CFj6uyzjrg0rsqmyJhDSWcLKfa+meeN6mKzwIYIBfEE7T1K1nxhe3MR/ruKtdUpS/a
 QmRp0A5D3y7yimcMbztt/oXxtChPi77OCEqEI3pdNLw6QyfgrwEyA6joiCXQI9ubN8Ss
 D73FhPqnwtlv/VXzM7clQBEmMhfbrAEJnQ6xfcveDmIpOfnRI+eavPNo1YZvSLuHK6D9
 vbeKcvLExHcskHNkYiFfjbVk99iOhubreu6eZjWxAval19aPMN61hm6U15AUAJDjaTwJ
 l/PQ12OwOW8qixAiTeOe7GFc2EoTwfEuaD1LvFfhxgPysnA1lrw3hHubBf0AccXUrHG8
 RoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489568; x=1795094368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJuPyRewKARtbvXHeQvye801NwPP0zClBTkqanBUoWo=;
 b=dpaai3M01GxUX7w0vL5Dh5qB3uLPyEqRdjI45gvM3sL4Ku2uHwJZaHIkHFoouh+cHS
 dIyY2iHUWx7DZ/Q2uuo3eEb1eZPhBKzi2RRLzdYENXducBZBdr6bzOO8ZPCZtd5nDQqp
 phSC1qd8B9Vy+I5d/S324N993K5FCP2+VwHGDamcexn7ZziUxQQPCfjkCsEPc9kaIwA4
 0G9nvY/+GEun+KjnT6I1sW8Y0Z/8SETNEzffudyig7q5DotH0XtaC/qzSe3NyflS2ALN
 9fxIkHDrMsv56GMoOFj7Fc5SPapb00h0zHq4HaYpWjkLGcstX2/6wqIs2o/8mxfLb56h
 5Tjg==
X-Gm-Message-State: APuU4Z9r5p2UxODkESWsiiejewjdTG4jdrO5bbWc0hkkT7nN+rICqsQi
 TSYrQcqSUC8F2AAgrDNS3dnIrFxSJhSSYPHpArpTTDlDdrvV+faRQoqEhhSSO3CPMxeDp2nO2ZC
 ay7vg/ryhF+G69bEpadcQ1X9pRN8i6dNU4q4bzMOFyPKU6krvyOMY5awVHxjZzzKTWw==
X-Gm-Gg: AYBFou0/4MGFd2hK2jYIXmjn6VQj3b0HUMl9tfc2Czkx1ijDKCUzo4VC600Q4JkKNoK
 Uc03KI53zEswbbnFW4nDwaIDWVARQ4oR4nvbU1D8zCW4sECE1oKgt+pAxIrVrBtfguEAqqAESy/
 Y2ZhrHGqRutDpuSKMfEGpyy4My/Njwvi51bALS5oqmQmim1NQDxTJdiNh5zIzdr/Y6Q7wQb8RgQ
 A26nV2tveBhHv2lisdrzsaTqsUn/93/FsrCaq9yObQj0Q+5J8YVqr1azcAdDbZMEMiLvul8/3nd
 sxBDygcVo1ZcEDo3gKeJojUxJQ4UYwJrTcTHcwh/8VpJHvcRO10eok3WiqVw/nQjrbr8zjKubTQ
 JkIVnBsKfzGssZ8BUsG2uA8dKH+SnpmOUaWjQDZmK1rSLzOUm3T+vSUDjf3hcFkcRk1YiJHbDzn
 sU2SDBCjeQexeZvaogKlyimrC3el5eI2H+rpMYnbwRpdgu
X-Received: by 2002:a05:6214:5684:b0:91c:bba5:ecda with SMTP id
 6a1803df08f44-91f03fffce4mr93954856d6.25.1794489567436; 
 Thu, 12 Nov 2026 05:19:27 -0800 (PST)
X-Received: by 2002:a05:6214:5684:b0:91c:bba5:ecda with SMTP id
 6a1803df08f44-91f03fffce4mr93954266d6.25.1794489566780; 
 Thu, 12 Nov 2026 05:19:26 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f02efe5ddsm46350186d6.19.2026.11.12.05.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:19:25 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] target/riscv/tcg/csr: filter bits when r/w HVIP(H)
 [GL3133]
Date: Thu, 12 Nov 2026 10:19:19 -0300
Message-ID: <20261112131920.485933-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FpaxewhlmuCJomU2VaspNjU2AFqbmAVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX2Vned3qLA/ra
 2fGiGjU7bzbegaw8bKVg7X5r9fTKwxETNomMQLQlz747QHwv4A3ZD5haNxQraHpQJMaTqNBBoiz
 JHNuYpJqywGkq/SXjrq8Xqi/+GjU1gnADaLoJLauEtUmrNEr2OhCFHiG/vNbhIIuvQXP75n73N8
 Rc+uZ2MACeWIEstxlTSZWkJ2X9TZ+4MzLEurirRcRDTVB4Uuf5OJuURDlQ2D5dU2D3pLkgJKYVW
 pkOrvzPz1yxFPtn+3CyWF7L1FzicFohEysQu3dYRI7rv8VJqosy0/AzzkvJ3QPXbBCwjTezGUND
 ulFqovm8QoiTu+THI8bfdKaxSHUNJmgcDis2iSNdzg8XJ7KHeZ/RPrdxY5CiI4kfBC87ziyIdHV
 ZiHm9PH6LMDkm+FeUOAcrxMDcL6btwSeg5d/opK5pUxSCrC2c+YQ8QsBjlODEqR6MSpXb7JmDU9
 M7lr6bB62WCn4uwU2Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX9PB9BS+KmWTE
 Qn0TyjzvSv1C1Cmcx2+hDm50I88ubLjLPu/zRAHRIPXUmK7xuU588YuTg083E5t0aDzFiWpYaUt
 EoLzt/VWF+cT5N6WgfhDm5HdTe3kG/Y=
X-Proofpoint-GUID: FpaxewhlmuCJomU2VaspNjU2AFqbmAVO
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af5bce0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HWObzVld2rp96nF285MA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

In this version we have adjustments suggested by Sashiko and one small
meson.build change done after feeback on another patch.  All changes are
superficial and do not affect the core logic.


Changes in v2:
- fix extra whitespace between sha and opening parenthesis (Sashiko)
- fix Gitlab bug number in test-hvip-read.S (3313 -> 3133) (Sashiko)
- remove 'exe_name' field from meson.build test entry
- v1 link: https://lore.kernel.org/qemu-devel/20261111133833.258917-1-daniel.barboza@oss.qualcomm.com/ 


Daniel Henrique Barboza (1):
  target/riscv/tcg/csr: filter bits when r/w HVIP(H) [GL3133]

 target/riscv/tcg/csr.c               |  8 ++++++
 tests/tcg/riscv64/system/meson.build |  8 ++++++
 tests/tcg/riscv64/test-hvip-read.S   | 41 ++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hvip-read.S

-- 
2.43.0


