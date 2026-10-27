Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49984606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ+Jvsvi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VhkLEbzp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXuO-0005Dr-Dj; Mon, 26 Oct 2026 23:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtg-0003xW-EO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXte-00009X-CD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F2Od1349020
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=; b=UQ+Jvsvid2Fm+4ou
 S9SiOdDm+thCCiAnpxyUDtJoVsQ5K5EgYix64dPqOJJaFQtRQNqz79HQq7kLmisT
 07+TodWExp7JUMSgwWkameJIKbLYVpIsnCiDZiFKKbpQi0wPlK0T1gZJxTE4Msek
 wjIV3fZ9kfJlSP8XtzjQYEfhTZXBGvQL0cr1EUdHKPunyOOOV66voNAAeKCQ/JOD
 fOnsuC5ATQJgnPYK6sMo/GTCVCkMMTdkHnP9rbsSEdmbjIhbKxVMlRO04+/McWfY
 cbl0tXTpbt/5zTTUWbuG4aHgrITqZ6z6/NUxs9FVzzR/uXWaJ7H7Z59y6jqjUosY
 Rd3axA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbt8b3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:35 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so1330898c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071834; x=1793676634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=VhkLEbzppApfxQq8iTlYx3TOvLREKf28W9BQMFVAsDAQBoFjl7jLCZC8oeVMyWRP/h
 ffFori2IABspCr+Tbrh4tvZktN74gcHR2YvY1hCy5w3fxJkGJgADmj6s32c/kBslCfRP
 lTI/8juySawgKqSX9PQwmkPm0Pqz81xjYjP+SkEC1kkdwjrc34RZ5hP/rq4AbUGAFBiY
 Pdn5DUoJgZfj7kArFyC9Wigye5jz/3MH5rNryTLzA/jxncCUX+LsOD2dWg4aLypquCcf
 qmt5eEmF7QtjURBlLgmCnu+d6pi1u++6mTONnsFcfIVqc9HcO3PB7b06EXqrqzhxZfXC
 Fq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071834; x=1793676634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=D9Jxhxe+pPkZb1U9eG/3+m7WhL+K7WsP/x2DoRGttGx/j+OM7Iod3eYs0pPSGnOKoc
 CceBiSLmZ+Xo1i0Xp+VIXuhMNx2vqkp36J1RM9W7H2Q/qaeDTvWOo9rlHSBdJIeWx09r
 ITaTtI801BreAagEuXWizt6ALcldHD8t+dIRc1TzIPAaPNhzFXwQhipqNAj/m361HWP1
 JwjphROTqoRqpf2isp9Godt9yvh/laZvJJnNVlL+QjhbVGo6a1uUWpRNGsQjJpMU1Y6p
 2a8q2miSJiHqTjJ7lLn7QPi9KNnOU3Q3WTzrQH+S90ZOG04W8qjNPrHA4uuuPR2kjh4i
 kXxA==
X-Gm-Message-State: AFq9FYJSE9wC9yl+zI4WpX2Y3NmcsmSAthbjvu5MT4u0Vtsua4Y7/Jk7
 qCNoPjg6HrLZ7579jzOXSpiE6eDZ5miBH/khETrFRSB7X0bbm5M2PUAQD+dmqWV3IfIbbTuglHG
 fcoIvRF20l625E9OGsTbCv5Pk2DR2xy0ys+kjBlq8EeltMIMO41CKPXttWb5UMdQfKA==
X-Gm-Gg: AYBFou0Q5I7Setft4Tk9Ti0B9xdOmCOoq83XSMPdf36GVZwvdaoBymNBmhtwbUlqZ32
 i1J8EPubyy2402a4LyXFt8uN+aa+TiFwhYq6RyK9gYl/a4c+8oLVdlMxJS1KO/uiW+9ofmUj3f0
 ryd1/IsPTZn4TJQ4DcTp3w6M/OIRf7M9aeJI/tJ+U8AGslCgedGCX7TG66g8hmZLQwLIx/e0Q/P
 LvGeyiUVGT0qqMPNo5Ffniv6zvATydXlHeX1cOTmOYWbim56QVEVaVvmLgHzTZ2c6D23MJFWkvU
 N+7HdhXkzwV8aApt+W5Z+PzKMS6fy8JsaDUowzugJs5H3z4m/rZXDS1BI4HXSEPLYhl/RrqLzr5
 jxynUkDhfVD76/tzmyaxKx0PvUYkisB9GvdZnk6bgHv8ZuHY=
