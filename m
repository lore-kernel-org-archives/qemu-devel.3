Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC15CD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waQtj-0005wr-RQ; Fri, 19 Jun 2026 00:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waQth-0005w9-Hu
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:32:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waQtf-0008TO-OG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:32:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J2v6Dm3465544
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VStjQyCdMzeQEZPvUMmZSW
 4gsMTwrFMuGeCvaV+WJYc=; b=Bzh+P3wiD/hSYfMqyjCnHIwS43pbjkqJJyZhSY
 r15EBP+axHnE5JQEq1O+Yn/r2imChA1xSSsTyBMawf8CLCuUL7YgUcH4pcus8Ng3
 ZY0dBVR+KdvprwQwYEpNPtwIhckjYRWBLk7ZKL16IsA3/pYOAhQfEigGpesOOG7d
 /M6cvFcuHz28ANHRE1pQcVp+p9LbPugDhK2FjXkFFedc7C34JaH36Op/B0hOKqry
 9h+4yROZ7PZnFWO6ADSSkaifXz2DWt6ifmmgjo339N3WTWTMxzlqNqanEmTDhszm
 S6QQwaHvQ9drdPqiWjuDYkpOZOIyDJaKnmJUb+dDChZAvZPw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s9v9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:32:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30b877ee493so2092919eec.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781843521; x=1782448321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VStjQyCdMzeQEZPvUMmZSW4gsMTwrFMuGeCvaV+WJYc=;
 b=BpYvwoNGUOghHiax84JRSxawOFpyTe6BqUTGnCN+2IogfVZ0WcF7iGqWCJS64+lc1f
 GOqpQQIghH/iyEM/hZ4A9WbSoZVkjZ9yNCP6TTPn02vNBkii0LiHyWMW2AuNd7pjsOej
 JK1hJ5HizIo/SEvV/KNfE3K3hAXruPEyTp3wikES1YNfM/+dk0V9sgXgrteJaY/WzhfZ
 U0tpeUykaPMhmjnFwIEAwvRrlNtE6apX+ub/2VGpzSP2pALco0cPV7vWP/FgQt44PYTy
 qz5sQtPXGMFTj/GYECL4vc2sfD2X0VHNBwku9u2OHM9vMWeBWWYXhwC10Xohn1Fa8198
 wgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781843521; x=1782448321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VStjQyCdMzeQEZPvUMmZSW4gsMTwrFMuGeCvaV+WJYc=;
 b=Ol5I5xgDA4A4ugd8mq7UqYoFW/fSeTcYFJUKvOoFiwu/tt20O2IdWPr7Fk+gQbI92a
 yT3K90Gj7K5b+QGW5KxrAcOLSlf5T4ePqOJL9TAGxX2Rwdm0a0LgWXcjd7nYVSXd7vAI
 khUileSjF+1Ff8NSv5mwYH0cshmF0RdP/GMAuhlxOM7x7ozLs4cz6YOKzMQy+q3KJ+ha
 0P8JfcG1yerXn6oTdPDHG7NquaTXhLOUMy+Dg48P6+dgaI7Rk4JLp/yb8g7aXm6PsAli
 Hidyh5SEJmuI+omB/oibMV91uXy3lqknsQiHZk9Nebx8iomjxa346daXjtyNi48wq2eX
 F36g==
X-Gm-Message-State: AOJu0YyVG2PhvT8bs3Gy2rZFgFX34ABqHebV8XhL2WYdM3ptyZ2sISNd
 13MsVUIknZITJC5nQrvT26/37l5TjLRj6STPBiMD+6MQ4FIiUGdYifp2vmAh9LoYQI21lgCPfom
 qrZ3W0bIUQVmtmHAEtZevd0gEBibdWUs+ZvM9OuNg5hCWbzWXqh7pd5PXVfbLHOBHog==
X-Gm-Gg: AfdE7cmUxeASW4Ccqw3fD0YJAsw4JDgyPAeFTWZFgwwcvxpCOuZZylCM6f5bVVchQnN
 /8u3Vu4yXh/UVRGfblBJ7+gvfMbaQPN3kpbn9NBI5EENeHyMmVBTb46svyatAonHD9t8Sa5A/P2
 AVCIUHq8hSpO6tIOWWVp6epSPbf12lWHw3vmxhG5ihiNW3Hd/gp7dOqCJFPXgloobasxrlzS8v3
 lg2gO9HqMHPogZs7gIvdtfAorlCM4BPiWWEItIYNiX7sJC7WtAJLU4frlI17qoZhIQWckCuNUqV
 BY6A3PWwurZu9Fl3qxITxgCryF+8jKUm/KnFkiljoUPNz1L/9LTFyFOuVHar5Qe4UntdVHvFXRA
 5GwHZGPZj3ZTV02JUuavy90jBFSy3nac5gV4C+KoHfKHX5eLPeVHiBKRZpTI=
