Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3154BCD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVoI-0001Cl-A1; Tue, 16 Jun 2026 11:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoF-00019F-KW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoD-0004fl-0y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxda43920643
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gHpWTdcei7CK0KaVCEOZL/
 WbFA1/N6NZJO7bAwzD0Mw=; b=F6ZJiuUTkwvx2SbN9YKqHp5aKsbbu6sf63dQOv
 PHJLHXx5zEBbGqiasV/TKsWtFoevlgBb6aQS+EmwajVXTQ2Fm3A03CQnLMMtrUTA
 Ft0dm0SnKeRjRSL5n+umK0eOuETwUZedXoRqE7iZQ2IeQKfeFxfvvcD6UVta33AL
 86cP5rtBZvBIXDRfbL743jUvSgRnC7+LMHooZYaYi52WCEx4QvEaGugsjLE88R9n
 lxXoudpk+X+SpPnYESdriEqKgW6rtRq577YvL8fTacOlTZArjx9pEvqvkfJit3Fh
 fWVOeeeuQEfVCbDbdXS4D2L5Vbsba01B/F66Px6y9G+0Hylg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09ganch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:35 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-966a61478ceso860912241.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624075; x=1782228875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHpWTdcei7CK0KaVCEOZL/WbFA1/N6NZJO7bAwzD0Mw=;
 b=i68hc84eNMSI1Uqe6Kzcgns75uw7aQwIsLtHtuXSI5rPaLJ/nRGiWweS3C9zgEQ4Wj
 FYnuDNM08yS5p2dMuqRy2h3b9KMaKSojLIQFGespic9DjTHXF/d1CAzD3TK19JOibimi
 +wPhJgyVXc5OksEar+f9h0iPcS9WyTLDfe6hHXvjkgdLwexvYocmDLZduUNyirJAmS8y
 3x9I61HDud+qDd9udgsYg6aPTkhreq+5XcjJMuRVkISaJnIBzVRZnTMBKVwMldSTUGzn
 pMTIZvYccf3OujsmERXcp66/aNYVwvsB0u/iS+BYtuRNXk0v6PkY57vsy2Ng2UgHR3xy
 YQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624075; x=1782228875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHpWTdcei7CK0KaVCEOZL/WbFA1/N6NZJO7bAwzD0Mw=;
 b=KZFYaDG4WjI3hsnSDA7xuNo0gLrXo4rbBYq3AXIZWl50jp7BLwkwoGoGCeSD1t+YpH
 vfdsU59jytQecpdH2va1Mu26Z6428zcRIb6zvuazBbhX0uK31cu/eCU1C+9ik2K+JbcK
 t3SgUsyX3XvuPjF1TipxYgpAwLn0CWWeEDKSH99ATPShU4oO4VSwZzwqWOEgl8XH15z7
 +FvKpK2ZtylExHL8QQae4xozfuZpEbG/H1m/ceVL0NridNkJlRxKPHGN63fnu6EX36Ej
 xhR0JRyxqnxym1HQwFpPd7R/mGD2Itie7EV9e1B3OMq7xRk8UY/zqTYvFv4bN7jhOyBy
 8HDQ==
X-Gm-Message-State: AOJu0YwqMRvDMQ0HvUQm8lrzSiiKI7+ZG31NtUj08tIrJs40qkxdgL6S
 tIqFTm3oXGB8VyVWd9tzttlj0zRNT9IASMwNaAwn70csAIMrMspSnLWY/rJ314T3GCAwJBmWCnt
 UgUGhXMqX0yv05HHZRqbrRDT7AMtFO09+aypYRbO2al1oKXyK2pHw7ySXgcuDbquvew==
X-Gm-Gg: Acq92OFIWOl+68WKRef9HaF17tspq/TVztUxhJx1r1ejqXNdkzq31qORTjiLGe5D7wM
 C+0xh1c20RApcwnbH9t4UaQ7ynR21XQs+H4Dl9C+vjnMAhRu6kOyRipmVKlj/BSWW7+x0fHn11T
 saTSpqXsFQuxRibWc9eCnkUdLSPwSPU9MJbri2UIA2Z4ap8pDDuPc3Lyog2SI3OtTqgZ4W0qEnO
 0VgjnFTj5ENiCIT9S8lpAToihGFGRnLATu02yT/pZCt1iHuBmgRm5+iCjE74QMT2W5zjSlCd7r1
 Mv0FfCd4pOUxbDFe73IoWf9JhANlJD3gM45xzjC0On3VMRaDAnjwqbgdPhg5RBpwf2UBds8ZkY4
 7qhXu1qVnQ21nzYFPQMd+7G4B2/txjyX1/nkI1wtYBVuoWDyOkEC6VQlSBhy6GGJ6H/4yc2D4oJ
 kQ9L4=
