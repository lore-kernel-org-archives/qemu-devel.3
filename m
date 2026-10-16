Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A9FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkN-0007ou-AW; Fri, 16 Oct 2026 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkL-0007o9-Dw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkH-0002Xm-8j
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5hJD3506072
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=o53rPtaD+BIiywBwxHPV1l
 N9+2jtiLz4PiHRGVF5uoo=; b=NwA2zM4KdgZ1HBQeFwH2U24myrEywno5zpcqDF
 xsYkIFDBMicbUUsLjJlud+yLYwE+cpu9pF29ME6ef/cjx/cSeyFcPtgfgplN8yYA
 qj5SFsZefW+Izy2qq9zuALOZiozbtx819DaVha48o4ThBUQNQHZ7YFHZIL4k/QdH
 BrPkXl2a/CCj7JFBLyWzKI9CODxqP/x92mqUCokm90+2AIWMnz3G4fWRE9CrdNxF
 GtjoHxNb4qHSOixtPT1BbeGV6bFWEb5kNkENOBwYXUd52XKKxvrCKEXrTGj9or99
 kvlXmRTMjovPZNRieN6pcq5dB/m3iJKZU4/gIf06AtDgc4Ew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r13efj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd61df4951cso110989a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167917; x=1792772717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o53rPtaD+BIiywBwxHPV1lN9+2jtiLz4PiHRGVF5uoo=;
 b=WUh6GPMy6W7nVaSMbS97E+VDS+KPi5w61uwC1VXImYluJ+sd0uiSWBLB/xWOtDP7TN
 klsL36++RUzGJk/AC3IC+5bsLK7TUQJ4czeyM78qvZCT5RzoCWk7zdhMsEyhplXHfQxi
 gnPeK+LPeeM0yBFuzACCtiK583EuYM22fDfXceCiQjYnSC2c17Z/M1/IgJgoZG4jP48U
 U0CuaV83o9GDp3cdH+ISwMqYOdam7imdYNI36qgIfteio1IFoZflytGmGUrhgn/TZ6dJ
 CYAEVFmq8xmKWFgvPaCWTcIAt3B+WeITDnERB7unpMkU335QIs/Xpe2bB1q7Qys2EmYd
 Uf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167917; x=1792772717;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o53rPtaD+BIiywBwxHPV1lN9+2jtiLz4PiHRGVF5uoo=;
 b=tkdAi2BFFE0LRCWWn4RjGPAD3YMdcqmBJ+cB7NOaXH1N1ruXCHV7pHf/NjP5CYGX3S
 sIwlUJNdjN3Ls4cCj5je9FHdmP7W0DQn1n86bQsx8H7xY2detBsHjWHY2zMMXANbG2h/
 7ZCdZeD7TyPc5eeAmQ97Nv4oPaUWcpIzzj2o3G75L4qZcJlHVEQ+zQgxfG1LJtMUDtfq
 VWhXOru2t+IIcIG6lgTt8oLvyLFir9YWE63QqbbBqS68QOsZEo673rF7QiuPl1jkPEjj
 apfPn2jga4YOZay1SlmUSXkCo/7RFbGyjnY6vyWTdwq+/djD/9TG1JbskH9guh2/ks2W
 Uqhg==
X-Gm-Message-State: AFq9FYJYdgZz+gXB5xHuXoD4+DucKDTQpxU55w1GPmUPOsKoQrdbjL4y
 kJp5FxWfCtbw8u0N/b2URsr1MSz7QUSn3vG8PTcjJcLxyX0JxJZX9GPGbsLr9300zXGLJCcPgl0
 XfoAy3LaitCl9pGujLzJOYdoPw4j0vk4OhZZovKHcW9gNvy1uW50W4dbPvzljnxLsGA==
X-Gm-Gg: AYBFou1031uCcsGeypLXeMYcs2f6NMpqoT1mAGOQadTm6yP1Enmra4IIHTUardxLv4q
 jYRwOwh1BNctFBvQ9HQlnE0DNsBwmHXZIsQDdzGSCcMwBOswV1LjvZcYka/t2iidwZ8qJj6MTpS
 6m4ZHU/IpAusER5B11+rhzhnfPduGE3rWRN1l4auRPre0SmRo8LMH/Tv/zTfpnqk2BIkisualwf
 qWzKlPDZ1iDFfe4u65+oAVrh1pffZ44/ebEgpA2OWtijsVQ0zUyffaWDcqR92LlC3YRlbpYLLVP
 GE5gF7qzgmqmi3ILqYOXtUX6NSD7KcSHIdyl+dCicejTDhi+qPFuE2yeXc6NeMtz4tKSAN75otP
 gET9NOIyI5bn82Wcf4E+snCp4rkc8Hxr/IT1J0nxSadg/RKU/dp/Z87sBfhMIfIE=
