Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE3C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphx-0002vn-JF; Thu, 06 Aug 2026 00:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphq-0002sc-UP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphp-0003E8-A8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763wWwT775106
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=z+6qeAlJOKKWo1FncvQKP0fGn79PFWfQcGh4oQBRHxU=; b=nJ
 RX+yuLbXfHKRDrji1s/0G1WA52O+NKOImNJ+zgO4aL4XFNGZBC0VjSSomjX7L0Ji
 Ty9HONDehor04p0JrREbUpn6LmPyg6NhkccEsgGgy14Fp+SNqKmvLjpkiJveWE5W
 gQthVdkAglX5wQTotROEjbvfHG6/Rhmj6SCOqYcpUouDx6L384ffmiLIOcSDx28i
 wQRCFwYGUqKn/KssSGC2XATgoUq+7sUU13T9OXhAP0OID+RzPQDutpXcj6YGeijK
 NfuxktMfPQN95JDb8VXApkQ2hogCqR4tHbdZFf5Mhk7BWR82zyWw10ZaYak2fIur
 2CJ0h5bN08FPgve8l9Zg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8g351-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so2384643a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990463; x=1786595263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z+6qeAlJOKKWo1FncvQKP0fGn79PFWfQcGh4oQBRHxU=;
 b=YawNxIewF4JPAAmXQojClnsdSaKW4tOOtbIs0PbLZRR3h5nrSnWDEZw6gXNjUyMQ8R
 Q02I0Pe87/O9kET96i2kYUor8GPH0/0KyLWJEO9s0zMxf5fen1cF/CIKMMXCzHFIlsJf
 HnH1H/8xovF5jZlFu/MkwIAWx2LyldOm7xCTrKg3JOJtRGa96yqLmkegNCr7shrXNk3W
 MwQQAABZY8TCRImFa3Xw+nIa3E5T+WV2fGZzBNeuCNm6xgFL851luMScUpQKz9LQm4pD
 c7fK8AIS0GzH+cvkCyLuv8D+2VvVtAk82XqERQCvfYt7D31rYoO2mHZAXzzYh6DjdWNA
 Oupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990463; x=1786595263;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+6qeAlJOKKWo1FncvQKP0fGn79PFWfQcGh4oQBRHxU=;
 b=AnZIO4afpVQXU9L7IC7RhVziD0Sq3bZ/wIIXyOq/9WISL29HMv8rbzWLX65UZbtZzJ
 kwu/hsy/DkN+z9OMVcfFbWkokVdAhdnX1Zmyr9SAcS5Nft7ZQ3yUQUXvjUrEUBfpjZr5
 x9pcl8WnEKXbAzk4+As+JuHOIGhyCJS1vHzaZhIivNycWnwex9gT0xz+gvtBn9mdQTFn
 pnz31vKkWhh5y69Pfce9DCycYipfr6ePSpqTUaATzJYv5NYH+fy2+nO/Kgf5DUs4m8Hv
 UMFDJ+PQ6heTdR6LdFiSnih6VJaAZ4RlZrnueyVBUCd8LtfWc3RPyADWn2TmFA7V78Kl
 iQaQ==
X-Gm-Message-State: AOJu0Yzc3AQCy/Rq6CC5uWU7tEGk+klRoK+Haxzu3ly+SJrGUiWyUH4j
 cAoCaikQH3kE0HpjFAHr6uOvT1FHnji19R82kc/HhjHVFfF+g5V9kaZvZznEJW1/QHqtfl5/pSk
 01Ig+axq4/y5n/RMceFASxD0Pqp4yH/+0pNhILKvLfueBegaFtUwAOS3ug8PmbZnikg==
