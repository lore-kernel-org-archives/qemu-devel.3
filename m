Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E41610F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXwz-0005F1-Tu; Wed, 08 Apr 2026 14:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXwx-0002mq-LE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKQM-0005hk-M7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:21:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637KOJkn250047
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=Xd518drQH2h
 l+JKvD0F0VpZcGOu1/VNhmtgMbYgg94U=; b=fWUMR5bR5FQmbFeh6u6Myf3C5NH
 Ns1H5R9X4CYo4m0Yj+gykS+wQYOi+NFv4G9sBHiE4JUDOS9+vh3/GuA7AKSin/VO
 YtCL3WrqQy/B8b5L9LvH01O4GbVUGtFi8Z6vcWhsRUBWDi6BIZj/SA4aEsjSax+J
 yf0J7XHe/JwiHkG3Ayq11e001w9BvEaxyAIoEVKnmAxUuEp6XfE+4TPlyniWEbKi
 T7gwA7Y4P4DV1/zcWPHmTfJ/++FjDjMJjlgTby69miNLisdFuuzrhzyaeSN6Mgh9
 hkrvW1C3VJM6l7rDXNd7KMTXTaQSVwDZWvMnHhHYGKhHGZ8vxkDDKTyuohQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x9971y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:21:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2cc9118dc2eso17125822eec.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622112; x=1776226912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xd518drQH2hl+JKvD0F0VpZcGOu1/VNhmtgMbYgg94U=;
 b=aTGLmIeV5H8fUH564QK471EIrZO1z8ydpqRpjSknNulEq9laQoKFNLjAstKZWmU2O3
 VoaEXlZkGbYmT/aHQ3v8m2ED6f7ZFx8Hrr0FCQBSgOaB7D1YlWVAWLCNHOClyUmS/Pgr
 7mldz/DPfOehD4yFZNWUZK2di/SQY6x1AiPv0OBEonYyCCda/i61J3B/hRdubJJ37ujq
 BCvZYxbMPfkk3pNv+EnQVPjewC+miiEjybc0XBqf1owEPpsysUkGd7xRROfGcr74QdB8
 Art78seJu5gFNJKM6ETuncUqu68rdfKH4pUEsg19TZZVSAI7591bOiwlSzwToTfVJxc0
 UpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622112; x=1776226912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xd518drQH2hl+JKvD0F0VpZcGOu1/VNhmtgMbYgg94U=;
 b=ZAuCkrTKn0ryalbUW3szZwK3oMpXQfLTnehiQoJVc8TxBcFrg8zxQ1I3znyCEe5vqw
 vqvCivDArnEDuuqWDAUWG2S42xK44Dvs7iOBda2oaXQze4j+QhBFUBJmHIdNzvw800uS
 8JSS9fThWYZn13Gabtv/i5lAW9w1jhFPWKadHgku58GWB/v9JNRAOaLE0wuvyS91W+H+
 CMeTSFVqlyyv92uZwvSsFNGxLMGcGw2SVvLRlHfVK37mkawe+DqFN1jTZFJQ5nlXn1Rf
 kuG8tS88Kzo1eAKtJ1GUYKmPLTHNS6s9L2dbRID1OFr4Fsr9vKwVgx35tPRTBrtva+Y6
 NrGg==
X-Gm-Message-State: AOJu0Yz6y0Zcba1tPG1oC8IfNwM6+canVQhRCYVrdy1pNqTo9f8kx+/O
 4b+m1zHhecAjHE9wclvchMsr8MF4BoaHKegWaNSl7J6sdAG9xSP3H876kKCDPBFv8Hi43Q9seq4
 Q/GckA7vkKkV6YwypG0mjwzLCR68qSDqulhXjFxl29Dvr89OhPWsEPjD4wPww4Bc+zA==
X-Gm-Gg: AeBDieu1sRzntqgy0j4F04tBndKi9mfxEjnbyL5TiWbP9ILHs23BzdWaLMj7d7Jfg+t
 gaHx7QxvkVkMYWHz4DqM/5ThpHH4ayNae5DRD2rVNxh8v0KMp0YOanEC96a3PIlKRsEV7Z78j4S
 9qu/CplWgPVxWy7tsrd2mzdXpzegCPoOEgVJkRT1fxrwUcgbuiLygWsGoCIwJYvemWCZxlsDNdt
 EzIrwyv6bpuS4F419BehSulGFBQDyG47R8FnpcsvHJC74/U/k4y6pzE7HBhgi56IIG7CpOjGzD0
 ythCJc5CostfgJABKnvMrkaZ4m4WQCMxaCcmiUa7l270WEGD5sjl+fSl7+KWbg5f67uLNorxS5/
 IRTZc5oOd9UrxFNfhSSEkDzPthnOjqaSSh0CTPtbhYSv/NfMNXu2u4xYcKthfaWPwJPU7ww==
