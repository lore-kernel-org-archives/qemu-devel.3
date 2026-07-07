Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876B4C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Hk-0003c0-Cd; Tue, 07 Jul 2026 09:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Hj-0003be-IF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Hh-00007r-Gy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8uWF3676533
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qJrctU8DFjI8gyRChYhTKt
 AezuSpDY0ofKfq9R/Ymb0=; b=Bqg83lwCTxtD7fJ/S3oDdw1YlBJlOquJAOmYTz
 hSixdahffeXCyNSmmblYjX2srS/qJwPqe02sVu673xfvHR9oSvFb6p4BQtB1lJ02
 1xVIC3ofUbPOa+Gtuw1FwFuvTYmyzBCUz++MQ65FvmKrqgiIIh9Lg/EspIHw76N8
 lIoSf2CTrses70h/8vh8OUuZKvv5b5rK2dDtoetb9OeO7ZIOeLR285JYhlL0w2x/
 mYihtK4nwusJZNscMS6uuatJmiKDtVfOyQuQpLfsSTCoBHc91O01OtlFVHytdSpu
 Ne5Y96EwnejExMP/3i/sU7sRAYEyI1hjusgjGu642J69DcJg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15a9sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:56:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so62242021cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783432583; x=1784037383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJrctU8DFjI8gyRChYhTKtAezuSpDY0ofKfq9R/Ymb0=;
 b=HbzZfn8vUeJgeiFmqFGrPfz2gUfK/ksXSFsm9uB5g9asv8Q/qIY6OJBzntjeXzwRCI
 L4rZqpuj+fTrlStPl908i8R9uhwyE5VEYRhRXPR9OeFwEIrB7n8++SkwfnRvIxbFtq+m
 EWk7Vx7Mk5fJOZXbC9e8TSerJEiEnG24Q5u0NiAptdMOP6+t3aMnjh7WfGm8yI9xXOBr
 glM/XvLesg4KG2uDjmhXkEPvbNCciav7AMHMbpIKH8Nnn0u/vCC0CFOBzdwlfHA6l496
 b4ByPnwwXoZKwWt4yY2H9oFOKlm2VRK+28wiaLVM6Lz3sSNNqXwX7IrDgGRBKX106v6V
 twQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432583; x=1784037383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJrctU8DFjI8gyRChYhTKtAezuSpDY0ofKfq9R/Ymb0=;
 b=nR2z7N9/sohHoY6lOemX64RqxbRDKXtzupC3nyuPIR4jN2zJskBUY3aypfniKoLKCU
 tJXa85EwEDqXFa5gTTRCxzyUdJI1lPeS1tXS9qMIzlb+lU0B1pi3JFuk5U4ufDmEWtCj
 sGxDRyjVAW1bKxuKXu8ZcObRyxGpPd1APAzmpKkn2fioQ4Z4Z87i71VnYvqVMMwZjn3Z
 X7vdzZ8xqkPXjS4/O2gC6MqvawHkMBXvMfNZcVyiybVB2byC6rP3Ytt1QDhcccjtsFkY
 rv+L7e/b06xQwMEOFTlRGi0kV190sdM69zzY9qymUh8fXv6gKEr0d+Ugx2Hr/5BdZpSB
 /NlQ==
X-Gm-Message-State: AOJu0YxQU/T5OBTg6Q9QccxIDf0wwZcYvuMPcSHwiWdGhi8KacfWpthj
 aICKoowA8R6Evfiyx097ntbRWY+UFJxjuLNnPeVV5Faw8yN2IpfKZHGGPulxP9KbDF+8yzLW9sC
 DlyR62EDlCnUKwuxRrqI7Od8DS8vz4q9UGa2s01ReVgy8us4qLX1T18t/NIETkRm4rw==
