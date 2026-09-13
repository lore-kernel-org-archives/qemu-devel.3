Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D62C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 16:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5mcK-0003Us-Vx; Sun, 13 Sep 2026 11:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5mcJ-0003UF-Ci
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:59:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5mcH-0002eL-Q3
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:59:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DE00Yc2786237
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CCJBLjUSxWNoEqq90BDvaDZbICdK1NjUxSbNQgTZoSY=; b=MC5rE2StLQfRlxH0
 cousp+JTHlP3agQOgst3HfoZFbKQnGF3A3I1KPAXX9CEiTTGaKwvhs9fF+E7lmW3
 WyPFR2fmLI76zJ45e4m51OvcNON3YYe2Nok58CImRGFiTRpyLH+XsKbtgBCxdQHX
 iRRP+alRcw8BzkFwRDlTh+ubfGGketpv6OD7EWq87yT5JdjOVRLEwgDdrXBpEqre
 DmfdOgHixiACQPbIdlea8RWZZkvohIR0f8eL07hg/ux9O95x7mAq/dN/Ig7OTarW
 SOJoZePnZOUUHTnPlw/k8SOHhp20P/GbZGv9p5EpPlteglvknHh4jeBuSY/wK27Z
 nimaOQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cbnca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:59:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc435388657so2834869a12.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789315180; x=1789919980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CCJBLjUSxWNoEqq90BDvaDZbICdK1NjUxSbNQgTZoSY=;
 b=PUe929nRXthm3TfZwkQGme+m3GfpM2sRd3OwJLCDXBmGRC81/y2G9JzIGHPtXo6iwF
 k0i/KY796HXlb+RiFshXNy5xr2nFs0skUYPqO/fBeOEOjzp5lfTXxAmLcpvO6FJfNJD6
 bJtlx/l+W0wwIWXqfxC2Q/oUhFnO9qozbkKnVhh7V/R26gqwanfooIQKigjceAVLsmBO
 aYZ2v8omiTK2iEH3/mQJPVRINyibn5JU3i0LRlnkLFKZFVX301YTt30k1XGWiiFJpsNe
 s621I6r63v4HTkvK9pwY0Fp28KswFFa9sfHc+ZIYQAQzr8VT0mkd3X9DlIl2Vt+dw1EC
 ZZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789315180; x=1789919980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCJBLjUSxWNoEqq90BDvaDZbICdK1NjUxSbNQgTZoSY=;
 b=YJBv86JfmAAWw5/uNRBhaBvpDD1ZuDYSzOZ43U2hLez7FW8TuXb+2cn32Q6q3QWzJg
 FEdLt+20/fqLEVfoLfJ/RE2TB3VaPHZQJ4c8aU66J8FmEG7EcmUWz2FHwOMgwPWAopWJ
 RvHlS/nsrkpqIXa6MhMPBhEL+g2cva13MRVCqc/lckd1p2OWbDkbQKd9T+vxqzlMfpDl
 PT3CoHb99pvZXEzzA3VPKqQaCE2gDmWNJc9TS/gYkpeKg8u+wooMQz/Gz9gNn+P4I7N5
 B0NG/6x2G5eKISzIc3jN9F0hibjZy+9OveEf6Xc4P3mcfj0bS/bE+p5UtLcFC92cn0zv
 FbSg==
X-Gm-Message-State: AFuF++kPwv/UjBxq4e/wSy6ElNi8IT8nFbYExR/AOVIAWw8h6d8MuiBN
 A2/U3opW6LUeIKcAWmiJlmf9UAaygA/BYOL3feDUC2OrXmj1eWlpGAETOQgnv31uW6NL0hLuztt
 +HSeWiXGP/L9rUWkhznVYdVx6fhT4ufCdTGpojEkSLbJo2fQOdUsP/wf/KIN44fvTQA==
X-Gm-Gg: AYBFou34ENo9aIgkztBDGxrI1Z6qqyPhrztDvIEwDFA5FO77rky16e1vzJCxrCwD5ob
 sFjPTNxkqpRj1kMJHDGZxaxtoaQ5CfMFkJ8+VasU3/dQCWzIIjQb/dW7o8iC9CghK2C/J9ejmvA
 lba0l2Hhc5dc4XsI+tcR5E87/p9gi+4/mHarZ6u23DbSMK+i+v68yrkTB8LTmUDRaPo36yFyNJN
 V8Uk/r9gqisOnd6ER6DTz1JDcLeAYlYossvE1c3TOlWCdeyCPCJTUsQm6odjhduDyNT+YrrBt31
 G2fYGWfLqEBmKt7z3Nh+ZQyFz2nVLq4haAqPMTdHoFA0M1HNa8mhJRN0AVxgEvq7fHcsqpFVWDv
 R5tRS5bAKhjSCFIzb5Ncx8Uja8K8SXeDl2p0nPZXsUCgVVD7y
