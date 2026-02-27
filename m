Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2922310398AD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aS-0007ah-Rx; Fri, 27 Feb 2026 15:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aH-0007Jn-Qc
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aG-0006tC-BW
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:13 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0HnY527514
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W7+bXpvCeyS6OfLlZNZAmQmj+Ty2xeRkND9UhhfsRJ8=; b=BvQKTxu0bkIL4o8w
 jtRN5lOcj64VF9qRpOqvwtiRSLomzCEqC2edQEf0lwOFaGhkLDZLE8VrmyX6nVsK
 Yl1w0nfseM4GZy7w8bXNGlr1ziMF1mS+79I5IIKKzj94VwsBROvICRWa65gWDpge
 h/qwuq1YSZHzc/XL+0d/iDjhzlp6bNFECV+Uxd07KezNbIv2hj92lh+srNJ1LbAT
 pYcBsP/zhzC60KCrMjl8O2Kx8elMGXS+WA3gZTvkdlPl/5Idf4quhbcRnoBNEUW6
 1KVulByxrsEaqsTQohcPGL4SGBnomaKRDwuPz2nzrccEu42hQIPKqq/y4SOmYlcj
 bIcjdg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23c93g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:11 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-46393ffb94eso31428120b6e.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224631; x=1772829431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7+bXpvCeyS6OfLlZNZAmQmj+Ty2xeRkND9UhhfsRJ8=;
 b=Q80h2UkhGjukoSJgiLvnk2kitFE4Z/jpByFmspmywQeu+bMmC5EIvVXJtmgln1krLA
 CHC+srTbljxBF0He/gTazm3WN96h/YbkaPv1NeVJAyaAhKyn1ZYqdK3X/WsHjyGTUQg5
 RshVGnlUxLiLGYj76tRS5KBFVh2D398I+JlVz+57AIEKn8orcLMxLECHKjRp3fR8lxRK
 Q/p6dTFno73FKhSULy0J8KhTEevhJMFjs6JGL7Wx1bHPCNOkEA8YjuI2RaNzXgwU+8ep
 PqrcTxmt7FisqwnFfGPBYKc7D3cGoBpkHCn47WzQ6RPWxiM9EQVZmaY1ENH8inKcfYr0
 AW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224631; x=1772829431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7+bXpvCeyS6OfLlZNZAmQmj+Ty2xeRkND9UhhfsRJ8=;
 b=bxL7Zk7vs7zNEwfWPxzlrjxrJlqeoLMHOdmjZ7RSLvVjZ79YERdb/r2/hfdiMDzkJA
 WnxHFXj9/UY4HR0ZlTNaFX54bv07wJAD7FK1RDjfJCaHySqFyhs6mfvn5x3jZAV4kTYA
 +d/gBrF607t8EaUbbj7eJEolczjmHdQ1seFltGu1FPCBy62nndKaH/HdACf34nNjIuhH
 Pn5IE8icuhfn6pqxiSDGftwCPSL0+XuYkJJgdmAlKfmPLfE6AregVfzgZzDA3rif3/CR
 30D5foUpjnxvmIOkdpaXK72cx56WAnovqw5vVAC+kggB+h27/yiE/nEwXOtxvZOJrWa0
 xjyA==
X-Gm-Message-State: AOJu0YxFDPXpUH8LtSeAXNZy2IMZccKzIq9KgsS99InwajqzFRzfkqtr
 wDy1KGxaGA540WNSGXAOuxgtlK+K/XNtFj8De/f2cGwqgkvjCv9juTDyuEbOaH1Tx0R5culBzhE
 UKSolMt8yD/dkqLbyPBGy2sqsMsYZmnfWWhhKgcp0ufWrmrDhUgqSiTyOXHy1MM21sQ==
X-Gm-Gg: ATEYQzz25GjIuvEqm19Z+VnVHWlgOGtCiY0ioMDqqezyB9izJqmQWZk/0ZqN1YA8GkK
 NIyW6XxldSZF4N5DuRUe6YtQO7rvQASgESYOkC0FdzGVQaKjaWgZGzJ7yPzUhPKweaLtSuDjLk5
 4dYXlpVLofQ91XYkz5OAHvjRiDgiqZTimcDJwyu6cohoNpta0k8PQUb0TNPZMu/ZGRSeF1DqSgb
 96oJqh4XstquwvkleZIDjb89IA0G3xFPqjsF341D7NImldMRtzwgWMMEuTRUkK4a30LjEX8vw0l
 2J5p/8nfmzaUQTNbzinVtJGR0MPPk3IkM2luet8CrGpm3h5wtuiRd+TRIJZjVx0s/MTL74ZkZQm
 R53L8bQbnX04jGPZMHrKYJ5X7TmDX1FcFWzVblr0q7V1q3G7WjMfTXsE2rQ/Rou2meDm1Gw==
