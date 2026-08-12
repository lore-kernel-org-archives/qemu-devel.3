Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A352C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7p8-0006vA-6w; Wed, 12 Aug 2026 08:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7p5-0006uT-M0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:12:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7p1-0007Pe-Eu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:12:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB466b3265806
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3oDYmKtdquESLPPz3Ymc1y
 wX7m4z6yN/E5oECqEWfkg=; b=PVxQUrLv2WfN3pQgeLLMYC6hqjmlLbKlJIhgVc
 PFt1M2X4OVh0FC2mRvLc95BQ/gEsD+HLdnHBDqYNNLnh5oXI5/RX0xLseggsZ6T/
 7SSgh7J3bXHo27LbgjFZEcIrbqhmorVHFe9/0gbmhLbogDFM3Mqs95RqT1UJL/Qa
 bquSZi3S/Vk3X6oP3xQ+5OEReLYY3kFz62lUutxa+0EHGfpg25wjAkPpWjthMs6+
 /1GipeQz9hscgtTYNXr4Qqn93aQI5VlOWzyTRwQ4K1qygWNwP4r+kGepmxXU6lfs
 5CX+3HVblBdgLSUn7IDDrtldV+4Uhq2qki2kgrnhuXziwDKA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrkqts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52cd0374265so17263011cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536755; x=1787141555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3oDYmKtdquESLPPz3Ymc1ywX7m4z6yN/E5oECqEWfkg=;
 b=DWYamYlvR7LkOu6BqJwNOt83F8w9W6JwdUmLdfFrYYTCsK85cU0ynzM+e4lQJbMwwh
 zilwUQb0GyKoHei5ZWQpT4v3aM+qV5kSEYm453M/oZRNR7KpLGyB/HwSIxKNqJAr3e+9
 xlssBp7U87ugyl0WlTYiU+I4h+mtl/dfEybrYIwNaPGLvveHL3AiSNIL0jrUQa3sm2If
 0+gNxJKPT7audj93wlh0M1JJLbMXsbUSfxcWkhOFc7OOXxi7gFU068hqTLx3PsmWDCgz
 o3RB4w0KtMMo9z/HRks0ll8+Vrr5dg5zrBVc5451zXQ0gTFzLEdGWBmEci+vUogAl+kN
 JNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536755; x=1787141555;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oDYmKtdquESLPPz3Ymc1ywX7m4z6yN/E5oECqEWfkg=;
 b=CvBrGI9+UC4T4D/cUCoECs3aUNVFhzcuk+y57ddTHdwUa7ylRE3w0HHXwXO+GcaCR2
 XQ12IV+XpGNNTaeNLK1mOQpojtwYchv3QqDW35hnmVA9D3FFRxr9Vyvk9nlup8p/29rD
 h0FoavtgPJbMBRkg9vYSF4nH9MOB0a3KjuOKieaPic4IXlY9u1wEbXV2AgLaXzYXD3Ex
 C1oxLs0OBe1MjcvN5GrzZDkr+/pQkYsCWrP+TUlkSZFT/UmQVXAoP4SqvR8R2odkVBei
 zdaGvfZKSKoXc2VkqBIxTwju34RpRGRR0urx0ACT2CbE7/BZZugDqsEzu63sLYsxiS0W
 dcJg==
X-Gm-Message-State: AOJu0Yy5R9rjHFpgYc52GxWRUHOZlBkj0OvZe7xK+Pgu+S87XBkEMxIH
 SothYZ9B3NAeYeln7YUB3iAYMT+eIyud2ex0F+J08/1ntg1wNdPW9cCYTvMrGzd2YROlm8Zuibs
 R3j9lsUVjyfb1N4PgT0894Qungt659xc87og87adOG5zWH/VhTjpzf2v/FSVgAvaBgQ==
X-Gm-Gg: AR+sD13kK9OoVek6ZKNEWprad9NkWu2qkgppufj4ELyo/ab1Q/tbmu1thwcZkNhwaPm
 l/Ui9C1RASkFHNIHoN+o1nk/YUqCmgTQfRQtaCzoM8ONfVLunIxuMuRrU9pBdxiigjw23QVK3Kd
 vozDubQ3i3lpB660tgY8i4yW3aPykgaYYdaQejIhjNk/m6NyUZRtBANkqWreASakw7VO0Xeo7F8
 LjD6ML9mlg1mIrKXGX7IxfjwRwraU1R7KKnMj6ko64bznmw2gMzHExr4+e0kl2l85g1RSg1LVMX
 8Ou7PFJ8TCJmv4STez3YWFKKay5CSa+yv1bXIQVA7E6r8tJOO0otG5y8bsAL2GgR1pTfF8Mkmnb
 MAy7qy8DaA2Aks63kQV6Of3XTgMcpVsFOIw1wTdWdQw==
