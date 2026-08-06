Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6721EC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5m8-00052D-RO; Thu, 06 Aug 2026 17:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1ws5lq-00050s-2h
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:36:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1ws5ln-00005r-6u
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:36:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L8Akm2815661
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PCw+r03c1GCoMBqkJSeJiTXWTAy4S3oUw3qsrGuqlbI=; b=Di1mQA2g3wZAh5vk
 JmD6PCCrd4MCZAD5ZkDU3T5ykW8HmEp/Z8J9JsGJ4jOx+4QVBkNLmZq594KpjjvT
 DpFfHjrrLM9+GSjfw0bXRkW2+RBpfMGEYP0uvn2gLw9ZRvISpVoV0BCvIMqRn7h7
 rnFE6fx9i0sP6Ew/6E4r0muZAl+g6xznKU30qz+LJx7uO4WtZ63pPE0erFTM9MBm
 xYxj8qFWbSj/RKn/jRUtqYBElrb1zCvTFOK/oJKIdsBKqsZt6bavABfSMpRuziSy
 TVoHI2K11D47csjl1GmpGJ8NUDtpI0lEAAB5Yj7WJu9qwL5TT1tjSgGgGj6DsKdY
 BAjf2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hruvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:36:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so1097253a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786052208; x=1786657008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PCw+r03c1GCoMBqkJSeJiTXWTAy4S3oUw3qsrGuqlbI=;
 b=jcvSuEmxZYbA3jnd0E7ByS38EXM+HG5y2MWknS59YIT1wUPTm+t/UmqFPJOBjVPwxL
 4604wcLYZrk55bc6MZYdiVj9NjJ2XJsGoatfKVfWaP0RKMhRvPsydG0+5DPZ9rdHfc+q
 /jal6CO3TtViGhIeUsONTqV23P4z6JMKov3mUWlsJgFkDtydiDHzJ2bx3qnWK0twXjL5
 q3yTLGoqyLiI54bkvxj4SMQlCD3cNGLrYuqg4iCmHEYTPr+doI2Jq4XhTofTJfa6uED4
 bpihe/ubesPaPyraWR0AmJCnEThcdyevDqmX82RSKP5k2bTzruhpNd9D5ypd+3GxuScs
 Ns3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786052208; x=1786657008;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PCw+r03c1GCoMBqkJSeJiTXWTAy4S3oUw3qsrGuqlbI=;
 b=qO6o8F6xvATUU/v162oiQgRoqAH/Wr10IXyLr07l3pY6RLs6cCgaAglCfxxTJ1cOh5
 BkA62yEapsCBoiaWnP14Zjgf/zw0r4HjR4dOxeiQDdRF1yQMkDf0Iw4newgO81u2fgHJ
 Qf2wNAg00uje3qVPE5yZENxA7Ow8DfWwLIXvdyo0lKwKFsZFn1DyaJAgP7taXaVR6M/A
 tWu3LloABuUULxOeDusk7TNxbim3gyjHxT6b9PG/6PumHAsTTr7oL7RKCBVxzyXsrXMu
 IxRtkD7GtZm1StEy5NYQ6TNR2cxfGM3sQlcc7lNCB32SRZ8GJQpE0LLysAVuQw8IXHqa
 CQRQ==
X-Gm-Message-State: AOJu0YwsBYxYYS1cf9g8Xim3ZGR9dX+6gQFa5TCIy9O4N174ynQHIv5c
 ibnf6MLTb5B+85/U1e1SgapJR/9/+ghDe2vsnIasMKjN4NBUQs0/74P5BNFgUsdjeVHk8owfleo
 J/LqiwkjFXEaJKgAApBZtWANQRR/PVDhH/aOSglJn9otw5RFeb/BJhJalFcS32JXjJA==
X-Gm-Gg: AR+sD10E8qiZPthbXTgnvLbGB/mWfaQSBDAo9C8fw00Sd123mT7s4T2mvoW0cgaE3jH
 chHoRsqGlkCLWFRzb0LGFNQau8nw0DMRvOZIozcavoWu7JWK3nsyWDwISeQ4bSjCENohqH9eYtx
 P3E1FGjS5JVOCyXXeWLFpnCN0o0P4UEy6s/8Shmp1Fm1xMQNV3yctHT/xIOr9XDwLIcq61jooWz
 y7rLN5FqMJ1cI/bBo//bey6Iz2iXwYnj0Zqxtpz+VRQDGne43p5in5AkHaynZc+OFO+ydj2KCru
 TLDyOpXxuQv2y8iytEdr27nwAj7sooqB04kmlz1GUZsWJ9yx146nNVBnwK33pJUpQxU9K04nR9S
 6MHfG/HmHcvMf/zTWU0/4byn0LEAI5oYT6pPLsF1UoEAE8zar
