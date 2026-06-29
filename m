Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D3CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3eG-0003ou-T1; Mon, 29 Jun 2026 00:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dn-0002xN-9O
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dk-0001W3-Ep
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NHDs1771453
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=; b=QI
 ZTgDxBTlikgC1eyUw6cSi+DXObY3gPjiRbTBUz5g48AZkAtrtMTlFpZ9wRumYuj5
 +S4RPEfqLwKG0iWzkBj5Hd33swAJBrKnj3BtII+FI/fLEB3bYkJ5HYyZsqlY0WBW
 VJH8nMm6NB+/i1TU9PL4R2Nz7noR52Nxko2i44gkSgzyTgMmZcXG64R+XSLoh5ji
 Gft9Ek2bTf9MuD7oYCjVih0x4IOeibhrBcHSGjCpGDVGwvh1xWWUvAWBdfXA0Bd1
 LhjpCUTUgt4Gup0ZgZWvO2dVjK39W1qa7qs3Re7hOpcvPhxRtuXNatwtYqKYaxxX
 wgjGj4oJjoCwsnJx5e7g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumctc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so13505789eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707423; x=1783312223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=;
 b=EgTzW0mHLQPeTGxltyiYhw1Ehw0SeEFIAVvBfm+ud3zPItB/6x+JFHlqCb+yqpHT4Z
 yUR3np+orKKuG6hKPDWre+Rhub/Wh+w4bJhhQ5vtS3pfCayUH8Z7HmM8NjNRV6FV9wg6
 DWLqSoa4rf+PmuckxLudFlDl3jEO3J4vdXsUYpyT+UF4aQ2BH9MDq/MTcMGdv15EhbrZ
 3kqCpiye+p6yFu9vSw1jY2xCnOBhTylAEp2hkwOPy/pDIzvrBfE5mILNKwMxWaE87WrS
 t21o7Wcy86fAu1w/aShWsiRqPSKoWGV62E4UHWq9E7Uaid3YCZmp6p5ff9mp4z5ET05z
 c3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707423; x=1783312223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=;
 b=RQ/tEfVu//5VYrwAluQnn4UcqPhn6+v4pfLQ1YW6Gi47aFSmIiFh3LqK6Xj/G5loTN
 /Lp4l9fYWV+QRCXgLvhG7BXxy3favO6oaT//izLBfq2GtsypS/bc+1H7iqykjo1KUZ6D
 IvdK/dt5ifWhUBAmlo3ViClpokosS/aZTNgjH+nj5ptrTdbAfzuyCc+FexyoCoeQA3sU
 99Ex0Wcm7QhsgZblPxYRCIfeDdznhXsc74sB4PpCJ6ku9GD5Vt6djS9BGh6WKaV0IHYL
 kKFycTYKGm1wmk96E7PixFOpduX1ndtcLre1EDlxHXwN9n7xGpIGJbxlYFAQGB4N+jNF
 O24Q==
X-Gm-Message-State: AOJu0YyXgxSY37yw9VNboc3hlvsrUGiXNYKX1s4oc5F54qC5C8kG0lV+
 2HEC2Y74qh09ogE9fRY92JuqfqrnD0HNttKjgsqld9VLRPgbWnFfaWSXBJQJNPMbcWemb0lJXoN
 Z7Ko7rssCIZNAddbOQ/nhtIQjp+xey8g6lGmuY0M0EVJ2kEyx0J2N4PDjMn2cLWxr2w==
X-Gm-Gg: AfdE7cmgmG1c1AGFn4yLolKekdGK+DeP37JNIcWQ+wheZu/jSeQ4WlKj7FcU3O+5PAh
 gBkhLpnNIralVAI2o1L17/XF35gTizGm5mw/flQ0fCZKpszaFRpCFBqvSdS1zpgUcM0bl1utpRB
 hr9cEuYq/qloleJHu9eTrD18N52/k7iNe1NxwSnoCp4HIuql9LQawhMCCxfSTBWhxhH43L5tRWN
 n9XqthE/N/+zQvleztM0O8lcT+c6ZYNBMdU+4Lrqi1QRxbhrsJscA7AVR+DnUtefOP2TLc77VS6
 HUa6y2N++R9e3Py4EhKapXoFJh24F/aUnrGdha9q1Q8GZGV1dAXUbMP7tQkauV8q0chMZuUZrcP
 EbQUKsz6L9KDIiCpQqZxSe6UzwZhur19dmcy+DCBJGscKA6WkA75r6n/aM2I=
X-Received: by 2002:a05:7300:548:b0:30e:952b:ddf4 with SMTP id
 5a478bee46e88-30e952be013mr5674662eec.3.1782707423461; 
 Sun, 28 Jun 2026 21:30:23 -0700 (PDT)
X-Received: by 2002:a05:7300:548:b0:30e:952b:ddf4 with SMTP id
 5a478bee46e88-30e952be013mr5674639eec.3.1782707422960; 
 Sun, 28 Jun 2026 21:30:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 73/77] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Sun, 28 Jun 2026 20:58:26 -0700
