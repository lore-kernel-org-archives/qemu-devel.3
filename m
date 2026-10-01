Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C0DCA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKy3-00088J-NV; Thu, 01 Oct 2026 13:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxn-00084s-68
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxl-0001qO-9L
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:58 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsmDU2687134
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SSNY5oTPStUnkVazOtR9WH497MatXquToFIDV6MfVe4=; b=Yx+8NruQhbvV8jHG
 vqYcYSVnTaKxRXIIYfb+1SzY0ip2ia749NlzuMkCXDwIm8SrEwuUnWhYSsvc1dKc
 ZS/M7gex+t1yNtLhasZiSQGBsLMKvORvIw7MSuab+LasAOFvDoTDnTRcDq3l9M14
 xJtey3u+Jsht4gbTmmckWEdlWC0hniqkSGPRWTtzn6ZJVyw32IzZ8eMF/PFdfkfA
 k8sSk1gxDNsDJ+2m98/ffmujim9sf1EqM7lQ+Sl5ZKq0390vQkMW8tIqb1n5p/ue
 OL3lyzcRsr4SmWVNTs+F0eWuJCjbUUd5MwxMIHPlFEk9HSV+F4KfiuIRhz9t3AGn
 0MFieA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8ntq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:46 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1431ba79941so7872816c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877165; x=1791481965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SSNY5oTPStUnkVazOtR9WH497MatXquToFIDV6MfVe4=;
 b=WxjpMYiY5ydsStSmQRqBlThOqc3VnmDwqb9kTzpveyqrL2sqnXnRcxu4WafrojA9GV
 Maa/uppnido96df4btcPKaWfju9x3KaB/KPvIKL+/DVo2YFns4bAu4zePBpervwEwHFe
 Ork6O/0/IasaGp3QtxvY29i5fa/G0qLhci7uopJCPUqFwoKwmyG1BN3h+4vQ0NHJlHfE
 dt1MpF/xkxjhJ5sgrRGNcidgxiJ6b9jiCEoPFyuxhZeVBeLWKbFHo/+bgJZ83YEfMihH
 g6Ub6+pcxeIJ1K/IZGSu2AptQec89IA5fxY6IcLTdGuSUE6rQFnnhPfsk4PuL7U8shQc
 IWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877165; x=1791481965;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SSNY5oTPStUnkVazOtR9WH497MatXquToFIDV6MfVe4=;
 b=Yva2aM8R1gwMvLYGqswUDtuskcR9wEE6zt7kBXJcXqEJuETHlDh+fxbF4YsWNU0AAo
 9OJOJwixwJWp+JmLP0krhcJ2JTriRgQ+v5WQbbimnBU8alRDRlZFHoL4w9n/M7vNaTOF
 xrqHtN0mfKVHwsKkLO2bRh1B+mZD4B0ixOQweQhS3D0hAeKvhj2t9nH1GKwsUuG86KmF
 InfFLqmVWFYY7zpfsGVB2QCBX45CJsTnb3qjSyK5dqet0huqAXKuS7iU8UE53aSmgCWw
 HHDWKdUvWpi3wC4DauGq6cyG5ixUcH0BvOhNY8LQ/UQNXYhMUmJZEtYqirYY2iaQjR4c
 26bA==
X-Gm-Message-State: AFuF++kFHg5nLMKzu11o41EPGBJ/prgshq7EcKp1UaiTp9osBD6mhIPH
 DCpVtiIRJD1WlEokoBhSEBvZps/xKPVvnv3zpH37J6R4OSOGfKPbQdVp/no1ZeOLchnFTGR31W2
 22yXx9/fFofaPhYhy9ZuqFtLs8nLWQUTbTHrL25oFSmeAQB2yP5mmhvw/WFZY/Pxqqw==
