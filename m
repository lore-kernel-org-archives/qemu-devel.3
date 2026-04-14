Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C8F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdYO-0006O6-8r; Tue, 14 Apr 2026 09:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wCdYL-0006Ni-BI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:11:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wCdYI-0005aw-Uj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:11:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EB5Uhu2387051
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 13:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ViVNBJLDNe7dTza5ub1nJhFCv8l4ZF0Zi6x
 rrxyXaFM=; b=EAnMcFr+ey6Al7x1i1Da/cv/6a+Zqj1VnUfJc274B8YpFRUz5Az
 BVi5RpwdD1EtPWQAO82o47qhQaAroyHczjp5SQAChqXLn6aHHv5vsa+dmY25GlPY
 LsGxOPtTYQukMdSHTXvYnrodtCX1TYdZWrr01vYsuYn05H/1NKnXvwpI+5gyrn37
 DP6NrlRZ9JGQkcqp+8lCIzhtTalrhSyave0+PoiRmLceqdvYMIdTVlsTwOJes/fw
 YpR5BvghF88Jgyapeea7mNOJBN6uIkTAcnMYMLlpqoWM/WzvY+VdLfHCUUnJkw+Q
 PlLKsB08gEmgN2yG1MNb2fLlvZhGDy2dlzA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86w2tep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 13:11:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2d93379001eso7476328eec.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776172296; x=1776777096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ViVNBJLDNe7dTza5ub1nJhFCv8l4ZF0Zi6xrrxyXaFM=;
 b=NCue08UhG+WvAVjlnnFTKpPvomAmXBwp74gZnnCQ9460b+mByQyVCOZ+t0Y2ZbMte4
 +TiD8HzZoMWMLTs+OBAzVBGHeUv3SzrrPlYPPY8O8Fecy5NXiyoS1VT4k5miBzuq6L+m
 ovz9ZopsEoff1qQ/Edjeyphr0c3obWK5Omsm1duZJ424uqCHwqIVML+NlqLqMfD4k8W6
 RVh9YPPaul9343CSdihU0ztQ0ajPCQYJkebEEieiYWA3ab89VDcNOY2lFPIej/uS12Og
 NiRJ3NPXM/b0k7IBFCfrVVw0Ah+4b3bPm+YHEBPKjb7iWncnr5UCkTfKKa8/mNYWgFwC
 K61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172296; x=1776777096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViVNBJLDNe7dTza5ub1nJhFCv8l4ZF0Zi6xrrxyXaFM=;
 b=pxV6byN9Zym1RKAwlHIgJhDu6NfPoJw0SgeYzS2/fkmm//iAwv/4JcqeeTmzVoz+HA
 0jLqd9lzZvQU0yrPXGqGBgIyjXgevFXnEe1a6RM1OjMdK0P/oMpjUviFj19IhsGOixsG
 sv7S+SLP7YMRmJGgt+fXBck5dC3fz5fXevIqqwAtNlMOFdfeIhueHvZCgRcBnGi0krUF
 x2PG4OEjSzcKZOwRwBFPzW4V05YL7zXYqQoNOKh0n9xiks3GPnHwkI8QKe+JXNamoJcd
 shnbhJ/Y/3p5O2Xgrob8eSXV19eGYTH863DDN54IHBRL0RFRhlC9ZcNzGBU6Df5tYXEX
 jHOQ==
X-Gm-Message-State: AOJu0YyWAJcGKbh5BcIO0OabpxFAR2LmoQ/OvUf1OjNL3sTrkMQYxupk
 rfQsxtcszpxqBnyi+2VIMW070cUzLMlRFd/fX+OXpNKachHVr3eHpTOvu33GUbLoCFod5z6x93G
 iNgy4QO5+7/c1CRgMw3XVDX5+gi3PB58Iy/Av5SlD8TQKJ0QNet7W0887jfph0ebyC/Yv
