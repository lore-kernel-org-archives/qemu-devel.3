Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C73FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegXm-00034g-1l; Tue, 30 Jun 2026 18:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegX5-0002ia-I4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegX0-0003rt-U9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDaRv2881438
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DJMmr3+XwLt3KJsVQCfjGWMC+Pwyxb4MVSeXPY0Lok0=; b=Ji7C1Cg9PvkhjV+d
 /HJaQ2oV+8K9Yae9jl4D7kKbbdH8tN9Pi9s1/aJ10F0GbV88zvoXkrp24/tGNa7/
 nPZCQWfnrtzJiRC34sSLvBUv1GnmdXzudBo8kHPrwBRrTtA17po4vXwYCJdRycJ9
 ZxFogcblDHuB5MNq6HhoaoVVY6Pt4kIumPDlIy+LHOfLy6aoE/kBmnzRD5mkpp+S
 o8xkGkQDlGmIAVIQEbDS/Y0GMEbA9D2v4aHjl4FQTzVsQRByUFuPrRktHYrRg3ot
 47Rs6Mxg6zMmBAKX1ppP06dmFSIAazUrn2DLkW+OzQXseqWu8d6nfZjkvifby+SY
 0J26yA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqgx46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:13 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4893fc86bebso80971b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856933; x=1783461733; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DJMmr3+XwLt3KJsVQCfjGWMC+Pwyxb4MVSeXPY0Lok0=;
 b=aAo3dtshOrjTdCCWaFQ/VLXVnaEZTVjF36XUHBHPNUvU1gbcmavm3mqV1/qUi6lb8+
 DvBBHjVBPhQSgH2noLcifms3+YO82PyyoV5JK0fe7/2z0HwPGku0eW15d6Fa8QsauPh6
 MOELETzACZUTMMWUS8Loex2o+Vy9IWX1fET7EooQEdoVrWeVKc4QzkqMgBM4L6JhbG4t
 y4mTvV59YFVrcZprR5wKyCEIe9s7qz44DZ8uuf4pKZBxDxCZxZVe1ara0i3MDwmYwBsh
 1KDxleWVGtL0xUWAmq9XJbpy9dVOnPlWenCt58Zr4oRhpASOX1c0c7X+j2YKpnNqO7Ib
 lB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856933; x=1783461733;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DJMmr3+XwLt3KJsVQCfjGWMC+Pwyxb4MVSeXPY0Lok0=;
 b=TooMoipjrFcC8dXnTFtiH3U3Wwb61XVHQuRv1YQQHvOISfscm49P5cZUDYi1YcGiR4
 2uCawgekDxx8j5WNZ+NRQBARvPcZH5s9Ibzqx4Q1ItWUYnrodvVMlkyWqqEdmuzylPmM
 uNwcKyWA5Cc0renhxR9Qz7Uny0T5l3W4bQQzcwENMmrN05pgpAw0YS0abUI/3vvj8sWL
 yUYjcIOLinIkZZFkoIov/TeXtn1vN0MIJCscchGigrExCNLRb8YZ0y8XygZVeb3/WZNs
 4Y1oOtxS4hOAPLLWkvbt+bvFlSgWIKtVLEGQyNnfdDXmqktR3CetGLUcZ4YnzOA68wdq
 PgBA==
X-Gm-Message-State: AOJu0YxysfNLnn78i4qgdnbU5ISNX3DFW+i8StC7RvhTbcJUQLx2B7J2
 Lt/iJ+wmj+qAVW5Wkh/bl8cWWYXa8wdQ8VQTdt/mlbGIOyESFHSGAI/XEQU0wPBkpf92bq84oK0
 oY5vAtwHtZcsag9/yAl/O6WU2aO3UqeEEfdtVVtFQf+V+zA/h0cUfCXcZb5E5o6iU2w==
