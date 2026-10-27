Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9C60A3802
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6pCvJOT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jcSkNmZR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiLX-0003FD-Tt; Tue, 27 Oct 2026 10:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKB-0008LW-V4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiK9-0006Ak-Ug
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:51 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoYTH1850875
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=; b=o6pCvJOT5yr9W+bj
 L8F99UwT5HmNjzSjOHJTaoNAyiK3zhLbT36IZyp6606tz6gtrixGBMlFSA0s3d4r
 2kbA8hNlGfH22yfuOwwjFS8PEG2h1Upb9H58BYl7BLpu9ZDU6rrfAUBNKpcXjhmN
 vRbgMPPSRnJ5+qs2f5Xj57RC8G9h50RSM9xnOMaI5DY6peaPJh5IXQecVNHxGS7q
 WlVI6Vf5U4rCJN/HTIBE/eO137YLxPCsVKibd4ODTwrPo6ygI5csqdaHoFcioAhw
 G4D9dlDcIbzDSi9tll60rjD0HnK/kihYivT6ktXL+QC/oAMYMWMXKUEdqqII9Zxk
 TR9I5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmc4g7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso3698060a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111928; x=1793716728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=jcSkNmZRZeU7ZvhAcbdF4mXB1KuxMtXKaKN9skyKuOnDx4pfJkzkiPHxE966dkVtEv
 OCjQBjcmQCehchXUfVqJIth4CLdha3dQ00KbYtFOvn4rRuMcNYrP2hsvZfpDerfLPpby
 C/A0PpDqGl5ZF+bKywosXPOvvfRimNJ+jlGoFxJMdCttnNQxJAt+aChGYOkb2FUQaYYy
 bcbG6jNTWAS4mYsXfH8I8m6UkTQo2ZUgxE9HoO6usLwAKGRhpUZDVmHdoMxUfcLv2b76
 gOVZuK2mWCeE8a8Ao+fpvZXdNy6raqsuuWWvxA1DDXWnVpcitXpKsOSIJG6AFk1xdWO4
 7RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111928; x=1793716728;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=TPWWPbPIWwp2Jy6XQ2tOD5dcnysGrACrwCVCmhkvx/BAZUGdIR2fMzMWSL9zEDt/tW
 KPFZLfeKOjDNykWiiGZ+L9vSwRAVFBm/eXUCIQ1OKKn7qkfEuItoMFjeIx2sdpqIs+9R
 jVYAhlOhr5RCXQI+jhZ3a662/J+U/abJghk6WZvos3+nn8kNz9W4MYJ73y6Xx8jURWet
 cp49ajFMwfEXXjEg4xO6pYaWjsRWjUWjNZFAyjGVPAq+AAncrciti1bX5bEb+MyQopCE
 iK8zxWzSXIi65gboi3or7Szv3z1fYD/lSALTxPcoldo66+fXJZv404CM1E5SfR5b0swl
 Z8wA==
X-Gm-Message-State: AFq9FYL7hmtdczwKKaHb1/T2YOozGZiRlpUOcNSBaOPb4WmkB3M+UJj1
 sYVZqwqp/HJf2fKRctpahUwES9KI3/lxZlUlGt/qwKDvW0CVVnfwVtH335QYOB0KELOvfbTB++w
 0NXAXXYNV87b8wvfq18qlvhta/JsnmuFwfEXVYumMKHdl1bGw3V48DLkpKP8jDdbtbQ==
X-Gm-Gg: AYBFou0oc48EiFseTGXUVcjXJHVwfNML0BGZS3bx3K7hluiNz/TT/LAVPyBi2NH7Wsb
 ReEi0XJhBybxFVED1Hb5mq6Cvt7Dvns8YUiBV5ZQWERcrExDrXHvTUYZRplDKQm27UOT7tH6bgm
 QGTHYyammjfGmoeWxeOVX64hyYPMXA+1kTyUSh82iquG/ypet4eoGK6RpZKaltIr0D9ylAT9I6i
 qCFY2y80KEIHZ7yOD4LAD8CZMUIKYrq9cV7H6FofoJW5gUR3z4l4Ob1RoHt5g/U2SpHo0AABxi0
 g4znoDBRz/9nbOjjDccwmA6E34vbm1iPoXq3Zi2O4OUF9wPenl2d5GJS5AkHIysAnYVRkUNY6jU
 rFuujc5ad8Ujz6Jx65tLsj/7yYl1e5KrnURRP2+OQtchMoUw=
X-Received: by 2002:a17:90a:e70c:b0:3ac:6e91:3f14 with SMTP id
 98e67ed59e1d1-3adea899102mr8572661a91.22.1793111927670; 
 Tue, 27 Oct 2026 07:38:47 -0700 (PDT)
X-Received: by 2002:a17:90a:e70c:b0:3ac:6e91:3f14 with SMTP id
 98e67ed59e1d1-3adea899102mr8572627a91.22.1793111926950; 
 Tue, 27 Oct 2026 07:38:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 31/42] tests/functional/hexagon: boot DSP firmware
Date: Tue, 27 Oct 2026 07:37:10 -0700
Message-Id: <20261027143721.4125584-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX9wQdF8BiqCsE
 Pa/8gjp5DJ1EPlaChF6j/Ar+yXGZgcP58Khs6e44b1BJe2oyocYQepJzX44auQkDO+JNtzUL9ac
 nx9yTCe1dHtEvXjJ/ZA6yuFM51eKwdQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX/Ys47SeuwWjb
 udd6Rru0PDhoT0QmOOF7cAOJ4w8HBnsWcYQofcgwHtKezMGMnGD+wwjFInAYk7H/MwO4mQ680d+
 QPSIHX5MspycttAEl1gT+TqNh6kIVv/bo+rjvzWXFKcqL8Z/VMvTYnK/RxAnufsuv1TF1LW8sS5
 xacZSukIxpAHtjqPvJ5rVEBdxZiV0Kc3c8r32TCvbGf7dh5q2Z3C2rGKDMC+KfV9eTAYwrq1VAA
 Qio0sGAXyiA91ht5GFHZKlvdtfAozoRO7md+eLxa4CdQXdg8zUOGBcvMxzPlkNGZjdunnd8x3at
 W8e2eFK+6ltKIejvSE6o9Ox9TcivMFAWfCLUw/W0AJgEyBYWxPWD/thI2Tc8nQ3Otk934Y5FkYx
 gakxlNgpqRgvKPVekkjURRqLoR88z7Qa3ZZKcDHE3L1KLE24DbRkThb4QticOuO9xskp6qO0PPh
 nx3eh1W9WBT3eeRKMXA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0b778 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: KS3nJSKYSortSOERNYCTc38R2JFiH2yG
X-Proofpoint-GUID: KS3nJSKYSortSOERNYCTc38R2JFiH2yG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

