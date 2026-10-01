Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A675CCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxX-0007y9-4V; Thu, 01 Oct 2026 13:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxJ-0007vy-D5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxH-0001gP-QJ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsmqg3354593
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PTa/Vo+FzifFOYbVGnKA8goMVEYlDXcj+rgiERB6Q3s=; b=e+TJnaX9tqLqAVar
 bAVNPe4v7CFU4YNSTgC5pS3vD8QUIfFLbAMOU8C5iWuQuvq1EsTL5oMdzQkckdhd
 VBSr4HVUUL1AxrvQuTf3UIYPNrALDCKwZRHOaJnjzthnrXNHZH+O7wX0tXl2+w/h
 oJKS4UkaXtSAYlHni9T1dzCbzJsXGpXZ9mwSkUtjnwx5hdnRFKFQLsNSfvRsex+Q
 PzKP1gKIU5IHgI5YEcUX0BQfKvoYx5Taa3jYMudBgAb9XntF1XJkg5qSeX7WKGCv
 o/l7nD/D1LC0nXB8ZXJpmM+g7mIh+s6VKlZfqmkoYoM6KgdXvC5UU9m8pPRO7KQn
 eTtGLg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nub67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:26 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so4568354c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877146; x=1791481946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PTa/Vo+FzifFOYbVGnKA8goMVEYlDXcj+rgiERB6Q3s=;
 b=Z4sIXTqjCo0X4ZgVPVFJZ0M9V/KELfGvTQ6Tmriv4TAt4k8qTVpWJo3/7CmcE0prHZ
 sfNDBrYYIrTmJulmUAt7X/SEkY9JYmzEN16YJdmfiKBrQ/O0GTQ8IOBZkuA/BYYNfpZx
 sbYVyRhUnoERZeHAJepVPb8rvw0Z0gJ60pC2hVuHInMkgTduIBj8/wohKTtiWYN2bIBK
 ipO7G/1ETlk7fBXTH0PetFYqtcfql9SvG23kTc4SqK7PnCR/uvDDjVxjL6SH+uilDhnl
 qxJAawpFGAnKJMTCsK8Mken84tcxvn0J00gSw3wiAWynEFiXwHQXBEHTnlJj0ZORSLo7
 M4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877146; x=1791481946;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PTa/Vo+FzifFOYbVGnKA8goMVEYlDXcj+rgiERB6Q3s=;
 b=dtan21OIb4/IW1wyo7ZowLJhp/CL2DeKfwfdXebHGhNuzKtm/ECXgWRAm6mrL5aSi7
 1IrU8IBvARUjLaiFVKOsBVEgp8QdM2g014nD+pu7QUwa7tK0omTn1jV5C4ofySzu5Mk9
 +jbqgsNGBK+8/LSA93xyvtJqETYhLECdHfVt8F1+ZXiNgOT1Wa+WRUM+m6636ROnq/Ro
 eZvo43dXR9MHVHIx7a40A/mNZxpey51bSxhy3vLyMpT72ng3LwphIGuzbm2lNvKKb5V9
 hOvQLEDCAVzYEJUTIj4wNqte1U7d58j5JqaB15632QPVHaPSOt9aC0/YWkDmjpxRPpw7
 Angg==
X-Gm-Message-State: AFuF++lfu7ZwbO5G5HcEVg9wZ+wq/APdwh8l211CX4SQgPcAex71sxVM
 J1ryh9fsoCRZrAAMbempfc/ppEACIjN8LiArDw0ThF3V1COW7Piwy2CZWhP1onKgSfBhk9o0ZIr
 LGALXl5/lRn4IfYuslgw85zkR/WNqJdcjlL56fFdwJ+kiN7HeURDPwutz9v7U3B0Wxw==
X-Gm-Gg: AYBFou05bfGtKeQpeg41YVOOs8WwIVq/z8cmPi75CaGsoipm7KLzwAllHGX2xWy9RZd
 ohZt3U4ZXsXHSE4vZhHpxZ/2HJJWBG7moeUBVZwqEWwcTsGJFlSGi8TCyzqEJf6JzpgCoIIKQw0
 9qwr1WsXehRTidzXGXB0U3JTXIdHjhJdouAoNfC8Uv0ORi7bkeDHjgLuk2eXO/v8Wf0lwtVvJVc
 QOzHGiqIUEoaD1uFybbou9D52m2N3PNjAg+l7fpLcw3vWY/zRMsrhUFHtTBMTduwNWc5nNIqs2s
 hpXhHA3FuPVBffT4Qjnuj8oZA+7aRv7rDWLn/Fvajy3LCITej21eauG2dqx9q4j2/5ABC0ShnEi
 XBsd/o7MneVxOOFu0CogiHUlLS1oOwqwI8dYXMziBYEQ4pjowQsJH2O7I3p3x
X-Received: by 2002:a05:7022:ea8b:b0:141:4c37:a212 with SMTP id
 a92af1059eb24-14d2fcbf69bmr6034957c88.2.1790877145582; 
 Thu, 01 Oct 2026 10:52:25 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8b:b0:141:4c37:a212 with SMTP id
 a92af1059eb24-14d2fcbf69bmr6034890c88.2.1790877144391; 
 Thu, 01 Oct 2026 10:52:24 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 05/27] tests/tcg/mipsel: add multiarch tests
Date: Thu,  1 Oct 2026 17:51:41 +0000
Message-ID: <20261001175203.8673-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe9dda cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UxoTx-g5h8q4z3wlkrIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXyY3skmvnNBFV
 XnXDoTKhVQeC3yXq0AT8qQjpwNCBGg1LvWg4SJZdU0/sG7VipbbnSomy3xESP+RiONE+slkcK43
 zDiamDTPPl+L/cutua3pVpUBCcJ/YqA=
X-Proofpoint-ORIG-GUID: H_zg53FJrdcNg7hSPDZ4Gie8QZXyvXZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXwQSYgDlddKQt
 +smNJvrwoAZaIRBVR/dDEagKPqzO79q2kou/uIln7s+FRyT3zC0WV7inQtVlO4vg4sBOWJJtCHg
 Fd8Q6S5aOilRQtqDcDLLBczRiauQOADHTRzsl1tNIarVtU26ICqAzZTc4DYaoKpIU+pt6Iq0oF4
 oBJ58kruEwAA09lv1rnR7BAJOiPAZZnNozk96L1bSN5vj6pis8hHNPAWXi0/i5PPHsV7jyq85/K
 LMePSdyyMejABA0/Yk1j+kWATAEEINv2ZeR0cHzyhNl4Sw7bSLXHViLscaP0gKFmxZItcSItMZr
 JlHSDkOrAE5cCaf7gB2ydBzgqOuB1OjoM7U7Sq3sIzq+d9/l5uaKRznKYIh5zoEKqETsEKCRU0J
 I8lYFuF0x+0Tncx9oNJmJwaeRlp5orUPkYf6q+riS/UO6wixhjN8S9BAacYQNmVfGv56YvaUVHJ
 RzsjVj/KjtCJP+zsK2g==
X-Proofpoint-GUID: H_zg53FJrdcNg7hSPDZ4Gie8QZXyvXZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0bf7e840a7d..a02a4bac289 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -1,5 +1,8 @@
 tests = []
 
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
 tests_dsp = [
   'test_dsp_r1_absq_s_ph.c',
   'test_dsp_r1_absq_s_w.c',
-- 
2.43.0