X-Gm-Gg: AfdE7cnmtYZrQwB7C0mTvT7JGNxYbmSahHlvGULHnjQPHmsWZVuFRZ4wHiOEXLBQgDX
 oI6ftByt877sg6Kgz4v/ZcRqLfvi0rC721Wkscam8Yu21tN6XVUcRYu3oBeRPvk1qCWbmX1aFV/
 snYiUI9LMcK1NonAHEcPN5/wgArfevyz4au2P5ILdYjKE3UI29uBJH2dIMERTGvO3kYvlWRk0Oi
 fPDY/KQzKkwFc+bYHjVl1aVm/AFqFMTcNDG/ywcK+4ZzLa6DpCrnLGlpM1bKngmtsV8vOLq2NuV
 bMSMpJJkfoLRrUnuMYH8mrQWK1Edbse2Jc7vvSocb4sgPgOA43YnLNvK8e98LTxSvGu/S7gJ8zM
 2y4KmMhKLX2Ida6ihaIWtqaEIL4XhmR0Wi9Ge8YEWEjuFJSfJr6t4dOhMnN5lRioIyG2l
X-Received: by 2002:a05:6808:5186:b0:485:41fc:71e1 with SMTP id
 5614622812f47-495eaf32892mr4357633b6e.21.1782856932690; 
 Tue, 30 Jun 2026 15:02:12 -0700 (PDT)
X-Received: by 2002:a05:6808:5186:b0:485:41fc:71e1 with SMTP id
 5614622812f47-495eaf32892mr4357591b6e.21.1782856932204; 
 Tue, 30 Jun 2026 15:02:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf1asm12156232f8f.18.2026.06.30.15.02.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 09/33] accel/kvm: Simplify kvm_init() w.r.t.
 TARGET_KVM_HAVE_GUEST_DEBUG
Date: Wed,  1 Jul 2026 00:00:36 +0200
Message-ID: <20260630220100.1289-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sxt2erI9WPdB0xYHQROUcB0MSy-D0zer
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX/pYT9f35M2aJ
 wD5WlCKhkvSpjvD+IpyTn4CC5m7/XmpeeA3YVfe2biHV0Il/HEtv62b3WfdbDD0TcujGhTKLSx/
 pJMfzHzgZS/pYp9rW60tdrpO84cLsMFWwgKKJ+uY9Cqb6WUIAtolgMEkJG0Z+Xa0HPBRIOS0pv4
 FVG/6FW2zFLjyl6oGo/NwsJ1zff5mnb/YxH+8wY4HiO2XNNmzyOOIa4ea4ac/TY/Nhr0uztEWGh
 gWaYoUQejMjrNaxW0eZ22uYze/UrbqlfDXOMgjuWskkk6zy0cB764tVqfSM/NtGHqTHYC2Vtx4X
 GYOF5kLJ9Fuy+R8AyivYBCB1fTu0ERLjYqabkmxRnCqn3xvTr5a1IEJYxq9yqlY6R1JMDm9uP3B
 WOfSvupPw7ChYiTQsxfex4sa+pu5ybztw3gnzsNw5kxsCmTi3v2pluT7UP2yv18YZWvz97OmU6Y
 VpynkHSU5OsxJxCB4dA==
X-Proofpoint-GUID: sxt2erI9WPdB0xYHQROUcB0MSy-D0zer
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a443ce5 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Fjv_wwvgkwid0SI5BdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX9+o83KGnEJjq
 +Ovw7RLYXh4puXSyxcjXDPJqwxa+EDq+x7Mbn42sjfJbBtvL3NJBy+BmrTqpZ4fATadHWD+SJLU
 8bcLJzileka/ItlezJEBkGxmsjqzRyY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300214
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

Simplify #ifdef'ry using TARGET_KVM_HAVE_GUEST_DEBUG in kvm_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d55cb45cf7..6cd5f95d06e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3037,24 +3037,23 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
+    kvm_sstep_flags = 0;
+
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-#endif
 
-    kvm_sstep_flags = 0;
     if (kvm_has_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
-#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
             kvm_sstep_flags |= SSTEP_NOIRQ;
         }
-#endif
     }
+#endif
 
     kvm_state = s;
 
-- 
2.53.0


