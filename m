Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D0606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CPdyJk2w;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bVuIouFs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQGuc-0003lr-Ay; Sun, 08 Nov 2026 23:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGua-0003l3-RI
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGuX-0008Rf-VZ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:16 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A94B8KF3382549
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 04:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dz/CV/mROt6Y8wC6PAwEvXMn4zKJxF55fBN/9sOS2SU=; b=CPdyJk2wG3dbXX5K
 GPFSStkrlW7hilXzBtBDg+BEO0Pa9xNK9xr/PCUK9G2Q+ieoYkdzpXPJ3T5KEdpk
 NnkpFH2mIOy8iOXAKV1kIuBfZka+YBbp6GMP8aZoIBwfFhjo+Qf0yEa28qJ6o+8g
 bTk1nQtZmpIBSAgqmjxfcRpDO8IIV0Q6/QZzM+vjFIdujU4r+BqY1lzPOThwRxST
 jzkwDuFdKOfGntuBQIIhaEGCu4L+XXqoDpb5SGSMuFaiv+UDNnfL8J7UqDH+0K3z
 af21uw0iJi8JZ+ueiDagqe4iNn41heMlNRa2HEGPDPQr+x0NiWPbjMEsaXIVs9EI
 l9SZcw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2g0tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 04:23:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36ecd5db581so99476eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794198190; x=1794802990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dz/CV/mROt6Y8wC6PAwEvXMn4zKJxF55fBN/9sOS2SU=;
 b=bVuIouFskbSN2ILYQuCaR/vc6tSZlBYET6lJnwuWmp5GxyI9haFVBUR8lwjwsIeLdN
 N9aqLBJvxzq5e5QNNUbZaFpEFRoTw7E7fcsePdnunQqwpqoUlVwGyhB0R8odhjGBNljr
 4CtQweIioH3WbTmUpdICprs/9mwjbHQdOORQoiy5WqreEZQmlQ+O9aySHkpH1v7uaUUO
 /xQtff0EpSuTp4iNQmuLMurXXgxgrdh/obgCk2Pl9yWD7uwSDp9hURCF10uqSRsU5Fzm
 dXqZb+0Ai2dOPYp9YOhj9q0bAFys6gnx2xWUvj+xGKJc+5zPmXUohHyVNGrbdEy+4rUy
 c43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794198190; x=1794802990;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dz/CV/mROt6Y8wC6PAwEvXMn4zKJxF55fBN/9sOS2SU=;
 b=owLBSpVoiU3AjXWIUjE+Jm47M7H0yM0+OSFD8eMLgvV87SIY4DmdJsEIeU6RPp/dTA
 X3dUIEJUsEWWxkT5LaTNRoAtQak8YUzViW9JAAo0jFNUDxLKysnc0dhJERmMKAeqE0lx
 g0J1+lm2zm6zFY8g+y4VexlxPnAev6FY8/8XaVXNribdhYYRdVKaSKfxGgY+dXUiSKpm
 u7tgwDOALYe7S97k3WFjEbf/naMYwF3Bx5jgBpa9/RsjcKESLniDuK2lvk1HqSVOC9Y4
 2AtXZD/Qp94srQG/E+SiNJq4O/S9dun9eENW8/QXsnt6fS2sg7phwGkfcaZPk2lCiWYb
 oRLw==
X-Gm-Message-State: APuU4Z9lieBDFsMdXf6q2fHisMIeUZ0nCxzxaEHRmlSKtqwX2IGnWeha
 6rJs2FGXvNtS0+dcbPzMPqfZIanUcPuDI9HwHjNTZ60QCx+M4V7fDQyWSp2Uso4O0bnDTnZp9Pu
 lUSLZPDKoOE0hjVy3JCPvU7dknBuBPX0YlP3KX5ipPumMnNO30G4hxixeHyohN0bdDg==
X-Gm-Gg: AYBFou0qdTHh6nWAKjmcLmNTHdNS6IadZVwAiA4tcxVtY/PBK1SrpxXnBHxczq5oJ9Z
 3w7QJaRiOJeP1Yajah1j6kwRBdV4VE1UcuJokeeeCq39+dH18/NtEDkh5DTpI2JNENAkEKW/oAS
 +85JVur9LxgRe0QHP9HoNvuzU40vulevdQy4zPnu1LN1uQkEsjJH1sC3koC4++iN2dEJuJ9sJKM
 MFh5VcyKjdNE22iGSRTNj3/rYeHN1MCEQPFOBlnAQx7KDdJ3b/6jYa0VDKky0xJ8OEB19ARs6RY
 tD9y8LnkY9zc4foQJp9V8HmfuSTqQS8gX4PN2wpatEA6xjtz6s42NTRUIhDWHO5ED/156JF+93e
 TLOMogxaRQZCpZQB7lPIIHzbcXAQqMKRit0kM2JEWQsivp6wI4qkks/+IRa4UmeRx9AQQhdcl8B
 9iqpN3/52t2oNVeI31Ew30xA==
