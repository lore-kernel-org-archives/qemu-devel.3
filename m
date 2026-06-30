Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87098C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegY8-0003de-NS; Tue, 30 Jun 2026 18:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWl-0002dA-Pp
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWh-0003iL-8o
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDYOU2942530
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O+CJQ2WaPj1ekIqswOivVJT69nveLqslyZ7evlwq6PE=; b=ZqoFldRRRtiRog25
 wipxUrFJMzQXSRnkCZcUO9rpFgssPMsV6TD3u0E51YISjYFeIulK80r7FwQG13Eg
 mwfVP0nlgRC7md7IgNwRUmou3erAKyvII3k/yUPKFth5mYijU1Jo2K2FxGhhAFPu
 LxQJK5IyxvBzEZkGh5sSe0+Cfv42kuhjoEHViDljskCbaf27t8e1rMr8C0EccSoF
 sbNgppZ+Yumo9lrzV9wIPvh2WUFi4CdLpOkKs54A8EEhxkMphH6NDVeqXAVOc+JP
 zWvR7zHstf7F4z2Wm+XWqJgbXfiJlRIFVURtXO5MZ2Nz2Topf9Hs3W/iyhwn1DEM
 9ANM9A==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h41r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:51 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6a177de7766so9787eaf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856911; x=1783461711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+CJQ2WaPj1ekIqswOivVJT69nveLqslyZ7evlwq6PE=;
 b=EHalOfYlJ6qh/7N2R7s9XUF33+M7cCtr70f8QTrmD5jIPqPb/6PSkAqvTbCmzJv841
 nihZM1cvHwlefgUlKoxGJd4df1ddgJl4igNC9CibCkNF210ni5VoXL08TDpRcjIGReKI
 jkKJhj6eWpvy5AWlbM92JDMlcBjoNqszwYgSOJkm+gs22L0SYDy9YPoH+A2lKY4bVvgu
 eG9ZoPtYtQTF2Oq4f1mR7vpyBUo5cypAUMl6zPHi6G8tau15bt6Y3AMyeWJw6NFWPRBE
 cGODxTdR5j1mdXme3PM7HfV3URGUQ+aqlcQc8NNXvkn46X8BY10VxBTIwDEuLF4MoO3r
 uhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856911; x=1783461711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+CJQ2WaPj1ekIqswOivVJT69nveLqslyZ7evlwq6PE=;
 b=JSZph0yNb6yrE9HQEKBE7tPA5S+YSLWu85D7f7PeG0wpI0vX6fmRPQJakkGyZRTcQD
 VY88AFwjQP/sMk6zQT+UbLfUFVWtk1PF7tYPx+nTp62Ze/miGGqyd0aTwo2bQyXjNsiu
 p1MzO1SdURiM0wLIwICFmcberCkvW6QiaPRZjL+nWU6iyHUpGbYkDo9KrkD0DGUeqHdY
 ewLNH5Gtlu0eoOhdZ50XkNEyyzto6DOngk4BS0BZswAcjFC7Lv1TCGGYheuhXZX10sJa
 Qi+u2yEN3kshqIk88H29wKLhJRLVU94sssKZ4z4+WfWlU30H8LUpSblPJ/hHME6pSw7p
 CySQ==
X-Gm-Message-State: AOJu0Yzhl6XWeuXaeGdZjsYTIPMAVJnA5f01/FV/3N+vdlIQUlRKL2BM
 6uXjI42OmTJQaQkB4TuPSWUEiQliSD65PQEldeBTdfi0te79dr2nu1tgIIBs7hqj8qEfT2NspOn
 Pnog3oWK3iw+0zIiDtIypXZVt6phPt/KqHRu9GocqrNlsJGrh5pXaGsnrvj3rlie60w==
X-Gm-Gg: AfdE7cmiy9Ve+ov239VaHuacqDXDtui/nVw/XZiayV5rW5eHoMF5RbdnUPjsQPxHUtR
 s/FPf0+QZ+jxmftIvJJD4yQHYK0XIAG+A5R+cO6xFlkCAJ494+Azl6K4pZAo4co2b36ZLC7XEmC
 oOPIOCXK9DXNzjeeoMA+aU4KpjBtLr4x0UcJWOS6EzGXgMiwOpZWFaVmt64/Blw5OKImWLckNze
 hNVuAGZGGsM3ZxQYpvzTbZiOuyLJDcfv/SwW481at/uFADPgjziAqRZFIWWCINaRlNX3mmEr8iS
 LvyQZTU3Pjdr74az1z8+lpvvHuOSyN6v7S54rts+49H64hLXe0XZ9zf55AH4bqdjiPxdlIeMGJ5
 veHc0aYcwrTRirgVwc5Uyso7+ecDH0wlcJk4TkhA3tGEhxmM1yeOsrgjL8eHdvJWm+K6t
X-Received: by 2002:a05:6820:8107:b0:6a0:e230:61c5 with SMTP id
 006d021491bc7-6a196b35eb7mr1622722eaf.2.1782856910317; 
 Tue, 30 Jun 2026 15:01:50 -0700 (PDT)
X-Received: by 2002:a05:6820:8107:b0:6a0:e230:61c5 with SMTP id
 006d021491bc7-6a196b35eb7mr1622688eaf.2.1782856909916; 
 Tue, 30 Jun 2026 15:01:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm17134445e9.2.2026.06.30.15.01.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 06/33] gdbstub: Add trace event for STEP packet handler
Date: Wed,  1 Jul 2026 00:00:33 +0200
Message-ID: <20260630220100.1289-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX36v/W9eDlryF
 pYbAlbwWq89ZZCmYXtdSX0T3DKwTKFpX3mnLA+4KZr/ja0R67NBi5k9Z+uBjmeafkZSxOvuuHlV
 lDjxuGwAtoTiLtzJg45A0+z6NbutT7Q=
X-Proofpoint-ORIG-GUID: Lmn6cUWa7CGUMKXuFWBa_g09s2unZFCy
X-Proofpoint-GUID: Lmn6cUWa7CGUMKXuFWBa_g09s2unZFCy
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a443ccf cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=TahVrclb075nq1LRks4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX49+WAbyfXTt8
 mSDV+FK6WJsCCSgRSMH6mdW3Adih9Usa+52TIPCfPa+0ywpnaSUY+fdtulTeNIUPN4V7W/N/KYa
 u9BToyRZsb15betb+hJGiOKr27vN3QdEuS5YzNPXAdsi3mcj7G3jISf3lwqMpfRcDNkd5FetE7t
 8CIwhATnC1ozA8fR7XPiDosjkKucO1QC4RUTmzmkjsekW66PtVghzjeiDtaiYlW3p7qxkAX6W0m
 h5d5KgNLFSSFg67XF1hhgs7UXGbclnUwjF8YdNdJd/3vY3w5dnwc78itChelt5DNss+MAa9ZcW7
 rk6EoLKTm+GUKmBo24FoeTox3j1WbxnQ+cirDbTDZtRr9ubHH721IgzfW0LRoPM3RLjsNc/4X3t
 azc/OmhXe2w+MgrK1ecXMTMnVjDiqKcgY7CGIs5o8j2tsOcFYjxtmqV7swsItzMPCV7Th1F/Ima
 eMLs95vvlQN9gGGyCig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 26366acb674..246e7746300 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1369,6 +1369,7 @@ static void handle_step(GArray *params, void *user_ctx)
         gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
     }
 
+    trace_gdbstub_op_stepping(gdbserver_state.c_cpu->cpu_index);
     cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
     gdb_continue();
 }
-- 
2.53.0


