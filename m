Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D10C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFa7-0005ll-Ao; Wed, 29 Jul 2026 21:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFa5-0005lc-R3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:29:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFa4-0005eI-Ba
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:29:05 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1M9K0496719
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GhQnLWWiUGO5P3NDVBX5O4g6byktQ5bXhd4epAk9mqk=; b=LLgjyEcpr0MXUAau
 hDKIRpWtFMFINrtw8WoMdwuBpXE+dyodT7m3XWK+I3x4ijWQr62qlGtsTZT+eOu4
 AZHYZeWQZp8y9V2O7AZ0SLLS98bLS+iXEnv8i0IwGXVqUQG4zUZHq0+aRolAa3iQ
 kxGiik+hSSzwQsbiOEL79o3BQbYKDSN2nIV40LrLgyovsG2wS34OXuVJtc8tUubB
 ytQvVAzIFkQezQWVdzfXzsV1OysF2WpCQzbQi1Ux4puE1yYW2SQ9uweG5pb0Mn17
 qPqD6gxg9kO0Kpb/tEhGIcAu1547gmF7jOuerRhb6mKp1jw8VCNIHbdFbWgcQI6t
 otJDRA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvvy80p6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cec4226c70so27817185ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374932; x=1785979732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GhQnLWWiUGO5P3NDVBX5O4g6byktQ5bXhd4epAk9mqk=;
 b=DKEPfXy7ylX7th1xupuCdypATymWnht6mvCnVluxNPaVvkNASRHCKDBHZZcVMVI+ma
 s9hIf2ANTkotaAVXiHQcCq+esxCiPmzLHruwHlPtDvNgPT39sMwu6obPgVZDzbrdvH7O
 pU423twOsr+08SlKmP5xlr6JM6y5IxKfPErlrCGxSmi7XE3mmOzOM1Zhp0Ylo7vSeOAh
 QWsXU81IWD59IeA6iYuf7s6Lcdd+MstmNGWNHuuz6AwWzCDaAcpTSQaXK4DrhtiuL15Q
 l9CsMqdUxe2cLkLyPC9UAfaRQAz5H1NhYNvf/D4m3c/zREcjTTD+3LvsrxEMcBiMITUD
 ejtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374932; x=1785979732;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GhQnLWWiUGO5P3NDVBX5O4g6byktQ5bXhd4epAk9mqk=;
 b=X2WsCDeyE75jaQldLoO0ej2ZbScvRYjS4FX9IAeEC49kPTnyX2pAmuS+Oj1pHmIlOx
 t6bGQAW3MxbvmAHRF/oOB1gMdYr2wEHkofYlgVjhOHkCaq5qybSIceiWHOnjxiucaJ+g
 eAhAkFOxaIObtGdNOg+/SlXvy202/M8TttokCL7pyMnstLqliDpbF726E9t/eQEQotr+
 biCDSpBweA9MYlMcuI8wDhKeVuIoIv95VON15SkL7eWhZIDjWbX4r6BPzy57ngH+dIb1
 7jUEfB4oAufDQtM2jU6M1XlsAT09Aq55AUovpHTDXXhU2z2i8iRMjxNDqOAyk9Hnm16T
 DC6Q==
X-Gm-Message-State: AOJu0YyY/JmKSJinZegDDUqZIy1DlSNF9fphXLdkEEvQ1scKQVaLayMG
 RI28Oe8oRTYOkn45RoxzzoogcCE+z9FslmcSVHj5EhOmDjOfTmNqlJsTi+Z2HzQwkj0qNDdUcpp
 SdwDIVp/LpqCqkerdkSqW3NEyNy2dbaOIV1hfrlAwzBJN2cHaiLCoQ3hKxHe4dztbNA==