X-Received: by 2002:a05:7300:ec97:b0:36e:3a0a:2953 with SMTP id
 5a478bee46e88-37256bf38f9mr5564931eec.41.1794198190266; 
 Sun, 08 Nov 2026 20:23:10 -0800 (PST)
X-Received: by 2002:a05:7300:ec97:b0:36e:3a0a:2953 with SMTP id
 5a478bee46e88-37256bf38f9mr5564901eec.41.1794198189666; 
 Sun, 08 Nov 2026 20:23:09 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372669d2826sm10156773eec.29.2026.11.08.20.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 20:23:08 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/5] docs/system/hexagon: describe machine models and memory
 maps
Date: Sun,  8 Nov 2026 20:23:02 -0800
Message-Id: <20261109042307.1301438-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af14aaf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=XEA1TDPqdI0cZNt5_OoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX2KSRQyPfIcne
 9PzmmJUN7/Bk0SpwI8/6eeCSmDcp+WaTW7Sc4nTO+94I9E6flYmr/X80HQckrq0QYQhgpuKYeEp
 vIECQHxA5jPIetY3V2DFUUxqSeuMhQn1X5zd+NSExNAgDdYXvn4oDEFsaiNUTdNEHQzk7O5J6om
 H687CeJ8MgNQNBoRF+tc4NfEIkP/DC0ZtLzwLj/OFLCmFD2XM2eBwPKYxXkhcaXEd3fKzpecutc
 S+5+HClehpJ2qjrAQ0N5XvelbqrlERVyGaSSa5cNR6aFcDqpsATYlh67PS5AsSpiQQqGJANVKcY
 B6pQgRRFj4pwAxM1vogx0r8tr+WDm1v6Nic5gs+RXDcxTNEPIYt3b+XZc7n9c4hQCSmZl8iE924
 GgGVcgy3uVarKQyBWjd/+hb7XoMLlg8I2mvo/KChtT8F3/IVWH/8bkeN05rfs4dDx8XmF1g0LRS
 INn4iWFfd2I2zw3tFQA==
X-Proofpoint-GUID: Fiy0aNr2qk9G7NmyRJYJar_25wAud38c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfXyY+tO5LT2Eg1
 09ljtUdU2EUN2W+KLYcngm15+qg/LvdWMmoOfnjqrcOJ/iVHhYWXhFpWFo/2Smbe5ApAYsEDG2o
 bVEEq+sKZU2rBHsEBLs3fHgIl6twRS0=
