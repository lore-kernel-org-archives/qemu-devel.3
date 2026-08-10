Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82540C5B569
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXgh-0003tb-HH; Mon, 10 Aug 2026 17:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgg-0003sn-5b
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgd-000809-Pa
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXaMm3140743
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yT0QzNA7i7xEZ9zHTuDptW
 TEJOF3BGwslu9xi9kwWI8=; b=GONW1ZVvDD26mi3MvdjT/28Tdxf9TmcvaZbodh
 9Msw57GsWRmrTu6/uFHhqQnaY1GGnLVLPzloU1z+ytvA7US/Yo3rF2uVOYxAzjB2
 ETbwzNIOWzIIa45UVEzrIo7eqLx1xrt6NQ9zltrn3ShgVQKbhy5yANMtT+bDGn8P
 ifGU4M9NklHNg3gVhamRsXTa3m9uchbkOnJR20XuPHoEoEFeo7rmc6gr5tNVM5y5
 JyX1DNFSCBvD3aKG6nOVIQvxeX+pVOE3Wutd4EU3E4AqZoFVQ156Dh3pNC/jTrV/
 aj/SvxC8eYSwlrQyjqBy8X0+Vcr8yRccqicQCq2HQlZs9bPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfs0v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d30035dso17405751cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786397846; x=1787002646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yT0QzNA7i7xEZ9zHTuDptWTEJOF3BGwslu9xi9kwWI8=;
 b=et9BXvnF/3ObHt5zZxpwmMRpoYW8lyu+780Z5x7SdgqO+XqxF8+lY8yaZVNxmh9Y3D
 eCLus9QTvY2vsY6diDp9dU/4vrpjPgK6RFrVZLLf16DrVpI892L2zPtTQzYPdNNmTDAo
 MxoKBTg9Oryx+lxdmkDciDJQbcsKQHDB2fOEeaL0mNamxV8VJ3XyR8SrB87RxYHPaaR7
 QCpxUE8kitA6julEloAe5K4P/4g8aGkdsAkAof4F8URXiXoFBwle5rKKh+p9diSe3dZO
 SJtjbHipVXHxjyRjgjZ23Q+NMfiGu5NKSqz9P4Q2AhgA4fJa7I+U47PVzjp+kS4o7iIF
 l95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397846; x=1787002646;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yT0QzNA7i7xEZ9zHTuDptWTEJOF3BGwslu9xi9kwWI8=;
 b=qcqL3B4et91zts46FqIQZb1LMwx/TU2PQCDKG1y7r08dJat/fFMMnFOavM7Vbi7+LG
 zM7EYw6FA5PYSwvWvnBSSAslR51ul156nLj+t28dMSjny6JsH6dRTAnpVeXSqmv+kuMv
 cv9gyiJ7zCshAu8X/cTd8UGnpnKIyd3OjrljVTKB5arTyRtD30Yhk7jhzmSM2+1KxMzA
 jAUI26HHEEyU5rCt5rieQ2qMqzqDnkb7P4gzjYmnhOgSz8AJPG6dvH4mzlarOB/HMTG8
 qWjiuOQ+47mZxB5ovD6Ar5ytOAjoHY9GpundDwyBFw2+wYx+xW5O2RLjmOUZsOxcbJKt
 ErPQ==
X-Gm-Message-State: AOJu0YyHtrYUjmZLPGrmMRlcU93qYid1TSAFUGM70GmgSIzuqzDOkEfz
 IopMN/UaSkdTpKIQXn2oNCCDUfY+rtGwJzRQpy+JRGZH+ObcxUCGQUYq2kfUNr4/pC0hNuGxthp
 Dg8kE0Jf/ougqIA90cy88qruRApSGaOCJZLPSxmtPCCI709s6KQSczEsdT0lrKbQthA==
