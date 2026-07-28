Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D9C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJ6-0002XN-0i; Tue, 28 Jul 2026 05:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJ4-0002X0-1r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJ2-0007O5-8g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:01 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82IwP2128939
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dU6sbOT5wqbC1lAHl5GpwO
 /YKP08AIv1S30ys0KIROw=; b=Wath89aXWbXXVWc2BMBRzqx6K6aPoZgcIGzFUA
 cGSHpF2rDfNVsWSrDIH40zql0YdIUefODS7vLQ2TDQaeUt162H0Vtl0z03e4t2uA
 zMmes2CpM7T42001Xw8ghK4MGx7AaUd7qj/HxFdrSkFp/oVm1wFCSKtEYDsou+Gg
 I7sMiLvT8lveszRrzrEA6WfNjKNCJuPnSDTaT9VNZrkLZWiW70gEjk60ygcvIMld
 cUCubz1pg6pEwhbK5PR2zMSYxhzHgVSrO5AmI8amub+KI5xtpz6ukpdZuadfSt7C
 /Yft48dZ0VORHBsGpuQEgWqmsnTx08sOsjnwkG8DWX4HvjiQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8bh6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:40:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so31553561cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231658; x=1785836458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dU6sbOT5wqbC1lAHl5GpwO/YKP08AIv1S30ys0KIROw=;
 b=FBM7V4ZG46m1NScqebYjz53xT0jxxHP0RIzEVBjf5GqVab0YgCHrs4jZGunD/qg/le
 9Tsvhli5C7MHhmvmY+Nc7w6BJzBkAO4m7R1T8ptTwW97Zvf4bN/sXpKzmvQ/HMi64wVf
 ErG7fNjrwLc6yCpFRRzcEdjp51lxGkwmoT38Orq8oBe7SeyEH/Ok89eigvIkwL0riyCl
 QjhPt9Xx8t2PCiE2wqgWbNgDf/woxsIljwIbmJ5mjdBl8X5CS6lg8UfvgXocqrXVo/Gp
 HKe+csY+lp3Hkhth3enmpQnAZlyXO3ov4pR12mvYHxPnxYOuQg7CT0TwxZuKb6TT7m/W
 /MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231658; x=1785836458;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dU6sbOT5wqbC1lAHl5GpwO/YKP08AIv1S30ys0KIROw=;
 b=QXPJ1UWd3vfFgG1O/fV9dH+34+oNXYjNPMiMOdoTDa+e9syJPwpevw7vY+355wqdPU
 1zLacauWIxh+AYrrUMEGAzMeZmOafp6wOjj3BifLISEPNWb4S5/CUF2d9dVLJ1/XuLo+
 orPlqnHdjIykaXxPytcgpQOFYxJUEZOjPifF3aQtFChcIuxPtwJVHr6EVcvjpLZRr6cD
 gk0SzgGIX/iN9ZtrmJY59ljF+jCABvVeRXddAGawqF0t/wWLyNR5tg+QJIn0NpCQmnC3
 9+6HhvQOvlq2bYIyAGXXpR2TOYWrqSHAQtIvNRo/7NJHqAneDfZOnnSDFHpkva7dmZvi
 FQzw==
X-Gm-Message-State: AOJu0YwNiwQCOckqNvSKKbyCBNyVUpn3j9Rq4OnGtPtkll1ypX5ZzePz
 zEO3p1mKlz+KZLWhNx66lhPDPuMbAcyBWvnW20Uxwce/rwQ00J4Go0dJBrtWK142ZresfUJw01x
 vXayL8Q32gemZjVhcml+LTOppaikqSHUUlwWD1h5x/5tl8dc6ZGoHrg5FQjoEY7sYCQ==
X-Gm-Gg: AR+sD11I6C9yxJepOf0cifV9FiZvpACC5DtJM4iZCRLuY6RLvk8q9YvVVa1AjKFoMvj
 l6Y4sVWJk6VJrcWk77ZbF3lOvk/sl24BP+pu+KqYdzGu9oz2gP7DoJkvNDi6HPyBghwhSSaT7el
 5Fe9K/5rZ+UEdrY7i5IVVo4rdPDQJwTU5QcrkzxaaHNUOSmBAD3DbfNdJi77WMqfr77v90yTyKT
 E+n70P37qhLmpsNDfP2sGA55OiN4ALBWXoZhXh/7peAUEn+8fDvHEgkgJem06m0aUt0KXRXWIuk
 GaHdEg/dwFu90Ala+b/tWMrHXIGkTp5JmXb0h1swCruWLqa/R4pIXduqpVyQUC2NT+NiTNAM5Ch
 GzZxnwtTE2VsEwN2kAait89hsM/nScUZafIZENFQNNUdWldvh57oIW3Dgtw==