X-Received: by 2002:a05:6a20:914f:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3cb9c2c4782mr9148264637.19.1786052206545; 
 Thu, 06 Aug 2026 14:36:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:914f:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3cb9c2c4782mr9148135637.19.1786052204471; 
 Thu, 06 Aug 2026 14:36:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm223557c88.13.2026.08.06.14.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:36:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/3] tests/tcg/hexagon: add slot-assignment tests
Date: Thu,  6 Aug 2026 14:36:39 -0700
Message-Id: <20260806213640.699905-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2OSBTYWx0ZWRfX3uZTo+sbiD/9
 17E0vmpLNCwAB+QqxvjDgvUSVZkIsdxmqYIa5JkNKl1EoI4ZARJlUwGf2sWCc8VN74+DVjIZyTH
 uOeeLGCiWrWGjG0X/J53vw0hAPhq2zU=
X-Authority-Analysis: v=2.4 cv=PK0/P/qC c=1 sm=1 tr=0 ts=6a74fe75 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=r_I9Sa7bfjC0UZVyMegA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2OSBTYWx0ZWRfX6WqrhEvUwPlx
 3l+pFboC5whx4Sk4+KU5mXNLNX37T1Bn3QpsH5cWpMW0l0OA7JoazfjBweFiAJu9C2iXM02f1Ds
 d6IMuvyiJyBsQuFac4hqYbGKHHJsoGORmODXcQb8keOrOpSaqsQRe3i3YE5ptp1JuMZW03hvmCk
 nd3pss3V1oJRjsmXmgpRFXb/R1kOWdaI24m0a92cdqI7ux2AldwpAiLchR7SOU1d2G6YPeZKJD3
 DHbxMovO5X5QkiI1nCx5s9ZkHYdQ92ube+As34vviaO88M8SDEFrpyGcFSahyqL1kfCtl9v0suO
 HEV72IUSLPUBqxF3qMEJC6Z1miNXpARcI2+7j6eDKbaygoS8ly2ilBBc6ME7io5LKWvGmVe+806
 ePWR6dshT6aHyKxuzQe1C1We9jN/2zKrnCyOBfZkfuZpgnuHXNUHPsdqIk8C+s0sUZAPQvqRHaI
 NdjlIcj99W8tjNruRAw==
X-Proofpoint-GUID: DyeHmhDg0Zvz528igDITtALGtZJVnEmw
X-Proofpoint-ORIG-GUID: DyeHmhDg0Zvz528igDITtALGtZJVnEmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_03,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060169
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

