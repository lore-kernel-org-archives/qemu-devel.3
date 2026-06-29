Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC186C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCI0-0003v6-KG; Mon, 29 Jun 2026 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHE-0003b5-Od
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHC-0006CV-NV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATMfF2647667
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=; b=coIm7/1cBU64IM7k
 JnBdyrRsyOqqoppTKOa0FzvZupmcBaqDI+bxjeNTD/dm2puHKN8C85o7y5bi8ZuD
 UW76IcddNRuiG81w3V6PZysAiafiG2+XOXC+yUrjNB0MUaY633gWgWe0ha6fKepZ
 T6uNBV/vdY5FKcZTmQ2+rwWbnNEX0aFd2dUcYJ1ixsjT7ILGxD8RwLiSd5G4Nzsd
 35l2zfpSctlewMuZMgDm7NGH+hbh2BV35lekEJof6AL4JmJVlJi7gmXF3NE7S+cQ
 Fm3mNExm9fwLbLJ3clTRHUEARR5QjBt5dKhJid5Delc70ghB8qmAbcrM9/M1dxV2
 K/+11A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tshem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c987913b08so20740755ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740632; x=1783345432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=Bjm4jg3IbAg0A005K6N6OUf4hWBOCDe+l4ny+1YXxcOSpXeS6dQhT6iWHqzEhgbv7r
 MyQzQXZik1g0LHNHnuYaoqSilJ+ogNyumshWnOWnR92Py8XeN+YtV1y4EqRjJuItPiWz
 shsb1juvE4+zgF5QjAWJxVaFiyRrX6cUG5ohjwFgO+FcofyaUYFAs4dxbV/0e91yEoGg
 bbCkurSI4uA1lDeRb8jlAkxBtdpS2Z+a7L2Flh5CEX9OpnoL66VI4T9lYhTyM8oThMf1
 S9fWQKjkoUjbEU3kBsy5ziQ1tmF6NUmyv5CMbJLLVvFr4WlBE4bWW2O5DstlmezB5epy
 jGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740632; x=1783345432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfSshN2DTXGV0fIztvVhxkGkdYU5fHFXewTdLdv52c8=;
 b=bLpIWJ01jH3BkCI4ryfsMX6dyhmXhATIQgC6tOZ/JnIWilhYnHecLl92WRMLqv1fMU
 KZMGsfC1H341v6U4b5MGmgzacaxqmR68x2BRllge6WvEYycND/EtReuvNLAMRqx6sUAN
 kAok4ctw5AkMgGEbvyE+B8jmgv8jt3oaww/SJC59NUTA/2r2c2pc28g6thBBI4QtNxHd
 ABlnXNDBSnWPey8m6XDtaqNUEG3s8kTo2cZukB3jVt6ULmEX2bdvqyYL+Q9ZDxr+zzEw
 Vpa83wuxzSkmZ3vUv+VKjbMAIr2Z3/UN/CauYPgPmPIdlvtrtt+H2trBStN5rUzwSlsh
 Mgig==
X-Gm-Message-State: AOJu0YzzVRKhgA/DROzZN1v0+nR9tnfdqNhKM8zWhiXaLe2h2yGwRLd1
 VJY4767fX0xafx6JBoqaPOFLGmsuSq3gh7Ebq/R5kFGbgd9U26mVtlKmZNrsBXlZJuhGaa+YU/x
 3NWUqA8HgUGaxDcqSyIgFrFMHTCOCharP1Ny+nvgAcP7u90TxVW1y+WysQUCMx7wIRg==
X-Gm-Gg: AfdE7cnqTPDJwNuqfx99LvVnQJLv1bMZOyKX1UQlAzrZnaWxgWCjJNhZ5dH1dJo8Qsj
 OU07pMkKMyNJc3YwA/prTQIEJibFXcZd+OM/clsqQtxCb5VOXkBscOA3T3g+Xs8w0Mh6k5TZBaL
 3A5agD3xKynj0ly9tidNETg5iFsioTOsuVu0vTmPWqrzLx+dHTwtJkQDFj9mCGIs3EIjA6C0X1a
 Pv02hlPPfhLYQi1NdqgyvY2G03A+7M+L0A/b7F+PasPtSGVQNV5bvX26fIgIxqW69kIuMXiCsJd
 hO+Po7gq2tqkd6KJ2ib0xooiZD3k59QPLmuPBIu1EQASYW+hTHWlNgzaKOeNF1jqwOysY1nTPqm
 6i7UzbuMfioHE4oVi1E+hWQ6vrOvVVmj5C8Rc3mWwWOyOv550tsbuyCCNZrg=
X-Received: by 2002:a17:903:3888:b0:2c8:2808:3ec5 with SMTP id
 d9443c01a7336-2c82808420dmr96593505ad.5.1782740631825; 
 Mon, 29 Jun 2026 06:43:51 -0700 (PDT)
X-Received: by 2002:a17:903:3888:b0:2c8:2808:3ec5 with SMTP id
 d9443c01a7336-2c82808420dmr96593305ad.5.1782740631359; 
 Mon, 29 Jun 2026 06:43:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 45/77] target/hexagon: Implement wait helper
