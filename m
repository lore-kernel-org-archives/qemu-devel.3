Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2717BC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2UL-0007KU-3j; Wed, 12 Aug 2026 02:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UE-0007Ik-Dn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UA-0003sO-V1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62OAQ2641579
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/TPmb71nhtmwh1BntVvFun3sm2MPM4sfZPk8QztV8w=; b=Lh3OWbL+pTKT9j1n
 A5c0rWHYsfWJZ60vLCeUqkqwir725H/fKRdCSU/PaHVC2cH7eZvVVPBq9cO9X0M2
 j59XEgZaaADLah10sa0gPBysBZCo7h1OhRUSP+p+WA6c7Z/x+UpJLvycsan8Y21K
 d/JN+iWRN4nESUn0wtYJQ5hKE410u679ujF+h8dd0UQ9Uj/wk7gFZCAWUvJ7oywf
 Xh8rDEaLNySunSoBlqAslallIYy6ZDnw0LyJQHALYGBReeSxBzhY19CJdK+3g++6
 xxIj6eWrL0DW8tLItzfP9CV7muIhTcu4nSRwOwDKB2X371VfPgXEEbUu3tCUys9V
 MJ14Lw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mkscd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so905697a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516243; x=1787121043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/TPmb71nhtmwh1BntVvFun3sm2MPM4sfZPk8QztV8w=;
 b=OZSpBnq0k8k0lp17AnbBpF0vG9zKlJpCm07U/5jGaqB+8xIthOQptpIbiFiUcfaHOs
 +M1VBZ/bDJJJ3/Rm8nRK/YdxT7Ud2xzJ6PsmqHQq+2AZ/j5LeEZ59QVbgx64S4iPYf4I
 I1n7UdCU34ksThiW1lC5ufqzOSnxNs5T2KNr37sv2JurepRDxMdQVaoN35nN2B3s3ivA
 pUvd0vcyQIUvqHQXRfhF1O7c/Xu/kbKQOCQCTaz0ogeFinIzVgaTM4V5g7rf5xGfpLPD
 dXP5xhlTl3pybO+j4xdHlkds8MqWNgiEAAe+Ch9FrAgp9FP4jBg3yvCHQNFwTN12uKBx
 fAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516243; x=1787121043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/TPmb71nhtmwh1BntVvFun3sm2MPM4sfZPk8QztV8w=;
 b=rc+sGlBaw71tY4/jJboekc5G2blTQAMwLXfS72kLRcPdj1FEyBo7jyBTri0zrUCOCW
 VuRRYcj5HezMON0jt3xSoodC4ugsMb4z4/yvZbk5lrN9hZFg/yvDLsZ1Mr/G5g4ePBcc
 Nw1SMnoEaAaFRFbD9CA0iHD4Ewfg/66y3R2MmSRPCbcvzCvhsOp3SQx9IGzK7rO1F+U3
 7md63NEW6/W6SRi33AM1J2YNgk4YpayE2mvgTDYWztxIBZRtQs6DDw9aYuFN1q+YORAo
 W/WSmyMqvNOaB3RCoWc9d4nhf0GK9UFGcK4CtNmR5YHw77iIRXyxufWoTqR23M1FRqfE
 +oBg==
X-Gm-Message-State: AOJu0YwzvuNGO0arvl4PlBDDstLuRKk2xYuS6UjWvZEB5ppsmJd7vKa4
 lfMnEoaiCjaWHa4/EfV4+tSEZrlrMIdipH7Og/PaL4GvbSa+5AUHTqaPcTM3U6GZ2N6k5DsvTKR
 tV9OkAcRdgrLRdA6rQ0z8OlyFfqUr9X7LV2skk+SeGr0hO3zGeOTbTYYQhpOE2HHfWg==
