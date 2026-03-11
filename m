Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42176FD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsH-0000rv-S8; Wed, 11 Mar 2026 00:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As2-0000nK-JK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As1-0008Vf-09
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2gs1v1572954
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DR8uYl6sVAIuH1FZqfeFCtMEgETahoyDYvHwaSMbrdI=; b=HvZvHrgM0nM+eo0G
 Y/y+FS0YJVmo3i2pSbvQ4w7YtKl+WJpDH0MguC0M1ojPCRAE4Xc6Pz0XX+tkFrPf
 WmQghmWBMT/CA4uMDx3Ap71CcnKAzWxVvRxhJ1dPSnqmgV8xWaUp9Kdw9c2q1XOk
 jlYJlHzoqFr9r4WVzdn42RF6eNsr/odZKLbdMw+RZJnQLufHhkgELnHynwpqyxwF
 R/AT2u9VU0hyk7RRED8Z4vzuelGBjN8ZWnAEInxULhXx8PGDDveLdqZ7Et26ZT2B
 4rQant7GrzNuj3HZBjNGtxizfR7Ms9r/4Us4kIJWTyti5ahhSvB0O9nGc+5fZMW2
 3Eqztg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9v3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:27 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-417015062ecso30956645fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202107; x=1773806907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DR8uYl6sVAIuH1FZqfeFCtMEgETahoyDYvHwaSMbrdI=;
 b=KOPmw233PJwzcQP4J3HiBIOGi4MY6fpwSm51G0KYnYKkTvhKY2DoH++yULZcWGcIam
 9S3MULaMltn5ZihtFwwR0+qZ8swXJ5rOy9BaCXQT8We4IXcMGVBPGCMlh5JacuU+WgeL
 uLdFDb5n3WgmjBOG6OXp3FlhOK7MvCSBb8lGjXG6ra8RcL/l0s6+mcoZIV68v4HCeX5x
 7tT1mDSrecHM8GF3CAss06NR1/ky72LKi4Sy4MQ0zHSd808BKWLi6ZxPAatZnQ8n3gVi
 finB+f2MQb+uro7DIdx3lSqMUjpyW9RzFKqF28bbr24QACAMUsObcft4Ew3jEYIDF7yR
 ehGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202107; x=1773806907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DR8uYl6sVAIuH1FZqfeFCtMEgETahoyDYvHwaSMbrdI=;
 b=eywonpiPHnroQJpoKWYwzZ2n6VdTNzYxjZiN0pH9uex9QxK3AY73fSiEl0yghtgVow
 r/5bey6G4QP7K5SvofW88jBJC7B3BA4X2T+zsOKNqI0rPWattQiwhQz2ZOum1D9QXv7q
 IbpDW2H6phFUVcQ+6ptf6DKX/6DYa8sRk0lQDhbw19Q1Kyre7YoNMSlv9PAadJB8VGa3
 fdKZ0GZ3t/FINAuEqidEscGBjaLjEkseag56/mXBsbrYkCisTOsiv8v89aivhxsg+6IR
 GLgkEDdd9WrSKXPAFFMk0CLdi88oyVDBZ3neTsnLPiEjdyUHt8+H/XEBWqZYvOtM/yc3
 /CPQ==
X-Gm-Message-State: AOJu0YwpukOnWntBVeDBI4dr7FkFBUOeH0qH22V20cRv75IJ4BNQqBT1
 CYH8+2sC/9F88Fx6L/WSOYbQmroOTUvt4QTFaRrdjr7H6eGztcaWDwcg9BwUlANUGabw5BSvshb
 MDoDJym0LK7dlkoEV33lZyB3cht75ZqqIusCq41R71sYR8FUE093kMP9/JMgK2XnD8Q==
X-Gm-Gg: ATEYQzwSZeoB0vnrNbWFWmeinqvFyfdwgCnbsGASK7CtpS0Mlh9AVJklWgRc4Uu68Qu
 dXtT4+LCZcpdZyLS4vL+HAgd+rMvo5BqZRnBMwZgDbaujJHmEnIo42vbcXLpKELJstM8ugxS7nt
 oaXJxiB+3j1Uhr0ZU1hvtzpTapxLC6kgZ2vKh3uFMKXEHqabbVMQ3I8K8cSe53/qQkfNoHzwmLW
 fVt8MZpV5Srsz9KYLwd+vdKB9Tx9euZPGJha2WrJu9+x0JnLrhDO9xBNbzef3+NbgY4IG5V9lkx
 DonQvy5pK+FSWQuxPcDkK3zRflNjMZybMzHsvyMGq0lny/zq/oEvMrb/HxCUs31OrjvqcuUmRoR
 xZSgiDRHkaTGlHEctdsth6r3S0J2q9YySHqJBg2cS90oiyP/gjk5Y1TjCJUBvt2At4/ATGg==