X-Gm-Gg: AR+sD11icZ3KPq2poxD3ArP7J+KLG59gVOQcHmeMUxLUHmqSpr0wEyG61hEjLjQWd8J
 RkluQgYu9T3KxiCj9y5xQmylNjJZ88xIRdVqXK8FtWrXlXOg0TuA5GQAL6llI6NYRN7dN088O1W
 umaZm7lch7PMs/ZvQYp4tBlWWPtkXPRsCHXYu1uZVysc4tUyW/qfo8ebsRbTwzBWJdZpex4zW/T
 npdC09qQDJZlZZh0CTfUc6N+Ra9G5S9tzc5GG1gavklopn+VlvJD4SCu3vi3HAwGFpgwg8CnQhA
 1ZWG5XvUvCUftfQ98OnedMEgUgznULMnSg/vi7FcXV7n57RHLfSa4XuvT6QgnriGDeczdDUNjuJ
 NXEEGuQ3E6eNhW5FefoYye4m163Fv/YFUHtslyuFXjVJnQNI=
X-Received: by 2002:ac8:7e86:0:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-52d4c128000mr54516911cf.36.1786397845872; 
 Mon, 10 Aug 2026 14:37:25 -0700 (PDT)
X-Received: by 2002:ac8:7e86:0:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-52d4c128000mr54516591cf.36.1786397845501; 
 Mon, 10 Aug 2026 14:37:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm39819389f8f.14.2026.08.10.14.37.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Aug 2026 14:37:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH 0/4] hw/nmi: Safer vCPU delivery
Date: Mon, 10 Aug 2026 23:37:18 +0200
Message-ID: <20260810213723.58467-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EaOHYCC4XNAoUGIkFPcpm_jGApilzcIL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX9ytXiLUcFqP7
 P1mUwn5lo3f5WwVPXliGQUP2Q6JUAQVFc6bPDTjZdXE2Qi/zJTCEK21Te0gFIQ0J4RJyEgx8qNp
 dqUbXMecQvkTIngejmdASYikmKaUsfU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfXzzyQEG5u77wJ
 N33FrCwTKpNeRQLgLj4+1K9N0WszEto9GC06UFrRwwzkFh2RlRt0JgYC07ZQTNz4u5jHqpbVyHN
 lvGhbhbRlFXdXFzlgdlGMSad2G1XJMBRrPIU5hZ/Ar4UrYglzdc+YpjqjT4dr4A5ev0oURUADoW
 mrzQ0wl/uTZadJ4rRqjGQDMEJYwRtZP9KQ9HYNMBPet2P1tFcU2fGzEmjcv82XYmGAmzJhet8vB
 VOqO7gtgaXpx+8AY7PeurCeFVdUfa4p/IzuzGM4bz4Eq2UVI2sX29J4DhZAJ5NkEWgEYHiU9uZ5
 hOWf6mO9e8m5b3kvMWPtJeqzvGOzXpXdd4kUZda7tsbatG5mruBdxWnZ+uGka4XTWBmGvmYABwQ
 MsNJ7tmks0m6a8XRDP1Qxlz9DcgbtVgyWeJpZzyR6Oft+iaBb/lWY27FzRkjmRTOxRBg8YEYm03
 Zjvm44d/xHb4wNqv0tw==
X-Proofpoint-GUID: EaOHYCC4XNAoUGIkFPcpm_jGApilzcIL
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7a449b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=ScDGvuIdFrOFI8FA9pkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Marc-André,

I don't remember what I suggested particularly for
20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com,
but this series is what I had in mind back then.

If you find it worthy, please consider including it
in your "Make HMP optional" work.

Regard,

Phil.

Philippe Mathieu-Daudé (4):
  hw/nmi: Allow delivering to first available vCPU (not by index)
  hw/nmi: Introduce nmi_cpu_handler() for vcpu-specific delivery
  hw/s390x: Deliver per-vcpu NMI using nmi_cpu_handler
  hw/nmi: Remove unused @cpu_index and @errp arguments

 include/hw/core/nmi.h      | 10 +++++++++-
 hw/core/nmi.c              | 25 ++++++++++++++++++++++---
 hw/hppa/machine.c          |  4 ++--
 hw/i386/x86.c              |  5 ++---
 hw/intc/m68k_irqc.c        |  4 ++--
 hw/ipmi/ipmi.c             |  2 +-
 hw/m68k/q800-glue.c        |  4 ++--
 hw/misc/macio/gpio.c       |  4 ++--
 hw/ppc/pnv.c               |  7 +++----
 hw/ppc/spapr.c             |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  6 ++----
 hw/watchdog/watchdog.c     |  2 +-
 12 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.53.0


