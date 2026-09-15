Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32936C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4O-00063O-QM; Tue, 15 Sep 2026 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W46-0005wp-1g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W43-0003qm-0y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAPeK813402
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hqfVicHy6v894bNbcDZGGKOJEk5tlT9bKuiAy6xrO9Q=; b=Psa/d0XVf0UNzzqg
 LqadgSJUaJjkV+mz578HQlxDbwiaySm/bA87SaMOqqVlj6wgAfgvk6MBmZiJp26b
 fcKjtTMUvC3pZouHZVIkyDE6vUYHAVoUfSZPSZNJRwMMHb9RTEpEcu6BHy/K83yl
 1h2P9/tJuDgNCESRx0ihzSsGNmPEKjPJxehhG8yAFuDjj5YpVCJN1oYt4baMacYK
 TV8XUn65Vy9NoPGEhtAi5v1IvuDIRNNeQSOXJUwWcSCF2NiIiPKkXenisFKBAJ2+
 YrbvuAIIyRxzWNW7Bu0qaj3Tw+Idn2soa74aiD99fg76NFKfmWebZ50ME2z/fqye
 QUsmCw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc1740-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso8893599a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489880; x=1790094680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hqfVicHy6v894bNbcDZGGKOJEk5tlT9bKuiAy6xrO9Q=;
 b=IOAG8BnVJoMziQ8DFDrV33FG+ZbZL8jHRSuY9PPWg7c0oOdPb1SR9ISXEGfLw6MhJU
 OfLYCTbVFfRpOrAOiIiapluiybxBDtEpIRp8Gmz4jqKvUeRlmiziAvQYYaSLiE13LdHa
 ul/jThWshChvIlg6YV1pWSvC8h8doBKfoCH4J15Ya1gDw83JLaFqOXdFLUnkiBt2TFxF
 EINjlbREwKn53emvshZm9QRAjJyiXDo8CCnvuJPgzFunYur/P80pbXbs4+Qoasl+QGrA
 4ZM+NndGdVIhoq/xgah1v8WV3VifjTmJduM2tZimUUBU0TwhWqCVzfoTJXGwqjjtOjFh
 pajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489880; x=1790094680;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hqfVicHy6v894bNbcDZGGKOJEk5tlT9bKuiAy6xrO9Q=;
 b=Rkh9ceMBmq/ctAG0eIry83TxJiiUXxhymhmcuL0HrnTwZPRgfbJ1ZfWyw4+5NvTBwG
 LPOPZr1k+zh45KPQJJa2082g1AdbBVFjy9Ib2dosfEoDf+/Hs+2pYHH59cGA0ORd3Hex
 HluxEx9vTktI2jKR3hqb3bRd1sjie2XcJZQGaVvyZkWpuo5MDGGWjLWsGV7iDw5smP9l
 QNODRivG2OUwFK1aC989knLhTd2VZ8JK5k2sF3V/B4wMPuuqcPEEG80VL4oFeAFprmh6
 yxT7syWxdbYqJprvXfJ6QCbMKqgJDmxumfougA0O2Y7gI6ZEbOAbxDEAG9ABL+3oKrNT
 bGCg==
X-Gm-Message-State: AFuF++n1ZxQik5eunNzL3FVErp5VOYtXiCG9EoVC6hezRB9CTZlI3Q7j
 3+s2ZeHO7cF/OCNXpgiixlKdrvvrBnF7x7TMzsxfKdj3KNwErlpv4rc1Pk+f/YSom1zkl5CrdPQ
 845sShqV+9JGNkeLWUoizG4xtJpEjStVEm3kct3st9d/uLERv71cGQLIUNrk5DTBJ8g==
X-Gm-Gg: AYBFou0ounW/BHuYuib1pFQ1ji0ECaggXV+9HQ+m8W32Rd8GDwpu7cuCCe4uBnZCOdj
 ngZWSh09tMV3WGgidWl+vGjVLiyLnzRhwEiYLlyTEV/1rhunWpS1dLdp3+u0IsNmHpjEj/CIQpk
 V6RGBX87Vm0AK/vB6OXmk57MydHvqcXMZBL6OiDBLhkGk5aJD+w/sOGGetm02ntC35LWizCGDsS
 q/+kCiBd22ra1wkumiYlTjUbG83XrAR5ViOZGDquzZreJd7Qzlwc7V49Rf2h69jFMIGad/hIQ1Q
 19qoNy8Ss4eCS08SXg39vFaD7dzNrD2Z956Vp5nr5olqmGZVqPdd93usByP4z7rgHxwBmGw7OHm
 5AX4fVae3D4kPUdw1fLyXKZ7pQSrvfxYVhTuc0GcaeIJcg6Nn