X-Received: by 2002:a05:7022:ec2:b0:143:868a:20c1 with SMTP id
 a92af1059eb24-1994091875cmr15061756c88.46.1793071834137; 
 Mon, 26 Oct 2026 20:30:34 -0700 (PDT)
X-Received: by 2002:a05:7022:ec2:b0:143:868a:20c1 with SMTP id
 a92af1059eb24-1994091875cmr15061707c88.46.1793071833515; 
 Mon, 26 Oct 2026 20:30:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 31/41] tests/functional/hexagon: boot DSP firmware
Date: Mon, 26 Oct 2026 20:29:17 -0700
Message-Id: <20261027032927.3055166-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX2F8bVP8ZWRzW
 a45LO/FjjhPRmTNH82C+fzOaVn++P35+qbWCH0fwFnnb1PDxbQsfHbEmTwm7Zkseqej0+FhtEFo
 sVvpPK7dUBcdSwcRXkQRVftnh6AEizs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX3fc8MGHNnfFY
 9vG2huAIQityyL8Qzn7yS1krL2hVKL5Yu3Rlz8us/otOzRwgFz/aPimI+BIC4M2NehqwZmqsp9Y
 vyq6YPkfhz0isY+Hn6FtX2guPWt1PLlNxUcKJpW49uwp+z8iPha5OZQTJiU7kt4EtCGrN70JY7H
 Om7i4mHEpS5QNypT/r7J+x9VExj4RNAA8QpX+GhZMU+IlpqHnduu2AGKpXNWPnh2tqBYOuh3Bcz
 HfRPUqCSm4a3BFG7OgZ5vqSIH72O8gZgzZo1OApfNar60/IBQNCqrO2TUByXxG04xYuh2bSwt1r
 Pqts2VHetYl9O1Z+H5JggnTuPTuu0c6W28VymNyPhAtao0LGGHxbcarW6v7bKwwM4ExcbxvHCva
 5tmG4Kd5Isw+KOIKdv0x07E2DYc5hDtqe9jtLAadNhaFgfAYzUuTzCpPc1k+FTW60ECMACHPqR/
 q0hg0fRpHxxPSN1r9dQ==
X-Proofpoint-ORIG-GUID: IIqzsKPzgQptonpwHROneS03sgSwtX-Y
X-Proofpoint-GUID: IIqzsKPzgQptonpwHROneS03sgSwtX-Y
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae01adb cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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

