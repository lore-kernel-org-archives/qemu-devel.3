Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A28C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2a-0006pd-4b; Fri, 17 Jul 2026 15:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2Y-0006oV-3w
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2W-00084h-IA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGoC4q2245302
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KsCgaxXgQZRglc26o60q1xAo+WS9Co5pcgBKtlNLAGk=; b=oPhC+cJoMQ6sFkl4
 6ZiNdJGdtIw1YFd+XKMPDi19idUPoa+T5PuoCpfEM6iRUb8tSozPop/NGjs07wdX
 ns2OZJeWpB4xLMWGG0Ixu6cLMhdhTcfVSpXLluiMnZ83hCrUBfK3brNazWfZkFnR
 /1JsApr0DYNZpAGh9AKdka/qkou2pxNvSRalBADmF+2UJ73i0SUixmqvXQTxU+9i
 D1lh2Ul5Vz9XILH4I2aF0B5+t8RUsgKsnpl5Srussumb9WYXauSn75Jq7qpR0DOT
 XIxUQuoYx5bWR7WbmI8CfEEmYyZlehQrWtAr0XqnhVwTKeEzpW6Ic8tdK/lJdypj
 lNqGvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pay3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38869800848so12250721a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315762; x=1784920562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KsCgaxXgQZRglc26o60q1xAo+WS9Co5pcgBKtlNLAGk=;
 b=dF2sul/6JVsgh7yxffxc8UBAb0KNZFncibFGL0z88+Jedo86TP2bZjYe/KgLJMzOfj
 xcsmaEOwr7EK6cmebUNym/NrtBQNPdPgMCFGA9SDifPlHGGxuswEPa1T5bPPxxw/paym
 yUbD902kE8ogEion03o0KEzRJ23ZYxYwbj3rD+AupZhrYO8DzSh/frmJDZmI2pM3+ha+
 pq+VbpCx83iIENxah9LCHS/Cb5krXSF4UOYp1PteVnujZHf4IJB/XFeuP/mRangOyGKz
 DK1eR6ruog3XQwbOy2+FrdvzaSGcXklpV4UzbeVtZ6NNCmdhTE0TyLBmFzU8EMFLaoGC
 KXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315762; x=1784920562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KsCgaxXgQZRglc26o60q1xAo+WS9Co5pcgBKtlNLAGk=;
 b=Qw6EL68GlipO1LLJJhrkmDAN8MAYvesIeJegvR1fnXGS1CFFhetZQpjzaE0CCBiibe
 opXNals9cyTFZfZ4S2i+HMrI376wtS4Np0cJkqcFxIXbTrAOM/3bpjFEn38bMB7OQnrQ
 HD+UPyf7lc82EpyKHFkgYPld4YukukOIm4ev8RsWsa2xs6N+/JvPK7IvyAiz7ZAPaHpD
 6QzMkB9fhv/yZWyqyzf/udwpmHQ3bBKCnl+RLgYpCLmd2CpZhnEn2CsmvyfT5IIzvoCE
 Y4VDP7G8kHsxlUk4Oxzm6pQjZCBZJBeVjWNGdHsfquoxq/utr6Uz3xciN2PntjmBO58Z
 du/Q==
X-Gm-Message-State: AOJu0YzlOgg0/vafXJK5sbp/OGTWLFXfQZP27F2o7RpBHxkYPwRXVbb5
 TSbmEZsgr/2BuBnvtQA3NbKHKB/0mNKV43rTk5Y0hN74oMPb00H3+dc2U17kVETdCRWVzTYFgJr
 ig26dyDeLGVEYVzRSLrTkC40CnIsRUCRlR2/t260oOqFEHOL4ZzuKnwKP637T7rIYYg==
