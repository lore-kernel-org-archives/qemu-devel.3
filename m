Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8E21039893
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zt-0006nu-LL; Fri, 27 Feb 2026 15:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zs-0006na-5K
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zq-0006oj-DY
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:47 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIeoRe373460
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=; b=D2fpoSja4rRO/6bn
 e+KfK4E2oqloHlRk5RdL6VqmHgEvWtGVzTI27/6SpYHlvEZg3XQygYXsMkFiEXDz
 naQL2sioEON4Dxd8McLPpTPPhR6Z4HzjSZXjpY3ubfebQrqifVVNAwMJzGBFb/wM
 q5a86VwJc7IzBoUxfHQ0f/ua2CSQVk3cNLjMtCPCasTxg4uL5YWvWo3m8BZmZwa+
 7D843T1J0fWylI4DzLcgDiJXKs0rQQFPNt//oNe73oiYXhLh9HR0OXOeG9OUJ3I2
 IgibMYbk02ICNGFV95u3OSB+wZqDi2Hs9x4rJRIeKVOnCqaYNuLEKJ+LbLXYTUi6
 H+l3NQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtratu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:45 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-45f0bfd68a3so14395608b6e.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224604; x=1772829404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=ftgCDQUQORNKSq0HHIGaetK0xSrba+bhe+bkoJOc7qPcRvT1OIdVcXMmWZqBRql/tT
 IbNQvhDUcAf/MRMNcX5le+pLGBvhZW7tc9wYSNPORWcSDgLctPltSxeEe6ca++daHDLD
 oSMWYtJAFhFX5MPUNC5lMGM/Qn9Qze/eG2ynnnx7LX3oFfKJIhuB3BeqEoRYkRDSduyP
 2M7KaBfAR+UPm4CDyR/cfxbnCBWxOo8w9pE8Kc7O42xUJcVdNc/jM9DCLGSWQR2e6xUe
 IrHUB98Gz3ELF0y3SyKOqMpG4NHwDSYok9NCZ7t5iOqPGPyPEmDRhOeh7GVn3aaS2hVZ
 4BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224604; x=1772829404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=V72B+kdHC0c5xQsC39xTC48FFI0SIwdniVxUtu3eY/w5jlTe/y8nwQ5kTI9MMsdpkJ
 N1pazzspctoXxXcl/9O+fpI4LnxEkdl3NMXtfLmh1c0R8Tq+eFxj6zcOucncAXJ9NzN3
 WTbSrVdu/IjHSseRIAZXuS8wUaI5aWdP/neI5yOlsDSkuvLZ5zpwCQEcjCi5RUFEGZM9
 Vlu5B0ZS90SsxYipGscDFGjxFvmAZoCVF12SC5W1vNGALMCWZ7LJf3hKYMMnyVOymfCk
 ZdnVhX/sNP8YIhCXImVbMveNT8IiPzmD4tCE/Fwxp0eToLntDPXUFBF3O6gkcp8X77rI
 +2mg==
X-Gm-Message-State: AOJu0YxPlizIy501McafUxvlh/rQPe1ar2bncr4/U9CHWcvXs+ZXa7F7
 8BAcSd28T93ULjOGAMkqEQHFVE9E9S7sqEBlx3JBSF4zm8ksN+ab05SoBqSXsH0LXkVl7vl4Blq
 QPchfQt3mVR9R5pDjowntPH5R8KBFXRbMyvpW4+sbYK0jEOAZISxkhPsTGt3QUvfxEw==
X-Gm-Gg: ATEYQzwOXB3+w0SMzQXxf0q6FxiM3P003mTaV8LzBrCbUmAD+BpCbaksAWroKWLEwXW
 kDjOlKXtIZBd5H2Y4xVnEt0pDISwLNVVbHtY4ztpErbt1F+w4t8ujQq8hZcT/7sGie4fp1A/H4D
 rZGaqO+Od7te9dw178SEO5a/RYKXinKIHH6u8y+U398ycZoqfXqKS+FQq9DDz8eDnBiYEiM4FWd
 zNt3HBEqqKGtf9yYxE1rR6W7C6jScXHxHScRKvasvINfjx2iYKIOW/4/hcv4b2OFHw/11xddlxi
 PClySkljwsM8LlMVCPWAClzHoSP5P3SDBQLl+8oMCe83hWek97LWLMc2Kl1Xz1VKjcIIXHFkAxG
 JXx0Gjy10PeGdxY+Ea8OMaMXqZ0CmsvZj2c0hlDZ+tCHGGJXtUO+xQOdu5tkatIiV30CEHg==
