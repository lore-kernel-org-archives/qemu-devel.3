Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1D606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UDcaG3l/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYzgFFbK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXum-0006GU-8o; Mon, 26 Oct 2026 23:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtx-0004VP-KP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:31:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtw-0000DW-10
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:31:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2EuSO1348708
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=; b=UDcaG3l/o10Ry92c
 0DnwshtUq0JZsAhiM/ycJ0sUJ2Rt4dwEM+HfEj/ShwHF3bVktjf/0xnkozzC1ivo
 8YLLJ2i4ueQ08l5zZn/pBcKDgf1uwXtj2T6i5bsYwTDEyjWxhC+RapzW2U2ORVvL
 h+HdHm/nd5UllfkDGqe4JgL2PzXfjboKeqHz+Y7jX75I/fr8RHJxa+7uo+NA8yuX
 WC3DljzjKhm7bGhFVRmbe3iuoLFZE4Zfw1QgI9+qqGlx9jb36DdRSTELwyIw85xK
 XVEHM6ysohD7674Mz62iAnxn30ZHyiqP55mrJnPs1nCu/U0MbRFsRC6lmFzk3RwQ
 b2KNYQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbt8b4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so5934973eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071851; x=1793676651; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=;
 b=LYzgFFbKPc+SS8vs2HMn67NRabzhG3JKSyLWJcBg2XS6y1Tw8V9jLM/iMwXmy6W3sH
 JlJbbWpU1gpopryFfDf+PC2zpl6GlplZfaEwCjm2y3WclpwZVhQ8D4hU8UApN7GWQeJz
 Icg8pCHGxViUMrO5DK58iYzm7txxm7y2YtV5GAV2ze428R4doShGUCQNxgPq1CGKN6gv
 mfgTP2U3wyGx/q9X2kfHGxUkFfRCRYInVJNhmotzZMuqaCOhyE0cVcUYWkjtKOE46fQr
 uFDOjk5hYCwkVs1wX1wXDAJ1rnlFF+hzG80GHMf86zVpI96oda7Gy4i/qWQK/ikgAyC4
 YYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071851; x=1793676651;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=;
 b=d0GkQr5zMt3AgsvpgYRvYvo4h9xtxko4ZWO69PzFSIw/W8P6633oq37DnPfHfEhJN8
 b7QoSToAzpijBsai2N6pYV0fKw+KJV5OmwBfiSxfiSLRs45Ft3SbB26DCo5bkBZl9VRd
 sPD60zu7TJ3gX3mnhYtcsRjZRzY+qXAwJ50c39D0AAnRnTl08wEkh9qrZ3vSm0lTixlC
 URjf1amAnFEvAkNmJVZPuQSGdmidqFcUWjlPkJH41LLOEn3XKP8twEXiZcGObC4f+ASA
 SDTqwJYrIOWt3xXBl3aXrpoueIt58R8yPgSlwSLedGMcmnDDCHabUhPYoBAmMAFeTyfV
 CilQ==
X-Gm-Message-State: AFq9FYL4lyiNJNZKuFt+qj86gLypMwpLsJ7inSPM6cFcheNKInNtQDgc
 EE5cBifdljaSGv6FJlVKmrAjKaHFxHahUQzl63ckvlcwPxrK4cAFykhI3H6Ry5l8vuWrRgLfwSE
 REa/WVxEnCP6ISWCg+arOI9KuX1XSsnYdPHZV7I4NVzMYKoUa94SdkUg4aDGp5/B3Gg==
X-Gm-Gg: AYBFou2C1Tp4mfN7oecUTt8a4KDutVpb0UsiBk3H21T8uKKzgwgODs+nJKQP9ONFLLl
 C47n+Xn0yV7ecjvVbg1BRa7gXS2qp0gP99XGZqN0chD1TnBIftMc83+bSOL3ruGyL31iCzmlB5L
 mThpdXiC8qt+vz2vHHb0m83eGvPuQ5cHyYvvCGK2ir8MxSG3ekhSqJXUulXDR0hsFswwUrAK/pA
 hDXvdfqsX2Yk+6YmIGsckm07zq5XjTu52ay5SojdG5X2P+soVFyEuFkUjVaCwSx13pEDI7w4+Qu
 eedQ10xFRwj7Rodam9jWlB8agaBSoMIfQb9hqOr2Lq3WKLhOWmFq3FYFqpPfagPVBeV7mP3F3Op
 OIVNMgoAjUZdNjULpCfn5dUA0IuXlXt0ZYODtRv90VEJPWyU07b/nzpq8MsWNmbO8ZXUmbDkOsW
 mD5L93qjsJzJ491nMC0WDt
