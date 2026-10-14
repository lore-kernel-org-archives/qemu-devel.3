Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C41DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2Jj-0000zr-LZ; Wed, 14 Oct 2026 12:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Ja-0000yi-6T
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2JS-0001Yz-CH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbHo7301254
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hDM2hDJKEOOT27YQJ81jFT8aBqIAoi8FtdpFrMtrjZg=; b=ZAu4egt62NRdJHTN
 +WlduIuf8ihm/TItBic1IENTb+ri8ou1KFTW+Xc1QjoXy/JZsw3F2WQKJZ7s3BnX
 yiSq1jN14tkp+LlProeXjm9CmYMopgcdkNOCqqsfBOLHpj1i5MRbrZZaV8RBSuz3
 qJ4SEbtkU7Zg00yEragBDwjQFSIFyrwnapHtkZOOesUb0HryWorCaypTwhnsVVpQ
 q5FLkLQW27sA5ARfmsYnvytXa8SyZ7oioxAWo7v9O4mpr2HJn1PLdUOZ0XuZoyVv
 HlxlUgYisWTVcwQ9txkS2689rtts0agxgaVJXejOcff34SJ8NbnmGvlixUX5uYhG
 87XDvw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622nba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:43 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso2197957c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997122; x=1792601922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hDM2hDJKEOOT27YQJ81jFT8aBqIAoi8FtdpFrMtrjZg=;
 b=SEJVmwQw18Yl1zoajDOYM2Vy7zPJDeQv0rKw/lRlXCNPo+NTNVaRGExrKuzBKoASBa
 35gpC6OaICtAUBWAFdcJrVQE7ZJqrgp9KhSsqKf/3IpYMQ1PuLMpRfXgkqTb2rAsnw5/
 NAvyvZD/H58mV4NeuT7Q3Ob0pS3g6o+m1iPU6I3b8E+m9mprYEZOmeDPPJdRyPcWtwcV
 6zBtt3dPiI8DfukNTqeRZMt0O7UMgxGwzR+trkGKSdt1ubTH+xlKmXpMgCyMJt2d8JU0
 G59zB/ZzeZuG0iBszbcqMKlTJKA7U+WUSvZlLxRYzHNY7R1ghE7XuyAui2dRv/5+SNnP
 Lg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997122; x=1792601922;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hDM2hDJKEOOT27YQJ81jFT8aBqIAoi8FtdpFrMtrjZg=;
 b=KbebFJ0GsJO6hzU1UA5Y2lNaWFdgk4vA1+mHl5vUee0KGUIZHeZGsdNgPY996FpjkW
 ky8SQbz7bRjHQ5MIlQlsc/3huInyPoiDmEf90EnjSjihuWk2lxJS81vVMSFYsUdZY7/G
 iXxxeKobS/kfAQdGJmZ5+yrUnbs58S4ieoduEsASterHQ0NJhvckPPAxQCmaNk/BpnuB
 Viml3xzYAOXiYV+i/ZoohLAquiqW6513Ko2HxH99Kcjet0W36RuXgSFu68wlEcThHcxL
 u8AxoQWLMMxliWxDxoWLEznNzkezyKCAQeS3apoHREtDv2KQYLBNBvE2Wt2ht7G34qa8
 r8Lg==
X-Gm-Message-State: AFq9FYJE793yNbiB0mDaJbQmpo3tiDN2UnDnD2bhG3T2X3G0+xmQJaO8
 hss3Cx9EtJLALihw1lWuMs8xak3JGUjb72WMwsC8sK9uG69qh3trBTDuCaRHosl7/Et5zVd/Nr1
 ZNXQEWqugyO0W5saZGnfiznQh0r4FMc7vYsZZnMENiTKDu4zMdve7s2HOPwfmvX4nZA==
X-Gm-Gg: AYBFou2syw/rkpdMpJz4G6xqFuoV0mcTCt8Xq5r1P6v89I98LwwmfWJ0V7Em3uZAV9O
 ovXeHEr7iuKBSGJKNkNGKTUN2TIGfUR9erqauLiYXpnJ0zCklC9ke+mUlqaDs6LyyO0YAZsO5jL
 8LHcptHf9BdbV6y4MmY9HxQ/Tpk9ZNwFc0JbdTg/ndjiAin34iMeml2ECp7tVzZ1AfHLw885lq7
 xe5oGYQu6lNLElVZZWHlfg7W9a1MBGsY/KNi/8GqtyuGx82VuSYJ9bcEQ8BgXZiZUZx/lrSb5ua
 AXE8uPvAdmR1xu1HcNore8z2i7tY782pX/m/L2jgmMGqibyW4kB2Pcg8F7NYz9nwidBF9zF57nt
 WcrgUC1PHgQ8FGW/B6yAwdR7iiUM5muhNeNVRNZyFXdrYY/Q=
X-Received: by 2002:a05:7022:4399:b0:175:525c:90b4 with SMTP id
 a92af1059eb24-175525c91b3mr18811669c88.20.1791997122006; 
 Wed, 14 Oct 2026 09:58:42 -0700 (PDT)
