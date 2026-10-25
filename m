Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA9606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHvS4s3f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sy7O5M3/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKorP-0008WL-GY; Sat, 24 Oct 2026 23:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqu-00082j-Ah
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqo-0001Wp-9K
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P17IMc1587973
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=; b=jHvS4s3fqu5odtSb
 q9ojvTLoZOXmNT+cEBM/uArMHNX7KctMrV74tfMa5n5jHoidpmItnWI4kTaoyN6e
 rxPsecOpsFKoJOS19KTIyh2ra/CBQBRJfKAjyLfw61AvLdheVHpTKYK+8XAmupRu
 VTynv9MCJY92qgys16ECX+/KKPusZ1bjSz/kxCHCcWvSl2D0ml1+W09ooxzAPvj5
 Dmxp7XBW3rA7f+2779DHHEW0Lj7yK5nyjjMBg8V8JydC5SuGTurly90+WvWXEs24
 E0wwXKVkft+lO5yPs9RTYVgpMExMWke4EhAC4/iFmOcZLKftSG9ARe5Bkfge8DXP
 yFV44w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnuka5ue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso8276101eec.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898688; x=1793503488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=Sy7O5M3/Z+e9WvUr46G7+dzV5g1UvpD26ShBHyr6/k/R9IZok9spuhnLYdYyLK2sNG
 oHiPwV3Q7bO6b/K0nK1TM0R2ybac3R3kllC5uSZ9epethiYzBRETXIRDliFntOFJSbR5
 332NFwauPBL+dNMRvK9OMe7B+WMQlVS/W4DFZD/rQfOm2IgM5enr3IkEDOBJ+7+tb4n6
 AnFqR6ZzA/VNIhE2kmV0osDGULhqw5BKFRId4Uv9oq5xSDzNczMqvsKfcZLj4+VykvMv
 i8CdRoHjzoC0CmSq3xTJZI6+mFErWNIVgHNj2enk/OmoE43t49Aa1rCbAH2OBVGRpwiP
 Deww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898688; x=1793503488;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=e8/hTXtd1kB5N4y0ngVLR2gHDwGSq29II4QI2wBVWLcOoLd0xVgjVu2c5OlXKqlkbM
 qLN+t6sA712mGDu0SDAnMhqJd0VVtoOkNH3iTkszV6oJE+l7ud0hrydhOjFMMKwcV4yJ
 dUCPhjBosRsmdHHW2n/TWRFPqw3+BMfILvkxaQOXMXIA1Lcd+8YVMaHOie21o3Ok2+3b
 VmBIyVgHZvcjhlzPoGU9aHjWDOyyEqRUFwBkvBd/EPbYcmiEZV6O695HpkzKaXAAcNiO
 YKOgIPZ4z1SKvoW8Je6hfFOQK9JxTgNv/3TJm2owFEUXt3Z9fuY5DN3puh3AbICs3Qs+
 sUKg==
X-Gm-Message-State: AFq9FYK+goUlp41Zyz8AVhI+hU5SfGBfgKiayqGgGJhXCaIQmxzhQZWB
 JFL9BEMnaXs/JyE8YCHT7doGST/6fLqyifhL+SRMMUyFG1yURGs6F/C3PUoKvZbA/wIKhPNr9GP
 BTmGCJiRkFsXh+0+cCfoSeeDkNyX9HrqrnIO40J4xE8ZBJk8F3iV2JtwdttfZ3luddw==
X-Gm-Gg: AYBFou1cCwzIPbCk8PTZTjLl01RSnX5RBxmpT3pdaVefK13qVNvBqEOXOkLfV9tW7tW
 jyv2v1WWV2k+v06SCMDcgbDqSEl2Syr/8WzHwpSBmYZhzZzPHmjnZqJEYdWfoSoWoJh21tbxgO5
 zFfJnkuqEgCcQgC//jj1wPzRAyWWuMlQ8x5WN+yf3B6pmitVBcZZdZbcV3bxFrQk9oCPAu6T4ki
 B+Cr2NfH1QuocH7WLa/Npq5gTtaK4XGFdlp8hv7D5FJExs+IjWN8PvWvrHmkG6P0UxpiSlo/dCR
 JyCK4tUT4iVwmREEsHl6FuTgDpcObsbYsdCtoFWTeVAl+saXy9NlTNfV/XRoH7hZdDwphQts2ng
 YBDoutGjDfw7O2+bhmC8vVw/81Y6ZI5rtTxi+oBBHgqLEm60=
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id
 5a478bee46e88-369e84d7714mr4954678eec.34.1792898687888; 
 Sat, 24 Oct 2026 20:24:47 -0700 (PDT)
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id
 5a478bee46e88-369e84d7714mr4954648eec.34.1792898687351; 
 Sat, 24 Oct 2026 20:24:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 30/40] tests/functional/hexagon: boot DSP firmware
Date: Sat, 24 Oct 2026 20:23:36 -0700
Message-Id: <20261025032346.2917451-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Z8Z5j3RA c=1 sm=1 tr=0 ts=6add7680 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: tQ0B2vK-T21irdMGPV9MRIGZc6PDLcjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXxqQowY6ykeM6
 2xOSsRtIKsm8EloIwoCBJnyhtlqtoW0RSzoqU9KAtJkRzjDmeLvnYDhGJdeO8+fenROnJbFPqY4
 18EnUV/Mnc+TgbA49sspSLrg7bHvwHjxUzj1F+t/2eZwCz//7nbmUQTebGGFIuH1/itktuYGXdT
 2IGZ+rRxZUvRMP5DIp2rUKOr1W3LMdRPdrhyYZvG11m26goMzPXnuuTzCuwnPgm2D8trYNRo0HA
 HF+NKPOBNTkBvkil+iUBhKe3qxd0it8MYg7tkimaOVewc8qaO3Ia1YmpxkIIlM/PDDClEIxoSZM
 9btWDC/yoTGL09nrNGBi50tTL8FEmasI+I81mEGvx2Q4Qv8JiUHAySbhyVQN3IUcFTkVUDXgkGg
 ElGtLKa3Ckl4+U1NE1ndtHjPD9Uw4yF9YT6ShdGAdyqr5O56rSM4SbHFv1Ip4H/WUYDK4NpZQdR
 FQ31F6I3bxQUxrVPJiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXz84nhJ5hDEVA
 eFeIG7uAb/Yuu0Vykfk6xZ0/0F1otfv69v6oxZ/xoSz3MPGBbnXdNXNIyJ2EIB2O7D5hAR2mZ8S
 eiP7RmgDUMuweOTi+4ffAbiAYfrft9U=
X-Proofpoint-GUID: tQ0B2vK-T21irdMGPV9MRIGZc6PDLcjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250013
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

