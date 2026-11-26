Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A29606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ow55cTZO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aAdux/G+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWi8X-00079b-IB; Thu, 26 Nov 2026 17:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWi8R-00077Y-97
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:40:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWi8O-0000z4-1c
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:40:09 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw8vB3990014
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/fFedCrrCwJbyj+OP+1c8W
 OyGB2E7lX4qHbUf67s/G0=; b=ow55cTZObcSIhnA5z8jzoeima8GJiiJKNt2ki1
 norN3ohFmwm8ZnBUtW2zN1ekpy3BFbYQrFojk1W0el0MQuxs/cuOpYpzGD/XSv4d
 tVgG6/5wTYSDm7gFE5XKsDHtXm40K1m38Cdc0Gl6DhBgb9bR5obL1J/TuzF6fIIg
 My6jsU/DBDZGo2JdVigEAGGlfDj12GNPBSzN2DXcXoCS69lpOq7bqoSuzDmzf5jF
 9GngOpMoPd+EoQhRx4/l/3wJ8F3FYLXQ89CKLQwdNsSW4KoEktrCPsgQrYMQCQBg
 5wZiojJgEqBXo4B49o1GsQ/AnMkSvqRJu14uzFXnYNpuwHRg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak0401h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:40:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2373e9b4so842870985a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795732803; x=1796337603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/fFedCrrCwJbyj+OP+1c8WOyGB2E7lX4qHbUf67s/G0=;
 b=aAdux/G+Otly/zC2fUrTGOZBa+8ulTpcQl7tj7V0jei0cJeqcDIYwPuHTllA/Ig6Hn
 ofFjfaIOfjA+kGYLibV7wWXcIaHKLk+yIk7d/hbxTfSeTttguNzrblIv1ciPtit9Qbx3
 rCmpP53pcdv6IpwxDmsBBmg9OoIQWT8ysq6EmMhRJLs5Ayg5vqROiMlbfrz63X5pZXiV
 iL5uVe+3ugWQAXAWEluyCxhKUMv4V95ze/FToz0Z17xt1lpmTMr/okYOyh1VEY9M7n1y
 Wakxg8sFxUGHYHCZupOhVJMRaytMLScDqwygkMrYcUSSwNNZttY6qK6MaY4ddJJuMr4w
 fV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795732803; x=1796337603;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/fFedCrrCwJbyj+OP+1c8WOyGB2E7lX4qHbUf67s/G0=;
 b=eXJsoAiUBJWW3yRhhZCQf3W9fWPAMUYCwYPHMDTN4ZT1u5N0aye71aR2kna3K0Azwb
 LnazUvYLl0mYLnm2ndrrE7UDK9LzgiZsuTvFiN7HQ6xjZEZ5NFL0tvdCGiJncwIRcXiq
 sz+BMX8kwB491AAq6Dwv86mPBQc6ryXWmyloeYEWCz+hCFAFte0xZrbMkca6T3APS0U/
 mlIHKhtrNIV0HGVZLG3YfmQxkA0mfIevC781jtRiwH7pccXPw9ZbGYBpzWj/a3NN5DHU
 2XoArlcvlFAI1iZy1GoWpqwZ6zzYB8CE5mxN7ppK84jXwmU+k6zdpVmIE3VfeV5HkhE6
 vlBA==
X-Gm-Message-State: APuU4Z/kTUjC3gdoeoTJlvGDbOHNcGIU0b96cpjrT5RzkYP3WE00frtb
 QBYS/KlTvT85q6F1AAmguC58sOZ7nxkv06NCaOdzcQNlni8khf3pOMrNigfphzIH9M31n6GOUi4
 +0wjYsUDXESVZI/ZRAyA7Q1uKGXsUL4oV5IDDpFF6Liz8UsI9rFcx5XYotbmQ2Y37tA==
X-Gm-Gg: AZFdTZfftWM4BqvFvsb+rHbGbgDGtCVPWfIzzOIia/4UWl7wmYgmLNmeiFbYyXudFuX
 SY331HSFiQrPkfDZZpNkzxLVcGKZOLk3I87xJhYHRb7Y4iVRRcEGLP+dOTcXmYKfHHrqo26ceEm
 5g5QrSna/060PVpnRcwVohHM2BkoFpDleBYjiNKbAn4683P7yUlspZTxkvqy73CMbuUjQ2qXrjE
 ycwi9Xa6FacNwY6Caj+YWWYg6p4C4GHi2zfe7/q6OtKkn8ZXH5VqmQtZipvzSYxkP/g/Khj0Uze
 8mVbp3lG2kq4oS5DczAo+C3Cbn/NsTcNj68o/LoRYXUOwAJckwbuojsR27W5EifOCGt81fYt3KE
 zpiWk3USndJItpQ7KZ8a/RTV37O5tlU9u5JAMeL8kr52l3Y0HQgEKAkCGPEGBgJLmeD+5O4E49Q
 NyOwJrP/8cPkA1hQ==
