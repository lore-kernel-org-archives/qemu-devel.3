Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203BBC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cp1-0000mQ-1L; Wed, 02 Sep 2026 00:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coz-0000kT-5L
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cow-0000Qs-AY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824M1W22982864
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ikxjYEykn3U+5nMggEF2/LG7xjE5m6kGU2N4izonSg4=; b=JcN8xgpiN1WUCpgt
 uktOA/uhhohdnHgMEg9E8PVClWyoNVjB9/NpYtSt8AWUr9PeAMKyQDiRtiwqbHQB
 QNDTc4QnIPoVdaSjQ4x+E/nyEq+K8NCBbySsExqA6HsAbliqGyvL0Z6MpqDD2xGy
 cRuriV6bfABtoDSqhypSEIsEHF7EFCYMUh/oYxmDTII3cyszAPcc2f2wSKL0RH6h
 zd2Ln/+gukV0EFzyXx1mAFkpcHj6Fz+82wfBryzZm2pth8k82H/XIiZe62O7EN3N
 TKsxNuOmRMul5axAJTOIcO2n5KAPDSogb8Jn1rObkCjlS2csbX6O5M8OxmJmAQaN
 XyLTsQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25ue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398d292eac1so1241527a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324202; x=1788929002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ikxjYEykn3U+5nMggEF2/LG7xjE5m6kGU2N4izonSg4=;
 b=heppa92C8L8O8NDwomtJRSQvwzi4ZTc5hnCvOjOftJPUT3MifC+jyWIj1K5XJYjKWO
 u17Wkea9FbWn9GCPTheAkBi+fzjShoKL2uiQ1/I9V6q6p04sC1TnuV2uH17nGZrZkTBq
 W1QJ5pU/oARKvo/WOABMuSFZnxbDwGqJwr4alrLsjEle4knqIkbBeYeuRnpR78CX8Xli
 5TZwRWAPmNsMyH1NBSu4tnwEIPU9XRQa6FUB8jJXse3EmFabgGUBo6v5YVyOP8SX8Aj9
 BQnvuIlHRXq9pR07wo9IKJS/2OVj36mgz2HhfxuyTBt+eSI3VO4sYGEvBBwqoD1L803/
 ZSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324202; x=1788929002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ikxjYEykn3U+5nMggEF2/LG7xjE5m6kGU2N4izonSg4=;
 b=i0I6ZXtPGOefFH4q61JlHJKhdeKYtba2P7CyYk+7n6VpGNCO8ZruWrqn7UdOuMNjlQ
 5TjR4KtAr8BI9bpkIkPI6x6OjYvYDrkqlvwPSR+Ipm/qIuvNHjHMl058fPDJCvZOScL1
 /nyTm9Mh8yyjNTUS0wPi4C7FqQ1+bDHkXU9dSL9l4a4Uu1cPMsYlJd7UcBx6TUM2VBFr
 CyQckCbIVzCAhZZHraUJVVlJTamHueToL73wkwBr2wn1neaU9Hh7pEnaEU55CCRJmJ4b
 88+pTKpdC9Relg7YugVDZvGdZO7dz8M6SqhTKIEnJoigbSMLDYuD4YBovXZ6mjN87rR9
 9pqQ==
X-Gm-Message-State: AFuF++mfQZb1JSqCgWLBdlX4D7ifLgCUt2fHloik8sPBv5Zr/Wz7BHzI
 SzFFpmMvp5fPI6Kb+Z2znU4IrhuF6W+j4I6PnhaUW7JXSoWmkwtXrSa2YKFY0GL6sgD/nRhRF+c
 7/b4PE9bk32cKk3aC3FFBYJ8xV1g8NaPr/L8mBcSiSOKX/a1NDk7azI9QI2jjQ4Bvwg==
X-Gm-Gg: AYBFou0AMHTyV8ldQJ9MKwqFXzNo7m339MUignRbMRipwQ/W6pYsk8i63dMcc0WfSTT
 fPJFHc9c+DS/jm05uZzG9nJROrYlpaBxjxz6hkZrfOf2b0VDHqpjL6H5cwAB2JuwsIjE35fBrSR
 H8q+AbQzljLaoDa2BD1icI6IDPPNtM69/vxO94mnVzaIARjLCC8ycnUyaT1tuw3vgdsE7Qfqsin
 Eyqxrz1ivcfXcC/Y4V0cZcqV9t4Bcm9h1sb/+Ep7eGSFiXQAxmZfBKNPbUxkV+nKHTuUtqXV434
 gAmw9SuBxt1cOYWFlfz3dongx9CXSS63d18secTnK3lr7PNyqIKwWjAu7f/Zkpe6qSQLVQfPk7k
 CkdHxoUNTg3tKsdbOpB/z3xYojpybZ2b8c/SuvhMZ3cinlpK/
X-Received: by 2002:a17:90b:560e:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-39aedf5da53mr3414198a91.3.1788324202228; 
 Tue, 01 Sep 2026 21:43:22 -0700 (PDT)