X-Received: by 2002:a17:90b:4e8c:b0:3ac:dd28:4621 with SMTP id
 98e67ed59e1d1-3acef58d57dmr299421a91.51.1792167916867; 
 Fri, 16 Oct 2026 09:25:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8c:b0:3ac:dd28:4621 with SMTP id
 98e67ed59e1d1-3acef58d57dmr299392a91.51.1792167916302; 
 Fri, 16 Oct 2026 09:25:16 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 0/6] multi-target: remove qmp_query_cpu_model_expansion
 duplication
Date: Fri, 16 Oct 2026 16:25:03 +0000
Message-ID: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Hhvsi4pOIsppi70DGi2FI7SKLpRLcr0E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX6DtVGss1WYAI
 AguVsgRef+1VCA7cXQm4AYH6mZ2eaEuFWXS9pRl2XaBxffN/MRyJD03gak4u0TtCMw4yYFFvwca
 NiCMzOFNV9uqO6z1C+0TxEZk2g9Luxc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfXwOQup4uSOlz1
 fHZW1vx/slgw7SRYmxk1EYoVW0rzwjWXUifNFyCPEC446SW2RZop5OuoVvShL9wsbnHoI6BKAhn
 8WJ0UPuJV27YuGqYvWGhZsWRyhG+5DMq8gq2UBlt2oukFmjOsRdHcyRZ1XAmi86/UQDbSrjP8ry
 jhkJXQnsTL0dpVEnPhFqVg29sPbXH7l36iCBaTpLjeUKzOwH5QkgjVN1ylGgkey8kbVvmPfWawz
 1Bg6ivp9A0TiZKo2sNyy+3fCDmkt+H4xAZCHxJJ6iiCLLsHBkoArMH5QS6841Td6ujM2eoo6Hrw
 w8rB6p9MkK58D9Gs+v+qeoYc4hRqNb7VaStZXSxIPDunETMHvXWhdF8kvi/TJTfHLVYszccIIfQ
 R/UrZlp/BegOFVOSwIGQN0Yye7QbJ704w5itfEY/oJmkor/uKKKomwQFJkPuslSgloWgGLQ7c42
 AuqypbbCsYUuidrZd7A==
X-Proofpoint-GUID: Hhvsi4pOIsppi70DGi2FI7SKLpRLcr0E
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad24fed cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=it2DQPLsigw5JZ1cssgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This series allows to link multiple targets that define
qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
target-specific ones and a single dispatcher.

It follows the exact same approach and structure than:
https://lore.kernel.org/qemu-devel/20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com/,
which was merged yesterday.

Pierrick Bouvier (6):
  target/arm: rename qmp_query_cpu_model_expansion to
    qmp_query_arm_cpu_model_expansion
  target/i386: rename qmp_query_cpu_model_expansion to
    qmp_query_i386_cpu_model_expansion
  target/loongarch: rename to qmp_query_loongarch_cpu_model_expansion
  target/riscv: rename qmp_query_cpu_model_expansion to
    qmp_query_riscv_cpu_model_expansion
  target/s390x: rename qmp_query_cpu_model_expansion to
    qmp_query_s390x_cpu_model_expansion
  qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher
    function

 hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
 include/system/qmp-cpu.h              | 21 +++++++++++++++++++++
 stubs/meson.build                     |  1 -
 stubs/qmp-cpu-arm.c                   |  8 ++++++++
 stubs/qmp-cpu-i386.c                  |  8 ++++++++
 stubs/qmp-cpu-loongarch.c             |  8 ++++++++
 stubs/qmp-cpu-riscv.c                 |  8 ++++++++
 stubs/qmp-cpu-s390x.c                 |  8 ++++++++
 stubs/qmp-cpu.c                       | 14 --------------
 target/arm/arm-qmp-cmds.c             |  7 ++++---
 target/i386/cpu-system.c              |  7 ++++---
 target/loongarch/loongarch-qmp-cmds.c |  7 ++++---
 target/mips/system/mips-qmp-cmds.c    |  9 ---------
 target/ppc/ppc-qmp-cmds.c             |  9 ---------
 target/riscv/riscv-qmp-cmds.c         |  7 ++++---
 target/s390x/cpu_models_system.c      |  7 ++++---
 16 files changed, 107 insertions(+), 48 deletions(-)
 delete mode 100644 stubs/qmp-cpu.c

-- 
2.43.0