X-Gm-Gg: AfdE7ck2s+NMr1uSBp3kdgDtt0a73M0vb5QYt/Hq3SlKqjhtcBjXRj4LGmvPW3YXHmA
 xh7loyMzmEWqsMobKCjLIBtTeTpu7Md98v0FPenox4zXK9kDJDAaf7LWYAPyAx4tccIQ4FyPrEW
 K5ynvIUCkY6nq1hBNo83GCszBGYgvKLknwoPzeeN6kOdYzhViCjkZA80nMXh5BgfkeYAw/5eT7A
 Wp8yArU063U9sgdXqjElvrO8wR1cLRwSOZiApHaa12dy/p2XhmXbpJ7Vr/Xuo479YOluJAFOfjK
 r821oOuUTj8n/UwHFz7DaEztaXFz9GDHac2tLiUoJWUuZnQL+p4QpJSjUaU/JS7OAWXfAH+5D0p
 te7YyDuzA+51nJtLJYV9sha5CPH6l7rKh5BjsGuUzRW9Fu25muEGWnfnX5nMPOV7gaVD3
X-Received: by 2002:ac8:6107:0:b0:51c:1811:6eae with SMTP id
 d75a77b69052e-51c748790ffmr54534701cf.47.1783432581889; 
 Tue, 07 Jul 2026 06:56:21 -0700 (PDT)
X-Received: by 2002:ac8:6107:0:b0:51c:1811:6eae with SMTP id
 d75a77b69052e-51c748790ffmr54534431cf.47.1783432581424; 
 Tue, 07 Jul 2026 06:56:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm35510933f8f.26.2026.07.07.06.56.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:56:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/4] buildsys: Few WHPX improvements
Date: Tue,  7 Jul 2026 15:56:14 +0200
Message-ID: <20260707135618.53561-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gJI1LK9oYK258mPVOWnFNJF1z4rYWorH
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4d0587 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=FPyRuVExgD2tslUSo8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: gJI1LK9oYK258mPVOWnFNJF1z4rYWorH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfX+joQa+wHJvpf
 0964TVcVXAsyNa9IsBKzmfoVHYFec5jHQ+5sE8HD1rykDB+SP3txvNO3HaTR37DOPZ3lSSKrn+m
 l2MnhnCnBxpfr81MJG+br2BYuBd7Y0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfX83OEGojFWAys
 qwKh9jC8n59O8YMckVgCw/99eSIUIxtqSex/wRXfMXDSXDxLvNWWrVhCQrOSVLbR8EQ36a68RTO
 GdnfOB3TBdxkorIuGPLraAqA1yjdGGlOIq2Zf9rfpTKxzsLcOai6i0nnF/Q1wG07nQdoVe3HBOq
 V9AP2iRg2BmtuKLgDiRpeQawvuQiAi8ZzHfT/MVfwk9hngksAmQ3gq3l2WllaeNx4m6dyhmt7bH
 rZKCLiL8zdR1RaVRj02Qg69tW1okEd99G1XGN3eWDVBuRqBBW2sEJIcgRNevR7UVQir3wy1NJtb
 nX+f3GqdkyRqqpVe9X1vmCvtfCLm8q+fGzhSVwr3KLSqy82vRFPcjhjlZHKJgsKOBFf3e4rkHBz
 UpPAOej63XTABlavZJe5FeY8SUxLDU5WihhEGvpDpFup0qMUH2bp3k/Dha+8DrOmaBImdh9mlv8
 K4Fn9555FjoLM3MWF9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070136
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

Few issues noticed when starting to develop on WHPX:

- WHPX not automatically selected as accelerator
- ARM Virt machine not selected by default
- mkvenv.py failing
- PYTHONPATH broken due to invalid PATH separator

Philippe Mathieu-Daudé (4):
  system: Select WHPX by default when no other accelerator is available
  hw/arm: Allow using Virt on a WHPX-only binary
  meson: Simplify calling mkvenv.py
  meson: Do not assume PATH separator is ':'

 configure                    | 1 -
 system/vl.c                  | 3 +++
 hw/arm/Kconfig               | 2 +-
 pyvenv/meson.build           | 7 +++----
 tests/functional/meson.build | 6 ++----
 5 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.53.0


