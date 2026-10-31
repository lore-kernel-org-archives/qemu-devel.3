Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB94606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e2BhZaOW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I1o5AEKv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwh-0006lq-8S; Fri, 30 Oct 2026 21:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxw9-0005LF-Jc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxw7-00038U-Ih
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CEWH749350
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U6j0LayafTjACZ3jsnzLhz3tYQtN7hSfMNUoUn458+o=; b=e2BhZaOWacjvRnl+
 j8FS2Srb+tPoyEWJ3pwTlQ/OgtEEDArmoa9AHPJYrFSLJij0Bbb5eyShcdcw6unZ
 LZcyWaDRRHQ+bkBwOSoOAeD7K51vxawkHZVD8mgX9qcxndos42crJ+owAFUcSD1H
 HuGGw7KDSuxi8GCK6U2fDXVnP88Vm3djLEZ1srBLLFWf91kEPyRp9Kt+Tx59r41W
 a9FLewHrMnvHFvKku52qzUUpmSLO1+z2sRV8JXfQGjkTmgcansg/gm9zDaKg+kDV
 Fot78W1JDST6ws/OUyLofu3kqO2bApHgyKflRvGgESCLkgBsdH9dKr7I6dHsmtXF
 hIoiQQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x00mu4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so5292249eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410259; x=1794015059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U6j0LayafTjACZ3jsnzLhz3tYQtN7hSfMNUoUn458+o=;
 b=I1o5AEKv47NKZVDiWVgPL0rNVdsoD2mFxhE8cvnyzKThNfzNZAV+qEGXF+qr5n6l5B
 Y6C9rgUGQi50awwBkRerf0010+Z1D4yveNCNsL3+L6y7cU4swPJSBnUf5XlnWUzomE43
 Pl67RuljccbiF3Y9oUXj3PghHt2oS238mushGg+ZilQZZQBC7ASO25J/RlFwfWFAUs/E
 2pOx9yir9vqvAJ7dU6oBLegqtUJRYva1aGHzTQFQUHRWd3zx1dkTtjUOGx/9L3LnpzGt
 xgA/54YgF5rbWyaadfNr0GdlZHJFvfewaQIbqTyxmMSxsydk7DmpnRL27Bmbye55uhlt
 UcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410259; x=1794015059;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U6j0LayafTjACZ3jsnzLhz3tYQtN7hSfMNUoUn458+o=;
 b=JDon68TvFIYgfto2yIl4PuNJzHI53XcQoZLWfwwtwFtLq12PFMEeO3rrPYL85URIEL
 RPfd6KmlSiQAROH6fWdEZ1NBIQRn2oVrxDWys2t+Tk8eqoc7JltOoITSUgx99ZDo4Gpp
 /9xPSRlEkgz7j3EZ36TyTy/B4ogbr8tXNj28smAeN1gQsq8hGXVbjX8Bs9ySu1UGWK33
 CHoBJbVMba9G6ryiVNzYa7q0aN/ZTt0Ei9MtsO045mW2q9cVQr8n7IUJu5r40gd3P6tk
 wSnTMH5yQfU99TQ7g50yNWtv7+1TWKEQtR5YNhhiehSf3GL53FpbOjwmUNkOw0PrItLG
 5H8g==
X-Gm-Message-State: AFq9FYICs9zwLi/6Jt4SGDDdHjMm+6bXknCrpBmlKc0YE0hlSNABmDVp
 No/8Oo4UdiFWPFOed8cou7wtXxf/RRQ1ECIX9uOoulnL4p1PzItFSi4RBlH64G8eVyKJLwOzYlB
 OGUxnnBo5+0c/WQyAenkJ6HFrTSOfL/EdQ/61JngqFty5YZ0JYEfxRmlXbzdQzv77xw==
X-Gm-Gg: AYBFou3gSWZxRrSxhR06O3h/b0tcGG3hUt5u8YjVLteBClW6IftQcd0vvVaBbfsfdXv
 Y6lJMww9ODhXiKUaCGOm7jeEDwrhXTPosJd+tXeyOv59CR2WXVYr66HlFWOUtpholAIIziwilPN
 h6lWeYDIcf+4yKhpNdX3rs+jC5cwu2sT6EHDe9vhN2nD46DNQSb9yQ3cEpvubuzm0kd3SR48UYi
 qN2C5CrpSEXfuSkaOmIEYcPeM+9OC3VYAdRB+3quw/90ufPkZbK9mIHkLO0CzZw7B8lG0paqJeE
 LuhewsFGBQKf1sWkF+A8iXslLq30VsiVUGjsc+7XXcu0JMXkBKCCeFhaVp/LFVjVnEQgaed+kg/
 LIBVzbcRsWU/GqbwLkUMm55IxLqkNx0i1AXF8DkgB5afm5yzUykgFmYgMe8YixF2yWxVVRUQnjU
 yxlBJ9qMSB6TZ3xEshJgnejg==
