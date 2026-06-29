Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFA1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3d6-0002cv-85; Mon, 29 Jun 2026 00:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3cw-0002cA-48
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3ct-0000j0-Cl
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4Nqbp1778272
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=; b=eyA4BJHe29U9hunN
 96fmJAcwMH3LSJlMTrbOLVOmnT7nMnrv2RmUYFopwdOeaeUFObEuMYVWgs5dRXXh
 vlaPLaN30AAnc9G/gdWYlec9KB46zMaf2NIF6Eo0ivYBgxvWhq9Ld79K+nzv5nWL
 VCB3utFTsrCGVNHh6777n6v8gsfUY02AbhQu60+jcKy657ePCf6vGmFpWDtZPiJY
 z4UBh9ksvU89FyC/MyLkw/jtG8+frnEJ0xWpQzWlRVRzC2oVRcKJ5rzcT1l5YCd3
 sux5Eioby3IgdlvRGERckmmHtQp531Rp6tyDzg5ks49NjXp4uuRJ12jLDydBcPJm
 NdME0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mg6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so7191628eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707381; x=1783312181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=ZYNYjiTJHpHVn9ky8RgvUkBarl5O+8Am/xD99go2km3HHW8nJLyHfy9sIw6HHqcnKZ
 X7CI7pQl1N7SKBGWjoNP0Rt1JCnfelx40WBTrFzSDp6vUKpuoH71zEm+W/GrXc95O+wY
 WyvbRYOMr4KzPHqPv+jOL9ofqgHc+sk/oU8AZ1sJcnZYOtU7kuEwAJTPQSnv2/m2vBdj
 odxAwerkKbCyWSYNHif8aGHIIZV9CAbwRxmoOg1apMK+k+86DKDVxI2k78U/mdcQNqab
 9qGQ3sqw2rL6pQq29CIYdTNlo+5IeHHnzKrTpNvoAhYxKmup9oAZkheOXed1U1h6wjth
 RhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707381; x=1783312181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=dKn4w+LQCaZtLhJ6MBRFzzLUuF+9Zt8hXUKqiospOFPB71q4wcBsgcZorFsAomJHS0
 3wWpSteun0ROnZKJ8vC5InftGgJ0/BNLWDDSfJzzJUpdUkdv3h0FHb8lUJuUY7jOJ/pr
 8XQfhw4D2zh/VCzYD/L0M7SW0UMVwiOGc3iJ2/0I646DPZxMbCU1oJYF8WpJnNAHv/Or
 fAu94dYKBVF/s8vp/BRTSlDCnNxrdBMjSG60M/l08EJttCKUYVLt5NYE24AgjY5FJEPv
 EMXbwxuIQ65wv5L5lT2MpfMy7pgVqXYnufPNEqfD9SUI6Y6G/cCyEApLMqkk91v9+7d7
 ziAQ==
X-Gm-Message-State: AOJu0Yy07tvixejJvrnYKfRnpYbdBiOHInjarhHIZsb83+suB9RZ8s1Z
 8QwWjak+bgnhm2sCWcKILqd2MasJBs4vJtbTa7SqYh7vX5qSoLcjUshr/Sw/UdGWVOXyx7ZWe84
 +R4PLEeyeJ+Bt/XEQvfzFY8eSum3yLDa8F3WDJ2SJurqPCvBVyjAEjOugIQVEjQeFRA==
X-Gm-Gg: AfdE7cllAvVTznDE9L1c0ar2cFWCzodeDRGOKVESF5Hhng/YW1GJdU5s3uvULbwqb3O
 i2vlk9Tzc3w39FhTBiZfGyd+NhtppOJJygCjqWlLBBIZBLX6yI4X5nRLEziSURUCo3b8pT+wJcg
 m1JUA7oPDVb6AduudDjcVPIX3HE4VHCuvwVYcpgEwLyZGMv5PG9Y4oRPmqY8Gct5RGCVIvK25QT
 6FHFIVl4be8rDinjgG4pjZWhTE67fItTpJ0kBDE07N66WVGIh10Wp3fjZc/VffMwH9UVcrt3wpK
 rdhhUFuDx6z6oBiuOXuP0+hrcS95JyzCHsNIkqSuc2qTS7x6mSlR0JbJi0W5vhMFlQeFTQHU8Ou
 bKwRfZ+XacXIPluJCceR6/y77pN/yP/ARGWdG0SbWW30c41xE3T3wSBuaWxQ=
X-Received: by 2002:a05:7300:430f:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30c84d9ba29mr16260666eec.5.1782707381267; 
 Sun, 28 Jun 2026 21:29:41 -0700 (PDT)
X-Received: by 2002:a05:7300:430f:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30c84d9ba29mr16260648eec.5.1782707380811; 
 Sun, 28 Jun 2026 21:29:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 42/77] target/hexagon: Implement iassign{r,w} helpers
Date: Sun, 28 Jun 2026 20:57:55 -0700
Message-Id: <20260629035830.1520296-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX2JiM+R44vTWC
 kWBzPWGeypjahDVN7i5ydyUHGQX0s7I6LMru2zJaiNPT9pbXk/vROQmk6HlXDCnIDCoz8t/XNOL
 1tAwJy0kwVVPGOjBlbqXMc4rR9ALdyo=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41f4b6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dUlqx8T-zEtef89Bddz_IpYvBE_1oqk8
X-Proofpoint-ORIG-GUID: dUlqx8T-zEtef89Bddz_IpYvBE_1oqk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXxQ/66rHFqEbX
 0g2i+xWcKBMMLERM+zvH6xTLP9D8YVXjmKXt86Bx3jAMFf6DHjjYGNTHlX4Wb7/cGYDyac8ZmTW
 rYkXzMCPcd/v0pV6Hi9jE4CawfnXOe+gJUu59w7r5c4/ZPQmdBnSK1IrZjQxnqE1mu1lR2atiEn
 dfy4p/AR8RAcRNCss1RH1hv0CfCgtDr9cFJNgXvtBMUY9hp1/LhdKcjSPLXC7iVxgBUUthpAPgH
 pF/SkhB1yX0vc199cPeef1Vqr1ubXMMK5u/DdFa30p0G7zxysYYP+aNoxLasaSJV9EBT76xOZ8n
 8hb4/H8f52p6A8/4rXdg+T0RE3ySsd+rg9/P18MwSa9TEQn+nAQrDwya+0XJaloqz9gkp1OJZdi
 Z42SNe2h/t+111rDHeMwYVFvFkvQT5ok2mekEviKf0cS/xlSq2fvNHeth/wkPuzF8goFAyJmAWv
 YIxWiGT2bysUo0rpwgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDc4Mjc2OTZjNmIyLi42ZjAxZjNiOTFk
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTcsMTIgKzE0MTcsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

