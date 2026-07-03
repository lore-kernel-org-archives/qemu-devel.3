Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE55AC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwp-0004f1-Et; Fri, 03 Jul 2026 12:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwn-0004d8-J9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwi-00017c-Sa
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInft498246
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gfohBGLaZbWwSsM8BLb51a9USAKrCnCAVyI6ZJxJiSc=; b=Oer6grjYf+qYDap2
 tm3ZHsY2rELicf475RKbnyf47gaPjbWFrr64K3N1G8xbqH1u7MT5fZiIrES18bmN
 BQoL9lugbDjHmrEpZ5C7n4+xz8ZWc1R4taIYMaKFanikp2ql+HmiUOdq52qWL/wk
 gDm13HjDx4HOdoVnwOldaF29NZpMTDXK1h61X3EtRtzXmIRrRJ2gZ9rsjn2nFlH4
 jwKSj4VhRzI/SzU+jRRBaBg62dH4t9BgzBrQipiI1aSb4m5XQr6IfpnXM/s0VRoa
 Ki06L85BQO31mjp2Cj8FistMaxetD/JEbSk1Z/SAu4ynmxvN00zpA139nN+Pfm+y
 2Lam4Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjx12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so54390685a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096845; x=1783701645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfohBGLaZbWwSsM8BLb51a9USAKrCnCAVyI6ZJxJiSc=;
 b=V1O1bT0rUAWaQ7wLopl74IM/YKkCC4z4EModnBPQsiLBJ938FtUU8jhx7oHyNXkgOo
 +PIuw6afGAEoyl+YPgCGgAKTYWY90ZOonaf2Ea7nzIL+BLcwF8rB15ULcvRzAMyYp8S4
 qKfo4hsRrgME6LE5ScrIt8NhMYg30E4CK0fkv+DvEcagxnUP3Dz2/57Y16RRRyii/NHd
 P8RzpXFM0qNjnzlA+7izWMVDN/hiKoGRrZImqarlH/9JggibtWSW9ZpSMEuItWRxRzG0
 0vFWK/nYga1Yw6i277QdWOqS+Vtf2BiVoCFfmLQL72sJObl2Kyjzu22xN4T7WmKg+kJG
 5N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096845; x=1783701645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfohBGLaZbWwSsM8BLb51a9USAKrCnCAVyI6ZJxJiSc=;
 b=ncwkhYoCCo7S5jktYfj0uRz6r473y9LOZxjwtaF9uaYOzQy2GAzZXMCJL5ciBWk1eM
 WeiZvQiMs36NWPaojQZ7yZBnMOxmQvl8+5Dmb+9J9F1B/0q97jwzST0ComnnPJ8N1RhL
 l3nm0n5Z7RaMpDhBbJjpaw9ukwFj/RP349uCCj5pjbTAbSvvwsktu40ZQydK1cSMWYSZ
 v9xHlzQoYTVQNgv2oZMG47hSBSbOpCTesGTa/7m+TH7lxrntym02Y7hAIvtDCBlyPGhP
 VX0iNw8vzVuMXpS14lrx3E82saDU6kRhP+CjAMhvXx1cueQs8IXA0Csl4g6khcJiBpF2
 jPiw==
X-Gm-Message-State: AOJu0Yyx5zXDEbfOr1GkEEieJxSPmxtVOfXfU6Aji5+VYgTO3Xxrt4AB
 mIwa4UfFRctIi52mCfAHWJuGnyYdAdEATTxdfnL4In1ATEhN7+YbLk+/6peGibHmUQumH5qPaoo
 bd3hShFQiYGzJSpnifU1b3ZMsggz7vGVLujWnShFaT4faQJzVca2AYlnckD8ZY+KFfg==
X-Gm-Gg: AfdE7clXUYkoTQ4qX8cQ2G03fw3Lm9xHwQPSH4dRwPXfyJpVXwpsdj4m3Bdak+9173Y
 dNfqZgBq0dIWghsukDjbojkWw/n7CFvXL8yPnrw17D1+NDXddedZObItcbImWVkglTyDNT/Oijm
 xPIYt28/Cny7OSpF+XK2+fYiy3TyEiOnTyTUnEgJJ2zR0+l+nBEnK9QwrGjRAS2beoGimBJKleG
 Lz9HrfcR6dJqI48UpQ8Fme30pOsRpyzJENr626PDGcLw2e0BqvsHSNEhDbb09HFOpsIEuik9OZ8
 rhIFF2xMIN5kyNXBr9H6Zvs8x1XYjyUTi9U+ARbjk0zovm15UKJO6Qpzd+tjhkCJt1YmtSjF6iV
 gt8c5fKE1l+R7t6Zq40pjuAvhGv+KOocMPVr9rMWtLV7E4gvtUFe0lqs7jXm4OJkEG8eR
X-Received: by 2002:a05:620a:46a7:b0:92b:67e6:4b73 with SMTP id
 af79cd13be357-92e9a52b304mr19063085a.74.1783096844925; 
 Fri, 03 Jul 2026 09:40:44 -0700 (PDT)
X-Received: by 2002:a05:620a:46a7:b0:92b:67e6:4b73 with SMTP id
 af79cd13be357-92e9a52b304mr19056485a.74.1783096844253; 
 Fri, 03 Jul 2026 09:40:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm754264f8f.0.2026.07.03.09.40.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 22/33] gdbstub/user: Directly call
 gdb_breakpoint_remove_all() in user mode
Date: Fri,  3 Jul 2026 18:37:45 +0200
Message-ID: <20260703163757.55500-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8XbYSee3XAYatSMgBtfYDK9QkO2OJvnD
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e60d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zxLOgqzoZ8asriTz2EMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8XbYSee3XAYatSMgBtfYDK9QkO2OJvnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX4vn+PP+kjk8t
 Qir/LdjrtvuUWRQXRG+q7b8qzJVV9xv8lP5mp6USRFMgIbANaudKvVa3py9gisJct0LywL5wQiP
 A9WH1HjBqY2oK7hsqQBqIQD2O5EL4MDVu7wr3niY2lU1gT2wKuAW1WfO82yQKyZltkkF9Q9A5y0
 +NzmIyh+H8hqvQzLyZMPxZ9446bGJyp6DjvuHuu6/GZmHVaVNkwfJaTnFWqtiqGHplgEhlJyc4H
 5CpmKJmsFLyVqNapgNDMbJlv9w2YenwIORrCHmHfEiCrnCz46U39flFhWCkGJqCIWIzJ5cmyKlP
 +O7dJP3F5fxRSVAvlhjKblel2NRGz37Azb4jaI/jbB1Nrg9xkj4gxeE8me4+C8pB+RGqomwVRCu
 CC6I6Jt9cBnqJ0tmAKgnUyCL+UMTXY8mFxASxaIqJDNhdPh8oJisDc7AL3mnPTtTJ53p2o+Z9tu
 raAkYzKw44yKQpEZEJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX66oqNquyn8uq
 P0w/4hzRHIPUucQ7tsPzy0WH/AEUokiV6BBLE1r016nXx68a7dnN+1/u6KqmUy8NJCBs+wxLlau
 YID/yIbFXaDtZCWEAY4s3AVMCZ9e4jA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

No need to deref external methods with unused argument to
end up calling a method defined in the same unit file, call
it directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 299388b9f71..90d6ee49fb5 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -557,7 +557,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
     close(gdbserver_user_state.fd);
     gdbserver_user_state.fd = -1;
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        gdb_breakpoint_remove_all(cpu);
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-- 
2.53.0