X-Received: by 2002:a05:7301:7306:b0:366:2893:7421 with SMTP id
 5a478bee46e88-36a4235f6aemr5512318eec.10.1793410259387; 
 Fri, 30 Oct 2026 18:30:59 -0700 (PDT)
X-Received: by 2002:a05:7301:7306:b0:366:2893:7421 with SMTP id
 5a478bee46e88-36a4235f6aemr5512288eec.10.1793410258743; 
 Fri, 30 Oct 2026 18:30:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 32/40] tests/functional/hexagon: add HLX system-mode tests
Date: Fri, 30 Oct 2026 18:29:33 -0700
Message-Id: <20261031012941.339141-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXwHWxfBG23L6v
 uMmNwwIQlROfmxRPrN8QhHwogh/hYGhqs64QfggF9Uz14JkqGf7s6EZoaBzbNOH5/JLi1VieBow
 9+DXYh+7VPNwvL9YpAlnEIIhtHWaQls2d9tTJmJ7028B7oTUz9okStz5S5EG17RqyYbtVEgDtRe
 tuivSiK4Hra4uZ2syH0MA0Frv71jjbXBjmqzY4ZBVRcdOi4OQK2YfIz39tvdmdmDxILI8cs3VVj
 ESPo6kb9kXRLvpiYvv2a1UJal25xAf1dG6l0apSBzgpHpeVc+E056vKiqNbq4RPMXEnsc+nNbte
 +s2eK2eC923QMu+xUl/RpQ2QvIZHL1U+d390mK89wLeASWEo261/lYSdYYYdW9U0YeZTVD9EvSB
 90aOU0jfnkGpKhOCsbGSgbMuo86upALIHElwPuF0EgB9cCHgdToWBT2mTocki5issQSpj52dOSo
 WoB7tzVMS3rC1fhRCjQ==
X-Proofpoint-GUID: zIUyiWpeF6uMf9v2FV7Ctq4n_PrA3nm6
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae544d4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=aFkscosF7gRCcwbLR9sA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: zIUyiWpeF6uMf9v2FV7Ctq4n_PrA3nm6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX2HqE+rxOLGjL
 QRXJpSeoGfhoqsCwmbaKxO+tD3A7mSijjms1xRHkdNfYjUoz6Q6EdaIGB+VbC5DnldKJypefKNj
 rHQM267bzewT5Tm9c4sWhiqW55X/M4o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClJ1biBz
