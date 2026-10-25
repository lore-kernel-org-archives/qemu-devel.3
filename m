Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE8606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aFw7ko97;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bsl9Hi6D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoqB-0007gJ-SB; Sat, 24 Oct 2026 23:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq9-0007f6-JI
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq8-0001Sv-6z
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16Bfj2050600
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=aFw7ko97Zkl4BOCU
 ksxqw+UR3B9LPLQMv2nZi7mHEgKaQS5rqPom5mfh/qmRP7qgdxMF74NWQn5XxWpZ
 BUyS3zK3MindDVy1PFm0iNvc6kve64/a57SGsbG7/QEySDQk1Da98o/Ox4fd8a6E
 ZJ9uhIu7AIgQOCJPq73kNCT2sZ546hzKdNaI+ew0KmMnnv0RbuyT0Ybh5tSzfSIj
 g2o6yaHEEwIT94ij8Hx5xAhiq+cLTZTQLnbf53VqtCJBWGA6AdHwtjcXQNKwb75P
 sH+/Z3u6amvC0aKc0JCb6wHhUc16okl5hUAbakPSdL09KAyg/5l5Vk7bYcWRj2d/
 DzJVEg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27t9y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:06 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-18b5ee75447so8483233c88.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898646; x=1793503446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=bsl9Hi6DJ5jDuOWuzjA/ThmTBB1UEp9xsswAkDCMP37L0fK1arCL0Lr56KS2Fp1jX+
 /WBBBdA/AC6g/vrrYLQniEPO19zja6HoIC5Lp2kLeIT9BvftYBwg+Ck91Gwl1w2c1vLM
 Oo6Y5g73HQ1z+eq0YI8c3MiCBNO9Khyd/XaViCxxkF9eKy0dY8GYKuG9YRHii55wCcD5
 ZLCVqF90Rioy7GZ2uTMeoOp+bq72O4ss8v4CO1NlCH/2lioHBX9D9KdxSkzCzFYAprXq
 SzSlUExNw4vZXu6UWHgKoQBxbHypkwgds/PgDp4WzX5liL2I0kLaiPopBsb84VZEvQV3
 qDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898646; x=1793503446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=zGDRU8aeqYn5A/+bwpczs5QCEWjcNiUq4v3PUxsGMpS7ri2P6lsAueQHX5uzSybQCU
 EzzontfMZW9r52cNPa1HQi7MLXZUcvjoHPQnJchPQXahzj+r6I9DJkSZxWkK7xNrOcp3
 QHP85y2re1IgXyhO/YPneK2FVO3IRVvzSZBcQ2XWipt3b2Pnw364rVkTL21ToJFC11Ot
 6VZGfIt5XMuIy/4zFpjdJOpfHl4tH1qvqQj/B2Nyfwoae/ay3bbXFw338UEh3wyi0MnO
 DLLMLxX7IGdZyApe6OrzAhhqXvIkVo5C4zUJ5veD8JwkbI0pE7T7TX2wOjz/IXKDyDmf
 pNtQ==
X-Gm-Message-State: AFq9FYJ/GLmHQvPEQiOmdr3z0Weg0w1t86ibhaNi+F9smgIwOs/cAdKH
 KG7nExO4OCVeRi+fEjx23So9LetvM7BfX4WZlvKYgdjZNJzEe92erQS+eC+cmsbwfFHK5sd/7M0
 y9GJZ/neBMuqEB0+KjZE5wmOI71DJ+rylT+K2/+wLrLk5KREJdMU5cU5qusSeKSyd0g==
X-Gm-Gg: AYBFou2OniF2IAidT7l/b5OEQx8/GFMpXp44Slye3vaF/82bIUT9ziCLakzJoOO0UXA
 V5RiJRGrmytRGG9H74wT2RFnT0uGozWys2h1rH1iUgA151GVhITJgBxJRMPJHN6niyoH9uD+Oj8
 f6lOYuFVHrt43xHZB7poj06FGQsvTTG9Lj1oeK26FxLH2X3t2nKX84XJbwQ9q+R/ZG/d2+6t8PI
 UOjbbGhrJ0c+JUmj7oEUb9gzMPBgeaCEcOakwf1Ph9/cvpPleZgCOKXQNEG9cXePbXjSxGr0U7y
 jW3w2IuqL4/a5AdqPdAxihwCTNH3xttXTRophkHLFmRC1qZsYVRYCaANmEkGQaqDrD8xvmD56fp
 enmI67JaELC+pzqA15ZAAa0BT8fhKsdZ+cl7ZdjCYt27Y7sg=
X-Received: by 2002:a05:7022:5f07:b0:17a:e684:b497 with SMTP id
 a92af1059eb24-1992a062241mr4694951c88.5.1792898645820; 
 Sat, 24 Oct 2026 20:24:05 -0700 (PDT)
X-Received: by 2002:a05:7022:5f07:b0:17a:e684:b497 with SMTP id
 a92af1059eb24-1992a062241mr4694937c88.5.1792898645311; 
 Sat, 24 Oct 2026 20:24:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v2 07/40] linux-user/hexagon: report ISA HWCAP through v85
Date: Sat, 24 Oct 2026 20:23:13 -0700
Message-Id: <20261025032346.2917451-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6add7656 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: y3E8nfrMO4Utc4m7WacRx-t5gTrz0inE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX+A4Vo1x3s6Jz
 Z3whXNkun5ioZGVQa+EkvjG+HWEz1SohD8FquxhEszIZ+3k65ZHy+n0UdV0WSGKhldZ0zmsDcZg
 xtEB3C9uo+9oeUgmd3ev1Is3s21tWXM=
X-Proofpoint-GUID: y3E8nfrMO4Utc4m7WacRx-t5gTrz0inE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXyvZZFL4mhDiA
 AoebADLo3AdblTkbfj5q5E5BlDA8EURaKuc6yybQT0IwAzUGk49S+DxCd/B+lBfZpkpLw2m6Yaa
 rb0PWuP4vbJvRM8fVx75NvZVHCKIxywnje+4PsCADqtBf4hOAeg4vr3uUCuCmFNq3jNeixDheXO
 TwQGF6D4GcnhaDAtfptKyrJD0IC76kOzENzftiafZW9haTALe3XvY5fFH6yoV/yFavAT0f9RlkG
 3pUym0peXtzSa6pS5IXAfckKY45PMTPYiHK9wmVT2TTUBEYesAQ5YgKUW4/rQ99rnx8uF5Sksc6
 g5TXohc0QZ8pI8F+RNw/WnwvvjCW1D+CtfHJaxKSc7lQXA3rcYH91KRXZW5sy5Ro/hRaX71E9ji
 WO0Q9CfiYA2ee3od0TropBXCZc44kkIE2ibW+LtzQgmDNGOFarOM3kDCHFnICh9AjTo/IvbdADj
 HRs2GSXpZOV8SXnxf7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610250012
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

