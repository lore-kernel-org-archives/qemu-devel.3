Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E1FC4450F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4nO-0002pe-1u; Wed, 15 Jul 2026 14:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4nM-0002my-Gz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4nI-00062I-6m
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHHXkU162048
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5DhB+JUpGXlk6IHlyqJjGIVrJdBRqCbw090T+V0vsho=; b=PFp3nUa2ihgoNZar
 2IN6n8fiK6j8el/V1xO29kx23NCjC1tryP6noK+d2XaOyfIxqVNWd5aQNKoyDRXm
 RS1BYyFs6uB62PohGFeysHbJvxD4uQnJ+qwgAKtSU+sTtQqMy8ogie9ek21ral+u
 WkIVae1aS2CzkcHhWnlKXaeYw37PIh0FoTe3DQD/7hBV+1oBaCQAZCzToELqecXt
 Rf7QLxSNKGXYgbSgbBhx8lt0IRDWAVztQ7KdEK9xqucnHhuVJZicyWn4ON0yFPeO
 yA4xxZb+DA9ostZKF4K5ezA8A8eQK6gM61yqUXXAUTcuH2jN4IZ7QPKBBu7+7vtv
 bQAvhQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqgck8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37fca5f21b1so990672a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784141836; x=1784746636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5DhB+JUpGXlk6IHlyqJjGIVrJdBRqCbw090T+V0vsho=;
 b=EwX/4BBfMfZNgAcjV6yr5NxhQ9jWbhsEfsnFmfa9O16lmYcHWeQFVsdH04TheBG864
 Do5AHmiMFBWuxCRQA36ITCyV4N9dl7xGcLs4f5lf0Mncbt0sWxxVAEKLb6UMCcE1jFQY
 hAAHX9GkFGUDeBQCvih6Bd+7WT7rJlYLW6NT256klW+YT1QKpFI1faId6IJsq9FPLIFP
 ZmKd178SlHgILC85acbguyG2SlBYqL7OrAPfEtRmKV7J4N6gzjiv5sfo34AFGLVRxVEW
 cj6ThvIE5NRabffOCJzmz7dXB5s3eVdhNLJbPLzMxUYk/MkiqT7AfDDHS3KEFpf52JRx
 sCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784141836; x=1784746636;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5DhB+JUpGXlk6IHlyqJjGIVrJdBRqCbw090T+V0vsho=;
 b=sDWOGije+jKlC8zLqZkmCIsa1YIRRBc9j4+MCdoWvguV9YoXBKq+adH98KDJwLlLLb
 EtvavHmYQ4rJmSyRWQhrxy19/5zz4aZmRe6nEZRMvf5TdXhTEVGoi5RfQgmwiz+10Bo4
 CRhuXp2O7OjKej9W40X0Iyv2bk1w1hBPwuVofiMVUpSLH5MryqqkVkZHB5dnnw8hsTZ2
 bCWLhGIuVlVw7qcerE9DtKBq42Jovjvnp4lV7AJJKhhoNoMjZyqt5N2hQdqOXWH/sSQf
 ruAlmS2rsBhHkZiwK/CsLAD2CxK5G/6plLtIhdoSeWD7R7B9kNTXRCtJzRwzhKvrGT4w
 MRPQ==
X-Gm-Message-State: AOJu0YzY4cUyiAGFlvSCr4RLWNLzIUun0x5pB2QzB8EhvdIH1PolouWz
 s/LOsZcKmxCGqCUnAKbsyh9AfYWFuLZ5K4IPdetNpW8zyBwxphuuDaLe2wXx/qe8k7eijop4cUw
 i8aqi5jgPnj/Qz4sk2DkVBrp3Xn4b+DUxWXiHZoxr4Ne5J39wj5TrkvQfjN+vXBly8Q==
X-Gm-Gg: AfdE7cmSGg9asdrD44qEp/FgsUnFsd5M2MOivn3PKSSoMiGmPO7f+P6j8zlA/Th2QD2
 Oz7nSgSNk4Daol875JBbGHhIdlYhB/n/jl4jCTCKlpOPZkcBDGEKHi01p7PP40SJe6ydTetv46u
 9OoBoYw4NvbCFoZrEGa7PxZQWsjDqTZL+EXzm/Ws1XAGQ1kbiATolZSIWhxKqV0Mq/F8DNM9ovH
 jQUuUjh1s7+teqzpK8oL/GXj92u/u7bQdUvnPPlHt7+On+cz7Khk7luZ747wgl4y46wRUNcwLQ2
 nm07EJ9Ip+daqR4I28s5vO12mEKlyCV20TFpKrL5PE0HqvyYQPTJhFBgEDMeOfoaITFwwvV/Re5
 304OpnTnNRXJK9ir6sxn8cLSjpDDe1BFjuEI7LkIUXhVIOtwJfT6K4cAgDwk=
X-Received: by 2002:a17:90b:5843:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-38e38166016mr490660a91.10.1784141836148; 
 Wed, 15 Jul 2026 11:57:16 -0700 (PDT)
