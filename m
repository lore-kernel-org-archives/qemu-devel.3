Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5280BC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W3m-0005v3-Oq; Tue, 15 Sep 2026 12:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3f-0005u8-Sl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3e-0003mX-2F
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:30:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAgYV460951
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tfSrMHvOixY5dGSh+TQnow
 dUBlHGD6N1QdS0Wwfml6k=; b=FcUFZUnktMZ6GBSj2AHSrKSrO8YdB6qaxNQECa
 mdyJEyda26snAgGmVkSCsE19pm0n/g9sQ6rb4QBfQWx4jPaT6OVvDmCyKFczU/S2
 ji3p5Ur1SCS4azwBAF9yQY3vUYv1oVk+Uj2eZ27EkA/8/faFOM88KZl6mdvE5ZFY
 WOPND0TGo0o80oQb59LxXDbeGtvDsoILW5HoxpNRnAL3+SfWUBRya/ydlutRcJm1
 6/+ixAISQCnYbdJ1JO7LdyHBzlVyFmSu6eZBsIUB3rSD6Rw2CWe6AqROPujZnNa5
 0xSAledQFWzobq4lS22tjhnOj76IQThi1FLgClTrkolgymhw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq0jetq29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so5310025a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489856; x=1790094656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tfSrMHvOixY5dGSh+TQnowdUBlHGD6N1QdS0Wwfml6k=;
 b=NUJE+He7aeHROYk2SqSCjR/SfspOvMOujITiYUHI9TrchMC5GDBhXOcy/41Ahk8HVF
 nPwxRmLolyCXZTj3kfSn96lgpJnrj16n8FBBuWDQNT6qaRvdQFg+6zF0nyTYOdprPrFB
 Ast2bzPrevGDgqdkyjfEcdQ2mnDkdfgdcmCIqj5FkZWk13xd1aITuNxTIXIr+F9yul4R
 qm0Hr6gLq4kpI5Y1ymFmexGCqYG5PEohcxLdBL/1YHhNAaP6kAimAGgv4sBuBhbVKYpa
 7135wIHHNCXZh1E7YgIdBh0fgMJj2sbe4+6EQhpfJoO2jIWi2e9VgGRk8TaJR1kr6ilb
 8pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489856; x=1790094656;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tfSrMHvOixY5dGSh+TQnowdUBlHGD6N1QdS0Wwfml6k=;
 b=JqYWTQDY/EdBQsjYCMK9tk8/Wk6ddAQEE5LRFI/yv5Z7MWeEjGzj8bKKrc9xnb3HGK
 FKw7FXcef4EjfLmv5jhBAYShgyzEdAv2hsSXe5ZdAMBw+y2xur1pjAPnxy7DPU8UfiYp
 7QoqUsRDLZWUhSsQUsKgSyW6pgWPh44e6ZeNsff0O9hUmccsZFABSTq+0bCeRtFBbkEq
 XjHR8Q9l/+OTOFleTicnW+fVzz2redGpud9unxBMk88C8Y5Kjtb6mjKvkcb23R7AeWP/
 7SdtEVhiaXBKkEMDz2SgbEOY2ynxAnNSaSTWu2EkoMhGDmaVKKzqdqlIH/UIsMlBWx4t
 nyCQ==
X-Gm-Message-State: AFuF++mgkCM6gh6Zjim9Ygjty3A3oqvSWgSBzGsq9zIaDjKv5WE5ENIz
 fcgmrovpy7cgw1glzrLOkDseHGQ6TCKv9E1m/Q/BSFGCBroxUAy4ejSLH4+ZBkqlbkrFhFiUzav
 yDQcxRof2aqglpR62xYuojIQyp+8fQR0TCUS486TODruHxPwAepstB1wa3EH0t5+WTw==
X-Gm-Gg: AYBFou30X9hvOunC7yr8wiBaSup6McwazO6kQLDdPw3Kklvfzk/EvbWip2zb9PVP+Jz
 EuU3yuMjFRmGApoQuNq3MC2sObra1neAjV04kDkJleZy1FUP29ou+LrXv9NLdxNzfRml8zkETpQ
 h3uiyue8aqCyXj0Rqu5Nh7XYrj4Xg7t0K229QHSxxug4EvumU3GvrfNw8VsRM8ThG6GAZJ8V51t
 CNHrX/innjagkF9tjRiRitq2177fKIPAPdsQ2z+mJE3u3cZTp9KH+eBHWfa4KKRtoROPoRck3VP
 qKcVSxjNOglXSo4Rpq94z2g5MXCL/USGfLF2oYE2DBIzUp6rEA8d8a+YPot4B2MPrfMgUaDn2TZ
 usaJZKkaN8POJhROa/yWeC5qYbqQQuq3pvzgyWHYPX7H/l1Je
