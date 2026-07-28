Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2765C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlR-0004Sd-2D; Tue, 28 Jul 2026 00:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZkB-0002oy-67
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk8-00029p-MT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ab2U1714803
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=; b=U/Ley+2H91U8OJkk
 aunWjz+Hi0yGRQzuYlMWLcB7QDhrGJAKOjWH1f56qhs10vd9gxN3YV6NTD8P2dQk
 mcG+eguEiTqm4UzbhxZELSSNyMSH8kwSeZ6Uez+KlLO+FhRy2wHiem+3Mdj5RIlW
 Aojw1MW2lluI6RtcZlkjZfsqyWTyOvwsakRFZvYwmWEI6Zxj8YXagsR1IWGbBWcr
 /I4/cxhAXmzMcEJS0h+6rdPTigP45H992wXf9jlT4bzeex6LRcDBje5bUPQDMx5o
 Mx+lop8nKkJjcJZT1YDJwRrn9Ww6OOwawXsA641YwNKrmZWR8lEjMQjdmNYPxZeb
 wsHTgg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjyk8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb6dd278512so2218804a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214108; x=1785818908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=;
 b=C3ZJr+h805ni2c8VFNuEMOpjcjctBxcU038G5wLKPtxVrrk3WzxDnNEpLJAHmIL3EK
 aczmjfxy433/sOKbuSH0WsVP/Ew03rOQxto9QHk+6THulcRw8MSuxz3LRlxUa0ySbkHs
 /hzkC65Ds4MoqohQ16sB24G+r6lC6sFk9nyx2rbkW/BP2S7Y2davXEf8lHntqKptxBRR
 GfW9IRIglVq1ysCHrId9YYa7xs0r+e30gaIv9+sQdnX+c5FRmFbmR5T1XddZhrJ0STVq
 32w1vdEMJaPP/ogSJjb05lmEF+FOCYdCXrTChjq7bqHUdJbumVM4kCH/MoXdDGMYnFcg
 sf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214108; x=1785818908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=;
 b=c8pbMagWEuXh2lVMGFhpHOB4LixcbtGjlGHjOnJo8KlJFmPQGTPh+FJnOm1P5ozmhJ
 B72spWAPfsd3DseWOYvCMPcBzdaM+dYJElZaXKGprmzSopLwt0SC1c5RqZybebDX9p44
 iBDIT1tgE/srqStk2GDHrSjsxz+n28HJmpgS70WFJNwomqv1cQryOKPxKc1Sn9nvg3eZ
 ZPTqFMLBF3QXyrWO1OZvLgAba8onaFuzXbrqSn068tRxCfqckOZvpOwSv387uIZ2NM+y
 Yaf8pGb+yaVz5kyGfb7UfZfHg80IKhW71Aloal/WVpgjyZBzPBC1VnHcwlvYK9olLEZR
 9v6A==
X-Gm-Message-State: AOJu0Yyterxp0JgDqIuXQnaScmQEgJTTOoxagxGcKYPREcrGbLbLNXgp
 vfz7GwV1pmMGv24wAUDnLXESOSgv2HEG1RrpYdDx15xqrX0UuF+Ai33yh1xudk8a5n/uGljj1iZ
 RT5TePddrCLl1vOQHdMk4V2UDOKPilZ1OvX8FQXmjAR5wn+2/LfOCYP7Y2BkFC0jFqQ==
X-Gm-Gg: AR+sD13JsFAc9moKicdQmsx0C1V0xcC/6ZlZJSddaCFDsy9sOCA9r636KNpXXCfDTU2
 BxYyOyL91nDC7bmF7PcYGTPXE59ESPyP4kRxlU63YCaQu7CKbxQ3V3QJFM9WrSRPSM4KDzfWFt8
 Z8B6pMScRNW8sIjVi1HlUEkVy/qFIdlzOu8ZLQYBNsLhJYfI61NOSojYmthAzeheIte9USSG9jl
 dhLu81v/3VoiR4E9ekJmZmeWOyEqJF93i9+kQJQrQlxs0STSj+reEz0MIbkvo1Vjspn2O9WTT0m
 RJVcsys0QsZQAE4htB1ao+QhQb4I67ZeTq9sUkv4bJWjxkPQ6DcUPHag/ew3lNO0o74BhTKozkP
 l0sWMU2WRoLvlXIL2257OqxL9C1bu6ykaCbNBwjAC/xmIiI+ZYzj25M0Gen4qVGrAlhrNvUg=
X-Received: by 2002:a05:6a21:3993:b0:3c4:3672:ba6 with SMTP id
 adf61e73a8af0-3c8b70cfcdfmr1122840637.22.1785214108392; 
 Mon, 27 Jul 2026 21:48:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:3993:b0:3c4:3672:ba6 with SMTP id
 adf61e73a8af0-3c8b70cfcdfmr1122818637.22.1785214107887; 
 Mon, 27 Jul 2026 21:48:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 071/103] plugins/api.c: identify or1k pc register and mark
 it as read only
Date: Mon, 27 Jul 2026 21:42:15 -0700
Message-ID: <20260728044248.137626-72-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yClP7uWV2qZsiclbcM4yRDv9vqZDsQhA
X-Proofpoint-GUID: yClP7uWV2qZsiclbcM4yRDv9vqZDsQhA
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68349d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=qpq-EKoDnDwZV1OHMCMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXy44HQPKHE7ar
 BamyrMjtVMFMM795tSONjbRy6A+j/86geFkpb1Sqihpob26TruKzcwvMJ01Ei+ssUtJx7gD3r7o
 +MbEYPBulB+3NZcyjWySnrsaQx8QfEvMyzgtgpO2vf5o6aVR483nBus+WgWnCYYgM07yRzgfiWQ
 BuUgLbf2S6Ek0tfnqI6fsPvYd3zU89pgyNE0LWaJIqXc9XowPNWZDAuKPfCjK6NwO6i6XgsazDJ
 TjQbTZvTkk1WDD7tv9RBWPOFXnBPLtIG69Kxczob4i9RLCK8CHZ4NeYqgydupQgcaBkyiROJrKE
 Y/8ObXZ1QIQ9eUeRHmCjJdXh9T4OavwsgQ7qRVwiQi07TkcdwzplU1VdgWuncLnPbDDthD3oa08
 mZGXrlgck35bnOG3hXj5gN5FrLUjyAhkzXWlPrt6c9D60x1/N0mJeR3cHPzNg1ue+CQVzg+NVGC
 5Jjf00gYSyR7Ydnd0sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX6nPUto/rW/qq
 ztTBG8eHxCRNgDt6TDjh11nkmX7dj9j1mRjM4mC7zf+sx3MLa9OgjeIbpyCPsaYKzEkUVwNhSN+
 1kWL8VP4qoqYMWIoBmk/dATxy50TvfE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

plugin registers.c checks if at least one register is read-only, which
was missing for target or1k.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 plugins/api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/api.c b/plugins/api.c
index eb982f9aad7..3520c96f411 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -425,6 +425,7 @@ static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
 static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
 static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
 static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
+static const char ppc_str[] = "ppc"; /* or1k-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -449,6 +450,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, pswa_str) == 0
             || g_strcmp0(desc.name, iaoq_str) == 0
             || g_strcmp0(desc.name, rpc_str) == 0
+            || g_strcmp0(desc.name, ppc_str) == 0
            ) {
             desc.is_readonly = true;
             plugin_ro_bit = 1;
-- 
2.47.3


