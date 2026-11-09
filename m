Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70777606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iQs4hSbO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fUfqkVBl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW18-0003YG-2p; Mon, 09 Nov 2026 15:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0f-0003Q2-I7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0b-0007IZ-GT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:33 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHNUO899784
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sRtvnKv400vEameoQRJ33TnxrjTDXZ8FFaT4zrc3vEw=; b=iQs4hSbOFtLLVMbr
 X5sdFiQqAJFCQOA00ekBIKQUD56oxhuCL1Uoa4cZ15hloIw1Zt55hqwJ4s09SrMW
 fFaql4eh3xhq6Nr4mCKcBrGO4VASK8MVgueMIvU+YF1mymp4KIu1meTBUFsgv5KQ
 Ux8t7cjDctmYUI7ITyPsR3/V1rMemRxjMlwoVgTz+86+LPu6reQLk3jtvPkU3ztt
 Z677c5y5LBwBfHE3mXertDBCbv0DN/dhbPddFsiPov4O8kzvQW844w/h6Z5XiLwG
 k+wKcsLfNtXiRbBt+L7mv2ImRezJcQfW0B29/WtqVuwU30XncIHCAlF0wsxhBbYt
 QOXUqQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2kegp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:30:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2378529eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256227; x=1794861027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sRtvnKv400vEameoQRJ33TnxrjTDXZ8FFaT4zrc3vEw=;
 b=fUfqkVBl3bHxCyPU8wqHQwR+e4w9vfZ6eQDnMvxeXc91v5Mn6DPLk5B8dfuz7GUsOa
 hhGBplm9kvKLN+7H+qOIwMzc/ggFah0Iym2+Q10CyyBFxRAnFjYPVNiB77jrrE5FQtmD
 C6Z9p57dsP/qYpY+jdgSotJTgsAPcEvwRGm54VLjpVfERKKDV0Zui1oHmvFVXVFSNVLP
 0LrVwnxA7tA2afnq/4ztnUwaLdT8IBzt7tPDfr+50nNmcYCdzsqN990MbG/at9W6IxoQ
 WHWVzGZHyp09YQIO/Hy/3wC0vjeR/skOKlyNSU1pyBS2/P+hl/hxrFKWiU98DZsm8cvE
 RICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256227; x=1794861027;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sRtvnKv400vEameoQRJ33TnxrjTDXZ8FFaT4zrc3vEw=;
 b=CyPbjEM/SzE3vJVfH/CErX/75k6aVR2ebH2maIwE+17uuWu075tvYVFgx3WaQL0Hu8
 zoHNHp7e/8lne5UijCayZbHcU4thA0VtWW0mev6zZEyEFegAXwiW+QUy6/01fat588Eq
 Y9RKrAVRozsyGvDy5JUnaOrc6zGuQQIQUUEZyVvsa0fAWfjWoY3Tpr9pCKoem8JD1XWg
 +7GKl/KJvsWjrg3vfB8u+pvhckkq0jTz0RihQPmdeQ/ZP2VyAoYSSAqdh7WQkp5GuTsS
 L8vcdofEGTNIZzOqdFvdpEfNQ42Oq5i4u4dSF362lQBSvEd1YGYjHaTu4oERFmzKJvmE
 K6WQ==
X-Gm-Message-State: APuU4Z/ShYefIDSXVDu96kmka78fw61EeB6fChCbFjXO5vyQeMFH7fwH
 cN0M5pFh0c+ToHEABEiqS6Ej9jWsbCculXLcV1uWIqe2Sx1iJoQbnAYHo8NZgACD1YxysxQOQLE
 hEKmQLo0YMr/o9z2WKoXyQk0SsSBUA6S+KBtm+1VNcgvTbrqxpXwkF6FMo0URatKq1A==