RG93bmxvYWQgdGhlIGZpcm13YXJlIGFuZCBydW4gaXQgb24gdGhlIGNvcnJlc3BvbmRpbmcgRFNQ
IG1hY2hpbmUuCgpUaGUgaW1hZ2VzIGFyZSB0aGlyZC1wYXJ0eSBiaW5hcmllcywgc28gdGhlIHRl
c3RzIHJ1biBvbmx5IHdoZW4gdW50cnVzdGVkCmNvZGUgaXMgYWxsb3dlZC4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAgMiArCiAu
Li4vaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5ICAgICAgICAgfCA5NyArKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDk5IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9xY29tX2RzcF9maXJtd2Fy
ZS5weQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCBi
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBlMTgyYmM5OGEwNi4u
MGZkOTBlNDkxYTIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5i
dWlsZAorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIsMTAg
KzIsMTIgQEAKIAogdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiAgICdhcmNoX3Rl
c3RzJywKKyAgJ3Fjb21fZHNwX2Zpcm13YXJlJywKICAgJ3N5c3Rlc3RzJywKICAgJ21pbml2bScs
CiBdCiAKIHRlc3RfaGV4YWdvbl90aW1lb3V0cyA9IHsKKyAgJ3Fjb21fZHNwX2Zpcm13YXJlJzog
MjQwLAogICAnc3lzdGVzdHMnOiAxODAsCiB9CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9xY29tX2RzcF9maXJtd2FyZS5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4
IDAwMDAwMDAwMDAwLi4wNTUyMmU2MGQ5ZgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5CkBAIC0wLDAgKzEsOTcgQEAK
KyMhL3Vzci9iaW4vZW52IHB5dGhvbjMKKyMKKyMgQm9vdCB0aGUgcHJvZHVjdGlvbiBEU1AgZmly
bXdhcmUgb24gdGhlIFF1YWxjb21tIERTUCBtYWNoaW5lcworIworIyBDb3B5cmlnaHQgKGMpIFF1
YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMKKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworZnJvbSBxZW11X3Rl
c3QgaW1wb3J0IFFlbXVTeXN0ZW1UZXN0LCBBc3NldCwgc2tpcFVudHJ1c3RlZFRlc3QKK2Zyb20g
cWVtdV90ZXN0IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4KKworCitjbGFzcyBRY29t
RHNwRmlybXdhcmVUZXN0KFFlbXVTeXN0ZW1UZXN0KToKKyAgICAiIiJCYXNlIGNsYXNzOiB0aGUg
ZmlybXdhcmUgaXMgdGhlIEVMRiB0aGF0IC1rZXJuZWwgc3RhcnRzIHJ1bm5pbmcuIiIiCisKKyAg
ICBNQUNISU5FID0gTm9uZQorICAgIEFTU0VUX0ZJUk1XQVJFID0gTm9uZQorICAgIE1JTEVTVE9O
RSA9ICdFbnRlcmluZyBtYWluKCkgLi4uJworCisgICAgZGVmIGJvb3RfZmlybXdhcmUoc2VsZik6
CisgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoc2VsZi5NQUNISU5FKQorICAgICAgICBmaXJtd2Fy
ZSA9IHNlbGYuQVNTRVRfRklSTVdBUkUuZmV0Y2goKQorCisgICAgICAgIHNlbGYudm0uc2V0X2Nv
bnNvbGUoc2VtaWhvc3Rpbmc9VHJ1ZSkKKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWtlcm5l
bCcsIGZpcm13YXJlKQorICAgICAgICBzZWxmLnZtLmxhdW5jaCgpCisgICAgICAgIHdhaXRfZm9y
X2NvbnNvbGVfcGF0dGVybihzZWxmLCAnUVVSVCBrZXJuZWwgc3RhcnRlZCcsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmYWlsdXJlX21lc3NhZ2U9J0ZhdGFsIEVycm9yJykKKyAg
ICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsIHNlbGYuTUlMRVNUT05FLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFpbHVyZV9tZXNzYWdlPSdGYXRhbCBFcnJv
cicpCisgICAgICAgIHNlbGYudm0ua2lsbCgpCisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2Ns
YXNzIFFjczY0OTBDZHNwRmlybXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1B
Q0hJTkUgPSAncWNzNjQ5MC1jZHNwJworCisgICAgQVNTRVRfRklSTVdBUkUgPSBBc3NldCgKKyAg
ICAgICAgJ2h0dHBzOi8vZ2l0bGFiLmNvbS9rZXJuZWwtZmlybXdhcmUvbGludXgtZmlybXdhcmUv
LS9yYXcvJworICAgICAgICAnMjAyNjEwMTkvcWNvbS9xY202NDkwL2Nkc3AubWJuJywKKyAgICAg
ICAgJzQzZTljODllMTVlZTgyZGFmODMyMTRjYWUzNDAwNmE4NTE1ZmRkZjlkYjdmNjQ1ZjVlZmY0
YjhlM2M0ZWJiNjQnKQorCisgICAgZGVmIHRlc3RfcWNzNjQ5MF9jZHNwX2Zpcm13YXJlKHNlbGYp
OgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK0Bza2lwVW50cnVzdGVkVGVzdCgp
CitjbGFzcyBTYTg3NzVwQ2RzcEZpcm13YXJlVGVzdChRY29tRHNwRmlybXdhcmVUZXN0KToKKyAg
ICBNQUNISU5FID0gJ3NhODc3NXAtY2RzcCcKKyAgICBBU1NFVF9GSVJNV0FSRSA9IEFzc2V0KAor
ICAgICAgICAnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1maXJtd2FyZS9saW51eC1maXJtd2Fy
ZS8tL3Jhdy8nCisgICAgICAgICcyMDI2MTAxOS9xY29tL3NhODc3NXAvY2RzcDAubWJuJywKKyAg
ICAgICAgJzFkOWQ4Y2QxZTkxM2IwZDNiNDlhNzdiNGU5NjI1NjRhYjQ4MTE5M2U2YTU2OTdjOGYw
NjQwNmIzZmQ4NWE4ZmMnKQorCisgICAgZGVmIHRlc3Rfc2E4Nzc1cF9jZHNwX2Zpcm13YXJlKHNl
bGYpOgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK0Bza2lwVW50cnVzdGVkVGVz
dCgpCitjbGFzcyBTYzg0ODB4cE5zcDBGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6
CisgICAgTUFDSElORSA9ICdzYzg0ODB4cC1uc3AwJworICAgIEFTU0VUX0ZJUk1XQVJFID0gQXNz
ZXQoCisgICAgICAgICdodHRwczovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJlL2xpbnV4LWZp
cm13YXJlLy0vcmF3LycKKyAgICAgICAgJzIwMjYxMDE5L3Fjb20vZ2x5bXVyL2Nkc3AubWJuJywK
KyAgICAgICAgJzdiMjJmMzNhZTI3M2QzZGZjNWY3NDFhOTY3ODMxZTdkNGZkNzlhZDE0MWU2YTFl
Y2VlMTc1MDllYWMyMDcxMDknKQorCisgICAgZGVmIHRlc3Rfc2M4NDgweHBfbnNwMF9maXJtd2Fy
ZShzZWxmKToKKyAgICAgICAgc2VsZi5ib290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3Rl
ZFRlc3QoKQorY2xhc3MgU2E4Nzk3cE5zcDBGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVz
dCk6CisgICAgTUFDSElORSA9ICdzYTg3OTdwLW5zcDAnCisgICAgQVNTRVRfRklSTVdBUkUgPSBB
c3NldCgKKyAgICAgICAgJ2h0dHBzOi8vZ2l0bGFiLmNvbS9rZXJuZWwtZmlybXdhcmUvbGludXgt
ZmlybXdhcmUvLS9yYXcvJworICAgICAgICAnMjAyNjEwMTkvcWNvbS9ub3JkL2Nkc3AubWJuJywK
KyAgICAgICAgJzQxMGU3Y2EzYjM0MGU4MDgzNWU0NjQ1NDVhMjE4ZDkzNzYzMTBhMDlmMjRiYzg3
ZGU0MGJjMjVmN2Y1ZTMyNDAnKQorCisgICAgZGVmIHRlc3Rfc2E4Nzk3cF9uc3AwX2Zpcm13YXJl
KHNlbGYpOgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK0Bza2lwVW50cnVzdGVk
VGVzdCgpCitjbGFzcyBTbTg5NzVOc3BGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6
CisgICAgTUFDSElORSA9ICdzbTg5NzUtbnNwJworICAgIE1JTEVTVE9ORSA9ICdRVVJUIHJvb3Qg
dGFzayBzdGFydGVkJworICAgIEFTU0VUX0ZJUk1XQVJFID0gQXNzZXQoCisgICAgICAgICdodHRw
czovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJlL2xpbnV4LWZpcm13YXJlLy0vcmF3LycKKyAg
ICAgICAgJzIwMjYxMDE5L3Fjb20vaGF3aS9jZHNwLm1ibicsCisgICAgICAgICc3MzczOTUyNDEz
YzE0MWZjNjM2YWE5MzNhYjBjNzFlN2JlMWQxMGY1ZjdkZDM2YmU1Mzc0ODI3YjI1M2MzZGI1JykK
KworICAgIGRlZiB0ZXN0X3NtODk3NV9uc3BfZmlybXdhcmUoc2VsZik6CisgICAgICAgIHNlbGYu
Ym9vdF9maXJtd2FyZSgpCisKKworaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKKyAgICBRZW11
U3lzdGVtVGVzdC5tYWluKCkKLS0gCjIuMzQuMQoK

