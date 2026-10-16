Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AFDCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRv-00078J-IJ; Fri, 16 Oct 2026 14:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRr-00077o-Qb
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRq-0000WU-5y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE69vh2455449
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kobPT/iGlnCylfEzMbKrxF+6JJhUUdKvxS9pc8Ipuuc=; b=WyronuA/DEdNwty8
 qNoA7gYUXe8k4nV47MjkSUW4eTa2NV008+tcnX8ccC+CpqCTaknbWeH6FybbWLkX
 chfuB1MB3QeHPwTJ91CPyLJu0i3duaUZgcBAoihMOAVtWO6AozSRyzrwmxTQbPgx
 zxkvzgjgUsC+Tp5zJ6tAIwQ2uvSAiqfG7kAoOfEx2O0Eg+CEQjexv6coBa7Rfzz6
 AH2UWgjzFzULA3hsjyfZKI8vAH9Z5RuZcmXwEjbdYb45ndAIbYaO3WfB5rai99SJ
 vbDJ52YBMucek+sOye9ghK90Az4oGueaA+XRZKl8XI8VXM1DKhg7TjDGlJ6U7/Nt
 TgwElA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yta8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd634ac49baso749130a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174468; x=1792779268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kobPT/iGlnCylfEzMbKrxF+6JJhUUdKvxS9pc8Ipuuc=;
 b=S8yohYwgA5o0RBjImYLsgZXjyKrmVswHTmsl2c6VMq2ScMPeeNWW3pctFHi3ezTUTi
 ri5sRqaf+nPKDIR5xN5qvIsTmu3tyD9ANmmfl+hzsgKTWBHRdpj2ZYK28slpgefzXSTX
 gQm5Y1A8AgRnuG8YsR+VdqsO7xGzycCuildy8wRnmKE5qDeW+o8/JznD4xK7Bzw7i+HP
 dk/CabgaVRGNRZzX4ti9YSEcoC4wHD+Fe+rtOIeNsewwXeH66V6fElgUtuDPZjhIyykh
 2hdp4CZMIcc57lOo0J30ETpQMDDSlWepeRIN0DIWe1vx8ZakyYhl87dh7BFKKUcDugmy
 k6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174468; x=1792779268;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kobPT/iGlnCylfEzMbKrxF+6JJhUUdKvxS9pc8Ipuuc=;
 b=FXMG18Xt54/0leCO3R4pazxqXwRA8ZLSJwZBwppFnc3giGn/aOrEuHeoF60qDygtmH
 XeKGXKf0BjKPEpVNN+Xl7kIvBD/e1A0V6Pnt0Y6ijqXsORlmrNpleuLWl6n5LN2BU8aM
 yqUzqjKsnX2MXN5enY9LTt3qIYj67lO867iIk9hQKLl717cwt/0hgZXQCi0zSKElMIKa
 oR3UY9lihjTBhqjmgv926TLiiiKEaUtJG7De4UYNQCrKT939mjTvjKFyKdlZg0PYqVvT
 eeLWKWdm0ao3K1Ua0cHDGgc3w6SQwZsmeFXifP7a5/4DShy1DUShHSXJgjNwy2GYm8tu
 aIPg==
X-Gm-Message-State: AFq9FYI72Q2iwAOq2+grUa2j2eIDAdknXTSyhmz09jkvNVnlfmsfCY7R
 qI/yK2Gkj4G7iCyvDo2csYBL/VyCZ+Rbd8uKWL2fdpiIKQ+w4PcIJx66m29K8+oTnQmKBOcTNNE
 e+xQV6P0N1Zq0eQJI2Oglf7KXmI+vDBVvn08a2jkfp0fD3A/0XPCML+86xs1XfKeVHw==
X-Gm-Gg: AYBFou3tRjo2S2ZSSCtjCcJA1wTzhRgIQIaCxHYsVGem2aoImLwsOcf2usIKK7O+2fj
 FaINTAm28LdwLLCoM2DsKnmzqRb52s4qTHs1dGPgGb4TcHOOCOraIYi61B/WGTgN292ro9jeI1z
 /Ba2hjBu0PJa22agwzvS24QOB5Q4wQdGNpCGk0aa0TNcUh/p9NsJcRyHrhL6WO//mg8kqzQ1tos
 rBzf5hmaBZZGzAHwJ+OybMuFaWV7fMVAr68BVO5zkRMsMGN65T4rdnsz64uBXwSqtd7k9ycXizN
 kf4ePlBCdLc3/igZ6iWy1ieY/RhdDXvIJkGD1AwOIUwSUH3/Dpuls6M/IUuOksvhZK2UXWSCNOT
 v3I6GJ907YhFo3m8lcf0A4N3hiDdyBMNwoeF8cYcdR2wcOCso5xfhPCFgHVZEv1Q=
X-Received: by 2002:a17:90b:28c7:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3acef134e1amr378703a91.16.1792174468130; 
 Fri, 16 Oct 2026 11:14:28 -0700 (PDT)
X-Received: by 2002:a17:90b:28c7:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3acef134e1amr378689a91.16.1792174467527; 
 Fri, 16 Oct 2026 11:14:27 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 08/23] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Date: Fri, 16 Oct 2026 11:13:55 -0700
Message-ID: <20261016181410.191743-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bRx_TghjfnHwZKlVQraWA5dvIiI8ShXf
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad26985 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=eFVOZ6oOXU5wpZiMpRIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX+pEy4jf3byO7
 hDXG3FAyFZW8BbFg9rQnQjLrWUhiNiVEyKBZEjooGLc2WQcw54h5CmsZnswkeaZpDv+VwW1gAOk
 +qViUkREyiEcVIbsvJmpqt/upK1f62M=
X-Proofpoint-GUID: bRx_TghjfnHwZKlVQraWA5dvIiI8ShXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXwnHqGlzwmDTr
 RWgxqyOowBzU19D8t59dObFaKFf61QQeAvSOPxkdcbBK7lkLgGswpfvz6Ri9MtSaz8JSvxpGSjD
 m7BWCy8kHz9V5MdtRb28V+ngq6nqdPDAIJ32Cu2/BOF4+HznV8nmnFJm9q5BkR4d6Gk5/QWUGGW
 PYpz8itR4V0nJz0sIQRA+FC1Pro0+yYc7OoCoBlaBN1pjgGw9TIOqjE01TZmWNYgCpKv/zWQxQl
 JZKTcuvUrC0QUuHhtvimIqsEyuH5jy7i9tAo5uZ/B3epa5PLo/eU08JfOGjaeh2xWo+gp5oWloY
 lb1+LefOMN8W4JkI514JCRRzr2RJsgAwtbD3H+AZ3VuBoQdTBBX/slvplckJK2jPFqXX0VVEiGB
 NRtqLOEN1sS3XL+z0KghB5mHJl/ZQ0vrzP4SWdkrE4qZDHoB/jfHkZSSL5AvdwMRr6k8AsBxEON
 s/UFFIkqvgkuSSYZ6WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..fbffc9b3005 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3048,10 +3048,10 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
-static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
+static inline bool ppc_interrupts_little_endian(const PowerPCCPU *cpu, bool hv)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const CPUPPCState *env = &cpu->env;
     bool ile;
 
     if (hv && env->has_hv_mode) {
-- 
2.47.3