X-Received: by 2002:a17:90b:560e:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-39aedf5da53mr3414143a91.3.1788324201761; 
 Tue, 01 Sep 2026 21:43:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 26/28] tests/tcg/hexagon: add icinva test
Date: Tue,  1 Sep 2026 21:42:29 -0700
Message-Id: <20260902044231.843004-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX0M293JTm/0ic
 /6RM7qaSREXdkCs3TB7FQUDjz2OoJXNn4t183MMzpqBu1/71mPCzHaUlTW0UqOrzr0f827FjBlU
 gHX+0odn2Kk43YKrat6N/1faeRtAxpxFRk6IT/wM9mtQBgX/l0JoPFgvV7T6ah2e/KEPr7v9sNz
 Za13QuCcEpPFwqGrTHTFfOfpH6ifvilS+DL+NrCGH8iyH+ljD1YLPW/GT/ySKNC8tXmnt8VTNmq
 JLeaALgc/Oh4s4X7sKt4iwhxN1KXWvOjhGd4jmSU0YhM2JGiV9WnXgyA+hVxSjb357YK8HxmggG
 G/wn9TaSWxqzjXKoZk60C3+GPHCSw854gQfK1SmhNNBo0rJSx9J8DJ208LKQ+z8vUS3FBxH/aOP
 zAL4bD/QnMdKUSLjxAL+JvSRyQpOEKMNlFLvqxIhcejy26nmD2HQaoGL0pJCTy0YD0Byud2R+/r
 J490Up+V1ghrDkkqAIA==
X-Proofpoint-GUID: C1s7VMrHE43CD12swDzWA4BZ-7hO8a1V
X-Proofpoint-ORIG-GUID: C1s7VMrHE43CD12swDzWA4BZ-7hO8a1V
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a96a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7vJHg93iHWy1kEV8rwgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX+nTgmvDbL+D/
 /aIlT1klfC/PqBIK836Sgf4p51E1rZp/9AWGG+72aKcVYT4Zik2vYVl57/sJhovtH/Y+cjJV4pE
 GvzcXai+pmxAyUI9AuWSKJrP8GVCl24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2ljaW52YS5jICAgICAgICB8IDcwICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRh
