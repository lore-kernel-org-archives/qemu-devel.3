Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25141CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdnh-0003OE-DP; Thu, 11 Jun 2026 07:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdnf-0003Nj-FR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:42:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdnd-00033M-DW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:42:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA0xgM299615
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iY17PXN0gY1pk0HBGQaSgB
 RpyAyj0RPl5a2huAp8jp0=; b=Y+NnTD0sl0UzFHiBgu+jXNVudYuK+3yVwvTROI
 afoBMv3IjcVWzp/Wt3BX7aILuDPl38MJeAfQ+/9LP43fWeU4AyMWgtPb4Z4t+YYp
 jTQyxt9duWHgMih8K+BPDybCfGWSKk9CCrwnQ48Mw9WiVfa/+p4WZPD6qRBj4yz+
 MntiGyKAyss80BclzxWdqWr4xz2qyMezb4N4fTVypyLh+PgaLQ7W9IKW9+70UNKu
 evB5ojz4pupdYqKTqBD6gSC7GpRWmVp5+J6MQLvTy8KqW9YoT4mOk4LlRPjIfX3w
 +IheVl9iB1mA2GXzM/UyDP37eMbKHVGjqDVI+gQKh+ZcR99g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe7035s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:42:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5175bb9d47fso151362361cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781178135; x=1781782935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iY17PXN0gY1pk0HBGQaSgBRpyAyj0RPl5a2huAp8jp0=;
 b=O2hFO7hin9y6lmLdWKGB3SwUCZVfc83cQZ/ENnXJ9Nhye37RrNATi6hk0fnY9Z9tmj
 ZgnUdYHkfQuNuUWoeU0BRgPnmLNP+8lQt0PAUHSZseUxGcvcX5jww9iIx54mZrptIt9l
 B43xR7REcmMzbllymrysVwmvkyXOcC/uRVsIolbYoPY8nH3anGhunw3tnITgIrcUmqIW
 UQxUTe/yT35IXC9h7uXVx9DKopu256v1ziDvnmNJNUOY8S4g8vmx0S2E7zot0d77CvYr
 1t+RMbz1RxHz4KFQqYDChsGNor/7sZWFJWF3cfMzZIjdjyC6/IMReyjhCJLxf33bXo6X
 rEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781178135; x=1781782935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iY17PXN0gY1pk0HBGQaSgBRpyAyj0RPl5a2huAp8jp0=;
 b=X7MIavP6Mm7IUKU+jqy+dDhAQn5kNrHSoyIDYaBox/f/p9S5oy8E6zTSw1CWfG1Brk
 11sGCpCDypzB/MckPRzY5ihTb9Yo2C1vY90MjyXfddOOyUDTroBRCJ341QO7RwEYdYuR
 05jWNQLupsLtTa5wmRZp38JvRyfKmpdSI268dwGXl/ZxYHmuBLXKHHEgwKXNB3lF5fMy
 GuDTbWttJb2mJ/bohrIpL7hb2+/mMK0DRQBJv/yUJalL32x6OUZzigd5b+TbgzKuct3i
 CsNTevmePanCbQFCIZPBzJbi3Qo6fbMwYUwzvRkuNC+AX46TLRisSXh6GxRMbMYv7T4P
 +hLw==
X-Gm-Message-State: AOJu0YxBg2WcC26kLWNTSNFqZJmU+DtKgek7UaoirmvqayejXDyVg7JH
 NDuY024hZ1zvwnr1bylh1Hfor7nTYfFzvjPqRkcxcCwfcYOZ4ONG3R0r92c54cpqIF7fG+rDq/i
 x5eOZ/hLuBW4vcXDg4PeLXzaawbXUbSfb94AxE+sCgXNpxpJyjGoF7hEqPsJcnhOfcxE2
