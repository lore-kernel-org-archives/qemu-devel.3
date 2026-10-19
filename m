Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C751CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 05:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgJX-0006cG-N9; Mon, 19 Oct 2026 01:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJA-0006Xn-36
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJ7-0001If-3r
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4jMN12268149
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=; b=GtG9tfAReRJBlOpU
 oNu3kOsyjArwQ5thD0U+ChjVbRiQfjATNBAuPBD7z6wD6Eb4L41xq6dfdMVc6QIy
 DN7RK/TmhoxrzZVfqa3MRwjGl28DOVe9BdSmKZjGLUidj94bz/eZI3gEPEO2XVfr
 TBDqIwzPyfogf2arTRbGaMublM99VvbLVPOoYmLVzAy/DBVDmGVZn3kU3ti4LKVX
 V/PFxgU9G/KXLrmRYxwcE3y9yBPzzXWoI/zhdOSss/ifP1lv+DeGD5+ypK/7U3BD
 mmSDqQPWrnutLRvT6lAU5iJ7jI9C6m7uZ7DBseT9BG88dPtyMrW2GXZwWN9aHl6X
 M9u/Jw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxn5se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:53:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso3906263eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792389191; x=1792993991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=;
 b=NkQh3dIDoK4g/ycLXYxIl1v9tON7z29CORz/eDGpx1TEh53L7ocMruzRf6PiGyhpzS
 b1yroH2zTp4XtL8KHUMDWV+F6/tIWlFhySUcOcJEjuWSE//aV7XgPkFkPxwuz8kI0cPB
 hxPV2oiqygUhP2b1Tz2jnT1sIErNsA1bXn5Q2AXlx1xc6y3VByhLas+WAXrJNHAoFjEN
 UAW4bebW6nk2TEl2UL976VtlWGElTH8Bt88WYip4p+K6b0zZDv1gFoDiOuHOYlfuXms9
 mMzOdkM8UbEIQgYrdylfAmsNuwsk73enylT/Rgew89+t00RO0QTkafiv+byOO/y4c9YI
 RfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792389191; x=1792993991;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=;
 b=lqZfX3heQYbM4CXf5fAnvlLMeBn8u0tAQosGFRBXa7iLAA7AdH5tj+lM1wfSKe/A2t
 9B9Jq1LQi4gFWWCW1Ql3+28ew1//BrW2yxm+8AZfKpguBQMz37gsjOWCfkazDwkCoiPK
 0wScL1Cp+jpvnEhO3RO4CUMz9VJu0N5CyVTeuM0kZ9LxBw1uOC51X2659OxJaOqqlW1/
 cDr4rNjae3X3sX8Dh3hdFTiHzkw5HUdJqRlvzLwTHCnA77WL9AYZmwPfSwfC+LHwxerM
 hrR82jyBoUvSfn+UwCQm/D7U6I87blFOZF5tcfTLGNNO0NJaBHQYb05ao8xMtwzzqbC2
 mW/g==
X-Gm-Message-State: AFq9FYK7hejAO93xuVFggjJPUjnkLjzF86ly0LxlADhj2JzxPpqfhcj7
 2sREemUsUKXCVgH4jlv1cmVomucQXO+en/2KumU27DOu8xyoySaNMjFPqTKkz5hw1vRXhS/zWEU
 Zzorq3l4/xsO3TxiXuGHjxZEPArHsc/zaTaWK+jjRFoCjvRnhGmVuDIIZwD+vy2Mglg==
X-Gm-Gg: AYBFou2VZgZjuRbuHICteVbuzpafyublhLL34eAQEngLpe6Uy+1tiqHidp7+a3w2DTl
 38Bz5Ho2l4pqIJcz7PkfdYa8IOB/FUZtQVJxW5SrH0gShHSuZxMDrq7e2gt4xiB8jEy3NCJ3t67
 DXGt4p6WFdrtcXovRbkV1AVk475sXID8A8cqa/18vNYVgyy3RL9rRWKcmDgLFMwXe3Ipkaq7M37
 E/7IWXV4SiD3oyMXlqeTQ8Q94ype43eDt1n7L9UYThloUT5BLhuuF2Z7Fi1V5K3K66+NkndDqS9
 uuF0dtU4XSoeaYRGu8yRH1c37Bz5D8BiyJP+2DgbTX9F+xpN9/qvLrbLXbQNl7qOjUOicwhL9AQ
 NTcmlLXQdBHyuj3srUoNKbcIZLoThEzoVPrzAOCQAp0JCh6s=
X-Received: by 2002:a05:701b:458e:10b0:151:5d01:9316 with SMTP id
 a92af1059eb24-18512f1d08bmr9907378c88.23.1792389190754; 
 Sun, 18 Oct 2026 22:53:10 -0700 (PDT)