X-Proofpoint-ORIG-GUID: Fiy0aNr2qk9G7NmyRJYJar_25wAud38c
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5yc3QgICAgIHwgNDEgKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vbWFjaGluZXMucnN0IHwgMzgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29u
LnJzdCAgIHwgIDUgKystLQogMyBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAyNCBk
ZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5c3RlbS9oZXhhZ29uL21hY2hp
bmVzLnJzdAoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5yc3QgYi9kb2Nz
L3N5c3RlbS9oZXhhZ29uL2Nkc3AucnN0CmluZGV4IDhkM2ExZjYxMWIwLi4zNTU2ZDhhOGFhMCAx
MDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9jZHNwLnJzdAorKysgYi9kb2NzL3N5c3Rl
bS9oZXhhZ29uL2Nkc3AucnN0CkBAIC0xLDIxICsxLDEyIEBACiAuLiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogCi1Db21wdXRlIERTUAotPT09PT09PT09PT0KK0Jv
YXJkLXNwZWNpZmljIGJvb3QgZmlybXdhcmUKKz09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
IAotQSBIZXhhZ29uIENEU1AgaXMgZGVzaWduZWQgYXMgYSBjb21wdXRhdGlvbiBvZmZsb2FkIGRl
dmljZSBmb3IgYW4gU29DLiAgVGhlCi1gYFY2NkdfMTAyNGBgIG1hY2hpbmUgY29udGFpbnM6Ci0K
LSogTDJWSUMgaW50ZXJydXB0IGNvbnRyb2xsZXIKLSogUVRpbWVyIHRpbWVyIGRldmljZQotCi1U
aGlzIG1hY2hpbmUgd2lsbCBzdXBwb3J0IGFueSBIZXhhZ29uIENQVSwgYnV0IHdpbGwgZGVmYXVs
dCB0byBgYHY2NmBgLgotCi1IMiBib290IGZpcm13YXJlCi0tLS0tLS0tLS0tLS0tLS0tCi0KLVRo
ZXNlIG1hY2hpbmVzIGNhbiBiZSBzdGFydGVkIHRocm91Z2ggdGhlIEgyIGh5cGVydmlzb3IgaW1h
Z2VzIHNoaXBwZWQgaW4KLWBgcGMtYmlvc2BgLCBzZWxlY3RlZCB3aXRoIGBgLWJpb3NgYDoKK1Ro
ZSBDRFNQL05TUCBtYWNoaW5lcyBjYW4gdXNlIHRoZSBob3N0IGZpcm13YXJlIHNoaXBwZWQgaW4g
YGBwYy1iaW9zYGAsCitzZWxlY3RlZCB3aXRoIGBgLWJpb3NgYC4gVGhlc2UgaW1hZ2VzIGNvbnRh
aW4gSDIgYW5kIGVpdGhlciB0aGUgYGBib290ZXJgYAorb3IgYGBsb2FkbGludXhgYCBsb2FkZXIu
IFVzZSBgYC1MYGAgdG8gc3BlY2lmeSBRRU1VJ3MgZmlybXdhcmUgZGlyZWN0b3J5Cit3aGVuIHJ1
bm5pbmcgYW4gdW5pbnN0YWxsZWQgYnVpbGQuCiAKIC4uIGxpc3QtdGFibGU6OgogICAgOmhlYWRl
ci1yb3dzOiAxCkBAIC00NSwxNiArMzYsMjIgQEAgVGhlc2UgbWFjaGluZXMgY2FuIGJlIHN0YXJ0
ZWQgdGhyb3VnaCB0aGUgSDIgaHlwZXJ2aXNvciBpbWFnZXMgc2hpcHBlZCBpbgogICAgICAtIGBg
MHhhMDAwMDAwMGBgCiAgICAgIC0gYGBzYTg3OTdwX25zcDBgYAogCitgYGhleGFnb25fbG9hZGxp
bnV4XzxzdWZmaXg+YGAKKyAgQm9vdHMgYSBndWVzdCBvcGVyYXRpbmcgc3lzdGVtIHdyaXR0ZW4g
Zm9yIHRoZSBIZXhhZ29uIFZNIGludGVyZmFjZS4KKyAgRGVzcGl0ZSB0aGUgbmFtZSwgaXQgaXMg
bm90IHNwZWNpZmljIHRvIExpbnV4LiBIMiBzdGFydHMgdGhlIGd1ZXN0IGZyb20KKyAgYW4gaW1h
Z2UgdGhhdCBRRU1VIGhhcyBwbGFjZWQgYXQgdGhlIGBgLWtlcm5lbGBgIGFkZHJlc3MgaW4gdGhl
IHRhYmxlCisgIGFib3ZlLgorCiBgYGhleGFnb25fYm9vdGVyXzxzdWZmaXg+YGAKLSAgSDIgcGx1
cyBhIGxvYWRlciB0aGF0IHJlYWRzIGd1ZXN0IEVMRiBmaWxlcyBmcm9tIHRoZSBob3N0IHRocm91
Z2ggUUVNVQotICBzZW1paG9zdGluZzo6CisgIFJ1bnMgSDIgdXNlciBwcm9ncmFtcy4gIFRoZSBi
b290ZXIgY3JlYXRlcyBhIFZNLCBsb2FkcyBhIHByb2dyYW0KKyAgdGhhdCBpdCByZWFkcyBmcm9t
IHRoZSBob3N0IHRocm91Z2ggc2VtaWhvc3RpbmcsIGFuZCB3YWl0cyBmb3IgdGhlCisgIHByb2dy
YW0gdG8gZXhpdDo6CiAKICAgICBxZW11LXN5c3RlbS1oZXhhZ29uIC1NIHFjczY0OTAtY2RzcCAt
c2VyaWFsIHN0ZGlvIC1kaXNwbGF5IG5vbmUgXAogICAgICAgICAtYmlvcyBoZXhhZ29uX2Jvb3Rl
cl9xY3M2NDkwX2Nkc3AgXAotICAgICAgICAtc2VtaWhvc3RpbmctY29uZmlnIGVuYWJsZT1vbix0
YXJnZXQ9bmF0aXZlLGFyZz1ib290ZXIsYXJnPWd1ZXN0LmVsZgorICAgICAgICAtc2VtaWhvc3Rp
bmctY29uZmlnIGVuYWJsZT1vbix0YXJnZXQ9bmF0aXZlLGFyZz1ib290ZXIsYXJnPXByb2cuZWxm
CiAKLSAgR3Vlc3RzIGFyZSBsb2FkZWQgYXQgYGAweGEyMDAwMDAwYGAuCisgIFByb2dyYW1zIGFy
ZSBsb2FkZWQgYXQgYGAweGEyMDAwMDAwYGAgYnkgZGVmYXVsdDsgdGhlIGJvb3RlcidzCisgIGBg
LS1ndWVzdF9iYXNlYGAgb3B0aW9uIGNoYW5nZXMgdGhpcyAoYGBhcmc9LS1oZWxwYGAgbGlzdHMg
aXRzIG9wdGlvbnMpLgogCi1gYGhleGFnb25fbG9hZGxpbnV4XzxzdWZmaXg+YGAKLSAgSDIgcGx1
cyBhIGxvYWRlciB0aGF0IHN0YXJ0cyBhIGtlcm5lbCB3aGljaCBRRU1VIGhhcyBwbGFjZWQgYXQg
dGhlCi0gIGBgLWtlcm5lbGBgIGFkZHJlc3MgaW4gdGhlIHRhYmxlIGFib3ZlLgorICBGb3IgbW9y
ZSBpbmZvLCBzZWUgPGh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9oZXhhZ29uLWh5cGVydmlz
b3I+LgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5yc3QgYi9kb2Nz
L3N5c3RlbS9oZXhhZ29uL21hY2hpbmVzLnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMC4uYTQ3NjBiN2E1YjEKLS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL3N5c3RlbS9o
ZXhhZ29uL21hY2hpbmVzLnJzdApAQCAtMCwwICsxLDM4IEBACisuLiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitIZXhhZ29uIG1hY2hpbmVzCis9PT09PT09PT09
PT09PT09CisKK0Nob29zZSBhIG1hY2hpbmUgdGhhdCBtYXRjaGVzIHRoZSBydW50aW1lIGVudmly
b25tZW50IGZvciB0aGUgcHJvZ3JhbSBhbmQKK3RoZSBIZXhhZ29uIElTQSBpdCB0YXJnZXRzLiBI
ZXhhZ29uIG1hY2hpbmVzIGZhbGwgaW50byB0d28gYnJvYWQgY2F0ZWdvcmllczoKK3NpbXVsYXRv
ci1jb21wYXRpYmxlIG1hY2hpbmVzIGFuZCBib2FyZC1zcGVjaWZpYyBEU1Agc3Vic3lzdGVtIG1h
Y2hpbmVzLgorCitTaW11bGF0b3ItY29tcGF0aWJsZSBtYWNoaW5lcworLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KKworU2ltdWxhdG9yLWNvbXBhdGlibGUgbWFjaGluZXMgc3VwcG9ydCBz
dGFuZGFsb25lIFNESyBPUyBhbmQgUXVSVCBwcm9ncmFtcworaW50ZW5kZWQgZm9yIHRoZSBIZXhh
Z29uIHNpbXVsYXRvciBlbnZpcm9ubWVudC4gVGhleSBwcm92aWRlIHRoZSBjb21tb24KK0hleGFn
b24gc3lzdGVtIGZhY2lsaXRpZXMgZXhwZWN0ZWQgYnkgdGhvc2UgcHJvZ3JhbXMsIGluY2x1ZGlu
ZyBpbnRlcnJ1cHQKK2FuZCB0aW1lciBzZXJ2aWNlcywgbG9jYWwgbWVtb3J5LCBzZW1paG9zdGlu
ZywgYW5kIGEgY29uZmlndXJhdGlvbiB0YWJsZQordGhhdCBkZXNjcmliZXMgdGhlIHNlbGVjdGVk
IG1vZGVsJ3MgY2FwYWJpbGl0aWVzLgorCitTZWxlY3QgdGhlIG1vZGVsIHRoYXQgbWF0Y2hlcyB0
aGUgcHJvZ3JhbSdzIHRhcmdldCBJU0EgYW5kIHRocmVhZGluZworcmVxdWlyZW1lbnRzLiBgYFY2
NkdfMTAyNGBgIGlzIHRoZSBkZWZhdWx0IHdoZW4gYGAtTWBgIGlzIG9taXR0ZWQ7IGBgc2ltYGAK
K3NlbGVjdHMgdGhlIG1vc3QgbW9kZXJuIHNpbXVsYXRvci1zdHlsZSBtYWNoaW5lLgorCitUaGUg
dmlydHVhbCBtYWNoaW5lIChgYHZpcnRgYCkKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQorCitgYHZpcnRgYCBpcyBhIHN5bnRoZXRpYyBzaW11bGF0b3ItY29tcGF0aWJsZSBib2FyZCBm
b3Igb3BlcmF0aW5nIHN5c3RlbXMgYW5kCitiYXJlLW1ldGFsIHByb2dyYW1zLiBRRU1VIHN1cHBs
aWVzIGEgZGV2aWNlIHRyZWUgdGhhdCBkZXNjcmliZXMgdGhlIHZpcnR1YWwKK2hhcmR3YXJlIGF2
YWlsYWJsZSB0byB0aGUgZ3Vlc3QsIGluY2x1ZGluZyBDUFVzLCBpbnRlcnJ1cHQgY29udHJvbGxl
ciwKK2NvbnNvbGUsIHZpcnRpbyBkZXZpY2VzLCBhbmQgYWNjZWxlcmF0b3IgY2FwYWJpbGl0aWVz
LiBTZWUgOmRvYzpgYm9vdGAgZm9yCitpdHMgYm9vdCBwcm90b2NvbC4KKworQm9hcmQtc3BlY2lm
aWMgQ0RTUCBhbmQgTlNQIG1hY2hpbmVzCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KKworQm9hcmQtc3BlY2lmaWMgQ0RTUCBhbmQgTlNQIG1hY2hpbmVzIG1vZGVsIHRoZSBE
U1Agc3Vic3lzdGVtIG9mIGEgbmFtZWQKK1NvQy4KKworRmlybXdhcmUgY2hvaWNlcyBhcmUgbGlz
dGVkIGluIDpkb2M6YGNkc3BgLgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFn
b24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4IDVkNDhjZjQwMWFk
Li41YTY0NmZkMGQwNCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0
CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdApAQCAtMjEsOCArMjEsOCBAQCBy
ZXNldCBhbmQgdGhlIGZpcnN0IGluc3RydWN0aW9ucyBhcmUgZmV0Y2hlZCBmcm9tIEREUiB2aWEg
dGhlIEVWQi9yZXNldCB2ZWN0b3IuCiBJbiBhIHJlYWwgc3lzdGVtLCBhIFRCVS9TTU1VIHdvdWxk
IG5vcm1hbGx5IGFyYml0cmF0ZSBBWEkgYWNjZXNzZXMgYnV0CiB3ZSBkb24ndCBoYXZlIGEgbmVl
ZCB0byBtb2RlbCB0aGF0IGZvciBRRU1VLgogCi1IZXhhZ29uIERTUCBjb3JlcyB1c2Ugc2ltdWx0
YW5lb3VzIG11bHRpdGhyZWFkaW5nIChTTVQpIHdpdGggYXMgbWFueSBhcyA4Ci1oYXJkd2FyZSB0
aHJlYWRzLgorSGV4YWdvbiBEU1AgY29yZXMgdXNlIHNpbXVsdGFuZW91cyBtdWx0aXRocmVhZGlu
ZyAoU01UKS4gVGhlIG51bWJlciBvZgoraGFyZHdhcmUgdGhyZWFkcyBkZXBlbmRzIG9uIHRoZSBt
YWNoaW5lLgogCiAuLiBhZG1vbml0aW9uOjogRGlhZ3JhbQogCkBAIC0xMDAsNiArMTAwLDcgQEAg
bWFjaGluZXMuIFRoaXMgY2FuIGJlIGZ1cnRoZXIgY29uZmlndXJlZCB0aHJvdWdoIGBgLXNlbWlo
b3N0aW5nLWNvbmZpZ2BgLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09PT09PQogLi4g
dG9jdHJlZTo6CisgICBoZXhhZ29uL21hY2hpbmVzCiAgICBoZXhhZ29uL2VtdWxhdGlvbgogICAg
aGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

