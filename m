Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D32606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nleLJHTO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RvuUwmkW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9g-0002Eb-3f; Thu, 29 Oct 2026 19:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9e-0002Cb-Bm
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9c-0004Dc-AV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZbpU1890864
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lxdO7v437eUmwoFWEz3JLeHoEc+bfhUpkBACCxFXD48=; b=nleLJHTOPYesZ+rl
 h2W5SAdjxKxB9pd4QspTvKB6ThMc7wr4DgXrZ2eGeotjpMgM8HZeYp2gvpON8ri7
 nGPt89N2nqhVnYcD/w2n3jNXQUYvq+AAFy0TBbm8ktrF9e+65m2WSkLnKvCnJssL
 SY4jBUY3nYjV4AMACQiZTJ97TiNOIxzLYQswPJC3syL+Rrb44Rp57XlX9qfCCqKG
 4vpJC12xr12NmsqRod/0Ynw0oQXZ6tnecOBiqLGcAAVI8cTLp5XTTaW9acEWV5iI
 HerH5df6kqa4Krron3FbZmyWU0W64jIIsyBscq0Jyxg5AvQc/6Bg4yi0tj78HICe
 KGz/Pw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qg94n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a223755e4so669991eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793315006; x=1793919806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lxdO7v437eUmwoFWEz3JLeHoEc+bfhUpkBACCxFXD48=;
 b=RvuUwmkW2Zpe26qnyEQlrOGuKhHqJrDWneAd4ZlI33xQKTDlqjm9uMYgi3gTp2EC+U
 L0YhVJNF71IEBxTH23wtnWjJsuqE3hKtqZL2qdxacbiCU3a9Gto7z7RfNcxKrdfHzfbn
 q/zkrc8myWhlsEjRQlEpdAlH29ul7Me0dR7gkpGsYDyUbO0DJlY/3iau43SxNgVIMeTf
 /JGM5j9vkEXxQgLAYcOSLn/xYUnwNxN40MzuE3FQw+PKGTuxTigOenCxUVFyrL6wocN9
 xmWsp5a8KibftdHjcvQQpZ2fGKvyiKDWvhsb15aj8MrPQzL5V/1PGSOvOH4rabUWvO8o
 /g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793315006; x=1793919806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxdO7v437eUmwoFWEz3JLeHoEc+bfhUpkBACCxFXD48=;
 b=G0F/8OE1d1rfYNbybfMRTBtCFWWptisVIQB1qecIe6g7UK7ys/+KppYUGvvB0ynYRp
 vUjhcEkujvBv1Ekm1jbBFtKfsAkw5Lj31bQ7W8azZm/vsQJpdZosGQKafg6/UiED+Mmb
 fyuXv0f1d4JaytFgJH/DvHNvHibR5ZoGHc9h2gN67FfZEbXoa7XDHrVHDBUBaciyV5Ul
 HGvTkbw76ZSyl6rSQCqXeBDWuRE4Qp/BRTp1MIG0bJYH3m3jUc0eZt7MdZ4z+ePBfOT2
 ciKTGaHPwy2Pzkj2K6fSnt1gLyAsB8Oy4jRdLV7gl8Ydf6/vLmPnsKGCz5iKpevFhbuS
 ctvQ==
X-Gm-Message-State: AFq9FYJNiaTe+OO1WUhUIlBz2OIT2CbPf+Nr1KLLAyM0HG3tWZOnaxzl
 8BgelwXVUzTrtdmIJ7Cu22q39kvj8I64zziQp90DDXN3vgzwFhdVkWBWGaXHhWNUlTmocjlgEqi
 fCrOZ2FnqEQ19zdAJA9fsrHON4zWYK6oF2/Kb1i2OlIPXeCZ1nD/AmKf1sCM1/nKlUg==
X-Gm-Gg: AYBFou2gxDnRNREQH2braB9gm6a33Ra2uYHyiiJMGD6VjQfH28BfKSrFilObvOzHNg0
 ZZhxeTIuIuTCDkh0iMYPi7jA0AXmEp7axHUocUrVXQ+kYWSUTcWQObhhcYSdgaU+7RMN5vXqmdB
 rGEfsS2bzgEuo5vDGIPNQxzxvqADGtpel+ivDnBH5uJk8BE4WPVpRb9XvdRX6LCSQtOi4SOGpAU
 siYPIRSmwkOI3uLbNKcwDPkBuM6LUQSrs92Djg751sIRStnI7sTTe3bEYNu8S+pB6XfZ6hBS4Ft
 DmJPHz4muyz9MHSUbME/u46HZN79iY6YihebvJB29jrx+crRvkI+xacVB7+q4f2VDrUOOtuti5e
 2uKZQ8spij+C++pgSkU+Y1WR/AQSWCTGMl/FTAmMv/dHEkaen0QajdQrHS0kp94F5qsGJuqGjYg
 3cMRUzaqqyIVADIvOjeEdD