X-Gm-Gg: AR+sD13h0Fp4k5jHuSESigmWUshbHFOVqomryJ/VZV8+BegIvMz3SCe5fI8dTP1ht+E
 xz05OFrtRgaJv5MZQZHIi4JsRE35fhIdJ4hkPN4rAqY4HzIpmORoGqAe0rtmSx03b3HhnHYDerX
 qvdh3WUSOjAH7x9tYLmoMkNtdO1QFVZFu35zNHVIGJ/HSRMJ897ylZi69LHiIQ8RDfGaY5zgKKc
 Gz5qQj1976rHFMqTdT4DDcMWeNIrhRhCCheV0RcLo/dwQkFn/YWN7l+hGJmLm//vkbZTJmCN4CC
 0q+buQa0mImFCMwxnieNZSyNa8X1PSE9cB/wqjd7tG7IY4n/1+k7lPb7VgdT9npaBMReMN7d4R8
 zNB9UsALVx/bY5FDNSwljL+/uqcupzZ+peBq2RjKYLmoWjoww
X-Received: by 2002:a17:90b:1e53:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-3903c5501efmr10306231a91.3.1785990463335; 
 Wed, 05 Aug 2026 21:27:43 -0700 (PDT)
X-Received: by 2002:a17:90b:1e53:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-3903c5501efmr10306201a91.3.1785990462951; 
 Wed, 05 Aug 2026 21:27:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 12/18] hw/hexagon/virt: connect pl011 UART interrupt
Date: Wed,  5 Aug 2026 21:27:17 -0700
Message-Id: <20260806042723.3785369-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 7AivQ-CPM5FaVA62RLWOl8schOHsZANY
X-Proofpoint-ORIG-GUID: 7AivQ-CPM5FaVA62RLWOl8schOHsZANY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX1DTi9jh5hnqC
 37mIC+OII+ajE7VpWa7yihV1xFGa7vIx/mMhJNJfEynpjOOr+hFoiX3cnu1jpuQiXJnsM1UX4o/
 4tKzFzL9YMsus+siOalb3KeZSpKcQQtPAClf0bB8UCl8xQQxyvbuNQ/49fsY0NyGxiAViCnXVbm
 m+Yv3flf8FGUgzJ8NXgU1wyrUzXJL7lX98nX/1UQQVO4E88VOuOSKc+H/v1PnRj/bEE04p1V0/K
 5M1wodBcKHt7gNIOVdf9/jYpLMxFhmGD/x70PDmvT3jLUhiK9XME39xDkcfy21v/J7o1PxvtBR6
 hCpGnJhUL6X8hUmXbaCutOV/u+WDm9P0ARVrd5wqwYm2DdKL4/B1ql2FR6tBLcInDh2nNWfJ433
 y5lwurbUBbR8eiVpxjf3bX0tl1Jfbdy9JFNV0YK4sZJUy3DtY8gnIo53QWRWi+RmehoKINDAyOb
 AOZeKxekxxZqbxzqwZg==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a740d40 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Z4HElfRGeH4uGo3IGfcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX+AsLbXQzQvHB
 Tx5VZbi/COX8aU5ILeTdtiPlYTgH5KS+rVbehcx56ISNY5LhJMp7K/jVmIyzhB8YbI5/wsgx1gP
 cSzjPPL+YZhjEgbM8i4qQRFQ7hDjSdg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