dGFuZGFsb25lIEhMWCB0ZXN0cyBvbiBWODVRQV8xIHVzaW5nIGEgcHJlYnVpbHQsIGhhc2gtY2hl
Y2tlZAphcmNoaXZlLiBUaGlzIGF2b2lkcyByZXF1aXJpbmcgdGhlIHN0YW5kYWxvbmUgU0RLIGlu
IFFFTVUncyB0ZXN0CmJ1aWxkIGVudmlyb25tZW50LgoKQ292ZXIgQ0NSIGVuYWJsZSBjb250cm9s
LCBlbmFibGVkIGV4ZWN1dGlvbiwgdmFsdWVzIGFjcm9zcyBwYWNrZXRzLApWU1AgYWNjZXNzZXMg
YW5kIFZUQ00gbG9hZHMgYW5kIHN0b3Jlcy4KClNpZ25lZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8
bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24v
bWVzb24uYnVpbGQgfCAgMiArKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfaGx4LnB5
IHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1MSBp
bnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3RfaGx4LnB5CgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29u
LmJ1aWxkIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IGYxNzU4
NGQ3NTFhLi4zZGQ0MGVkMDQ2MyAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZApA
QCAtNCw2ICs0LDcgQEAgdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiAgICdhcmNo
X3Rlc3RzJywKICAgJ3Fjb21fZHNwX2Zpcm13YXJlJywKICAgJ3N5c3Rlc3RzJywKKyAgJ2hseCcs
CiAgICdtaW5pdm0nLAogXQogCkBAIC0xMSw0ICsxMiw1IEBAIHRlc3RfaGV4YWdvbl90aW1lb3V0
cyA9IHsKICAgJ2FyY2hfdGVzdHMnOiAxODAsCiAgICdxY29tX2RzcF9maXJtd2FyZSc6IDI0MCwK
ICAgJ3N5c3Rlc3RzJzogMTgwLAorICAnaGx4JzogMTgwLAogfQpkaWZmIC0tZ2l0IGEvdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfaGx4LnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3RfaGx4LnB5Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwLi42YWRm
MmY4ZDQ5NwotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X2hseC5weQpAQCAtMCwwICsxLDQ5IEBACisjIS91c3IvYmluL2VudiBweXRob24zCisjCisjIENv
cHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lk
aWFyaWVzLgorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitm
cm9tIHBhdGhsaWIgaW1wb3J0IFBhdGgKKworZnJvbSBxZW11X3Rlc3QgaW1wb3J0IEFzc2V0LCBR
ZW11U3lzdGVtVGVzdAorCisKK2NsYXNzIEhMWFN5c3RlbVRlc3RzKFFlbXVTeXN0ZW1UZXN0KToK
KyAgICB0aW1lb3V0ID0gMTgwCisKKyAgICBBU1NFVF9UQVJCQUxMID0gQXNzZXQoCisgICAgICAg
ICJodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1oZXhhZ29uLXRlc3RpbmcvcmVsZWFz
ZXMvIgorICAgICAgICAiZG93bmxvYWQvdjAuMy4yL2hseF9zeXN0ZXN0cy50YXIuZ3oiLAorICAg
ICAgICAiOGI0MzQwNzQ5ZDQ4ZmUzM2MyMzcyNjkwN2FjN2Q1MzNmODAxZTM4ZjA4NDJmYjVmNDYz
NDZhYTdiM2VhYTVhNyIsCisgICAgKQorCisgICAgZGVmIHJ1bl9obHhfdGVzdChzZWxmLCBuYW1l
KToKKyAgICAgICAgc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9UQVJCQUxMKQorICAg
ICAgICBrZXJuZWwgPSBzZWxmLnNjcmF0Y2hfZmlsZSgiYmluIiwgbmFtZSkKKyAgICAgICAgc2Vs
Zi5hc3NlcnRUcnVlKFBhdGgoa2VybmVsKS5pc19maWxlKCksIGtlcm5lbCkKKyAgICAgICAgc2Vs
Zi5zZXRfbWFjaGluZSgiVjg1UUFfMSIpCisgICAgICAgIHNlbGYuc2V0X3ZtX2FyZygiLWRpc3Bs
YXkiLCAibm9uZSIpCisgICAgICAgIHNlbGYuc2V0X3ZtX2FyZygiLWtlcm5lbCIsIGtlcm5lbCkK
KyAgICAgICAgc2VsZi52bS5sYXVuY2goKQorICAgICAgICBzZWxmLnZtLndhaXQodGltZW91dD0z
MCkKKyAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChzZWxmLnZtLmV4aXRjb2RlKCksIDAsIHNlbGYu
dm0uZ2V0X2xvZygpKQorICAgICAgICBzZWxmLmFzc2VydEluKCJQQVNTIiwgc2VsZi52bS5nZXRf
bG9nKCkpCisKKyAgICBkZWYgdGVzdF9jY3Ioc2VsZik6CisgICAgICAgIHNlbGYucnVuX2hseF90
ZXN0KCJobHhfc3lzX2NjciIpCisKKyAgICBkZWYgdGVzdF9lbmFibGUoc2VsZik6CisgICAgICAg
IHNlbGYucnVuX2hseF90ZXN0KCJobHhfc3lzX2VuYWJsZSIpCisKKyAgICBkZWYgdGVzdF9wYWNr
ZXRfdmFsdWVzKHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9obHhfdGVzdCgiaGx4X3N5c19wZXJz
aXN0IikKKworICAgIGRlZiB0ZXN0X3ZzcChzZWxmKToKKyAgICAgICAgc2VsZi5ydW5faGx4X3Rl
c3QoImhseF9zeXNfdnNwIikKKworICAgIGRlZiB0ZXN0X3Z0Y20oc2VsZik6CisgICAgICAgIHNl
bGYucnVuX2hseF90ZXN0KCJobHhfc3lzX3Z0Y20iKQorCisKK2lmIF9fbmFtZV9fID09ICJfX21h
aW5fXyI6CisgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