X-Received: by 2002:a05:622a:120d:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-52d6474f609mr31467011cf.19.1786536754922; 
 Wed, 12 Aug 2026 05:12:34 -0700 (PDT)
X-Received: by 2002:a05:622a:120d:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-52d6474f609mr31466261cf.19.1786536754365; 
 Wed, 12 Aug 2026 05:12:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c057f0sm6844639f8f.9.2026.08.12.05.12.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:12:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/7] hw/nmi: Disconnect of vCPU and disentangle Monitor code
Date: Wed, 12 Aug 2026 14:12:25 +0200
Message-ID: <20260812121232.71958-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qTF2M6tad_AACriKWNm367ym0Z-p0MFj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXy6JkjKX3/Rvd
 GzxBoqMkPPhSCkVMk4z7Zj6Wh43zTtHaXeNoEeSTnYOOvMo44gkyzg9y0RUy+T9bqA5al3p/Qqf
 A+F5ddkxnNkxdGs91qT66dzH0ePmtUI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX80DXOgf61i5y
 rJI3ajogkAY5IW61QgrIlWMs2PnK6+ylKNT+Qv3mwUrLVClF0eImtO65VTL9d2On/QPxHk3SoHO
 cxpxmZmLAUVg9u0mMJAqrh/WbKP/SHY4XrkU+XkWwZim5VOWsojE1YCDtjq9M1R4E2K7mQiTasz
 mY4XwLj0of+ADndhGxR72QN5UPe0z4+cDyX/VF+gF5+sTH1xvkLpU7Q1SsMNCLd3MyyfZf8egtp
 gBOuRbJLbz7ayg9ppv+55JrceKwzZNPbhhaYBUzUfKpCiCuC+1n1C7xAHGKmIyMb/IXMO8P5sos
 iPqXivFhHHHOXsm7HbRQoQrjPhngM6XwW5nh0uS9/G8jFL6tDoGZmV/PUIh1dqgw2nviFXy3RLl
 whX/ViXCNkWoZR4zN9B2NH1P/TZTEYyzkG0gvjLgv1sPTfy1OYaIJtp2brP9hO+p/14yx8Z9jXI
 9QcaSd9gg0uWTjTitDA==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c6334 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=C5rFN5O0vr7X1WtnuFMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qTF2M6tad_AACriKWNm367ym0Z-p0MFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099
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

Series fully reviewed. I plan to queue/pull via my hw-misc tree.

Since v4:
- Fixed typos reported in v3

Since v3:
- Rename trigger -> inject (API entry point)
- Rename deliver -> raise (machine-specific handler)
- Do not mention 'cpu' in HMP doc

Cover:

- Have s390x always deliver NMI to the first CPU.
- Remove the @cpu_index / @errp arguments from handler.
- Rename API as nmi_trigger() (since not monitor specific).
- Only deliver NMI once

Rationale described by Peter in v1 [*]:

> The current hw/core/nmi.c code is a bit odd because it's partly
> working with a cpu_index and partly not: the code passes cpu_index
> around, but in practice for the QMP command the user can't set
> which CPU to operate on, and for everything except s390 the
> implementation doesn't care anyway. My impression from the IRC
> discussion is that it's not really necessary for the S390 that
> the monitor user be able to specify which CPU to NMI (and in any
> case you can only do that from the HMP command, not the QMP
> command, AIUI), so getting rid of that weird inconsistency makes
> sense to me: and that's what this patchset is doing.

[*] https://lore.kernel.org/qemu-devel/CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com/:

Philippe Mathieu-Daudé (7):
  hw/nmi: Use object_child_foreach_recursive() in nmi_children()
  hw/s390x/virtio-ccw: Always inject NMI to first CPU
  hw/nmi: Remove @cpu_index argument from
    NMIClass::nmi_monitor_handler()
  hw/nmi: Remove @cpu_index argument from nmi_inject()
  hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
  hw/nmi: Remove unused @errp argument from raise_nmi()
  hw/nmi: Raise NMI line only once

 qapi/machine.json          |  7 +++---
 qapi/run-state.json        |  6 +++--
 include/hw/core/nmi.h      | 33 ++++++++++++++++++++++++--
 hw/core/nmi.c              | 48 +++++++++++---------------------------
 hw/hppa/machine.c          |  4 ++--
 hw/i386/x86.c              |  4 ++--
 hw/intc/m68k_irqc.c        |  4 ++--
 hw/ipmi/ipmi.c             |  3 +--
 hw/m68k/q800-glue.c        |  4 ++--
 hw/misc/macio/gpio.c       |  4 ++--
 hw/ppc/pnv.c               |  4 ++--
 hw/ppc/spapr.c             |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  8 +++----
 hw/watchdog/watchdog.c     |  2 +-
 system/cpus.c              |  3 +--
 hmp-commands.hx            |  7 +++---
 16 files changed, 77 insertions(+), 68 deletions(-)

-- 
2.53.0


