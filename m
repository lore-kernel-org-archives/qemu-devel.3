Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9748C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1con-0000KI-Q6; Wed, 02 Sep 2026 00:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coj-0000Is-1x
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coh-0000ME-0Z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTI2E2982875
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tUb6HZcIOhxOTay/dp40hNaQg6ai7PBaXk7NXeGW/Mw=; b=k8W0kcgcpyXhOViR
 8AcmWkCPRo76M8JvhXl0bRwO6vA8agtY428VXFdVwHIAVTIuDv+wbHq1IKnL9KGc
 3hhI8603QtbvwTHxqQL+7lKJTwpEJGSU41RoIaV/trZdMi33bxkVj5pBRbqTHfZY
 cuBSXD/X7ZmeuvMlOFZtxdpD5w/13v/kH+hP5KMDFNU80KwA1Z/yVTvBMUGUd3cY
 50BH9VNRc9Wk/JFBhw9AaN3rYP0azbQob45+KkbAbiOJcirEmMTPiey2rrGuLxJh
 UUMTIVmOkyanyW09ggUiANcG0WsrGUW5F2RwjHQjUd7ByQInMPNxK32s1OT27Hoa
 wTyFoA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398d7e0f3b4so892504a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324187; x=1788928987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tUb6HZcIOhxOTay/dp40hNaQg6ai7PBaXk7NXeGW/Mw=;
 b=ML4MAMXMySmRjcihSBw396Z2B81Ovw8s8+lNWZeXXam2JQWdDhrt7wecq0o3OnU3j/
 wlZFrN8SGQIAZD8qEJqLZnaI0VbXOlvzHL6a+QyjC4N4Qgkrr8SQrxg7antXhDS10W8t
 DN6HFUFN84UdtUhvgq2/0wiSRr0Oshv53T115r+qd0mcmBj/DYKwHDBnbTP/sisC+n2s
 JfmBen3f3ojA61UDmbxaa8OTIZxO8GZAlKSYaOEilI1KspntqfdtWHhHTYIBVrlorAWf
 1vurH5dnDRDAMLm+AjI3ThAOZN/bJKHUKvMMX0PVVzi7IpM1DUo47cNIXm1o8IJ+dEgm
 HCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324187; x=1788928987;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tUb6HZcIOhxOTay/dp40hNaQg6ai7PBaXk7NXeGW/Mw=;
 b=OCxf9rZMtfOESJ7CaQp+rK22QmwGYz2bhUHsk6hd4IOI37IWpcBmq3ug8HLprkyA7m
 T6qyDDW29nBBpx11yqDc+OX8JDmykNADD57vrLqJO9JnhpZfT37yNAXLtVmooXQSf7+b
 l/2LeWBNAJICClU5pri7+WXpyIwzLC8ytjooz/oZlBeChBYFFy5hd/WcCo3fC1ZFMjz0
 a5wbLzzZ+Z9cIGDzqJvGOZEoWOuDXmS9YzZ1KAYb2t9r9xDlCTGxU7zy9VAbgoBXn+9P
 kOsCans11bZxHix6Aw+j9pqVh+WqpsCDOzxGmKWTCXu4BTRkByrs292T77uDkQf6BNjq
 K/kw==
X-Gm-Message-State: AFuF++kISjB6t/Z3/m3ajsSN02Q4lArqLL0x6mk10bzOcW5qb7j7Zyc0
 Qi7gphJa/Fm+R9k5rCl0TYZYoqkMIfZQdZm/qKncC48+W1dKK6sWPCiQPZ9dxBxdY6qZTc3s/7s
 XeiOpWu9z5q53z7s1yeGFkHR+kNdejm9B1DQeOpUe3G0p1l2Tn8ji/P7qP5+DKvaJsg==
X-Gm-Gg: AYBFou2YfAnubLvmrby1InE4nDB9O3YZAaZ8c6erV0Khd+buyaa317TqPj5Cd324Qc6
 i90G6FXA7dBs7jFiWLM/WPE72XpUrT86duHr21feLG9QxnD52e8GuHW3mTUFLejoMQVtwKUKgXj
 CWQWONuZ5c4WUcAGpeKm1asuP7eJVu5Cev4Uu4p9YmSomQ3eOoZ7rd6uT6q9BLvsn/Pa0Yh2btI
 qcGlqKq3zNaDpA1iRw86PSsVO6WgXbS+5Pbg9wfAwPBg1eNUfH0z2cnq+n5wm0+hPAODCP5fjLY
 upgPJBjzWb/XT7zOX/gVcfvpjwd/kdoas5jgl8ovzFHYBdaFddb4s5Xi2hXg3IohqDJhpizbuKw
 1T4yH1ZJ60VuxvVMGWl6gvPBt46YUdBaDssG1paAat7BriEzr