X-Gm-Gg: AfdE7cluEbAHvPmBvwRHYp5977J+84MBAm6kFDxBPIMUutvcNi4z5h1OemQ+kZonfb2
 eXDbySnDeMrlEdvjrR7foxllP/L7D7RipIrm5be2H8ER34AiiwO5MNzabsl84UXTAQ09GS6O58J
 oxCQDaP1WiyGsmQ/ZS5aZLIzOtCRVAkvukc66Ya7QC68OJn3hAio0CAYtPkho/UG2OQ8O00Ikre
 v2kDtlYSYVAC1jMEHXVu6oy9BmKfEEICRiZIUGu+mfOacNiSdR5mTfx97l2Gurk7E+z7gMmZjBJ
 Hxpv0ZC2FztafuqlwzsVPcpEfkB4ldgo9Ei0PU6yaAhiSUlVCX+E1rzRieZVACqpf07TYTJtw7f
 ZT76yQ/5TntYc8W3F78Xtp2M6/8JL8knVdvCP66ZHve4+CRv9
X-Received: by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e4b3e1424mr3976173a91.2.1784315761696; 
 Fri, 17 Jul 2026 12:16:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e4b3e1424mr3976126a91.2.1784315761142; 
 Fri, 17 Jul 2026 12:16:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:16:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PULL 06/12] target/hexagon: raise SIGBUS on unaligned scalar stores
Date: Fri, 17 Jul 2026 12:15:41 -0700
Message-Id: <20260717191547.920048-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: N8l47iohQmSX1XmngtUpCMSpl4nMuPNt
X-Proofpoint-ORIG-GUID: N8l47iohQmSX1XmngtUpCMSpl4nMuPNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX0vD6VdcFyzz0
 pTNGNVdkG8VDye1V6/83JhRlWoJk5lK+SvUZQlb2ede7iFDVNvCJ31ZjmE0xJmdx97TJojaX6oI
 jbDjN0qbzJ/py3tU7Ly+NIKjOzzWQDs+bUUTgRK/QAqfuCIVuTbCopIr3V26l70BdxHbL+RmQq2
 65Cv+Fe70DMAlu1m3aNDPqQXWwgg7F0OghRPcMdqOmLrfljicO9GzO8HpHm9Vxhc3R6fm9s4lsn
 /54aCVddOzgKB7xwpVU6Rgq3yWZWIu9gjKsSdkpsNAscDHOKQ6dYurRt9Lq0gtkEEszQsST9Ec6
 rnnMzcX4Cj8V7ROWDO7G3YTTO2EJFvl0/0t7LI4cAKwOxyjm+bL4TVw+ADdhal7SGYXmprxatIu
 rUfKZdIaxwfda+PKdAl6+RFrgdqApw57Ih6L6I5cRAyOToKoyqJZsMIFx0Dm3DN9ODsGuoJ6W7I
 GWBrGUTANAR9vWJoDwQ==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a7f72 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MHlpfT5McVMPhJjrq0IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX97kw30WlTjMg
 1XkY1sO0VL2MGgBzUyJNfZsPrgpVBeF0DQr/eR4mwDN0Yr1YRy5wQyrKP8LhBA/MneegFVEge8S
 twkvdVhHamjmrlu45vc+WzxuIK8dtok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

