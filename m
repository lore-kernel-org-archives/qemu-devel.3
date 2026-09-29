Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C4BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKQ-0000YH-Pw; Tue, 29 Sep 2026 17:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKM-0000Xj-Bk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKK-0003ss-Q2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TIqCGR1649751
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4OWmlmYIAlKmerOV/Q0L4RYIzTXKv8x+JtCQJE6Qaf4=; b=KroEMLPsQ50Ap0/k
 bjmNk3avCCO9gPRZ3wXVsoolVnie6hO5FLKwCz/T0L1S5vx9zq5Bz0j9IEK6P3DP
 kcmmldeimJOxoTkdnWuNwn7rikdLbFBLcdPaBigu3DeSIxqewzr+HouM1yC19lGD
 G/50FZKjZY36t+HeFIecgciQcq6dtJlNJb5WKeO9lBIqkxLDvzFiSxVqehCD5UQk
 GhdjhG9HToPymBEs4IseMY/EFVJ8I+TOoUwrq80c4qVCP+7W8GKiUey7XBcE3okQ
 AtBj8UM1MgVC795ZmTfQkuZEn919GGKT2+Mh0KpeKxuFJNg1WJn5bzsIH087q9L0
 +o/zsg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et29wey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34344599f01so3499302eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717127; x=1791321927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4OWmlmYIAlKmerOV/Q0L4RYIzTXKv8x+JtCQJE6Qaf4=;
 b=aUFDbEnEmW/YOspSFLSOGGQo7Z7D54iaYksAw1dPVrpa7HWF6dE5zUL8vRbXKsRoh1
 KaP4yw7kmgJEQD4CXZpaaRK4c0ngRQNjQuddQufwgKUh+yP9Y9qJAc/h3kzMWRBNc+IB
 4HI1kkjIBz/SrdUL22gJUPOkB/3F0Sz6yi+fR+P1zL8S2spmb+Q0wlNolxrn1bn/kubP
 m/xtp4kthNI3BdKgbkheBGkQpkr0mvHaoxiVz34yAtsCGXKR6iC7H45BAk2oICGfzht5
 muebpIGz73Pv9usaWIkGZZcxEFwlx8JPrj3C6cujOfH2fCGUOPzXVOoDvOvnKsFaSow5
 tmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717127; x=1791321927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4OWmlmYIAlKmerOV/Q0L4RYIzTXKv8x+JtCQJE6Qaf4=;
 b=KDoushvHzzdQQPK6Ziq6Y/JOA9m08Nb5Ew5eI/p93wZoiDR8v5hSRvrN2luyiXUB+x
 YZ6IrzMWDoQo9Ef32RUyORXrRLrymdEOSB1cOILwm59I7koHJqxZgp5pgEDlitZuu+dd
 IAivcrS6S10hZyS0IjCy4svToSnrHdESojvZnkHSqydB9LV0eAEJGU63gSsvYDti5Gdm
 Dw+iUu0KHfce47AxcOf+5n6d0f4DW5GRaFylBPVLXRTi7bfUdP5Ph8OozoYjwdT8c/4P
 v4wiZQbkP4KTOFzBVb9yjOcKLd2kO2++Xvjf1RtRnK+jrMAKBOzjNeiTvqAEh9MeFMVu
 N0Zg==
X-Gm-Message-State: AFq9FYK7WMyti7ljTq8TRYS9geqUBpRH2MqQYKs8n6Sl+Yv8nG1vD5dq
 NCauqamq5X6w7RP6RU5HIr3DuzbsFl8BTwLmpmuXcwFdhVcdWVaHz0nPThnu4dHpjwHuV9vPru1
 f4CUbVnJAhE8WhiLVmpGWwqZ1UiO27OB6LdvpTfUa4j67YFZz5r2Xzzf49SwAZwYxjQ==
