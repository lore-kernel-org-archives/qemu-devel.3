Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888C6C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbo-0003Xu-I0; Tue, 30 Jun 2026 18:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZP-0005VP-KI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZK-0004Xp-Eb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDp4K2947914
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 flWQ/MPYi5Yw+SwaWjb+CkmEKUB+4nfqA9d8BHOhI8Q=; b=PyR4QLU5zpnp8i/R
 ZfW7xe7Uye7HNnDVMzqDldlLFwbks8P5zb+ij6Lg0pl4HuEH8z5HtQHl3XnmQR4A
 uBBJYc5CAOy7qDSR0Em7m7QgX87ZxupolQrTQbiouspcS3bblyDSvoLAsxZUDyqL
 MEb0EJpLPodRnuZ1sRaMJxablC+ZFjzelOJesWP1vNrO3fLDFaEIeNEkICz8zrCi
 EyKpdC6XLHPDdkBTN+K6EheCOIZCGavAVnCfT3I88JEWHhhV/4jjsphyZXdpgI4e
 aPmWcissGrFEo1dQDHVogULuPluPE61Tdzkp77OaAd7lvpUI6DbtGdDUoBbUNkEI
 eXmzhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4h0asjmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e61b38eddso483812785a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857067; x=1783461867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flWQ/MPYi5Yw+SwaWjb+CkmEKUB+4nfqA9d8BHOhI8Q=;
 b=WOdlhkm6owJ0YyHLvHsA+Qbfi8vgfslrldofMunLFFBM96aHdxVnISSrJAHnIKnyDs
 atZ0+002js3CbT7LOLfFJAnzLPa2Dcu5IUU0FEc5GkS3vK4t8jdoBTIscl17FUsYr1/I
 vUZWjcuycedTroqeDQrc7DqzJLbl3jWJIF/zpyFHjBqOzbEjlc3f3He04UpgMCc+hd8Y
 deHzCkGoI/kxrU81Hrhlqigs+kNTnTKDrtT3EX+SLe3CBRIldOryo258ZH4t7DS+Bsqm
 VzaPmEdHhZ1OCggoDh+QNOqX1PWlEp3FWgxcrlyuOnrsyxt41c2sCdraYQpByDKM5cg2
 E0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857067; x=1783461867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=flWQ/MPYi5Yw+SwaWjb+CkmEKUB+4nfqA9d8BHOhI8Q=;
 b=hS+2NLQuNFP25jVKCzyv0bMTulz6VB9QyUdZXV/NsJ8DW1TuSzeDjTn/QCQrEGN+Fo
 DINEzcYTyVr4ByXsn8H2zv3xQ9QET7GpqtZ/0ajSbhon8PkqAY1Tb71mRmGtckp/z+iy
 oZQ+3Ij8ynJrXrywzPlDXENuhONtSnQYGqGBNN6/0f8kl9Ot78Vcy4mTg9+W3Y6B+ZB3
 hdQO1iqlPl9YfbXpX1eiakoHzDYQQmc1YVVPijcA8nCUpUMqcd5mXr37hJXjVbQzvils
 mPgBMk60d6DH12Qa2XpUFsrdVhFkkyhbfTRESXBnET8sYj1C5nDjTAe+kqG5ZKFBLV2L
 jeBg==
X-Gm-Message-State: AOJu0Yxqc2c2SauOlVos1CHQp2WgHXWzMeFsQANU+6HGXAfr45bIa6m6
 wbJZOJXeditq/e4BsHSvT6epOCzoegOTEnniDYmXlkC3rr7r29Z77Yw6ivcmKaMU2m1iwDXnpVH
 /4TmNoTjVMkKu5qtHA6Jd9DhceKtjIJlvDMf9DBytC/8GIPsDWmkHbkc4F0xta1Uuvg==
