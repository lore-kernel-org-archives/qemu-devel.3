Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i+GpKD7q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=izPkKiOL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzCq-00010y-2V; Mon, 19 Oct 2026 22:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCn-00010I-TA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCk-0003iy-Vq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tKvp4178129
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Enf2W/dFQxa7P2tBTeMCV59yWp+gzwwLwHLrsTYW8WY=; b=i+GpKD7qN0XM/YPM
 A1ymdyFBXWPTXqmw/Z4ehotLnDW8vKdXQHVALxzZBHwsMrNGh1WjIoSDdxmaUicv
 N6bUFmx8jEhYmgVxKc+Az+RUcTT5plqg2qtV7Nbte8onizfudrHobC6r24gDoxbZ
 iYAUlrXbeKtgaJFEIDNDahSx9jYSnF06N9MifEXXygivvLmcp9n4jdBkZi6TMlTl
 W9tAAlnrknOdik1AyVUZtTALQ0yHUPP1prsckucfyXxkYsuVDOBMFUFA8RvjIONr
 Dxr8uj0d4ad1Uhi5BTcDtDacN1LzCc8N4M1YlBkN8vQbA14dGI5o3A8/ntaH4gK+
 90MbYg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n0cgn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso4370535c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792461832; x=1793066632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Enf2W/dFQxa7P2tBTeMCV59yWp+gzwwLwHLrsTYW8WY=;
 b=izPkKiOL0lUeE7QXd6G3a2OiWJtbVWjypccogSCGyI82pyqYzltVeG6opiMuta2EG2
 jaID5PTYUPwKT/xS4pD0O3MYlypnsSsDYdDIsgXzyeljIvCEFHpR2EyUceS8FdNUC7wD
 yJFUbVO7Y9OrPBuHEuaD3ZMpW6wJ3E8jPqShJRrTqvE4oqFNeU8V7FIPcDknxmkD+4Vy
 zwQccWzejRvnUDx7Zk79UWr/X+Kr55AZA8/XI/YbdkxzZ8aZcywPWo34+6cN7+ngy6So
 ky5uN69sb8ro9ZwUtBirW8oJWKFeOTv35cbvhQwk5XBxYV6wyzeorWmVNqhRcWamrmoH
 d5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792461832; x=1793066632;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Enf2W/dFQxa7P2tBTeMCV59yWp+gzwwLwHLrsTYW8WY=;
 b=UqNeFlEL4ahjZhmAKemh11Pnwoxmnwvt00GUcqvlvUnL3zRKiuuIipG5r4yQxXJfBW
 pQmLTsQY0uIpdnsClOg+7YBmMVb+eW6Lcu1KCG4Mk6aKKjghW6za04JgpCIH4AsjoI8f
 2LbUpjcyqR++wrxiTy53oq7gj6NicCR0Mr4q/Mc/ZsU73Ahtu6KbGs+QAUKD07qvaJhI
 B8NRt9Sa6TyF8nxYLJ9F09Gw3Gr73eek/QTY4JCEo3PVWTp6Li1T8JPbCDrwpipjLuKZ
 8qxMn9JT9yBEloiE3i5kyPq1cPTM9/LIYJ6AIVvAAgQBPPHTYr9ro79eCiKWz4ULfHDn
 xTDQ==
X-Gm-Message-State: AFq9FYK4D6+xq/Djhfk2vitNw8+skzlHsQ7YPkgwpO2s4yUBoVbsEVZp
 x28MzJNu3s+N5CtTlG8ae1/ebrrgcTfHb0lJSXZoTl29hUTk5ey1rmSajZh5SkP0FxyVqyeluXY
 PLGLOZs55LN/jsJrB0ovkMqJqfRnGFDGdJHYCI4579XSw5nMwGyd7cIfyvuiZUJ4WnA==