X-Received: by 2002:a17:90b:5284:b0:39d:f130:8f13 with SMTP id
 98e67ed59e1d1-39e1100eeb8mr3097463a91.21.1789489851675; 
 Tue, 15 Sep 2026 09:30:51 -0700 (PDT)
X-Received: by 2002:a17:90b:5284:b0:39d:f130:8f13 with SMTP id
 98e67ed59e1d1-39e1100eeb8mr3097042a91.21.1789489849112; 
 Tue, 15 Sep 2026 09:30:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 00/17] hexagon: TCG test coverage + ubsan fixes
Date: Tue, 15 Sep 2026 09:30:30 -0700
Message-Id: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX9xsQLEvhAIhh
 2vW8ooYJYpOYfJDi7srdHkLIqYsFUoaw/boF+GppzY14HQlNIE7yCLhtSWKKCdGoAV/DdAvk6gT
 NOZ0+xTPDNWLKZXgsGSUwBhQaS9bYJQ=
X-Authority-Analysis: v=2.4 cv=Kr/YSmWN c=1 sm=1 tr=0 ts=6aa972c0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jfu7CTnWvCVQP5h_nMQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: _60VB84IL7cuFLITPlQNExfxXRduxOYU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfXwwZ1xzvAxTgo
 HbQgv15dHexIxIMqJhm/aF2x6v9pQlglKrivrpkcBO7+SxitB6+tZ/MKaLN7kjluDQpD/4AWzLR
 MThaoYH1AKKPzHfEKCSQsgDjReL5nzJRUkgBYWQQr9R0YKxBbDe2ryzHsuqec7rxG0P7EjzKi5j
 jO0nHGe4nWj1NW1kr4kpdnOkOcEB2CjjlMLFYeht9QspWMO+jw0otVlPjr2uxWk4PQkKhgqjmwV
 uATXNRkRgB0GTejiDeX2B/Su4ZuXrOLbAIg/WtclH20baCJG0wRc07PcFhWdD3p7Tmts8bwZNib
 TkfxZIgLr8EhtZ7BPxBaqJsuw8QTm/CszgqohAl51EgugpBRjJlMIvdKo6WWN2JaHeMMZbKy87R
 NFvwwA9S3+698JeQDc6mp+QP4cPFFPDRNkSesyOcW4d4JWG/3SKUerkS/NmqtNtdqVJTIPOSTZO
 arcC18Yyw7BsyYKOHHw==
X-Proofpoint-ORIG-GUID: _60VB84IL7cuFLITPlQNExfxXRduxOYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150239
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