X-Received: by 2002:a05:7022:628a:b0:1a4:c892:b130 with SMTP id
 a92af1059eb24-1ac5b9cb62dmr850881c88.15.1793315006118; 
 Thu, 29 Oct 2026 16:03:26 -0700 (PDT)
X-Received: by 2002:a05:7022:628a:b0:1a4:c892:b130 with SMTP id
 a92af1059eb24-1ac5b9cb62dmr850812c88.15.1793315005410; 
 Thu, 29 Oct 2026 16:03:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 7/8] hw/hexagon: migrate the HMX state
Date: Thu, 29 Oct 2026 16:03:09 -0700
Message-Id: <20261029230310.1632334-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX2ImxqezUApH7
 DwlA1rLf8egXquJltYefXmcfKTclEeKjNHTR8nTsctJqq5fuFC6jCQam+icwNcTxBRnfCUIMp4x
 G1U73DdFkmgaIfM1tSVp4Ld7pR9bhJEFoeIA3Mc/vXOKaZmFvEGcrQ2LEvccIK7QDCcz/HXpzer
 Ef4UAnfgvFQKNFI7s3cljdJn33IuWt6W6tMnIdoCN+3rE0449fedWtL/M/5HhLdpCTd63wP11b4
 W7shB3azVSf+vKfUPD8/hw5J08fEOjk8Q8HYjxvf4kIZgE1lrYJEwMifr4xLu3r+aIKzkVlY0sf
 OJHxijrERE7ftKDEYwrKsqJpR11k9i9XhFkjlKG1Gx7Kx1HYyUVo9DIoLevbsdPwXvm53M+iBXf
 Zu5M1lVefaa9j/v/viQ8pSvZQCaGh9lb9i3FZSpXDou4dv7jg4By7S3sNtGyxh6D8z8oNfeh4IJ
 B23/5gVpjBbtTi4pU7g==
X-Proofpoint-ORIG-GUID: QHlTMHnWPdx9tLNRG6jCMpTUMm9VR1Er
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae3d0bf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xdyA_gckl7Q-J04J5HIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX15jvb5LywHBy
 zlAh41JYlr+6wgBdMdATjNEbS/LqSvhE/pKGXxzjXkbBUG70jsJ4VJiL9hoDY5pbHwGG3l+eY3u
 9KRqXzZRpQRw6jqA8jTdy2sLNaa1Glg=
