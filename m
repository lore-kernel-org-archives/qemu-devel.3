Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F7FD88F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B42-0006ZW-24; Wed, 11 Mar 2026 00:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3l-0006Nl-G2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3h-00032R-HC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJHPsJ3418255
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o59QlMJ1QAXt5M0RvXScFMcmPWrRQdvrrP4HTAeBxRk=; b=V5zssyZYjptbadr9
 esjVUGOuX8pV26TC/c3JNVd2VJs3e23IKSw1arhlHWCIsCyaTtsXMw/HfxlBvuEW
 JrFclNaAez5OeEnmY0T3+U3feHtMeq/p4JersCwG5jmNK6kZPIDQF1FS6vQKGZpC
 S+dNJdIqZFgHGWfUWJSDh1Cc1yzT67kM44usDhMfp/y+AQYo+7r0YtqWEXeNPJSf
 N4qJAX4nPnYN8ks0fXnNz9GviRr2aEQ/upHYXnW1dvl6s9kVt+p9iab9TbvTt7JB
 1FSwl2DyLs16AjxZrEeJNSoTmLlHil+A4eu1/OXp04QkF6QdbJT0EpXdm0Ev4nVL
 nybavg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2bb8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:32 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d7536294fcso4828251a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202831; x=1773807631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o59QlMJ1QAXt5M0RvXScFMcmPWrRQdvrrP4HTAeBxRk=;
 b=jIlWs5frlkh5K50sGtDOAbBzcMM38WRlQCVIVFEEVCjeLUWsuFNl+yCltukSJgmZZj
 lez9D47h8eJgxkyF7i3qpFWKRigOFKT3beH2hwu6h6cN3AUoLU7ItuIR7Dioq8oNBzAR
 WQTeRWXypJkZoD9j9r2nosAssO4hsn3AwlbP7CUCddRyRnNk6pCSpPAl0DFae7O40rrT
 J8fdy7pTRDvO4Z/yc9O+ee5GVkwmQ1bznP1aDLyA8u78C1S3CNE0bjmNbtWj+Q/4W167
 WqozYLMb4bu7QOENTbTvOg9rDyhJw6L2PYYgCS0IEBoDWglfnMNnWCXKtZNzkXt30ftP
 Ry+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202831; x=1773807631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o59QlMJ1QAXt5M0RvXScFMcmPWrRQdvrrP4HTAeBxRk=;
 b=EHd4uxU1unXSGwkv2UEgHMACwlcBsuFjtGQzDqIklwXwqf4sANaCauRU/mFUepM81Y
 YMIAsRO3tCpiVE2hck0aZNesy0/EIWd6uhT3E3JTH+1EMD/v6D8DcCTA8hng3TBfCSIv
 zFWMxHz0EPkAt401iJvUsUF0tqHSs7UXfJknqji7AinmlVGWDVDXLW+ir7mqNa7y5ZIQ
 iTYys1Jps8knzQGW7HC3BUZpz8gkVIGIBrpSxsaGFOx3yRFtRJwrbnpReVtfv+yart7D
 OHYFk3AJ3UQ2TCiJrOcNPD6tlWLn70MgNs+xG/dspoJsmlBgEAo5XItbkBhOEj3e0bN7
 1Itg==
X-Gm-Message-State: AOJu0Yzs2I0vzhWrLisTOOkJeUTdX4tHMIoqIjmA9PaNmKhIwReeBPyw
 gPgGYYy7+iVnh34VZMsS39p0rkyE8Vt9GZ6a3FCuoE0UBu9tcQJ2aYIDFEPMvVS4WbAaZral2Y/
 MPuO5O/K+BC+l8iNj1bCosrpvvlNKTYSKJ5Cc2Wt6wIIPR+tTJ/VkzS8aztToU5ZJRw==