X-Received: by 2002:a05:6808:1645:b0:45a:6adf:4d44 with SMTP id
 5614622812f47-464a5dac614mr4128741b6e.12.1772224630745; 
 Fri, 27 Feb 2026 12:37:10 -0800 (PST)
X-Received: by 2002:a05:6808:1645:b0:45a:6adf:4d44 with SMTP id
 5614622812f47-464a5dac614mr4128731b6e.12.1772224630379; 
 Fri, 27 Feb 2026 12:37:10 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:10 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 29/37] target/hexagon: Add TCG overrides for rte, nmi
Date: Fri, 27 Feb 2026 12:36:19 -0800
Message-Id: <20260227203627.932864-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: bBaJG8_RRodk_0Yk70hnJfJ0NxwZySaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXxtWe4nSApLBp
 w79RLtmK3Lk60jwZ4FTV3KedXlRzlVICzrrKLfQdNCgotZUPh4ISz7w4boM9h8pitOTFHQfgwxS
 AY3WUY/xvW5Bu0sGD022LEkFdfVzFoD200ptJw66862D87oSdm5aDM3FnJPTggUTljiLxHhgpu6
 qKavrBvQJ7B/QbHSADKag5J0AQ/7UKAyqI+JPbv4QulnY0VYvk329VUevOnHiIcz98ICrnjLmgu
 d7odE+WgzBuUJ/0TkI0KejReL3uAUl7k97xI4CI7Mq6bhQxO66bAi58t/d8FK0VzB0VbRXq1F2v
 oOUxoRyfn7SeKsuIINvdBcxxX2XK753O/bptMUR70Pojx1PoCyelshC7QNwV4iYynJ6uWeyWw6X
 KPJe+Cl0sHsGkqLwDJeP8uAYAUU4nmXSrl0O2WOqjOyLoP2NOacpSg6SKSaPGheDxsBzSI2Sndr
 /aDlmCSWmmq6Ysa528g==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a20077 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zRxYJKy5J8nCns2dKEsA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bBaJG8_RRodk_0Yk70hnJfJ0NxwZySaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxOSArKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaCAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8ICA0ICsrKysK
IDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4
IDA0NTNlM2JiMmM0Li44NTYwMmYxZTNmZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw0ICs4
MCwyMyBAQAogICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxl
ICgwKQogCisvKgorICogcnRlIChyZXR1cm4gZnJvbSBleGNlcHRpb24pCisgKiAgICAgQ2xlYXIg
dGhlIEVYIGJpdCBpbiBTU1IKKyAqICAgICBKdW1wIHRvIEVMUgorICovCisjZGVmaW5lIGZHRU5f
VENHX0oyX3J0ZShTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgVENHdiBuZXdfc3Ny
ID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKG5ld19zc3Is
IGhleF90X3NyZWdbSEVYX1NSRUdfU1NSXSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
dGNnX2NvbnN0YW50X3RsKDApLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdfZmll
bGRfaW5mb1tTU1JfRVhdLm9mZnNldCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVn
X2ZpZWxkX2luZm9bU1NSX0VYXS53aWR0aCk7IFwKKyAgICAgICAgZ2VuX2xvZ19zcmVnX3dyaXRl
KGN0eCwgSEVYX1NSRUdfU1NSLCBuZXdfc3NyKTsgXAorICAgICAgICBnZW5fanVtcHIoY3R4LCBo
ZXhfdF9zcmVnW0hFWF9TUkVHX0VMUl0pOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBm
R0VOX1RDR19ZNF9ubWkoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9ubWkodGNnX2Vudiwg
UnNWKQorCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFy
Z2V0L2hleGFnb24vaGVscGVyLmgKaW5kZXggYjJjY2U0YjQ3YmEuLjA0YzAxNjQ5NjgzIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaApAQCAtMTI4LDQgKzEyOCw1IEBAIERFRl9IRUxQRVJfMihzdGFydCwgdm9pZCwgZW52LCBp
MzIpCiBERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQogREVGX0hFTFBFUl8yKHdhaXQsIHZv
aWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIpCitERUZf
SEVMUEVSXzIobm1pLCB2b2lkLCBlbnYsIGkzMikKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCA2
ODllNzlkODNlNy4uNjc1NGM0OTFmZjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDg3LDYgKzE0ODcs
MTAgQEAgdm9pZCBIRUxQRVIoc2V0cHJpbykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHRocmVhZCwgdWludDMyX3QgcHJpbykKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQog
Cit2b2lkIEhFTFBFUihubWkpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aHJlYWRf
bWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQogI2VuZGlmCiAKIAotLSAK
Mi4zNC4xCgo=

