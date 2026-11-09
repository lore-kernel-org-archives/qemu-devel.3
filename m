Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F514606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duxZZc8u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JBGLBVBV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQGuc-0003ls-Cf; Sun, 08 Nov 2026 23:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGuZ-0003kw-Vh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGuX-0008Rn-UJ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:15 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A94B0Vf3382413
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 04:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UsnV40nPJLMnMgucmH6rW1Gml1ueCy6PZprIsQcNcBg=; b=duxZZc8u9n2/BUDc
 APAc6l6+YInInJH52MSUE1ttldEyvi3fe4f6r7Ja/wc60WI/AU+qk4dwaLN7fXvF
 un11IB6sf1u2Aa8CRjm9Mh+04+hZNIONYNd/AfzlrqI2h9Gvof4mAPoHdiEavqy9
 3k1NGdfbwXHc0dFk16eDkVFWHGPZboojV8xY4CcwPkXBwGVD87LSKru/0EiSfJXS
 vDa+NGTnStV5VVk20QXR+oxrX7R6LwUnSfp9ogip/Mv/yVs7mCeQoaIvhd/CZC3H
 Nptul5xjSCZ8b3HPuPcg4NIq09ZuooOuqfKKqGxz3B3LarXjq+n/Cz1bSjAYDT/b
 /Xhhnw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2g0u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 04:23:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so1307456eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794198192; x=1794802992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UsnV40nPJLMnMgucmH6rW1Gml1ueCy6PZprIsQcNcBg=;
 b=JBGLBVBV3Op0pq/thGZ1/gRD0HEtiXX0GBEZ+g0ozRhVtKPBsV8uV0vTamX9gwZCAo
 fUN5XvqVt++9IMimaIZbxwtIXRwCTY+2OaLn08+lJsCONy9ZHWE0Pcr4wKl5H5SIDPfK
 QOwIhNobz/JiGwUIWh/w9JxXC4v6NE3Ozl6qi0B3MA1vUAU+lmjFoNu5mNZcSVUoHj6T
 XB0kUfu5hGeubESi9XnWtorhIPgdMQq6xo0lS9+Avg6hmnvzPiq9Kn2mMVq9UkkHNdQn
 cQuKvirBElEiVL84/pXZek9WScoFr8dJ27d1wpGE+uaxDrieyMuKHu76yqg8yrbPLC+f
 U+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794198192; x=1794802992;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UsnV40nPJLMnMgucmH6rW1Gml1ueCy6PZprIsQcNcBg=;
 b=25AyUAKDeVBJMw+/ucU1mHTsTPHr/N2e4GaaNk1+AqZ6Nx72ofnSu1QvmnlNkccPo1
 y7V9UCgGu3hsPOs9kYxKLyabmJ+HGPoioMhpfh/DoiNux/K4hSCRkCgM1ZDpXar0TJoD
 Dk3eCKM8z+2Smudi133T+8zAjvB13gYdIyvxYdjQNC0t3XfYMrExdDDRele3Fiwec2LM
 udkv2VIhU3kiMs3cA6cwgAyskOymuRv6S9TcWFZN0WSIG7Bx1Yxos6Ag9IoSrOkq5xUE
 hjXkCLGVvzyM1pyD8pWW2lHvb6C4kiwUSr9T3i6MBLVJOhHe1osAbcRHdDV4HY9s3z9z
 8ujA==
X-Gm-Message-State: APuU4Z/Drq+phynG6X3mclmrNEL/8otQIxWieRgt6EO+jgZPvxKbDPpf
 N1efZGhWQL3MMuctR95uHPxUB5vjnoI5FY9Bh2ZnTwA+d/cyO0IbMg24vwity+oHBSkNnYj6aeI
 HjhaY+dv8knVxkRu60rPmbnwhP7eiM+yzCM4DnFXP1l3Np70IXia2L4DJQWMAa2fQtw==
X-Gm-Gg: AYBFou3adJPM+CbAluR0E1lCtUIR/Pe30fqRbr0Zk8yfMeaXU9CNtt1P2OyfioZcLT7
 5aKdU5JNgAuF/Sjb9ZGFHD20ZJu81XdnLfTTo0cUQJ7eKbZEJljgA14F2HQy542Y5fnCvn6DNec
 O9i02jWL86JlNxmqhpx4h1KhqNQw7sy/MHDi1jZuLldMTbm6dpDB0nOUWF57OMltrCwNtk6Sq0x
 1sdAIRp34k4RYcSmMWI7mUbT38ifxIg6g7bhPh+UoWE64iCK/dJ4masTH9BV5+1LES5yBLtfQtk
 CGHTGX8/K9w+CKY43qqMh61512sArQJ7m09EV1z5tnp5dvJMg/CrT4U3VjpKrBos6hyE0eh9zCH
 AEzEPix7Jw9X2Hgqv1wzvQLCMsFLjR8UxHeJctJnO7IQaMemgJHAaHI/+nhEfgD8+Y2ciLSBppL
 uqg2NGUTv0a4wFuEA8PVAVVg==
