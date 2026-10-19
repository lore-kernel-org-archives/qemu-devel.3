Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F68606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RK5eThji;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cWYxvDs5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvul-0000R7-JG; Mon, 19 Oct 2026 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvui-0000PV-UT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:33:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvuf-0003Rf-Ly
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:33:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZTn4836456
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7hq5nbvq3UYFK3vnPf8IbLUI7pGgpWATyJo/RjfnvO0=; b=RK5eThjift+CZGbQ
 FqkNwIKA6xdhL4m0YZKGorH/zTugWCH6QHqknPGGbWLzw/oS0sOBmx3Re8k1ORrV
 1bhg7cD2BfgikGDYbI2hqUoMijBaR8D+pii5bBE7GgdUPyYeg6Pbc+7Io0P9oC3T
 y9uN7Ga5biJ8vAlbF5Zq1SE5YPLwKcXbKo2iEC79NA3tSOl0F0eyzzx18kSStyr6
 OWNF+lE7Noxk+5p3NDYie9Byo5Xcxim9kpT3KvX706n3itZv94oKoFdlCjEEtAGX
 1finpPcVz5jW/YkULzVSpZcc7yhCbs5eauPvqX9ueH6f2qooZlAXengWF/FTRudt
 VlhRDg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kjs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:33:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5403180eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449180; x=1793053980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7hq5nbvq3UYFK3vnPf8IbLUI7pGgpWATyJo/RjfnvO0=;
 b=cWYxvDs5f8WzmzOXZapTEFND4AZLD5CGOJkxlY3QgbNhvbLe9BcDGOd2ySiSkZuF+V
 DRT+y6EPv0KvI3Qf9gfIzZL2BaeIKpm43YfnUfkGnPr9NwsoimG28qem6JcRh0xjPCRL
 gJR50BC2LTr7Rzp9B5b2ObF+rPVbFcq6VSaXQMS4TA2+M6SWphxe0r+Z+NojvYDy23eB
 mHchObcpSsB1TCYPEsO3c8W+G1D2R87iJHNxE4Jj/ph7iOyz1PXFjfKEl4lkORvrfNFS
 V23QmJ8TGRZATIoLwos1mcdDH4emKWt3d6z1e+7ZZx8/WaGkQVdr/czuAaH5Vywm6MFl
 +JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449180; x=1793053980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hq5nbvq3UYFK3vnPf8IbLUI7pGgpWATyJo/RjfnvO0=;
 b=h19Q9J5yQIiDbX9g6h2F8nDL48zhUSYjQYZHlCcRuIfnZYo0Z4VUA9i4o2Wv9Nj7EJ
 kRD5UaCGhAht8NV8svFhb9M1YQrMyx7UQ9OBnpEio6TlOmgxGS788NMXR+WQmGgxkqDE
 ZmxzScKizO0xhUqHO63xe9NkHTdoeJoYCYkBZtsc9w6YksOCf+NC578h/KIyyI/Mmdin
 6uEh5IscZYX+v2lTdTrwX676HT3xtsadYsAv/pQto2RIKtMhJisEhUu6zdM3TE+P6VoA
 XviZzi4Aq6Mcf8RHUmAD3LoAEJ0boilLJLvWkjj3i8bIhpfBiKwxLknnCvtWWuXwMAQR
 HkDw==
X-Gm-Message-State: AFq9FYKNbYE2/BAHx/fBZ7bvEmBUbdjNU68+ZfeDbB39rOmPmAftTlJQ
 jlk0uo+xdSQ3N3ZVzfcXjFl29gDJ+IlhsJ3+5QpFsFt09IeE4fgRCGXXktaiXu6BjSb+wlg19Ln
 VquiO0P6Lkax7fchMbRD+A5nMJDOUsaMPlqNBEMmEny8SmmLJc7nqvAcyBwq729YWDQ==
X-Gm-Gg: AYBFou3aa1hRUV2RjHNPrHfkXPKLsznMc+LeqMNsV/9zGnSpCddL4A2SJZLBTs5Y1Gg
 Sz1cTlsRVWk8VkpUxb/2Khr1Ulfgw7SD53fCErhImct2SMiYpsVSHS5aTyPC2RUiaBSz3etb2z8
 7v3ahWkZYT0dBi2piw3oINPkfWA/k1+WTowxfN3j8vrQqka4oB2QmJJKeyopWy0TwXZU6IHCNfZ
 76Fvcfyb/I8YhoiVQdd82xgR5MmmFtWCmAfJfui2IRnHbzBi/ds5/6b0OGM9x7YqtdLdLeiSW54
 ZHCdc6ZHMRPBzuqNBPQ9K9iA4rJ17GDmu0awbfvgxEfUqfChTyYBahYalTe170OYEl+gCTaG/pe
 uuhY779Y3wG9N3s0w8M7PfDPTJQj4WVOrhXS509ESVpy4A2c=
X-Received: by 2002:a05:701b:4201:20b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-1850c22369cmr13893794c88.3.1792449178135; 
 Mon, 19 Oct 2026 15:32:58 -0700 (PDT)
X-Received: by 2002:a05:701b:4201:20b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-1850c22369cmr13893767c88.3.1792449177582; 
 Mon, 19 Oct 2026 15:32:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm48294319c88.11.2026.10.19.15.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:32:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/2] target/hexagon: reset implicit USR write state
Date: Mon, 19 Oct 2026 15:32:53 -0700
Message-Id: <20261019223253.3243067-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
References: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: KvWPCny0O-9Vcuq00KTtZY-UXjkcm6dY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX3bZTUuECQy7W
 hmKnlOPppSm07rELwjYUMHPGTxHEiwVGJNm53zpVMvf27mJI16yecRnbWQIjcf3haJPB6jW4U2r
 nSzQogUq4IGhbNwZEBSGZLbI3GbWzbi0+R4sFKoKUZZ+ilzXqcqnKgosaW5PwuPtXTSYHmqroft
 lbIBkGBWVjJ/KltPKG38kVaQUNY8Be6NpQkZ4VP6pPJFHr98hZUEj8aFPT4vSvz8M6DEE/qlmbY
 FP6yIKOb+8M1Fhf5xs5mFB1ELQ3NQ+IJSz9MvX1wq1ZFeZBdLEp/+NZTqU8K9jq4ANcmYrJkf/i
 tnC5JoK7KMTljpZv7RzNJfgNg5ZGK+jIakVUjzKTbM2Kz1uoHcaV2cgkuWQgthnWb1GJ8Eliz8z
 jkFyTfmeFNIEwIa9hH9PUNeKWMBvADHv3ljuGSE37+TIDAGuj0nSDV0Si2gwRnM3ugSu/uiV24u
 fi9zyff3PX1FCW6sFnQ==
X-Proofpoint-GUID: KvWPCny0O-9Vcuq00KTtZY-UXjkcm6dY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX/F5tNXrZYYJx
 wQqdHi/Jd0RWZaA6+D7B7HeyDXhcXWWpe8rf9W2v08rnvEirSEKIR9TsfegeNvYiMBuIwCrpvOB
 g/tFlVqBTpse73nceSqlTVLTTSxU/8w=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad69a9c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190089
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
IHBhY2tldCBjb21taXQiKQpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAxICsKIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggMmMxOGY1ZWVi
ZmYuLmE0YzVlMDQzYzcyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNTY5LDYgKzU2OSw3IEBAIHN0YXRp
YyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4LT5yZWdfbG9n
X2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRPVEFMX1BFUl9U
SFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3JlZ3MsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUgPSBmYWxzZTsK
ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4ID0gMDsKICAg
ICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0tIAoyLjM0LjEK
Cg==

