Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FD606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A/y84MBm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=js+cqLzD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4RF-0001NN-DF; Thu, 22 Oct 2026 21:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qs-0000VV-IL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:50:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qo-0006H0-DK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:50:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1F8QO425685
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iBrFR+0sk5zM8kbC7Z+VhEbrVionSXwnGjPep2Z4hWw=; b=A/y84MBmAopyy3Ih
 JCfpP/C/Xsjn/KQw2HNaglZTW6ZuFRCvij5/sFG+2jhX0GdLPL/y2oQMt4ET2j26
 FQd7ldAiQR/IhbNWjVpmu1S9olWSOGqY/6MdQ01EyobziIGpgLwmR4fHqA0HyJRG
 uy/6HjN97cdlVFOBVKltbbnyiBskwPB6dlD79aMGOwp49WwPEhlBr27nk7Wo2mzW
 Oq1FUQIs89Qkj2LcydLInigoLR6UwUu92d2/RKMVPL8L/zcKGt+PkLiOT/h0X1z8
 iF3M8sC5MsmTvOXTHjDTsgLVPpy2ELk6Pic8w6kqOgUOl7ynftXN9OjWn6eHcOK8
 LJ9UrA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms1b65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so966831eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720252; x=1793325052; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iBrFR+0sk5zM8kbC7Z+VhEbrVionSXwnGjPep2Z4hWw=;
 b=js+cqLzDJUJ/49pOK28WSJwy3/Zh1w+7M88HBZx1EHg9Ls2cUP3BxG/Noy33GAHDre
 Qqw5lUfP4Rse4lLF3xXXHgEZvdEXZ/JLg4lxl0E0/xgJqoLs2Exgek3qohXSu+GAoPQ6
 oq4RBwzU4eDobeq03NsiAAnGZsELlKbAfQvpshMQUYne92FEsFuzcz+3dz8G40sdV9NK
 eM93PbPXd6X3aT1L6OTyoZGk8YTFx/u/1SOVSDd5w+MQEWFby1I3DSji2hJTc/IC1scL
 hHjN8eVrvvGRl+YgyML5aJQGAVcQ2fxPoC6T2Od82rM/sns7Wt7TAv9pUaqbflFRZS23
 MZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720252; x=1793325052;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iBrFR+0sk5zM8kbC7Z+VhEbrVionSXwnGjPep2Z4hWw=;
 b=wGjapezf4f9Q5pCtSA5KzLPMJybo835a81VZWkyGyIeRz1WO+ZVQoXO3V1pk/u7l52
 pT6X4j6uapZjSZPU4jIhmXFOfyAIyYIhARgMNay1CxcukE8pOQdDQr+tKGYsf33GkQlU
 g6XbCeWPbQSyiOVPmMhLisIDMuqhZYJSbpFw7qK7g22fLa7ZsaprLi67N9iflVrJwmdc
 PE57I6H6KnubnQvSOqwX+eH3n8VqUCwV6t904xKRJB9E5hqZ+kYjnji7/lz+Il/8Di2f
 Nr03BBSprsrIWd3py6+xgcKmP69r1fJ1p0ffNv/nmP+lnDoyH0rUBcueoECGDytKYDau
 wQBw==
X-Gm-Message-State: AFq9FYJajcoe9OX8jn69vPgiSVx5g4o1p4cr83DCMIJ+HoE6hLJMf69o
 V5GbyZWrI8gsbzyS7sf/h/esORqkbAnzmNnkyXnRJ+gfxkpLagxFoIWJbWa1AbboAtPWLU9uzuz
 ZBMWvSl4ziFPVrnD9LYOkLyEc54uRnD49vvDMer4YqchdnAXeJdJc1NIM0ZD01EfxUQ==