X-Received: by 2002:a05:7022:e02:b0:119:e56b:9581 with SMTP id
 a92af1059eb24-12bfb6eb69emr10298647c88.6.1775622111812; 
 Tue, 07 Apr 2026 21:21:51 -0700 (PDT)
X-Received: by 2002:a05:7022:e02:b0:119:e56b:9581 with SMTP id
 a92af1059eb24-12bfb6eb69emr10298631c88.6.1775622111109; 
 Tue, 07 Apr 2026 21:21:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm23474816c88.0.2026.04.07.21.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:21:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 0/9] Hexagon system emulation - Part 3/3
Date: Tue,  7 Apr 2026 21:21:39 -0700
Message-Id: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d5d7e0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N3XQ6_GsU5t2OgCActgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX78gRzC2AIbvh
 kFkBAAaCvtuhx5Ew0TuZhHdpomcrygIlFPBefqAS7mauUaewXEJgtMIFXoAU6A447FY7Oqq5Fxh
 Ikl7GKVwFxgpaCOjp2kCue5zlbHOfyktRE6bG90J3M2Hu8dEemrQ/HUy1YreBgR2hfQ0speFdmH
 wqt7lqPUsb/lYaMd2BCM17/iKYbzZJu2lp2xJxKgahGKtYfejdNjCHmkDaEXiz+K0iZyhy7oAaK
 fdhTo1RUO+XAT9tw8WRxZvq8VYYcNHdaYtcTZeDTkA7q/aiI8K/nfZTkdszv5kG/gWl/u7fh9M6
 RrlqJwBYQZsUIYxSiBorEKs8jZLj+Gd9vtEFUIdrFUNKr5Nd62FzZYROHlzo0CXV9rLBqtSdpJF
 ECajhDARkxMwC81CRAfNzTSkahaqYLQXgDx/4xMsVjHQ6onDYhjIf0BjNCn6+7rgcsMR0PzS8in
 7r40gu+2mu/mEeLZyVw==
