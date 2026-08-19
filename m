Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF74C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9v-0008LO-UA; Tue, 18 Aug 2026 21:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9u-0008Ku-DN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9s-0008DU-Jk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkRWc2278847
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x6XGLZ0WeMKrqVTiytLRtFXKuMZvq+QURVKSw4E61Es=; b=EV0y+nfxRBz/ZZHM
 1EmJq/NxUwIwXF/NY8yRZ6w0TPYHiePx5hcbI9Y00ebjpmaA9xc+6fp75AihqPG6
 hW0TQJ/tcHiuibpjlVamJ65C6gekxLSwWdT5q0GXOhGg82ICvjzk1VLXk+d1995H
 aW4YYX8snCZJNfj4SoiGfsrB1V+L2leHYIj0eN574TombVdDYh3cQppP7ACnqnOt
 2nvLu4EiOYVSL2HD0i8UFXjpinaSW8LuGfy7SqFrUw3H663kUPIj3ZAxFdNRNbpb
 UeWFO1T3+eoGgglSiVheC7LnU/su7gZ5Z5oq7Z13P+ADUyHq3cJpuFNWOyghVyVD
 AJmWjA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkgrvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so819101a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103118; x=1787707918; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x6XGLZ0WeMKrqVTiytLRtFXKuMZvq+QURVKSw4E61Es=;
 b=LPUXJBtg1Feg2yxkhk68LboCbKnD8xYPXdgQN1l8RcvzGm1updH25YftXwYn+5S652
 F1cYfpD4RYp9Xjc02hZnb3VjX2Cjs11AZOOul8M5533zmG9MJ1O/m5/Cfl5WLgCkwnCp
 IB1ua9l1FIOFlyUuabBDpF3v7ZoQ9vDGzHmKjDmVhA92ePBpzRL3aTBem7YDbRuf2HCU
 t8wfIDLwoG68gQkMkA3W3zQr06SLgzveXeqPJcXLjdDKblpAqRz4+q2XhTfkEaydw9Gl
 xzc+ge14Cn0An1qStY6O8KhQOg82ivy2cb6tnYze72g6NZV4M1nuhJagh2oZlE0ZX8k6
 B8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103118; x=1787707918;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x6XGLZ0WeMKrqVTiytLRtFXKuMZvq+QURVKSw4E61Es=;
 b=a6lsrgB7Di0+SmZjtG6Q6RKc9ea8BR/ttITTv9JoBIcAgB5Tq/nZaF4WSQ6jxCyij9
 s39p3lGdw0IJ5Y7qS4djKp36+IONbXDg6v6KXO/t5+fxw68oVuDc3Wq14ip0K0wzZhUK
 TnMNkYZJbzXi3SKlZhRcnq3Q1oJahHZDQDFkbLq7CtkLNK8vO4cioGsbmoO8avDgMKah
 BMBKHSFIY8bGOSyzTe6gAJy38/Zp6cNVMuSGH+2uLDJmX5KQiY/SE/PteqCPTCaCqJEC
 T/qCQUHBc8C8DdgHsVCL9BvafyJkKWn1YMrVmnpuSweVmV28GT5LZgCR8fqokLQftpdQ
 iZMQ==
X-Gm-Message-State: AOJu0YyiQjJZmnB/HzZsC8SQUgnFjWYoaVS6Q+jZqNfNm+bfNz1KfLeY
 i+KeMFZeyE5iB1//9lR/Pn9j1Wxk+1jIZdgmBQKIw+AfsLRrLnmffUSJujqfaszXf0Lf5U+UWsT
 gX5PH5fiHILiqDvHiohKH09RCcytPZ0rwlf3R3mxDHXn0mdgi8d8d4JZpc5J+qzGZUg==