X-Received: by 2002:a17:90b:5843:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-38e38166016mr490605a91.10.1784141835225; 
 Wed, 15 Jul 2026 11:57:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c2b17sm5469546eec.25.2026.07.15.11.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:57:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 7/7] tests/functional/hexagon: add arch_tests functional
 test
Date: Wed, 15 Jul 2026 11:57:01 -0700
Message-Id: <20260715185701.1287176-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a57d80d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=vy0UrYlPH36GBmUselQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX5Z5ZaJDcBstq
 xvcneei1RQtHRGGHqTkcyp+9Z6OveKcg2S2qr0PBYPyh5Hm3dsb9JdCCQSVgyOEHp3VPg0Ab7K6
 GBBCNbXtFmdqXOL5/aSuZhteZrVMaVI=
X-Proofpoint-ORIG-GUID: pBdOQ_2MLQh_cb7FhGOFEl1QDyAiwfnm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX1zJlegtC/p9f
 2NcoqgypDTWGDoj/c8m2YkTZryXlWcCoMFvHv9canAk1eZrxvGFsxj/rdngylDk7DnPz0YH6+oc
 HbwUVzw18XRtg/9z5gk4EHZjCNIeLY7ocsdLqwzMYfwNPTlDbuDhPVy0NmSK2I6jGmzZC/tKs55
 R0/xzxRWnmWJne3j3EgZ1ZMb+XE/yXPww+tXCJ4sBpGf8kJrW1QWDypgmfeoDVQ8tMISExwOdBv
 qzPEy85xqaALJTMMavzt0Sm7yU1NZhAXlmc/Se1jHFRLtlCNogNjCmQ17VS8eVZ1CMsaySdv1in
 N6O0jJNy79XgcDUxDbuvM0i/0MTD0CueNqCjC28LGbmC9UrWiriL08+JAN5ZBCHET6d2j7ZCOU/
 MFv+CuZAqsaVCgv31ZrXwnxLFo0raxfyFTcF/b8A8FnPO1a67OjJTR/rDTUfz39pZKOBsZxjiTZ
 HvjMSZMfCgp7Q6QJkTw==
X-Proofpoint-GUID: pBdOQ_2MLQh_cb7FhGOFEl1QDyAiwfnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150188
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