X-Gm-Gg: AYBFou1BEsCkX6RU6YIQQJehXV4y9lytSybDNAMaO89OwF50VE+zK/z+6i+kicyHSzB
 8WqZW8DYV+A9+hg+3/8YE27k3VYT3PdVe1LqNdcStWnLgoI+L30/5clGAw5PZArcWPziafhuEH5
 +bNjoclJVIXsod/84hEp7aP4np/X+/PZtMRiT5riXE6W+Bdo9Ai73kY/mVxX4eKzUC6DCSkkSae
 BkLbG1Tt7WI8Yu5W8/LO16LDCi4alIq+Kqnx+VhVILx7hiULGtr/zfjIcxzI8PL+iZTU9zxTAqD
 msAsj4NPxDko1FmhISQWrVSlXIwA17SnxRHGYVYwBHzvZXqJj+jVy+f/CHHpP2A35CdxgYMAlGI
 wNB3S12GRZ8I2gIUzCGiC2n5wvJFAdL84r1zPK7qoWnUmRkSH
X-Received: by 2002:a05:7301:6196:20b0:354:1db3:674e with SMTP id
 5a478bee46e88-369d97cdffbmr1067241eec.6.1792720251957; 
 Thu, 22 Oct 2026 18:50:51 -0700 (PDT)
X-Received: by 2002:a05:7301:6196:20b0:354:1db3:674e with SMTP id
 5a478bee46e88-369d97cdffbmr1067223eec.6.1792720251355; 
 Thu, 22 Oct 2026 18:50:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:50:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/43] target/hexagon: fix the allocframe framekey
Date: Thu, 22 Oct 2026 18:50:01 -0700
Message-Id: <20261023015040.2473105-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX8sw9srqijdir
 +SoYCmLJgeFN8r1rrAdqkBObV3Tx2uSJ7rAufpNpQre9pfshxbGPkQUG9HhC8HurOgQLU8gh4K0
 7HE4GK5F+NBcbJrRVNpYm0At28yR36ZZfVc0uCqN6IS/EHSikoy0TbvxI0x+QHeIkX5BEc8O3Zi
 k930l2/DwJBo9lsVJB/lDhQ5pilf4XVnAJT0jQA6rVJ+ai7MCXYhIRjlWdOEuvFT3CSSRyk9mVC
 GpUNE2kwxO6phczsdO50OCqAHx8jn8o0LbgITdtk9dfc7Cf/7Po4OPB+lxTIteV1AI+3l9j+ibO
 8MUUbRbRhrAUxIK/u8QDbt9t7I+5HdXBclO6YwoMIYI4a3NgvEvacLEeob7F1F7XGO3udZGuLiz
 0KgpGbEtU7x/bhL1VWOJILp+gfcKNwYKctWA7pwd4M/06hWhk5PNrzKxwc7yWr43labziWBZQGo
 q3WjwHNsd+IIXGw9ztw==
X-Proofpoint-GUID: 8QEHi4n1EdQ2lUkfKrVJvCb9FhjHvv4W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX2/Ckd/qxxD7p
 pQLTMSs3Buye/F4HqL/GEJ+bhyzWtLF7tW2EcCjsSJFyOHABle1+IhHImR6+700jfHKcJsPekoY
 95Ss1FuMDOE9jnEv+jCDjT/rw1jI8kw=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adabd7c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=C52g3mIZ0U6sDkJ2YRgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 8QEHi4n1EdQ2lUkfKrVJvCb9FhjHvv4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
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

