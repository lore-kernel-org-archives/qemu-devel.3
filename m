Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE9EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegYN-00040T-0R; Tue, 30 Jun 2026 18:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWp-0002fq-Dy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWm-0003kP-HO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDlZo2937268
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4oVqV4TVjvIqWPN1HoisnzLzhW+GkrfDL0s26Pl3fow=; b=Oz8t/yI2yqoaGjO7
 tRtKCLjtBaAaXNMmHiTgJg1fNFB+1Nzg0aZy7xJ6Umre0vAUz9gX95vL8OOlHAtQ
 QOX3ToaYI5MZR/DAUMeNEIu7IZvvDsUvynKJB38Lx62g5sgBR5wblvEZ6k4Cr5Uq
 bWcMEf/r3MV2wLceRT8nOsDufUfDwJYvF4yFJAQf+sSfsWyKESSLnkrbMfygX1O5
 9bH2e0QkcfaIljjubrDZ6vjBcDXiQqtz6duhRmQKK8x1XUlaA17eC7MfqV3OddIL
 Oqs1IWuRne+5nNzoKSZSTfPSTIyF74eRZ+xxd3e9L9NmGJFy4r1TTqU8FTQiBoP1
 NRUkMQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0a3u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:59 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5954c5fbcc7so4604346e0c.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856919; x=1783461719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oVqV4TVjvIqWPN1HoisnzLzhW+GkrfDL0s26Pl3fow=;
 b=KW2jPhpULAUeU9aTqioePDwP9XCHIuYWrPJG120lj9nATE8xGldZN2iw9Eqz9QRDXX
 qwOHHDu+LOOFiYoF/nnlGacyj/QJrEErkno7hoj6T+5P/TEAdv0q74KKaS3I8dA1wIio
 ULRTVrc9GuQ14sF9oeMnVnctTfygnWX6u8KDg0/TXMW499L0DT1w+aTFxlUZ1urj7rz8
 y8tSpms29c0nezSz+Hp5YHPZ+a7Ab6UbRd5z+zR1OLjpPcSbEbAFO/RfRquPksx7TOER
 zK5bsHbcqbM9X0bQjU96xKLOc1aQ35jPeMDTtFsdAHeyQz/iRaCdbhBcUiwnGXd4TW0M
 tyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856919; x=1783461719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4oVqV4TVjvIqWPN1HoisnzLzhW+GkrfDL0s26Pl3fow=;
 b=NfYJZ+G00dFnlsT6fd1eWItr9OhAl5q4+XXruMs6OvHkqRyosLdZG6xu8EDXL3XXUg
 nKjUyjLhpjQB5e/qsps06VSfG+JyaFM5KS4uYLOlMI40LRVD7dP3l+VsGRU2uv3JEg2z
 a93oGrUrktGEdiyFeQwY/8MIZyl6zfuJwWQTewhANDqLZ9HOGYr2AT7Dce07AfKTj0CB
 wEC7Yk4MMXJnWLmjGvQGzj4HHwsVUkecTnvTYNFN9wFcbWH1/X+30Jz0yL/WC2roJAOh
 ukxe0jTFyaRg16A1/gWG/42BIXz6WeGs/Xm7FL0LFeEjMHGaRBteKcpScYIWbM13XyeK
 qO0w==
X-Gm-Message-State: AOJu0YxU9d03esp72YTI6z69kdXuhI4Hx7ytdT+CZFVmm1R7+6E6LSTL
 ThCMtDtE98PhtDVxJzqQxaGQe7cN9FSiRxT9cSUyRVgtc3w4BtPflvS6hL8yigccovY+HAWvfxY
 oSAs8XDDfigfTeUJv4/RFsxOxYehSlgFDGcv7est7deeP2aFLo5i4G7jbeIGcj/m+qg==