X-Received: by 2002:a05:7022:4399:b0:175:525c:90b4 with SMTP id
 a92af1059eb24-175525c91b3mr18811620c88.20.1791997121415; 
 Wed, 14 Oct 2026 09:58:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11137939c88.6.2026.10.14.09.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:58:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/5] target/hexagon: check privilege mode for system
 instructions
Date: Wed, 14 Oct 2026 09:58:33 -0700
Message-Id: <20261014165837.2916482-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
References: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: FyN9RNdjPqSHxr-INXPrd_f3gc5HmWj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX5gnDy6ZtvARt
 E9DbqD7JP6n2NH5GNq+/Ec+QWiSia6qoGhPxPrZHXXtmjaBCXbGGeP0DyKqj6CAbQfU9HmDHg4w
 mxPEnK0T+XUevBPSKoCMemT01GudX91Kxk5qcBhlQ95Kq8BRD3dmSXeFBntQALL8fROb0LHtVIH
 qM2eIL2E4QayXY7yO4D4enfTZldfnPoT3pviArXHiGjL2R/FwXfxgjShAUN4dm+EPd6up4vuA2K
 wClvXVxxiXPJhkzHAfvhep4JNXiSrFvEZQRrLor+fOemwc9TLDuFn5JNHFfhjsaH1NR5yzcXdsD
 g4dioe3CzZrbd0b/zggZECaqoF/S+C/MkkMESkNo0LeG1atY+C62qjwXHlMUbaK5BRlU9hlY5qZ
 EEuxMYm55htqc1MMO2akJYNaYnmdnLZKhSe/fa7CfT1RCVLzy/9zcglEkBmWUgGLRcql7mGv8aZ
 70q4iK7R3aFK4x+etyQ==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfb4c3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=BTrIe76cHL4Dmed7cV0A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX5VVCUZt3xfWj
 rAVFCAGmYXXJFdWjV8yCXspODfvEg3yqPMiDpqUWZ8LkENhdFaZ0MAZRfXaFlLID9AAk/awGSJi
 gIzIC2fK0jUGRZYEHtuVlq4GpY81lu0=
X-Proofpoint-GUID: FyN9RNdjPqSHxr-INXPrd_f3gc5HmWj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