X-Gm-Gg: AR+sD11FvkYGsGVo6HFibumLjGonVWOdvqcGXMeJv+3h09olRJCi93mnX7/qW8BPLwN
 SA0ByHmQoATuHj/OgEfBzVahoZjrkUF0VXQUmaaESlcIxo/rQTG6a+5O8tAuyTYqFQ9tWdIdUj/
 RBYECQCuOhqbxCiubhta2JqYgH9gMRXKac7fjDbqTdwwFu7K8mqgTqM+/IwOjse8V8v4QWJofmw
 08PNFKDFGvpyZuC+eP6ceTXhMajjj+YmXYSLZuY12kmpvoaNiNudR0yEwNGgDgP7A0T7PTMi0Qk
 w7mNk1HVxQMdQ/uaJ5MRCTG/1aoh08cSHUjg5cIRMKAGJxw4P7/YdFxxWwgFTyayRMdQAvP3UmI
 fDkk1uPkBlq7LCa/o4Co82R6REScOBfwvHgp/DCVtK/d7D+Ay
X-Received: by 2002:a17:90b:1649:b0:37f:9ce1:7364 with SMTP id
 98e67ed59e1d1-38f9bed3bccmr614941a91.26.1785374931327; 
 Wed, 29 Jul 2026 18:28:51 -0700 (PDT)
X-Received: by 2002:a17:90b:1649:b0:37f:9ce1:7364 with SMTP id
 98e67ed59e1d1-38f9bed3bccmr614912a91.26.1785374930846; 
 Wed, 29 Jul 2026 18:28:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 18/18] tests/functional/hexagon: enable more arch_tests
 cases
Date: Wed, 29 Jul 2026 18:28:23 -0700
Message-Id: <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX6KpfO+NYLgCW
 cC/UgXf7V73BewF6EAht1BeYnZ2CvDnF1plYiHLVT8y2mtpb2Ubk2g6ZUPbWX5ygk8Ev8v7hHP8
 HDH/ieQ37lbUqihoCH/9te8A9rtIeHnJzQ7xBfrB7FpST4icFXXHYwN5U5lZ4wVdOu9ZvHIBaVV
 GeWysdk2fa5u5qM8jRP4YXiNCqDG+Oq4r3uDX3iidxPzB12Lq9d3ntWMPQ4doW3IYr5wrt+dzG+
 gw3HGDb3ocvZ4gulGkw5TG7FUP9dAhwUoeVuvBb7brQC6+T4jpk0kbOYWhf0yok3279kioGmA6+
 gjLqCluTE03nEVSKDQBBws4ZpfAeL8znJY5pp5ZaTjVBbF6pKWcnJ2vZup1t3hZ74moeNxVYYV8
 Mf4UokTYq2ySQcebkVx/um7mc2Gq6KZRQXL2YntRKRxHWLZPE11W0K0O96Mdwa2PmF66ETeZv/K
 ft6Wz6KbF0e3tyTFIQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX9Fa50HEDUIpy
 N2vYLNLdYgMZhEiPRz8FBdLtOl4mCkObgckFRuP83BzCqdWSRW+/T87WRY5w3/C21HAy5R/BkyJ
 nPz+n1LGD7u7nQ+XtWHDwTQ+kG837ko=
X-Authority-Analysis: v=2.4 cv=U8+iy+ru c=1 sm=1 tr=0 ts=6a6aa8d4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6_sklNI9eh_OQcpcNH0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: XVAlyXXhdfP3JO1dnTRbHilC4wjGdJrM
X-Proofpoint-ORIG-GUID: XVAlyXXhdfP3JO1dnTRbHilC4wjGdJrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300006
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