X-Gm-Gg: AYBFou2GE7BW+cpVJWz6/oeMWWdMGKdm7P27eySU3JLeJSdATFT0pajQN+21/zPKkeA
 HSWDN+RDmKthzDs6DWv1+Tcx1cbdJGX/OBKuqkuWxQdHSLx38z2po/iNkgArw+GSJ9MAV6VUfI0
 QuXejcBWDbAjrylt/IkuiM2OpZVx4FuCdY1DFm8DIytnxaXNs/eYJEzSwEPfkm+8un7PEB06dQ2
 fmf/OOB9xBdniyxQLfzAD+j25Qqc4+qwG2f5aJcd85G8yrvhjdp5MEeoZEdQkng+7GzDZHAJ8gi
 MLFa72o+Njcrp6nJNR9fN9t76RuX9CzNb++jFMoGHsHjv0YqmPgWlzroDv4OVByXwo4u9Eu/LkK
 TNykDI53g/2SWc/nCWrhszcSXAnXC014L2aV5nD4f1+xqwoJaPCoQXrfsK7vh
X-Received: by 2002:a05:701b:2712:b0:148:302e:1bed with SMTP id
 a92af1059eb24-14d33490065mr6002511c88.38.1790877165277; 
 Thu, 01 Oct 2026 10:52:45 -0700 (PDT)
X-Received: by 2002:a05:701b:2712:b0:148:302e:1bed with SMTP id
 a92af1059eb24-14d33490065mr6002401c88.38.1790877163624; 
 Thu, 01 Oct 2026 10:52:43 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 21/27] tests/tcg/mips64/mips64r6: add msa tests
Date: Thu,  1 Oct 2026 17:51:57 +0000
Message-ID: <20261001175203.8673-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4GxmF3eCcUuH
 ggHudx39NOROkf2QSjDXC2ykco0Z47jo1excvyQZYXuCJ1tngcHVrJBY5X2YMokLnSCDVqs1gR5
 zVgXpX8l6UqmUlSdTAk99yp/vhN1wqM=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9dee cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xXatPaY6A71EF1Dc_LYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: Wb_sB4CWblb78_vNciLJeDHf8k0wg_sv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4CTt1VUeJFNs
 6NfJmio5kG1+/LjPAmz56+WFpiRe8vRpS7tU3RfEzGR6XzNvYukdO/rXwrvgZAvUsqV81/M9wld
 jngavvLp/IJ2Kl44S5MEFj5Z41ZlYIGO7p5GsHwi5MANbByjyX5qD85O7oD9KPpdeMBx1yirpE+
 OobGRpUpDCaBlNeshqIoddZQWjtBf03FTNxmrBc3wDU3glX8z8u4S4kEqMPjHJ6n3CsnH2TutnS
 W0i44CKerXegWA3tbGlCLA6/H7Z2bsXzCyyl1EvJZSZmmdWP1rcvN6hv8iv/h728jo8K+NpAbVV
 B3Dx6xnI6LT3t5WMdC7j5Z/ndPA26eiTk9xXMI6ol39Rz6ytnTfQbO8Vefedt1ifHbCGjULYupW
 Rxm/28yehgK/x+jpLgfr6HRhirD5ZE/yLw3fW6HW5ZYJo6hDt0upy06GYuDZCwGbDEkjEnPm1EV
 FGgYgmT3pmQrp83xJUA==
X-Proofpoint-GUID: Wb_sB4CWblb78_vNciLJeDHf8k0wg_sv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Those tests are added to mips64r6 and mips64r6el test suites.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-22-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 676a47f5c8f..c80a3716f55 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -65,6 +65,15 @@ foreach src: tests_mips64r6
   tests += {src: {'cflags': '-march=mips64r6'}}
 endforeach
 
+foreach src: tests_mips_msa
+  tests += {
+    src: {
+      'cflags': ['-march=mips64r6', '-mmsa'],
+      'qemu_args': ['-cpu', 'I6400'],
+    }
+  }
+endforeach
+
 # export tests for mips64el
 tcg_tests_mips64r6 = tests
 
-- 
2.43.0


