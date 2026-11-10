Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6D606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GLVglJzD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gnXlwexI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbvS-0006PB-5x; Mon, 09 Nov 2026 21:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvI-0006Ky-V2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvG-0004Cw-Py
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:24 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0j5CJ2481995
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yT8//N0GY+gttz42XYGIjhvStSZfx8rCAyqLX7JU1/c=; b=GLVglJzD1oof2ui6
 wOE653T8YnIKA4exEBCvNPc6oCvUXKYabVhLb/T99kDLKvQ+3CgZ4yd/+NSxW71f
 g+7y9Xk2aOUN9o7qXptbfKN0Qp4CqbqPfeX7q7x5/hut019+fQA0xcDemQVUwrzW
 TMuS1xLTpnA0aguUrWicKRFZ7InSp+pUeAKIP9+ELEpeQsIxcZrtlifP7miLlsRa
 Xnq1lzU7mZYPalayYLs62h05MdJQFxcMeM+arLUSlTQG1w2c6+ia0NrD5oODrfqF
 k7/TPhYMaM0p5M80dWamIM0biG1sVfzKSwY7wxRp1J0csZsqafY80LOvnYk0DZ3z
 jbDwQg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx82j9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36d1353fdcdso948270eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794278960; x=1794883760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yT8//N0GY+gttz42XYGIjhvStSZfx8rCAyqLX7JU1/c=;
 b=gnXlwexIUeG9/yw9AC8JVIyYEZ4flTgIiiU4OL0C39DPGsl/djdAGEMv5HkBbh9ueZ
 hMLMlxXCSLWPDMtG7rZ0/4xn26XSUD1sR4BqcKLeVLOGnI25mM1/CVi25ysuWXKJd8Zp
 kDpQoimrfgmnUWwzYMwybJ8HuFLBz2Csn5bvYn6sjqSB0RnuqG5bRrmSBD8OnfOpjgaX
 VWr5PQwxORfVlRFNcQk8tSb47TH07sJaI8U0uD41Uuq1UVpDajWkyMdDb0QxEqL1IKVN
 JfkOBfXnlgHLGZd2y8C5grhMkGNX9WGH4Xv8pGauiadJWafqsVN8x5BF8KMfSEYJJPxt
 m8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278960; x=1794883760;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yT8//N0GY+gttz42XYGIjhvStSZfx8rCAyqLX7JU1/c=;
 b=W3lTQDfeEfCTK1O8hkYCUb4/kjJslfM+XSjoOVo6xjwUXWFJHoQakKPDzwGXCkXlel
 uI0EFIv6VX9K333oZzQLeaQuZCb10xpPeutBg2DOiETj9NQvXnqGnzXqTd2Y9K1h20E0
 8xgYTjqu4RCQYZQ9LQfMPmmZpeXtFF7uP9PUa1Pbn/ygBpe5FlNzlOvsXMKNIAZWUppx
 /mjqT62Y1vZFN0tZdtIdYbBfUdPTm3yEQ0I8e+Za9e5REpQg3S04kogKmv6/ogmr//Gl
 NneJwruNtP2hKFtX+L4s0L4qKH0ZKMFBvwJZoGa0NJ3RP7KyDhlg4IW8Nrmz1CX2yCdJ
 5xgw==
X-Gm-Message-State: APuU4Z+/HLZYPGu8uPEdLtXOy+UEHHEhok/jubS+ljWgLFfs5d6PlrsB
 HL+4eWcdLdETjDlyuEFBItimOBauXDdPXWnmVfxJ0GEB3uUjYHADwGFSppDeBbXzJbUDqoFxQY6
 9e8+i4W5HbzLTn4Du+a7O7tSGMwchsIo6Eo9IQ+sw4CBrhARIfB5RqWQO+lhyZdNrgg==
X-Gm-Gg: AYBFou12IQX3/Y33PFNrxMNAmp/0KThIX2+uvHm5Ry+Mchf4Uj7p5HWVnR6hzoH1Pz2
 vJSuH79HoPikW+0+gTXKgjpSsdmlYW8lEcQx+w34a4uESscmfnpddanbXOAvtyuvQs6URTBf3co
 CvkgntFlttNAC5UhGxt0/dSAx4LWRCy3ROrZrLlXoC7sqjqQ7FFtNiZ9rLXH0xjDMOWFkcYXUaR
 hZibXzWl0byNmsNJMAuQiGnIlq23Py8BPVr7Ctv4K5uUAWZ96ZBf4SMXi2UrWqAqKQ3DJZzV623
 ApjQ5R6296d8+xa3iGTtQv78KoXp/0tmg1cmbVJ6pCnH7F5Ztc5mMdWu/hQ9tCqDcmK/IywOCMx
 UDFYIrvH9tha8bS33JeNWEbNxEke7LW6SszPMGxz74vEaJyq7X1XKdN7K9ZPGm6EbyW05WqHEWH
 0IbMrBtWjuR/gSys3t2iBX
