Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AEECA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGE4-0007Lz-G8; Fri, 09 Oct 2026 15:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE0-0007LH-2z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGDy-0007c5-5b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HaTpS2969805
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4O9C4nhhOuXR6FeiZRD6Wo
 UWAZWpnBdnziVpFykTjyE=; b=cwkMPcIMDskCO89YojIIcIkMuPjHkXSi3t/8kh
 a80kN5w5nZJ8gDlPbxTlKSlIT7sK4yKv+yzIURRHHX44/L9X2MPmq7kXLkOq2a2E
 frKQibpHcPL9qyXILEHWhCB69+msIKlOvLJF/8g64IbYJbXAqOYu4/BGg8simeMh
 tS09nGwLE4qjp3ELkasl0CSC8iW9vK7kaX2c9p9tvuT7AmIpt7Ys3EtiluFBRbWJ
 FGJqEFROVJjhX/WHaRj0fzWn2AU+JJ6nVkiymheCtzI71DsUf0aWfBsPjGfbGAsQ
 /Nz8N8m3SP9SH7YhZAmO8fQOhT0AwYz0mzAXtbBq986+NngQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8gegf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so97164eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573943; x=1792178743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4O9C4nhhOuXR6FeiZRD6WoUWAZWpnBdnziVpFykTjyE=;
 b=NNPGcLcS/sFcvvN86jLcWpNef/D2snADwq+Y8BLz2VrkDjFmRIUakpTa0zjZfHywHf
 ULpcFNlCLdyYAH2cQ0NfMHSAHX2YIiSHN4pXV2CWfB8qA/obr6UiO7nGk0axa9ombb7n
 0PzErnOlN0OofZjuk4A4vEbg8GfgsNqbiYO+92BPbhvfkYt67E6DJESE0L5SS589SMdB
 BsKDhXBD7T8hxXAi9tZx2daLCxkNT4Dr2Nw9LYDU3zxd3gvjMI2YhpvrO/uwHUmesuyI
 rz+zQiDlyrDkbZmoQ16c+NUMbByrI8uvHmsXHihYy7Kxr4ugqOEdCUJbP1DKj4iHdNT8
 JFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573943; x=1792178743;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4O9C4nhhOuXR6FeiZRD6WoUWAZWpnBdnziVpFykTjyE=;
 b=0NoZCz/J9BmRenQUYWOV2UnX31HFKiOkiFO5xTHj7CIIioOQM8XCX8pxUS8+ELU+WG
 B0sIOfUAmxixdxJ2H39YpMWSEoNhPisFEmmSgCSpi5hiJVFDF8VInivz2J1rFFXr0IAa
 qJvVUEtxvDx1lmxFbgqpZ+i0csuUaBibVNa2tZZajfeXD5Qj/f6TS/FWyD+azZuEYLsf
 cBMTEKbdsGftnDAIc4v97CXg1KxuCGKRiM5amOMS59K4Y4e27VozjIecL40qiOTGnd9z
 JlyM+5RsNu/zvbKZs+t92nnR1Lu2WglS8Hak5g+BLyDN3mAeahRuHH1ZbOu5J8wuxB8t
 y1lQ==
X-Gm-Message-State: AFuF++nwGf5iEfeluBAttxMrmzGH2SzgFiwMJt6++I+8I43bb4309ogA
 fXs57mSvAAWl00juRvSqXjOaQxXRkfRZjV4I2zwykLoWDXpKSGEXERvAuX4FDu/eFQqr4H0kY+W
 SAjiVgIVyPPeNW5gba3+RMEx4Q/o//60aXSQ1m44hkDqDAX+GnGjrfR/xm8pbtR7bkg==
X-Gm-Gg: AYBFou2M8NajQvKRs/Tt+ibbk24cOj7fHLMkfalno3FS5ZZHGU379CjSA763MV/X9AM
 fJ76KEatRGP3wdI4E72LBTfm45UTElWLWbJg5iP3LKiu/CTCeX5lnbSKIqXRcA/3nxo+5oyUZxG
 Uv/cnmDKnxRRLtb5tUU2OUyUprb2rt5ACIrE2uhJ4gf74LpK6V99H58iXyAdMWBN+zq5wG4HzQz
 uwnJPR1MZ4pRqcDggPeZ7kvMavNVyBmRPpslJJWwyMp1Dea301r1iAG/auxpaEWRKfdHTUWVymZ
 ouf0CCL9b22JeW6oJCieLpUzbV0bF2bJoKqJSMliXnUtzlWepa5YEvCzgMtSqU/QrXzTlRO/oBc
 ukS759q2JSniI8MyJy6Z/8jDeEVIpEtmzpp8YzHQqvSzzWls=
X-Received: by 2002:a05:693c:42d6:b0:351:232c:6d79 with SMTP id
 5a478bee46e88-3537df8cd55mr4708788eec.12.1791573943080; 
 Fri, 09 Oct 2026 12:25:43 -0700 (PDT)