X-Received: by 2002:a05:6870:3310:b0:3d2:6a9e:29ff with SMTP id
 586e51a60fabf-4177c7b8ea8mr840721fac.16.1773202107294; 
 Tue, 10 Mar 2026 21:08:27 -0700 (PDT)
X-Received: by 2002:a05:6870:3310:b0:3d2:6a9e:29ff with SMTP id
 586e51a60fabf-4177c7b8ea8mr840704fac.16.1773202106895; 
 Tue, 10 Mar 2026 21:08:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 15/32] target/hexagon: Implement hexagon_tlb_fill()
Date: Tue, 10 Mar 2026 21:07:41 -0700
Message-Id: <20260311040758.1068731-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: qu2EshGD2oHFqa-5F3Kjb438LYkl_6Nx
X-Proofpoint-ORIG-GUID: qu2EshGD2oHFqa-5F3Kjb438LYkl_6Nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX1CqIEpkhDNtc
 iLmSEsEBRDPjArw2acWfxNatlG0cigSIReKkFRoZXhMHpwluH9Lwc83sc46HR0lAbjAJ7AtEpdm
 CFszsEUodcqgN0zkeelHP+v5+QGk/Fk7aTgHSGJBpQvq3XG9HaGInWlxXD1sVkqy4uKEjy2WHUL
 WNGwBJbEN632BkgHFwCWE7K5okXvXWsj39Y8BYVn3hE6N4epvm80bewnxr92kZBaHjt2u1YJvlG
 ja2LiGdTiGqgFbA3JdRMySdgvn1BAT6/b8WtmUHbpy3WiAnt7VaoFNtO9WDwvBNNy/8ukrVFraz
 g6LBMeICxX7P7/XgWd0u/ecR57ghSrtZ3ShDMHx3rf2Pn96H1/N/iNOPL2illPdtLD+dOERM6V6
 CWoZPDMocrprrQcvs/AovfoY5H55LzHiYd4doA1oW2wKRc3Os9aohzP6oyhOaiOlDnp+2xas/1v
 81z43JUe+xmvmZsyMjQ==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0eabc cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yz7b9sy1sBSXNk6fZdQA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMTM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjQzOWRmZjFjMjAuLmM1ZWM0
NzhlZjQwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuYwpAQCAtMzgsNiArMzgsOCBAQAogI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgi
CiAjaW5jbHVkZSAiaGV4X2ludGVycnVwdHMuaCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1
cHQuaCIKKyNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCisjaW5jbHVkZSAiaHcvaGV4YWdv
bi9oZXhhZ29uX2dsb2JhbHJlZy5oIgogI2VuZGlmCiAKIHN0YXRpYyB2b2lkIGhleGFnb25fdjY2
X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KQEAgLTQ3OCw2ICs0ODAsMTM4IEBAIHN0YXRpYyB2
b2lkIGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpvYmopCiB9CiAKICNpZm5kZWYgQ09ORklHX1VT
RVJfT05MWQorc3RhdGljIGJvb2wgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGh3YWRkciAqcGh5cywgaW50ICpwcm90LAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QgKnNpemUsIGludDMyX3QgKmV4Y3AsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50MzJfdCBhZGRyZXNzLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1tdV9pZHgpCisKK3sK
KyAgICBpZiAoaGV4YWdvbl9jcHVfbW11X2VuYWJsZWQoZW52KSkgeworICAgICAgICByZXR1cm4g
aGV4X3RsYl9maW5kX21hdGNoKGVudiwgYWRkcmVzcywgYWNjZXNzX3R5cGUsIHBoeXMsIHByb3Qs
IHNpemUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhjcCwgbW11X2lkeCk7
CisgICAgfSBlbHNlIHsKKyAgICAgICAgKnBoeXMgPSBhZGRyZXNzICYgMHhGRkZGRkZGRjsKKyAg
ICAgICAgKnByb3QgPSBQQUdFX1ZBTElEIHwgUEFHRV9SRUFEIHwgUEFHRV9XUklURSB8IFBBR0Vf
RVhFQzsKKyAgICAgICAgKnNpemUgPSBUQVJHRVRfUEFHRV9TSVpFOworICAgICAgICByZXR1cm4g
dHJ1ZTsKKyAgICB9Cit9CisKKy8qIHFlbXUgc2VlbXMgdG8gb25seSB3YW50IHRvIGtub3cgYWJv
dXQgVEFSR0VUX1BBR0VfU0laRSBwYWdlcyAqLworc3RhdGljIHZvaWQgZmluZF9xZW11X3N1YnBh
Z2UodmFkZHIgKmFkZHIsIGh3YWRkciAqcGh5cywgdWludDY0X3QgcGFnZV9zaXplKQoreworICAg
IHZhZGRyIHBhZ2Vfc3RhcnQgPSAqYWRkciAmIH4oKHZhZGRyKShwYWdlX3NpemUgLSAxKSk7Cisg
ICAgdmFkZHIgb2Zmc2V0ID0gKCgqYWRkciAtIHBhZ2Vfc3RhcnQpIC8gVEFSR0VUX1BBR0VfU0la
RSkgKiBUQVJHRVRfUEFHRV9TSVpFOworICAgICphZGRyID0gcGFnZV9zdGFydCArIG9mZnNldDsK
KyAgICAqcGh5cyArPSBvZmZzZXQ7Cit9CisKKworI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFk
YWJhZGEKKworc3RhdGljIHZvaWQgc2V0X2JhZHZhX3JlZ3MoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IFZBLCBpbnQgc2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUpCit7CisgICAgZW52LT50X3NyZWdbSEVYX1NSRUdfQkFEVkFd
ID0gVkE7CisKKyAgICBpZiAoYWNjZXNzX3R5cGUgPT0gTU1VX0lOU1RfRkVUQ0ggfHwgc2xvdCA9
PSAwKSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JBRFZBMF0gPSBWQTsKKyAgICAg
ICAgZW52LT50X3NyZWdbSEVYX1NSRUdfQkFEVkExXSA9IElOVkFMSURfQkFEVkE7CisgICAgICAg
IFNFVF9TU1JfRklFTEQoZW52LCBTU1JfVjAsIDEpOworICAgICAgICBTRVRfU1NSX0ZJRUxEKGVu
diwgU1NSX1YxLCAwKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9CVlMsIDApOwor
ICAgIH0gZWxzZSBpZiAoc2xvdCA9PSAxKSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVH
X0JBRFZBMF0gPSBJTlZBTElEX0JBRFZBOworICAgICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19C
QURWQTFdID0gVkE7CisgICAgICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfVjAsIDApOworICAg
ICAgICBTRVRfU1NSX0ZJRUxEKGVudiwgU1NSX1YxLCAxKTsKKyAgICAgICAgU0VUX1NTUl9GSUVM
RChlbnYsIFNTUl9CVlMsIDEpOworICAgIH0gZWxzZSB7CisgICAgICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CisgICAgfQorfQorCitzdGF0aWMgdm9pZCByYWlzZV90bGJtaXNzX2V4Y2VwdGlv
bihDUFVTdGF0ZSAqY3MsIHVpbnQzMl90IFZBLCBpbnQgc2xvdCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUpCit7CisgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKworICAgIHNldF9iYWR2YV9yZWdzKGVu
diwgVkEsIHNsb3QsIGFjY2Vzc190eXBlKTsKKworICAgIHN3aXRjaCAoYWNjZXNzX3R5cGUpIHsK
KyAgICBjYXNlIE1NVV9JTlNUX0ZFVENIOgorICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0g
SEVYX0VWRU5UX1RMQl9NSVNTX1g7CisgICAgICAgIGlmICgoVkEgJiB+VEFSR0VUX1BBR0VfTUFT
SykgPT0gMCkgeworICAgICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1J
U1NYX0NBVVNFX05FWFRQQUdFOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgZW52LT5j
YXVzZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1JU1NYX0NBVVNFX05PUk1BTDsKKyAgICAgICAgfQor
ICAgICAgICBicmVhazsKKyAgICBjYXNlIE1NVV9EQVRBX0xPQUQ6CisgICAgICAgIGNzLT5leGNl
cHRpb25faW5kZXggPSBIRVhfRVZFTlRfVExCX01JU1NfUlc7CisgICAgICAgIGVudi0+Y2F1c2Vf
Y29kZSA9IEhFWF9DQVVTRV9UTEJNSVNTUldfQ0FVU0VfUkVBRDsKKyAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBNTVVfREFUQV9TVE9SRToKKyAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhF
WF9FVkVOVF9UTEJfTUlTU19SVzsKKyAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNF
X1RMQk1JU1NSV19DQVVTRV9XUklURTsKKyAgICAgICAgYnJlYWs7CisgICAgfQorfQorCitzdGF0
aWMgdm9pZCByYWlzZV9wZXJtX2V4Y2VwdGlvbihDUFVTdGF0ZSAqY3MsIHVpbnQzMl90IFZBLCBp
bnQgc2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUg
YWNjZXNzX3R5cGUsIGludDMyX3QgZXhjcCkKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9
IGNwdV9lbnYoY3MpOworCisgICAgc2V0X2JhZHZhX3JlZ3MoZW52LCBWQSwgc2xvdCwgYWNjZXNz
X3R5cGUpOworICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNwOworfQorCitzdGF0aWMgY29u
c3QgY2hhciAqYWNjZXNzX3R5cGVfbmFtZXNbXSA9IHsgIk1NVV9EQVRBX0xPQUQgIiwgIk1NVV9E
QVRBX1NUT1JFIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
TU1VX0lOU1RfRkVUQ0giIH07CisKK3N0YXRpYyBjb25zdCBjaGFyICptbXVfaWR4X25hbWVzW10g
PSB7ICJNTVVfVVNFUl9JRFgiLCAiTU1VX0dVRVNUX0lEWCIsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiTU1VX0tFUk5FTF9JRFgiIH07CisKK3N0YXRpYyBib29sIGhl
eGFnb25fdGxiX2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50
IG1tdV9pZHgsIGJvb2wgcHJvYmUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRw
dHJfdCByZXRhZGRyKQoreworICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7
CisgICAgaW50IHNsb3QgPSAwOworICAgIGh3YWRkciBwaHlzOworICAgIGludCBwcm90ID0gMDsK
KyAgICB1aW50NjRfdCBwYWdlX3NpemUgPSAwOworICAgIGludDMyX3QgZXhjcCA9IDA7CisgICAg
Ym9vbCByZXQgPSAwOworCisgICAgcWVtdV9sb2dfbWFzaygKKyAgICAgICAgQ1BVX0xPR19NTVUs
CisgICAgICAgICIlczogdGlkID0gMHgleCwgcGMgPSAweCUwOCIgUFJJeDMyICIsIHZhZGRyID0g
MHglMDgiIFZBRERSX1BSSXgKKyAgICAgICAgIiwgc2l6ZSA9ICVkLCAlcyxcdHByb2JlID0gJWQs
ICVzXG4iLAorICAgICAgICBfX2Z1bmNfXywgZW52LT50aHJlYWRJZCwgZW52LT5ncHJbSEVYX1JF
R19QQ10sIGFkZHJlc3MsIHNpemUsCisgICAgICAgIGFjY2Vzc190eXBlX25hbWVzW2FjY2Vzc190
eXBlXSwgcHJvYmUsIG1tdV9pZHhfbmFtZXNbbW11X2lkeF0pOworICAgIHJldCA9IGdldF9waHlz
aWNhbF9hZGRyZXNzKGVudiwgJnBoeXMsICZwcm90LCAmcGFnZV9zaXplLCAmZXhjcCwgYWRkcmVz
cywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3NfdHlwZSwgbW11X2lkeCk7
CisgICAgaWYgKHJldCkgeworICAgICAgICBpZiAoIWV4Y3ApIHsKKyAgICAgICAgICAgIGZpbmRf
cWVtdV9zdWJwYWdlKCZhZGRyZXNzLCAmcGh5cywgcGFnZV9zaXplKTsKKyAgICAgICAgICAgIHRs
Yl9zZXRfcGFnZShjcywgYWRkcmVzcywgcGh5cywgcHJvdCwgbW11X2lkeCwgVEFSR0VUX1BBR0Vf
U0laRSk7CisgICAgICAgICAgICByZXR1cm4gcmV0OworICAgICAgICB9CisgICAgICAgIGlmIChw
cm9iZSkgeworICAgICAgICAgICAgcmV0dXJuIGZhbHNlOworICAgICAgICB9CisgICAgICAgIHJh
aXNlX3Blcm1fZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nlc3NfdHlwZSwgZXhjcCk7
CisgICAgICAgIGRvX3JhaXNlX2V4Y2VwdGlvbihlbnYsIGNzLT5leGNlcHRpb25faW5kZXgsIGVu
di0+Z3ByW0hFWF9SRUdfUENdLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0YWRkcik7
CisgICAgfQorICAgIGlmIChwcm9iZSkgeworICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgfQor
ICAgIHJhaXNlX3RsYm1pc3NfZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nlc3NfdHlw
ZSk7CisgICAgZG9fcmFpc2VfZXhjZXB0aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgZW52
LT5ncHJbSEVYX1JFR19QQ10sIHJldGFkZHIpOworfQogCiBzdGF0aWMgYm9vbCBoZXhhZ29uX2Nw
dV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1cHRfcmVxdWVzdCkKIHsK
QEAgLTUyMCw2ICs2NTQsNyBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29w
cyA9IHsKICAgICAuY3B1X2V4ZWNfaW50ZXJydXB0ID0gaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1
cHQsCiAgICAgLnBvaW50ZXJfd3JhcCA9IGhleGFnb25fcG9pbnRlcl93cmFwLAogICAgIC5jcHVf
ZXhlY19yZXNldCA9IGNwdV9yZXNldCwKKyAgICAudGxiX2ZpbGwgPSBoZXhhZ29uX3RsYl9maWxs
LAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