X-Proofpoint-ORIG-GUID: 3UcGdWIygsun8aELl2sblvaoRpIXy7at
X-Proofpoint-GUID: 3UcGdWIygsun8aELl2sblvaoRpIXy7at
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhpcyBpcyBQYXJ0IDMgb2YgdGhlIEhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiBzZXJpZXMuICBJ
dCBhZGRzIHRoZQpib2FyZC1sZXZlbCBzdXBwb3J0LCBtYWNoaW5lIGRlZmluaXRpb25zLCBhbmQg
YnVpbGQgaW5mcmFzdHJ1Y3R1cmUKbmVlZGVkIHRvIHJ1biBoZXhhZ29uLXNvZnRtbXUuCgpUaGlz
IGluY2x1ZGVzOgogLSBHbG9iYWwgcmVnaXN0ZXIgbW9kZWwgKFFPTSBkZXZpY2UgZm9yIHNoYXJl
ZCBzeXN0ZW0gcmVnaXN0ZXJzKQogLSBHbG9iYWwgcmVnaXN0ZXIgdHJhY2luZwogLSBNYWNoaW5l
IGNvbmZpZ3VyYXRpb24gZGVmaW5pdGlvbnMgKHY2NmcsIHY2OG4sIHNhODc3NS1jZHNwMCkKIC0g
Y2ZnYmFzZSBzdXBwb3J0CiAtIEhleGFnb24gInZpcnQiIG1hY2hpbmUgZGVmaW5pdGlvbgogLSBC
dWlsZCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29uLXNvZnRtbXUgdGFyZ2V0CiAtIEJvb3Qgc2Vy
aWFsIHRlc3QgZm9yIGhleGFnb24KCkJhc2VkIG9uIFBhcnQgMSB2NiArIFBhcnQgMiB2NC4KCkNo
YW5nZXMgc2luY2UgdjM6CiAtIFJlYmFzZWQgb250byBQYXJ0IDEgdjYgLyBQYXJ0IDIgdjQKIC0g
Q3JlYXRlZCBody9oZXhhZ29uL3RyYWNlLmggd3JhcHBlciAoUGhpbGlwcGUpCiAtIENvbnZlcnRl
ZCBUQVJHRVRfU1VQUE9SVFNfTVRUQ0c9eSB0bwogICBUQ0dDUFVPcHM6Om10dGNnX3N1cHBvcnRl
ZCA9IHRydWUgKFBoaWxpcHBlKQogLSBBZGRlZCBUQVJHRVRfTk9UX1VTSU5HX0xFR0FDWV9MRFNU
X1BIWVNfQVBJPXkgYW5kCiAgIFRBUkdFVF9OT1RfVVNJTkdfTEVHQUNZX05BVElWRV9FTkRJQU5f
QVBJPXkgdG8KICAgaGV4YWdvbi1zb2Z0bW11Lm1hayAoUGhpbGlwcGUpCiAtIEFkZGVkIGNvbnN0
IHF1YWxpZmllciB0byBtYWNoaW5lIGNvbmZpZyBzdHJ1Y3RzIChQaGlsaXBwZSkKIC0gRml4ZWQg
bWlkLWJsb2NrIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyAoQzg5IHN0eWxlKQogLSBNb3ZlZCBERUZJ
TkVfUFJPUF9MSU5LKCJ0bGIiKSB0byB2aXJ0IG1hY2hpbmUgY29tbWl0CgpQcmV2aW91cyB2ZXJz
aW9uczoKIC0gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAzMTEw
NDIwMTkuMTA4NTAzMC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KIC0gdjI6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTA5MDIwMzQ5NTEuMTk0ODE5NC0xLWJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KIC0gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNTAzMDExNzIwNDUuMTI5NTQxMi0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbS8KCkJyaWFuIENhaW4gKDgpOgogIGh3L2hleGFnb246IEFkZCBnbG9iYWxyZWcgbW9k
ZWwKICBody9oZXhhZ29uOiBBZGQgZ2xvYmFsIHJlZ2lzdGVyIHRyYWNpbmcKICBody9oZXhhZ29u
OiBBZGQgbWFjaGluZSBjb25maWdzIGZvciBzeXNlbXUKICBody9oZXhhZ29uOiBBZGQgdjY4LCBz
YTg3NzUtY2RzcDAgZGVmcwogIGh3L2hleGFnb246IE1vZGlmeSAiU3RhbmRhbG9uZSIgc3ltYm9s
cwogIHRhcmdldC9oZXhhZ29uOiBhZGQgYnVpbGQgY29uZmlnIGZvciBzb2Z0bW11CiAgaHcvaGV4
YWdvbjogRGVmaW5lIGhleGFnb24gInZpcnQiIG1hY2hpbmUKICB0ZXN0cy9xdGVzdDogQWRkIGhl
eGFnb24gYm9vdC1zZXJpYWwtdGVzdAoKU2lkIE1hbm5pbmcgKDEpOgogIGh3L2hleGFnb246IEFk
ZCBzdXBwb3J0IGZvciBjZmdiYXNlCgogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMyArCiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1
bHQubWFrIHwgICA4ICsKIGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrICAgICAg
ICAgfCAgIDggKwogbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArCiBody9oZXhhZ29uL3RyYWNlLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAy
ICsKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAgICAgICAgfCAxNTAgKysr
KysrKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmggICAgICB8ICA1NiAr
KysKIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggICAgICAgICAgICAgICAgICAgfCAgNDMgKysK
IHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKy0KIGh3
L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jICAgfCAgNjQgKysrCiBody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3Y2NmdfMTAyNC5oLmluYyAgICAgIHwgIDY0ICsrKwogaHcvaGV4
YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgICB8ICA2NSArKysKIGh3L2hleGFn
b24vaGV4YWdvbl9kc3AuYyAgICAgICAgICAgICAgICAgICAgfCAxODggKysrKysrKysKIGh3L2hl
eGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyAgICAgICAgICAgICAgfCAzMTggKysrKysrKysrKysr
KysKIGh3L2hleGFnb24vdmlydC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA0NTYgKysr
KysrKysrKysrKysrKysrKysKIHN5c3RlbS9xZGV2LW1vbml0b3IuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDYgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAg
fCAgIDEgKwogdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jICAgICAgICAgICAgICB8ICAg
OCArCiBody9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsK
IGh3L2hleGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUgKwogaHcv
aGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArCiBody9oZXhh
Z29uL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIGh3L21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L0tjb25maWcg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgfCAgMTMgKy0KIHRlc3RzL3FlbXUtaW90ZXN0cy90ZXN0ZW52
LnB5ICAgICAgICAgICAgICAgfCAgIDEgKwogdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgICAgICAg
ICAgICAgICAgICAgICB8ICAgMiArCiAyOSBmaWxlcyBjaGFuZ2VkLCAxNDg2IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9o
ZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3Rh
cmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24v
dHJhY2UuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcu
aAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY2Z18xMDI0LmguaW5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL2hleGFnb25fZHNwLmMKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9oZXhhZ29uL3ZpcnQuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vS2NvbmZp
ZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWVzb24uYnVpbGQKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9oZXhhZ29uL3RyYWNlLWV2ZW50cwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdl
dC9oZXhhZ29uL0tjb25maWcKCi0tIAoyLjM0LjEKCg==