X-Received: by 2002:a05:620a:460e:b0:93d:f7ac:4706 with SMTP id
 af79cd13be357-949ba8260cfmr3682199285a.9.1795732803122; 
 Thu, 26 Nov 2026 14:40:03 -0800 (PST)
X-Received: by 2002:a05:620a:460e:b0:93d:f7ac:4706 with SMTP id
 af79cd13be357-949ba8260cfmr3682195585a.9.1795732802651; 
 Thu, 26 Nov 2026 14:40:02 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm49423534f8f.55.2026.11.26.14.40.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 14:40:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/2] target/arm: Read generic timer counters without the BQL
Date: Thu, 26 Nov 2026 23:39:57 +0100
Message-ID: <20261126223959.62899-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b08b545 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0at1Q4f4uHMGvLL1maQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: kIywwQB42USOi8KCy8wAp4OJtDk35QnR
X-Proofpoint-GUID: kIywwQB42USOi8KCy8wAp4OJtDk35QnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfXyBxOMcdVZ8NA
 t8+3eB41V6LniNIiwffYjwk+F5YGcUf5s8b1C24xqrGyJm9PCTc1K0xLcxusOHhjNzcumbwFiI8
 kn/d7d1rD7T5L7C2cN936Bzam/ur5xqyr7d83oEZPUQ0Xo0BUQys6sRM4DlqmbNPbcgIeJK0pPc
 wtdf6udgY0i3vIyTVi6ZcI83TknDpvLxhmnzjd2Fw9vIsP/qK5q3gpgturEtGFbUZHfkTgbaA4S
 wjecEFxoLkdCmEbNVzR5h5o5iB6Z/jmx55e6R27WVRNP6rWEH2suwKW7lqN7sZkt6/lHa3pcxn4
 iyfzPSbn2P9kBjcshw8E7X3VA+ilRDBC+3w542kRMD7evMU8icbXSvbq3l9F9FVEMSEMz4/E0NC
 NsiJ4HBC5cOZG4T05ZWGuCJZzF+ShiLf9jznO+9LZLjy+D7Sw4WfgpZO/v+CrzsqnYLe76gEJpR
 4hnnbPXoM1TJBfawz1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX8YXQLIxPhH9P
 xibfApfjrk2+ebE6Jr43CgaQkessBJHKvR/pUxqjqWLGezOGlmyKZ0ZDbUCqvWvdcQDT8qZ5HXN
 Tf837GoewgF7qkDU/wF9PoYMkI582kQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260089
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ARM_CP_IO both ends the TB and takes the BQL around the hooks.

Split it into ARM_CP_IO_ENDTB and ARM_CP_IO_BQL (ARM_CP_IO is
their union, so existing registers are unchanged), then mark
CNTPCT/CNTVCT and their SS variants ENDTB only: they are
read-only and only use per-CPU state and QEMU_CLOCK_VIRTUAL,
read through the timers_state seqlock.

Under MTTCG, counter reads are no longer serialized on the
BQL; with icount this relies on the qemu_icount series
based-on below.

Note, RISC-V cycle and instret CSR reads reach icount_get()
and icount_get_raw() without holding the BQL. Call path:

  helper_csrr()
    riscv_csrr()
      read_hpmcounter()
        riscv_pmu_ctr_get_fixed_counters_val()
          cycle = icount_get()
          instret = icount_get_raw()

Based-on: <20261126222530.62175-1-philmd@oss.qualcomm.com>
"accel/tcg: Do not write qemu_icount from seqlock readers"

Philippe Mathieu-Daudé (2):
  target/arm: Split ARM_CP_IO as ARM_CP_IO_ENDTB + ARM_CP_IO_BQL
  target/arm: Read generic timer counters without the BQL

 docs/devel/multi-thread-tcg.rst |  8 +++++---
 target/arm/cpregs.h             | 11 ++++++++++-
 target/arm/helper.c             | 24 ++++++++++++------------
 target/arm/tcg/op_helper.c      |  8 ++++----
 target/arm/tcg/translate-a64.c  |  2 +-
 target/arm/tcg/translate.c      |  2 +-
 6 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.55.0