dmFsaWQtc2xvdHM6IHBhY2tldHMgdGhhdCBsZWdhbGx5IHNoYXJlIGEgc2xvdCBhbmQgd2VyZSB3
cm9uZ2x5CnJlamVjdGVkIGJlZm9yZSB0aGUgZml4IChsb2FkIGFuZCB0cmFuc2ZlciwgbG9hZCBl
bmNvZGVkIGZpcnN0OwpkY3plcm9hIHBhY2tlZCBsYXN0IHdpdGggdGhyZWUgdHJhbnNmZXJzKS4K
CmludmFsaWQtc2xvdHM6IHVuYXNzaWduYWJsZSBwYWNrZXRzIHRoYXQgbXVzdCBzdGlsbCBiZSBy
ZWplY3RlZDoKc3RvcmUgKyBkdXBsZXgsIGxvYWQgKyBpbmRpcmVjdCBqdW1wLCB0aHJlZSBsb2dp
Y2FsIG9wcyBjb21wZXRpbmcgZm9yCnNsb3RzIDIgYW5kIDMsIGFuZCBmaXZlIG9wcyBmb3IgZm91
ciBzbG90cy4KClJldmlld2VkLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8bWF0aGV1
cy5iZXJuYXJkaW5vQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9pbnZh
bGlkLXNsb3RzLmMgfCA3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90
Y2cvaGV4YWdvbi92YWxpZC1zbG90cy5jICAgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysr
KwogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IHwgIDEgKwogMyBmaWxlcyBjaGFu
Z2VkLCAxMzUgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhh
Z29uL3ZhbGlkLXNsb3RzLmMKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlk
LXNsb3RzLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLXNsb3RzLmMKaW5kZXggNjA3MDI3
ZjMxNGQuLmYyZGFjZTJlNTQxIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlk
LXNsb3RzLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1zbG90cy5jCkBAIC01NSw2
ICs1NSw3NSBAQCBzdGF0aWMgaW50IHRlc3RfaW52YWxpZF9zbG90cyh2b2lkKQogICAgIHJldHVy
biBzaWc7CiB9CiAKKy8qIExvYWQgdGhlbiBpbmRpcmVjdCBqdW1wLCBsb2FkIGVuY29kZWQgZmly
c3Q6IG5vIGhpZ2ggc2xvdCBsZWZ0IGZvciBqdW1wLiAqLworc3RhdGljIGludCB0ZXN0X2ludmFs
aWRfc2xvdHNfaGlnaHNsb3Qodm9pZCkKK3sKKyAgICBpbnQgc2lnOworCisgICAgYXNtIHZvbGF0
aWxlKAorICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAg
ICJtZW13KCUxKSA9IHIxXG4iCisgICAgICAgICJyMyA9ICNtZW1cbiIKKyAgICAgICAgIi53b3Jk
IDB4OTE4MzQwMDZcbiIgLyogeyByNiA9IG1lbXcocjMrIzApOyAqLworICAgICAgICAiLndvcmQg
MHg1MjlmYzAwMFxuIiAvKiAgIGp1bXByIHIzMSB9ICAgICAgICAqLworICAgICAgICAiMTpcbiIK
KyAgICAgICAgIiUwID0gcjBcbiIKKyAgICAgICAgOiAiPXIiKHNpZykKKyAgICAgICAgOiAiciIo
JnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAicjMiLCAicjYiLCAibWVtb3J5Iik7
CisKKyAgICByZXR1cm4gc2lnOworfQorCisvKgorICogVGhyZWUgcHJlZGljYXRlLWxvZ2ljYWwg
b3BzOiBlYWNoIGlzIHJlc3RyaWN0ZWQgdG8gc2xvdHMgMiBhbmQgMywgc28gdGhlCisgKiBmb3Vy
dGgtYW5kLWZpZnRoLXNsb3QtZnJlZSBwYWNrZXQgc3RpbGwgaGFzIG9ubHkgdHdvIHNsb3RzIGZv
ciB0aHJlZSBvcHMuCisgKiBObyBjaGFuZ2Utb2YtZmxvdyBpcyBpbnZvbHZlZCwgc28gdGhlIG9u
bHkgcmVhc29uIHRvIHJlamVjdCBpdCBpcyB0aGUgc2xvdAorICogY29uZmxpY3QuCisgKi8KK3N0
YXRpYyBpbnQgdGVzdF9pbnZhbGlkX3Nsb3RzX2Nyc2xvdDIzKHZvaWQpCit7CisgICAgaW50IHNp
ZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIx
ID0gIyMxZlxuIgorICAgICAgICAibWVtdyglMSkgPSByMVxuIgorICAgICAgICAiLndvcmQgMHg2
YjAyNDEwMFxuIiAvKiB7IHAwID0gYW5kKHAxLCBwMik7ICovCisgICAgICAgICIud29yZCAweDZi
MjI0MTAzXG4iIC8qICAgcDMgPSBvcihwMSwgcDIpOyAgICovCisgICAgICAgICIud29yZCAweDZi
NDJjMzAxXG4iIC8qICAgcDEgPSB4b3IocDIsIHAzKSB9ICovCisgICAgICAgICIxOlxuIgorICAg
ICAgICAiJTAgPSByMFxuIgorICAgICAgICA6ICI9ciIoc2lnKQorICAgICAgICA6ICJyIigmcmVz
dW1lX3BjKQorICAgICAgICA6ICJyMCIsICJyMSIsICJwMCIsICJwMSIsICJwMyIsICJtZW1vcnki
KTsKKworICAgIHJldHVybiBzaWc7Cit9CisKKy8qIFRocmVlIHRyYW5zZmVycyBwbHVzIGEgZHVw
bGV4OiBmaXZlIG9wcyBmb3IgZm91ciBzbG90cy4gKi8KK3N0YXRpYyBpbnQgdGVzdF9pbnZhbGlk
X3Nsb3RzX2ZpdmUodm9pZCkKK3sKKyAgICBpbnQgc2lnOworCisgICAgYXNtIHZvbGF0aWxlKAor
ICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13
KCUxKSA9IHIxXG4iCisgICAgICAgICIud29yZCAweDc4MDA0MDIwXG4iIC8qIHsgcjAgPSAjMTsg
ICAgICAgICAgICovCisgICAgICAgICIud29yZCAweDc4MDA0MDQxXG4iIC8qICAgcjEgPSAjMjsg
ICAgICAgICAgICAqLworICAgICAgICAiLndvcmQgMHg3ODAwNDA2MlxuIiAvKiAgIHIyID0gIzM7
ICAgICAgICAgICAgKi8KKyAgICAgICAgIi53b3JkIDB4Mjg0NTI4NTZcbiIgLyogICByNSA9ICM0
OyByNiA9ICM1IH0gICovCisgICAgICAgICIxOlxuIgorICAgICAgICAiJTAgPSByMFxuIgorICAg
ICAgICA6ICI9ciIoc2lnKQorICAgICAgICA6ICJyIigmcmVzdW1lX3BjKQorICAgICAgICA6ICJy
MCIsICJyMSIsICJyMiIsICJyNSIsICJyNiIsICJtZW1vcnkiKTsKKworICAgIHJldHVybiBzaWc7
Cit9CisKIGludCBtYWluKCkKIHsKICAgICBzdHJ1Y3Qgc2lnYWN0aW9uIGFjdDsKQEAgLTY1LDYg
KzEzNCw5IEBAIGludCBtYWluKCkKICAgICBhc3NlcnQoc2lnYWN0aW9uKFNJR0lMTCwgJmFjdCwg
TlVMTCkgPT0gMCk7CiAKICAgICBhc3NlcnQodGVzdF9pbnZhbGlkX3Nsb3RzKCkgPT0gU0lHSUxM
KTsKKyAgICBhc3NlcnQodGVzdF9pbnZhbGlkX3Nsb3RzX2hpZ2hzbG90KCkgPT0gU0lHSUxMKTsK
KyAgICBhc3NlcnQodGVzdF9pbnZhbGlkX3Nsb3RzX2Nyc2xvdDIzKCkgPT0gU0lHSUxMKTsKKyAg
ICBhc3NlcnQodGVzdF9pbnZhbGlkX3Nsb3RzX2ZpdmUoKSA9PSBTSUdJTEwpOwogCiAgICAgcHV0
cygiUEFTUyIpOwogICAgIHJldHVybiBFWElUX1NVQ0NFU1M7CmRpZmYgLS1naXQgYS90ZXN0cy90
Y2cvaGV4YWdvbi92YWxpZC1zbG90cy5jIGIvdGVzdHMvdGNnL2hleGFnb24vdmFsaWQtc2xvdHMu
YwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNzBkOWIwYjZhY2YKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi92YWxpZC1zbG90cy5jCkBAIC0wLDAg
KzEsNjIgQEAKKy8qCisgKiBSZWdyZXNzaW9uIHRlc3RzIGZvciB2YWxpZCBwYWNrZXRzIHRoYXQg
cWVtdSBpbmNvcnJlY3RseSByZWplY3RlZCBhcworICogaW52YWxpZC4KKyAqCisgKiBDb3B5cmln
aHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmll
cy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKwor
I2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisKK2ludCBlcnI7CisKKyNp
bmNsdWRlICJoZXhfdGVzdC5oIgorCisvKiB2b2xhdGlsZSB0byBrZWVwIHRoZSBsb2FkIGZyb20g
YmVpbmcgb3B0aW1pemVkIGF3YXkgKi8KK3N0YXRpYyB2b2xhdGlsZSBpbnQgYnVmWzJdID0geyAw
eDEyMzQsIDAgfTsKKworLyogTG9hZCBhbmQgcmVnaXN0ZXIgdHJhbnNmZXIgaW4gb25lIHBhY2tl
dCwgbG9hZCBlbmNvZGVkIGZpcnN0LiAqLworc3RhdGljIGludDMyX3QgbG9hZF9pbW1fcGFpcih2
b2lkKQoreworICAgIGludDMyX3Qgb3V0OworICAgIC8qIHsgcjYgPSBtZW13KHIzKyMtNCk7IHI3
ID0gIzB4NGFlNiB9ICovCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAieyByMyA9ICUxIH1c
blx0IgorICAgICAgICAiLndvcmQgMHg5NzgzN2ZlNlxuXHQiCisgICAgICAgICIud29yZCAweDc4
NDVkY2M3XG5cdCIKKyAgICAgICAgInsgJTAgPSByNiB9XG5cdCIKKyAgICAgICAgOiAiPXIiKG91
dCkgOiAiciIoJmJ1ZlsxXSkgOiAicjMiLCAicjYiLCAicjciKTsKKyAgICByZXR1cm4gb3V0Owor
fQorCitzdGF0aWMgaW50MzJfdCBkY2J1Zls4XSBfX2F0dHJpYnV0ZV9fKChhbGlnbmVkKDMyKSkp
OworCisvKiBTbG90LTAtb25seSBvcCAoZGN6ZXJvYSkgcGFja2VkIGxhc3Qgd2l0aCB0aHJlZSB0
cmFuc2ZlcnMuICovCitzdGF0aWMgdm9pZCBzbG90MF9yZXN0cmljdGVkKGludDMyX3QgKm91dCkK
K3sKKyAgICBhc20gdm9sYXRpbGUoCisgICAgICAgICJ7ICUwID0gIzB4MTFcblx0IgorICAgICAg
ICAiICAlMSA9ICMweDIyXG5cdCIKKyAgICAgICAgIiAgJTIgPSAjMHgzM1xuXHQiCisgICAgICAg
ICIgIGRjemVyb2EoJTMpIH1cblx0IgorICAgICAgICA6ICI9ciIob3V0WzBdKSwgIj1yIihvdXRb
MV0pLCAiPXIiKG91dFsyXSkKKyAgICAgICAgOiAiciIoZGNidWYpIDogIm1lbW9yeSIpOworfQor
CitpbnQgbWFpbigpCit7CisgICAgaW50MzJfdCByWzNdOworCisgICAgY2hlY2szMihsb2FkX2lt
bV9wYWlyKCksIDB4MTIzNCk7CisKKyAgICBkY2J1ZlswXSA9IDB4NWE1YTVhNWE7CisgICAgc2xv
dDBfcmVzdHJpY3RlZChyKTsKKyAgICBjaGVjazMyKHJbMF0sIDB4MTEpOworICAgIGNoZWNrMzIo
clsxXSwgMHgyMik7CisgICAgY2hlY2szMihyWzJdLCAweDMzKTsKKyAgICBjaGVjazMyKGRjYnVm
WzBdLCAwKTsgICAgICAgLyogZGN6ZXJvYSBjbGVhcmVkIHRoZSBsaW5lICovCisKKyAgICBwdXRz
KGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBh
L3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCBiL3Rlc3RzL3RjZy9oZXhhZ29uL01h
a2VmaWxlLnRhcmdldAppbmRleCBhMmEwZmZjNjliMi4uODBlNTZmN2QwNTUgMTAwNjQ0Ci0tLSBh
L3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldAorKysgYi90ZXN0cy90Y2cvaGV4YWdv
bi9NYWtlZmlsZS50YXJnZXQKQEAgLTUxLDYgKzUxLDcgQEAgSEVYX1RFU1RTICs9IHNjYXR0ZXJf
Z2F0aGVyCiBIRVhfVEVTVFMgKz0gaHZ4X21pc2MKIEhFWF9URVNUUyArPSBodnhfaGlzdG9ncmFt
CiBIRVhfVEVTVFMgKz0gaW52YWxpZC1zbG90cworSEVYX1RFU1RTICs9IHZhbGlkLXNsb3RzCiBI
RVhfVEVTVFMgKz0gaW52YWxpZC1lbmNvZGluZwogSEVYX1RFU1RTICs9IG11bHRpcGxlLXdyaXRl
cwogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9wYwotLSAKMi4zNC4xCgo=