X-Received: by 2002:a05:7023:b0c:b0:139:85c2:d7aa with SMTP id
 a92af1059eb24-139a311b661mr885082c88.18.1781843520996; 
 Thu, 18 Jun 2026 21:32:00 -0700 (PDT)
X-Received: by 2002:a05:7023:b0c:b0:139:85c2:d7aa with SMTP id
 a92af1059eb24-139a311b661mr885076c88.18.1781843520376; 
 Thu, 18 Jun 2026 21:32:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a3494fe8sm796654c88.1.2026.06.18.21.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:31:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/docker: tolerate chmod EPERM when unpacking hexagon
 toolchain
Date: Thu, 18 Jun 2026 21:31:59 -0700
Message-Id: <20260619043159.2174062-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UnOYTrrXpxA66BXjZw3ra_TEed-OIfRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDAzNyBTYWx0ZWRfX2zIqCjjKeod+
 EmGBPZwQ6J6QM+ORBrBskKJnK2R6LGc6kb9AKAd8zmDUsgEzzZ2EW3AXpPo85MiH2NHFBOI3bvQ
 Qg7WGzTtU6wk07TVRNeN+kulmkxt1R0Rbli6mQ72fiL3xjz1GHBt5EwcwDFfwIA75ty+8ksAxry
 R7PdrVKROVZgOkodNo3r5By2I0Da8rFNshqmUcTQsMI0l0QQV77wHqutUK2MaHDWCpR29UocxSR
 buebgdp5Mxmo7IndIaIvOtuk3qT8So5MUYwzoyM+Zai/xCAfHJd3TJfV3/UX5q1sIi2cJGird2q
 zaMEhRYAn1uTrmjdiuP91RCRiUulQe6i0OhPg2o8XCrrdv707ABte9+4prj7LRfQQxOxTbKrdNy
 0uKiYc+czpRsLAl7k7i8iarQE6AoveZxS/fg7E7W8+4beEQEIumLjlf8nrOdLO3MsnPOW9UzZzz
 b/iJOWnduB7PQ6qZVQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDAzNyBTYWx0ZWRfX+sNACdzdUu/N
 IzL0PyqKJBAO31D/MLCQ6LjmdDVvvJZx0BN9yo/BGj3yGY1MD3pttYrVbICnwyd7sZprUQJ0t7F
 RVAwNTQ7xXLGmfhYIw91FomMt8oM0f4=