V2lyZSBwbDAxMSdzIHN5c2J1cyBJUlEgaW50byBsMnZpYyBhdCBJUlEgMTUuCgpSZXZpZXdlZC1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQog
aHcvaGV4YWdvbi92aXJ0LmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5j
IGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXggZWEyMGVhM2M1MGEuLjY0ZDgzNjZkMjdkIDEwMDY0
NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtMzks
NiArMzksNyBAQCBlbnVtIHsKICAqIFZJUlRJT19JUlFfQkFTRSArIFZJUlRJT19ERVZfQ09VTlQg
LSAxCiAgKi8KIHN0YXRpYyBjb25zdCBpbnQgVklSVElPX0lSUV9CQVNFID0gMTY7CitzdGF0aWMg
Y29uc3QgaW50IFZJUlRfVUFSVDBfSVJRID0gMTU7CiAKIHN0YXRpYyBjb25zdCBNZW1NYXBFbnRy
eSBiYXNlX21lbW1hcFtdID0gewogICAgIFtWSVJUX1VBUlQwXSA9IHsgMHgxMDAwMDAwMCwgMHgw
MDAwMDIwMCB9LApAQCAtMTQzLDcgKzE0NCw3IEBAIHN0YXRpYyBpbnQzMl90IGZkdF9hZGRfY2xv
Y2tzKGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCiB9CiAKIHN0YXRpYyB2b2lk
IGZkdF9hZGRfdWFydChjb25zdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zLCBpbnQgdWFy
dCwKLSAgICAgICAgICAgICAgICAgICAgICAgICBpbnQzMl90IGNsa19waGFuZGxlKQorICAgICAg
ICAgICAgICAgICAgICAgICAgIGludDMyX3QgY2xrX3BoYW5kbGUsIGludDMyX3QgbDJ2aWNfcGhh
bmRsZSkKIHsKICAgICBjaGFyICpub2RlbmFtZTsKICAgICBod2FkZHIgYmFzZSA9IGJhc2VfbWVt
bWFwW3VhcnRdLmJhc2U7CkBAIC0xNjEsNiArMTYyLDggQEAgc3RhdGljIHZvaWQgZmR0X2FkZF91
YXJ0KGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsIGludCB1YXJ0LAogICAgIHFk
ZXZfY29ubmVjdF9jbG9ja19pbihkZXYsICJjbGsiLCB2bXMtPmFwYl9jbGspOwogICAgIHN5c2J1
c19yZWFsaXplX2FuZF91bnJlZihzLCAmZXJyb3JfZmF0YWwpOwogICAgIHN5c2J1c19tbWlvX21h
cChzLCAwLCBiYXNlKTsKKyAgICBzeXNidXNfY29ubmVjdF9pcnEocywgMCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbih2bXMtPnBhcmVudF9vYmoubDJ2aWMsIFZJUlRf
VUFSVDBfSVJRKSk7CiAKICAgICBub2RlbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL3BsMDExQCUi
IFBSSXg2NCwgYmFzZSk7CiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwgbm9kZW5h
bWUpOwpAQCAtMTY4LDYgKzE3MSw5IEBAIHN0YXRpYyB2b2lkIGZkdF9hZGRfdWFydChjb25zdCBI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zLCBpbnQgdWFydCwKICAgICAvKiBOb3RlIHRoYXQg
d2UgY2FuJ3QgdXNlIHNldHByb3Bfc3RyaW5nIGJlY2F1c2Ugb2YgdGhlIGVtYmVkZGVkIE5VTCAq
LwogICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9kZW5hbWUsICJjb21wYXRpYmxlIiwg
Y29tcGF0LCBzaXplb2YoY29tcGF0KSk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+
ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIGJhc2UsIHNpemUpOworICAgIHFlbXVfZmR0X3NldHBy
b3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgImludGVycnVwdHMiLCBWSVJUX1VBUlQwX0lSUSk7
CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0
LXBhcmVudCIsCisgICAgICAgICAgICAgICAgICAgICAgICAgIGwydmljX3BoYW5kbGUpOwogICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJjbG9ja3MiLCBjbGtf
cGhhbmRsZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsa19waGFuZGxlKTsKICAgICBx
ZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiY2xvY2stbmFtZXMiLCBjbG9ja25h
bWVzLApAQCAtMzQyLDcgKzM0OCw3IEBAIHN0YXRpYyB2b2lkIHZpcnRfaW5pdChNYWNoaW5lU3Rh
dGUgKm1zKQogCiAgICAgZmR0X2FkZF9jcHVfbm9kZXModm1zKTsKICAgICBjbGtfcGhhbmRsZSA9
IGZkdF9hZGRfY2xvY2tzKHZtcyk7Ci0gICAgZmR0X2FkZF91YXJ0KHZtcywgVklSVF9VQVJUMCwg
Y2xrX3BoYW5kbGUpOworICAgIGZkdF9hZGRfdWFydCh2bXMsIFZJUlRfVUFSVDAsIGNsa19waGFu
ZGxlLCBsMnZpY19waGFuZGxlKTsKIAogICAgIGhleGFnb25fbG9hZF9mZHQodm1zKTsKIH0KLS0g
CjIuMzQuMQoK