X-Gm-Gg: AR+sD13wwIpDSLHKedzRV2rbfWF31qJUlZvnrqU2GdBZwGNElZzOejdHFOKGTuuQs47
 U9xmmTPTiZYXFAwYj87wz24oj8iJ7nonuxakcTWTq97IHHuGhlTm4dtStizqgvJRn5+u6WFDIRC
 6Huog8AAWhy0FuXDJdDsHj2XI4Cnd4ZwXfI0neyLup9GSRLTaHStmjQaR9Xh91pKma9SGYqD1C6
 18UcpJCTj/tfg6k2NU0tVhajp8Wzcn1bi8hCAroAM6LcSgpH+YRdmEN/dhEpNo3kvI92P1ow4Xx
 yYhhTQU2lgASp+OlsyI+017hZ8O2hGmKSQ8qmR2okQr+2oTC0O1JvqepZT1NUWhA4fg5L0xuMhA
 VbSucFilzKNKG1XtwIBV3wv2mrSAnmT7L24AoHPpJHkCHapRK
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-39580eafaa7mr2110914a91.6.1787103118307; 
 Tue, 18 Aug 2026 18:31:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-39580eafaa7mr2110804a91.6.1787103117712; 
 Tue, 18 Aug 2026 18:31:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/11] target/hexagon: read UTIMERLO/UTIMERHI from the global
 timer
Date: Tue, 18 Aug 2026 18:31:40 -0700
Message-Id: <20260819013144.3264096-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=NoPhtcdJ c=1 sm=1 tr=0 ts=6a85078f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=q_fxtLUCAn1J2UUIEkUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: zyWCyyLnWZFfgwSy2fESvOe4aV08K2IR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXwJFMaeyhdyZj
 D5ey3332AR/5adzmeCegEyYrMDkMT+z4Myea3Qd1K/2V64JStQVSBg+B3iPuE5HbCoYk0AgzpjS
 Ktya7GNhnOcXPxx41o+ld6soAsUs9yc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX22o9eq9rnFSR
 UcVPPvFsz8+uKaYwk7zpwQOALEsxo6OSouq6lRKsBwaquosf2hWc6Z8jGW2u9878zDb7rQXRvbP
 jlSJ8X6P66wXmc5taEbcfAg6Nkp3DGU5yuYqE8tsjuUhMhRvQwC39a0+/WVLgWfQhZ1kNER8Szl
 iNGzca7/6IKMPk9Yt4qeT+eP/0oXb5aEKWDv/ZMgC4U+SfEsE5e1Pdk3fSDFb4p63v46kyG8/Fa
 cF4N/6TZomrWQxgGnJCJdKPd6CarHmkqgOCvRQ/2tHPi5CjXG7FN6OGBs4byvnKvnzCy+t8fruu
 y6UUSEDUM54wilBs0lWwGtD2Ko4GqWF+SZ/Nvot2a4MhR36YYem4YwQ+DJhsACCcpabB3a64p8g
 6qkD3IFfl3hq/kIX0b0Yj2WYVU0VXvt8TBUOGhMROoAhhSrwzAOwi/i3t5/J1/bkg1dMKCoq0A1
 GGJG+XwQAG5Pgo/JDFQ==
X-Proofpoint-GUID: zyWCyyLnWZFfgwSy2fESvOe4aV08K2IR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
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