X-Received: by 2002:a05:6102:6444:b0:631:ea6b:23dc with SMTP id
 ada2fe7eead31-71f5e2fc555mr7369032137.2.1781624074754; 
 Tue, 16 Jun 2026 08:34:34 -0700 (PDT)
X-Received: by 2002:a05:6102:6444:b0:631:ea6b:23dc with SMTP id
 ada2fe7eead31-71f5e2fc555mr7368990137.2.1781624074307; 
 Tue, 16 Jun 2026 08:34:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm43496454f8f.34.2026.06.16.08.34.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:34:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/5] tcg: Unassorted patch set
Date: Tue, 16 Jun 2026 17:34:26 +0200
Message-ID: <20260616153432.92939-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX2JJ5zdoGfRF4
 pKJniXkX5uJ/zgzaHYoD2lMPubzrHRp6efanxrtRtk6EzDgVFZg+8vgzLHFLUUy6HQURwFFggCW
 7AzSYkJoy76nFYsMqH+g2sKoZxo1lpf+ulC2KtCvNMcvKlvYHkFZgwGIzRyiyXPv3fMiQjT9JGe
 81VNBWor4HtE2Tv2zxctP3NbRQpnEBL/V0kft/HVWqv3g9tMOgY355xFzJmoZ3AmO1wRtqDv1nN
 MEZJKqolm2ZAPV3gOOmsdZ038exFyW2iYhlC/K32FDjohZq/tXYNpR7ll4RGAEeknwEwVGLZN3g
 QGd6PsmuPjmCrGCCIpFfA6goma0ikCpZpG73L2gmG0IcoMtLi2dJrRyNUPw3jzuNh9pm/TSKBBt
 PXrpSHbkNEu0q56Gr6vS6i8odhAGg7R1HUk5X+B7uMN2RTCZic+qMqTWJAzYJZ6Xk5SJTUgcwUb
 03YL12ONfwP3bqtL5ow==
X-Proofpoint-ORIG-GUID: EHQbKHNlQt8002Udnob-dkd9yNVT3Rh4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfXxrSYKN9XInQx
 MWNA4KoCiobxdj+bCIUt1q46WzNwVfL7DgcDNXbMnsLnegvoF0xVxExivwxiNA7PzcyJgMzVlSN
 jV0G944NBYUn3DcSteo5fJOYW1X74Ho=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a316d0b cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=S3685bXv7dM2Iy_4H4AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: EHQbKHNlQt8002Udnob-dkd9yNVT3Rh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
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

Few TCG-related patches I have queued, not sure is posting
them appart would help review.

Philippe Mathieu-Daudé (5):
  tcg: Include missing 'qemu/bitops.h' header in tcg-gvec-desc.h
  target/arm/ptw: Restrict PMSAv8 code to TCG
  target/ppc: Restrict TCGTBCPUState to TCG
  target/or1k: Have exception_helper.c absorb exception.c
  accel/tcg: Remove pre-vCPU ignore_memory_transaction_failures flag

 include/hw/core/cpu.h          |  2 --
 include/system/tcg.h           |  2 ++
 include/tcg/tcg-gvec-desc.h    |  2 ++
 target/or1k/exception.h        |  2 +-
 target/ppc/internal.h          |  5 ++++-
 accel/stubs/tcg-stub.c         |  1 +
 accel/tcg/cputlb.c             |  9 +++++++--
 hw/core/cpu-common.c           | 15 ---------------
 hw/core/machine.c              |  5 +++++
 target/arm/ptw.c               | 20 +++++++++++++++++++-
 target/or1k/exception.c        | 30 ------------------------------
 target/or1k/exception_helper.c | 13 +++++++++++--
 target/ppc/helper_regs.c       |  3 ++-
 target/or1k/meson.build        |  1 -
 14 files changed, 54 insertions(+), 56 deletions(-)
 delete mode 100644 target/or1k/exception.c

-- 
2.53.0