X-Received: by 2002:a05:7301:628a:b0:33b:c24c:d31c with SMTP id
 5a478bee46e88-37256612cc6mr5456094eec.7.1794198191782; 
 Sun, 08 Nov 2026 20:23:11 -0800 (PST)
X-Received: by 2002:a05:7301:628a:b0:33b:c24c:d31c with SMTP id
 5a478bee46e88-37256612cc6mr5456057eec.7.1794198191088; 
 Sun, 08 Nov 2026 20:23:11 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372669d2826sm10156773eec.29.2026.11.08.20.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 20:23:10 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/5] docs/system/hexagon: update the overview and emulation
 limits
Date: Sun,  8 Nov 2026 20:23:03 -0800
Message-Id: <20261109042307.1301438-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af14ab1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5uMcSSmQ1h4GQFTkCBAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX6nxbO3g2TzXc
 h9x+2XEIbwaxCYWdBd2TxB89dXfiRkr1eKZo3xRxB2VLphky6AGxebOXOEFA0saXCJYQzgrGOfW
 jc2iMxe5Ddax1surMKlOLt7gndat7Ceyhiom+1kGqe3nY+CQwubDHQffLqrGOyQRco7cnRjFhGJ
 XQLKH/17/lqa/iwsIvsE2Wy8G/jaZTbnrKCVGJXREVxwIFufErX60mc17Dkx0vHeY5+9cG3jHt5
 xMWFVvq98CBuqiDP9rCMOcB3Y0Z38LdmdqNGWwO1GygbNOJdpQTJ1mw1+dhT6zGYOboGul+iJFM
 x00hQDBU8pxjFR2g0XBEB3B7gCPMldCeqNzk8H9HWJEnMw2F7sG+Ns/Sy/fbxTmED0eZuPuw8iu
 AHAV1S8t0pb4W730zGhDwzS3EW1lZXmuyvbwJq0jquce4hsNqJlKf+hKiLUABHdjAcljJGZlB7W
 esTJa+Rl3HSYfe82MOQ==
X-Proofpoint-GUID: jbCPoXNIWuafbGZ1DzbhXF6M-5pgerpO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfXw+OVVDPhvjJh
 zjqxo2xVq52sCwvTDa/cJlcG/Jg332emlgxZeDhH3zmGHwuNtpLvxfcy+ofmd8/ST973MU/Wvmn
 B5UFtP+83/6jv/3np9kdrRmWEYl/+w8=
X-Proofpoint-ORIG-GUID: jbCPoXNIWuafbGZ1DzbhXF6M-5pgerpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090017
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