X-Gm-Gg: AYBFou1E7ANwXVXOyVxJw9J4AqTl6Q6afEAVRQwd3vuiKZ8n9+OOe/A/5yo3klA748G
 K752eihDjZzE3yR+XNqKRifidhPW3kaxXGGIpsU2CUEtAitJKJ9zwOMfAKTodSILsgMF1HbrUuB
 Y1m6jjH4PMSqLlb+5WizpALXJ8ETTenjIyjFF43FC+9t+zwKHQ0jfcTJZQJ9E+xQwfB8A42ZFx0
 Hp+9C1fnuPfJp7t5uPaoueacDuaCbStbJ/YI+a6bUg/VIQFgPe/+KFvbf7BVPSe84oqNdzTMURx
 4tXvpl0vHxP64MIikHP5a2RTk4JkNgeHpdpbDN/+rl+M5S+5C0bCA0052YsTHXAnD0wTxQiup5D
 dUxcdaAMcZJ5w+PYYbySNOAcc2yxDD+i2gG5HGdA/8gmVVNUCVLJkzk60j/PC6Cu/U82VkWsS3t
 Z+CIl1OMZNTJDHayFMU4Md
X-Received: by 2002:a05:7300:ed0e:b0:36d:2b02:86a6 with SMTP id
 5a478bee46e88-3751c63a111mr692665eec.4.1794256226379; 
 Mon, 09 Nov 2026 12:30:26 -0800 (PST)
X-Received: by 2002:a05:7300:ed0e:b0:36d:2b02:86a6 with SMTP id
 5a478bee46e88-3751c63a111mr692556eec.4.1794256225210; 
 Mon, 09 Nov 2026 12:30:25 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm823737eec.14.2026.11.09.12.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:30:24 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 5/5] docs/system/hexagon: describe integrated firmware OS
 boot paths
Date: Mon,  9 Nov 2026 12:30:17 -0800
Message-Id: <20261109203017.262225-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
References: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af22d64 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DCEdGjf_N-zXLgs_qoUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX2bT34ubtgkYt
 OwGP08K4juRF+GdpvWokbojRDVGWQx/mMacG+S2ROH6iIRXp9rlF5ONpCX522VO00v4VO1KTe5E
 r5SwtJAyN8kwNK1y1IW2Whuql9soUxBy37Ft4KNep5gilT32dUsKWewMbzuuSPsMMoiw/EZKMzO
 2q8Lux1tntYzH+H3QDesJ4VCvgKKXWPwZP9feB4Mz2HtZWRzAM/mIRSgg0p/2q5eEA885IpVp8i
 T8z0esManCjOAgXhu1sdcth+x1XS2K+cJjrMqI9oENr87UqlTu+0DjocGr9DMniokhVy9XiJpZk
 kqxDy3RuC3cInn+UT0zgD9ZiLlHegtjmeAmeOblLJpqBiXdPIgcUmGj/psRF1wz1wX6NpQrdmgc
 zAdcPUFDpACbSwIvsKnwPLcLpCX6tLeMKN3YK+BDibyYH8Zen15G4MlOhgoy64jbGl3ZTSO+NaJ
 W5d+r7T4CyOQ03SH0LQ==
X-Proofpoint-GUID: f7Xi30Y-T-Jv93T8LPifdwH38A8J-hlR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX/pjzPRy4YfYS
 cvyuYHUA/CCo7Zy1sM1fR6vdkKvOSCxlnt2QhRAEedJ2TDCNDvpOV5g1YkRIg3R0XTTw8B+4n/o
 ymZEI2Sfs52QJ2Uwlr4+uBCBnDkg0LI=
X-Proofpoint-ORIG-GUID: f7Xi30Y-T-Jv93T8LPifdwH38A8J-hlR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090081
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