X-Gm-Gg: AYBFou3Lv+WjYRwshwE+phRpkd+AmB3JFLdnSws4EvmEmAZ9VHqs/cBmy+yjO59EH/T
 7HMwqin5BlMCdXt09RiOeuRrKPEqW82F0YKxZdNOjFYEbdpFlSp9EMpIrluVmFeIwZXjDEmr0Pi
 3NuBweamTR4LoT4xkKykpOSqLYiMnWl2oafEwPI/2DBR9D+ROPrVyiQDnFfBfr5furaK3LCUgk+
 lCyo39IDNVK/ueIbkc1s+5XLI8ihCvSiqCYjmppi4czFVxCLakHRLOvK2eXTBVbO7rzqbt1iUL8
 MWl7rd9he1i1wYS9ivceUnipWr67xSsCmSv8JkqwGEJyu/SE9rUFEmEAbXsPn5zHzKGOr4p97VX
 q86Q8jw9WzI+Qe/uwh4V/72v/iPxenvAyQgTU4q6ruC5yjSl5tUc0vOfp3TaV
X-Received: by 2002:a05:7300:8186:b0:33e:4ad0:4bc0 with SMTP id
 5a478bee46e88-34c6370d9c2mr966045eec.9.1790717126685; 
 Tue, 29 Sep 2026 14:25:26 -0700 (PDT)
X-Received: by 2002:a05:7300:8186:b0:33e:4ad0:4bc0 with SMTP id
 5a478bee46e88-34c6370d9c2mr966017eec.9.1790717126096; 
 Tue, 29 Sep 2026 14:25:26 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 17/24] target/mips: Sign-extend the SRAV operand
Date: Tue, 29 Sep 2026 21:24:32 +0000
Message-ID: <20260929212439.110454-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: T1OwpL3lRH2Nfz1SIhV7tAwr73B_ABOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX+qkSOr5IoCms
 lJ4lOKnDLFWn4BW0msmbXU9jW6vXpv0N7LyK3fLa1GpYqRKHAr2i9IH75nQu5VhqTwWijZd5c/M
 exDOWpcHGsS9GVbghGT4fno0TOG0dAsBQc41QuTjyN+EuKg8ZBQoXvQtiOKnrsX1IxtDt1C8BPj
 oJGkrkyjmSTvzE8Y4dBoe1pgvnTxbFWZJgFZu7Zt88aKAdqdkEs6VJ/INgyHiFmqf+TGpKV7POh
 1U5lAr8OAYYH7741sjPOJ1gcslfeS+Kt+3WlVY7JLxd0+9k3aKSofWY8HGZaMt0ZLVfTU82gyh6
 DnXB03b5Bx5iOLqz77yPURIahVUhDU7SsXJJ1O6ffJ2RX2vwcglLtjpgBKH+LZshoavYwV2aFjQ
 0KGEyZ0ICa3j//vVLsSYhWjPdOUX1RjGHjWW3nIa4QTFePKf2tQ6iWdNoT8DBYsI7053EWikr86
 2IVYjp3g1QNUN6RZidQ==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abc2cc7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=W5-BjZYuLqWngTJxaqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: T1OwpL3lRH2Nfz1SIhV7tAwr73B_ABOL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX/G3m8W6O+WlJ
 8G0ctpPHWkKpaSpayAMSaEzvDuLgtzC3D2gHn6f3yMW6rhnMrMcjglOE+WQXlFws0z4qewBYNlO
 GkHZZEaBNAvYTcTgZQJhgRG2TviXoYo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

SRAV operates on the low-order 32-bit word of its source and
sign-extends the shifted result. Sign-extend the source before
shifting to make results deterministic when the source register
is not already sign-extended.

Fixes: 48d38ca52b6 ("Switch most MIPS logical and arithmetic  instructions to TCG")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e3467d15251..936f8c4eddc 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2853,6 +2853,7 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
         tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
         break;
     case OPC_SRAV:
+        tcg_gen_ext32s_tl(t1, t1);
         tcg_gen_andi_tl(t0, t0, 0x1f);
         tcg_gen_sar_tl(cpu_gpr[rd], t1, t0);
         break;
-- 
2.43.0