X-Received: by 2002:a05:701b:458e:10b0:151:5d01:9316 with SMTP id
 a92af1059eb24-18512f1d08bmr9907364c88.23.1792389190197; 
 Sun, 18 Oct 2026 22:53:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm25672781c88.15.2026.10.18.22.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:53:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 13/14] target/hexagon: fix the allocframe framekey
Date: Sun, 18 Oct 2026 22:52:44 -0700
Message-Id: <20261019055245.1457795-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX2AtoqINs5TjS
 U7NlKXO/+slFTr4eCz1C1zyqksOhZCQUf7fjewuR3uFaWPOD12ELwf2I25UnJYDct1+eHFVnye8
 h/ztQF9Ank3hO9UKLvHbaSGIg0NoXIM=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad5b047 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_X05_UiFBxjwBGZApkgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX35A6jQRzUfvO
 4V54mq4Dv9LDahmEawbN838/YqzmEhl6V7+1msnjS8t9H8DhfQF1JTOMyk8qHSYQX3oiB3TDJC8
 A+xn6kBsObFB9i3aie3NR+tOuVuBtVLCSIFKbKkaUH1RX0uBn1MzBy5B/wBCRZTOW1930v0Ti9J
 5ie4M4Z3hY1zX35kuMybC/VPay+JpAgP9zVbH80S2K2FhPbGGAsGfYRuTogX2k2aLioKbIbvOTd
 2GCby/pgGUi0HFsFMUoKuvDMCPCPEXO3w0T8L/jL0OS52MyfYbla3ZcFKxcqs7mKFT3TqVih8mN
 IzRYJdaO3x8va1cBVrGmNh5Rrh/DsQPuZS546e7t5eDZKXmdbLyco6gfGhwXV7VniR58G19TX6M
 y/fCG/ho6yh5/41qCvofqsl3p+cJCIpaJXCjSjRQ6pByyaaLPhRf6bgFxOP6TK6NOOGk/wEqjiX
 LdqKvyL6IEQ1RVOJo6g==