X-Gm-Gg: ATEYQzyylOZNwydmQg+cEV0JAuR9oOCSdBW55DxOAjVw5u2iNn4NjvldOsUFi4GC/Ts
 AOkjFdQvMUo5YiTauDVud+c884KvB9xvxvZcArxpHURBTpu0O8+XGYT9wSKgos956qaWHng7NSF
 PuvovmzdKZev324EuNkovFIdL0ZQ+qZwNmaF2p++DzRk2H/ccoe5Ci8ce234eZtSRCNhMM3HHCN
 A0QXbvBQfQRwHAYhdt7HPyL7cbuJwELxUGqR0ibw7mYDbsoV7raoKQoNU1QkYeXd4f4MoWjWwvv
 dZqsTIxVofN0xmqSl41cucQ+OqAtYzAOn6LryvLPahE5ICn3xEml1m9IYZpN2M294eWjMThrKMZ
 0FnqhsxB7sthbY6KYb66a3wonISd9YP1Z+XSJGKDzwBOSvHjlBb8+djMdDU/+GVoDzm+Dog==
X-Received: by 2002:a05:6830:82fa:b0:7d7:58b0:769e with SMTP id
 46e09a7af769-7d76afab4camr809813a34.3.1773202831647; 
 Tue, 10 Mar 2026 21:20:31 -0700 (PDT)
X-Received: by 2002:a05:6830:82fa:b0:7d7:58b0:769e with SMTP id
 46e09a7af769-7d76afab4camr809799a34.3.1773202831319; 
 Tue, 10 Mar 2026 21:20:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 7/9] target/hexagon: add build config for softmmu
Date: Tue, 10 Mar 2026 21:20:17 -0700
Message-Id: <20260311042019.1085030-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b0ed90 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qti4gPp8nJWhuP28z54A:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: NRS0qqsr2MBAdqdd-9In5JZTO-YRB3_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfXyO76BfqSBcDl
 bljEhKZnKgpRBHNYbZ4QS6Q/OHCZgmiBH1sD8UZhZLXbcAplxte0gVom47QTq0LLIE/SwEODkKa
 49IK0rkD2fGrXdJbvkHaoQdzf2+R/2weXvbiZAl5sCfW9luNORdO2GOF8ucP1hS3puHOejCXWB5
 3zNuWb9SZpbjuZVyXgLBzF8uSNwnASBCFDnravoABrPKSSwNwgJUrvSQwKbrX9savNwI23+glzj
 iIMvPhRk0knoYtz5kNQkJ8IjbseHzVFe+Xlt7LgNuNoXhPDeqXIkBcbtyl88mTB7EOFAspUtd7R
 ZwL2hmz3jcrMeKbUasT55JGFvu2H1AXAfbZ8vdsi2KbFF5kDF6KPn/nK9SDUZmlbol+wzrdkGqd
 BBe7RbfjWBnJNqq9kvH9QZOx9Xj1nLxinfSYgZ+EExxi3Ta12f72alP6oSqARiUDNltfhuTdoBM
 w9PzCjw6DTk7+/hi90Q==
