Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28B9C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2VK-0000BS-7j; Wed, 12 Aug 2026 02:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Uk-00086G-Eq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:31:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Ui-0003wP-Nf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:31:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62Bnv3506105
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NGriTnLoz2RElF9KQ1Lq7rPTXvqV1eVC9zv9DU0v1dY=; b=ZFAVPDSDjHTO9LZr
 Ut4rIpik6SREdVT6MDA65ef6fxtON/8U0ZqPGH4CLqaSnqvZC+tG2UmS6XS85n8s
 LnijMEqceAjVNkSP992bh/BnIoS+DpPVD3aXEOV0ln0isOLgOSrh4kQfQ/A0PcFJ
 owKu5ru+3HSdqgO3EDxKB3iIh+tonn4K05N7iL6Ys5PYRh0GRxmKD3Sv8CgMwI67
 cnTeQAn4Hbfn4X1vASscH5Emhc1PrdNokV04KCOn+8qchTg8jRQfWT2jmSXg0fIW
 XyqVA1RrxJUz2ZRYxb+4lSMUCZnYgQK/p6nIR5cPmndX2DxFroMmzG0kfpEXaQx8
 gCnNZw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5jens-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:31:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1109798a91.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516268; x=1787121068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NGriTnLoz2RElF9KQ1Lq7rPTXvqV1eVC9zv9DU0v1dY=;
 b=iKN+AYJ00wV80uRzFknlQiesllgi7bYKMwmNl4tfKT7k0vng/jBvBh3WX928glD5ro
 /VXYP7UsEYmyIq1jVrMsb+HTFGnryJIQZMwqrMoJZy8gR1CktzzlhtLc2uQFHzVximU2
 rk8ek4uWAM6r2vw2v5eW3HjuSls9C9rUGgTatubeaWzifofmu2510libZwcpXMqemE2C
 9+mnf/3jVKCK4k4DK+AN7FJIJUHRhhAKOIVoBhKBq1CAaX1AbgVd1JfCtaWPhrQBJ3hA
 eqpIldPLsEd2r6FY3i78AS3YphOSCuD1YKBWAjPQNgk0ArZfv54R2BRB3W1C9w93Pis1
 So9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516268; x=1787121068;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGriTnLoz2RElF9KQ1Lq7rPTXvqV1eVC9zv9DU0v1dY=;
 b=SQLPguO3TwMFgEvWpgSMVte69nB8TLYo4IRj9CiLMa9LFowcKDKaaz9Du5/jFURRk6
 P17zHxjOJxpj0me5ug9xqbdtT1gGJBr8Bsi3+o5v7xsfdlLQyMK1HYng/avO2ex14Qw3
 7AseeFFlZLzfbpsMdWTYyvntGG9q9TuuREKTejulcyBM/DMVL94yJDqysZ3KlOP+e7Ec
 zW+Gf2S6+LPB4rgPVkTMyB/IxELGLKECIb8lGKmDIfVkAraTvELk28g93FFi5SEo0hXT
 rGJres9V8j1e7rmdXbyvB4AsxaL5SBkEtYvfJe0SyOUkQP1KBD6DB4UsdrpwUQwfrkMr
 vuEw==
X-Gm-Message-State: AOJu0YweOOaMzuhtvWfWqTkXfuIk58ZsEOBmrUYiWis9L+PY5O7vqY96
 c3q+kpA0O1Qv9HnfDZvqkCe1UWCviE9UgEukCQd2YHIau0xU9N4fTFcQEY6lUE03SYvitWgaFPj
 HTMKZ1YPb8jhAyQdadapClY2i68MgFTf9VSU7JG8kvDR51YnvTxsx/TVBLbspulWlEQ==
X-Gm-Gg: AR+sD138SCZtmAblxcbwI6s22JsEPQ7wG83ceqt2oJmn8XyUA8u8xHt/Wg6gQnbNhlv
 atKpROrcg3u9Y//QeecH6l2ao1j6Rfi4Ly/MRSKRvDni+THn+IZb8AcFo33XDroip+FLniY1NzG
 uUxX2Ex+X0qaEpeG0YFapZzmTrDvwmP3r4/QhZfbUApnm3AqLu0e8BW84K5y1WrCYQ/6yRcJqND
 WR4q7cqNup8X2dFWDaYSwIUD5PlXMlhalS4C4kViqU3bCYchTkz9Sj3sNk91ZHUNfVsbfOW2b3q
 jL7F8JUYXv8YqXLDNGqt5uU4RxydFx4mrXCxc60nrtoAvPk9gPTrg05EM2ku26iHr+xx5znkTJO
 NgRh6jaOisUkrYCk1OnKWxIf1+jLjTEGrXLbNjhD+8UbN/CZ9
X-Received: by 2002:a17:90b:5112:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3930144caa2mr3277482a91.17.1786516268217; 
 Tue, 11 Aug 2026 23:31:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3930144caa2mr3277421a91.17.1786516267671; 
 Tue, 11 Aug 2026 23:31:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:31:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 38/41] tests/hexagon: add tests for v68 HVX IEEE float min/max
Date: Tue, 11 Aug 2026 23:29:29 -0700
Message-Id: <20260812062932.543840-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX+faDPVOkgHFp
 7+INkIn66UfniIEf+xaMBGpTCvMPxvjyOR/7wHCv/pBJMd5/jO7tKXpwy+EA1J1bp9uzmvDLnMF
 EByr7+BInkE7RD+bbOUDTsmUf/sv0To=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c132d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=kx3085Z4g_GOeJDqwkIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: eWcpotb4eJAGciCEtaqHzPPqG7ABkMZ6
