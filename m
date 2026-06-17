Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EA4CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtJk-0007Fd-Ah; Wed, 17 Jun 2026 12:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtJj-0007FK-6r
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:40:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtJh-0004ML-4n
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:40:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HG5qS02634401
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cWx32/3wCJ9m2HYfpz36MQ
 a5ljGCW5bzgqwMKINS4zE=; b=DqUB1RcCDRxOX5Bxnf4P81F4EGwNPyFY08ybLk
 7BQEaJh7ari3Vhonr+C80o5khvOYAFSFSHd4sx5ovyw4i131607IUjknoVoFPdGT
 qqVlps+PF8BUhD8d7aT4etnZP2eK6hDu8lqx8qRGigf66FavV9Dpg8b3YESJ6SpU
 W0kwDv2FJaW87OXyCM9mOJREgPNPrjKwrNqFCeKLWkFNMU/LP8TPXhQ8UU2wn3fd
 tRpywm24t1f6KNfOp+I7N7bFoSnxVEDv3u1zbFwHo7JOa3Hs3JdMWOu7htxFHVkG
 BxiYtwMkWbAnX4hIMV+dD4WQHxrcokwMlY1P/r/u7T43ITvw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt507tu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:40:39 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6a2b8b91dc5so2302418137.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781714438; x=1782319238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cWx32/3wCJ9m2HYfpz36MQa5ljGCW5bzgqwMKINS4zE=;
 b=K4/EUpzxwKNvkxcWtC6+8YMW3Dt4mw7Nhs/5+pB+gHOhIQ6eabikDdJA3rekTt3T+C
 +6m2jUlq/AcYn/oLAwz4QdDGiuS6egNIoBYVJYrq8YJeDlQqPyAjspXxVNyXs9Oo44pc
 C4jepiEgMIus4zQoYM1sR8N33ey1hm9WyvIAMjkqKEttPCFoUtfY09q9rNedESC0A8Gb
 0wkDSlEUN/68h0bgB8HTbzTz0FSe8RhgUC0ckgDQoUihVIk9xpz61EzVxHG0Stvby5G/
 /FbwWhnl6uZJ0a5gCTdFSkm/J0DGD4NbPOw21XCfIghXXK7KA1jLFYl5OGPFQ6Nzynzc
 ffMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714438; x=1782319238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWx32/3wCJ9m2HYfpz36MQa5ljGCW5bzgqwMKINS4zE=;
 b=XOsMdaPC6zAdIAOu02gGMK3Ni7Ex9YVbZkKrTV5FbKTYSeYvrhifhCcwcU9NuZoMpj
 sLzJ37pF4XAFbwwjg86OeazWsau74dwJJQ5pWNjnlixfRxmBwOSRoAw5VOKaNTJMFQlo
 FQUA2hf0oXsz9Eql7O79bWwHu6Gr9D2WvXnCdoJnCIl8DMKlMVVjlpyIg8FIoWfpQkiV
 BjAvF0zHay46YXStN/5Pm8/PLfONEp/jiSNfuZfbRrgWJBWv+ybesZ8Ntv1D+o3MmFcR
 ZgM1ArYCp8cD76/S/D74Q1F3oXN7j4nvjmlDTI/r9A9TEYWtqBggt/fMIgmPgoZ42krc
 NfFQ==
X-Gm-Message-State: AOJu0Yyv8OvyqZhTIPGRftLznX+bLJegxpz+5xAVRr45vgVy3b7wZpNC
 QcCX4UwDiqPdu4CwnOhRAkvk6roICOB012ltcYMPgiBf/LRzGeNkMEXlOYqQWF96YIR9dUtUd6T
 XPb6MD0eln5eBazWZbz1ilgo/A4ClD+6XTQgvbls+ePIRjix8QY+/GS/w+xkS0LUQQA==