X-Gm-Gg: AeBDievQiRakKMa1EOlVGqjyUTCsHmToLD95MMSplm2xUYntJma0Kq3HWvW3TLOASna
 6NAH0rmV5OFyvyXWG3/pytQ74d4ubtPC1GVVLolCAoqFhhL5ug+2+9fH0qFJ/GS+uhMvZc450Fg
 TeKhdN6umRJsHpjE1XNngD/+xEcLH7cYk2LilXOgtdVPkap9ob8n53uEXrIViMz0B6BfEmXEOH2
 xy5hreFa2bMZKYgAk13xzsk1sWBjSTw9hb6MCG65C+H/YmgAKwY/H8y3PTI6502bPNyrFqKYx6m
 aiNo6sAKAZm2w2pRKAFyFCYCnk5FKNOK8tmgAbiZVyUH6gLRRjNhtdA0EVSN8MXYMUkwjDMsqWM
 CE3wKbtxeYI1XyYfxPfWmUyp9gpRvRl3RjvBfeSYHphj0bktsrKMlKhUY/6r+9l35cXhZ9eNAGU
 HHTc6Y/cvR2c0WHjVHs/8=
X-Received: by 2002:a05:7301:470e:b0:2d8:1efe:51dc with SMTP id
 5a478bee46e88-2d81efe56c0mr3926767eec.6.1776172295675; 
 Tue, 14 Apr 2026 06:11:35 -0700 (PDT)
X-Received: by 2002:a05:7301:470e:b0:2d8:1efe:51dc with SMTP id
 5a478bee46e88-2d81efe56c0mr3926746eec.6.1776172295118; 
 Tue, 14 Apr 2026 06:11:35 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561cd2c09sm24301325eec.18.2026.04.14.06.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 06:11:34 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, slp@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, richard.henderson@linaro.org, mads@ynddal.dk,
 brian.cain@oss.qualcomm.com, mburton@qti.qualcomm.com,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] accel/hvf: fix double hv_vcpu_destroy() causing teardown
 error on ARM
Date: Tue, 14 Apr 2026 06:11:25 -0700
Message-Id: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rFmoU8JDgvMy1Aj9wQFX2Ouzae3Uw76y
X-Authority-Analysis: v=2.4 cv=HKfz0Itv c=1 sm=1 tr=0 ts=69de3d08 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xliAoVnKQx6J4uCu_igA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEyNCBTYWx0ZWRfX408IeJyWOz01
 ZkRa/SKPIhGqs5Ob6nbQNHT6n3DjC6ZD26jCaZzjun/RpoowUYr9GEamUhEtHI/KdctnD/Gq5+4
 kcYgn0n+sdsKvSPMi4gmjegzcNbYF5PaqXn72Y17izfDvag72/XlqlCep6NgfxG01dp8ClkLq0q
 OGjQc4XQRZE1NiP1vlIGicB8wmUvR2R2CuBet/+Km+4Dt6jfMFpwTXFzpzQTYdzRcDveOSH9CjB
 5qvgHpz8sIkwEKgAIhLF7MwuYevSkdJUd2QKMzUinoGrO83Rt0NsIAbM+Xq6b56Lxc6Un1KdX7Q
 0OWb5jVk53u/duXoWg6mpH3w9LVxAZQpRG1WqwfF8UQGYEOxhQOKppdc/EVoD0nL1+87x1GAbwM
 UDBTi5RW0dIai7XFHFjODjnt6blummXczlk9/kYZQtJgpd3i7IdbGbyxE6DmOcGV1o/oyRTTOyD
 F7ZKX17vcAwt/CoxjKA==
X-Proofpoint-GUID: rFmoU8JDgvMy1Aj9wQFX2Ouzae3Uw76y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140124
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following callstack causes hv_vcpu_destroy() to be called twice,
producing HV_BAD_ARGUMENT on the already-destroyed handler:

hvf_vcpu_destroy
 |
 |_ hv_vcpu_destroy
 |
 |_ hvf_arch_vcpu_destroy
     |
     |_ hv_vcpu_destroy

The first hv_vcpu_destroy call covers both x86 and arm. Let's remove the
second one, as it is redundant.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
v1: https://lore.kernel.org/qemu-devel/70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com/

Changed in v2: removed second call instead of first one to avoid
breaking x86 (thanks Philippe!)

 target/arm/hvf/hvf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..2ee653f08e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1212,10 +1212,6 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
-    hv_return_t ret;
-
-    ret = hv_vcpu_destroy(cpu->accel->fd);
-    assert_hvf_ok(ret);
 }
 
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
-- 
2.37.2


