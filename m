Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D808C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfI-00078J-8n; Mon, 06 Jul 2026 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeu-0006mn-TN
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjep-0006O5-RI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxGF0369006
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ywcft/LQOg/AUbGKSvPPmBtK9CP8mXb/1dMcOlTHzQI=; b=PMS9Sxn/zKGio/u6
 rRg1OQF7DNnmpYbO3s9BfcSClmqJX5RqMwVlKEh3kfffrV2RfsSZRHvBsbShkxub
 CQVOwVDYX3clnw8ymwOR3nM2uOuc4pOxLyU6AfWI3G26fyVw4KSUKmsprvD49QZX
 9ojSrDMtW0kx8R64Fw9S/VAxFmZU/8VrdhZpIWkQB45EbX4TylfHiid5uFwQAL7G
 eM2A61Eh61Ug8XVv46rII9FS3N1aag54IzQPwXvEKxq8HC2xAXZ0Cj51RCdTGdn0
 wZQl/f+JAUN0Cynmhiv+V9WxX5aM738hu01Fu73sQEaJnWQ7DZFC1h3DgsSPdyWg
 moqhow==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99c0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:46 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-96939fcd33dso418955241.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345606; x=1783950406; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ywcft/LQOg/AUbGKSvPPmBtK9CP8mXb/1dMcOlTHzQI=;
 b=KQXcy+CqnzLh0JE1BjzopoDf8xfxBFcmFb23KXXneb21s5pMlGCBZQkErRjA7Lom2Z
 3ujwGItnNCWnI50piAcoAm37VVO3Wh7C6Bc7eFtDtCcryum2EH5F4gDYd6x0/NCf6cph
 bRDTMoBi0iRBGVSiSWVMc0DMiZUbrxEVi/HPvcvKlV/4pr0WcnU6Wnu7nEdnJT5Ja72e
 f/YrKljYZIHYusarPyg4jh3W84pqYvpCdWTQjkBWO/oN8c8UWutt8yw2vGnPHb+7kuOo
 hs9KGLz1E9uv4LVNbr/E4eKV3SF30p3i2k8AY56Dv90AjIPRm/nk8IHAjRxpVv8MqJ27
 jB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345606; x=1783950406;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ywcft/LQOg/AUbGKSvPPmBtK9CP8mXb/1dMcOlTHzQI=;
 b=iSexsO5aWF1DNjzfntKDUWHMHoN6kPW7whyvFu7CJ+eKwwavvBcalicVzlGpe3u1sq
 u1fo9r380pKzJ93OG3OYJvwr/2O2t3yOsNWXn0/7vXluyl2sgr/AeMsXMow4h3m0KdgL
 ROA9Y/3RZfOmgjkP8rciU1KNn8qwu5AcsOyr/ox6znAh2u6n7py7Q7ou2RrY7Nk73iOk
 k7hxlfUWFnVsM/LGvpa/tavcczr7iRn3MsoaHtDcQb4TMF3cp9DXtbP1Yboj+WyrbZPu
 qeoy1dAgdtHkcgwtsgiJdv0v+33XE3gIUjMMwtcp/BD1pY38OJT/++NR3DC5nCmeKNZ7
 WCpA==
X-Gm-Message-State: AOJu0Yz/JQJrFaoFwm1Y12I0fCqvTCdpcet12LwApT/h2k/ZJYbSIWBr
 xDYhA7/FM907ty2EWVj5DjqeDPiGmUgNw0/BCBJidAdKsZCqWGTCPi3PpK0/n66Ac1tTE8M1rri
 CYtBfzoqxbh+Uz1x+t5oZGMwxTeFtfLSfEqAn/PbtsGP3b13IKxjP60qxNjaFz5Bh1Q==
X-Gm-Gg: AfdE7cnQOmkQbfifGTHzdPmmDUIwyD03blTnJXhU9NBC7yN/BsogS7LRt+cHpVi9Dt7
 uMnAkUstemOlZsGWNoI2DWPzyGzoEWLUtlXAxIgGsiUltuTNXhXTQxw1dPawTmoNnWJdAJlVyHT
 hBsBBHeoZ+5yf6fw4SfMZpeRzgKarfqq2OmBGv/ZLi77ZPN+nr34enGZLBaVcPV/AxNqmsF9k5h
 Mj+8bvRWXBkch9gIYCiVrfQsoA2Up3hFhTykH6uGPV8sCHokw5E3wr+SjysjPkapUlbksJ1rs20
 uw5HJTvM7tLIz9ZqeFS0NlvZ4af9OpJJtQ2aiL0zx6d2dlWK6Mnsfby54nQEIfWf0CfnRG/r66F
 EmxUaKpUWDrQEaCW2KWw4zXVCDsjLlLGbnhhaQP8EquBzW2/jrsxdgcWtFg==
X-Received: by 2002:a05:6122:e183:b0:5bd:ac45:5b04 with SMTP id
 71dfb90a1353d-5be9085f27fmr300091e0c.9.1783345605737; 
 Mon, 06 Jul 2026 06:46:45 -0700 (PDT)
X-Received: by 2002:a05:6122:e183:b0:5bd:ac45:5b04 with SMTP id
 71dfb90a1353d-5be9085f27fmr300072e0c.9.1783345605270; 
 Mon, 06 Jul 2026 06:46:45 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e3e2702sm25093965f8f.9.2026.07.06.06.46.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:46:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] gdbstub: Only return E22 when reverse GDB is not
 supported
Date: Mon,  6 Jul 2026 15:45:03 +0200
Message-ID: <20260706134527.84808-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DJfPT6Rk893u77nfgnOlbHx-TPeHSwfR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX5ZmNY/2OAi7l
 hamZM2k/i14Th2BqiQYmyK06oV0Gf33d3xT4I6DelWXTNeD5Pjbw2NliottHnBL2UYPG+CxW213
 Q3ZNuBBjkfSD4VEUfY1kfR1yT4WhLlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXxD1MqiKswrz2
 naozMQqRqr9bcg2nLSEoCQ2KfJDjSZyTHXv+YPanjphjTuT76i8n9pYXHAL+SnsX+p2D2ukOAyO
 /vuFWXVWmEqZmLtgp3dCwsCDQ4BH36xn6ui3CEMBOvipjZYM/qc4kYGXPedWZBzvvE4sz3yl+ny
 DFYG1oJIqIclP7SN9YwHYPLi3dmr4GRKmjihOreqs6sZLp55EfFK4KqijA8DhzTGPYy7vkAm/2L
 zOnWJcaCpCch6lNNK2IKrNIJ7EMrzOSnbv4so0zOs/dcyeD6/K4jYKYXJIpJKKV/GdLM0X7neP1
 fcE7xtKsBIN8NLXARrVJKL0qaLK2Xj21WYFVZaQhr1laW0CNslCdh14AwlI/4aPZRT7gVCzEiNp
 ZtVOKIgXBUX7/tWmkgxsytNMrYS+BPpIM9kD7pyhhO1SWZq2j0CioA1wF5BBg7UIwN83TDij8Uv
 5ozAuX5ObVsBtUNVc4g==
X-Proofpoint-GUID: DJfPT6Rk893u77nfgnOlbHx-TPeHSwfR
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bb1c6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=0n23ylXGgdPVI_k3iFEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
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

No need to keep processing the arguments when we know
reverse debugging is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260705215729.62196-8-philmd@oss.qualcomm.com>
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