X-Received: by 2002:a05:7022:43a0:b0:182:9071:3249 with SMTP id
 a92af1059eb24-19936b55bbfmr18002607c88.30.1793071850561; 
 Mon, 26 Oct 2026 20:30:50 -0700 (PDT)
X-Received: by 2002:a05:7022:43a0:b0:182:9071:3249 with SMTP id
 a92af1059eb24-19936b55bbfmr18002563c88.30.1793071849984; 
 Mon, 26 Oct 2026 20:30:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 37/41] target/hexagon: reset implicit USR write state
Date: Mon, 26 Oct 2026 20:29:23 -0700
Message-Id: <20261027032927.3055166-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXzfQsOUWZ+kLK
 BxZpyLkzStOqJ7IJ90w7i1pqD5d7aJ+jDTVAyVi2w8C/KTH+Z9RteyZM/ALxVAvilt4DBJi9D4f
 iQFGYMJALkKKru0KBPyMmFIu5xWMWJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXy2VOY61k3I5B
 zfZTwR93/VRUagCR+6+a1TmfPZm7y49ArARfnyBn7EgJhBix+j9axTzEcbkXKIn3xpecyNYbVH2
 b7Z/gGoVa6sK7FMp1xyyZQ2tJfFnGA2//88/DogmMZJ7PJ4dDxeip7tn5iSMWAvL4HBJQ0CxPia
 18mxYGwDw7KIzGGKOOK8jmvET3+WnKN8zTFR+MkKf7f7JDE6ZPJKgMZdQbn866LiCsNKm2jDB1n
 MPZATsz5hIlKnBNH95hjMVbw5YeRk02nf5RvwJtp0DOIgx7gJas+McpcEfEgVSZQ2F8R4EXTXKf
 fBp/rHgmGxw+0JNr4expLUiIYRKeXBT/GSA/iTXhrdZvLMtvnNdAMOEJk6Dx+vmcjTOZqQsrMrt
 jSbGS1Mb3pWw3CbXcRIBNYIvm6zxkc0vXEDCEuMA2tq7siP20vaEhAtE7gHrJJEaME4HOb716sS
 gByRdy2TIZGSfVtNGJg==
X-Proofpoint-ORIG-GUID: aEgmucgwD6wmyZFhPJEKMvu-oCvmSyNT
X-Proofpoint-GUID: aEgmucgwD6wmyZFhPJEKMvu-oCvmSyNT
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae01aeb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aW1wbGljaXRfdXNyX3dyaXRlIGlzIHBlci1wYWNrZXQgREMgc3RhdGUuIEl0IHdhcyBub3QgY2xl
YXJlZCBiZWZvcmUKYW5hbHl6aW5nIHRoZSBuZXh0IHBhY2tldC4gUmVzZXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgb3RoZXIgcGVyLXBhY2tldApzdGF0ZS4KCldoZW4gcnVubmluZyBxZmxvYXRfdjgx
IHVic2FuIHJlcG9ydGVkOgoKICAgIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jOjcyNTozMjog
cnVudGltZSBlcnJvcjogbG9hZCBvZiB2YWx1ZSAxOTIsCiAgICB3aGljaCBpcyBub3QgYSB2YWxp
ZCB2YWx1ZSBmb3IgdHlwZSAnX0Jvb2wnCiAgICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYzo4
NzQ6MTI6IHJ1bnRpbWUgZXJyb3I6IGxvYWQgb2YgdmFsdWUgMTkyLAogICAgd2hpY2ggaXMgbm90
IGEgdmFsaWQgdmFsdWUgZm9yIHR5cGUgJ19Cb29sJwoKRml4ZXM6IDNlOTg0OTY2OTFlZCAoIkhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbXBsaWNpdCB3cml0ZXMgdG8gVVNSIGRvbid0IGZvcmNl
IHBhY2tldCBjb21taXQiKQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXgg
YWMwOGViOTFiOTYuLjA2YTNlZDU2OTYxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNjQ5LDYgKzY0OSw3
IEBAIHN0YXRpYyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4
LT5yZWdfbG9nX2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRP
VEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3Jl
Z3MsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUg
PSBmYWxzZTsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0t
IAoyLjM0LjEKCg==

