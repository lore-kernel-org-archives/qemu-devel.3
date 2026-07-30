Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FEDC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZc-0005eO-4a; Wed, 29 Jul 2026 21:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZb-0005dz-2S
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZZ-0005ZW-Dt
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1JCZn3662808
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 voZe0rvcTWu/Ku3hUtr2oUYQyHSA5bpwIbj31wP9mSo=; b=KlaFR/MBr+gwn9GN
 IqXFTzlm6vBB3m2hxXW1lxykb5HyOU5s9P2WDRuhdDQOPe8SJI3akE3y+SGT54bq
 77526pf0wQPmwrXuxc00zYPSx9cmo6/O2J0Oah2XedGlMc3P0nygH1DEW5ntdrMc
 IgWoV/+WXhJFvVvbiNTcJ9m1j3gowGv5eozziYKxRZbN6X6470sQe+UAms7Z66zL
 VF0PxyKyqgsHLqHR/HLXvLrxTnwyiF01qLG15JGhK4w6eajwMDt2ivil9lM2uLfF
 Qv0V6JbwhJzPUtLTXMJIsWbSoSISVw+76yyy84ZYGnWzeqLKePkFQowme1uTYm+F
 8VEzjA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvujr0rd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so1799151b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374911; x=1785979711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=voZe0rvcTWu/Ku3hUtr2oUYQyHSA5bpwIbj31wP9mSo=;
 b=L0SgOROK+eXqx2p0fOM+AQ598AQVPbXDmc7J4FVwB5+qI6PysSvy0Ex20mKjtsbqe0
 dZD8zXu/s6bP+PozvpRuTm/dvGAE93mkONI8K1sU4nk7qYz8hmCtoZUEScOumHQh3Z72
 3JG2aOgsZ6Qi2zWhkur7MwCWPi2nbb0YpIRlIlG2PoC5lGAN0c1FJZu+2r8h0CtgJQbt
 s9Zxfo1D7fzelhCTJj3dnCmTQzkWwI2g4BYnaLevotMpMx+wd47TC0BuCLfJBbNqmRMa
 GlkQvW44dSa6XljHO8oBb88+ncMA/Xvg3/l0Go3Gfw7f89K4RsMkbJsUe0l3EEogrqcr
 r4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374911; x=1785979711;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=voZe0rvcTWu/Ku3hUtr2oUYQyHSA5bpwIbj31wP9mSo=;
 b=ZoRBTJOw+bz6nSDKt2k82cmnrua4/K7N0AFEXXuVYiWxTb2Ud+glC/VrnAmLTYUwoA
 MaHoyN4TSQYWO9rhZWqSOhGcQjx9jzhCWYvYm1OUxguzjiDXx+RnTcYyAig7Ltwa4xnL
 BM5dCwAqclln2QFmelovonZdidTyXGSLVDnwrxmxOi+v/U0m4hierrPVC5mTwz5Vtc5P
 Wwr7Fh5b0B7Yt1VyuVHJueUTfyxhheDJ88eiPbT9YQZvw9qPV5yUxAVhpD8Ih9y5jYe8
 x4ORDto5DKh+olN75C7LjhPBPwZOkcaDggpPmqayXJKOf5dCXcrq5qC7W4C4cWIMwv0R
 8PEA==
X-Gm-Message-State: AOJu0Yw4atfuGnHpV/O5wqY48AQuSb+Eh/32ejecW+aIdVL2c7m/0u/F
 1K3y+UkA+u0ILRviwFsVgTPM1PAeabselrFRuRIxEPbpHQjl7T2E65VApFzs5PaWhxS+HhbLaFG
 tIWN3FdtkPvyRWVxC8LQjfJWP6yL0DOHz4VClVdQ6fOD8k4g2J8MP+pyTVeNMR54goA==
