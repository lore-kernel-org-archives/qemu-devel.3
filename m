Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78D8C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmf-00029s-0l; Thu, 06 Aug 2026 00:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmR-00027X-DF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmP-000454-Mo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763x1V8482620
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=7v7Z+jUrMyLbMvr/H3tEiPNRxqOAGx/XOr1xzx4/+xU=; b=f9
 ECWGJe8QNlazkO1QTvBKJxp4z37KXDJUkKrz98Iea4j6jn4yPJT8g33mqCDQsiI8
 YHR1ImwR+P1gghDe8qJlEIKuRu+Fma5xYyzcTSl4Fw4a8APxHkVsGFS6Z7cc8VQs
 7FQfZ7fBw1Zen8Q8ziyyiIeVM0aVeIpSfXsM/ITkSzu2D0PumgnCcljqjisdnzgT
 NwXyNDvoCWj3hmed1jPm4rfLNDp2A98mea90r7jKghpVtU7dyk2uVg0ahFFuLyij
 8MNoVZRhBv/DQhtDy50Q1b2cB+bFlcXDbzpaeD2WhXhVdlSpwhORPTyB0GkDStd7
 hvJ49PBo9tVu1Kr5l3aQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjueg3ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6ef846b33so456604a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990747; x=1786595547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7v7Z+jUrMyLbMvr/H3tEiPNRxqOAGx/XOr1xzx4/+xU=;
 b=Yaw+2sNI4hL1Vwd605u6fBE5h6UxB+ZxCrS396DMMmqrmvdh2CK+3crl7p9M/boakz
 pEvyYV27KLjxEnPjcQ2PkEeESejAMA33eR5xnHz2mUl1TnDh4xCS/KneGQAo5i+6Ny+v
 /PJKVlRI6JqEBkqx8yf7fESDHKYDXNS1tB79y/JsnfXq5DobSqOvtRZJjXlSK9ZkrUE2
 k0Wk3ehtQi85k2PioyAoGjNwPyhIQkIluOdT33etfdFluouKqHSURVzS4J2MOa/uBOu+
 jJAECXZsjsaXc0+g1fG778vQh4jqdFyC2Q27Gfrtc5kbF9yOCasdkWt1qYFeGHXYwucm
 qxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990747; x=1786595547;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7v7Z+jUrMyLbMvr/H3tEiPNRxqOAGx/XOr1xzx4/+xU=;
 b=H5NNjX+TjjGXGcRMNN4JkVHKFi+8uSoP2A8fcrj3iBNkl3J194UmEcEPwQS09GpHSa
 HYwjUQwVs865IkHj+qdjoEfBoKDjGKaaNzIcA2BtY8MsrPcS+QV40ztHLJworuS5WGM2
 FL1PzLgz2RoO1UDD7gRnvnIbhr1d5U1M9OWQ6NcOkikPYLlkFYfb0U0Tnp//TRc0lxxn
 J1S32okaFN9mdiwmiGTCUDtQIA/apidaEAyPpY8oEcLL50rSlUwVHXUXZtQzNv/NhxOY
 oj4RBgCeODJui9mGTlx2WO7g2Z7/4zBoA7fhFjccDO2gnv2swdQHPCCdBZ0qH/IEy/HE
 V07Q==
X-Gm-Message-State: AOJu0YwkmNG5nyXU75jVhTbp4HdYYgDYBD3f7U3Z3Ff2J+6U3PV11LM0
 g8MruOdUt/FDu8Y6pcLzCbJrvwYWVsNbakZVmPqt/qWTDioPQb8KYE+PEJoqd4s1NfLk18LJlmk
 HAXOIMGwkRRSV+Zr35T7YMeebk/h0/JDXtVD5dK1QBstoyx6qZSMVFXyG0fP7hAgn/w==
X-Gm-Gg: AR+sD11GO7POOoviB4q51G+BFYzU67gLrtr+HVTAKYlUubALxLrtSgpKfidXpZL+SYb
 DnBu6UEPRzADCANMlJClmhr7k6XY/GhbH6lwNHgvOf3YES95Ju49JWNOKqO0M5VJq2eDv2je0T/
 yHK1buSNQUmU1tuotFg7VlP3++lnocLhYY4p5l8XO1ZKbCXRMQbiEJamO4+xIFubYisKs0rGLL7
 yutf7mzaJb9SYq/arKH+W7onoLyPebmMhJzhjRKAgHIUhazpy74UX0TholPjqMG4QLv9Jol4OMw
 kMiCD/tLha0X5uiPESnwtweMIHZa+ClwmSzNE2LNzLO9vfjh/BDzhw7cEIhUekFoeVg9bV9v1ae
 HEzRMmuj3aubddabM6AgArk/YQc436ihTgfpj2Tc5Q+UDfKYq