X-Gm-Gg: AfdE7cliwjIpb99WNGHMTbtMotS5KYs/WzDhsAx4LYQyt/4X25yOeiKLFViAphL8DbQ
 mpiDNsxh7IY4DTYPW6ujdYAOan7nCwfVHR8c3OId5JMN847jn3OfuoeA5t1eJo9BS/LwaqvR1H6
 MSPsBCLWApnlYRhWpUdGGg2FhFeFVV8E32npBMbvT898f/TA78Qa2w3hQyra9FFEp4UkoKbwQni
 wPTTmb/K4i0FM49//AKz5QD7buwE69Njuvn+I1eGfbFXapVC7GK7O+ROFj9chatkz+lkb97Asbo
 VUAKd4CMLfXErz8Rp3/4/kO6KuYk82Dfo09Gks0pTEQcXijIO2vnLyI5l+Y1+y4ymDonCe4C0oZ
 ZMCrt8PSzZZD8NG8naanjegUG3v5s4JcMcDPlTXzPSjkqC9ffxfGFtNqcri3v8+1neroB
X-Received: by 2002:a05:620a:2945:b0:92e:5b92:98bb with SMTP id
 af79cd13be357-92e6d7da61emr427342185a.14.1782857066844; 
 Tue, 30 Jun 2026 15:04:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2945:b0:92e:5b92:98bb with SMTP id
 af79cd13be357-92e6d7da61emr427333185a.14.1782857066229; 
 Tue, 30 Jun 2026 15:04:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475671d0403sm11724641f8f.29.2026.06.30.15.04.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 27/33] target/ppc: Ensure TCG is used in ppc_update_daw()
Date: Wed,  1 Jul 2026 00:00:54 +0200
Message-ID: <20260630220100.1289-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OuF/DS/t c=1 sm=1 tr=0 ts=6a443d6b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0gApPR3MPTmSQoBs11EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: iJowD1ua8MhO-eqITCsgMH9eCW6aRHG8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX/vTXuvojghJB
 bKf3CQFQVa58J2QMEyRN9SIbcAQTubX2Y9zpOz3aIDa8YH7YAjfnvDun3Sfp4EfeNSHL+ECWoPv
 dYI0DHCD7pHWpxVwYAQnz/60xkGRUx4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX1RPwNERWRoF8
 ZJkaEJ99Kj+uPvuEMB894B9tWMuE8v2OSjcyhbNFQG9w/JQ7SJQt9UOiFoTqHTwqTJXk/DI8R6D
 SI63Dqvb6cUQp9UDUV2Fz62ksqMDTR7fjacDbzliprjelUP2zpD3Aes1UcOiZXdnamYB1v1V5Vx
 oOmr2biAVzPkHl/m9f4u2EYFZ/g+5fDS4IdghUW4q0Ql6JgYtdHLcxnw92TbXjWUCZT21En1wYe
 bBWmlmKEhlcdtZY24a6Bqz3XUL3XVGMroQT8aG6IVm3N9/MTQAbR6q4WU6VnYadI3ftwqtFUu1j
 06GLIA+C8CuDpWbolJJio2Wi50+kPh6gikc6HhXqRKn0Y8RDhMZdY8UENOayiCCpeaaR/Nphbli
 HtC3MAwqL6jJldSfostk2M89xIDV5ZuWzIRFlRthY9Ns49rDG6pXgv4yXeHsc1UEIQKXkiXpiPk
 TbnDPucQu0j7bb27O1A==
X-Proofpoint-GUID: iJowD1ua8MhO-eqITCsgMH9eCW6aRHG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
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

Per commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug
facility for v2.07S"), only TCG is implemented:

    ISA v2.07S introduced the watchpoint facility based on the DAWR0
    and DAWRX0 SPRs. Implement this in TCG.
                     ^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 913920d55b8..36e1209119d 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -147,6 +147,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     vaddr len;
     BreakpointFlags flags;
 
+    assert(tcg_enabled());
+
     if (env->dawr_watchpoint[rid]) {
         cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
         env->dawr_watchpoint[rid] = NULL;
-- 
2.53.0