QWRkIG5ldyB0ZXN0IGNhc2VzIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzIHRvIGV4ZXJjaXNlIGV4
Y2VwdGlvbnMsCmd1ZXN0IG1vZGUsIGludGVycnVwdCBzdGVlcmluZywgZXRjLgoKUmV2aWV3ZWQt
Ynk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgIHwgIDUgKysKIHRlc3Rz
L2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCA2MyArKysrKysrKysrKysr
KysrKysrKysKIHRlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgfCAg
MSArCiA0IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CgpkaWZmIC0tZ2l0
IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCBiNzAxMmU5NDVlMi4uYjk2ZDhmNDNm
ZmYgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xMzYxLDYg
KzEzNjEsNyBAQCBGOiBody9oZXhhZ29uLwogRjogaW5jbHVkZS9ody9oZXhhZ29uLwogRjogY29u
Zmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawogRjogZG9jcy9zeXN0ZW0v
aGV4YWdvbi8KK0Y6IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi8KIEY6IGRvY3MvZGV2ZWwvaGV4
YWdvbi1zeXMucnN0CiAKIExvb25nQXJjaCBNYWNoaW5lcwpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21l
c29uLmJ1aWxkCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4yYjVhMWE4
ZjI2NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5i
dWlsZApAQCAtMCwwICsxLDUgQEAKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIKKwordGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCisgICdhcmNoX3Rl
c3RzJywKK10KZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hf
dGVzdHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5Cm5l
dyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwLi4yYmIzNGY5YjhkYwotLS0gL2Rl
di9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkK
QEAgLTAsMCArMSw2MyBAQAorIyEvdXNyL2Jpbi9lbnYgcHl0aG9uMworIworIyBDb3B5cmlnaHQg
KGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4K
KyMKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworZnJvbSBx
ZW11X3Rlc3QgaW1wb3J0IFFlbXVTeXN0ZW1UZXN0LCBBc3NldAorZnJvbSBxZW11X3Rlc3QuY21k
IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4KKworCitjbGFzcyBBcmNoVGVzdHNVYXJ0
KFFlbXVTeXN0ZW1UZXN0KToKKyAgICAiIiIKKyAgICBIZXhhZ29uIGFyY2hpdGVjdHVyZSB2ZXJp
ZmljYXRpb24gdGVzdHMKKworICAgIFRoZXNlIGFyZSBiYXJlLW1ldGFsIHRlc3RzIGZyb20gaGV4
YWdvbi1hcmNoLXRlc3RzIHRoYXQgZXhlcmNpc2UKKyAgICBzeXN0ZW0gZnVuY3Rpb25hbGl0eS4K
KworICAgIFRlc3RzIG91dHB1dCByZXN1bHRzIHZpYSBVQVJULgorICAgICIiIgorICAgIHRpbWVv
dXQgPSA2MAorCisgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAorICAgICAgICAiaHR0cHM6Ly9n
aXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzLyIKKyAgICAg
ICAgImRvd25sb2FkL3YwLjIuNS9hcmNoX3Rlc3RzX3VhcnQudGFyLmd6IiwKKyAgICAgICAgImVk
YjRmMzdiODc3YTNhNzJhMGUxMDkyMDQ3NzQ1OGE0M2I0MDA0NWQzNDM5OGZlZThjYjc2M2ZlZmQz
NDJmNGYiLAorICAgICkKKworICAgIGRlZiBydW5fdWFydF90ZXN0KHNlbGYsIHRlc3RfbmFtZTog
c3RyLAorICAgICAgICAgICAgICAgICAgICAgIG1hY2hpbmU6IHN0ciA9ICJ2aXJ0IikgLT4gTm9u
ZToKKyAgICAgICAgIiIiCisgICAgICAgIFJ1biBhbiBhcmNoIHRlc3QgYmluYXJ5IGFuZCB2ZXJp
ZnkgUEFTUyB2aWEgVUFSVCBjb25zb2xlIG91dHB1dC4KKyAgICAgICAgIiIiCisgICAgICAgIHNl
bGYuc2V0X21hY2hpbmUobWFjaGluZSkKKyAgICAgICAgc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2Vs
Zi5BU1NFVF9UQVJCQUxMKQorICAgICAgICB0YXJnZXRfYmluID0gc2VsZi5zY3JhdGNoX2ZpbGUo
J2FyY2hfdGVzdHNfdWFydF9wYWNrYWdlJywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJ2JpbicsIHRlc3RfbmFtZSkKKyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZSgp
CisgICAgICAgIHNlbGYuc2V0X3ZtX2FyZygiLWRpc3BsYXkiLCAibm9uZSIpCisgICAgICAgIHNl
bGYuc2V0X3ZtX2FyZygiLWtlcm5lbCIsIHRhcmdldF9iaW4pCisgICAgICAgIHNlbGYudm0ubGF1
bmNoKCkKKyAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsICJQQVNTIikKKwor
ICAgIGRlZiB0ZXN0X2V4Y2VwdGlvbnMoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMg
ZXhjZXB0aW9uIGRlbGl2ZXJ5IGZvciB0cmFwIGluc3RydWN0aW9ucywgcHJpdmlsZWdlCisgICAg
ICAgIHZpb2xhdGlvbnMsIGFuZCB2ZXJpZmllcyBTU1IgY2F1c2UgY29kZXMgYW5kIEVMUiB2YWx1
ZXMuCisgICAgICAgICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZXhjZXB0
aW9ucyIpCisKKyAgICBkZWYgdGVzdF9ndWVzdF9tb2RlKHNlbGYpIC0+IE5vbmU6CisgICAgICAg
ICIiIlRlc3RzIGd1ZXN0IG1vZGUgZW50cnkvZXhpdCB2aWEgQ0NSIGNvbmZpZ3VyYXRpb24sIHZl
cmlmeWluZworICAgICAgICBHU1IgZmllbGRzLCBHRUxSLCBhbmQgZ3Vlc3QgZXZlbnQgdmVjdG9y
IHRhYmxlIGRpc3BhdGNoLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0
KCJ0ZXN0X2d1ZXN0X21vZGUiKQorCisgICAgZGVmIHRlc3RfaW50X3N0ZWVyaW5nKHNlbGYpIC0+
IE5vbmU6CisgICAgICAgICIiIlRlc3RzIGludGVycnVwdCBzdGVlcmluZyB2aWEgcHJpb3JpdHkt
YmFzZWQgcm91dGluZyB0bworICAgICAgICBzcGVjaWZpYyB0aHJlYWRzIHVzaW5nIFNUSUQgcHJp
b3JpdHkgYW5kIGlhc3NpZ253LgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90
ZXN0KCJ0ZXN0X2ludF9zdGVlcmluZyIpCisKKworaWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoK
KyAgICBRZW11U3lzdGVtVGVzdC5tYWluKCkKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwv
bWVzb24uYnVpbGQgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkCmluZGV4IGMxNTgxOTdj
NGI3Li5jNzM2MmRkMDBlZiAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWls
ZAorKysgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkCkBAIC0xNCw2ICsxNCw3IEBAIHN1
YmRpcignYWFyY2g2NCcpCiBzdWJkaXIoJ2FscGhhJykKIHN1YmRpcignYXJtJykKIHN1YmRpcign
YXZyJykKK3N1YmRpcignaGV4YWdvbicpCiBzdWJkaXIoJ2hwcGEnKQogc3ViZGlyKCdpMzg2JykK
IHN1YmRpcignbG9vbmdhcmNoNjQnKQotLSAKMi4zNC4xCgo=

