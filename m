Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD419CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rPl-0004R7-JO; Fri, 17 Oct 2025 16:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPi-0004Q9-2S
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPd-00031P-39
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJG89I004456
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b2pP8LhzCjj6SdsIJ4pCSzvvkowISt+FluLQ5iWnwy8=; b=Bg0E38I7jp5+js7y
 c1rM6SYZmZm2o/3hqijPFx3MsW5XoSE8jJxJpTTyyZPNpQ/gP71FWpNycX3WJG0D
 c5ACohDQss5K2DxjhjxN2BmfYtT3bylhCacDBkhz17YWGX47PZk8GIXEDghw9MVt
 eApmuwWbtPCRfTv5oDEIftwWxciO2ULAuzDu0ofaqOzMh3C17n/Z4K3Syv58jq1x
 LgGv+bDEmp4PYXiLhxWel6zL7NAy74D4Z6bUP7aLpGCC0LNPIC8qbWlOtftET0M0
 vAi4n4LFnaLZBVmXZZAApIN/hwihCeZIBM3xS6U1t/++srwOvigQYzPla9dJBV7i
 7+L5pg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5wu9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7a144677fd9so4173450b3a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734253; x=1761339053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2pP8LhzCjj6SdsIJ4pCSzvvkowISt+FluLQ5iWnwy8=;
 b=I5GFvtI/g1ItmznhTL6NZfHmyMppnpiUDoIm1hgpWb641qsOwEZ12OMOw4ebZ8iFtE
 ksTPNv2cqn2IHWqZpqbKxkno0Wg6EBg0IDVC3jdDK+YrB864s3cG0fNo/cP7yAvNs0HZ
 33baiTFbOuqwgbaQpVt4JvsYWtMe36kRKGHLJD18h2EToblq0cQ7MvzFQ4n0AS82kdGM
 GHx9bMBal0L3coTQ2wyBDkq1Jm0VEuhdITb9NZ4dbQc36tabgLyIObn0Tglia8kHSM0w
 oCa8nKtxQs8R5iUTKDAyFUSTZAdiEopmmuTnYPPjfvWbA/gaKTR9BjLxQS6pdhFZfLvT
 /A5A==
X-Gm-Message-State: AOJu0YzKMZwcUFWvfYxdqCKF9D38ac1GW3jfN8Vxd8Nj8Q/ABUKrl/pm
 W7KlxnUhE4ya6+/RbwmEXmf7UJ/BLaKBSP16CmDnbNWOaQWIyl0/Uq9imk6vOeapeZYl7+3hjOb
 To4Gi50Xi1bLQgqyL7oDGHD5GOjRxP+4EPrfirNmGkNXOuo96YyC5ECAwHuWCg6D4IA==
X-Gm-Gg: ASbGncv65+f1YKwJazZ+g4MQnkmQQMw9pS9yjL32E0vfXFa6D/3jZwfHIQbjt9HANXE
 S2/SNpHRhQu5tT32AAIWThwVKS2tYz7WcZ7B7qUWBM1Y2YQD607ej+MNYKD58NdoG+5F2xGcqTp
 OCDOZ3I/lQMVqDrAcory8NeYMIydad0TwU2l0nMIMtblOHBxJm79BNF6cX8N0aCtPX0LjDSDSQA
 rAyZJH37CbCfhVmma2Q/yJIzVsbRx0rRe/B1beSP0VGmFr6XFbJWCjHq+y+LBFouFdhtq47ZYTq
 0BRg2npQ02LSjQDwe6QHmq378WpZ3R9KS1s4R8bQ+Fmm8z6w434tSXJ9LjLsMB656vIkhCbaOCG
 JpfjeMMUhu/NB18ezbTxeoS2qDXiMn2G0d8tiAFmdybUGD+o=
X-Received: by 2002:a05:6a00:1394:b0:781:2177:1c9b with SMTP id
 d2e1a72fcca58-7a220d232e6mr7096941b3a.17.1760734253458; 
 Fri, 17 Oct 2025 13:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpMWwElC0S8g/N8TkSxsOjTqqQUXnY/iYTjYHAVcIlapWAvhl/LsVlGc50BPRaHjAs6gqB/w==
X-Received: by 2002:a05:6a00:1394:b0:781:2177:1c9b with SMTP id
 d2e1a72fcca58-7a220d232e6mr7096913b3a.17.1760734253064; 
 Fri, 17 Oct 2025 13:50:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 Anton Johansson <anjo@rev.ng>, Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PULL 4/8] tests/tcg/hexagon: Add cs{0,1} coverage
Date: Fri, 17 Oct 2025 13:50:24 -0700
Message-Id: <20251017205028.1105595-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: t319j8ut5W47TWQ2tXA6azcr0jDX-2-V
X-Proofpoint-ORIG-GUID: t319j8ut5W47TWQ2tXA6azcr0jDX-2-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXzOZOVEhZcWEq
 picyuqtkNFA89Uet5S0IWnN0lf+7ixF47HccveCy1WNVwWQQBTEiHKb+TnVDGJwkIoRZ+rZahVf
 1c46ZCdc6aYanjzldBPhRKfjRhxOyHeZShRcd1ZsFDQ0uwNhAYRSxSs4Ak49xkYJ77cWQKNtUvf
 fche16UwZNU7SS2KtGsfPuyAqQ/93UqIw2gFOH103qOwmUD4VvJhLpQ4d7LlK+rY0NFhNc5xJ1q
 uGo29eH1gSBGYXgZkp0eFqX/VMJ/iwZy2px7oSQdVAWaQT7wWFZNZUog0YbbM898SElwAA4qQFU
 RouQEiLWaHRghdoRD5RErGTucTcdGnrS1xNdrwSvgHY39ZsU4TI5uBzJNWZt0L4NPX4skZO2Mot
 R8nFKfuO2Cx5FzCgQHgvhFS7yWyA7Q==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f2ac2e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-udWlhBUCFu-wqMqflQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Q292ZXIgY3MwLDEgcmVnaXN0ZXIgY29ycnVwdGlvbiBpbiB0aGUgc2lnbmFsX2NvbnRleHQgdGVz
