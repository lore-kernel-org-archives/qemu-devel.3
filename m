Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357F1C4450B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiuh-0001Wk-Vy; Tue, 14 Jul 2026 15:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiud-0001WU-UV
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiua-0004zn-3j
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIx17d1391016
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xR+SvwFyxqGJjNM1blg2Of
 A3Gz4dDGuc3aBp6MqMbz4=; b=on4+MrYfWP5UgJn0LKULUF+FZ9w93YhkPXZPTA
 H+LXhkcjAWvBOVEPg55C2dO+qbpoxrTW3vjQSRMYWuzOBQAnjOeVMgdGy1bKKuEX
 0q9/yCkHdFox5KkdGP6OiUFDLlIEEpjUKXfZCtL5sq65+XaPTZlZIs+OTt3IV4T0
 sLVdkWUhgQk0DN8pvqqLcOC8/sOt782YTPRU1G0LtoSKS3wm5op5yE65EVEXs6gZ
 i2aHxGMpYsde5AITFouXuUAyPT/bpqyZTP8AI7cMMyn1Coqp1Kki+xzrb/AmESbb
 nO/N750tHR65iEWB0IYdrVAUbnizjTShmOJch/Dm+sOL2CJA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr1hxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8db414c7so65490061cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057721; x=1784662521; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xR+SvwFyxqGJjNM1blg2OfA3Gz4dDGuc3aBp6MqMbz4=;
 b=UYKSWha9c/iWZ9zx0cb3B4bXLue98dOmu8wsKf75V90f1i+ewGM08lCN8dXZoqu6av
 /CKqckC5ieef5wGihW5i/4xqwdag/rqs3Ee5qvQpx5X+t4ptOqnLLt4/F3S69HowP9bf
 2lsm6fp6YTtoNnLiHoqfSBOeuaXv1ED4reufVDGJq6dqRBYbyI2vfOI3SaA6t79DclvB
 G00OlBlSI/VmmqeGecPVDpaqCRv/VP4EM54AIhOEYv4RkQTF2p/xouFfw88rJAv4Pa6C
 rRaZFiupvqp+LFb13BnJnOZIZZmIVt4U5wi88Tw9/jl+IsWktfTfGVAWfX/JJzr8f5u7
 awwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057721; x=1784662521;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xR+SvwFyxqGJjNM1blg2OfA3Gz4dDGuc3aBp6MqMbz4=;
 b=hylJt8llV+FQengRiU5opTC+/hlnKKceKQxmn0DebrqNGAMB/DTlJou7AWtC3rrAlF
 N9c51XeJcj1QJuuZZjaEE9DlSHUxuWcWNPGYgY7/+2Mx8kRIJ7K6BuHDgBNtWdX2mm94
 7wRm9fUIww4eDkoh98QlMGdvWLdp5JVbz5LkUfkWv9wbGFKekr8MFOP2bbViubgHhQSK
 sPbBVgEsLCxLDLVSFUSkyz5wL7ry744w2Zpz2CTVsFwBT3jL4iP3sH7VtVAL8MK+izc6
 rXlh6NP+hFjtA9Q6f3+Z9FdBbPrA/BFLzPQ16dQL6PzS1b6sOU4YabBTfrmRhYSTE6mq
 6IQg==
X-Gm-Message-State: AOJu0YxLL1UL/+1A2osaooJfzve10QE0knXZ0VUEvRIz/sCER7GtAGXk
 yCh0eUn/49fjdfjq5X2tuVk71l8WriLbMoz983x1AGAvHNBDjvBrCDNfK5jLuRopTL2ojfjWEnH
 gwHqY/angQIOlvb9F7Uqzulr/ELAkgyBfqduHh3eg+2JhuW7usQWuQCzLQogqOqqA3g==
X-Gm-Gg: AfdE7ckQ5Et0bqLBWqEbCe9DJiw0EAe8QfNcwHVn4/KRv7wdVJ19w6lUD4K5wdKAXCg
 bAvha7kYHykdKQFdxp7N+ahuNf1AE9s6U/aMm0HA6D9qk3oHHwtcjcELIBDgDUafEaUuMVXOKpG
 Ml75/TDDQsopVQf2yFXi0CdRnouVKrQwM/9+GhYBagRBJAppBNc3PbBgBvM6LSrq4XQBNqjS7/e
 saqjx5qqBCNj0wuaFati4jMM2YLCoxOy7ZhIXuuGyhXKWJgZAdQBwpgKs12eCummuhVQkSmVNEw
 YYRQGTRcSVIs0LcgzIM+egMYboQ/sRYrX40CvmR4Y1zoyoE0PTnisfqoGBADlzO0v6NPgpMG/lH
 kg04ieRzgfYdfhypbkkvtKI9KiY9d65lmA9+76JfPRTD1HmjbAqratUaB9UsRclNDygwM