U2hvdyBob3cgdG8gYm9vdCBhIExpbnV4IGd1ZXN0IHdpdGggdGhlIGhleGFnb25fbG9hZGxpbnV4
IGZpcm13YXJlLCBhbmQKaGV4YWdvbl9ib290ZXIgZm9yIHJ1bm5pbmcgaDIgdXNlciBwcm9ncmFt
cy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2Jvb3QucnN0ICAgICAgICAgICAg
ICB8IDE4ICsrKystLS0tLQogZG9jcy9zeXN0ZW0vaGV4YWdvbi9vcGVyYXRpbmctc3lzdGVtcy5y
c3QgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFn
b24ucnN0ICAgICAgICAgICAgfCAxMiArKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5c3RlbS9o
ZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zLnJzdAoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hl
eGFnb24vYm9vdC5yc3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2Jvb3QucnN0CmluZGV4IDM2YzYw
M2M2OWUwLi44MGVhYWM5OWM3OSAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9ib290
LnJzdAorKysgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2Jvb3QucnN0CkBAIC00MSw4ICs0MSw4IEBA
IFRoZSB2aXJ0IG1hY2hpbmUKIHN0YXJ0cyBleGVjdXRpbmcgdGhlcmUuCiAKIGBgLWJpb3NgYCB3
aXRoIGBgLWtlcm5lbGBgIGJvb3RzIHRoZSBrZXJuZWwgdGhyb3VnaCBIZXhhZ29uIFZNIGhvc3QK
LWZpcm13YXJlLCBhcyBkZXNjcmliZWQgaW4gOnJlZjpgaGV4YWdvbi12bS1ib290YC4gVGhlIGtl
cm5lbCB3aW5kb3cgc3RhcnRzCi1hdCBgYDB4YTAwMDAwMDBgYC4KK2Zpcm13YXJlLCBhcyBkZXNj
cmliZWQgaW4gOnJlZjpgaGV4YWdvbi12bS1ib290YC4gQm90aCBFTEYgaW1hZ2VzIGxvYWQgYXQK
K3RoZWlyIGRlY2xhcmVkIHBoeXNpY2FsIGFkZHJlc3Nlcy4KIAogT3RoZXJ3aXNlLCBndWVzdCBz
b2Z0d2FyZSByZWFkcyB0aGUgZ2VuZXJhdGVkIERUQiBhdCBgYDB4OTk4MDAwMDBgYC4KIGBgLWFw
cGVuZGBgIHNldHMgaXRzIGBgL2Nob3Nlbi9ib290YXJnc2BgIHByb3BlcnR5LgpAQCAtODAsMTMg
KzgwLDEzIEBAIEJvb3RpbmcgYSBrZXJuZWwgdGhyb3VnaCBIZXhhZ29uIFZNIGhvc3QgZmlybXdh
cmUKIAogT24gdGhlIGBgdmlydGBgIGFuZCBib2FyZC1zcGVjaWZpYyBtYWNoaW5lcywgYGAtYmlv
c2BgIHdpdGggYGAta2VybmVsYGAKIHN0YXJ0cyB0aGUga2VybmVsIHRocm91Z2ggSGV4YWdvbiBW
TSBob3N0IGZpcm13YXJlLiBRRU1VIGxvYWRzIHRoZSBmaXJtd2FyZQotRUxGIGFzIGxpbmtlZCBh
bmQgYWRkcyB0aGUgbWFjaGluZSdzIGtlcm5lbCBiYXNlIHRvIHRoZSBrZXJuZWwgRUxGJ3MKLXBo
eXNpY2FsIGxvYWQgYWRkcmVzc2VzLCBzbyB0aGUga2VybmVsJ3MgYWRkcmVzc2VzIGFyZSByZWxh
dGl2ZSB0byB0aGUKLXN0YXJ0IG9mIGl0cyB3aW5kb3cuIFRoZSBrZXJuZWwgbXVzdCB1c2UgdGhl
IGNvcnJlc3BvbmRpbmcgSGV4YWdvbiBWTQotZ3Vlc3QgbGF5b3V0LiBRRU1VIHN0YXJ0cyB0aHJl
YWQgemVybyBhdCBhIGJvb3Qgc3R1YiBhdCBgYDB4OTljMDAwMDBgYC4KLVRoZSBzdHViIHBhc3Nl
cyB0aGUgRFRCIGFkZHJlc3Mgd2l0aCB0aGUgbG93IHdvcmQgaW4gYGByMGBgIGFuZCB0aGUgaGln
aAotd29yZCBpbiBgYHIxYGAsIHRoZW4ganVtcHMgdG8gdGhlIGZpcm13YXJlJ3MgRUxGIGVudHJ5
IHBvaW50LiBUaGUgSGV4YWdvbgotVk0gaG9zdCBkZWZpbmVzIHRoZSBjaGlsZCBWTSdzIHJlZ2lz
dGVyIGFuZCBleGVjdXRpb24gc3RhdGUuCitFTEYgYXMgbGlua2VkLiBPbiBgYHZpcnRgYCwgaXQg
YWxzbyBsb2FkcyB0aGUga2VybmVsIEVMRiBhcyBsaW5rZWQuIFRoZQorYm9hcmQtc3BlY2lmaWMg
bWFjaGluZXMgYWRkIHRoZWlyIGNvbmZpZ3VyZWQga2VybmVsIGJhc2UgdG8gdGhlIGtlcm5lbCBF
TEYncworcGh5c2ljYWwgbG9hZCBhZGRyZXNzZXMsIHNvIHRob3NlIGtlcm5lbHMgYXJlIHJlbGF0
aXZlIHRvIHRoZSBzdGFydCBvZiB0aGUKK2JvYXJkJ3MgZ3Vlc3Qgd2luZG93LiBRRU1VIHN0YXJ0
cyB0aHJlYWQgemVybyBhdCBhIGJvb3Qgc3R1YiBhdAorYGAweDk5YzAwMDAwYGAuIFRoZSBzdHVi
IHBhc3NlcyB0aGUgRFRCIGFkZHJlc3Mgd2l0aCB0aGUgbG93IHdvcmQgaW4gYGByMGBgCithbmQg
dGhlIGhpZ2ggd29yZCBpbiBgYHIxYGAsIHRoZW4ganVtcHMgdG8gdGhlIGZpcm13YXJlJ3MgRUxG
IGVudHJ5IHBvaW50LgorVGhlIEhleGFnb24gVk0gaG9zdCBkZWZpbmVzIHRoZSBjaGlsZCBWTSdz
IHJlZ2lzdGVyIGFuZCBleGVjdXRpb24gc3RhdGUuCiAKIFFFTVUgcGxhY2VzIHRoZSBEVEIgYWZ0
ZXIgdGhlIGxvYWRlZCBrZXJuZWwuICBRRU1VIGNvcGllcyBpdCB0byBndWVzdCBSQU0KIGJlZm9y
ZSBlbnRlcmluZyB0aGUgZmlybXdhcmUuIEFuIG9wdGlvbmFsIGBgLWluaXRyZGBgIGlzIHBsYWNl
ZApkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9vcGVyYXRpbmctc3lzdGVtcy5yc3Qg
Yi9kb2NzL3N5c3RlbS9oZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zLnJzdApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uYzY0YWYyOGUxZjUKLS0tIC9kZXYvbnVsbAorKysg
Yi9kb2NzL3N5c3RlbS9oZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zLnJzdApAQCAtMCwwICsxLDQ4
IEBACisuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitCb290
aW5nIGd1ZXN0IG9wZXJhdGluZyBzeXN0ZW1zCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09CisKK0hleGFnb24gVk0gZ3Vlc3RzIHJlcXVpcmUgYSBIZXhhZ29uIFZNIGhvc3QuIFFFTVUg
c2hpcHMgYm9hcmQtc3BlY2lmaWMKK2hvc3QgZmlybXdhcmUgaW4gYGBwYy1iaW9zYGAuIEd1ZXN0
IG9wZXJhdGluZyBzeXN0ZW1zIGJvb3Qgd2l0aCB0aGUKK2BgaGV4YWdvbl9sb2FkbGludXhfKmBg
IGltYWdlczsgdGhlIGBgaGV4YWdvbl9ib290ZXJfKmBgIGltYWdlcyBydW4gSDIKK3VzZXIgcHJv
Z3JhbXMgaW5zdGVhZCAoc2VlIDpkb2M6YGNkc3BgKS4gU2VsZWN0IGEgbWF0Y2hpbmcgbWFjaGlu
ZSwKK2Zpcm13YXJlLCBhbmQgZ3Vlc3QgbWVtb3J5IGxheW91dCBmcm9tIDpkb2M6YGNkc3BgLgor
CitMaW51eAorLS0tLS0KKworVGhlIGtlcm5lbCBtdXN0IGJlIGJ1aWx0IGZvciB0aGUgSGV4YWdv
biBWTSBpbnRlcmZhY2UgYW5kIGluY2x1ZGUgdGhlCitQTDAxMSBjb25zb2xlIGFuZCByZXF1aXJl
ZCB2aXJ0aW8tbW1pbyBkZXZpY2UgZHJpdmVycy4KKworRm9yIGEgcHJlbG9hZGVkIGtlcm5lbCBh
bmQgc2VwYXJhdGUgaW5pdHJhbWZzOgorCisuLiBjb2RlLWJsb2NrOjogc2gKKworICAgIHFlbXUt
c3lzdGVtLWhleGFnb24gLU0gcWNzNjQ5MC1jZHNwIC1kaXNwbGF5IG5vbmUgLXNlcmlhbCBzdGRp
byBcCisgICAgICAgIC1iaW9zIGhleGFnb25fbG9hZGxpbnV4X3FjczY0OTBfY2RzcCBcCisgICAg
ICAgIC1rZXJuZWwgLi92bWxpbnV4IC1pbml0cmQgLi9pbml0cmFtZnMuY3Bpby5neiBcCisgICAg
ICAgIC1hcHBlbmQgImNvbnNvbGU9dHR5QU1BMCByZGluaXQ9L2luaXQiCisKK2BgdHR5QU1BMGBg
IHNlbGVjdHMgdGhlIFBMMDExIGNvbnNvbGUuIGBgLWFwcGVuZGBgIHNldHMgdGhlIGJvb3QgYXJn
dW1lbnRzCitpbiBRRU1VJ3MgRFRCOyB0aGUgZ3Vlc3QgYW5kIGl0cyBWTSBob3N0IGRldGVybWlu
ZSBob3cgdGhvc2UgYXJndW1lbnRzCithcmUgY29uc3VtZWQuIEFkZCBhbnkgcGxhdGZvcm0tc3Bl
Y2lmaWMgbWVtb3J5IG9yIGRlbGF5LWNhbGlicmF0aW9uCitwYXJhbWV0ZXJzIHJlcXVpcmVkIGJ5
IHRoZSBrZXJuZWwgaW1hZ2UuCisKK0d1ZXN0IG9wZXJhdGluZyBzeXN0ZW1zIG9uIHZpcnQKKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK1RoZSBgYHZpcnRgYCBtYWNoaW5lIGJv
b3RzIGEgZ3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbSB0aHJvdWdoIHRoZSBzYW1lCitmaXJtd2FyZToK
KworLi4gY29kZS1ibG9jazo6IHNoCisKKyAgICBxZW11LXN5c3RlbS1oZXhhZ29uIC1NIHZpcnQg
LWRpc3BsYXkgbm9uZSAtc2VyaWFsIHN0ZGlvIFwKKyAgICAgICAgLWJpb3MgaGV4YWdvbl9sb2Fk
bGludXhfc2E4Nzc1cF9jZHNwIFwKKyAgICAgICAgLWtlcm5lbCAuL2d1ZXN0LmVsZiAtYXBwZW5k
ICJjb25zb2xlPXR0eUFNQTAiCisKK1FFTVUgbG9hZHMgdGhlIGd1ZXN0IEVMRiBhdCBpdHMgZGVj
bGFyZWQgcGh5c2ljYWwgYWRkcmVzc2VzLiBRRU1VIGVudGVycwordGhlIGZpcm13YXJlIHdpdGgg
dGhlIERUQiBhZGRyZXNzIGluIGBgcjE6cjBgYCAoc2VlCis6cmVmOmBoZXhhZ29uLXZtLWJvb3Rg
KS4gVGhlIGd1ZXN0IG11c3QgdXNlIHRoZSBIZXhhZ29uIFZNIGludGVyZmFjZSBmb3IKK2ludGVy
cnVwdHMgYW5kIHRpbWVycywgdGhlIFBMMDExIGF0IGBgMHgxMDAwMDAwMGBgLCBhbmQgdGhlIHZp
cnRpby1tbWlvCit0cmFuc3BvcnRzIGxpc3RlZCBpbiA6ZG9jOmBtYWNoaW5lc2AuCmRpZmYgLS1n
aXQgYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgYi9kb2NzL3N5c3RlbS90YXJnZXQt
aGV4YWdvbi5yc3QKaW5kZXggZGFjOGI5YjM0ODMuLjNiNjNhOTRlYjU2IDEwMDY0NAotLS0gYS9k
b2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CkBAIC0xMDUsMTEgKzEwNSwyMyBAQCBndWVzdCBzb2Z0d2FyZSBjYW4gYWNjZXNz
IHRoZSBob3N0IGNvbnNvbGUgYW5kIGZpbGVzeXN0ZW0uIFJlYWQgdGhlCiBmb3IgZGV0YWlscy4g
U2VtaWhvc3RpbmcgaXMgZW5hYmxlZCBieSBkZWZhdWx0IG9uIGhleGFnb24tc2ltLWNvbXBhdGli
bGUKIG1hY2hpbmVzLiBUaGlzIGNhbiBiZSBmdXJ0aGVyIGNvbmZpZ3VyZWQgdGhyb3VnaCBgYC1z
ZW1paG9zdGluZy1jb25maWdgYC4KIAorSGV4YWdvbiBWTSBob3N0CistLS0tLS0tLS0tLS0tLS0K
KworR3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbXMgY2FuIHJ1biB1bmRlciBhIEhleGFnb24gVk0gaG9z
dCwgd2hpY2ggcHJvdmlkZXMKK3ZpcnR1YWwgcHJvY2Vzc29yLCBtZW1vcnkgbWFuYWdlbWVudCwg
aW50ZXJydXB0LCBhbmQgdGltZXIgc2VydmljZXMuCitUaGUgYEhleGFnb24gVmlydHVhbCBNYWNo
aW5lIFNwZWNpZmljYXRpb24KKzxodHRwczovL2RvY3MucXVhbGNvbW0uY29tL2RvYy84MC1OQjQx
OS0zLzgwLU5CNDE5LTNfUkVWX0FfSGV4YWdpbl9WaXJ0dWFsX01hY2hpbmVfU3BlY2lmaWNhdGlv
bi5wZGY+YF9fCitkZXNjcmliZXMgdGhlIGd1ZXN0IGludGVyZmFjZS4gVGhlIE9TIGJvb3QgZXhh
bXBsZXMgaW4KKzpkb2M6YGhleGFnb24vb3BlcmF0aW5nLXN5c3RlbXNgIHVzZSBIMiBhcyB0aGUg
SGV4YWdvbiBWTSBob3N0OyBRRU1VCitlbXVsYXRlcyB0aGUgdW5kZXJseWluZyBEU1AgaGFyZHdh
cmUuCisKIC4uIHRvY3RyZWU6OgogICAgOmNhcHRpb246IEhleGFnb24gZG9jdW1lbnRhdGlvbgog
CiAgICBoZXhhZ29uL21hY2hpbmVzCiAgICBoZXhhZ29uL3Nkay1wcm9ncmFtcwogICAgaGV4YWdv
bi9ib290CisgICBoZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zCiAgICBoZXhhZ29uL2VtdWxhdGlv
bgogICAgaGV4YWdvbi9jZHNwCi0tIAoyLjM0LjEKCg==

