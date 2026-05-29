Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB23CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CQ-00062x-4e; Fri, 29 May 2026 17:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CO-0005uV-3r
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:57:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CM-0000ZC-FP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Non1912358
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IrBCoWHRNxXkyP6r0ijMh9ho7/K8FLW28OO7q04R734=; b=aZpurTNeDLBpdXVJ
 hlkaoi7urFc5dxoDpvGZFwcpIEbzwEGa7GkpgrBvXn3RZbToS0KVxrl9hmx06l9U
 iIPWdsdbNTevemMMrnq76X6BaQw6IPo4sLZLEDI32SyahJqqFxtgkvvJTqa3yXS8
 6i/RA+9kj8qgbD7SizykZeIE6XCsV0gH4ycWLDjwktksw1asbBMx0e46+9GiEpBK
 4T3bO1nv7ZTT0LzNxDQ1sLP4qC0r2MAKLkrtM8NhrxrIvdcxJIIdCCnkQtL2e6pU
 +CCnbgjrlJsv69Hge895s8tPJOaX+bclx/JiYu0bStvP70FPOp022VVaaSWj0ehj
 3VfRQA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu52gkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5135709eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091816; x=1780696616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrBCoWHRNxXkyP6r0ijMh9ho7/K8FLW28OO7q04R734=;
 b=atb6zhP/SmkRlVY5BVptgYJ3BhMWru7aAJTWW4ANePdiwM5FcUhtLDt2QZ/ySp/hzu
 f7TJtncFJqK1k0vAIInAc1DmRKant7nqyTTpdZh/GzdJP5GmDENSbrKs/Faf8411Yymj
 ktaAE6i3jk+EKLIdoipfULij03yruB0gKjRNQJAIYm3XNntFIzJn6Fe7thiJYSm9LiJ4
 PZzccaJ9sWtwJJJGJ18Tn7KqvCCIaYfc9PH0rcLhq5CvB7jmm2MrW0YbQkqHqUJ7Grt1
 7vrDpHA3/S2VxxFDIeA5z6+OUrFzOvZkcvY85JRh5kY5YFbpp8J3uw+fDfdQr8zqHOat
 CM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091816; x=1780696616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IrBCoWHRNxXkyP6r0ijMh9ho7/K8FLW28OO7q04R734=;
 b=HhRMrLzcszoZqj/gqAEfLLvjByah7JblELU6y0AZk5ssMxsuT36TwIBFCAU1GwkP5S
 GpPBEHEh322d09nXObi5jueAnhnNugYzOUL+PlgrrHcY7JI/zTYIq+vRSRhyTzpqirxi
 RzkNChPKbjYfN8TncmGh/ZsoORyHx4dlFTjcV0wLrHuwNkn/KDyWHpkukSKQ5AKpV/45
 aF+dpFz0a4SP3xFrn1rVVqf/bedOVVutolPz6uGMHVQzOLaMgBJykQT/ZyQE3O3qItA/
 C+03UHgkZDkQGbsIZnStk1R4TSvSeLWw9BC711IAx9Dwvaskvpx2ec8vycuKFQAvN/D7
 SFYA==
X-Gm-Message-State: AOJu0YwDfWMwkElCe00aEWebnMT8PbzhxX7GXYiCT3rRaAlLivfgSIHd
 X3814XA4f/pvsCp3JR3u9OHxaaxDfEYwM46QauIzQhTysJ7rRYGuGXkTn8s7TxPGL8ARZEPlXgI
 lg0POQ8Dutr7rjFRA/znLKW+2NKm2FOHpdNzwG4TQrhGgbjrtTKdJUocpwwQYTUJU2w==
X-Gm-Gg: Acq92OFG7rgwkG/bPFRBevPz42sdyJpN+8MsGnUM56FCJiUH/rkTuJFGENajHL34mFM
 kD5xl2qOXowclmYvjlQKCBxQGGtuz5akjmEazLJ7OVh75jA4t4/8Jk1lMp8IR9AethYV3EpVJbe
 dmYV3bbmWISGKcHeUULO+1UcVrvXnK1D8xhOYB+dew/bIDNUZCqsgGy9f6R11cfDfP2vCgZz9ww
 hIg3LA/4zfShrXZFsLO7nOJjq7RZrntD4gTQ8X2kQEQwdFaEnVvL09C3daN2Jbg9bXPC3e93UYm
 aGiUOXu9PEiU0WuBMLQWB0lvhRbXlEiOkUABPJE8iQhQZIUzPTr9reYFGHPPA1S9gzsHLQKjR8F
 9zANdl+E9iheC7NJx/UDPgJn205t7SZF5QmvuERFyYqoJQcLbiXEa11VNq/6QAG+j37PfhbMFGV
 +2Hcr4