RGVzY3JpYmUgdGhlIGRldmljZXMgdGhhdCB0aGUgbWFjaGluZXMgaW5zdGFudGlhdGUsIEVMRiBi
b290CnBhdGguCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IHwgMTggKysr
KysrKysrKysrKysrCiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgICAgfCAzNyArKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24v
ZW11bGF0aW9uLnJzdCBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdAppbmRleCBm
YjU3Yzc3YWU5MC4uNDFhOWE4NDY3ZjkgMTAwNjQ0Ci0tLSBhL2RvY3Mvc3lzdGVtL2hleGFnb24v
ZW11bGF0aW9uLnJzdAorKysgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKQEAg
LTExLDcgKzExLDI1IEBAIEl0IGFsc28gaGFzIHN1cHBvcnQgZm9yIHRoZSBmb2xsb3dpbmcgYXJj
aGl0ZWN0dXJlIGV4dGVuc2lvbnM6CiAKIC0gSFZYIChIZXhhZ29uIFZlY3RvciBlWHRlbnNpb25z
KQogLSBgSFZYIGZsb2F0aW5nIHBvaW50IDxodHRwczovL2RvY3MucXVhbGNvbW0uY29tL2RvYy84
MC1OMjA0MC02MS90b3BpYy9odngtZmxvYXRpbmctcG9pbnQuaHRtbD5gXy4KKy0gSExYIChzZWUg
dGhlIGBITFggcmVmZXJlbmNlIG1hbnVhbAorICA8aHR0cHM6Ly9kb2NzLnF1YWxjb21tLmNvbS9k
b2MvODAtTjMwNDAtMjMvdG9waWMvaGx4Lmh0bWw+YF8pLgorCitVc2VyLURNQSBhbmQgSE1YIGFy
ZSBub3QgeWV0IGltcGxlbWVudGVkLgorCitNYWNoaW5lIGNvbmZpZ3VyYXRpb25zIGFsc28gc2Vs
ZWN0IHRoZSBhdmFpbGFibGUgSFZYIGNvbnRleHRzLCBWVENNLAorYW5kIEhNWC9ITFggcmVzb3Vy
Y2VzLiBTZWUgOmRvYzpgbWFjaGluZXNgIGZvciB0aGUgbWFjaGluZSBjb25maWd1cmF0aW9ucy4K
IAogRm9yIGluZm9ybWF0aW9uIG9uIHRoZSBzcGVjaWZpY3Mgb2YgdGhlIEhWWCBleHRlbnNpb24s
IHBsZWFzZSByZWZlcgogdG8gdGhlIGBRdWFsY29tbSBIZXhhZ29uIFY3OSBIVlggUHJvZ3JhbW1l
cidzIFJlZmVyZW5jZSBNYW51YWwKIDxodHRwczovL2RvY3MucXVhbGNvbW0uY29tL2RvYy84MC1O
MjA0MC02MS8+YF8uCisKK0VtdWxhdGlvbiBsaW1pdHMKKy0tLS0tLS0tLS0tLS0tLS0KKworVGhl
IHN5c3RlbSBtb2RlbHMgdGFyZ2V0IGZ1bmN0aW9uYWwgZXhlY3V0aW9uLgorCitIVlggdXNlcyAx
MjgtYnl0ZSB2ZWN0b3JzOyA2NC1ieXRlIG1vZGUgaXMgbm90IGltcGxlbWVudGVkLgorCitTZWUg
OmRvYzpgLi4vLi4vZGV2ZWwvaGV4YWdvbi1zeXNgIGFuZAorOmRvYzpgLi4vLi4vZGV2ZWwvaGV4
YWdvbi1sMnZpY2AgZm9yIHN5c3RlbS1yZWdpc3RlciwgVExCLCBhbmQgaW50ZXJydXB0CitkZXRh
aWxzIHJlbGV2YW50IHRvIE9TIGFuZCBmaXJtd2FyZSBhdXRob3JzLgpkaWZmIC0tZ2l0IGEvZG9j
cy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24u
cnN0CmluZGV4IDVhNjQ2ZmQwZDA0Li43YjdkMGJjMzFiYyAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0
ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJz
dApAQCAtOCwxNSArOCwxNyBAQCBIZXhhZ29uIFN5c3RlbSBlbXVsYXRvcgogVXNlIHRoZSBgYHFl
bXUtc3lzdGVtLWhleGFnb25gYCBleGVjdXRhYmxlIHRvIHNpbXVsYXRlIGEgMzItYml0IEhleGFn
b24KIG1hY2hpbmUuCiAKLUhleGFnb24gTWFjaGluZXMKLT09PT09PT09PT09PT09PT0KK0RTUCBz
dWJzeXN0ZW0KKz09PT09PT09PT09PT0KIAogSGV4YWdvbiBEU1BzIGFyZSBzdWl0ZWQgdG8gdmFy
aW91cyBmdW5jdGlvbnMgYW5kIGdlbmVyYWxseSBhcHBlYXIgaW4gYQogIkRTUCBzdWJzeXN0ZW0i
IG9mIGEgbGFyZ2VyIHN5c3RlbS1vbi1jaGlwIChTb0MpLgogCiBIZXhhZ29uIERTUHMgYXJlIG9m
dGVuIGluY2x1ZGVkIGluIGEgc3Vic3lzdGVtIHRoYXQgbG9va3MgbGlrZSB0aGUgZGlhZ3JhbQog
YmVsb3cuICBJbnN0cnVjdGlvbnMgYXJlIGxvYWRlZCBpbnRvIEREUiBiZWZvcmUgdGhlIERTUCBp
cyBicm91Z2h0IG91dCBvZgotcmVzZXQgYW5kIHRoZSBmaXJzdCBpbnN0cnVjdGlvbnMgYXJlIGZl
dGNoZWQgZnJvbSBERFIgdmlhIHRoZSBFVkIvcmVzZXQgdmVjdG9yLgorcmVzZXQgYW5kIHRoZSBm
aXJzdCBpbnN0cnVjdGlvbnMgYXJlIGZldGNoZWQgZnJvbSBERFIgdmlhIHRoZSByZXNldCB2ZWN0
b3IuCitRRU1VJ3MgRUxGIGJvb3QgcGF0aCBpbnN0ZWFkIHN0YXJ0cyBhdCB0aGUgRUxGIGVudHJ5
IHBvaW50OyB0aGUgZ3Vlc3Qgc2V0cwordXAgaXRzIG93biBgYEVWQmBgLgogCiBJbiBhIHJlYWwg
c3lzdGVtLCBhIFRCVS9TTU1VIHdvdWxkIG5vcm1hbGx5IGFyYml0cmF0ZSBBWEkgYWNjZXNzZXMg
YnV0CiB3ZSBkb24ndCBoYXZlIGEgbmVlZCB0byBtb2RlbCB0aGF0IGZvciBRRU1VLgpAQCAtNjAs
MzIgKzYyLDM2IEBAIGhhcmR3YXJlIHRocmVhZHMgZGVwZW5kcyBvbiB0aGUgbWFjaGluZS4KIAog
Q29tcG9uZW50cwogLS0tLS0tLS0tLQotT3RoZXIgdGhhbiBsMnZpYyBhbmQgSFZYLCB0aGUgY29t
cG9uZW50cyBiZWxvdyBhcmUgbm90IGltcGxlbWVudGVkIGluIFFFTVUuCitUaGUgZGV2aWNlcyBp
bnN0YW50aWF0ZWQgZGVwZW5kIG9uIHRoZSBtYWNoaW5lLiBRRU1VIGltcGxlbWVudHMgdGhlCitp
bnRlcnJ1cHQgY29udHJvbGxlciwgdGltZXIsIGNvbmZpZ3VyYXRpb24gdGFibGUsIGFuZCBhY2Nl
bGVyYXRvciBjb250ZXh0czsKK2xvY2FsIFJBTSByZWdpb25zIGFyZSBwcm92aWRlZCB3aGVyZSB0
aGUgbWFjaGluZSBjb25maWd1cmF0aW9uIGNhbGxzIGZvcgordGhlbS4KIAogKiBMMlZJQzogdGhl
IEwyIHZlY3RvcmVkIGludGVycnVwdCBjb250cm9sbGVyLiAgU3VwcG9ydHMgMTAyNCBpbnB1dAog
ICBpbnRlcnJ1cHRzLCBlZGdlLSBvciBsZXZlbC10cmlnZ2VyZWQuICBUaGUgY29yZSBJU0EgaGFz
IHN5c3RlbSByZWdpc3RlcnMKICAgYGBWSURgYCwgYGBWSUQxYGAgd2hpY2ggcmVhZCB0aHJvdWdo
IHRvIHRoZSBMMlZJQyBkZXZpY2UuCi0qIFFUaW1lcjogQVJNU1NFLWJhc2VkIHByb2dyYW1tYWJs
ZSB0aW1lciBkZXZpY2UuIEl0cyBpbnRlcnJ1cHRzIGFyZQorKiBRVGltZXI6IHByb2dyYW1tYWJs
ZSB0aW1lciBkZXZpY2UuIEl0cyBpbnRlcnJ1cHRzIGFyZQogICB3aXJlZCB0byB0aGUgTDJWSUMu
ICBTeXN0ZW0gcmVnaXN0ZXJzIGBgVElNRVJgYCwgYGBVVElNRVJgYCByZWFkCiAgIHRocm91Z2gg
dG8gdGhlIFFUaW1lciBkZXZpY2UuCiAqIFFEU1A2U1M6IERTUCBzdWJzeXN0ZW0gZmVhdHVyZXMs
IGFjY2Vzc2libGUgdG8gdGhlIGVudGlyZSBTb0MsIGluY2x1ZGluZwotICBEU1AgTk1JLCB3YXRj
aGRvZywgcmVzZXQsIGV0Yy4KLSogQ1NSOiBDb25maWd1cmF0aW9uL1N0YXR1cyBSZWdpc3RlcnMu
CisgIERTUCBOTUksIHdhdGNoZG9nLCByZXNldCwgZXRjLiBCb2FyZCBtb2RlbHMgcHJvdmlkZSBz
ZWxlY3RlZCByZWdpc3RlcnMKKyAgZm9yIGZpcm13YXJlIGluaXRpYWxpemF0aW9uLgorKiBDU1I6
IHRoZSBRVGltZXIgY29udHJvbCByZWdpc3RlcnMgYXJlIG1hcHBlZCBhdCB0aGUgbWFjaGluZSdz
IENTUiBiYXNlCisgIGFkZHJlc3M7IHNlZSA6ZG9jOmBoZXhhZ29uL21hY2hpbmVzYC4KICogVENN
OiBEU1AtZXhjbHVzaXZlIHRpZ2h0bHktY291cGxlZCBtZW1vcnkuICBUaGlzIG1lbW9yeSBjYW4g
YmUgdXNlZCBmb3IKICAgRFNQcyB3aGVuIGlzb2xhdGVkIGZyb20gRERSIGFuZCBpbiBzb21lIGJv
b3RzdHJhcHBpbmcgbW9kZXMuCiAqIFZUQ006IERTUC1leGNsdXNpdmUgdmVjdG9yIHRpZ2h0bHkt
Y291cGxlZCBtZW1vcnkuICBUaGlzIG1lbW9yeSBpcyBhY2Nlc3NlZAogICBieSBzb21lIEhWWCBp
bnN0cnVjdGlvbnMuCi0qIEhWWDogdGhlIHZlY3RvciBjb3Byb2Nlc3NvciBzdXBwb3J0cyA2NCBh
bmQgMTI4LWJ5dGUgdmVjdG9yIHJlZ2lzdGVycy4KLSAgNjQtYnl0ZSBtb2RlIGlzIG5vdCBpbXBs
ZW1lbnRlZCBpbiBRRU1VLgorKiBIVlg6IHRoZSB2ZWN0b3IgY29wcm9jZXNzb3IuIFNlZSA6ZG9j
OmBoZXhhZ29uL2VtdWxhdGlvbmAgZm9yIHN1cHBvcnRlZAorICBtb2RlcyBhbmQgaW5zdHJ1Y3Rp
b24gc2V0cy4KIAogCiBCb290c3RyYXBwaW5nCiAtLS0tLS0tLS0tLS0tCi1IZXhhZ29uIHN5c3Rl
bXMgZG8gbm90IGdlbmVyYWxseSBoYXZlIGFjY2VzcyB0byBhIGJsb2NrIGRldmljZS4gIFNvLCBm
b3IKLVFFTVUgdGhlIHR5cGljYWwgdXNlIGNhc2UgaW52b2x2ZXMgbG9hZGluZyBhIGJpbmFyeSBv
ciBFTEYgZmlsZSBpbnRvIG1lbW9yeQotYW5kIGV4ZWN1dGluZyBmcm9tIHRoZSBpbmRpY2F0ZWQg
c3RhcnQgYWRkcmVzczo6CitVc2UgYGAta2VybmVsYGAgdG8gbG9hZCBhbiBFTEYgZmlsZSBpbnRv
IG1lbW9yeSBhbmQgc3RhcnQgZXhlY3V0aW9uIGF0CitpdHMgZW50cnkgcG9pbnQ6OgogCi0gICAg
JCBxZW11LXN5c3RlbS1oZXhhZ29uIC1rZXJuZWwgLi9wcm9nIC1hcHBlbmQgJ2FyZzEgYXJnMicK
KyAgICAkIHFlbXUtc3lzdGVtLWhleGFnb24gLU0gVjY4Tl8xMDI0IC1rZXJuZWwgLi9wcm9nLmVs
ZiAtYXBwZW5kICdhcmcxIGFyZzInCiAKIFNlbWlob3N0aW5nCiAtLS0tLS0tLS0tLQpAQCAtOTcs
MTAgKzEwMyw5IEBAIGd1ZXN0IHNvZnR3YXJlIGNhbiBhY2Nlc3MgdGhlIGhvc3QgY29uc29sZSBh
bmQgZmlsZXN5c3RlbS4gUmVhZCB0aGUKIGZvciBkZXRhaWxzLiBTZW1paG9zdGluZyBpcyBlbmFi
bGVkIGJ5IGRlZmF1bHQgb24gaGV4YWdvbi1zaW0tY29tcGF0aWJsZQogbWFjaGluZXMuIFRoaXMg
Y2FuIGJlIGZ1cnRoZXIgY29uZmlndXJlZCB0aHJvdWdoIGBgLXNlbWlob3N0aW5nLWNvbmZpZ2Bg
LgogCi1IZXhhZ29uIEZlYXR1cmVzCi09PT09PT09PT09PT09PT09CiAuLiB0b2N0cmVlOjoKKyAg
IDpjYXB0aW9uOiBIZXhhZ29uIGRvY3VtZW50YXRpb24KKwogICAgaGV4YWdvbi9tYWNoaW5lcwog
ICAgaGV4YWdvbi9lbXVsYXRpb24KICAgIGhleGFnb24vY2RzcAotCi0tIAoyLjM0LjEKCg==