X-Received: by 2002:a05:6808:3a1b:b0:450:3e21:f567 with SMTP id
 5614622812f47-464bef821d4mr2303300b6e.56.1772224603859; 
 Fri, 27 Feb 2026 12:36:43 -0800 (PST)
X-Received: by 2002:a05:6808:3a1b:b0:450:3e21:f567 with SMTP id
 5614622812f47-464bef821d4mr2303285b6e.56.1772224603426; 
 Fri, 27 Feb 2026 12:36:43 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:42 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 07/37] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Fri, 27 Feb 2026 12:35:57 -0800
Message-Id: <20260227203627.932864-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a2005d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=orAq0Iv1PZLbcfkgE-4A:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JD6VlIC7zGNKIyJfGmRu2oRvzjZLkfhX
X-Proofpoint-ORIG-GUID: JD6VlIC7zGNKIyJfGmRu2oRvzjZLkfhX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5p+j3k15SHTR
 tsnhtDuCHAJcXkN51Oc3a9P6BrLH0VSyWyuAn42T603Trv/mFAkn4EWGeu5m4RKD18bI8e6GU2Q
 TqQPuMDo3UTdg1QhQin5py1b8M8T2kg7+dI0W1awuozHjyPs2Ji7XQOEz4N3casKmet1G0VbtBV
 KDta5NuB46WgibswPuj1cRW1y/izX+K33fqU8f6yG7FcNSGgN+kktSTDzxSM+BlbTcRZnHtM2cj
 reE2x8RQASiMbf/Ma592Rg+inGvWO63MAczOF/iwHblP9eJAZW1D91bNoz4dR69cDbnY+2BhQab
 c/lYQQ29+4wcc1loA1y8qz7FctK104uvJDOlB4/1rwNLxvS7H5wGD5qD8tl3CwmVUsw0a7hpIPN
 ftUU0hjGH/M4KVE9lzeFCVPdt/u5lCLgUsaDk4NxdJ6TYDABeFbdwVeColn2+TL+hrV7p0wlmN5
 tLIeNkyPZPtDhEQuVmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl9oZWxwZXJfZnVuY3MucHkgICAgICB8IDI2ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIHRh
cmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfcHJvdG9zLnB5ICAgICB8IDIzICsrKysrKysrKysrLS0t
LS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbl9pZGVmX3BhcnNlcl9mdW5jcy5weSB8ICAyICsr
CiB0YXJnZXQvaGV4YWdvbi9nZW5fb3BfYXR0cmlicy5weSAgICAgICAgfCAgMiArLQogdGFyZ2V0
L2hleGFnb24vZ2VuX29wY29kZXNfZGVmLnB5ICAgICAgIHwgIDUgKysrKy0KIDUgZmlsZXMgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9oZWxw
ZXJfZnVuY3MucHkKaW5kZXggNjIwNjEwNDQyNGMuLjE2MjllYmMwZTFhIDEwMDc1NQotLS0gYS90
YXJnZXQvaGV4YWdvbi9nZW5faGVscGVyX2Z1bmNzLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2dl
bl9oZWxwZXJfZnVuY3MucHkKQEAgLTEwNCwyOSArMTA0LDIzIEBAIGRlZiBtYWluKCk6CiAgICAg
dGFnaW1tcyA9IGhleF9jb21tb24uZ2V0X3RhZ2ltbXMoKQogCiAgICAgd2l0aCBvcGVuKGFyZ3Mu
b3V0LCAidyIpIGFzIGY6Ci0gICAgICAgIGZvciB0YWcgaW4gaGV4X2NvbW1vbi50YWdzOgotICAg
ICAgICAgICAgIyMgU2tpcCB0aGUgcHJpdiBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmICJB
X1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgotICAgICAgICAgICAgICAgIGNv
bnRpbnVlCi0gICAgICAgICAgICAjIyBTa2lwIHRoZSBndWVzdCBpbnN0cnVjdGlvbnMKLSAgICAg
ICAgICAgIGlmICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAg
ICAgICAgICAgICBjb250aW51ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZmxvYXRpbmcgcG9p
bnQgaW5zdHJ1Y3Rpb25zCi0gICAgICAgICAgICBpZiAiQV9GUE9QIiBpbiBoZXhfY29tbW9uLmF0
dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAgICAgICBjb250aW51ZQotICAgICAgICAgICAgIyMg
U2tpcCB0aGUgZGlhZyBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZfZGlh
ZyI6Ci0gICAgICAgICAgICAgICAgY29udGludWUKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZf
ZGlhZzAiOgotICAgICAgICAgICAgICAgIGNvbnRpbnVlCi0gICAgICAgICAgICBpZiB0YWcgPT0g
Ilk2X2RpYWcxIjoKKyAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLmdldF91c2VyX3RhZ3Mo
KToKKyAgICAgICAgICAgIGlmIGhleF9jb21tb24udGFnX2lnbm9yZSh0YWcpOgogICAgICAgICAg
ICAgICAgIGNvbnRpbnVlCiAgICAgICAgICAgICBpZiBoZXhfY29tbW9uLnNraXBfcWVtdV9oZWxw
ZXIodGFnKToKICAgICAgICAgICAgICAgICBjb250aW51ZQogICAgICAgICAgICAgaWYgaGV4X2Nv
bW1vbi5pc19pZGVmX3BhcnNlcl9lbmFibGVkKHRhZyk6CiAgICAgICAgICAgICAgICAgY29udGlu
dWUKKyAgICAgICAgICAgIGdlbl9oZWxwZXJfZnVuY3Rpb24oZiwgdGFnLCB0YWdyZWdzLCB0YWdp
bW1zKQogCisgICAgICAgIGYud3JpdGUoIiNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKVxu
IikKKyAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLmdldF9zeXNfdGFncygpOgorICAgICAg
ICAgICAgaWYgaGV4X2NvbW1vbi5za2lwX3FlbXVfaGVscGVyKHRhZyk6CisgICAgICAgICAgICAg
ICAgY29udGludWUKKyAgICAgICAgICAgIGlmIGhleF9jb21tb24uaXNfaWRlZl9wYXJzZXJfZW5h
YmxlZCh0YWcpOgorICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgICAgICBnZW5faGVs
cGVyX2Z1bmN0aW9uKGYsIHRhZywgdGFncmVncywgdGFnaW1tcykKKyAgICAgICAgZi53cml0ZSgi
I2VuZGlmXG4iKQogCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9nZW5faGVscGVyX3Byb3Rvcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9o
ZWxwZXJfcHJvdG9zLnB5CmluZGV4IDc3ZjhlMGE2YTMyLi41OWM4YmRkMDVjMCAxMDA3NTUKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9wcm90b3MucHkKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX2hlbHBlcl9wcm90b3MucHkKQEAgLTU5LDI3ICs1OSwyOCBAQCBkZWYgbWFpbigpOgog
ICAgIHRhZ2ltbXMgPSBoZXhfY29tbW9uLmdldF90YWdpbW1zKCkKIAogICAgIHdpdGggb3Blbihh
cmdzLm91dCwgInciKSBhcyBmOgotICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoK
LSAgICAgICAgICAgICMjIFNraXAgdGhlIHByaXYgaW5zdHJ1Y3Rpb25zCi0gICAgICAgICAgICBp
ZiAiQV9QUklWIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKKyAgICAgICAgZm9yIHRh
ZyBpbiBoZXhfY29tbW9uLmdldF91c2VyX3RhZ3MoKToKKyAgICAgICAgICAgIGlmIGhleF9jb21t
b24udGFnX2lnbm9yZSh0YWcpOgogICAgICAgICAgICAgICAgIGNvbnRpbnVlCi0gICAgICAgICAg
ICAjIyBTa2lwIHRoZSBndWVzdCBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmICJBX0dVRVNU
IiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAgICAgICBjb250aW51
ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZGlhZyBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAg
IGlmIHRhZyA9PSAiWTZfZGlhZyI6Ci0gICAgICAgICAgICAgICAgY29udGludWUKLSAgICAgICAg
ICAgIGlmIHRhZyA9PSAiWTZfZGlhZzAiOgorCisgICAgICAgICAgICBpZiBoZXhfY29tbW9uLnNr
aXBfcWVtdV9oZWxwZXIodGFnKToKICAgICAgICAgICAgICAgICBjb250aW51ZQotICAgICAgICAg
ICAgaWYgdGFnID09ICJZNl9kaWFnMSI6CisgICAgICAgICAgICBpZiBoZXhfY29tbW9uLmlzX2lk
ZWZfcGFyc2VyX2VuYWJsZWQodGFnKToKICAgICAgICAgICAgICAgICBjb250aW51ZQogCisgICAg
ICAgICAgICBnZW5faGVscGVyX3Byb3RvdHlwZShmLCB0YWcsIHRhZ3JlZ3MsIHRhZ2ltbXMpCisK
KyAgICAgICAgZi53cml0ZSgiI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpXG4iKQorICAg
ICAgICBmb3IgdGFnIGluIGhleF9jb21tb24uZ2V0X3N5c190YWdzKCk6CisgICAgICAgICAgICBp
ZiBoZXhfY29tbW9uLnRhZ19pZ25vcmUodGFnKToKKyAgICAgICAgICAgICAgICBjb250aW51ZQog
ICAgICAgICAgICAgaWYgaGV4X2NvbW1vbi5za2lwX3FlbXVfaGVscGVyKHRhZyk6CiAgICAgICAg
ICAgICAgICAgY29udGludWUKICAgICAgICAgICAgIGlmIGhleF9jb21tb24uaXNfaWRlZl9wYXJz
ZXJfZW5hYmxlZCh0YWcpOgogICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAKICAgICAgICAgICAg
IGdlbl9oZWxwZXJfcHJvdG90eXBlKGYsIHRhZywgdGFncmVncywgdGFnaW1tcykKKyAgICAgICAg
Zi53cml0ZSgiI2VuZGlmXG4iKQogCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkgYi90YXJnZXQv
aGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkKaW5kZXggMmY2ZTgyNmY3NmQuLjMyYmNl
OWIwMDI4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3Mu
cHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5CkBAIC02MCw2
ICs2MCw4IEBAIGRlZiBtYWluKCk6CiAgICAgICAgIGYud3JpdGUoJyNpbmNsdWRlICJtYWNyb3Mu
aC5pbmMiXG5cbicpCiAKICAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLnRhZ3M6CisgICAg
ICAgICAgICBpZiBoZXhfY29tbW9uLnRhZ19pZ25vcmUodGFnKToKKyAgICAgICAgICAgICAgICBj
b250aW51ZQogICAgICAgICAgICAgIyMgU2tpcCB0aGUgcHJpdiBpbnN0cnVjdGlvbnMKICAgICAg
ICAgICAgIGlmICJBX1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgogICAgICAg
ICAgICAgICAgIGNvbnRpbnVlCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fb3BfYXR0
cmlicy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9vcF9hdHRyaWJzLnB5CmluZGV4IGJiYmIwMmRm
M2EyLi45NGRkMWY4NzZiMiAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX29wX2F0dHJp
YnMucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX29wX2F0dHJpYnMucHkKQEAgLTM4LDcgKzM4
LDcgQEAgZGVmIG1haW4oKToKICAgICAjIyAgICAgR2VuZXJhdGUgYWxsIHRoZSBhdHRyaWJ1dGVz
IGFzc29jaWF0ZWQgd2l0aCBlYWNoIGluc3RydWN0aW9uCiAgICAgIyMKICAgICB3aXRoIG9wZW4o
YXJncy5vdXQsICJ3IikgYXMgZjoKLSAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLnRhZ3M6
CisgICAgICAgIGZvciB0YWcgaW4gaGV4X2NvbW1vbi5nZXRfYWxsX3RhZ3MoKToKICAgICAgICAg
ICAgIGYud3JpdGUoCiAgICAgICAgICAgICAgICAgZiJPUF9BVFRSSUIoe3RhZ30sQVRUUklCUygi
CiAgICAgICAgICAgICAgICAgZid7IiwiLmpvaW4oc29ydGVkKGhleF9jb21tb24uYXR0cmliZGlj
dFt0YWddKSl9KSlcbicKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl9vcGNvZGVzX2Rl
Zi5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9vcGNvZGVzX2RlZi5weQppbmRleCA5NGExOWZmNDEy
ZS4uMTdiYTNmOWRiOTUgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl9vcGNvZGVzX2Rl
Zi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fb3Bjb2Rlc19kZWYucHkKQEAgLTM3LDcgKzM3
LDEwIEBAIGRlZiBtYWluKCk6CiAgICAgIyMgICAgIEdlbmVyYXRlIGEgbGlzdCBvZiBhbGwgdGhl
IG9wY29kZXMKICAgICAjIwogICAgIHdpdGggb3BlbihhcmdzLm91dCwgInciKSBhcyBmOgotICAg
ICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoKKyAgICAgICAgZm9yIHRhZyBpbiBoZXhf
Y29tbW9uLmdldF91c2VyX3RhZ3MoKToKKyAgICAgICAgICAgIGYud3JpdGUoZiJPUENPREUoe3Rh
Z30pLFxuIikKKworICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24uZ2V0X3N5c190YWdzKCk6
CiAgICAgICAgICAgICBmLndyaXRlKGYiT1BDT0RFKHt0YWd9KSxcbiIpCiAKIAotLSAKMi4zNC4x
Cgo=