X-Received: by 2002:a05:7300:80c6:b0:304:df8b:71ee with SMTP id
 5a478bee46e88-304fa49ce36mr811044eec.7.1780091816350; 
 Fri, 29 May 2026 14:56:56 -0700 (PDT)
X-Received: by 2002:a05:7300:80c6:b0:304:df8b:71ee with SMTP id
 5a478bee46e88-304fa49ce36mr811024eec.7.1780091815812; 
 Fri, 29 May 2026 14:56:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v7 35/38] target/hexagon: Define MMU_INDEX TB_FLAGS field
Date: Fri, 29 May 2026 14:55:51 -0700
Message-Id: <20260529215554.606133-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a1a0ba9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pqn84ZIC0LxmOLqsUA4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: eiu2BjjeCd1TUKnWhpvAtYBncMkLvKLc
X-Proofpoint-ORIG-GUID: eiu2BjjeCd1TUKnWhpvAtYBncMkLvKLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXzIrwR9uOkGMF
 7OOFjlq6Y8aZLMSe4jzQsMoJimhrW02CpxZ0/uSIz+qQoO7rPiFqAFrP1gQs2/tnjrJugN7Ed3t
 QcdUQtc2uFM9QYnWfoOlDK0UFM+4brmtxbo1Hg4102qqFJzWLyOdHWex+M3cbYkCypqYL4ccfSl
 cdPjxvh3/Vvg69jAMyfnNDK2LYSfeEKZ5F7ZgoKti37uFZRoby/SORzFYyRyo5W/oQAlNmS9MOH
 B5iydYMrjPEuLQkRUeyif22SFp8AI/Qg8+BWhvGISl3RHSAtxWVrBrYiFT9Z/ZN1+Abzh1SaWxu
 m++uB6LWNq0Usb48CLtCL0WGlTJ8chP4Z6kMKeCrizY84CLCQzDWn08b1S5dnRqBFLp9GmfJUMK
 EFj1O1J8gyKHzXraa3/PFx14eNii0lx9zhIEo+nFOJFSEZYhxYXGc1J/i0ao88Q52+IY7JjJCC+
 KT5QA+0MF4ZtUXztTjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RGVjbGFyZSB0aGUgTU1VX0lOREVYIGZpZWxkIGluIFRCX0ZMQUdTIGFuZCB1c2UgaXQgdG8gZXh0
cmFjdAp0aGUgbW11IGluZGV4IGluIHRyYW5zbGF0ZS5jIGluaXRpYWxpemF0aW9uLgoKU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL2NwdS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUu
aAppbmRleCA1NWRhZGIzYjk2NC4uN2JhMWQzMDQ3ZGYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0xODMsNiArMTgzLDcgQEAg
c3RydWN0IEFyY2hDUFUgewogI2luY2x1ZGUgImNwdV9iaXRzLmgiCiAKIEZJRUxEKFRCX0ZMQUdT
LCBJU19USUdIVF9MT09QLCAwLCAxKQorRklFTEQoVEJfRkxBR1MsIE1NVV9JTkRFWCwgMSwgMykK
IEZJRUxEKFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwgNCwgMSkKIAogR19OT1JFVFVSTiB2b2lk
IGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNs
YXRlLmMKaW5kZXggZWQ5NmQ5YTY2YjMuLmNlNWJiZTkyZDVkIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAt
OTg4LDcgKzk4OCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0
KERpc2FzQ29udGV4dEJhc2UgKmRjYmFzZSwKICAgICBIZXhhZ29uQ1BVICpoZXhfY3B1ID0gZW52
X2FyY2hjcHUoY3B1X2VudihjcykpOwogICAgIHVpbnQzMl90IGhleF9mbGFncyA9IGRjYmFzZS0+
dGItPmZsYWdzOwogCi0gICAgY3R4LT5tZW1faWR4ID0gTU1VX1VTRVJfSURYOworICAgIGN0eC0+
bWVtX2lkeCA9IEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYKTsKICAg
ICBjdHgtPm51bV9wYWNrZXRzID0gMDsKICAgICBjdHgtPm51bV9pbnNucyA9IDA7CiAgICAgY3R4
LT5udW1faHZ4X2luc25zID0gMDsKLS0gCjIuMzQuMQoK