UnVubmluZyBhIGNvdmVyYWdlIGJ1aWxkIGlkZW50aWZpZWQgc29tZSBnYXBzIGluIHRoZSBjb3Zl
cmFnZSBvZiB0cmFuc2xhdGlvbgpjb2RlLiAgTmV3IHRlc3RzIGFyZSBhZGRlZCBoZXJlIHRvIGNs
b3NlIHNvbWUgb2YgdGhvc2UgZ2Fwcy4KCkFmdGVyIHJ1bm5pbmcgdWJzYW4gb24gdGhlIGhleGFn
b24gVENHIHRlc3RzLCBzb21lIHRlc3RzIHdlcmUgZmxhZ2dlZAphcyBoYXZpbmcgdW5kZWZpbmVk
IGJlaGF2aW9yLiAgRml4ZXMgZm9yIG1hbnkgb2YgdGhvc2UgaXNzdWVzIGFyZSBpbmNsdWRlZC4K
CkluIHYyOgotIHVwZGF0ZWQgdndoaXN0IHRlc3QgdG8gdXNlIHRoZSBjaGVjazMyKCkgZnJvbSBo
ZXhfdGVzdC5oLCBtb3ZlZCBjaGVjazE2KCkKdGhlcmUuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkwNTE4MDk0OS4xODUyNjczLTEtYnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoMTcpOgogIHRlc3RzL3RjZy9oZXhhZ29uOiBmaXgg
dW5kZWZpbmVkIHNpZ25lZCBsZWZ0IHNoaWZ0IGluIGNpcmMuYwogIHRlc3RzL3RjZy9oZXhhZ29u
OiBmaXggdW5kZWZpbmVkIHNpZ25lZCBsZWZ0IHNoaWZ0IGluIGJyZXYuYwogIHRlc3RzL3RjZy9o
ZXhhZ29uOiBmaXggdW5kZWZpbmVkIHNpZ25lZCBpbnRlZ2VyIG92ZXJmbG93IGluIGh2eF9taXNj
CiAgdGVzdHMvdGNnL2hleGFnb246IGZpeCB1bmRlZmluZWQgaW50ZWdlciBvdmVyZmxvdyBpbiB2
NjlfaHZ4LmMKICB0ZXN0cy90Y2cvbXVsdGlhcmNoOiBzdXBwcmVzcyBVQlNhbiBmb3IgZmxvYXQt
dG8taW50IGNvbnZlcnNpb25zCiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCBGUCBjbGFzc2lmaWNh
dGlvbiwgY29udmVyc2lvbiwgYW5kIGZpeHVwIHRlc3RzCiAgdGVzdHMvdGNnL2hleGFnb246IGFk
ZCBiaXQgaW50ZXJsZWF2ZSBhbmQgY29udmVyZ2VudCByb3VuZGluZyB0ZXN0cwogIHRlc3RzL3Rj
Zy9oZXhhZ29uOiBhZGQgY29uZCBjYWxsLCB0c3RiaXQtanVtcCwgYW5kIGVuZGxvb3AwMSB0ZXN0
cwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgZGN6ZXJvYSBjYWNoZSBsaW5lIHplcm8gdGVzdAog
IHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgSFZYIHZ3aGlzdCB0ZXN0cwogIHRlc3RzL3RjZy9oZXhh
Z29uOiBhZGQgc2ZyZWNpcGEgZWRnZSBjYXNlIHRlc3RzCiAgdGVzdHMvdGNnL2hleGFnb246IGFk
ZCBkZm1weWhoCiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCB1bmNvbmRpdGlvbmFsIHN0b3JlLWlt
bWVkaWF0ZSB0ZXN0cwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgcHJlZGljYXRlIHJlZ2lzdGVy
IHRyYW5zZmVyIHRlc3QKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHJvdW5kaW5nIGNvbnYsIHNm
Zm1hOmxpYiwgYW5kIHNmaW52c3FydGEKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHNjYWxhcitI
VlggYW5kIG1hc2tlZCBzdG9yZSB0ZXN0cwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgZGVjYmlu
IE1QUyB0ZXN0IGNhc2UKCiB0ZXN0cy90Y2cvaGV4YWdvbi9oZXhfdGVzdC5oICAgICAgICAgfCAg
MTAgKwogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuaCAgICAgICAgIHwgICAxICsKIHRlc3Rz
L3RjZy9oZXhhZ29uL2JyZXYuYyAgICAgICAgICAgICB8ICAgMiArLQogdGVzdHMvdGNnL2hleGFn
b24vY2lyYy5jICAgICAgICAgICAgIHwgICA2ICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZm
LmMgICAgICAgICAgfCA0MTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cv
aGV4YWdvbi9odnhfbWlzYy5jICAgICAgICAgfCAgODQgKysrKystCiB0ZXN0cy90Y2cvaGV4YWdv
bi9taXNjLmMgICAgICAgICAgICAgfCAgNzkgKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3Rf
Yml0b3BzLmMgICAgICB8ICA5OCArKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2NvbmRf
YnJhbmNoLmMgfCAxNjIgKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJv
YS5jICAgICB8ICA4OCArKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfdndoaXN0LmMgICAg
ICB8IDM0NSArKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi92NjlfaHZ4
LmMgICAgICAgICAgfCAgIDMgKy0KIHRlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29udmQuYyAg
ICB8ICAgMSArCiB0ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2NvbnZzLmMgICAgfCAgIDEgKwog
dGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgIHwgICA0ICsKIDE1IGZpbGVzIGNo
YW5nZWQsIDEyODIgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvdGNnL2hleGFnb24vdGVzdF9iaXRvcHMuYwogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfY29uZF9icmFuY2guYwogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvdGNnL2hleGFnb24vdGVzdF92d2hpc3QuYwoKLS0gCjIuMzQuMQoK