X-Proofpoint-GUID: NRS0qqsr2MBAdqdd-9In5JZTO-YRB3_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogY29u
Zmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayB8ICA3ICsrKysrKysKIGNv
bmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrICAgICAgICAgfCAgNiArKysrKysKIHRh
cmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCAtLS0tCiB0YXJn
ZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hl
eGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdv
bi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrLQogNyBmaWxl
cyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL0tjb25maWcKCmRpZmYgLS1naXQgYS9NQUlOVEFJ
TkVSUyBiL01BSU5UQUlORVJTCmluZGV4IGQzMjQ3MDFhZTA1Li5kOWQ0Y2RhNGQwYiAxMDA2NDQK
LS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI1Myw2ICsyNTMsNyBAQCBG
OiBsaW51eC11c2VyL2hleGFnb24vCiBGOiB0ZXN0cy90Y2cvaGV4YWdvbi8KIEY6IGRpc2FzL2hl
eGFnb24uYwogRjogY29uZmlncy90YXJnZXRzL2hleGFnb24tbGludXgtdXNlci9kZWZhdWx0Lm1h
aworRjogY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawogRjogZG9j
a2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlcgogRjogZ2RiLXhtbC9o
ZXhhZ29uKi54bWwKIEY6IGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdApkaWZmIC0tZ2l0
IGEvY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayBiL2NvbmZpZ3Mv
ZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAuLjA4ZTcwOWFlYTcyCi0tLSAvZGV2L251bGwKKysrIGIvY29uZmln
cy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawpAQCAtMCwwICsxLDcgQEAKKyMg
RGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29uLXNvZnRtbXUKKworIyBVbmNvbW1lbnQg
dGhlIGZvbGxvd2luZyBsaW5lcyB0byBkaXNhYmxlIHRoZXNlIG9wdGlvbmFsIGRldmljZXM6CisK
KyMgQm9hcmRzIGFyZSBzZWxlY3RlZCBieSBkZWZhdWx0LCB1bmNvbW1lbnQgdG8ga2VlcCBvdXQg
b2YgdGhlIGJ1aWxkLgorIyBDT05GSUdfSEVYX0RTUD15CisjIENPTkZJR19MMlZJQz15CmRpZmYg
LS1naXQgYS9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayBiL2NvbmZpZ3MvdGFy
Z2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwLi40MmUxZTVjNGY4MwotLS0gL2Rldi9udWxsCisrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9o
ZXhhZ29uLXNvZnRtbXUubWFrCkBAIC0wLDAgKzEsNiBAQAorIyBEZWZhdWx0IGNvbmZpZ3VyYXRp
b24gZm9yIGhleGFnb24tc29mdG1tdQorCitUQVJHRVRfQVJDSD1oZXhhZ29uCitUQVJHRVRfU1VQ
UE9SVFNfTVRUQ0c9eQorVEFSR0VUX1hNTF9GSUxFUz1nZGIteG1sL2hleGFnb24tY29yZS54bWwg
Z2RiLXhtbC9oZXhhZ29uLWh2eC54bWwKK1RBUkdFVF9MT05HX0JJVFM9MzIKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggNjE2OGZl
YTNiNWYuLjkzZTRkNDg4YmU5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMzUsMTAgKzM1LDYgQEAKICNpbmNsdWRlICJtbXZl
Yy9tbXZlYy5oIgogI2luY2x1ZGUgImh3L2NvcmUvcmVnaXN0ZXJmaWVsZHMuaCIKIAotI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCi0jZXJyb3IgIkhleGFnb24gZG9lcyBub3Qgc3VwcG9ydCBzeXN0
ZW0gZW11bGF0aW9uIgotI2VuZGlmCi0KICNpbmNsdWRlICJyZWdfZmllbGRzLmgiCiAKICNkZWZp
bmUgTlVNX1BSRUdTIDQKZGlmZiAtLWdpdCBhL3RhcmdldC9LY29uZmlnIGIvdGFyZ2V0L0tjb25m
aWcKaW5kZXggM2M3M2UzYmFlMDEuLjAyODhhM2Y0MTY0IDEwMDY0NAotLS0gYS90YXJnZXQvS2Nv
bmZpZworKysgYi90YXJnZXQvS2NvbmZpZwpAQCAtMTYsNiArMTYsNyBAQCBzb3VyY2Ugc2g0L0tj
b25maWcKIHNvdXJjZSBzcGFyYy9LY29uZmlnCiBzb3VyY2UgdHJpY29yZS9LY29uZmlnCiBzb3Vy
Y2UgeHRlbnNhL0tjb25maWcKK3NvdXJjZSBoZXhhZ29uL0tjb25maWcKIAogY29uZmlnIFRBUkdF
VF9CSUdfRU5ESUFOCiAgICAgYm9vbApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vS2NvbmZp
ZyBiL3RhcmdldC9oZXhhZ29uL0tjb25maWcKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAuLjdlNTU2ZjM1MDYzCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24v
S2NvbmZpZwpAQCAtMCwwICsxLDIgQEAKK2NvbmZpZyBIRVhBR09OCisgICAgYm9vbApkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5i
dWlsZAppbmRleCA1MjhiZWNhM2NkMC4uYmM3YTI5MmU0N2IgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0y
MzUsNiArMjM1LDcgQEAgZGVjb2RldHJlZV90cmFuc19mdW5jc19nZW5lcmF0ZWQgPSBjdXN0b21f
dGFyZ2V0KAogICAgIGNvbW1hbmQ6IFtweXRob24sIGZpbGVzKCdnZW5fdHJhbnNfZnVuY3MucHkn
KSwgc2VtYW50aWNzX2dlbmVyYXRlZCwgJ0BPVVRQVVRAJ10sCiApCiBoZXhhZ29uX3NzLmFkZChk
ZWNvZGV0cmVlX3RyYW5zX2Z1bmNzX2dlbmVyYXRlZCkKK2hleGFnb25fc29mdG1tdV9zcyA9IHNz
LnNvdXJjZV9zZXQoKQogCiBoZXhhZ29uX3NzLmFkZChmaWxlcygKICAgICAnY3B1LmMnLApAQCAt
MjUzLDYgKzI1NCwxNCBAQCBoZXhhZ29uX3NzLmFkZChmaWxlcygKICAgICAnbW12ZWMvc3lzdGVt
X2V4dF9tbXZlYy5jJywKICkpCiAKK2hleGFnb25fc29mdG1tdV9zcy5hZGQoZmlsZXMoCisgICAg
J2NwdV9oZWxwZXIuYycsCisgICAgJ2hleF9tbXUuYycsCisgICAgJ2hleF9pbnRlcnJ1cHRzLmMn
LAorICAgICdoZXhzd2kuYycsCisgICAgJ21hY2hpbmUuYycsCispKQorCiAjCiAjIFN0ZXAgNC41
CiAjIFdlIHVzZSBmbGV4L2Jpc29uIGJhc2VkIGlkZWYtcGFyc2VyIHRvIGdlbmVyYXRlIFRDRyBj
b2RlIGZvciBhIGxvdApAQCAtMjYyLDcgKzI3MSw4IEBAIGhleGFnb25fc3MuYWRkKGZpbGVzKAog
IyAgICAgaWRlZi1nZW5lcmF0ZWQtZW5hYmxlZC1pbnN0cnVjdGlvbnMKICMKIGlkZWZfcGFyc2Vy
X2VuYWJsZWQgPSBnZXRfb3B0aW9uKCdoZXhhZ29uX2lkZWZfcGFyc2VyJykKLWlmIGlkZWZfcGFy
c2VyX2VuYWJsZWQgYW5kICdoZXhhZ29uLWxpbnV4LXVzZXInIGluIHRhcmdldF9kaXJzCitpZiBp
ZGVmX3BhcnNlcl9lbmFibGVkIGFuZCAoJ2hleGFnb24tbGludXgtdXNlcicgaW4gdGFyZ2V0X2Rp
cnMgb3IKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAnaGV4YWdvbi1zb2Z0bW11JyBpbiB0
YXJnZXRfZGlycykKICAgICBpZGVmX3BhcnNlcl9pbnB1dF9nZW5lcmF0ZWQgPSBjdXN0b21fdGFy
Z2V0KAogICAgICAgICAnaWRlZl9wYXJzZXJfaW5wdXQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6
ICdpZGVmX3BhcnNlcl9pbnB1dC5oLmluYycsCkBAIC0zOTAsMyArNDAwLDQgQEAgYW5hbHl6ZV9m
dW5jc19nZW5lcmF0ZWQgPSBjdXN0b21fdGFyZ2V0KAogaGV4YWdvbl9zcy5hZGQoYW5hbHl6ZV9m
dW5jc19nZW5lcmF0ZWQpCiAKIHRhcmdldF9hcmNoICs9IHsnaGV4YWdvbic6IGhleGFnb25fc3N9
Cit0YXJnZXRfc3lzdGVtX2FyY2ggKz0geydoZXhhZ29uJzogaGV4YWdvbl9zb2Z0bW11X3NzfQot
LSAKMi4zNC4xCgo=