X-Gm-Gg: AR+sD124niHLzuFLNYkaee3FN+U0jFEn9LPupuDoGWw2VMsQP4WIrScOEyZ6xM+1V9D
 DNTRbdW2rOmAwbgm5efxQOIK/S99w0EVwJOsF38+l13qaaRBgQ85F//Zd3pPFChzOHrYvP0Ulsp
 0nJHh+4EF5xvOkvi5kiZocg1yomQEq2kJsdQ0ek8iHoRlsmRGQ1IAfO+6hZnafULrNy4WOvB0sv
 3kxofctLsqLEN6QwUk2osLMRcAoOzrXlL6TH6RaVHxsyeLsUob/YlTfGFRMjIF6qUkUKI4X2xDO
 HHhLpghb6Rwx2OPkTg9JIj4wb4TnoKSYiIecldbnQr+iCB/aRu7l0XwRcTFIlt4PZ1apkMIJGTo
 B/xxNGzXzmGU4YzTvx0KJ0/l8yZT9wMRwBD1iokZLTTJrfuCi
X-Received: by 2002:a05:6a21:134b:b0:3c0:4269:47bb with SMTP id
 adf61e73a8af0-3c9008ac5f3mr431596637.52.1785374911459; 
 Wed, 29 Jul 2026 18:28:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:134b:b0:3c0:4269:47bb with SMTP id
 adf61e73a8af0-3c9008ac5f3mr431570637.52.1785374911033; 
 Wed, 29 Jul 2026 18:28:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 04/18] hw/hexagon: move the TLB to hex-subsys
Date: Wed, 29 Jul 2026 18:28:09 -0700
Message-Id: <20260730012824.1135905-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfXwhey6+V0JVCV
 nMTUjUSdnJm9WZ5KXwaOX82S79X8e9BdeOEHyoF0RooC7Ul/ZUM1zmFvrdL9wwSP03oP6qkmCsA
 B90USx8RwPc6aGPQhJRe9tQtWnKz4OE=
X-Proofpoint-ORIG-GUID: IxBAYDJ2VDcvk-qYKJMGD63owIcYo3eN
X-Authority-Analysis: v=2.4 cv=KpR9H2WN c=1 sm=1 tr=0 ts=6a6aa8c0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qVS_p__ePFo4ISZweN8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: IxBAYDJ2VDcvk-qYKJMGD63owIcYo3eN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfXz+RSdgnwnWud
 ENtXmezPazX5GRdXe0FOkvbJqJnYaBL7ybba4M3JVTF45PNc20mVmfqpAlkXHKsYV6OMOv5p2CO
 Qb+9Gv4eb2YdhMfHQJ8UtS6kC0iiudkE2Kg6w/iC601ZGsj140VLNoXHcqXOywIgKAdPl+ac/TG
 gBeKEqPjcxFP93vEZemHcrg0yZoHuLxrQaKr6FbomaAWkABTceysHxIVskHiZPJJeROv1qXwgje
 xVzYFSSzuPThPuejLSfqt4qD17VaZfWlFThMQZ60veirLqDrGT773vcag+R4mQ8i5bBL+TYXUpi
 6Bst0e/xE70Bp1OsZgfbRhSW+GpBCY9zyFMBtozX0jw29N4Tb7YyUymNpYTdgbY3S9WfmlVwlvD
 STLTKvXh3zKjdhoP5I5yToSoXB+EvYr+1V1+2mVl+ssBTJmIBibvpnlw2/ZQRz2yfccQeR3aNqT
 5c0K+ouDrthbrZc2NYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300007
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