X-Received: by 2002:a17:90b:4c05:b0:398:d93a:b343 with SMTP id
 98e67ed59e1d1-39aedebf901mr3215613a91.3.1788324187012; 
 Tue, 01 Sep 2026 21:43:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:398:d93a:b343 with SMTP id
 98e67ed59e1d1-39aedebf901mr3215568a91.3.1788324186580; 
 Tue, 01 Sep 2026 21:43:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 16/28] hw/intc: clear pending bit on l2vic de-assertion
Date: Tue,  1 Sep 2026 21:42:19 -0700
Message-Id: <20260902044231.843004-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXw8uMuU+C+8LS
 VRcvzdDor9CFMiFkQoGYH1AePLZ1wzsfwL02othB1yaXVNoK4gFI5MMlzb1DE9A10Pg/1FPylvx
 iUP5qmBtrP+KkggnFfD1pTAIumU+NP96bCF8XgYZojBWlsmCfT3Jbgz6fP5PQVUWcbcP8TtuzmB
 iem1zfNXPFBDBRAeCVfch5RGNwFt2qFMbZG6bdx+fsRMtBXmPXHrj3B3UtWWNxdSKGyYbY3rtSk
 /orppd57OskjT93kDjOrtTEHzoE3QZce0B4vzk0Hx3+r5PLIHY/RHlS6u+K6RpaTirIGkNtSsfM
 IThucH4cbtd3q220BBmtlxj2AXWls42E+bcvm12elbZ1Hrw6Cw87v1WchRw4WcVHOG6OOwdPfs5
 5IbcElO+13nu6lpUW4Gt4YwS25iQ3Cf3h3yrKAdFF/Jif9fmx6wC5MGLJRvUD8sFmvEEvmHnD9C
 PZZxO88QEIbxs6DTJ7g==
X-Proofpoint-GUID: M_IaTaXL1YiIzDFpbf0eptmUchyY1Bn7
X-Proofpoint-ORIG-GUID: M_IaTaXL1YiIzDFpbf0eptmUchyY1Bn7
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a95b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Z8PlLslTYKWvlVeuNugA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXz6IoKxEIoFnh
 qfpUBs4B2KB1sPHJjpzj/h2NedrqCGGd3mgcSPv+WEU8Snx2e5YrY5fM6cSCF8nhDstKbosXOZo
 7RNA60pVJAW6QNIewV6tXH2chmqmr2A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpsMnZpY19zZXRfaXJxKCkg
Y2xlYXJzIGEgbGV2ZWwtdHJpZ2dlcmVkIHNvdXJjZSdzIHBlbmRpbmcgYml0IG9uCmRlLWFzc2Vy
dGlvbiwgc28gYSBzb3VyY2UgdGhhdCBkcm9wcyBiZWZvcmUgaXQgaXMgbGF0Y2hlZCBpbnRvCmlu
dF9zdGF0dXMgaXMgbm90IHNwdXJpb3VzbHkgcmUtZGVsaXZlcmVkIG9uIHRoZSBuZXh0IGNpYWQu
CkVkZ2UtdHJpZ2dlcmVkIHNvdXJjZXMgKGludF90eXBlIHNldCkga2VlcCB0aGUgcHVsc2Ugc2Vt
YW50aWNzIHRoZXkKYWxyZWFkeSBoYXZlIHZpYSBTT0ZUX0lOVC9zZXRfaXJxKGxldmVsPTEpLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGh3L2ludGMvaGV4LWwydmljLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaHcvaW50Yy9oZXgtbDJ2aWMuYyBiL2h3L2lu
dGMvaGV4LWwydmljLmMKaW5kZXggZjA3ZWM4NTBkNDkuLmE5ODZmMGJkZjM1IDEwMDY0NAotLS0g
YS9ody9pbnRjL2hleC1sMnZpYy5jCisrKyBiL2h3L2ludGMvaGV4LWwydmljLmMKQEAgLTI5OSw2
ICsyOTksOCBAQCBzdGF0aWMgdm9pZCBsMnZpY19zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGly
cSwgaW50IGxldmVsKQogCiAgICAgaWYgKGxldmVsKSB7CiAgICAgICAgIHNldF9iaXQzMihpcnEs
IHMtPmludF9wZW5kaW5nKTsKKyAgICB9IGVsc2UgaWYgKCF0ZXN0X2JpdDMyKGlycSwgcy0+aW50
X3R5cGUpKSB7CisgICAgICAgIGNsZWFyX2JpdDMyKGlycSwgcy0+aW50X3BlbmRpbmcpOwogICAg
IH0KICAgICBsMnZpY191cGRhdGUocywgaXJxKTsKIH0KLS0gCjIuMzQuMQoK