X-Received: by 2002:a17:90b:4a85:b0:39d:f731:e5f3 with SMTP id
 98e67ed59e1d1-39df731eb5dmr4669775a91.24.1789489880021; 
 Tue, 15 Sep 2026 09:31:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4a85:b0:39d:f731:e5f3 with SMTP id
 98e67ed59e1d1-39df731eb5dmr4669717a91.24.1789489879504; 
 Tue, 15 Sep 2026 09:31:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 11/17] tests/tcg/hexagon: add sfrecipa edge case tests
Date: Tue, 15 Sep 2026 09:30:41 -0700
Message-Id: <20260915163047.4180600-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX42SNm9t/iHFz
 53i6zsnscGn/JpVYDKeEdxnz61I1sDRDu+ayPbjSR652YwzuCEBwTIeehC+itHHvc4mFEbZnJvn
 ZB0vg8LNNTMiMe5KLbfxGgwku7Li4sw=
X-Proofpoint-GUID: sPOw0bMFZJArg81JfgFoilI20DCKgmAG
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa972d8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=iLNeMspusdFBM-S5qpkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: sPOw0bMFZJArg81JfgFoilI20DCKgmAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfXwTyssixZwZS2
 BRk35rmiDguMgOIl4impepNM6c3yCU8YP9oohtxZFngh56allzjbjxZpYnNF1tVcywZX/JXCGLf
 XyxkOWe8Cg0QZGMg0D6bxOs/+BSORBJ012daf5bkauAQMxjnUNJ/wn+FCva5w/aRsQ3c5dbr7HW
 +DVRDi80E1XVBqkEwUHUCc9AhVO8wZ1BfkAX+5WmXNO+eI9nN6OtjyblhjJ/L+spIC+Q7FpiLlW
 NLaMi365XQ/STOz4KxFxp51BLYgGiaX95unB3dFJ5GtJKx+d9qU11wvwbb+XmxhkgNvLa2g/5TQ
 MYuHNof0xr3R+Kyk2Y1sQoyeZ8xVmlji0+NzUEGWG1FLiPbKPgpj/UkpkgFW/v0ex9QRzSjY4uq
 h6NcB+7iGnXXl1d9APLzJGfehzrdybga2utBqbFneDqCxO3P56HTzxCSVbbjC1/rPFw0uolDBv6
 v1EiOkmInDUiEPBL9gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
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

