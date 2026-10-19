Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97F8CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgYm-0004ep-Qq; Mon, 19 Oct 2026 02:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYl-0004eT-Iz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYj-0002k6-Um
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4iwho2768439
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3g0AINHh072KnYnDIq6xQsThx6XYk9Aga00Tf9ABTpo=; b=aaJ7it2KaNDWEQxH
 Hzs5VlDUm5P0H7p6k2Ieo78/sk7FQWvneDhxuevoL1e6FPcYzP1BzLT5tz8eyozf
 77sKg4PShJpZUdmTcwRnwwCER8ldkNYFAURGP0Trd16L14v3vTTZMJpA96a1T2Zv
 tbukOTrJEevuYImwv9feiRfjrZMALXjEr+7VaeR5AP7hCBUGoRw3cdwcmJgMnUIe
 H+Pru9K51Y/wzna75295MmYgp4f7vo+TLNNlfINZSfSX41TY7sVowYSyV8AmZa1L
 S8J6AdSQxfqqRBHNgaQAIaGPE1akUxemuf7fU1yKgSon4fyAHfVDXPr+yyVI9izr
 PqJMzA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys58q0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3907125eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792390160; x=1792994960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3g0AINHh072KnYnDIq6xQsThx6XYk9Aga00Tf9ABTpo=;
 b=BJOXVSr8rGGBhvWUtSHl0WEMgV9qB8AmwymuanKIfIjBcAHYOoNQq8/qqvLHDcwrUa
 MxJHx8wKKNmoTp1ElDYKdo0K6pSzDo5J7DoCbUR7ivOCY0opbvXlZO9HaNAqfueiKM9l
 ye5R5S4mQCthe4vi5ii7jtwQnkkVyei7HzjW9GjRgMEjjPKc9HhhfsFkFrkSzmGn2kKU
 uurEIxA06dw+EscVRsZAeyxahCZSf3dEmHFcSz0cmNBzyH1Jh292AGJdgAMe6+976oDd
 Hf/qyZY8eesSgjQOrZ/Did9/qF+5d45bjTTgVHeRownHkIIIMx9HEhPZ6tlZ6Ofb54bG
 HRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792390160; x=1792994960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3g0AINHh072KnYnDIq6xQsThx6XYk9Aga00Tf9ABTpo=;
 b=xjXMMOF3m70H3e7vf6SPudrc3hdhmp5wd5gPJ2QqlJV/ixFCVWWdy3tEp1DVSvpEmw
 ldoqnbNmWE9R9+Fz+lF1h7qSXICPi1o6ZKYysbNETkrvlaAT0ynbJTeeYuv4b7qtC0qF
 XjhbqP/eZxu7FvM+KooGauy/5CTVSy7AW1879iE5w0DmIapojMdG+Yldatx2nbGfukk9
 TTWfCJe6MuAsd9iSlvAnq6VBZDdi1gi7fKY9ijpI4JFwMnE8LSaAcv6qF4QFVKbNIDGB
 kYx/jy8IrVl3btImzrFFJav5l1D/s1sgoRPOhqXXpRv5KC5LSUdoEco1uQZEdeh36Gjg
 pwsA==
X-Gm-Message-State: AFq9FYLAndyfYf0pqM9IIK/hjaZ9uvQ6Oz+oijfPW5bAamOMqs7H5O3M
 jP2wZ4cYOZY5UNYDY9zqoYQ8RucigY1Clpci5kk4w4zurs3sCkNKdXHzv421qyTdUmJMOTsNoH4
 NxM82IPy6ARSPZEXsHgyB6SA43KLYWyUS/0GId342IS1T86Drm3WLVROhXR1m5wwAnw==
X-Gm-Gg: AYBFou2IjcQVWierarjMIvh/S9LEFku+N7WNTU8+P1AgzuasX6JjcOO157asXJ2zTS9
 eQSHB1Qjh5g3sNwVb+0uXfmNBgxpJCGd2y5uiVLXTdI/2yoUh6iVEjpXM31YrUDLbrED6UMqE75
 nkyPW6bo2Xk2i90PPu9wDnuq2nfozcnP5T7tsKXhV3piOK+snMm3bDTdlMwz2HQ4eYt54TflDNX
 kTJ3AaNx65T6KG1SwNTA6fxUw6z5X/R6nPu+IDP35lOruGLtP9engpqCtPs53rBjl7JZWULzWwi
 9jJY6492CCVSOhlshbuA38XO6fl7EWVl6K1Uxjad8aEyozauQOxe8iFCqkHZajwXy/1DX77R5ET
 cJN9t4bW6fpMHu1xWEMUBzfovOknrbiqxGTKtKn3bsWB/cUY=