dCBjYXNlLgoKbGMwLCBzYTAgcmVnaXN0ZXJzIHByZXZpb3VzbHkgb21pdHRlZCBmcm9tIHRoZSBj
bG9iYmVycyBsaXN0CmFyZSBub3cgY2FwdHVyZWQuCgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5z
c29uIDxhbmpvQHJldi5uZz4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5o
ZW5kZXJzb25AbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0
LmMgfCAyMyArKysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24v
c2lnbmFsX2NvbnRleHQuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMKaW5k
ZXggNzIwMmZhNjRiNi4uOWRlN2Y2YmU0ZiAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24v
c2lnbmFsX2NvbnRleHQuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9zaWduYWxfY29udGV4dC5j
CkBAIC0yNiw3ICsyNiwxMSBAQCB2b2lkIHNpZ191c2VyKGludCBzaWcsIHNpZ2luZm9fdCAqaW5m
bywgdm9pZCAqcHVjKQogICAgICAgICAicDEgPSByN1xuXHQiCiAgICAgICAgICJwMiA9IHI3XG5c
dCIKICAgICAgICAgInAzID0gcjdcblx0IgotICAgICAgICA6IDogOiAicjciLCAicDAiLCAicDEi
LCAicDIiLCAicDMiKTsKKyAgICAgICAgInI2ID0gIzB4MTIzNDU2Nzhcblx0IgorICAgICAgICAi
Y3MwID0gcjZcblx0IgorICAgICAgICAicjYgPSAjMHg4NzY1NDMyMVxuXHQiCisgICAgICAgICJj
czEgPSByNlxuXHQiCisgICAgICAgIDogOiA6ICJyNiIsICJyNyIsICJwMCIsICJwMSIsICJwMiIs
ICJwMyIsICJjczAiLCAiY3MxIik7CiB9CiAKIGludCBtYWluKCkKQEAgLTUzLDcgKzU3LDExIEBA
IGludCBtYWluKCkKICAgICB0aW1lcl9zZXR0aW1lKHRpZCwgMCwgJml0LCBOVUxMKTsKIAogICAg
IGFzbSgibG9vcDAoMWYsICUxKVxuXHQiCi0gICAgICAgICIxOiByOCA9ICMweGZmXG5cdCIKKyAg
ICAgICAgIjE6IHI5ID0gIzB4ZGVhZGJlZWZcblx0IgorICAgICAgICAiICAgY3MwID0gcjlcblx0
IgorICAgICAgICAiICAgcjkgPSAjMHhiYWRjMGZlZVxuXHQiCisgICAgICAgICIgICBjczEgPSBy
OVxuXHQiCisgICAgICAgICIgICByOCA9ICMweGZmXG5cdCIKICAgICAgICAgIiAgIHAwID0gcjhc
blx0IgogICAgICAgICAiICAgcDEgPSByOFxuXHQiCiAgICAgICAgICIgICBwMiA9IHI4XG5cdCIK
QEAgLTc0LDEwICs4MiwxOSBAQCBpbnQgbWFpbigpCiAgICAgICAgICIgICByOCA9IHAzXG5cdCIK
ICAgICAgICAgIiAgIHAwID0gY21wLmVxKHI4LCAjMHhmZilcblx0IgogICAgICAgICAiICAgaWYg
KCFwMCkganVtcCAyYlxuXHQiCisgICAgICAgICIgICByOCA9IGNzMFxuXHQiCisgICAgICAgICIg
ICByOSA9ICMweGRlYWRiZWVmXG5cdCIKKyAgICAgICAgIiAgIHAwID0gY21wLmVxKHI4LCByOSlc
blx0IgorICAgICAgICAiICAgaWYgKCFwMCkganVtcCAyYlxuXHQiCisgICAgICAgICIgICByOCA9
IGNzMVxuXHQiCisgICAgICAgICIgICByOSA9ICMweGJhZGMwZmVlXG5cdCIKKyAgICAgICAgIiAg
IHAwID0gY21wLmVxKHI4LCByOSlcblx0IgorICAgICAgICAiICAgaWYgKCFwMCkganVtcCAyYlxu
XHQiCiAgICAgICAgICI0OiB7fTogZW5kbG9vcDBcblx0IgogICAgICAgICA6CiAgICAgICAgIDog
InIiKCZlcnIpLCAiciIoaSkKLSAgICAgICAgOiAibWVtb3J5IiwgInI4IiwgInAwIiwgInAxIiwg
InAyIiwgInAzIik7CisgICAgICAgIDogIm1lbW9yeSIsICJyOCIsICJyOSIsICJwMCIsICJwMSIs
ICJwMiIsICJwMyIsICJjczAiLCAiY3MxIiwgImxjMCIsCisgICAgICAgICAgInNhMCIpOwogCiAg
ICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnI7Ci0tIAoyLjM0
LjEKCg==