VGhlIGZyYW1lIHRoYXQgYWxsb2NmcmFtZSBwdXNoZXMgaXMge0xSLCBGUH0sIGFuZCB3aGF0IGlz
IHNjcmFtYmxlZCBpcwp0aGUgTFIgd29yZDogRlJBTUVLRVkgaXMgWE9SJ2QgaW50byB0aGUgdXBw
ZXIgMzIgYml0cy4gIFRoZSBnZW5lcmF0ZWQKY29kZSBmb3IgZkZSQU1FX1NDUkFNQkxFIGJ1aWx0
IHRoZSBrZXkgZnJvbSBGUkFNRUtFWSBpbiBib3RoIGhhbHZlcyBvZgphIDY0LWJpdCB2YWx1ZSwg
c28gaXQgc2NyYW1ibGVkIEZQIGFzIHdlbGwuICBkZWFsbG9jZnJhbWUgYW5kCmRlYWxsb2NfcmV0
dXJuIG9ubHkgdW5kbyB0aGUgdXBwZXIgd29yZCwgc28gYSBGUCByZXN0b3JlZCBmcm9tIGEgZnJh
bWUKcHVzaGVkIHdpdGggYSBub24temVybyBGUkFNRUtFWSB3YXMgY29ycnVwdC4KClVuY292ZXJl
ZCBieSB0ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKaW5kZXggMTRjN2ZjYmM2NTQuLjVkNTc5MjkzNDc3IDEw
MDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL2ZyYW1la2V5LmMKQEAgLTEyLDQyICsxMiw1NSBAQCBpbnQgZXJyOwogI2luY2x1ZGUg
ImhleF90ZXN0LmgiCiAKIC8qCi0gKiBhbGxvY2ZyYW1lIHB1c2hlcyB7TFIsIEZQfSwgc2NyYW1i
bGluZyBMUiB3aXRoIEZSQU1FS0VZLiAgUmV0dXJuIHRocm91Z2gKLSAqIGRlYWxsb2NfcmV0dXJu
IGFuZCByZXBvcnQgdGhlIEZQIHRoYXQgaXQgcmVzdG9yZXMuCisgKiBhbGxvY2ZyYW1lIHB1c2hl
cyB7TFIsIEZQfSwgc2NyYW1ibGluZyBMUiB3aXRoIEZSQU1FS0VZLCBhbmQgZGVhbGxvY2ZyYW1l
CisgKiByZXN0b3JlcyB0aGVtLiAgUHVzaCBhIGZyYW1lIGFuZCByZXR1cm4gdGhlIHdvcmRzIHRo
YXQgd2VyZSBzdG9yZWQsIEZQCisgKiB0aHJvdWdoIHRoZSByZXR1cm4gdmFsdWUgYW5kIExSIHRo
cm91Z2ggQGxyX3N0b3JlZCwgYW5kIHRoZSBGUCBhbmQgTFIKKyAqIHRoYXQgZGVhbGxvY2ZyYW1l
IHJlc3RvcmVzLgogICovCi1zdGF0aWMgaW5saW5lIHVpbnQzMl90IGZyYW1lX3JvdW5kdHJpcCh1
aW50MzJfdCBrZXksIHVpbnQzMl90IGZwKQorc3RhdGljIGlubGluZSB1aW50MzJfdCBmcmFtZV9y
b3VuZHRyaXAodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGxyLCB1aW50MzJfdCAqbHJfc3RvcmVkLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmZwX2JhY2ssIHVp
bnQzMl90ICpscl9iYWNrKQogewotICAgIHVpbnQzMl90IGZwX2JhY2ssIHNhdmVkX2ZwLCBzYXZl
ZF9scjsKKyAgICB1aW50MzJfdCBmcF9zdG9yZWQsIHNhdmVkX2ZwLCBzYXZlZF9scjsKIAogICAg
IGFzbSB2b2xhdGlsZSgiJVtzYXZlZF9mcF0gPSByMzBcblx0IgogICAgICAgICAgICAgICAgICAi
JVtzYXZlZF9scl0gPSByMzFcblx0IgogICAgICAgICAgICAgICAgICAiZnJhbWVrZXkgPSAlW2tl
eV1cblx0IgogICAgICAgICAgICAgICAgICAicjMwID0gJVtmcF1cblx0IgotICAgICAgICAgICAg
ICAgICAicjMxID0gIyMxZlxuXHQiCisgICAgICAgICAgICAgICAgICJyMzEgPSAlW2xyXVxuXHQi
CiAgICAgICAgICAgICAgICAgICJhbGxvY2ZyYW1lKCMwKVxuXHQiCisgICAgICAgICAgICAgICAg
ICIlW2ZwX3N0b3JlZF0gPSBtZW13KHIzMClcblx0IgorICAgICAgICAgICAgICAgICAiJVtscl9z
dG9yZWRdID0gbWVtdyhyMzAgKyAjNClcblx0IgogICAgICAgICAgICAgICAgICAicjMxID0gIzBc
blx0IgotICAgICAgICAgICAgICAgICAiZGVhbGxvY19yZXR1cm5cblx0IgotICAgICAgICAgICAg
ICAgICAiMTpcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY2ZyYW1lXG5cdCIKICAgICAg
ICAgICAgICAgICAgIiVbZnBfYmFja10gPSByMzBcblx0IgorICAgICAgICAgICAgICAgICAiJVts
cl9iYWNrXSA9IHIzMVxuXHQiCiAgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVbemVyb11c
blx0IgogICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1cblx0IgogICAgICAgICAg
ICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKLSAgICAgICAgICAgICAgICAgOiBbZnBfYmFj
a10gIj0mciIoZnBfYmFjayksCisgICAgICAgICAgICAgICAgIDogW2ZwX3N0b3JlZF0gIj0mciIo
ZnBfc3RvcmVkKSwgW2xyX3N0b3JlZF0gIj0mciIoKmxyX3N0b3JlZCksCisgICAgICAgICAgICAg
ICAgICAgW2ZwX2JhY2tdICI9JnIiKCpmcF9iYWNrKSwgW2xyX2JhY2tdICI9JnIiKCpscl9iYWNr
KSwKICAgICAgICAgICAgICAgICAgICBbc2F2ZWRfZnBdICI9JnIiKHNhdmVkX2ZwKSwgW3NhdmVk
X2xyXSAiPSZyIihzYXZlZF9scikKLSAgICAgICAgICAgICAgICAgOiBba2V5XSAiciIoa2V5KSwg
W2ZwXSAiciIoZnApLCBbemVyb10gInIiKDApCisgICAgICAgICAgICAgICAgIDogW2tleV0gInIi
KGtleSksIFtmcF0gInIiKGZwKSwgW2xyXSAiciIobHIpLCBbemVyb10gInIiKDApCiAgICAgICAg
ICAgICAgICAgIDogIm1lbW9yeSIsICJmcmFtZWtleSIpOwotICAgIHJldHVybiBmcF9iYWNrOwor
ICAgIHJldHVybiBmcF9zdG9yZWQ7CiB9CiAKLXN0YXRpYyB2b2lkIGNoZWNrX2ZyYW1lKHVpbnQz
Ml90IGtleSwgdWludDMyX3QgZnApCitzdGF0aWMgdm9pZCBjaGVja19mcmFtZSh1aW50MzJfdCBr
ZXksIHVpbnQzMl90IGZwLCB1aW50MzJfdCBscikKIHsKLSAgICBjaGVjazMyKGZyYW1lX3JvdW5k
dHJpcChrZXksIGZwKSwgZnApOworICAgIHVpbnQzMl90IGxyX3N0b3JlZCwgZnBfYmFjaywgbHJf
YmFjazsKKworICAgIC8qIE9ubHkgTFIgaXMgc2NyYW1ibGVkLCBGUCBpcyBzdG9yZWQgYXMgaXMg
Ki8KKyAgICBjaGVjazMyKGZyYW1lX3JvdW5kdHJpcChrZXksIGZwLCBsciwgJmxyX3N0b3JlZCwg
JmZwX2JhY2ssICZscl9iYWNrKSwgZnApOworICAgIGNoZWNrMzIobHJfc3RvcmVkLCBsciBeIGtl
eSk7CisgICAgY2hlY2szMihmcF9iYWNrLCBmcCk7CisgICAgY2hlY2szMihscl9iYWNrLCBscik7
CiB9CiAKIGludCBtYWluKCkKIHsKLSAgICBjaGVja19mcmFtZSgwLCAweDEyMzRmZmYwKTsKLSAg
ICBjaGVja19mcmFtZSgweGYyMWYyMGEwLCAweDEyMzRmZmYwKTsKKyAgICBjaGVja19mcmFtZSgw
LCAweDEyMzRmZmYwLCAweDU2NzhhYmNjKTsKKyAgICBjaGVja19mcmFtZSgweGYyMWYyMGEwLCAw
eDEyMzRmZmYwLCAweDU2NzhhYmNjKTsKIAogICAgIHB1dHMoZXJyID8gIkZBSUwiIDogIlBBU1Mi
KTsKICAgICByZXR1cm4gZXJyOwotLSAKMi4zNC4xCgo=