X-Received: by 2002:a05:622a:1b8e:b0:51a:8c9b:6499 with SMTP id
 d75a77b69052e-529d7163793mr12371211cf.61.1785231658046; 
 Tue, 28 Jul 2026 02:40:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8e:b0:51a:8c9b:6499 with SMTP id
 d75a77b69052e-529d7163793mr12370981cf.61.1785231657506; 
 Tue, 28 Jul 2026 02:40:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cbd09sm59403365e9.10.2026.07.28.02.40.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:40:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Misc HW patches for 2026-07-28
Date: Tue, 28 Jul 2026 11:40:49 +0200
Message-ID: <20260728094055.12684-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX34uelGmF2zKs
 nWlmxULBdozIzqStxtICWJxJ613EM2jzeVhrwEptDuw8ZWWIGV0ixByXcnE1j+rsjGJeG7UW4vj
 woJdbefz0YPiScVIVv+hReioTmMR6q7R7+9zq80zazlzCaP/tT5cr619bUW120v1z5d1EVku3VY
 B5G7YmPKDUZOqzKPVs4zZt79/osSXilkHOFLmTSmZ4toPzv926lBzIXKF7l6wdCGIel+qDMlu2E
 GIcrbext91HHAPnPfux4feCxx5buagBatdZeyMBS3+17evnAXqOgBia/FCfQlwA802qK7TbTisO
 9M7AQCa6YvbeMZov3o738TkakjwxDgFA7GgKkF9yDyDftqgTDc/g71+ce0MTXDzAqu7IPIpARHx
 z9ERQ6kWCam/fcHEa+lyLq7c68MR/vDMdba/U+UCSUJUSXadEWQvnbxcQ16daAS20GkeZ9AFlTQ
 MMrurv7/dH47a5wcaDw==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a68792a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=vkRzn229ap7jrLUKHgkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: cAgnfKpJKbL1smz_Xpuw6cMpexzMD8KM
X-Proofpoint-GUID: cAgnfKpJKbL1smz_Xpuw6cMpexzMD8KM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX/Z7kFZzuvbTo
 k5TaHRBSK6ro6MWoDhzBw8VZbv3CbDNN8NRMMhGJo2QuzcQx1+ZXpadJnFWqpp3ho96/mIn5+Q2
 U4Bjwfmjm+fQYe3W04L2tlvC8mNIHLM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280083
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

The following changes since commit 299e7557ed15a9a325620698add379a3ce2d1d95:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-07-27 16:51:28 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260728

for you to fetch changes up to c607cca75c354f2be9c2d3259f5b5237afec1717:

  tests/functional/ppc: skip remote interrupts test if -net user not built (2026-07-28 11:09:08 +0200)

----------------------------------------------------------------
Misc HW patches

- HW model fixes (network, SDHCI)
- SPARC64 vCPU migration fix
- PPC64 functional test fix
----------------------------------------------------------------

Bernhard Beschow (1):
  hw/sd/sdhci: Extract uSDHC-specific quirk

Laurent Vivier (2):
  hw/net/e1000e: recalculate rx_desc_len on migration load
  hw/net/igb: recalculate rx_desc_len on migration load

Mark Cave-Ayland (1):
  target/sparc: set reg window data structures currently after vmstate
    load

Peter Maydell (1):
  hw/net/xilinx_axienet: Don't write checksums off end of packet

Shivang Upadhyay (1):
  tests/functional/ppc: skip remote interrupts test if -net user not
    built

 hw/net/e1000e_core.c                   | 18 +++++--
 hw/net/igb_core.c                      |  2 +
 hw/net/xilinx_axienet.c                | 29 ++++++----
 hw/sd/sdhci.c                          | 73 ++++++++++++++++----------
 target/sparc/machine.c                 | 40 +++++++++++++-
 tests/functional/ppc64/test_powernv.py |  1 +
 6 files changed, 117 insertions(+), 46 deletions(-)

-- 
2.53.0