aGV4YWdvbi1saW51eC11c2VyIGhhZCBubyBlbmZvcmNlbWVudCBvZiBhbGlnbm1lbnQgZm9yIHNj
YWxhciBzdG9yZQpleGNlcHRpb25zLCBhbmQgdW5hbGlnbmVkIHN0b3JlcyBzaWxlbnRseSBzdWNj
ZWVkZWQgaW5zdGVhZCBvZiByYWlzaW5nClNJR0JVUy4KClN0b3JlcyBhcmUgbG9nZ2VkIHJhdGhl
ciB0aGFuIGNvbW1pdHRlZCBpbW1lZGlhdGVseSwgc28gYm90aCBjb21taXQKcGF0aHMgbmVlZCB0
aGUgZml4LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5v
IDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2dlbnB0ci5jICAgIHwgIDQgKystLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAxMyAr
KysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8ICA2ICsrKy0tLQogMyBm
aWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKaW5k
ZXggMDVjOWFhMDQ0NjcuLmY0OGEyN2JjMDliIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9n
ZW5wdHIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtNDk1LDcgKzQ5NSw3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc3RvcmVfY29uZGl0aW9uYWw0KERpc2FzQ29udGV4dCAq
Y3R4LAogICAgIHplcm8gPSB0Y2dfY29uc3RhbnRfdGwoMCk7CiAgICAgdG1wID0gdGNnX3RlbXBf
bmV3KCk7CiAgICAgdGNnX2dlbl9hdG9taWNfY21weGNoZ190bCh0bXAsIGhleF9sbHNjX2FkZHIs
IGhleF9sbHNjX3ZhbCwgc3JjLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5t
ZW1faWR4LCBNT18zMik7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPm1lbV9p
ZHgsIE1PXzMyIHwgTU9fQUxJR04pOwogICAgIHRjZ19nZW5fbW92Y29uZF90bChUQ0dfQ09ORF9F
USwgcHJlZCwgdG1wLCBoZXhfbGxzY192YWwsCiAgICAgICAgICAgICAgICAgICAgICAgIG9uZSwg
emVybyk7CiAgICAgdGNnX2dlbl9icihkb25lKTsKQEAgLTUyMCw3ICs1MjAsNyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgZ2VuX3N0b3JlX2NvbmRpdGlvbmFsOChEaXNhc0NvbnRleHQgKmN0eCwKICAg
ICB6ZXJvID0gdGNnX2NvbnN0YW50X2k2NCgwKTsKICAgICB0bXAgPSB0Y2dfdGVtcF9uZXdfaTY0
KCk7CiAgICAgdGNnX2dlbl9hdG9taWNfY21weGNoZ19pNjQodG1wLCBoZXhfbGxzY19hZGRyLCBo
ZXhfbGxzY192YWxfaTY0LCBzcmMsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4
LT5tZW1faWR4LCBNT182NCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5t
ZW1faWR4LCBNT182NCB8IE1PX0FMSUdOKTsKICAgICB0Y2dfZ2VuX21vdmNvbmRfaTY0KFRDR19D
T05EX0VRLCB0bXAsIHRtcCwgaGV4X2xsc2NfdmFsX2k2NCwKICAgICAgICAgICAgICAgICAgICAg
ICAgIG9uZSwgemVybyk7CiAgICAgdGNnX2dlbl9leHRybF9pNjRfaTMyKHByZWQsIHRtcCk7CmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCmluZGV4IDEyNTk1MmFlZTU5Li4zY2UyMjNjYWJhMyAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMK
QEAgLTk1LDE5ICs5NSwyNiBAQCBzdGF0aWMgdm9pZCBjb21taXRfc3RvcmUoQ1BVSGV4YWdvblN0
YXRlICplbnYsIGludCBzbG90X251bSwgdWludHB0cl90IHJhKQogewogICAgIHVpbnQzMl90IHdp
ZHRoID0gZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90X251bV0ud2lkdGg7CiAgICAgdGFyZ2V0X3Vs
b25nIHZhID0gZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90X251bV0udmE7CisgICAgTWVtT3BJZHgg
b2k7CiAKICAgICBzd2l0Y2ggKHdpZHRoKSB7CiAgICAgY2FzZSAxOgogICAgICAgICBjcHVfc3Ri
X2RhdGFfcmEoZW52LCB2YSwgZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90X251bV0uZGF0YTMyLCBy
YSk7CiAgICAgICAgIGJyZWFrOwogICAgIGNhc2UgMjoKLSAgICAgICAgY3B1X3N0d19sZV9kYXRh
X3JhKGVudiwgdmEsIGVudi0+bWVtX2xvZ19zdG9yZXNbc2xvdF9udW1dLmRhdGEzMiwgcmEpOwor
ICAgICAgICBvaSA9IG1ha2VfbWVtb3BfaWR4KE1PX0xFVVcgfCBNT19BTElHTiwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjcHVfbW11X2luZGV4KGVudl9jcHUoZW52KSwgZmFsc2UpKTsK
KyAgICAgICAgY3B1X3N0d19tbXUoZW52LCB2YSwgZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90X251
bV0uZGF0YTMyLCBvaSwgcmEpOwogICAgICAgICBicmVhazsKICAgICBjYXNlIDQ6Ci0gICAgICAg
IGNwdV9zdGxfbGVfZGF0YV9yYShlbnYsIHZhLCBlbnYtPm1lbV9sb2dfc3RvcmVzW3Nsb3RfbnVt
XS5kYXRhMzIsIHJhKTsKKyAgICAgICAgb2kgPSBtYWtlX21lbW9wX2lkeChNT19MRVVMIHwgTU9f
QUxJR04sCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X21tdV9pbmRleChlbnZfY3B1
KGVudiksIGZhbHNlKSk7CisgICAgICAgIGNwdV9zdGxfbW11KGVudiwgdmEsIGVudi0+bWVtX2xv
Z19zdG9yZXNbc2xvdF9udW1dLmRhdGEzMiwgb2ksIHJhKTsKICAgICAgICAgYnJlYWs7CiAgICAg
Y2FzZSA4OgotICAgICAgICBjcHVfc3RxX2xlX2RhdGFfcmEoZW52LCB2YSwgZW52LT5tZW1fbG9n
X3N0b3Jlc1tzbG90X251bV0uZGF0YTY0LCByYSk7CisgICAgICAgIG9pID0gbWFrZV9tZW1vcF9p
ZHgoTU9fTEVVUSB8IE1PX0FMSUdOLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV9t
bXVfaW5kZXgoZW52X2NwdShlbnYpLCBmYWxzZSkpOworICAgICAgICBjcHVfc3RxX21tdShlbnYs
IHZhLCBlbnYtPm1lbV9sb2dfc3RvcmVzW3Nsb3RfbnVtXS5kYXRhNjQsIG9pLCByYSk7CiAgICAg
ICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6CiAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jCmluZGV4IDc3MjM1OTE2ZjRiLi41ZDU0Y2U4Y2FhNCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmMKQEAgLTg5NiwxNyArODk2LDE3IEBAIHZvaWQgcHJvY2Vzc19zdG9yZShEaXNhc0NvbnRleHQg
KmN0eCwgaW50IHNsb3RfbnVtKQogICAgICAgICBjYXNlIDI6CiAgICAgICAgICAgICB0Y2dfZ2Vu
X3FlbXVfc3RfdGwoaGV4X3N0b3JlX3ZhbDMyW3Nsb3RfbnVtXSwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBoZXhfc3RvcmVfYWRkcltzbG90X251bV0sCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY3R4LT5tZW1faWR4LCBNT19MRSB8IE1PX1VXKTsKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjdHgtPm1lbV9pZHgsIE1PX0xFIHwgTU9fVVcgfCBNT19BTElH
Tik7CiAgICAgICAgICAgICBicmVhazsKICAgICAgICAgY2FzZSA0OgogICAgICAgICAgICAgdGNn
X2dlbl9xZW11X3N0X3RsKGhleF9zdG9yZV92YWwzMltzbG90X251bV0sCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaGV4X3N0b3JlX2FkZHJbc2xvdF9udW1dLAotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGN0eC0+bWVtX2lkeCwgTU9fTEUgfCBNT19VTCk7CisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5tZW1faWR4LCBNT19MRSB8IE1PX1VMIHwgTU9f
QUxJR04pOwogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgODoKICAgICAgICAgICAg
IHRjZ19nZW5fcWVtdV9zdF9pNjQoaGV4X3N0b3JlX3ZhbDY0W3Nsb3RfbnVtXSwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaGV4X3N0b3JlX2FkZHJbc2xvdF9udW1dLAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPm1lbV9pZHgsIE1PX0xFIHwgTU9fVVEpOwor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPm1lbV9pZHgsIE1PX0xFIHwgTU9f
VVEgfCBNT19BTElHTik7CiAgICAgICAgICAgICBicmVhazsKICAgICAgICAgZGVmYXVsdDoKICAg
ICAgICAgICAgIHsKLS0gCjIuMzQuMQoK