X-Proofpoint-ORIG-GUID: eWcpotb4eJAGciCEtaqHzPPqG7ABkMZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX/KsqLZwtygnk
 I/GhZEexuGXO2wVlluDRl7xwpcVNqsXqaCKzBpGxpw1DOVOf5T/ag4R/GgOBL2JdJm2qVvu+aCL
 sFFnur0B63dYLgpJrOCeh7i5iEHIWXoijaF5SI9YAp/sXv2FHfh7OkVP6ukyUuVZ3lUJv41vzp1
 NfiTh9PQDr4GYGDFsVb65o2zBj6OEteFEt/QWlXnYxGKgPm5GDBEfVB2BDFd5LPXSueFSEm5hov
 z3ZI916PAFlzJoB2OiLI5JC56xVNBl/g6gDgs8xkOMdEOmjoqm/n0MysEzzxJQju2YlHsBuDrGo
 LDU8XQCUZy+Z2lQZdaaYLVElgiiBAsCPV9X5msIxqOLQ1rLY+KWkEdMQiIBY8OE01UCIEdgMSG6
 kOqdbehOB4SioY2XJPxB+QgG4qwwjLeG62/lRv51pZl6teOWg4NkYUJbxeiarj5q4qaEiOpdol5
 x4bUBehgSujnYSAZCcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120050
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNv
bkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxt
YXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC83ZmRiYzEyZWQ0YzYyYTE2MDY4YzM4MGE4NWVlMjM1NjA1MWU2MWVh
LjE3NzYzMzk0NTEuZ2l0Lm1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
ZXN0cy90Y2cvaGV4YWdvbi9mcF9odnguYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0
cy90Y2cvaGV4YWdvbi9mcF9odnguYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ZwX2h2eC5jCmluZGV4
IGEzMDk2NTRlZDc4Li5kZWUwNzgxYmQ3MiAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24v
ZnBfaHZ4LmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vZnBfaHZ4LmMKQEAgLTczLDYgKzczLDMw
IEBAIERFRl9URVNUX09QXzIodnN1YiwgU1VCX0hGLCBoZiwgaGYpOwogREVGX1RFU1RfT1BfMih2
bXB5LCBNVUxUX1NGLCBzZiwgc2YpOwogREVGX1RFU1RfT1BfMih2bXB5LCBNVUxUX0hGLCBoZiwg
aGYpOwogCisjZGVmaW5lIHNpZ25iaXRfZnAoWCkgXAorICAgIChzaXplb2YoWCkgPT0gYnl0ZXNf
aGYgPyAoKHJhd19oZihYKSAmIDB4ODAwMCkgIT0gMCkgOiBcCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICgocmF3X3NmKFgpICYgMHg4MDAwMDAwMCkgIT0gMCkpCisKKyNkZWZpbmUgU1RE
X01JTihYLCBZKSAoKFgpIDwgKFkpID8gKFgpIDogKFkpKQorI2RlZmluZSBTVERfTUFYKFgsIFkp
ICgoWCkgPiAoWSkgPyAoWCkgOiAoWSkpCisKKyNkZWZpbmUgTUlOKFgsIFksIERFRl9OQU4pIFwK
KyAgICAoKGlzbmFuKFgpIHx8IGlzbmFuKFkpKSA/IERFRl9OQU4gOiBcCisgICAgICgoWCkgIT0g
KFkpKSA/IFNURF9NSU4oWCwgWSkgOiAoc2lnbmJpdF9mcChYKSA/IChYKSA6IChZKSkpIC8qIC0w
IDwgKzAgKi8KKyNkZWZpbmUgTUFYKFgsIFksIERFRl9OQU4pIFwKKyAgICAoKGlzbmFuKFgpIHx8
IGlzbmFuKFkpKSA/IERFRl9OQU4gOiBcCisgICAgICgoWCkgIT0gKFkpKSA/IFNURF9NQVgoWCwg
WSkgOiAoc2lnbmJpdF9mcChYKSA/IChZKSA6IChYKSkpIC8qIC0wIDwgKzAgKi8KKworI2RlZmlu
ZSBNSU5fSEYoWCwgWSkgTUlOKFgsIFksIE5BTl9IRikKKyNkZWZpbmUgTUFYX0hGKFgsIFkpIE1B
WChYLCBZLCBOQU5fSEYpCisjZGVmaW5lIE1JTl9TRihYLCBZKSBNSU4oWCwgWSwgTkFOX1NGKQor
I2RlZmluZSBNQVhfU0YoWCwgWSkgTUFYKFgsIFksIE5BTl9TRikKKworREVGX1RFU1RfT1BfMih2
Zm1pbiwgTUlOX1NGLCBzZiwgc2YpOworREVGX1RFU1RfT1BfMih2Zm1heCwgTUFYX1NGLCBzZiwg
c2YpOworREVGX1RFU1RfT1BfMih2Zm1pbiwgTUlOX0hGLCBoZiwgaGYpOworREVGX1RFU1RfT1Bf
Mih2Zm1heCwgTUFYX0hGLCBoZiwgaGYpOworCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgKiBP
dGhlciB0ZXN0cwogICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwpAQCAtMTUwLDYgKzE3NCwxMiBAQCBp
bnQgbWFpbih2b2lkKQogCiAgICAgdGVzdF9uZXcoKTsKIAorICAgIC8qIG1pbi9tYXggKi8KKyAg
ICB0ZXN0X3ZmbWluX3NmX3NmKCk7CisgICAgdGVzdF92Zm1pbl9oZl9oZigpOworICAgIHRlc3Rf
dmZtYXhfc2Zfc2YoKTsKKyAgICB0ZXN0X3ZmbWF4X2hmX2hmKCk7CisKICAgICBwdXRzKGVyciA/
ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEgOiAwOwogfQotLSAKMi4zNC4x
Cgo=