X-Gm-Gg: AfdE7cldqTldQc3op5LTKQ4bX3Z4avv5dhc/bKZKS3YfzOjIZ0SOHM9kB2TkTNYsHjD
 KVHn/DDAoQJcA1XkIZLdFO4UvKlO7BA/O0TloIK708PcQ6oecN36GP9SISkEt2DqMf+fJ4jB75p
 JiRhFNlZjHnDhvPXFlC7Jhif4Xo9a4/OKhVVeGj6KUOurwQSdM2Sj8v0AHaew7NwCsgPSkbLvFx
 aavFSZsPXG4yzWINXHyq72e+P++zCfbowmPcaLgXkNZow36aI0ffMjfjNWhM3LWulUyaffiNRMS
 k5zFwxfwDLJyP2N/2yaeLS9gVY5PQNQgsOEAoTTVLv3kE+rxO2IpN0IH5+lVX2o0gSttGB4+OGj
 HpWHHSEd/N15Kd7k/33r9hNOLRjAF5/ghMGp2eWqIyM8jZb93k5tN2EcELZ25l9pJrzqY
X-Received: by 2002:a05:6123:2e6:b0:576:c4b:460a with SMTP id
 71dfb90a1353d-5bdbed438b2mr2731093e0c.8.1782856918105; 
 Tue, 30 Jun 2026 15:01:58 -0700 (PDT)
X-Received: by 2002:a05:6123:2e6:b0:576:c4b:460a with SMTP id
 71dfb90a1353d-5bdbed438b2mr2730896e0c.8.1782856917293; 
 Tue, 30 Jun 2026 15:01:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47567a6f0ddsm10608340f8f.37.2026.06.30.15.01.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/33] gdbstub: Only return E22 when reverse GDB is not
 supported
Date: Wed,  1 Jul 2026 00:00:34 +0200
Message-ID: <20260630220100.1289-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX/3iRDqRvvBxk
 OTQKKNpz1daZDxQ5VUy1K5HniELS/F4cgU7YrZZotLzIfm1xtUXO1HdHcGQde/aX4OrS/0ivHrL
 ZKlXc7gpAM1J1M1kWVf2Jb7gbS9QGJG5rEkLogF4UCNHCXq+2hH9k7S174c7d0mH/MXcjcMI/+E
 7Z6QfYB2II6KoidUI4mDqeVAIEKKe7kpyxMwGXjTnIdchHCKyBcCc2KQuK/sL+qr6cgxeFhBep4
 wQuNoCidLDhUpAspeIH0vHp2MdvMpYhlZQIEtGbF5LPXl0U5vtT407O9CtIbd+izj3Ejuk2UdW9
 74GDtOlqYCzsz1cvzM/F1rbR+4kLvKXdRXXEXAIQbqzXdi3V85PFWbNyohnZy2ub1EjYnvEmwNN
 ZXlRjwLPW89vtQaPhAOFfFKjMcj6T2z+/QrnhVEOtz1Gr3xDTkrRDIYyk6ZZA83Y/WQhFA9tI+h
 2dyWZH3StuPa8JpX3eg==
X-Proofpoint-GUID: XbQ_7IuYWhjGDpWc1bYIRWzBBJL-mK6B
X-Proofpoint-ORIG-GUID: XbQ_7IuYWhjGDpWc1bYIRWzBBJL-mK6B
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a443cd7 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0n23ylXGgdPVI_k3iFEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXy5709awRtoO4
 mnQd9xc3vek2s58CxXopwFeX617hMUDbhOtMkv7eJJTg6SOzTKtLbF98UhbVH9mTmSDPNsFCUBR
 KVupBMLIOEhAjSgPU4YdKMu9DlZDzBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
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

No need to keep processing the arguments when we know
reverse debugging is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 246e7746300..f54415a9db7 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1378,6 +1378,7 @@ static void handle_backward(GArray *params, void *user_ctx)
 {
     if (!gdb_can_reverse()) {
         gdb_put_packet("E22");
+        return;
     }
     if (params->len == 1) {
         switch (gdb_get_cmd_param(params, 0)->opcode) {
-- 
2.53.0