SW4gc3lzdGVtIG1vZGUsIHJvdXRlIGFjY2Vzc2VzIHRvIHRoZSBxdGltZXItYmFja2VkIGdsb2Jh
bApUSU1FUkxPL1RJTUVSSEkgc28gZ3Vlc3QgcmVhZHMgc2VlIGEgbGl2ZSwgbW9ub3RvbmljYWxs
eSBpbmNyZWFzaW5nCnRpbWVyLgoKSW4gdXNlciBtb2RlIHdlIGRlcml2ZSBpdCBmcm9tIFFFTVVf
Q0xPQ0tfVklSVFVBTC4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICAgfCAgNCArKysr
CiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwgMjEgKysrKysrKysrKysrKysr
KysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9yZWdfbXV0LmMgfCAxMSArKysrKysrKy0tLQogNCBm
aWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKaW5k
ZXggNzhkYzI4Y2E5ZTUuLmUzOWFmZDYyM2I1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9o
ZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTEzLDYgKzExMywxMCBA
QCBERUZfSEVMUEVSX0ZMQUdTXzQoZ3ZlY19zYWJzZGlmZl93LCBUQ0dfQ0FMTF9OT19SV0csIHZv
aWQsIHB0ciwgcHRyLCBwdHIsIGkzMikKIERFRl9IRUxQRVJfRkxBR1NfNChndmVjX3VhYnNkaWZm
X2IsIFRDR19DQUxMX05PX1JXRywgdm9pZCwgcHRyLCBwdHIsIHB0ciwgaTMyKQogREVGX0hFTFBF
Ul9GTEFHU180KGd2ZWNfdWFic2RpZmZfaCwgVENHX0NBTExfTk9fUldHLCB2b2lkLCBwdHIsIHB0
ciwgcHRyLCBpMzIpCiAKKyNpZiBkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitERUZfSEVMUEVS
X0ZMQUdTXzAodXRpbWVyLCBUQ0dfQ0FMTF9OT19SV0csIGk2NCkKKyNlbmRpZgorCiAjaWYgIWRl
ZmluZWQoQ09ORklHX1VTRVJfT05MWSkKIERFRl9IRUxQRVJfMyhyYWlzZV9zdGFja19vdmVyZmxv
dywgdm9pZCwgZW52LCBpMzIsIGkzMikKIERFRl9IRUxQRVJfMihzd2ksIHZvaWQsIGVudiwgaTMy
KQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdvbi9n
ZW5wdHIuYwppbmRleCAyYTk4YjEzYjcxNC4uMjgyYTY5N2QxOTAgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbnB0ci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC00MTEs
NiArNDExLDIzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBnZW5fcmVhZF9jdHJsX3JlZyhEaXNhc0Nv
bnRleHQgKmN0eCwgY29uc3QgaW50IHJlZ19udW0sCiAgICAgfSBlbHNlIGlmIChyZWdfbnVtID09
IEhFWF9SRUdfUUVNVV9IVlhfQ05UKSB7CiAgICAgICAgIHRjZ19nZW5fYWRkaV90bChkZXN0LCBo
ZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhfQ05UXSwKICAgICAgICAgICAgICAgICAgICAgICAgIGN0
eC0+bnVtX2h2eF9pbnNucyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICB9IGVsc2Ug
aWYgKHJlZ19udW0gPT0gSEVYX1JFR19VVElNRVJMTykgeworICAgICAgICBnZW5faGVscGVyX3Ny
ZWdfcmVhZChkZXN0LCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Y2df
Y29uc3RhbnRfaTMyKEhFWF9TUkVHX1RJTUVSTE8pKTsKKyAgICB9IGVsc2UgaWYgKHJlZ19udW0g
PT0gSEVYX1JFR19VVElNRVJISSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChkZXN0
LCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Y2dfY29uc3RhbnRfaTMy
KEhFWF9TUkVHX1RJTUVSSEkpKTsKKyNlbHNlCisgICAgfSBlbHNlIGlmIChyZWdfbnVtID09IEhF
WF9SRUdfVVRJTUVSTE8pIHsKKyAgICAgICAgVENHdl9pNjQgdXRpbWVyID0gdGNnX3RlbXBfbmV3
X2k2NCgpOworICAgICAgICBnZW5faGVscGVyX3V0aW1lcih1dGltZXIpOworICAgICAgICB0Y2df
Z2VuX2V4dHJsX2k2NF9pMzIoZGVzdCwgdXRpbWVyKTsKKyAgICB9IGVsc2UgaWYgKHJlZ19udW0g
PT0gSEVYX1JFR19VVElNRVJISSkgeworICAgICAgICBUQ0d2X2k2NCB1dGltZXIgPSB0Y2dfdGVt
cF9uZXdfaTY0KCk7CisgICAgICAgIGdlbl9oZWxwZXJfdXRpbWVyKHV0aW1lcik7CisgICAgICAg
IHRjZ19nZW5fZXh0cmhfaTY0X2kzMihkZXN0LCB1dGltZXIpOworI2VuZGlmCiAgICAgfSBlbHNl
IHsKICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoZGVzdCwgaGV4X2dwcltyZWdfbnVtXSk7CiAgICAg
fQpAQCAtNDM5LDYgKzQ1NiwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3JlYWRfY3RybF9y
ZWdfcGFpcihEaXNhc0NvbnRleHQgKmN0eCwgY29uc3QgaW50IHJlZ19udW0sCiAgICAgICAgIHRj
Z19nZW5fYWRkaV90bChodnhfY250LCBoZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhfQ05UXSwKICAg
ICAgICAgICAgICAgICAgICAgICAgIGN0eC0+bnVtX2h2eF9pbnNucyk7CiAgICAgICAgIHRjZ19n
ZW5fY29uY2F0X2kzMl9pNjQoZGVzdCwgaHZ4X2NudCwgaGV4X2dwcltyZWdfbnVtICsgMV0pOwor
I2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgfSBlbHNlIGlmIChyZWdfbnVtID09IEhFWF9S
RUdfVVRJTUVSTE8pIHsKKyAgICAgICAgVENHdiBsbyA9IHRjZ190ZW1wX25ldygpOworICAgICAg
ICBUQ0d2IGhpID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFk
KGxvLCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKEhFWF9TUkVHX1RJTUVSTE8pKTsKKyAgICAg
ICAgZ2VuX2hlbHBlcl9zcmVnX3JlYWQoaGksIHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIoSEVY
X1NSRUdfVElNRVJISSkpOworICAgICAgICB0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KGRlc3QsIGxv
LCBoaSk7CisjZWxzZQorICAgIH0gZWxzZSBpZiAocmVnX251bSA9PSBIRVhfUkVHX1VUSU1FUkxP
KSB7CisgICAgICAgIC8qIE9uZSBoZWxwZXIgY2FsbCwgc28gdGhlIHBhaXIgaXMgYSBjb2hlcmVu
dCA2NC1iaXQgc25hcHNob3QuICovCisgICAgICAgIGdlbl9oZWxwZXJfdXRpbWVyKGRlc3QpOwor
I2VuZGlmCiAgICAgfSBlbHNlIHsKICAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2NChkZXN0
LAogICAgICAgICAgICAgaGV4X2dwcltyZWdfbnVtXSwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggMmNlYTE5
MjcyNjMuLmRmMzFlZDI0ODhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMzcsNiArMzcsOSBAQAogI2lu
Y2x1ZGUgImNwdV9oZWxwZXIuaCIKICNpbmNsdWRlICJ0Y2cvdGNnLWd2ZWMtZGVzYy5oIgogI2lu
Y2x1ZGUgInRyYW5zbGF0ZS5oIgorI2lmZGVmIENPTkZJR19VU0VSX09OTFkKKyNpbmNsdWRlICJx
ZW11L3RpbWVyLmgiCisjZW5kaWYKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogI2luY2x1ZGUg
Imh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKICNpbmNsdWRlICJoZXhfbW11LmgiCkBA
IC00Niw2ICs0OSwyNCBAQAogI2luY2x1ZGUgImhleHN3aS5oIgogI2VuZGlmCiAKKyNpZmRlZiBD
T05GSUdfVVNFUl9PTkxZCisvKgorICogVXNlciBtb2RlIGhhcyBubyBxdGltZXIgZGV2aWNlIGJh
Y2tpbmcgVElNRVJMTy9USU1FUkhJLCBzbyBkZXJpdmUgdGhlCisgKiB1c2VyIHRpbWVyIGRpcmVj
dGx5IGZyb20gdGhlIHZpcnR1YWwgY2xvY2sgLS0gdGhlIHNhbWUgY2xvY2sgdGhlIHF0aW1lcgor
ICogY291bnRzIC0tIGF0IHRoZSBxdGltZXIncyBkZWZhdWx0IDE5LjJNSHogdGljayByYXRlLCBt
YXNrZWQgdG8gdGhlCisgKiBxdGltZXIncyBjb3VudGVyIHdpZHRoLgorICovCisjZGVmaW5lIEhF
WF9VVElNRVJfRlJFUV9IWiAgMTkyMDAwMDBVTEwKKyNkZWZpbmUgSEVYX1VUSU1FUl9DTlRfTUFT
SyAweDAwZmZmZmZmZmZmZmZmZmZVTEwKKwordWludDY0X3QgSEVMUEVSKHV0aW1lcikodm9pZCkK
K3sKKyAgICByZXR1cm4gbXVsZGl2NjQocWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19WSVJU
VUFMKSwKKyAgICAgICAgICAgICAgICAgICAgSEVYX1VUSU1FUl9GUkVRX0haLCBOQU5PU0VDT05E
U19QRVJfU0VDT05EKSAmCisgICAgICAgICAgIEhFWF9VVElNRVJfQ05UX01BU0s7Cit9CisjZW5k
aWYKKwogI2RlZmluZSBTRl9CSUFTICAgICAgICAxMjcKICNkZWZpbmUgU0ZfTUFOVEJJVFMgICAg
MjMKIApkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jIGIvdGVzdHMvdGNn
L2hleGFnb24vcmVnX211dC5jCmluZGV4IGM1YTM5ZTU1MTAwLi45Y2UxOGYzZWJlNSAxMDA2NDQK
LS0tIGEvdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29u
L3JlZ19tdXQuYwpAQCAtNzcsMTAgKzc3LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB3cml0ZV9j
b250cm9sX3JlZ2lzdGVycyh2b2lkKQogICAgIGNoZWNrMzIocmVzdWx0LCAweDAwMDAwMDAwKTsK
IAogICAgIFdSSVRFX1JFR19OT0NMT0JCRVIocmVzdWx0LCAidXRpbWVybG8iLCAweGZmZmZmZmZm
KTsKLSAgICBjaGVjazMyKHJlc3VsdCwgMHgwMDAwMDAwMCk7CisgICAgY2hlY2szMl9uZShyZXN1
bHQsIDB4ZmZmZmZmZmYpOwogCiAgICAgV1JJVEVfUkVHX05PQ0xPQkJFUihyZXN1bHQsICJ1dGlt
ZXJoaSIsIDB4ZmZmZmZmZmYpOwotICAgIGNoZWNrMzIocmVzdWx0LCAweDAwMDAwMDAwKTsKKyAg
ICBjaGVjazMyX25lKHJlc3VsdCwgMHhmZmZmZmZmZik7CiAKICAgICAvKgogICAgICAqIFBDIGlz
IHNwZWNpYWwuICBTZXR0aW5nIGl0IHRvIHRoZXNlIHZhbHVlcwpAQCAtMTA2LDggKzEwNiwxMyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgd3JpdGVfY29udHJvbF9yZWdpc3Rlcl9wYWlycyh2b2lkKQog
ICAgIFdSSVRFX1JFR19OT0NMT0JCRVIocmVzdWx0LCAiYzE1OjE0IiwgMHhmZmZmZmZmZmZmZmZm
ZmZmKTsKICAgICBjaGVjazY0KHJlc3VsdCwgMHgwMDAwMDAwMDAwMDAwMDAwKTsKIAorICAgIC8q
CisgICAgICogYzMxOjMwIGlzIFVUSU1FUkhJOlVUSU1FUkxPLCBhIHJlYWQtb25seSBmcmVlLXJ1
bm5pbmcgY291bnRlci4gIFRoZQorICAgICAqIHdyaXRlIG11c3QgYmUgZGlzY2FyZGVkOyB0aGUg
cmVhZC1iYWNrIGlzIHdoYXRldmVyIHRoZSB0aW1lciBzYXlzLAorICAgICAqIHNvIG9ubHkgY2hl
Y2sgdGhhdCB0aGUgd3JpdHRlbiB2YWx1ZSBkaWQgbm90IHN0aWNrLgorICAgICAqLwogICAgIFdS
SVRFX1JFR19OT0NMT0JCRVIocmVzdWx0LCAiYzMxOjMwIiwgMHhmZmZmZmZmZmZmZmZmZmZmKTsK
LSAgICBjaGVjazY0KHJlc3VsdCwgMHgwMDAwMDAwMDAwMDAwMDAwKTsKKyAgICBjaGVjazY0X25l
KHJlc3VsdCwgMHhmZmZmZmZmZmZmZmZmZmZmKTsKIAogICAgIFdSSVRFX1JFR19QQUlSX0VOQ09E
RUQocmVzdWx0LCAiYzk6OCIsICh1aW50NjRfdCkgMHgwMDAwMDAwMDAwMDAwMDAwLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQzlfOF9FUV9SMV8wKTsKLS0gCjIuMzQuMQoK