X-Gm-Gg: AYBFou2HrGgrqO5d1gMU+vgqIBVT9RizrNSMrLdaS8ocRrpi35GwlVVkbYYDUbVGWHI
 TWNLTFn3UPcUHnQ82ZGEkE3gUHPQnIDKxoIFXCCYzTkf8De2ZlQemlvhb4NZYaws1n5GcApnaTo
 AN6ZAK4BL2bLPO01zD5tcdHa59weCKMg6QGXaD+wKNqWtiwKzYls/J7r0Fhl+elDCcguoiAFVl5
 7TYsLBRDCMX6+2BHeSvpF/S0NUS/snqrpTyZR5XgVp6WvBl54uKPkuTgYg9daCbqv0mUdSfsVfd
 UeobO8XMWt1KSEpEBFAUckNKAYboOzIeFoagxAfb1OOiT0GAPAhd7KYbUBakI4KSlHFhVUOzxUy
 3HpKb3MqhzGAu8vKw6bLs5+GqHofMCi/hrjN2By6+hNvA7oHT
X-Received: by 2002:a05:701b:4305:b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-1851238b618mr12737720c88.7.1792461832490; 
 Mon, 19 Oct 2026 19:03:52 -0700 (PDT)
X-Received: by 2002:a05:701b:4305:b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-1851238b618mr12737696c88.7.1792461831929; 
 Mon, 19 Oct 2026 19:03:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm49452078c88.11.2026.10.19.19.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:03:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 3/4] target/hexagon: fix semihosting STAT filename handling
Date: Mon, 19 Oct 2026 19:03:41 -0700
Message-Id: <20261020020342.3619566-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
References: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6oUNqiKRKTYwfZ_sAGb9FrYnfztMuzFQ
X-Proofpoint-ORIG-GUID: 6oUNqiKRKTYwfZ_sAGb9FrYnfztMuzFQ
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad6cc09 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FZZFJ5KotruyPtQxbZcA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX5+DvT1Jm7k4k
 v035A60+31d0EjGUqDw8P2f4dj151J6nuuBmeQDQjJJPxgRbPfakksPkUBZUxeaBs6vDmhjYxNf
 nC8SojRg4OuYJGZR0fPb1VTX8BU4+Vps9ppotaanOsfDwist4V/zDC4fgdN7lPQ3njZ/6/sfMkV
 FxhpEJeKA3ZGjsMrxdqPbpFPuuDsBQ6dgRJiNEPbkuljL7i6drVddQkNJ5DwSA7M1qfauETg3Wl
 uKuELxZHQvKnkOEcWrYj6gC0YLLgShTfchdw+41xAKfo/S+DA6SnF1/qLu1pCxZ9w0cOsVopKwi
 Tt6fhgf7mUyHpisRHLgs9S0uih8GzPfpAVTfXSI9WPkJJch9VWIA32Kt0WEPs9/hihYynwCjT1X
 0CQPx4KsQzFEWGFvD8Aasr0D0dwwzwedcpgDEJuzZil89vsGBbMWywVoDInHRza37xpIRw6LKvl
 xlz/GRp4tf4u7yINrlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX62WAHP2LbjJS
 888ptVtlVsetiDN4IkSAUOO4DkdKP9ugaUSF6mj1dfc2BR2k80psnPjkJSsDYnFdhbDYX02N/su
 oC+Zgaj55pulR5eiwqX+iRmHTRpyrgU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200007
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IGNj
NDhjOWJhOWYxLi5hNWM4ZWUyN2M3ZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTU2NCw3ICs1NjQsNyBAQCBzdGF0
aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICBz
dHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0ciA9ICh1aW50OF90
ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAgICAgIGNoYXIgZmls
ZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRhcmdldF91
bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRfdWxvbmcgc3RhdEJ1
ZmZlckFkZHI7CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CkBAIC01NzMsMTUgKzU3MywxNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAKICAgICAgICAgaWYg
KHdoYXRfc3dpID09IEhFWF9TWVNfU1RBVCkgewotICAgICAgICAgICAgaW50IGkgPSAwOwotICAg
ICAgICAgICAgZG8gewotICAgICAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtp
XSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAgICAgICAgICAgICAgICAgIGdv
dG8gZG9fZmF1bHQ7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAgICAgIGkrKzsKLSAg
ICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0pOworICAg
ICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVuYW1lX2Fk
ZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAgIHNlbWlf
Y2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAg
fQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAgICAgICAg
IGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgaW50IGZk
ID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdmID0gZ2V0
X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