X-Received: by 2002:a05:693c:62ce:b0:372:eab:d700 with SMTP id
 5a478bee46e88-3751c34712dmr1661154eec.1.1794278960191; 
 Mon, 09 Nov 2026 18:49:20 -0800 (PST)
X-Received: by 2002:a05:693c:62ce:b0:372:eab:d700 with SMTP id
 5a478bee46e88-3751c34712dmr1661120eec.1.1794278959548; 
 Mon, 09 Nov 2026 18:49:19 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm2700263eec.25.2026.11.09.18.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:49:18 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/11] docs/system/hexagon: describe machine models and memory
 maps
Date: Mon,  9 Nov 2026 18:48:54 -0800
Message-Id: <20261110024901.1610588-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
References: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af28631 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=XEA1TDPqdI0cZNt5_OoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: LLMxZy3S4esqFzx1ZqX-Kz5fB76CSgfi
X-Proofpoint-ORIG-GUID: LLMxZy3S4esqFzx1ZqX-Kz5fB76CSgfi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfXywpJXq6GCIQ2
 KjRSTWwkgUfJgWuwoIaiXlmWRRgf4SfDwGWYOsaE0ILb7uukpvHfGtEtPCzg0wMcRqPW6Cad7jY
 T8xXN6K7+9VvrP593i0Aeav1NjyUEM4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX6rysIk9Fxiyi
 8Zo033m3ewm8GylZicF31N17AKNf+K+Ax64aKawWPv1AinKi2tdpW734Eb3Xxe66ornZlhUwkV4
 Hf6+QBkf60dryLaeJ2d1Aqwhe95O7cW8wddeQiMppD8d55SNuPsS0mjWHHMAYoo70oKqa1Iibjd
 j1nBEVgrlSWcyGLz/MeVIHTxPar44Aflm6Gl4BzOG1Qj7XG1Dh60p4P7y8DmRVdcwM8Fa/CqpLf
 SQzKgX+kYCTip2QxiniNBDS5oXFGDqI1y7whbPO510PNdicG7wcclpBYHkX30xgFfzzNmRQE0Ya
 aB3PfeKI0Wjr8DTLifX4xhCTZUtGTjZGeFi+waq23/cYPHwA6CgMgqVNa+tC+phFX0PI0ANnk7T
 9j3VX5idFkDKfm9JaA2s/KUyIasGLYi9UDoGWyrF48i1FOYaV63wbWhcmVo37WwAtZ25ODBCYFa
 FvhuECIyZG+Oij9EcUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100010
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5yc3QgICAgIHwgNDEgKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vbWFjaGluZXMu
cnN0IHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL3Rhcmdl
dC1oZXhhZ29uLnJzdCAgIHwgIDUgKystLQogMyBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25z
KCspLCAyNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5c3RlbS9oZXhh
Z29uL21hY2hpbmVzLnJzdAoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5y
c3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2Nkc3AucnN0CmluZGV4IDhkM2ExZjYxMWIwLi4zNTU2
ZDhhOGFhMCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9jZHNwLnJzdAorKysgYi9k
b2NzL3N5c3RlbS9oZXhhZ29uL2Nkc3AucnN0CkBAIC0xLDIxICsxLDEyIEBACiAuLiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogCi1Db21wdXRlIERTUAotPT09PT09
PT09PT0KK0JvYXJkLXNwZWNpZmljIGJvb3QgZmlybXdhcmUKKz09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KIAotQSBIZXhhZ29uIENEU1AgaXMgZGVzaWduZWQgYXMgYSBjb21wdXRhdGlvbiBv
ZmZsb2FkIGRldmljZSBmb3IgYW4gU29DLiAgVGhlCi1gYFY2NkdfMTAyNGBgIG1hY2hpbmUgY29u
dGFpbnM6Ci0KLSogTDJWSUMgaW50ZXJydXB0IGNvbnRyb2xsZXIKLSogUVRpbWVyIHRpbWVyIGRl
dmljZQotCi1UaGlzIG1hY2hpbmUgd2lsbCBzdXBwb3J0IGFueSBIZXhhZ29uIENQVSwgYnV0IHdp
bGwgZGVmYXVsdCB0byBgYHY2NmBgLgotCi1IMiBib290IGZpcm13YXJlCi0tLS0tLS0tLS0tLS0t
LS0tCi0KLVRoZXNlIG1hY2hpbmVzIGNhbiBiZSBzdGFydGVkIHRocm91Z2ggdGhlIEgyIGh5cGVy
dmlzb3IgaW1hZ2VzIHNoaXBwZWQgaW4KLWBgcGMtYmlvc2BgLCBzZWxlY3RlZCB3aXRoIGBgLWJp
b3NgYDoKK1RoZSBDRFNQL05TUCBtYWNoaW5lcyBjYW4gdXNlIHRoZSBob3N0IGZpcm13YXJlIHNo
aXBwZWQgaW4gYGBwYy1iaW9zYGAsCitzZWxlY3RlZCB3aXRoIGBgLWJpb3NgYC4gVGhlc2UgaW1h
Z2VzIGNvbnRhaW4gSDIgYW5kIGVpdGhlciB0aGUgYGBib290ZXJgYAorb3IgYGBsb2FkbGludXhg
YCBsb2FkZXIuIFVzZSBgYC1MYGAgdG8gc3BlY2lmeSBRRU1VJ3MgZmlybXdhcmUgZGlyZWN0b3J5
Cit3aGVuIHJ1bm5pbmcgYW4gdW5pbnN0YWxsZWQgYnVpbGQuCiAKIC4uIGxpc3QtdGFibGU6Ogog
ICAgOmhlYWRlci1yb3dzOiAxCkBAIC00NSwxNiArMzYsMjIgQEAgVGhlc2UgbWFjaGluZXMgY2Fu
IGJlIHN0YXJ0ZWQgdGhyb3VnaCB0aGUgSDIgaHlwZXJ2aXNvciBpbWFnZXMgc2hpcHBlZCBpbgog
ICAgICAtIGBgMHhhMDAwMDAwMGBgCiAgICAgIC0gYGBzYTg3OTdwX25zcDBgYAogCitgYGhleGFn
b25fbG9hZGxpbnV4XzxzdWZmaXg+YGAKKyAgQm9vdHMgYSBndWVzdCBvcGVyYXRpbmcgc3lzdGVt
IHdyaXR0ZW4gZm9yIHRoZSBIZXhhZ29uIFZNIGludGVyZmFjZS4KKyAgRGVzcGl0ZSB0aGUgbmFt
ZSwgaXQgaXMgbm90IHNwZWNpZmljIHRvIExpbnV4LiBIMiBzdGFydHMgdGhlIGd1ZXN0IGZyb20K
KyAgYW4gaW1hZ2UgdGhhdCBRRU1VIGhhcyBwbGFjZWQgYXQgdGhlIGBgLWtlcm5lbGBgIGFkZHJl
c3MgaW4gdGhlIHRhYmxlCisgIGFib3ZlLgorCiBgYGhleGFnb25fYm9vdGVyXzxzdWZmaXg+YGAK
LSAgSDIgcGx1cyBhIGxvYWRlciB0aGF0IHJlYWRzIGd1ZXN0IEVMRiBmaWxlcyBmcm9tIHRoZSBo
b3N0IHRocm91Z2ggUUVNVQotICBzZW1paG9zdGluZzo6CisgIFJ1bnMgSDIgdXNlciBwcm9ncmFt
cy4gIFRoZSBib290ZXIgY3JlYXRlcyBhIFZNLCBsb2FkcyBhIHByb2dyYW0KKyAgdGhhdCBpdCBy
ZWFkcyBmcm9tIHRoZSBob3N0IHRocm91Z2ggc2VtaWhvc3RpbmcsIGFuZCB3YWl0cyBmb3IgdGhl
CisgIHByb2dyYW0gdG8gZXhpdDo6CiAKICAgICBxZW11LXN5c3RlbS1oZXhhZ29uIC1NIHFjczY0
OTAtY2RzcCAtc2VyaWFsIHN0ZGlvIC1kaXNwbGF5IG5vbmUgXAogICAgICAgICAtYmlvcyBoZXhh
Z29uX2Jvb3Rlcl9xY3M2NDkwX2Nkc3AgXAotICAgICAgICAtc2VtaWhvc3RpbmctY29uZmlnIGVu
YWJsZT1vbix0YXJnZXQ9bmF0aXZlLGFyZz1ib290ZXIsYXJnPWd1ZXN0LmVsZgorICAgICAgICAt
c2VtaWhvc3RpbmctY29uZmlnIGVuYWJsZT1vbix0YXJnZXQ9bmF0aXZlLGFyZz1ib290ZXIsYXJn
PXByb2cuZWxmCiAKLSAgR3Vlc3RzIGFyZSBsb2FkZWQgYXQgYGAweGEyMDAwMDAwYGAuCisgIFBy
b2dyYW1zIGFyZSBsb2FkZWQgYXQgYGAweGEyMDAwMDAwYGAgYnkgZGVmYXVsdDsgdGhlIGJvb3Rl
cidzCisgIGBgLS1ndWVzdF9iYXNlYGAgb3B0aW9uIGNoYW5nZXMgdGhpcyAoYGBhcmc9LS1oZWxw
YGAgbGlzdHMgaXRzIG9wdGlvbnMpLgogCi1gYGhleGFnb25fbG9hZGxpbnV4XzxzdWZmaXg+YGAK
LSAgSDIgcGx1cyBhIGxvYWRlciB0aGF0IHN0YXJ0cyBhIGtlcm5lbCB3aGljaCBRRU1VIGhhcyBw
bGFjZWQgYXQgdGhlCi0gIGBgLWtlcm5lbGBgIGFkZHJlc3MgaW4gdGhlIHRhYmxlIGFib3ZlLgor
ICBGb3IgbW9yZSBpbmZvLCBzZWUgPGh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9oZXhhZ29u
LWh5cGVydmlzb3I+LgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5y
c3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL21hY2hpbmVzLnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMC4uYTQ3NjBiN2E1YjEKLS0tIC9kZXYvbnVsbAorKysgYi9kb2Nz
L3N5c3RlbS9oZXhhZ29uL21hY2hpbmVzLnJzdApAQCAtMCwwICsxLDM4IEBACisuLiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitIZXhhZ29uIG1hY2hpbmVzCis9
PT09PT09PT09PT09PT09CisKK0Nob29zZSBhIG1hY2hpbmUgdGhhdCBtYXRjaGVzIHRoZSBydW50
aW1lIGVudmlyb25tZW50IGZvciB0aGUgcHJvZ3JhbSBhbmQKK3RoZSBIZXhhZ29uIElTQSBpdCB0
YXJnZXRzLiBIZXhhZ29uIG1hY2hpbmVzIGZhbGwgaW50byB0d28gYnJvYWQgY2F0ZWdvcmllczoK
K3NpbXVsYXRvci1jb21wYXRpYmxlIG1hY2hpbmVzIGFuZCBib2FyZC1zcGVjaWZpYyBEU1Agc3Vi
c3lzdGVtIG1hY2hpbmVzLgorCitTaW11bGF0b3ItY29tcGF0aWJsZSBtYWNoaW5lcworLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KKworU2ltdWxhdG9yLWNvbXBhdGlibGUgbWFjaGluZXMg
c3VwcG9ydCBzdGFuZGFsb25lIFNESyBPUyBhbmQgUXVSVCBwcm9ncmFtcworaW50ZW5kZWQgZm9y
IHRoZSBIZXhhZ29uIHNpbXVsYXRvciBlbnZpcm9ubWVudC4gVGhleSBwcm92aWRlIHRoZSBjb21t
b24KK0hleGFnb24gc3lzdGVtIGZhY2lsaXRpZXMgZXhwZWN0ZWQgYnkgdGhvc2UgcHJvZ3JhbXMs
IGluY2x1ZGluZyBpbnRlcnJ1cHQKK2FuZCB0aW1lciBzZXJ2aWNlcywgbG9jYWwgbWVtb3J5LCBz
ZW1paG9zdGluZywgYW5kIGEgY29uZmlndXJhdGlvbiB0YWJsZQordGhhdCBkZXNjcmliZXMgdGhl
IHNlbGVjdGVkIG1vZGVsJ3MgY2FwYWJpbGl0aWVzLgorCitTZWxlY3QgdGhlIG1vZGVsIHRoYXQg
bWF0Y2hlcyB0aGUgcHJvZ3JhbSdzIHRhcmdldCBJU0EgYW5kIHRocmVhZGluZworcmVxdWlyZW1l
bnRzLiBgYFY2NkdfMTAyNGBgIGlzIHRoZSBkZWZhdWx0IHdoZW4gYGAtTWBgIGlzIG9taXR0ZWQ7
IGBgc2ltYGAKK3NlbGVjdHMgdGhlIG1vc3QgbW9kZXJuIHNpbXVsYXRvci1zdHlsZSBtYWNoaW5l
LgorCitUaGUgdmlydHVhbCBtYWNoaW5lIChgYHZpcnRgYCkKKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQorCitgYHZpcnRgYCBpcyBhIHN5bnRoZXRpYyBzaW11bGF0b3ItY29tcGF0aWJs
ZSBib2FyZCBmb3Igb3BlcmF0aW5nIHN5c3RlbXMgYW5kCitiYXJlLW1ldGFsIHByb2dyYW1zLiBR
RU1VIHN1cHBsaWVzIGEgZGV2aWNlIHRyZWUgdGhhdCBkZXNjcmliZXMgdGhlIHZpcnR1YWwKK2hh
cmR3YXJlIGF2YWlsYWJsZSB0byB0aGUgZ3Vlc3QsIGluY2x1ZGluZyBDUFVzLCBpbnRlcnJ1cHQg
Y29udHJvbGxlciwKK2NvbnNvbGUsIHZpcnRpbyBkZXZpY2VzLCBhbmQgYWNjZWxlcmF0b3IgY2Fw
YWJpbGl0aWVzLiBTZWUgOmRvYzpgYm9vdGAgZm9yCitpdHMgYm9vdCBwcm90b2NvbC4KKworQm9h
cmQtc3BlY2lmaWMgQ0RTUCBhbmQgTlNQIG1hY2hpbmVzCistLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KKworQm9hcmQtc3BlY2lmaWMgQ0RTUCBhbmQgTlNQIG1hY2hpbmVzIG1v
ZGVsIHRoZSBEU1Agc3Vic3lzdGVtIG9mIGEgbmFtZWQKK1NvQy4KKworRmlybXdhcmUgY2hvaWNl
cyBhcmUgbGlzdGVkIGluIDpkb2M6YGNkc3BgLgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vdGFy
Z2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4IDVk
NDhjZjQwMWFkLi41YTY0NmZkMGQwNCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdApAQCAtMjEsOCAr
MjEsOCBAQCByZXNldCBhbmQgdGhlIGZpcnN0IGluc3RydWN0aW9ucyBhcmUgZmV0Y2hlZCBmcm9t
IEREUiB2aWEgdGhlIEVWQi9yZXNldCB2ZWN0b3IuCiBJbiBhIHJlYWwgc3lzdGVtLCBhIFRCVS9T
TU1VIHdvdWxkIG5vcm1hbGx5IGFyYml0cmF0ZSBBWEkgYWNjZXNzZXMgYnV0CiB3ZSBkb24ndCBo
YXZlIGEgbmVlZCB0byBtb2RlbCB0aGF0IGZvciBRRU1VLgogCi1IZXhhZ29uIERTUCBjb3JlcyB1
c2Ugc2ltdWx0YW5lb3VzIG11bHRpdGhyZWFkaW5nIChTTVQpIHdpdGggYXMgbWFueSBhcyA4Ci1o
YXJkd2FyZSB0aHJlYWRzLgorSGV4YWdvbiBEU1AgY29yZXMgdXNlIHNpbXVsdGFuZW91cyBtdWx0
aXRocmVhZGluZyAoU01UKS4gVGhlIG51bWJlciBvZgoraGFyZHdhcmUgdGhyZWFkcyBkZXBlbmRz
IG9uIHRoZSBtYWNoaW5lLgogCiAuLiBhZG1vbml0aW9uOjogRGlhZ3JhbQogCkBAIC0xMDAsNiAr
MTAwLDcgQEAgbWFjaGluZXMuIFRoaXMgY2FuIGJlIGZ1cnRoZXIgY29uZmlndXJlZCB0aHJvdWdo
IGBgLXNlbWlob3N0aW5nLWNvbmZpZ2BgLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09
PT09PQogLi4gdG9jdHJlZTo6CisgICBoZXhhZ29uL21hY2hpbmVzCiAgICBoZXhhZ29uL2VtdWxh
dGlvbgogICAgaGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