X-Received: by 2002:a05:6a21:3393:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3cb9c0712b1mr4607344637.2.1785990747078; 
 Wed, 05 Aug 2026 21:32:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:3393:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3cb9c0712b1mr4607282637.2.1785990746606; 
 Wed, 05 Aug 2026 21:32:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/6] host-utils: fix ssub32/64_saturate return type and
 clamp direction
Date: Wed,  5 Aug 2026 21:32:18 -0700
Message-Id: <20260806043223.3787083-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a740e5b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=kM50MvNqywxRmdRKJWUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: YY8WDr1Pr-rDCKNLkdBCs_xCfmqq3HP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX/GAg8xMaAYLi
 QUJHFfCYSthJ758vHVd3mCS/xvN9vNZo3LbVBjdQeK3snFPekJBu2jnk4KzHpQVYmXAm7V7BTMJ
 ssyl08D3VKEk1Pat0cSGqSYk2dXyyGJHfIlsE4JKHX8tEEMYiO1+G7AWP6Y1ko8/NtXnlawoxGZ
 r6muPQeGv2ONX0Pyki/oEp1IWMKu+ty6ktbJztvDDBVDRSwIt1KhE7s4TrUkTbRY9rgn7NbFEBI
 DuGXpEeC3mq2TxRA8KmVZ10V/mo/lehBqQwJhSXe66xMv7TFroNaDV3425728uXqJFROQKEBEi2
 ZWQYnUptEND7Gx2LhhIHRzNvBX0/LCPTmJ0dUD3+4lsih2xQ5Ozc+/2xWK9ipJR1b8tgubNDOIi
 lKI9vnzRU55g1RHrZrSPdVzGVKmxFTg48NWQTFXViQLVkhIEk0fso+vVBe3g3KOgptxWURct7Ev
 0IbSgqa+O0YNyN6n4UA==
X-Proofpoint-ORIG-GUID: YY8WDr1Pr-rDCKNLkdBCs_xCfmqq3HP0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX2h/PlQwRCfeI
 BgViX9wSnd9JTYWhbrIHCBRenjO3TzIdWW5uU2nX9wpYc/8eP4Ftb3rrwXFsri1mZKQRVa7/ly/
 oEjMdASw4m2fXXlf8nRNU5WD8N677iM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