Rml4ZXM6IDk4MzFkM2NhYjE2OCAoInRhcmdldC9oZXhhZ29uOiBBZGQgcHJpdmlsZWdlIGNoZWNr
LCB1c2UgdGFnX2lnbm9yZSgpIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAg
ICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgIHwgIDEgKwog
dGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyAgICAgIHwgMTUgKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5f
dGNnX2Z1bmNzLnB5IHwgMTYgKysrKysrKysrKy0tLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAyOSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggNjVmZDJiMjk4MzAuLjY0OWUzM2Rl
MDIwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuaApAQCAtMjI4LDYgKzIyOCw3IEBAIEZJRUxEKFRCX0ZMQUdTLCBJU19USUdIVF9MT09Q
LCAwLCAxKQogRklFTEQoVEJfRkxBR1MsIE1NVV9JTkRFWCwgMSwgMykKIEZJRUxEKFRCX0ZMQUdT
LCBQQ1lDTEVfRU5BQkxFRCwgNCwgMSkKIEZJRUxEKFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VOQUJM
RUQsIDUsIDEpCitGSUVMRChUQl9GTEFHUywgQ1BVX01PREUsIDYsIDIpCiAKIEdfTk9SRVRVUk4g
dm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2Vw
dGlvbiwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmgKaW5kZXggMmQxZWQ1MjA4YjcuLjE1OTE4ZjJjNTJjIDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuaApAQCAtNDUsNiArNDUsNyBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewog
ICAgIERFQ0xBUkVfQklUTUFQKGdwcl91bmNvbmQsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAg
ICAgYm9vbCBpbXBsaWNpdF91c3Jfd3JpdGU7CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAg
ICB1aW50MzJfdCBjcHVfbW9kZTsKICAgICBpbnQgZ3JlZ19sb2dbR1JFR19XUklURVNfTUFYXTsK
ICAgICBpbnQgZ3JlZ19sb2dfaWR4OwogICAgIERFQ0xBUkVfQklUTUFQKGdyZWdzX3dyaXR0ZW4s
IE5VTV9HUkVHUyk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDY1NTBlN2ZhODAwLi5mNThlNDU5NjAzOSAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTM1Myw2
ICszNTMsOCBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dldF90Yl9jcHVfc3RhdGUo
Q1BVU3RhdGUgKmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9G
TEFHUywgSFZYX0NPUFJPQ19FTkFCTEVELAogICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1
LT5odnhfY3R4WzBdICYmCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxE
KFNTUl9YRSwgZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOworICAgIGhleF9mbGFncyA9IEZJ
RUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgQ1BVX01PREUsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICBnZXRfY3B1X21vZGUoZW52KSk7CiAjZWxzZQogICAgIGhleF9mbGFncyA9IEZJ
RUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLCBNTVVfVVNFUl9JRFgpOwog
I2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGNkMWFiZGYxNDYxLi43MmRkMWZkYmJiMiAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMKQEAgLTEzMDYsNiArMTMwNiwyMCBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfYW5kX3Ry
YW5zbGF0ZV9wYWNrZXQoQ1BVSGV4YWdvblN0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4KQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIRVhfQ0FVU0VfUkVHX1dSSVRF
X0NPTkZMSUNUKTsKICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQorI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZCisgICAgICAgIGlmIChjaGVja19mb3JfYXR0cmliKCZjdHgtPnBrdCwgQV9Q
UklWKSAmJgorICAgICAgICAgICAgY3R4LT5jcHVfbW9kZSAhPSBIRVhfQ1BVX01PREVfTU9OSVRP
UikgeworICAgICAgICAgICAgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0NBVVNF
X1BSSVZfVVNFUl9OT19TSU5TTik7CisgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCArPSBj
dHgtPnBrdC5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKKyAgICAgICAgICAgIHJldHVybjsKKyAg
ICAgICAgfQorICAgICAgICBpZiAoY2hlY2tfZm9yX2F0dHJpYigmY3R4LT5wa3QsIEFfR1VFU1Qp
ICYmCisgICAgICAgICAgICBjdHgtPmNwdV9tb2RlID09IEhFWF9DUFVfTU9ERV9VU0VSKSB7Cisg
ICAgICAgICAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfUFJJVl9V
U0VSX05PX0dJTlNOKTsKKyAgICAgICAgICAgIGN0eC0+YmFzZS5wY19uZXh0ICs9IGN0eC0+cGt0
LmVuY29kX3BrdF9zaXplX2luX2J5dGVzOworICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9
CisjZW5kaWYKICAgICAgICAgZ2VuX3N0YXJ0X3BhY2tldChjdHgpOwogICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgY3R4LT5wa3QubnVtX2luc25zOyBpKyspIHsKICAgICAgICAgICAgIGN0eC0+aW5z
biA9ICZjdHgtPnBrdC5pbnNuW2ldOwpAQCAtMTM0MCw2ICsxMzU0LDcgQEAgc3RhdGljIHZvaWQg
aGV4YWdvbl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLAog
ICAgIGN0eC0+aHZ4X2NvcHJvY19lbmFibGVkID0KICAgICAgICAgRklFTERfRVgzMihoZXhfZmxh
Z3MsIFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VOQUJMRUQpOwogICAgIGN0eC0+aHZ4X2NoZWNrX2Vt
aXR0ZWQgPSBmYWxzZTsKKyAgICBjdHgtPmNwdV9tb2RlID0gRklFTERfRVgzMihoZXhfZmxhZ3Ms
IFRCX0ZMQUdTLCBDUFVfTU9ERSk7CiAjZW5kaWYKIH0KIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vZ2VuX3RjZ19mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkK
aW5kZXggYjA5Y2U3YzI4NWYuLjYxZWZmYTM4Y2ZhIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX2Z1bmNzLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkK
QEAgLTU4LDE2ICs1OCwyMCBAQCBkZWYgZ2VuX3RjZ19mdW5jKGYsIHRhZywgcmVncywgaW1tcyk6
CiAKICAgICBmLndyaXRlKCIgICAgSW5zbiAqaW5zbiBHX0dOVUNfVU5VU0VEID0gY3R4LT5pbnNu
O1xuIikKIAotICAgIGlmICJBX1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgor
ICAgIGlmICgKKyAgICAgICAgIkFfUFJJViIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ10K
KyAgICAgICAgb3IgIkFfR1VFU1QiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddCisgICAg
KToKICAgICAgICAgZi53cml0ZShkZWRlbnQoIiIiXAogI2lmZGVmIENPTkZJR19VU0VSX09OTFkK
LSAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfUFJJVl9VU0VSX05P
X1NJTlNOKTsKLSNlbHNlCiAiIiIpKQotICAgIGlmICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0
dHJpYmRpY3RbdGFnXToKKyAgICAgICAgaWYgIkFfUFJJViIgaW4gaGV4X2NvbW1vbi5hdHRyaWJk
aWN0W3RhZ106CisgICAgICAgICAgICBmLndyaXRlKCIgICAgaGV4X2dlbl9leGNlcHRpb25fZW5k
X3RiKGN0eCwgIgorICAgICAgICAgICAgICAgICAgICAiSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19T
SU5TTik7XG4iKQorICAgICAgICBlbHNlOgorICAgICAgICAgICAgZi53cml0ZSgiICAgIGhleF9n
ZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsICIKKyAgICAgICAgICAgICAgICAgICAgIkhFWF9DQVVT
RV9QUklWX1VTRVJfTk9fR0lOU04pO1xuIikKICAgICAgICAgZi53cml0ZShkZWRlbnQoIiIiXAot
I2lmZGVmIENPTkZJR19VU0VSX09OTFkKLSAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4
LCBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX0dJTlNOKTsKICNlbHNlCiAiIiIpKQogICAgIGlmIGhl
eF9jb21tb24ubmVlZF9lYSh0YWcpOgotLSAKMi4zNC4xCgo=