QWRkIG1vcmUgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMsIGVuYWJsZWQgYnkgUVRpbWVy
IGRldmljZS4KClRoZXNlIGV4ZXJjaXNlIGNhY2hlIG1haW50ZW5hbmNlIG9wcywgbDJ2aWMsIHRo
cmVhZCBzdGFydC9zdG9wLCB0bGIvbW11Cm9wZXJhdGlvbnMsIGFuZCB1c2VyLW1vZGUgdHJhbnNp
dGlvbnMuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8
IDMyICsrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3Rz
LnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQppbmRleCAy
YmIzNGY5YjhkYy4uMDgzNDM5OGMzYjEgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQpAQCAtNTgsNiArNTgsMzggQEAgZGVmIHRlc3RfaW50X3N0ZWVyaW5n
KHNlbGYpIC0+IE5vbmU6CiAgICAgICAgICIiIgogICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3Qo
InRlc3RfaW50X3N0ZWVyaW5nIikKIAorICAgIGRlZiB0ZXN0X2NhY2hlKHNlbGYpIC0+IE5vbmU6
CisgICAgICAgICIiIlRlc3RzIGNhY2hlIG9wZXJhdGlvbnM6IGRja2lsbC9pY2tpbGwsIGwya2ls
bCwgZGN6ZXJvYSwKKyAgICAgICAgZGNjbGVhbmludmEsIGNhY2hlIGRpc2FibGUvZW5hYmxlLCBi
YXJyaWVycywgYW5kIGRjaW52YS9kY2NsZWFuYS4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYu
cnVuX3VhcnRfdGVzdCgidGVzdF9jYWNoZSIpCisKKyAgICBkZWYgdGVzdF9sMnZpYyhzZWxmKSAt
PiBOb25lOgorICAgICAgICAiIiJUZXN0cyB0aGUgTDJWSUMgaW50ZXJydXB0IGNvbnRyb2xsZXI6
IGVuYWJsZSByZWFkYmFjaywKKyAgICAgICAgaW50ZXJydXB0IHR5cGUgcmVhZGJhY2ssIFZJRCBj
YXB0dXJlLCBhbmQgdGhlIGZhc3QgaW50ZXJmYWNlLgorICAgICAgICAiIiIKKyAgICAgICAgc2Vs
Zi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2wydmljIikKKworICAgIGRlZiB0ZXN0X3RocmVhZHMoc2Vs
ZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgaGFyZHdhcmUgdGhyZWFkIG1hbmFnZW1lbnQ6
IHN0YXJ0L3N0b3AsIE1PREVDVEwgc3RhdGUsCisgICAgICAgIHBlci10aHJlYWQgSFRJRCwgc2hh
cmVkIG1lbW9yeSwgd2FpdC9yZXN1bWUsIFNUSUQgcHJpb3JpdHksIGFuZAorICAgICAgICBTQ0hF
RENGRy9CRVNUV0FJVCByZWFkYmFjay4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3Vh
cnRfdGVzdCgidGVzdF90aHJlYWRzIikKKworICAgIGRlZiB0ZXN0X3RsYl9tbXUoc2VsZikgLT4g
Tm9uZToKKyAgICAgICAgIiIiVGVzdHMgVExCL01NVSBvcGVyYXRpb25zOiB3cml0ZS9yZWFkL3By
b2JlL2ludmFsaWRhdGUsCisgICAgICAgIGdsb2JhbCBlbnRyaWVzLCBtdWx0aXBsZSBlbnRyaWVz
LCBvdmVyd3JpdGUsIEFTSUQgbWF0Y2hpbmcsCisgICAgICAgIGFuZCBwZXJtaXNzaW9uIGNoZWNr
cy4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF90bGJfbW11
IikKKworICAgIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJU
ZXN0cyB1c2VyIG1vZGUgLyBwcml2aWxlZ2UgdHJhbnNpdGlvbnM6IHN1cGVydmlzb3IgbW9kZSwK
KyAgICAgICAgU1NSIFVNL0lFL1hFL0NFL1BFIGJpdHMsIGFuZCB0aGUgdHJhcDAgdXNlci1tb2Rl
IGV4aXQgaGFuZGxlci4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgi
dGVzdF91c2VyX21vZGUiKQorCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVt
dVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