X-Received: by 2002:a05:6a21:3a43:b0:3da:4cc6:17d3 with SMTP id
 adf61e73a8af0-3db0e48db6amr15681376637.26.1789315179728; 
 Sun, 13 Sep 2026 08:59:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a43:b0:3da:4cc6:17d3 with SMTP id
 adf61e73a8af0-3db0e48db6amr15681322637.26.1789315179303; 
 Sun, 13 Sep 2026 08:59:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bbeb053a5sm8076380eec.27.2026.09.13.08.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:59:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 6/6] tests/functional/hexagon: add HVX tests
Date: Sun, 13 Sep 2026 08:59:28 -0700
Message-Id: <20260913155928.365928-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260913155928.365928-1-brian.cain@oss.qualcomm.com>
References: <20260913155928.365928-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX9m+VYHmuqX9v
 M0Z0+jzbIZc7IVeTuzC8O+iWDMlW7GHMDDNva4cszU3CTix+/IMNFEgdzXfIkqx6SCOgNySUqoA
 YxT0SLVMaK1TPTQ5u5r0MS3W3pXRMwc=
X-Proofpoint-GUID: T3qb9bAd_kjhXPnDItIwUe3GXm1g7Omk
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa6c86c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eq6FigJt9aAjue5lDr8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: T3qb9bAd_kjhXPnDItIwUe3GXm1g7Omk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX43EKjDtojFPT
 VXKRJKm/XBCzpbW/AV8eClEE7LE9Mm122+X1pF0GcQScKjzRNKxVLhO/jDoNRroSAr6GrAXXjc5
 w6klNUodC/bS3R3dEwKwZIJ1osuS3yGbppw/NuGqvdr64kIO/RLFwamJJ3eEHfTKziGRgg1IOgf
 y0FAkvyqWqQ1Z/6bX5Ewb1sAnS/QW5aqHhHGSC9pl6dkMDqh11+9pFnXlroOjFfFfJLTTU3alVE
 bzAFT3wHlYUkvcs8g2Dc7754Vajhivn9kiHbm84L6DtK3+SU44efkC8Df0DS6Sh7P+y+1Hdf0W1
 TrSBFJg2u0KWTZpPc+3ayxQw2C5QWhSNVRQkD8dDlcObGVN6YPr8g5E65aGt8zu727rxuK4XRbF
 oyE0FCEddja7wZ5CKGmV+4RnzK8wqWRb6+ANDvsQ1H41tA9revia+3l1ZB2zEoHArqoluMtNIUA
 HMKJmixIpHZw2ekNLaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130227
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

VGhlc2UgdGVzdHMgcGFzcyBub3cgdGhhdCBIVlggaXMgbW9kZWxlZCBmb3Igc3lzdGVtIGVtdWxh
dGlvbi4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwg
NyArKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSAgIHwg
NiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDQwZjc2ZTI1YWU2Li4yOGJm
MmYwMmQzOSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5
CkBAIC0xMTksNiArMTE5LDEzIEBAIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAtPiBOb25lOgog
ICAgICAgICAiIiIKICAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3VzZXJfbW9kZSIp
CiAKKyAgICBkZWYgdGVzdF9odnhfY29udGV4dChzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJU
ZXN0cyB0aGUgSFZYIGNvcHJvY2Vzc29yIGNvbnRleHQ6IFNTUiBYQSBjb250ZXh0IHNlbGVjdGlv
bgorICAgICAgICBhbmQgaXNvbGF0aW9uLCB2c3BsYXQvc3RvcmUsIGFuZCB0aGUgTk9fQ09QUk9D
X0VOQUJMRSBleGNlcHRpb24KKyAgICAgICAgcmFpc2VkIHdoZW4gU1NSOlhFIGlzIGNsZWFyLgor
ICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2h2eF9jb250ZXh0
IikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0Lm1h
aW4oKQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMu
cHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQppbmRleCAyNzc5
ZWZhOTE3Mi4uYzgxMzdhNzE3MTMgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5
c3Rlc3RzLnB5CkBAIC05OSw1ICs5OSwxMSBAQCBkZWYgdGVzdF9tbXVfbXVsdGlfdGxiKHNlbGYp
OgogICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKICAgICAgICAgc2VsZi5ydW5fZXhpdF96
ZXJvKCJ0aW1lcl9yZWciKQogCisgICAgZGVmIHRlc3RfaHZ4X211bHRpKHNlbGYpOgorICAgICAg
ICBzZWxmLnJ1bl9leGl0X3plcm8oImh2eC1tdWx0aSIpCisKKyAgICBkZWYgdGVzdF9zdGFuZGFs
b25lX3ZlYyhzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzdGFuZGFsb25lX3Zl
YyIpCisKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3RlbVRlc3QubWFp
bigpCi0tIAoyLjM0LjEKCg==