X-Proofpoint-GUID: QHlTMHnWPdx9tLNRG6jCMpTUMm9VR1Er
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGh3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5jIHwgMTE3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMTcgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5jIGIvaHcvaGV4YWdvbi9o
ZXhhZ29uX2hteF9jb250ZXh0LmMKaW5kZXggZTNlYTdiNzE0NzQuLjM2ODNiZDlkNDE2IDEwMDY0
NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYworKysgYi9ody9oZXhhZ29u
L2hleGFnb25faG14X2NvbnRleHQuYwpAQCAtNyw2ICs3LDcgQEAKIAogI2luY2x1ZGUgInFlbXUv
b3NkZXAuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuaCIKKyNp
bmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgogCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9j
b250ZXh0X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogewpAQCAtMTUs
NiArMTYsMTIxIEBAIHN0YXRpYyB2b2lkIGhleGFnb25faG14X2NvbnRleHRfcmVzZXRfaG9sZChP
YmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiAgICAgbWVtc2V0KCZzLT5yZWdzLCAwLCBzaXpl
b2Yocy0+cmVncykpOwogfQogCitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3Rh
dGVfaG14X2FjY19meHAgPSB7CisgICAgLm5hbWUgPSAiaGV4YWdvbl9obXhfYWNjX2Z4cCIsCisg
ICAgLnZlcnNpb25faWQgPSAxLAorICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSAxLAorICAgIC5m
aWVsZHMgPSAoY29uc3QgVk1TdGF0ZUZpZWxkW10pIHsKKyAgICAgICAgVk1TVEFURV8yREFSUkFZ
KGRhdGEsIEhteEFjY0Z4cCwgSE1YX1NQQVRJQUxfRElNX0ZYUCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgIEhNWF9PVVRQVVRfQ0hBTk5FTFMsIDAsIHZtc3RhdGVfaW5mb19pbnQzMiwgaW50MzJf
dCksCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9OworCitzdGF0aWMg
Y29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaG14X2FjY19mcCA9IHsKKyAgICAubmFt
ZSA9ICJoZXhhZ29uX2hteF9hY2NfZnAiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWlu
aW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtd
KSB7CisgICAgICAgIFZNU1RBVEVfVUlOVDY0XzJEQVJSQVkoZGF0YSwgSG14QWNjRnAsIEhNWF9T
UEFUSUFMX0RJTV9GUCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBITVhfT1VUUFVU
X0NIQU5ORUxTKSwKKyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpCisgICAgfSwKK307CisK
K3N0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9obXhfYWNjX3NldCA9IHsK
KyAgICAubmFtZSA9ICJoZXhhZ29uX2hteF9hY2Nfc2V0IiwKKyAgICAudmVyc2lvbl9pZCA9IDEs
CisgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0
YXRlRmllbGRbXSkgeworICAgICAgICBWTVNUQVRFX1NUUlVDVChmeHBfcHJpbWFyeSwgSG14QWNj
U2V0LCAwLCB2bXN0YXRlX2hteF9hY2NfZnhwLAorICAgICAgICAgICAgICAgICAgICAgICBIbXhB
Y2NGeHApLAorICAgICAgICBWTVNUQVRFX1NUUlVDVChmcF9wcmltYXJ5LCBIbXhBY2NTZXQsIDAs
IHZtc3RhdGVfaG14X2FjY19mcCwKKyAgICAgICAgICAgICAgICAgICAgICAgSG14QWNjRnApLAor
ICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAorfTsKKworc3RhdGljIGNvbnN0
IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hteF9jdnRfZnhwID0geworICAgIC5uYW1lID0g
ImhleGFnb25faG14X2N2dF9meHAiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11
bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7
CisgICAgICAgIFZNU1RBVEVfVUlOVDE2XzJEQVJSQVkoZGF0YSwgSG14Q3Z0U3RhdGVGeHAsIEhN
WF9TUEFUSUFMX0RJTV9GWFAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSE1YX09V
VFBVVF9DSEFOTkVMUyksCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9
OworCitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaG14X2N2dF9mcCA9
IHsKKyAgICAubmFtZSA9ICJoZXhhZ29uX2hteF9jdnRfZnAiLAorICAgIC52ZXJzaW9uX2lkID0g
MSwKKyAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZN
U3RhdGVGaWVsZFtdKSB7CisgICAgICAgIFZNU1RBVEVfVUlOVDE2XzJEQVJSQVkoZGF0YSwgSG14
Q3Z0U3RhdGVGcCwgSE1YX1NQQVRJQUxfRElNX0ZQLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEhNWF9PVVRQVVRfQ0hBTk5FTFMpLAorICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNU
KCkKKyAgICB9LAorfTsKKworc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRl
X2hteF9yZWdzID0geworICAgIC5uYW1lID0gImhleGFnb25faG14X3JlZ3MiLAorICAgIC52ZXJz
aW9uX2lkID0gMSwKKyAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0g
KGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7CisgICAgICAgIFZNU1RBVEVfU1RSVUNUX0FSUkFZKGFj
YywgSG14U3RhdGUsIEhNWF9OVU1fQUNDX1NFVFMsIDAsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZtc3RhdGVfaG14X2FjY19zZXQsIEhteEFjY1NldCksCisgICAgICAgIFZNU1RBVEVf
U1RSVUNUX0FSUkFZKGN2dF9meHAsIEhteFN0YXRlLCBITVhfTlVNX0NWVF9BR0VTLCAwLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2bXN0YXRlX2hteF9jdnRfZnhwLCBIbXhDdnRTdGF0
ZUZ4cCksCisgICAgICAgIFZNU1RBVEVfU1RSVUNUX0FSUkFZKGN2dF9mcCwgSG14U3RhdGUsIEhN
WF9OVU1fQ1ZUX0FHRVMsIDAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZtc3RhdGVf
aG14X2N2dF9mcCwgSG14Q3Z0U3RhdGVGcCksCisgICAgICAgIFZNU1RBVEVfU1RSVUNUKGN2dF9m
dXR1cmVfZnhwLCBIbXhTdGF0ZSwgMCwgdm1zdGF0ZV9obXhfY3Z0X2Z4cCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgSG14Q3Z0U3RhdGVGeHApLAorICAgICAgICBWTVNUQVRFX1VJTlQ2NF8yREFS
UkFZKGJpYXNfcmF3LCBIbXhTdGF0ZSwgSE1YX05VTV9CSUFTX1NFVFMsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgSE1YX09VVFBVVF9DSEFOTkVMUyksCisgICAgICAgIFZNU1RBVEVf
VUlOVDMyKGN1cnJlbnRfYWNjX3NldCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX0JVRkZF
UihhY3RfYnVmZmVyLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGFjdF9ycywg
SG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihhY3RfdHlwZSwgSG14U3RhdGUpLAor
ICAgICAgICBWTVNUQVRFX1VJTlQ4KGlzX2Y4X29kZCwgSG14U3RhdGUpLAorICAgICAgICBWTVNU
QVRFX1VJTlQ4KGZwOF9vZGRfc2VsLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGZvcm1hdF9vZmZzZXQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIodGlsZV94
X21hc2ssIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIodGlsZV95X21hc2ssIEht
eFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIodGlsZV94X2luYywgSG14U3RhdGUpLAor
ICAgICAgICBWTVNUQVRFX1VJTlQzMih0aWxlX3lfaW5jLCBIbXhTdGF0ZSksCisgICAgICAgIFZN
U1RBVEVfVUlOVDMyKGZ4LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGZ5LCBI
bXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfSU5UMzIoY2hfc3RhcnQsIEhteFN0YXRlKSwKKyAg
ICAgICAgVk1TVEFURV9JTlQzMihjaF9zdG9wLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVf
VUlOVDMyKHlfc3RhcnQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoeV9zdG9w
LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHlfZGlsYXRlLCBIbXhTdGF0ZSks
CisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGJsb2NrcywgSG14U3RhdGUpLAorICAgICAgICBWTVNU
QVRFX0lOVDMyKGRZLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGdyb3VwX2Nv
bnYsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZ3JvdXBfc2l6ZSwgSG14U3Rh
dGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihncm91cF9jb3VudCwgSG14U3RhdGUpLAorICAg
ICAgICBWTVNUQVRFX0lOVDMyKG1hY19jeWNsZV9saW1pdCwgSG14U3RhdGUpLAorICAgICAgICBW
TVNUQVRFX1VJTlQzMihjdnRfZnhwX3BlbmRpbmcsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoY3Z0X2Z4cF9wZW5kaW5nX2FnZSwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRF
X1VJTlQzMihjdnRfYWNjX2NsZWFyX3BlbmRpbmcsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoY3Z0X2FjY19jbGVhcl9zZXQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9F
TkRfT0ZfTElTVCgpCisgICAgfSwKK307CisKK3N0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRp
b24gdm1zdGF0ZV9oZXhhZ29uX2hteF9jb250ZXh0ID0geworICAgIC5uYW1lID0gImhleGFnb25f
aG14X2NvbnRleHQiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11bV92ZXJzaW9u
X2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7CisgICAgICAg
IFZNU1RBVEVfU1RSVUNUKHJlZ3MsIEhleGFnb25ITVhDb250ZXh0U3RhdGUsIDEsIHZtc3RhdGVf
aG14X3JlZ3MsCisgICAgICAgICAgICAgICAgICAgICAgIEhteFN0YXRlKSwKKyAgICAgICAgVk1T
VEFURV9FTkRfT0ZfTElTVCgpCisgICAgfSwKK307CisKIHN0YXRpYyB2b2lkIGhleGFnb25faG14
X2NvbnRleHRfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSkKIHsKQEAgLTIyLDYg
KzEzOCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25faG14X2NvbnRleHRfY2xhc3NfaW5pdChPYmpl
Y3RDbGFzcyAqa2xhc3MsCiAgICAgUmVzZXR0YWJsZUNsYXNzICpyYyA9IFJFU0VUVEFCTEVfQ0xB
U1Moa2xhc3MpOwogCiAgICAgcmMtPnBoYXNlcy5ob2xkID0gaGV4YWdvbl9obXhfY29udGV4dF9y
ZXNldF9ob2xkOworICAgIGRjLT52bXNkID0gJnZtc3RhdGVfaGV4YWdvbl9obXhfY29udGV4dDsK
ICAgICBkYy0+dXNlcl9jcmVhdGFibGUgPSBmYWxzZTsKIH0KIAotLSAKMi4zNC4xCgo=