X-Received: by 2002:a05:693c:821c:b0:35f:5591:e40c with SMTP id
 5a478bee46e88-361a195ad4cmr9144993eec.22.1792390159790; 
 Sun, 18 Oct 2026 23:09:19 -0700 (PDT)
X-Received: by 2002:a05:693c:821c:b0:35f:5591:e40c with SMTP id
 5a478bee46e88-361a195ad4cmr9144958eec.22.1792390159011; 
 Sun, 18 Oct 2026 23:09:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm31770053eec.17.2026.10.18.23.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:09:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/5] target/hexagon: drop a pending HALT when resuming
Date: Sun, 18 Oct 2026 23:09:09 -0700
Message-Id: <20261019060911.1479329-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfXxaj3CX10gnv9
 Q7cQc5DXYP4t2XVQoqBZ4kVbfLvi/267/PGPY7+dRlEhzbkrXiOQYYkfH4ECAj24r67YNZjzSgM
 Bxqc0yokI13GGV/cohHyX8foSj4FhssAUXt2GqRDCF2FkyZHtl9sLFMgbac4W0T1uvjceJnS+SB
 0CbnydY4n4VhZBYNP8pnvh/YCayRQYKF3janRGSNHGf7whNPxsveC02uJ2hzk3+DbKc5j1ff0rX
 FApsUapfG0DLjerhsJ20oI4qWjIrdvBjfSaMlHsNgChMPpT15XkERQy8TUb6/u2z5JWBKHe2bcg
 N19/pZVV2qnlGcwa2ci7yoiAaHoFkTNSq7R7o2Qgntdb6tgQCsKUnHnWqwkQaSbJT4bRGTXw8G2
 0l2a4mHCeIDznAR5e+1gLlhP33yvhGkRU8FR9CZZc0gVzJKFRmgThisjh5WsISqL4yr+Umd505j
 2vPeRHDRXnLvVkgqANg==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad5b410 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=I2XebtYxRxNeac7nJm4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: pOSoMzaKnl7PZKujmCURTLR40ujhA-v_
X-Proofpoint-GUID: pOSoMzaKnl7PZKujmCURTLR40ujhA-v_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX5o8y0PX3wM1M
 r/3VxLlUd5FFpT5EL09X/q2TRlzfLQzof41yBBxz1ykfgaPQnZzuzXIt3MSPuAugoAI4PoDIHOA
 gchW0R/ojOUoF5+lMENIMtx7DwfE1PY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190024
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

QSB0aHJlYWQgZW50ZXJpbmcgd2FpdCBtb2RlIHJhaXNlcyBDUFVfSU5URVJSVVBUX0hBTFQgb24g
aXRzZWxmIGFuZCBvbmx5CnRha2VzIGl0IG9uY2UgaXRzIFRCIGVuZHMuICBJZiBhbm90aGVyIHRo
cmVhZCByZXN1bWVzIGl0IGluIGJldHdlZW4sIHRoZQpIQUxUIGlzIHN0aWxsIHBlbmRpbmcuCgpD
bGVhciB0aGUgSEFMVCBvbiByZXN1bWUuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKaW5k
ZXggNmRjMDY0MDFhZDUuLmI2ZjMxYWVmYzBmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBAIC0xMzgsNiAr
MTM4LDcgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQogICAgIGNsZWFyX3dhaXRfbW9kZShlbnYpOwogICAgIGNzID0gZW52X2NwdShlbnYp
OwogICAgIEFTU0VSVF9ESVJFQ1RfVE9fR1VFU1RfVU5TRVQoZW52LCBjcy0+ZXhjZXB0aW9uX2lu
ZGV4KTsKKyAgICBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwog
ICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVYX0VW
RU5UX05PTkU7CiAgICAgcWVtdV9jcHVfa2ljayhjcyk7Ci0tIAoyLjM0LjEKCg==