cmdldCB8ICAyICsKIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2ljaW52YS5jCgpkaWZmIC0tZ2l0IGEvdGVzdHMv
dGNnL2hleGFnb24vaWNpbnZhLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9pY2ludmEuYwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uYzc1YWRlYzY3NzkKLS0tIC9kZXYvbnVs
bAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9pY2ludmEuYwpAQCAtMCwwICsxLDcwIEBACisvKgor
ICogVGVzdCB0aGF0IGljaW52YSBlbmRzIHRoZSBjdXJyZW50IHRyYW5zbGF0aW9uIGJsb2NrLgor
ICoKKyAqIGljaW52YSBvbmx5IGludmFsaWRhdGVzIHRoZSBlbXVsYXRvcidzIGNhY2hlZCB0cmFu
c2xhdGlvbiBmb3IgYQorICogY29kZSByYW5nZTsgaXQgZG9lc24ndCByZXRyb2FjdGl2ZWx5IGZp
eCB1cCBjb2RlIHRoYXQgaGFzIGFscmVhZHkKKyAqIGJlZW4gZGVjb2RlZCBhcyBwYXJ0IG9mIHRo
ZSBzdGlsbC1leGVjdXRpbmcgdHJhbnNsYXRpb24gYmxvY2suIElmCisgKiBpY2ludmEgZG9lc24n
dCBmb3JjZSBhIG5ldyBUQiB0byBzdGFydCByaWdodCBhZnRlciBpdCwgYSBwYWNrZXQKKyAqIHBh
dGNoZWQgdmlhIGEgc3RvcmUgaW1tZWRpYXRlbHkgYmVmb3JlIGljaW52YSAod2l0aCBubworICog
Y2hhbmdlLW9mLWZsb3cgaW4gYmV0d2Vlbikgc3RpbGwgcnVucyB0aGUgc3RhbGUgZGVjb2RlIGJh
a2VkIGludG8KKyAqIHRoZSBjdXJyZW50IFRCIGluc3RlYWQgb2YgdGhlIGZyZXNobHktcGF0Y2hl
ZCBpbnN0cnVjdGlvbi4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2ll
cywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVk
ZSA8c3RkaW50Lmg+CisjaW5jbHVkZSA8c3lzL21tYW4uaD4KKworaW50IGVycjsKKworI2luY2x1
ZGUgImhleF90ZXN0LmgiCisKKy8qIEVuY29kaW5nIG9mICJyMCA9ICM5OSIgKi8KKyNkZWZpbmUg
SUNJTlZBX05FV19JTlNOIDB4NzgwMGNjNjAKKworc3RhdGljIHVpbnQzMl90IF9fYXR0cmlidXRl
X18oKG5vaW5saW5lKSkgdGVzdF9pY2ludmFfc21jKHZvaWQpCit7CisgICAgdWludDMyX3QgcmVz
dWx0OworCisgICAgLyoKKyAgICAgKiByMSA9IGFkZHJlc3Mgb2YgdGhlICJwYXRjaF9zbG90IiBw
YWNrZXQgYmVsb3cgKDE6KQorICAgICAqIE92ZXJ3cml0ZSBpdCB3aXRoIHRoZSAicjAgPSAjOTki
IGVuY29kaW5nLCBpbnZhbGlkYXRlIHRoZQorICAgICAqIGljYWNoZSBmb3IgdGhhdCBhZGRyZXNz
LCB0aGVuIGZhbGwgc3RyYWlnaHQgdGhyb3VnaCBpbnRvIGl0CisgICAgICogd2l0aCBubyBpbnRl
cnZlbmluZyBqdW1wL2NhbGwuCisgICAgICovCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAi
cjEgPSAjIzFmXG4iCisgICAgICAgICJyMiA9ICMjJVtuZXdpbnNuXVxuIgorICAgICAgICAibWVt
dyhyMSkgPSByMlxuIgorICAgICAgICAiaWNpbnZhKHIxKVxuIgorICAgICAgICAiMTpcbiIKKyAg
ICAgICAgIiAgIHIwID0gIzExXG4iCisgICAgICAgICIlW291dF0gPSByMFxuIgorICAgICAgICA6
IFtvdXRdICI9ciIocmVzdWx0KQorICAgICAgICA6IFtuZXdpbnNuXSAiaSIoSUNJTlZBX05FV19J
TlNOKQorICAgICAgICA6ICJyMCIsICJyMSIsICJyMiIsICJtZW1vcnkiCisgICAgKTsKKworICAg
IHJldHVybiByZXN1bHQ7Cit9CisKK2ludCBtYWluKHZvaWQpCit7CisgICAgaW50IHBhZ2VzaXpl
ID0gNDA5NjsKKyAgICB1aW50cHRyX3QgcGFnZSA9ICh1aW50cHRyX3QpdGVzdF9pY2ludmFfc21j
ICYgfihwYWdlc2l6ZSAtIDEpOworICAgIHVpbnQzMl90IHJlc3VsdDsKKworICAgIGlmIChtcHJv
dGVjdCgodm9pZCAqKXBhZ2UsIDIgKiBwYWdlc2l6ZSwKKyAgICAgICAgICAgICAgICAgUFJPVF9S
RUFEIHwgUFJPVF9XUklURSB8IFBST1RfRVhFQykgIT0gMCkgeworICAgICAgICBwZXJyb3IoIm1w
cm90ZWN0Iik7CisgICAgICAgIHJldHVybiAxOworICAgIH0KKworICAgIHJlc3VsdCA9IHRlc3Rf
aWNpbnZhX3NtYygpOworICAgIGNoZWNrMzIocmVzdWx0LCA5OSk7CisKKyAgICBwdXRzKGVyciA/
ICJGQUlMIiA6ICJQQVNTIik7CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3Rz
L3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCBiL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxl
LnRhcmdldAppbmRleCA2NDFmNmJjMTBlNy4uZjcyYmI4YTZiNDUgMTAwNjQ0Ci0tLSBhL3Rlc3Rz
L3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtl
ZmlsZS50YXJnZXQKQEAgLTYxLDYgKzYxLDcgQEAgSEVYX1RFU1RTICs9IG11bHRpcGxlLXdyaXRl
cwogSEVYX1RFU1RTICs9IHByaXZpbGVnZWQtaW5zbgogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9w
YwogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9kYXRhCitIRVhfVEVTVFMgKz0gaWNpbnZhCiAKIEhF
WF9URVNUUyArPSB0ZXN0X2FicwogSEVYX1RFU1RTICs9IHRlc3RfYml0Y250CkBAIC0xMDQsNiAr
MTA1LDcgQEAgY2lyYzogY2lyYy5jIGhleF90ZXN0LmgKIGR1YWxfc3RvcmVzOiBkdWFsX3N0b3Jl
cy5jIGhleF90ZXN0LmgKIGZwc3R1ZmY6IGZwc3R1ZmYuYyBoZXhfdGVzdC5oCiBoZXhfc2lnc2Vn
djogaGV4X3NpZ3NlZ3YuYyBoZXhfdGVzdC5oCitpY2ludmE6IGljaW52YS5jIGhleF90ZXN0LmgK
IGxvYWRfYWxpZ246IGxvYWRfYWxpZ24uYyBoZXhfdGVzdC5oCiBsb2FkX3VucGFjazogbG9hZF91
bnBhY2suYyBoZXhfdGVzdC5oCiBtZW1fbm9zaHVmX2V4Y2VwdGlvbjogbWVtX25vc2h1Zl9leGNl
cHRpb24uYyBoZXhfdGVzdC5oCi0tIAoyLjM0LjEKCg==