X-Proofpoint-ORIG-GUID: UnOYTrrXpxA66BXjZw3ra_TEed-OIfRn
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a34c642 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=RdXCHfyVKiYUX_lfwpsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190037
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGRlYmlhbi1oZXhhZ29uLWNyb3NzIGltYWdlIHVucGFja3MgdGhlIGNvZGVsaW5hcm8gY2xh
bmcrbGx2bSBoZXhhZ29uCnRvb2xjaGFpbiB0YXJiYWxsIGludG8gL29wdC4gVGhlIGFyY2hpdmUg
Y29udGFpbnMgc3ltbGlua3MgKHRoZSAuc28vLmEKbGlicmFyeSBhbGlhc2VzKSBhbmQgZGlyZWN0
b3JpZXMgd2hvc2Ugc3RvcmVkIG1vZGVzIEdOVSB0YXIgcmVzdG9yZXMgdmlhCmNobW9kKCkvbGNo
bW9kKCkuIFVuZGVyIGRvY2tlciwgd2hlcmUgdGhlIGJ1aWxkIHJ1bnMgYXMgcmVhbCByb290LCB0
aG9zZQpjYWxscyBzdWNjZWVkLiBVbmRlciByb290bGVzcyBwb2RtYW4gdGhlIGJ1aWxkIHJ1bnMg
aW4gYSB1c2VyIG5hbWVzcGFjZQpvbiBvdmVybGF5IHN0b3JhZ2UsIHdoaWNoIHJlamVjdHMgdGhl
IGNobW9kKCkvbGNobW9kKCkgY2FsbHMgd2l0aCBFUEVSTToKCiAgdGFyOiAuLi4vbGliY2xhbmdf
cnQuYnVpbHRpbnMuYTogQ2Fubm90IGNoYW5nZSBtb2RlIHRvIHJ3eHJ3eHJ3eDogXAogICAgICAg
T3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQKICB0YXI6IC4uLi94ODZfNjQtbGludXgtZ251OiBDYW5u
b3QgY2hhbmdlIG1vZGUgdG8gcnd4ci14ci14OiBcCiAgICAgICBPcGVyYXRpb24gbm90IHBlcm1p
dHRlZAogIHRhcjogRXhpdGluZyB3aXRoIGZhaWx1cmUgc3RhdHVzIGR1ZSB0byBwcmV2aW91cyBl
cnJvcnMKCnRhciB0aGVuIGV4aXRzIG5vbi16ZXJvIGFuZCBhYm9ydHMgdGhlIGJ1aWxkLiBUaGUg
bW9kZSBtZXRhZGF0YSBvbiB0aGVzZQpzeW1saW5rcyBhbmQgZGlyZWN0b3JpZXMgaXMgaXJyZWxl
dmFudCBmb3Igb3VyIHVzZSwgYW5kIG5laXRoZXIKLS1uby1zYW1lLXBlcm1pc3Npb25zIG5vciBl
eHRyYWN0aW5nIGFzIGEgbm9uLXJvb3QgdXNlciBzdG9wcyBHTlUgdGFyCjEuMzUgZnJvbSBhdHRl
bXB0aW5nIHRoZSBsY2htb2Qgb24gdGhlIHN5bWxpbmtzLgoKRG93bmxvYWQgdGhlIHRhcmJhbGwg
dG8gYSBmaWxlIGFuZCBpZ25vcmUgdGFyIGVycm9ycyBkdXJpbmcgZXh0cmFjdGlvbgp3aXRoIC0t
bm8tc2FtZS1vd25lciBhbmQgLS1uby1zYW1lLXBlcm1pc3Npb25zLgoKU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL2RvY2tl
ci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIgfCA3ICsrKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyIGIv
dGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlcgppbmRl
eCAyM2U4YmIyZmIyNi4uODE3YzkwMzI0NmEgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2RvY2tlci9kb2Nr
ZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKKysrIGIvdGVzdHMvZG9ja2VyL2Rv
Y2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlcgpAQCAtNDksNyArNDksMTIgQEAg
RU5WIFRPT0xDSEFJTl9CQVNFTkFNRT1jbGFuZytsbHZtLSR7VE9PTENIQUlOX1JFTEVBU0V9LWNy
b3NzLWhleGFnb24tdW5rbm93bi1saW4KIEVOViBUT09MQ0hBSU5fVVJMPWh0dHBzOi8vYXJ0aWZh
Y3RzLmNvZGVsaW5hcm8ub3JnL2FydGlmYWN0b3J5L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZvci1o
ZXhhZ29uLyR7VE9PTENIQUlOX1JFTEVBU0V9Xy8ke1RPT0xDSEFJTl9CQVNFTkFNRX0udGFyLnpz
dAogRU5WIENDQUNIRV9XUkFQUEVSU0RJUj0vdXNyL2xpYmV4ZWMvY2NhY2hlLXdyYXBwZXJzCiAK
LVJVTiBjdXJsIC0jU0wgIiRUT09MQ0hBSU5fVVJMIiB8IHRhciAtLXpzdGQgLXhDICIkVE9PTENI
QUlOX0lOU1RBTEwiCisjIElnbm9yZSB0YXIncyBjaG1vZC9sY2htb2QgRVBFUk0gb24gdGhlIHRv
b2xjaGFpbiBzeW1saW5rcyBhbmQgZGlyZWN0b3JpZXMsCisjIHdoaWNoIHJvb3RsZXNzIHBvZG1h
bidzIG92ZXJsYXkgc3RvcmFnZSByZWplY3RzIChoYXJtbGVzcyBtb2RlIG1ldGFkYXRhKS4KK1JV
TiBjdXJsIC0jU0xvIC90bXAvdG9vbGNoYWluLnRhci56c3QgIiRUT09MQ0hBSU5fVVJMIiAmJiBc
CisgICAgeyB0YXIgLS16c3RkIC0tbm8tc2FtZS1vd25lciAtLW5vLXNhbWUtcGVybWlzc2lvbnMg
XAorICAgICAgICAgIC14ZiAvdG1wL3Rvb2xjaGFpbi50YXIuenN0IC1DICIkVE9PTENIQUlOX0lO
U1RBTEwiIHx8IHRydWU7IH0gJiYgXAorICAgIHJtIC1mIC90bXAvdG9vbGNoYWluLnRhci56c3QK
IEVOViBQQVRIPSRQQVRIOiR7VE9PTENIQUlOX0lOU1RBTEx9LyR7VE9PTENIQUlOX0JBU0VOQU1F
fS94ODZfNjQtbGludXgtZ251L2JpbgogRU5WIE1BS0U9L3Vzci9iaW4vbWFrZQogIyBBcyBhIGZp
bmFsIHN0ZXAgY29uZmlndXJlIHRoZSB1c2VyIChpZiBlbnYgaXMgZGVmaW5lZCkKLS0gCjIuMzQu
MQoK