X-Gm-Gg: Acq92OGCgXyhvXda7CWVQ+EpcfHPJeSKHsSkBpvN2KkJDVyVLt0OZh+/L0YopcVhnY/
 pa98GaEgRpIUoHqvy5LhWd3LqG55YQmZooLw93+RHmxTBfEfrUoAzVNHEUWuzQ9I7x0MqPbDJUz
 e0qkXpwYYU+tRnaU6PqXsEdOwH6JhiRLg77yNKeYLZavL7lauzTDgRXmLcMo7CQWIvbWcuuA+K1
 eOJqNSIOAc9r67ploMY6rjg8JLrlATkdH9iBcguvmzugxHX4te77j7yOrKDbXyiDzC/j2ieAtxt
 3h81eTKYKiaiN6BK8dd+zc3DDFFcN5RW3GVW+Mq9FXIIXUnxRsMXM4Xk+CA3BVt6gLa+ACwXxyG
 Brg4Swsrh6c7MFuBM69bKeTAT7v0IoTZGjg+mhjhf569DPd9qZC1hctx7sZvMfYJ/QUXY8rCyrA
 bw30UJH0Ve9mRovQ==
X-Received: by 2002:a05:622a:1449:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-517ee26676emr36568621cf.52.1781178134971; 
 Thu, 11 Jun 2026 04:42:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1449:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-517ee26676emr36568261cf.52.1781178134567; 
 Thu, 11 Jun 2026 04:42:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm81445626f8f.2.2026.06.11.04.42.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 04:42:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/2] ui/input: Constify qemu_input_is_absolute()
Date: Thu, 11 Jun 2026 13:42:10 +0200
Message-ID: <20260611114212.27472-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gBOhlrPjSPshjvaf3LOW2TdbX0MimYXH
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a9f17 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=hASM29Ypcn5g6y9dSDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNyBTYWx0ZWRfX/mmgh0Dc3IdK
 xUrYm8o69NqdnKs4bbpYLdD0aUoOPXq5Iwl3iKsf4HBR/yZs/mxSguuJn6fPMmsOI2LG1n6CRrk
 /NCujadjMe0mWBS6E/72GKd+iW6wVO5trzSHKdemGAotN0vYY46lOdutUbLje7XbO3jS7v2Zi9D
 SRd/zSeGjCYUIUZsut63NvHBw6oD6EI7NKFJSv+oM6RVgQm0vAkG/+vVpi5ksMUB8njcUVqGzqN
 SPmc1kosTGdHCpqQ24S2MQjxoxdjX+Uj8mJk3DMxJ/8QHw8Y+ohARuIE3StB+eKWaZEbMMRRbJz
 nWm7b+E5OICeyA9Higs6WxRjBSQ2qGzKJ840hd8PEaM/afkzI30r7fKjkepCv7GdJdQU4jM8T5/
 Nht2FCEb82wxIgkLAG0d4YCFsEjQ0pMJJgNuET46m8ld64837fbF2ml1V1RiV+meJOpt3Xchn0o
 Y7MVdwwFwxYeDxo+GKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNyBTYWx0ZWRfX612iJe/FaHlr
 vEhdhewbZVslVnJcqQcEXbN/DP2oZBCu4x1dmgBafFZ3wPKJ7CAp9WKrQiNgVMDGWpIGiaKNGo8
 IYccrUOxtiU7hToSSri60ZzQjj+W1Ac=
X-Proofpoint-ORIG-GUID: gBOhlrPjSPshjvaf3LOW2TdbX0MimYXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110117
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

Notes while reviewing Marc-André's "ui: retire input-legacy.c" series
(20260610-ui-input-v2-0-f68452dd6a22@redhat.com).

Philippe Mathieu-Daudé (2):
  tools/qemu-vnc: Have console_get_mouse/keyboard take const QemuConsole
  ui/input: Have qemu_input_is_absolute() take a const QemuConsole

 include/ui/input.h        | 2 +-
 tools/qemu-vnc/qemu-vnc.h | 4 ++--
 tools/qemu-vnc/display.c  | 4 ++--
 tools/qemu-vnc/input.c    | 2 +-
 ui/input.c                | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.53.0