X-Gm-Gg: AR+sD11oI8sW6SO1LSL2v1aa9YgzqcuOdbBvb9V4PcMgU2L5S2ZUf4/JxaW0/wlQo1f
 xM5HW+V2aJgHcfgyg4R0w8bSXxXj5oKQp+H03nC/KQIYXU6Fdy7rZEpeVDr9kfwT/0zBEpZc4gf
 rFcjv8tRCOi8eLyTkSm//1uoqPHWeWQWUxDc43yi9VveGTgbgiIBzPEr40pFE3vhd88hpxfnZbY
 /zhGzfHvUk+xc76wVtMyUDGqG7+wWriFQ/OvG5VDHw8aEJpgoE6N7hSUJLAPx26Bu5EQ/yPgrGK
 F+dbQ8BfB4RpIknt38HWJeklkITDMyB9x6iG0t78uiYHc4JocJV3HgCg2Lcqq4xexpupeSW84l0
 RXNn3jCy3E7iR2FuN0tfIv26fYHF8xHLVdMDBeP/rJXFMSoU3
X-Received: by 2002:a17:90b:3946:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3930288439dmr1033870a91.3.1786516241442; 
 Tue, 11 Aug 2026 23:30:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3946:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3930288439dmr1033843a91.3.1786516240906; 
 Tue, 11 Aug 2026 23:30:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/41] tests/tcg/hexagon: add HVX test for V6_vsubwsat
 saturation
Date: Tue, 11 Aug 2026 23:29:15 -0700
Message-Id: <20260812062932.543840-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: eFvKDOI1IBMNcC6pgT_xwWKUZd-rrGDF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX951DPTFzbdj3
 TtwT51bIWszgQ6xTJDSzHGxoZWZmpXF8XEAkszjBv2BGe1pi+x+whhkL/QKv0Fjbiq6kjhkZDq6
 ZkLySCmoNLmnWIMdSeQeSCuV2qPLSYRzxsYQ2se6+fDrvIVU5C0mTGo0pm9s64Z3P26Z753L49H
 3AwXkxsVVEqv+ymR7G3LdeVFbMfAd3EucKTUrdUNWqhy/WfLHKptdH6HOWBz3LFImZqUKQNV/AT
 DDwCLN2qk6fwHZE0z2ChfzscKciSgv2jhHy/sr1wkxhGKBEzVee/2gAwPupU9LXJ5WlhKUBn8Bq
 CO/BXIMdK+AxScl1OmUCisH1jrTUqp2rNROyAojSOs1YUH6W04ISAks0RzwvjpYfRwZqsXlRj3S
 SIfX16PmqhtsqAa28CoPA1AaqCs1w/xX7r+w6s2rlBPxaYlKhcyYd2ExsLfgtKfpAitI8n/q/dL
 l3gPxmLOcSvH2K4B7yg==