X-Received: by 2002:a05:693c:42d6:b0:351:232c:6d79 with SMTP id
 5a478bee46e88-3537df8cd55mr4708735eec.12.1791573942402; 
 Fri, 09 Oct 2026 12:25:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/6] Hexagon: fix lock, priv bugs
Date: Fri,  9 Oct 2026 12:25:34 -0700
Message-Id: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX5udAKqoq/3yJ
 2LAyDoaqzA04WgARqtRmGl9RnTM35OLxzjepSyfchxVi0gaPuePaU0+mId+MUBt1Jx28f/LDxYl
 tpDNvrTf2D/1uPAZ3Ktl4ixOayYZwLA=
X-Proofpoint-GUID: yLX2klbW_G3Gxf21ZZuaSk0guR7MbP0T
X-Proofpoint-ORIG-GUID: yLX2klbW_G3Gxf21ZZuaSk0guR7MbP0T
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac93fb8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vnDRBMZamB5ZYofm1CEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfXykVCVs56LOKP
 icBv6s027ldeyFWj6+2oYZBDGh+a6mig3DTnQ2gcbgxlgjGnqEFs51KqVj6PR6JDOlgmIff3sGJ
 AGX5JA3YjpHFBAYTNBmLVj70EIpUQ8VOOhQvHqneJfS7vK3D9ZvJ5CnFT21QZCIMHhVpnxlAiCQ
 4sKiYamizUJ3qyEra8KIGCXZs+Ea8qRXE7nFMvUTDX2MaVs9+1Rwa+3mNuf1wEe1ysdK0P9yxEy
 ykRQGLBfZlDRx10irzjoIpTjWIfuaDMGMx/VtPLh6vZYukabt9ErdfyjJXI+2MKpafQkkyX0LsA
 6t1OYlQ85focdn1rgv/FoPAsQxfDm39sYR2yvRGIZP10R551vaWU/yjOK6ZW7QrsLXwBHn6q6Z1
 T95Z3OPeW/Xbz/WtrQQo5jCJu1GDo1ZYsz6oPeEH4RzvdKoCTCadCUath5GZgN+RdQcIP/f9GY1
 BkceuwS5K8J/N2OGGcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090077
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGVzdGluZyB3aXRoIGgyIGFuZCBsaW51eCBoYXMgdW5jb3ZlcmVkIHNvbWUgYnVncyBpbiB0aGUg
d2F5IHRoZSBsb2NrcyBhcmUKaW1wbGVtZW50ZWQgYW5kIHByaXZpbGVnZWQgaW5zdHJ1Y3Rpb25z
LgoKTm90ZSB0aGF0IHRoaXMgd2lsbCBiZSByZWJhc2VkIHRvIG1ha2UgYWRqdXN0bWVudHMgd2hl
biB0aGUgKm5leHRfcGMgcmVtb3ZhbHMKbGFuZC4gIFNlZSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjYxMDA4MjExMDA1LjE4NTM1NDItMS1icmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20vCgpCcmlhbiBDYWluICg2KToKICB0YXJnZXQvaGV4YWdvbjogY2hlY2sgcHJpdmls
ZWdlIG1vZGUgZm9yIHN5c3RlbSBpbnN0cnVjdGlvbnMKICB0YXJnZXQvaGV4YWdvbjogd2FrZSBL
MCBhbmQgVExCIGxvY2sgd2FpdGVycwogIHRhcmdldC9oZXhhZ29uOiBmaXggc3RhbGUgUEMgb24g
azBsb2NrIHdhaXQgcmVzdW1lCiAgdGFyZ2V0L2hleGFnb246IGhhbHQgb24gdGxibG9jayB3aGVu
IHRoZSBUTEIgbG9jayBpcyBjb250ZW5kZWQKICB0YXJnZXQvaGV4YWdvbjogc2V0IGEgc3RhcnRl
ZCB0aHJlYWQncyBlbmFibGUgYml0IHdoZW4gc3RhcnQgcmV0aXJlcwogIHRlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbjogYWRkIE1pbmlWTSwgbG9jayB0ZXN0cwoKIHRhcmdldC9oZXhhZ29uL2NwdS5o
ICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgg
ICAgICAgICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAg
ICAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgICAgICAgICAgICAg
ICB8ICA2ICsrKysKIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgICAgICAgICAgIHwg
IDggKysrLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICAgICAgICAgICAgICAgIHwgIDcg
KysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgfCAgMyArKwog
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKwog
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAgICAgICAgfCAxNiArKysrKy0tLS0K
IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwgIDEgKwogdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5ICAgfCA0MyArKysrKysrKysrKysrKysr
KysrKysrKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgfCAgMyAr
KwogMTIgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKIGNy
ZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9taW5pdm0ucHkK
Ci0tIAoyLjM0LjEKCg==