Message-Id: <20260629035830.1520296-74-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: --NVk41cjGkq0vKGIIdeJ3WjJSpCf9-z
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41f4e0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: --NVk41cjGkq0vKGIIdeJ3WjJSpCf9-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX9z6ODXOLnICH
 86iNG0QE1fsDWGhedktHNiEfRzJfrATS29GeYPXBUHPsrFYqqIvUT37tNqYAUA7woNf1ZWM8DZW
 8IR/rEAxa8YEJZzJnWm6OtDDUzUvNZhC7C1UctzBkaeJuruhfdKYeWpjiYg/TKkDzUxFk4uB1ta
 h9KqGgtCZXe9DJ5Atq+o/HVuBac5t5TpGpCFscicy96PS04XRg1ibAqeeQ2e9LOwxqOEDtFpGdL
 n8tnfRXGQqaAtYGCSb4YkdwHz5xoBhwJ313inXiDXzCDpbI/sl7iyz35/VDk/0XK+Bcvr5VDHhU
 Qy2SwJtVyZQLek4JMbRC4SS8vkxTwi1J35LulFzJQybbBYT1pCc2VNdUF6rT3zjHNJTxiM6IHcv
 I4bXqmnf9JAEZ+wmNV1wXRBKUqaetDBs1kb6I1PU2mX/EIMxYXgxqYAxZZg/bcZcFdDovwvQTrP
 bloB6Ahj7nWKpouhvVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX5VMploHCu+ND
 ybdOLINEcMil7TaDLqt19ex8Ei/yDwczB1WffvPtxoA0UuTjk2xoIyWu4Cbcn0JpFoU1k5NicaC
 eoKZ+DpMANafKW9UWRxXEndGni8Fj1k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFj
aGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysK
IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jICAgIHwgNjQgKysrKysrKysr
KysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKykKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5j
CgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVfY2RzcDAuaC5pbmMg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNDQyY2JlM2JlMzEKLS0tIC9kZXYvbnVsbAorKysg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwpAQCAtMCwwICsxLDY0
IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLworCitz
dGF0aWMgY29uc3Qgc3RydWN0IGhleGFnb25fbWFjaGluZV9jb25maWcgU0E4Nzc1UF9jZHNwMCA9
IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgMHgyNDAwMDAwMCArIDB4MTgwMDAwLAorICAgIC5s
MnRjbV9zaXplID0gICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAweDI2
MzAwMDAwICsgMHg5MDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgMHgwMDAwMTAwMCwKKyAg
ICAuY3NyX2Jhc2UgPSAgICAgICAgMHgyNjMwMDAwMCwKKyAgICAucXRtcl9yZWdpb24gPSAgICAg
MHgyNjMwMDAwMCArIDB4QTEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21f
YmFzZSA9IDB4MDAwMDI0MDAsCisgICAgICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAg
ICAgICAuc3Vic3lzdGVtX2Jhc2UgPSAweDAwMDAyNjM4LAorICAgICAgICAuZXRtX2Jhc2UgPSAw
eDAwMDAyNDE5LAorICAgICAgICAubDJjZmdfYmFzZSA9IDB4MDAwMDI0MWEsCisgICAgICAgIC5y
ZXNlcnZlZDEgPSAweDAwMDAyNDFiLAorICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwMjUwMCwK
KyAgICAgICAgLmF4aTJfbG93YWRkciA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdHJlYW1lcl9i
YXNlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2VydmVkMiA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5mYXN0bDJ2aWNfYmFzZSA9IDB4MDAwMDI0MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50
cmllcyA9IDB4MDAwMDAwODAsCisgICAgICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEs
CisgICAgICAgIC5leHRfY29udGV4dHMgPSAweDAwMDAwMDA0LAorICAgICAgICAudnRjbV9iYXNl
ID0gMHgwMDAwMjUwMCwKKyAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDIwMDAsCisgICAg
ICAgIC5sMnRhZ19zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAw
eDAwMDAwMDAwLAorICAgICAgICAudGhyZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAg
ICAgICAgLmVjY3JlZ19iYXNlID0gMHgwMDAwMjQxZiwKKyAgICAgICAgLmwybGluZV9zaXplID0g
MHgwMDAwMDA4MCwKKyAgICAgICAgLnRpbnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5s
Mml0Y21fc2l6ZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMDI0
MDAsCisgICAgICAgIC5yZXNlcnZlZDMgPSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNl
bnQgPSAweDAwMDAwMDAwLAorICAgICAgICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAzLAorICAg
ICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQg
PSAweDAwMDAwMDAwLAorICAgICAgICAuY29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAg
IC5jb3Byb2MyX3JlZzAgPSAweDAwMDAwMDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgw
MDAwMDAyMCwKKyAgICAgICAgLnYyeF9tb2RlID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmNvcHJv
YzJfcmVnMiA9IDB4MDAwMDAwMDgsCisgICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDAwMDAwMDIw
LAorICAgICAgICAuY29wcm9jMl9yZWc0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnNSA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3Byb2MyX3JlZzYgPSAweDAwMDAwMDE2LAor
ICAgICAgICAuY29wcm9jMl9yZWc3ID0gMHgwMDAwMDAwNiwKKyAgICAgICAgLmFjZF9wcmVzZXQg
PSAweDAwMDAwMDAxLAorICAgICAgICAubW5kX3ByZXNldCA9IDB4MDAwMDAwMDAsCisgICAgICAg
IC5sMWRfc2l6ZV9rYiA9IDB4MDAwMDAwMTAsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MDAw
MDAwMjAsCisgICAgICAgIC5sMWRfd3JpdGVfcG9saWN5ID0gMHgwMDAwMDAwMiwKKyAgICAgICAg
LnZ0Y21fYmFua193aWR0aCA9IDB4MDAwMDAwODAsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDAw
MDAwMDAxLAorICAgICAgICAucmVzZXJ2ZWQ1ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2Vy
dmVkNiA9IDB4MDAwMDAwMDMsCisgICAgICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAw
MDAwMGEsCisgICAgICAgIC5jb25zaXN0ZW5jeV9kb21haW4gPSAweDAwMDAwMGUwLAorICAgICAg
ICAuY2FwYWNpdHlfZG9tYWluID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9
IDB4MDAwMDAwMDAsCisgICAgfSwKK307CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVf
Y2ZnX3Y2OG5fMTAyNC5oLmluYyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0Lmgu
aW5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4wYzc5Njg5YmMyMQot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5j
CkBAIC0wLDAgKzEsNjQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyICovCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB2
NjhuXzEwMjQgPSB7CisgICAgLmNmZ2Jhc2UgPSAgICAgICAgICAgMHhkZTAwMDAwMCwKKyAgICAu
bDJ0Y21fc2l6ZSA9ICAgICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAg
IDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3NpemUgPSAgICAgICAgMHgwMDAwMTAwMCwKKyAgICAu
Y3NyX2Jhc2UgPSAgICAgICAgICAweGZjOTAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAg
IDB4ZmM5MjEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21fYmFzZSA9IDB4
MDAwMGQ4MDAsCisgICAgICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAgICAgICAuc3Vi
c3lzdGVtX2Jhc2UgPSAweDAwMDBmYzkwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5
LAorICAgICAgICAubDJjZmdfYmFzZSA9IDB4MDAwMGQ4MWEsCisgICAgICAgIC5yZXNlcnZlZDEg
PSAweDAwMDAwMDAwLAorICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwZDg0MCwKKyAgICAgICAg
LmF4aTJfbG93YWRkciA9IDB4MDAwMDMwMDAsCisgICAgICAgIC5zdHJlYW1lcl9iYXNlID0gMHgw
MDAwZDgxYywKKyAgICAgICAgLnJlc2VydmVkMiA9IDB4MDAwMGQ4MWQsCisgICAgICAgIC5mYXN0
bDJ2aWNfYmFzZSA9IDB4MDAwMGQ4MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50cmllcyA9IDB4
MDAwMDAwODAsCisgICAgICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEsCisgICAgICAg
IC5leHRfY29udGV4dHMgPSAweDAwMDAwMDA0LAorICAgICAgICAudnRjbV9iYXNlID0gMHgwMDAw
ZDg0MCwKKyAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDEwMDAsCisgICAgICAgIC5sMnRh
Z19zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAweDAwMDAwNDAw
LAorICAgICAgICAudGhyZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAgICAgICAgLmVj
Y3JlZ19iYXNlID0gMHgwMDAwZDgxZiwKKyAgICAgICAgLmwybGluZV9zaXplID0gMHgwMDAwMDA4
MCwKKyAgICAgICAgLnRpbnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fc2l6
ZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MjAsCisgICAg
ICAgIC5yZXNlcnZlZDMgPSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNlbnQgPSAweDAw
MDAwMDAwLAorICAgICAgICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAxLAorICAgICAgICAuaHZ4
X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQgPSAweDAwMDAw
MDAwLAorICAgICAgICAuY29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Byb2My
X3JlZzAgPSAweDAwMDAwMDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgwMDAwMDAyMCwK
KyAgICAgICAgLnYyeF9tb2RlID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMiA9
IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDFmMWYxZjFmLAorICAgICAg
ICAuY29wcm9jMl9yZWc0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNSA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzYgPSAweDFmMWYxZjFmLAorICAgICAgICAu
Y29wcm9jMl9yZWc3ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmFjZF9wcmVzZXQgPSAweDFmMWYx
ZjFmLAorICAgICAgICAubW5kX3ByZXNldCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5sMWRfc2l6
ZV9rYiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5sMWRfd3JpdGVfcG9saWN5ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnZ0Y21fYmFu
a193aWR0aCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDFmMWYxZjFmLAor
ICAgICAgICAucmVzZXJ2ZWQ1ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNiA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5jb25zaXN0ZW5jeV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuY2FwYWNp
dHlfZG9tYWluID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9IDB4MWYxZjFm
MWYsCisgICAgfSwKK307Ci0tIAoyLjM0LjEKCg==