X-Gm-Gg: AfdE7cnG6GY0P82/rumcsqEEg3SmK7IVVBCLfQ4YdjRQAd+/HIW8s7mY8M6X6Ewx8ne
 65CEMkG1dJw2WgUfVpM+41B0o2xA8GeDtRu9KgUXGK+/0aNVAswDpbka3MiUCeLfT2J6xj5l2CG
 1/7E0oo0nNx/6doMU51BUo5G6ekIuqOBj962xOMjygvDJneLYPhufN8wKT5/4+yPJhKnqkj1NGL
 dguek8Xk86qNtNO0zUBV1Ltdl7ogZ2PVHjpfUdqf8RVcIeKD1wg0aEROJQETs1//+XujeF8RH5i
 dxOCHBa0CYtej+3J5YsPlHHlbt8ZlpCLbWsiVUYCx8YmhuPkXoZ0OticO8ekDA/DzfONoa47wln
 zUL+aevKa2WQ/Qof00zbmuSTM9v6Zx+OAOgcgx78W8OhORGj43GxwIDG+nGteLAbQPi/x
X-Received: by 2002:a05:6102:2b98:b0:71e:1c56:e792 with SMTP id
 ada2fe7eead31-727c4cbd51dmr243955137.8.1781714437958; 
 Wed, 17 Jun 2026 09:40:37 -0700 (PDT)
X-Received: by 2002:a05:6102:2b98:b0:71e:1c56:e792 with SMTP id
 ada2fe7eead31-727c4cbd51dmr243936137.8.1781714437605; 
 Wed, 17 Jun 2026 09:40:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4631217027bsm4609926f8f.12.2026.06.17.09.40.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:40:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 0/3] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
Date: Wed, 17 Jun 2026 18:40:32 +0200
Message-ID: <20260617164035.70788-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b-UiMVWRQtkwP0aOwB5zCghf7VSe1L0H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfX1398gWuzak8b
 PDp14pr6n1947nkWjurjjllfMfVye3Q0BPMlKqasjs2Jd+j/1WxCgi2NQmN8jgJgOMrtkj7FXt/
 +mk2/PWn5X0tYN0Vr8iQ+2JxcwHvjC4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfX9CsCPmuMK2Ds
 8ARz33ZZKJURkjjPWhtbjAGkRb7NU06qd7ttmlwpEtbdEkwlPEKroQETJBgCOmCpeL3ZzmK0qg2
 7rJSrA6sRCXSS82pPuf88HnHMksI9lr7l4bQ0clafrK/G5yKWdQllCF7jjB4kM0B+qHHjz0oY5V
 GYUutwl83i3ycOi3vJhIDxBC3P9+4vVNUb8FmgDccQHyD3a1/BfAX8cGFXD5UMOIHYBmmjg8BxX
 sTCW8oohjrFt2m07zaDEkBOqVbpa8yV8TO18mcKV9mHiOeMJMplkutDVo5otT+cFGX3LImGosOd
 nRpqUsSnRQjlGsuzz0a4vOFIizWveedA6JBncUWoihrL+Cf2oMtHXxUROV85rF83WoC67DgiMIk
 La8TaPu0NyGyMmzIStaWXtaOisHatlyLaRmibFR8h7nH47iAffNmASNRYwyBbEVEqlYWAvztepv
 9XtmHIuqxZI3Zlt3nsQ==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a32ce07 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EUaVuJyt9MGD8cDpDnkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: b-UiMVWRQtkwP0aOwB5zCghf7VSe1L0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170160
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Required to decouple TCG from the TYPE_S390_IPL and
properly extract the TCG cpu-loop.h API:
https://lore.kernel.org/qemu-devel/20260616191716.12932-1-philmd@oss.qualcomm.com/

Since v3:
- include pre-requisites (Jared)
- return instead of break (Richard)

Philippe Mathieu-Daudé (3):
  target/s390x: Factor common s390_ipl_read/write() helpers
  target/s390x: Replace legacy cpu_physical_memory_read/write() calls
  hw/s390x/ipl: Remove TCG dependency in handle_diag_308()

 target/s390x/s390x-internal.h  |  3 +-
 hw/s390x/ipl.c                 |  5 ---
 target/s390x/diag.c            | 75 +++++++++++++++++++---------------
 target/s390x/tcg/misc_helper.c |  5 ++-
 4 files changed, 47 insertions(+), 41 deletions(-)

-- 
2.53.0