X-Proofpoint-ORIG-GUID: eFvKDOI1IBMNcC6pgT_xwWKUZd-rrGDF
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7c1314 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KziaR8soUeEz0EukW7EA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX7uek+1SkgV8J
 nlXZC8lH9PNKPDwuCrZ5yubPl1mOX49pKpToazGiwmfgI90cYx5u/T61sja8r8Y6ypmEXn1OoU4
 WBldVIHDqr2yWmGjy5GBFyFp85D4jrk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120049
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDgw
NzE1MjI0MS4xNTc2MzM0LTctYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90
Y2cvaGV4YWdvbi9odnhfbWlzYy5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5j
CmluZGV4IDkwYzM3MzNkYTA3Li42NDFjZmY1OWFiYSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hl
eGFnb24vaHZ4X21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCkBAIC0y
MCw2ICsyMCw4IEBACiAjaW5jbHVkZSA8c3RkYm9vbC5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgog
I2luY2x1ZGUgPGxpbWl0cy5oPgorI2luY2x1ZGUgPGhleGFnb25fdHlwZXMuaD4KKyNpbmNsdWRl
IDxodnhfaGV4YWdvbl9wcm90b3MuaD4KIAogaW50IGVycjsKIApAQCAtMzg2LDYgKzM4OCw0NyBA
QCBzdGF0aWMgdm9pZCB0ZXN0X3ZzdWJ1d3NhdF9kdih2b2lkKQogICAgIGNoZWNrX291dHB1dF93
KF9fTElORV9fLCAyKTsKIH0KIAorc3RhdGljIHZvaWQgdGVzdF92c3Vid3NhdCh2b2lkKQorewor
ICAgIGNvbnN0IGludDMyX3QgeDAgPSBJTlQzMl9NSU47CisgICAgY29uc3QgaW50MzJfdCB5MCA9
IDE7CisgICAgY29uc3QgaW50MzJfdCB4MSA9IElOVDMyX01BWDsKKyAgICBjb25zdCBpbnQzMl90
IHkxID0gLTE7CisgICAgSFZYX1ZlY3RvciB2MDsKKyAgICBIVlhfVmVjdG9yIHYxOworICAgIEhW
WF9WZWN0b3IgdnJlczsKKworICAgIC8qIElOVDMyX01JTiAtIDEgdW5kZXJmbG93cyBhbmQgbXVz
dCBzYXR1cmF0ZSB0byBJTlQzMl9NSU4gKi8KKyAgICBtZW1zZXQoZXhwZWN0LCAweDEyLCBzaXpl
b2YoTU1WZWN0b3IpKTsKKyAgICBtZW1zZXQob3V0cHV0LCAweDM0LCBzaXplb2YoTU1WZWN0b3Ip
KTsKKworICAgIHYwID0gUTZfVl92c3BsYXRfUih4MCk7CisgICAgdjEgPSBRNl9WX3ZzcGxhdF9S
KHkwKTsKKyAgICB2cmVzID0gUTZfVndfdnN1Yl9Wd1Z3X3NhdCh2MCwgdjEpOworICAgIG1lbWNw
eSgmb3V0cHV0WzBdLCAmdnJlcywgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBq
ID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGorKykgeworICAgICAgICBleHBlY3Rb
MF0ud1tqXSA9IElOVDMyX01JTjsKKyAgICB9CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVf
XywgMSk7CisKKyAgICAvKiBJTlQzMl9NQVggLSAoLTEpIG92ZXJmbG93cyBhbmQgbXVzdCBzYXR1
cmF0ZSB0byBJTlQzMl9NQVggKi8KKyAgICBtZW1zZXQoZXhwZWN0LCAweDEyLCBzaXplb2YoTU1W
ZWN0b3IpKTsKKyAgICBtZW1zZXQob3V0cHV0LCAweDM0LCBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgIHYwID0gUTZfVl92c3BsYXRfUih4MSk7CisgICAgdjEgPSBRNl9WX3ZzcGxhdF9SKHkxKTsK
KyAgICB2cmVzID0gUTZfVndfdnN1Yl9Wd1Z3X3NhdCh2MCwgdjEpOworICAgIG1lbWNweSgmb3V0
cHV0WzBdLCAmdnJlcywgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBqID0gMDsg
aiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGorKykgeworICAgICAgICBleHBlY3RbMF0ud1tq
XSA9IElOVDMyX01BWDsKKyAgICB9CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7
Cit9CisKIHN0YXRpYyB2b2lkIHRlc3RfbG9hZF90bXBfcHJlZGljYXRlZCh2b2lkKQogewogICAg
IHZvaWQgKnAwID0gYnVmZmVyMDsKQEAgLTUzMCw2ICs1NzMsNyBAQCBpbnQgbWFpbigpCiAKICAg
ICB0ZXN0X3ZhZGR1d3NhdCgpOwogICAgIHRlc3RfdnN1YnV3c2F0X2R2KCk7CisgICAgdGVzdF92
c3Vid3NhdCgpOwogCiAgICAgdGVzdF9sb2FkX3RtcF9wcmVkaWNhdGVkKCk7CiAgICAgdGVzdF9s
b2FkX2N1cl9wcmVkaWNhdGVkKCk7Ci0tIAoyLjM0LjEKCg==