Date: Mon, 29 Jun 2026 06:12:00 -0700
Message-Id: <20260629131232.2487780-46-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX5xBbfBVf1URz
 yhkxglhA+O26sMl1N/troRvfcHhcgkbfOdkIMeOj5bQnOiN0hFtFaan8/h9sXDsX/yQG6fXUt5a
 6ki5gSND8tEVuoeUoXTaFpZp6g1vSylZSQTpt/YU3zO6jiFmXiYLj9GOBZXQQ/CazLUkO0aUkMN
 /aMgTmEqBCqKj7mERReIb94pvF+BAVKdaoLqbm7RUo/GQSTpos9EVBztfN8BbBDROrg88hCeBul
 ItHUm2kor/DePd8aSkQfpOMURbkxFBzaVD/jG4oPdaunCkWix8Hwvv370b1ymvNfqzcuIB13X1D
 7VKIzS8+s/aQ9irrGCxiDNiX4vZrXMyIrwEbAVAO8dOJXUxx7HDDDmoDx9wN3WsoUlqLLJxyvvj
 xbCc3i6ptm9C/ePkrPYWjPL1NTrpdYrKYxqIHl+2f96xu/voKluxCqwDlB5rR4IMGlodW8PLxwP
 Eq9qViRlWMCYHLKiZTg==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a427698 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXy55MbNviM3ZO
 EYkhkoaoPNxf07L2pgs8fnL31zJQA7XnCBdHfA0SiSeN0+DBfFB8/zb5uCfTEldECCznCjE1weC
 6KrI/RPPey3vY4apZy8RaMRiFTBAEs4=
X-Proofpoint-ORIG-GUID: 72Nd45NGlxNReWxakhqFG_l_TETm9oFm
X-Proofpoint-GUID: 72Nd45NGlxNReWxakhqFG_l_TETm9oFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8IDYwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA1OSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDI2NGVh
MDI3NTJkLi42OGIyMzg5NTQyOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19z
eXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw3ICs4MCw3IEBA
CiAjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCiAgICAg
ICAgIFJzViA9IFJzVjsgXAotICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2VudiwgdGNnX2Nv
bnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2FpdCh0Y2df
ZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QucGMpKTsgXAogICAgIH0gd2hpbGUgKDApCiAK
ICNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRl
eCAxNjgwZTMwMGVjNC4uOWQ1MGU2ZWY4ODIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDg3LDkgKzE0
ODcsNjUgQEAgdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgaGV4
YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCi12b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQorc3RhdGljIHZvaWQgc2V0X3dhaXRfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAg
IEhleGFnb25DUFUgKmNwdTsKKyAgICB1aW50MzJfdCBtb2RlY3RsOworICAgIHVpbnQzMl90IHRo
cmVhZF93YWl0X21hc2s7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgY3B1
ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpZiAoIWNwdS0+Z2xvYmFscmVncykgeworICAgICAg
ICByZXR1cm47CisgICAgfQorICAgIG1vZGVjdGwgPQorICAgICAgICBoZXhhZ29uX2dsb2JhbHJl
Z19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfTU9ERUNUTCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICB0aHJlYWRfd2FpdF9tYXNrID0g
R0VUX0ZJRUxEKE1PREVDVExfVywgbW9kZWN0bCk7CisgICAgdGhyZWFkX3dhaXRfbWFzayB8PSAw
eDEgPDwgZW52LT50aHJlYWRJZDsKKyAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdf
TU9ERUNUTCwgTU9ERUNUTF9XLCB0aHJlYWRfd2FpdF9tYXNrKTsKK30KKworc3RhdGljIHZvaWQg
aGV4YWdvbl93YWl0X3RocmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgUEMpCit7
CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKworICAg
IGlmIChxZW11X2xvZ2xldmVsX21hc2soTE9HX0dVRVNUX0VSUk9SKSAmJgorICAgICAgICAoZW52
LT5rMF9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEIHx8CisgICAgICAgICBlbnYtPnRs
Yl9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEKSkgeworICAgICAgICBxZW11X2xvZygi
V0FSTklORzogZXhlY3V0aW5nIHdhaXQoKSB3aXRoIGFjcXVpcmVkIGxvY2siCisgICAgICAgICAg
ICAgICAgICJtYXkgbGVhZCB0byBkZWFkbG9ja1xuIik7CisgICAgfQorICAgIGdfYXNzZXJ0KGdl
dF9leGVfbW9kZShlbnYpICE9IEhFWF9FWEVfTU9ERV9XQUlUKTsKKworICAgIGNzID0gZW52X2Nw
dShlbnYpOworICAgIC8qCisgICAgICogVGhlIGFkZHRpb24gb2YgY3B1X2hhc193b3JrIGlzIGJv
cnJvd2VkIGZyb20gYXJtJ3Mgd2ZpIGhlbHBlcgorICAgICAqIGFuZCBpcyBjcml0aWNhbCBmb3Ig
b3VyIHN0YWJpbGl0eQorICAgICAqLworICAgIGlmICgoY3MtPmV4Y2VwdGlvbl9pbmRleCAhPSBI
RVhfRVZFTlRfTk9ORSkgfHwKKyAgICAgICAgKGNwdV9oYXNfd29yayhjcykpKSB7CisgICAgICAg
IHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAiJXM6IHRocmVhZCAlIiBQ
Ukl1MzIgIiBza2lwcGluZyBXQUlUIG1vZGUsIGhhdmUgc29tZSB3b3JrXG4iLAorICAgICAgICAg
ICAgX19mdW5jX18sIGVudi0+dGhyZWFkSWQpOworICAgICAgICByZXR1cm47CisgICAgfQorICAg
IHNldF93YWl0X21vZGUoZW52KTsKKyAgICBlbnYtPndhaXRfbmV4dF9wYyA9IFBDICsgNDsKKwor
ICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7Cit9CisKK3ZvaWQgSEVM
UEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKK3sKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworCisgICAgaWYgKCFmSU5fREVCVUdfTU9ERShlbnYtPnRocmVhZElkKSkg
eworICAgICAgICBoZXhhZ29uX3dhaXRfdGhyZWFkKGVudiwgUEMpOworICAgIH0KIH0KIAogdm9p
ZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKLS0g
CjIuMzQuMQoK