X-Proofpoint-ORIG-GUID: CcN7vni70bhBwMpxWAS1WvVOplRWd9IG
X-Proofpoint-GUID: CcN7vni70bhBwMpxWAS1WvVOplRWd9IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190023
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
YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDIgKy0KIHRlc3Rz
L3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMgICAgICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysr
KysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAg
MSArCiAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyBiL3RhcmdldC9o
ZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKaW5kZXggNDljYzExZmRkZDguLjE0
ODQwZDk4NzM3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXIt
aGVscGVycy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJz
LmMKQEAgLTE5ODksNyArMTk4OSw3IEBAIEhleFZhbHVlIGdlbl9ydmFsdWVfZnNjcihDb250ZXh0
ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAqdmFsdWUpCiAgICAgKnZhbHVlID0gZ2VuX3J2
YWx1ZV9leHRlbmQoYywgbG9jcCwgdmFsdWUpOwogICAgIE9VVChjLCBsb2NwLCAiZ2VuX3JlYWRf
cmVnKCIsICZmcmFtZV9rZXksICIsIEhFWF9SRUdfRlJBTUVLRVkpO1xuIik7CiAgICAgT1VUKGMs
IGxvY3AsICJ0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KCIsCi0gICAgICAgICZrZXksICIsICIsICZm
cmFtZV9rZXksICIsICIsICZmcmFtZV9rZXksICIpO1xuIik7CisgICAgICAgICZrZXksICIsIHRj
Z19jb25zdGFudF90bCgwKSwgIiwgJmZyYW1lX2tleSwgIik7XG4iKTsKICAgICBPVVQoYywgbG9j
cCwgInRjZ19nZW5feG9yX2k2NCgiLCAmcmVzLCAiLCAiLCB2YWx1ZSwgIiwgIiwgJmtleSwgIik7
XG4iKTsKICAgICByZXR1cm4gcmVzOwogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24v
ZnJhbWVrZXkuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjVkNTc5MjkzNDc3Ci0tLSAvZGV2L251bGwKKysrIGIv
dGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwpAQCAtMCwwICsxLDY3IEBACisvKgorICogIENv
cHlyaWdodChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRp
YXJpZXMuCisgKgorICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
CisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisKK2ludCBl
cnI7CisKKyNpbmNsdWRlICJoZXhfdGVzdC5oIgorCisvKgorICogYWxsb2NmcmFtZSBwdXNoZXMg
e0xSLCBGUH0sIHNjcmFtYmxpbmcgTFIgd2l0aCBGUkFNRUtFWSwgYW5kIGRlYWxsb2NmcmFtZQor
ICogcmVzdG9yZXMgdGhlbS4gIFB1c2ggYSBmcmFtZSBhbmQgcmV0dXJuIHRoZSB3b3JkcyB0aGF0
IHdlcmUgc3RvcmVkLCBGUAorICogdGhyb3VnaCB0aGUgcmV0dXJuIHZhbHVlIGFuZCBMUiB0aHJv
dWdoIEBscl9zdG9yZWQsIGFuZCB0aGUgRlAgYW5kIExSCisgKiB0aGF0IGRlYWxsb2NmcmFtZSBy
ZXN0b3Jlcy4KKyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWlu
dDMyX3Qga2V5LCB1aW50MzJfdCBmcCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IGxyLCB1aW50MzJfdCAqbHJfc3RvcmVkLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmZwX2JhY2ssIHVpbnQzMl90ICpscl9i
YWNrKQoreworICAgIHVpbnQzMl90IGZwX3N0b3JlZCwgc2F2ZWRfZnAsIHNhdmVkX2xyOworCisg
ICAgYXNtIHZvbGF0aWxlKCIlW3NhdmVkX2ZwXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAg
ICIlW3NhdmVkX2xyXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVb
a2V5XVxuXHQiCisgICAgICAgICAgICAgICAgICJyMzAgPSAlW2ZwXVxuXHQiCisgICAgICAgICAg
ICAgICAgICJyMzEgPSAlW2xyXVxuXHQiCisgICAgICAgICAgICAgICAgICJhbGxvY2ZyYW1lKCMw
KVxuXHQiCisgICAgICAgICAgICAgICAgICIlW2ZwX3N0b3JlZF0gPSBtZW13KHIzMClcblx0Igor
ICAgICAgICAgICAgICAgICAiJVtscl9zdG9yZWRdID0gbWVtdyhyMzAgKyAjNClcblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY2Zy
YW1lXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVbZnBfYmFja10gPSByMzBcblx0IgorICAgICAg
ICAgICAgICAgICAiJVtscl9iYWNrXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFt
ZWtleSA9ICVbemVyb11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1c
blx0IgorICAgICAgICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAg
ICAgICAgOiBbZnBfc3RvcmVkXSAiPSZyIihmcF9zdG9yZWQpLCBbbHJfc3RvcmVkXSAiPSZyIigq
bHJfc3RvcmVkKSwKKyAgICAgICAgICAgICAgICAgICBbZnBfYmFja10gIj0mciIoKmZwX2JhY2sp
LCBbbHJfYmFja10gIj0mciIoKmxyX2JhY2spLAorICAgICAgICAgICAgICAgICAgIFtzYXZlZF9m
cF0gIj0mciIoc2F2ZWRfZnApLCBbc2F2ZWRfbHJdICI9JnIiKHNhdmVkX2xyKQorICAgICAgICAg
ICAgICAgICA6IFtrZXldICJyIihrZXkpLCBbZnBdICJyIihmcCksIFtscl0gInIiKGxyKSwgW3pl
cm9dICJyIigwKQorICAgICAgICAgICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAg
ICByZXR1cm4gZnBfc3RvcmVkOworfQorCitzdGF0aWMgdm9pZCBjaGVja19mcmFtZSh1aW50MzJf
dCBrZXksIHVpbnQzMl90IGZwLCB1aW50MzJfdCBscikKK3sKKyAgICB1aW50MzJfdCBscl9zdG9y
ZWQsIGZwX2JhY2ssIGxyX2JhY2s7CisKKyAgICAvKiBPbmx5IExSIGlzIHNjcmFtYmxlZCwgRlAg
aXMgc3RvcmVkIGFzIGlzICovCisgICAgY2hlY2szMihmcmFtZV9yb3VuZHRyaXAoa2V5LCBmcCwg
bHIsICZscl9zdG9yZWQsICZmcF9iYWNrLCAmbHJfYmFjayksIGZwKTsKKyAgICBjaGVjazMyKGxy
X3N0b3JlZCwgbHIgXiBrZXkpOworICAgIGNoZWNrMzIoZnBfYmFjaywgZnApOworICAgIGNoZWNr
MzIobHJfYmFjaywgbHIpOworfQorCitpbnQgbWFpbigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwg
MHgxMjM0ZmZmMCwgMHg1Njc4YWJjYyk7CisgICAgY2hlY2tfZnJhbWUoMHhmMjFmMjBhMCwgMHgx
MjM0ZmZmMCwgMHg1Njc4YWJjYyk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7
CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29u
LmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3YzIu
LjBmZDYyY2U3ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAor
KysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0ZXN0
cyArPSB7CiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6ICdo
ZXgtb3ZlcmZsb3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAg
J2R1YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzogeydj
ZmxhZ3MnOiBjZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFnc30s
CiAgICdtZW1fbm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVmX2V4
Y2VwdGlvbi5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