c3N1YjMyX3NhdHVyYXRlKCkgYW5kIHNzdWI2NF9zYXR1cmF0ZSgpIHdlcmUgZGVjbGFyZWQgdG8g
cmV0dXJuIGJvb2wKaW5zdGVhZCBvZiBpbnQzMl90L2ludDY0X3QsIGFuZCBjbGFtcGVkIHRvIHRo
ZSB3cm9uZyBib3VuZCBvbiBvdmVyZmxvdy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+CkNjOiBxZW11LXN0YWJsZUBub25nbnUu
b3JnCkZpeGVzOiAxNjQ5NTUzMzEzMSAoImhvc3QtdXRpbHM6IEludHJvZHVjZSBzaWduZWQgc2F0
dXJhdGlvbiBwcmltaXRpdmVzIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvcWVtdS9ob3N0LXV0aWxz
LmggfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvaG9z
dC11dGlscy5oIGIvaW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaAppbmRleCAyZThkYTdmYjNkMC4u
MWRiOWRiYjEzOGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS9ob3N0LXV0aWxzLmgKKysrIGIv
aW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaApAQCAtNjA3LDEwICs2MDcsMTAgQEAgc3RhdGljIGlu
bGluZSBib29sIHVtdWw2NF9vdmVyZmxvdyh1aW50NjRfdCB4LCB1aW50NjRfdCB5LCB1aW50NjRf
dCAqcmV0KQogfQogCiAvKioKLSAqIHNhZGQzMl9zYXR1cmF0ZSAtIGFkZGl0aW9uIHdpdGggc2F0
dXJhdGlvbgorICogc2FkZDMyX3NhdHVyYXRlIC0gMzItYml0IHNpZ25lZCBhZGRpdGlvbiB3aXRo
IHNhdHVyYXRpb24KICAqIEB4LCBAeTogYWRkZW5kcwogICoKLSAqIENvbXB1dGVzIEB4ICsgQHks
IGFuZCBzYXR1cmF0ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAqIENv
bXB1dGVzIEB4ICsgQHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0aGUg
cmVzdWx0LgogICovCiBzdGF0aWMgaW5saW5lIGludDMyX3Qgc2FkZDMyX3NhdHVyYXRlKGludDMy
X3QgeCwgaW50MzJfdCB5KQogewpAQCAtNjIyLDEwICs2MjIsMTAgQEAgc3RhdGljIGlubGluZSBp
bnQzMl90IHNhZGQzMl9zYXR1cmF0ZShpbnQzMl90IHgsIGludDMyX3QgeSkKIH0KIAogLyoqCi0g
KiBzYWRkNjRfc2F0dXJhdGUgLSBhZGRpdGlvbiB3aXRoIHNhdHVyYXRpb24KKyAqIHNhZGQ2NF9z
YXR1cmF0ZSAtIDY0LWJpdCBzaWduZWQgYWRkaXRpb24gd2l0aCBzYXR1cmF0aW9uCiAgKiBAeCwg
QHk6IGFkZGVuZHMKICAqCi0gKiBDb21wdXRlcyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhl
cm4gdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCisgKiBDb21wdXRlcyBAeCArIEB5LCBhbmQg
c2F0dXJhdGVzIHJhdGhlciB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KICAqLwogc3RhdGlj
IGlubGluZSBpbnQ2NF90IHNhZGQ2NF9zYXR1cmF0ZShpbnQ2NF90IHgsIGludDY0X3QgeSkKIHsK
QEAgLTYzNywzMSArNjM3LDMxIEBAIHN0YXRpYyBpbmxpbmUgaW50NjRfdCBzYWRkNjRfc2F0dXJh
dGUoaW50NjRfdCB4LCBpbnQ2NF90IHkpCiB9CiAKIC8qKgotICogc3N1YjMyX3NhdHVyYXRlIC0g
c3VidHJhY3Rpb24gd2l0aCBzYXR1cmF0aW9uCisgKiBzc3ViMzJfc2F0dXJhdGUgLSAzMi1iaXQg
c2lnbmVkIHN1YnRyYWN0aW9uIHdpdGggc2F0dXJhdGlvbgogICogQHgsIEB5OiBhZGRlbmRzCiAg
KgotICogQ29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXJuIHRoYW4gdHJ1bmNh
dGluZyB0aGUgcmVzdWx0LgorICogQ29tcHV0ZXMgQHggLSBAeSwgYW5kIHNhdHVyYXRlcyByYXRo
ZXIgdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCiAgKi8KLXN0YXRpYyBpbmxpbmUgYm9vbCBz
c3ViMzJfc2F0dXJhdGUoaW50MzJfdCB4LCBpbnQzMl90IHkpCitzdGF0aWMgaW5saW5lIGludDMy
X3Qgc3N1YjMyX3NhdHVyYXRlKGludDMyX3QgeCwgaW50MzJfdCB5KQogewogICAgIGludDMyX3Qg
cmV0OwogICAgIGlmIChzc3ViMzJfb3ZlcmZsb3coeCwgeSwgJnJldCkpIHsKLSAgICAgICAgcmV0
ID0geCA8IDAgPyBJTlQzMl9NQVggOiBJTlQzMl9NSU47CisgICAgICAgIHJldCA9IHggPCAwID8g
SU5UMzJfTUlOIDogSU5UMzJfTUFYOwogICAgIH0KICAgICByZXR1cm4gcmV0OwogfQogCiAvKioK
LSAqIHNzdWI2NF9zYXR1cmF0ZSAtIHN1YnRyYWN0aW9uIHdpdGggc2F0dXJhdGlvbgorICogc3N1
YjY0X3NhdHVyYXRlIC0gNjQtYml0IHNpZ25lZCBzdWJ0cmFjdGlvbiB3aXRoIHNhdHVyYXRpb24K
ICAqIEB4LCBAeTogYWRkZW5kcwogICoKLSAqIENvbXB1dGVzIEB4ICsgQHksIGFuZCBzYXR1cmF0
ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAqIENvbXB1dGVzIEB4IC0g
QHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0aGUgcmVzdWx0LgogICov
Ci1zdGF0aWMgaW5saW5lIGJvb2wgc3N1YjY0X3NhdHVyYXRlKGludDY0X3QgeCwgaW50NjRfdCB5
KQorc3RhdGljIGlubGluZSBpbnQ2NF90IHNzdWI2NF9zYXR1cmF0ZShpbnQ2NF90IHgsIGludDY0
X3QgeSkKIHsKICAgICBpbnQ2NF90IHJldDsKICAgICBpZiAoc3N1YjY0X292ZXJmbG93KHgsIHks
ICZyZXQpKSB7Ci0gICAgICAgIHJldCA9IHggPCAwID8gSU5UNjRfTUFYIDogSU5UNjRfTUlOOwor
ICAgICAgICByZXQgPSB4IDwgMCA/IElOVDY0X01JTiA6IElOVDY0X01BWDsKICAgICB9CiAgICAg
cmV0dXJuIHJldDsKIH0KLS0gCjIuMzQuMQoK