X-Received: by 2002:a05:622a:1a82:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-51e4ede1931mr657731cf.13.1784057720885; 
 Tue, 14 Jul 2026 12:35:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1a82:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-51e4ede1931mr657461cf.13.1784057720432; 
 Tue, 14 Jul 2026 12:35:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4829896asm8683676f8f.23.2026.07.14.12.35.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:35:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] Misc HW patches for 2026-07-14
Date: Tue, 14 Jul 2026 21:35:04 +0200
Message-ID: <20260714193517.60708-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX3eGLNGsFz/Jw
 iS0tbGtsg3ZDb0V1s6++Vw9K9FHPZe91TDKvyR8qzWBNoDgX6xrhFUaqABlWdA9ioHb8zKJfAMa
 GGSeY1g/sm8ExWR7Xts4vD/FvudeeBA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX/IJe5y0kqX3O
 IZeiNf4TYVQb4zStpgL8hmrhTBe2Y5+HFQw7FZIeF2PF9RGUZptsvSa99GjbguYS+zhaDi6nuVC
 iEJh8V7B8Q64WX0MW93/wdTxpBQUu44Si24ZVGUoBSRe9nSeLLfgzVLu21cHUsI2n0LbfSw7D9A
 MuNsQH+nYt1kUwSn8+pGHFfi83naRtz3Bl+m3d2RWdRFp1tx1Oztn9GXZpE327SJ/ENebGIlyVN
 gOjHW0tNoiMYSGMNUIGsBjuGA2xyKAIvjtfcGt1MsywwUBcN8YFC6cc15X01t5aMQXa6GSqmuVQ
 /gNYkRHoKdPGSKO0I3WyfnZdK6BFfX/uA7cyTFL4V8sq2aEGX5hzjuZjvryJQCaYXhcyUA/Cn9c
 +HsTis/6a83g6I+s3rqas1Wtkf/ogvuATIUtsjCUZ38Wr7tjjcrpWJI0h+U+UYjSLnf041FLxCp
 RziLnh+D/mZVIwcfcfw==
X-Proofpoint-ORIG-GUID: DeOTVw2NgW6Mp8cBSHZyEttsEizvBj-B
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a568f79 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=IxW1n1RzZduqmow0te4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: DeOTVw2NgW6Mp8cBSHZyEttsEizvBj-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

The following changes since commit 191489ba750f13357ac677fb3b059f6f89ee4287:

  Merge tag 'pull-riscv-to-apply-20260714' of https://github.com/alistair23/qemu into staging (2026-07-14 07:26:45 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260714

for you to fetch changes up to a38455cf9368e7370b0cfea809ef228ffa2e8209:

  net: only advertise passt in netdev help when CONFIG_PASST (2026-07-14 21:33:53 +0200)

----------------------------------------------------------------
Misc HW patches

Various fixes mostly related to misc hardware devices.
----------------------------------------------------------------

Bin Meng (1):
  docs/devel: Document SSI dummy-cycle ownership

Dmitry Pimenov (1):
  hw/sparc64/niagara: use int64_t for vdisk size to avoid truncation

Haotian Jiang (1):
  hw/misc/ivshmem: clear chardev handlers before freeing peers

Marc-André Lureau (2):
  hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
  hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure

Miao Wang (2):
  hw/scsi/vmw_pvscsi: translate data endianness
  hw/scsi/vmw_pvscsi: add a comment to explain the endianness

Rohitashv Kumar (1):
  net: only advertise passt in netdev help when CONFIG_PASST

Thomas Huth (5):
  hw/sparc64/sun4u: Mark unusable PCI busses as full to ease device
    plugging
  hw/usb/hcd-ohci: Make sure that ohci_service_ed_list() cannot loop
    forever
  hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask()
  hw/usb/hcd-xhci: Remove the FIXME macro
  hw/usb/hcd-xhci: Use qemu_log_mask() instead of fprintf() statement

 MAINTAINERS                     |   1 +
 docs/devel/index-internals.rst  |   1 +
 docs/devel/ssi.rst              | 132 ++++++++++++++++++++++++++++++++
 hw/scsi/vmw_pvscsi.h            |  14 ++++
 hw/display/qxl-render.c         |  28 ++++---
 hw/display/virtio-gpu-udmabuf.c |   1 +
 hw/misc/ivshmem-pci.c           |   6 ++
 hw/scsi/vmw_pvscsi.c            |  57 +++++++++++++-
 hw/sparc64/niagara.c            |   2 +-
 hw/sparc64/sun4u.c              |   7 ++
 hw/usb/hcd-ohci.c               |  10 +++
 hw/usb/hcd-xhci.c               |  15 ++--
 net/net.c                       |   2 +
 13 files changed, 255 insertions(+), 21 deletions(-)
 create mode 100644 docs/devel/ssi.rst

-- 
2.53.0