VGhlIFRMQiBkZXZpY2UgaXMgc2l6ZWQgZnJvbSB0aGUgY29uZmlnIHRhYmxlLCBzbyBib3RoIG1h
Y2hpbmVzIGNyZWF0ZQppdCBpZGVudGljYWxseS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4
YWdvbi5oIHwgIDEgKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDE2ICsrKysrKysr
KysrKysrKysKIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgfCAxMCAtLS0tLS0tLS0tCiBo
dy9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgIHwgMTAgLS0tLS0tLS0tLQogNCBmaWxlcyBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L2hleGFnb24vaGV4YWdvbi5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaApp
bmRleCBlZjU3MDAwODJjYy4uNmVkZDkzZjQ3OGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uLmgKKysrIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaApAQCAtMTU4
LDYgKzE1OCw3IEBAIHN0cnVjdCBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlIHsKICAgICBNZW1v
cnlSZWdpb24gY2ZndGFibGVfcm9tOwogICAgIE1lbW9yeVJlZ2lvbiB2dGNtOwogICAgIERldmlj
ZVN0YXRlICpnbG9iX3JlZ3M7CisgICAgRGV2aWNlU3RhdGUgKnRsYjsKIH07CiAKICNlbmRpZgpk
aWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgYi9ody9oZXhhZ29uL2hleC1zdWJz
eXMuYwppbmRleCA2Nzg5YjZiYjIzZC4uYWM3ZTI5NjA0ZWIgMTAwNjQ0Ci0tLSBhL2h3L2hleGFn
b24vaGV4LXN1YnN5cy5jCisrKyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCkBAIC05LDYgKzks
NyBAQAogI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleC1z
dWJzeXMuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgiCisjaW5j
bHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oIgogI2luY2x1ZGUgImh3L2NvcmUvbG9hZGVy
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNsdWRlICJody9j
b3JlL3FkZXYuaCIKQEAgLTI5LDYgKzMwLDE4IEBAIHN0YXRpYyBEZXZpY2VTdGF0ZSAqZ2xvYmFs
cmVnX2NyZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgcmV0dXJuIGds
b2JfcmVnczsKIH0KIAorc3RhdGljIERldmljZVN0YXRlICp0bGJfY3JlYXRlKEhleGFnb25Db21t
b25NYWNoaW5lU3RhdGUgKmhtcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyAqbV9jZmcpCit7CisgICAgRGV2aWNlU3Rh
dGUgKnRsYiA9IHFkZXZfbmV3KFRZUEVfSEVYQUdPTl9UTEIpOworCisgICAgb2JqZWN0X3Byb3Bl
cnR5X2FkZF9jaGlsZChPQkpFQ1QoaG1zKSwgInRsYiIsIE9CSkVDVCh0bGIpKTsKKyAgICBxZGV2
X3Byb3Bfc2V0X3VpbnQzMih0bGIsICJudW0tZW50cmllcyIsIG1fY2ZnLT5jZmd0YWJsZS5qdGxi
X3NpemVfZW50cmllcyk7CisgICAgc3lzYnVzX3JlYWxpemVfYW5kX3VucmVmKFNZU19CVVNfREVW
SUNFKHRsYiksICZlcnJvcl9mYXRhbCk7CisKKyAgICByZXR1cm4gdGxiOworfQorCiB2b2lkIGhl
eF9zdWJzeXNfY3JlYXRlKEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcywKICAgICAgICAg
ICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGhleGFnb25fbWFjaGluZV9jb25maWcgKm1fY2Zn
LCBSZXZfdCByZXYpCiB7CkBAIC01NywxMSArNzAsMTQgQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0
ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgfQogCiAgICAgaG1zLT5nbG9i
X3JlZ3MgPSBnbG9iYWxyZWdfY3JlYXRlKGhtcywgbV9jZmcsIHJldik7CisgICAgaG1zLT50bGIg
PSB0bGJfY3JlYXRlKGhtcywgbV9jZmcpOwogfQogCiB2b2lkIGhleF9zdWJzeXNfcmVhbGl6ZV9j
cHUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLCBEZXZpY2VTdGF0ZSAqY3B1KQogewog
ICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoY3B1KSwgImdsb2JhbC1yZWdzIiwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKGhtcy0+Z2xvYl9yZWdzKSwgJmVy
cm9yX2ZhdGFsKTsKKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGNwdSksICJ0
bGIiLCBPQkpFQ1QoaG1zLT50bGIpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJy
b3JfZmF0YWwpOwogICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoY3B1LCBOVUxMLCAmZXJyb3Jf
ZmF0YWwpOwogfQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4
YWdvbi9oZXhhZ29uX2RzcC5jCmluZGV4IDg1OTlmNTg4M2JmLi4yNWU4NTUwZmJhMiAxMDA2NDQK
LS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9k
c3AuYwpAQCAtMTUsNyArMTUsNiBAQAogI2luY2x1ZGUgImh3L2NvcmUvcWRldi1wcm9wZXJ0aWVz
LmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdv
bi9oZXgtc3Vic3lzLmgiCi0jaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oIgogI2lu
Y2x1ZGUgImh3L2NvcmUvbG9hZGVyLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogI2luY2x1
ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiCkBAIC0xMDgsNyArMTA3LDYgQEAgc3RhdGljIHZvaWQg
aGV4YWdvbl9jb21tb25faW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIFJldl90IHJldiwKIHsK
ICAgICBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMgPSBIRVhBR09OX0NPTU1PTl9NQUNI
SU5FKG1hY2hpbmUpOwogICAgIEhleGFnb25Ec3BNYWNoaW5lU3RhdGUgKmRtcyA9IEhFWEFHT05f
RFNQX01BQ0hJTkUobWFjaGluZSk7Ci0gICAgRGV2aWNlU3RhdGUgKnRsYl9kZXY7CiAKICAgICBt
ZW1zZXQoJmhleGFnb25fYmluZm8sIDAsIHNpemVvZihoZXhhZ29uX2JpbmZvKSk7CiAgICAgaWYg
KG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSkgewpAQCAtMTIwLDEyICsxMTgsNiBAQCBzdGF0aWMg
dm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgUmV2X3QgcmV2
LAogCiAgICAgaGV4X3N1YnN5c19jcmVhdGUoaG1zLCBtX2NmZywgcmV2KTsKIAotICAgIHRsYl9k
ZXYgPSBxZGV2X25ldyhUWVBFX0hFWEFHT05fVExCKTsKLSAgICBvYmplY3RfcHJvcGVydHlfYWRk
X2NoaWxkKE9CSkVDVChtYWNoaW5lKSwgInRsYiIsIE9CSkVDVCh0bGJfZGV2KSk7Ci0gICAgcWRl
dl9wcm9wX3NldF91aW50MzIodGxiX2RldiwgIm51bS1lbnRyaWVzIiwKLSAgICAgICAgICAgICAg
ICAgICAgICAgICBtX2NmZy0+Y2ZndGFibGUuanRsYl9zaXplX2VudHJpZXMpOwotICAgIHN5c2J1
c19yZWFsaXplX2FuZF91bnJlZihTWVNfQlVTX0RFVklDRSh0bGJfZGV2KSwgJmVycm9yX2ZhdGFs
KTsKLQogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbWFjaGluZS0+c21wLmNwdXM7IGkrKykgewog
ICAgICAgICBIZXhhZ29uQ1BVICpjcHUgPSBIRVhBR09OX0NQVShvYmplY3RfbmV3KG1hY2hpbmUt
PmNwdV90eXBlKSk7CiAgICAgICAgIHFlbXVfcmVnaXN0ZXJfcmVzZXQoZG9fY3B1X3Jlc2V0LCBj
cHUpOwpAQCAtMTM4LDggKzEzMCw2IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQo
TWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCByZXYsCiAgICAgICAgIGlmIChpID09IDApIHsK
ICAgICAgICAgICAgIGhleGFnb25faW5pdF9ib290c3RyYXAoZG1zLCBjcHUpOwogICAgICAgICB9
Ci0gICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoY3B1KSwgInRsYiIsCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2RldiksICZlcnJvcl9m
YXRhbCk7CiAgICAgICAgIGhleF9zdWJzeXNfcmVhbGl6ZV9jcHUoaG1zLCBERVZJQ0UoY3B1KSk7
CiAgICAgfQogfQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi92aXJ0LmMgYi9ody9oZXhhZ29uL3Zp
cnQuYwppbmRleCAyOTA3ODNkNTExZi4uYjllMGJiYjcwNGMgMTAwNjQ0Ci0tLSBhL2h3L2hleGFn
b24vdmlydC5jCisrKyBiL2h3L2hleGFnb24vdmlydC5jCkBAIC0xNCw3ICsxNCw2IEBACiAjaW5j
bHVkZSAiaHcvY29yZS9zeXNidXMtZmR0LmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29u
LmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmgiCi0jaW5jbHVkZSAiaHcvaGV4
YWdvbi9oZXhhZ29uX3RsYi5oIgogI2luY2x1ZGUgImh3L2NvcmUvbG9hZGVyLmgiCiAjaW5jbHVk
ZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNsdWRlICJody9jb3JlL3FkZXYtY2xv
Y2suaCIKQEAgLTIyNSw3ICsyMjQsNiBAQCBzdGF0aWMgdm9pZCB2aXJ0X2luaXQoTWFjaGluZVN0
YXRlICptcykKIHsKICAgICBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zID0gSEVYQUdPTl9W
SVJUX01BQ0hJTkUobXMpOwogICAgIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmln
ICptX2NmZyA9ICZ2NjhuXzEwMjQ7Ci0gICAgRGV2aWNlU3RhdGUgKnRsYl9kZXY7CiAgICAgaW50
MzJfdCBjbGtfcGhhbmRsZTsKIAogICAgIGNyZWF0ZV9mZHQodm1zKTsKQEAgLTI0OCwxMiArMjQ2
LDYgQEAgc3RhdGljIHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAKICAgICBmZHRf
YWRkX2h2eCh2bXMsIG1fY2ZnKTsKIAotICAgIHRsYl9kZXYgPSBxZGV2X25ldyhUWVBFX0hFWEFH
T05fVExCKTsKLSAgICBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKE9CSkVDVChtcyksICJ0bGIi
LCBPQkpFQ1QodGxiX2RldikpOwotICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKHRsYl9kZXYsICJu
dW0tZW50cmllcyIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgbV9jZmctPmNmZ3RhYmxlLmp0
bGJfc2l6ZV9lbnRyaWVzKTsKLSAgICBzeXNidXNfcmVhbGl6ZV9hbmRfdW5yZWYoU1lTX0JVU19E
RVZJQ0UodGxiX2RldiksICZlcnJvcl9mYXRhbCk7Ci0KICAgICBmb3IgKGludCBpID0gMDsgaSA8
IG1zLT5zbXAuY3B1czsgaSsrKSB7CiAgICAgICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05f
Q1BVKG9iamVjdF9uZXcobXMtPmNwdV90eXBlKSk7CiAgICAgICAgIHFlbXVfcmVnaXN0ZXJfcmVz
ZXQoZG9fY3B1X3Jlc2V0LCBjcHUpOwpAQCAtMjY5LDggKzI2MSw2IEBAIHN0YXRpYyB2b2lkIHZp
cnRfaW5pdChNYWNoaW5lU3RhdGUgKm1zKQogICAgICAgICB9CiAgICAgICAgIHFkZXZfcHJvcF9z
ZXRfdWludDMyKERFVklDRShjcHUpLCAiaHRpZCIsIGkpOwogICAgICAgICBxZGV2X3Byb3Bfc2V0
X2JpdChERVZJQ0UoY3B1KSwgInN0YXJ0LXBvd2VyZWQtb2ZmIiwgKGkgIT0gMCkpOwotICAgICAg
ICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGNwdSksICJ0bGIiLAotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKHRsYl9kZXYpLCAmZXJyb3JfZmF0YWwpOwog
ICAgICAgICBoZXhfc3Vic3lzX3JlYWxpemVfY3B1KCZ2bXMtPnBhcmVudF9vYmosIERFVklDRShj
cHUpKTsKICAgICB9CiAKLS0gCjIuMzQuMQoK