QWRkIGVkZ2UgY2FzZSB0ZXN0cyBmb3IgdGhlIHNmcmVjaXBhIGluc3RydWN0aW9uCgpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIHwgODEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMgYi90ZXN0cy90Y2cvaGV4YWdv
bi9mcHN0dWZmLmMKaW5kZXggNzU2MWYzMWNkYzMuLmY4MjI2MmFiNGFjIDEwMDY0NAotLS0gYS90
ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVm
Zi5jCkBAIC0zNDUsNiArMzQ1LDg2IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3NmcmVjaXBhKHZvaWQp
CiAgICAgY2hlY2szMihwcmVkLCAweDgwKTsKIH0KIAorLyoKKyAqIEhlbHBlciB0byBydW4gc2Zy
ZWNpcGEgYW5kIGNhcHR1cmUgcmVzdWx0ICsgVVNSLgorICovCitzdGF0aWMgdm9pZCBkb19zZnJl
Y2lwYSh1aW50MzJfdCBScywgdWludDMyX3QgUnQsCisgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCAqUmQsIHVpbnQzMl90ICp1c3Jfb3V0KQoreworICAgIHVpbnQzMl90IHJkLCB1c3I7
CisKKyAgICBhc20gdm9sYXRpbGUoQ0xFQVJfRlBTVEFUVVMKKyAgICAgICAgIiVbcmRdLHAwID0g
c2ZyZWNpcGEoJVtSc10sICVbUnRdKVxuXHQiCisgICAgICAgICIlW3Vzcl0gPSB1c3Jcblx0Igor
ICAgICAgICA6IFtyZF0gIj1yIihyZCksIFt1c3JdICI9ciIodXNyKQorICAgICAgICA6IFtSc10g
InIiKFJzKSwgW1J0XSAiciIoUnQpCisgICAgICAgIDogInAwIiwgInIyIiwgInVzciIpOworICAg
ICpSZCA9IHJkOworICAgICp1c3Jfb3V0ID0gdXNyOworfQorCisvKgorICogQWRkaXRpb25hbCBz
ZnJlY2lwYSBlZGdlIGNhc2VzOgorICogICAtIGluZi9pbmYsIDAvMCAtPiBOYU4gKyBpbnZhbGlk
CisgKiAgIC0gbm9ybWFsL2luZiwgMC9ub3JtYWwsIGluZi9ub3JtYWwKKyAqICAgLSBkZW5vbWlu
YXRvciB3aXRoIGV4dHJlbWUgYmlhc2VkIGV4cG9uZW50cworICovCitzdGF0aWMgdm9pZCBjaGVj
a19zZnJlY2lwYV9lZGdlcyh2b2lkKQoreworICAgIHVpbnQzMl90IHJkLCB1c3I7CisKKyAgICAv
KiBpbmYgLyBpbmYgLT4gaW52YWxpZCAqLworICAgIGRvX3NmcmVjaXBhKFNGX0lORiwgU0ZfSU5G
LCAmcmQsICZ1c3IpOworICAgIGNoZWNrX2Zwc3RhdHVzKHVzciwgVVNSX0ZQSU5WRik7CisKKyAg
ICAvKiAtaW5mIC8gK2luZiAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoMHhmZjgwMDAw
MCwgU0ZfSU5GLCAmcmQsICZ1c3IpOworICAgIGNoZWNrX2Zwc3RhdHVzKHVzciwgVVNSX0ZQSU5W
Rik7CisKKyAgICAvKiAwIC8gMCAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoU0ZfemVy
bywgU0ZfemVybywgJnJkLCAmdXNyKTsKKyAgICBjaGVja19mcHN0YXR1cyh1c3IsIFVTUl9GUElO
VkYpOworCisgICAgLyogLTAgLyArMCAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoU0Zf
emVyb19uZWcsIFNGX3plcm8sICZyZCwgJnVzcik7CisgICAgY2hlY2tfZnBzdGF0dXModXNyLCBV
U1JfRlBJTlZGKTsKKworICAgIC8qIG5vcm1hbCAvIGluZiAtPiBmaXh1cCAoUmQgPSAxLjApICov
CisgICAgZG9fc2ZyZWNpcGEoU0Zfb25lLCBTRl9JTkYsICZyZCwgJnVzcik7CisgICAgY2hlY2sz
MihyZCwgU0Zfb25lKTsKKworICAgIGRvX3NmcmVjaXBhKFNGX3R3bywgU0ZfSU5GLCAmcmQsICZ1
c3IpOworICAgIGNoZWNrMzIocmQsIFNGX29uZSk7CisKKyAgICAvKiAwIC8gbm9ybWFsIC0+IGZp
eHVwIChSZCA9IDEuMCkgKi8KKyAgICBkb19zZnJlY2lwYShTRl96ZXJvLCBTRl9vbmUsICZyZCwg
JnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKworICAgIGRvX3NmcmVjaXBhKFNGX3pl
cm9fbmVnLCBTRl90d28sICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKwor
ICAgIC8qIGluZiAvIG5vcm1hbCAtPiBmaXh1cCAoUmQgPSAxLjApICovCisgICAgZG9fc2ZyZWNp
cGEoU0ZfSU5GLCBTRl9vbmUsICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsK
KworICAgIGRvX3NmcmVjaXBhKDB4ZmY4MDAwMDAsIFNGX3R3bywgJnJkLCAmdXNyKTsKKyAgICBj
aGVjazMyKHJkLCBTRl9vbmUpOworCisgICAgLyoKKyAgICAgKiBEZW5vbWluYXRvciB3aXRoIGJp
YXNlZCBleHBvbmVudCA8PSAxLgorICAgICAqIFJzOiBiaWFzZWQgZXhwIDI2LCBSdDogYmlhc2Vk
IGV4cCAxLgorICAgICAqLworICAgIGRvX3NmcmVjaXBhKDI2VSA8PCAyMywgMVUgPDwgMjMsICZy
ZCwgJnVzcik7CisgICAgY2hlY2szMl9uZShyZCwgMCk7CisKKyAgICAvKgorICAgICAqIERlbm9t
aW5hdG9yIHdpdGggYmlhc2VkIGV4cG9uZW50ID4gMjUyLgorICAgICAqIEJvdGg6IGJpYXNlZCBl
eHAgMjUzLgorICAgICAqLworICAgIGRvX3NmcmVjaXBhKDI1M1UgPDwgMjMsIDI1M1UgPDwgMjMs
ICZyZCwgJnVzcik7CisgICAgY2hlY2szMl9uZShyZCwgMCk7Cit9CisKIHN0YXRpYyB2b2lkIGNo
ZWNrX2Nhbm9uaWNhbF9OYU4odm9pZCkKIHsKICAgICB1aW50MzJfdCBzZl9yZXN1bHQ7CkBAIC04
ODcsNiArOTY3LDcgQEAgaW50IG1haW4oKQogICAgIGNoZWNrX3NmbWlubWF4KCk7CiAgICAgY2hl
Y2tfZGZtaW5tYXgoKTsKICAgICBjaGVja19zZnJlY2lwYSgpOworICAgIGNoZWNrX3NmcmVjaXBh
X2VkZ2VzKCk7CiAgICAgY2hlY2tfY2Fub25pY2FsX05hTigpOwogICAgIGNoZWNrX2ludnNxcnRh
KCk7CiAgICAgY2hlY2tfc2ZmaXh1cG4oKTsKLS0gCjIuMzQuMQoK

