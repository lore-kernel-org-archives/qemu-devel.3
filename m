Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F87606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cN9nGqYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NN4XmypA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKP1-0002BR-4y; Tue, 20 Oct 2026 20:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKOw-0002AW-4X
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:41:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKOu-0006ys-8u
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:41:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtbYT2222514
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=; b=cN9nGqYUx0w7Wqir
 mNkTbdaNp4ZY1WUBraC1GCFsR7ZQfNKcKsNldKQIKYc+0TR231vT9jd/FTuKpkM5
 53Spvw8GhLXhe1e9nFveNEfLlI6lIRPrW5QKfBg36nmEiQEOjFBDF5reGm6HHBEo
 F0cK7wthjSB9FKF/pyCZijQN7vgAGZ2A9CPBW75q+LFgUN193SMKEjutpd0HF+yQ
 OIvbMJXCf8qNhtwmnARNLP/Tvh7hHZHJvuGSyq6rSPT0v4OhFerRpyPxrffHAtU8
 oUmWptnUBRtbFYkJ6jLZxqYOh42cMTIseF5dCK1tUsDocvw7v0MwPZiiNqSsqDQV
 h0SMbQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0h6t9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:50 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1663fb7e005so296835c88.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543310; x=1793148110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=;
 b=NN4XmypANODn0cBaK5MZkxEBRG8pqxTVKBPO5HKEW7SE4Acs3p1qTFrxAV4QC7g94e
 M0hiOQekCkv64D/mGmExwcE4lIe+K5IvBet8jSmAO+RqrfkwYQV3lq2m955FNwgRVZRq
 CfxL3U1hheJE0npoV2za2xW7TP8JqV7VK+x/A2ke2uKLio0Bs63Gw0qBF52D6Y9FuaDP
 deWbdXqmoLGOy71KeEO/ahnNyev2Hw9xP1sh/GTzkAmInwUFcqfmNxc1OxKG3zLj+iXE
 0Ncv1yG6BNAC8jrZqx2uGmzO1bRwMN/LvMOjRuXaMfA6NnGhASJPQG1Elnt67Y7jr5qc
 RCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543310; x=1793148110;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=;
 b=PpC6V96T78n4FqzkLPYtxiRdQpyL/8PR0ps785HEXHviSkYz9hyLOo3M8YXc9C5ut4
 aErFYyWdhz08oslmeLHEyEW7nCvHZ7rsexkl4mTF9tyxxRZIN1QZX8WnSmzrAlX1zcoF
 HAQhuBC6vMSTDbYeqeCK3XuAjxf3yxqc14YXwlm8YFDGWSCeklYewr2WIz3cjL4UvnxT
 Vn5cohoiwmodMDGEmWgieZQEYYlkW4ZaDQwoQ6deZ3GNDmaB8n30Id9nqUO5rO1WWETu
 m9RoXwsf+Sw9wh/XTow2fCYXlsyuBPKojHroXMnuTse378imcVtS7igz+hzLc4S0jh4t
 5yDA==
X-Gm-Message-State: AFq9FYIktWEtynK5sLg849UsWc7ZccPdZzZvNFkTdKZnoyrfSwMax8PF
 CUWFLZndqYVXLQpfDhGl/1ke9aQPGGInEicSNbo1yIKgHv8F0RUasGArM/8KlDeahl37qDZwFI5
 AngYxtPuCVdCx0Qo5b1ajeBtOWo8ZnJEXoZo+wCUnZjU/Ahy577WJFP4tMX4Fo/qGTg==
X-Gm-Gg: AYBFou2Ewfd33zv/5CYWr2I3oRewdusNMvgqAslFZH2QYRJHiky5oyjfM9/9PNvhnqj
 cU6TpeoDZceucc9O6lReyJufWq5qt5lJnjey0MQGu3kukXNvSZLn5WkjMFV/E05Uf5HLOuoS+6x
 wI286PeTdY9RcPJuodTf4p1bmRuL/4uGgmILGscwLVlkGyEeAuyczSf06VSUGuayJlA+u4JJTOc
 X5stp3qKWSuonJ5Yvsrqls+PrhewGk9ktDxu0EILKQBKXiVIWj5XVKye0CrBzEZe7R8bsEbyrrp
 VhmF81Jnq0uMQv3G99yk/Q7iiAg7bJehyRGTvLuY6Mtic9X/6A7RtUzetrWwrYe1XcFj41SVRIp
 9J7qnSXqdI9y15KpkKpCb0VeOYZ8mcNF0Xddcj5RwXf/Yp50=
X-Received: by 2002:a05:7022:1713:b0:18e:5292:2670 with SMTP id
 a92af1059eb24-190a52dd65amr468624c88.23.1792543309768; 
 Tue, 20 Oct 2026 17:41:49 -0700 (PDT)
X-Received: by 2002:a05:7022:1713:b0:18e:5292:2670 with SMTP id
 a92af1059eb24-190a52dd65amr468602c88.23.1792543309226; 
 Tue, 20 Oct 2026 17:41:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:41:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 01/15] Hexagon: add v85 CPU model
Date: Tue, 20 Oct 2026 17:41:31 -0700
Message-Id: <20261021004145.1693260-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXz2O8bxTzEjVP
 yzeIJg12BvxYatxa4E+aG7NwnTQJBMhWNivRs5t7vgs4CPxpWzgxpWFYcVZAE92GwKxcyFjNQV+
 qxxgTo4/NZulgbJndka2uZQmiEAF4d0hcUpPJwsWamU86GhpPWYsx66+GtfvIwIkGqY+BFR783T
 OpJribk8NcnE4Oy88zyCWlcvO4JMe/Di4Uaw1U8Id7GL1tQ3C+uDAEpWUhWyMgoJaZdmcgaxsAv
 JbXY3xbUFkPurqp1f61MgxLrM2n3lEXJjFrkjb89Pcmcy36n1N14n1xwYZ+ako7Yey+fR8HK4dV
 DJ2oabMHJrh6BO0HWfooF0I3CS99wu4BqNw8XCAnUnWYUpNqKXG8jITAaHiMJ7yKQMKM38V23Rj
 4UrBpTa4ADADVpIfwNn3UYwxTAMX9KRzn9OAcvoCnfP2XsXXu+TH1U8UfdmYqzlQg2mxXj5HI5J
 luuUp5v8F1y/tNRLeDg==
X-Proofpoint-ORIG-GUID: m38JhzGUoiDFe0R6Qd7RyUZ08qwqPMz8
X-Proofpoint-GUID: m38JhzGUoiDFe0R6Qd7RyUZ08qwqPMz8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX0ddyNz9gHhPm
 s4/M0AfG+BeFZcrZYkFe/VPT3/3G2xZwMHyDBsd9j6ixN9l6GbjH0XAlo4UnaXjWFqAUD34Qw8p
 b6FUvNeLjHzr+p0SmOXs8/NAXBJHqCg=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad80a4e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210001
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCB8IDIgKy0KIHRh
cmdldC9oZXhhZ29uL2NwdS1xb20uaCAgICAgICAgICB8IDQgKysrKwogbGludXgtdXNlci9oZXhh
Z29uL2VsZmxvYWQuYyAgICAgIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAg
ICAgICAgfCAyICsrCiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgYi9k
b2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKaW5kZXggMTIzODUzMTFhYTQuLmZiNTdj
NzdhZTkwIDEwMDY0NAotLS0gYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKKysr
IGIvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CkBAIC02LDcgKzYsNyBAQCBIZXhh
Z29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAogPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KIAogUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2
NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLAotdjc1LCB2NzcsIHY3OSwgdjgxLgordjc1LCB2
NzcsIHY3OSwgdjgxLCB2ODMsIHY4NS4KIEl0IGFsc28gaGFzIHN1cHBvcnQgZm9yIHRoZSBmb2xs
b3dpbmcgYXJjaGl0ZWN0dXJlIGV4dGVuc2lvbnM6CiAKIC0gSFZYIChIZXhhZ29uIFZlY3RvciBl
WHRlbnNpb25zKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LXFvbS5oCmluZGV4IDJiZmE0ZDVkMGZjLi5kNGM4NDEzZGVkMyAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS1x
b20uaApAQCAtMjgsNiArMjgsOCBAQCB0eXBlZGVmIGVudW0gewogICAgIEhFWF9WRVJfVjc1ID0g
MHg3NSwKICAgICBIRVhfVkVSX1Y3OSA9IDB4NzksCiAgICAgSEVYX1ZFUl9WODEgPSAweDgxLAor
ICAgIEhFWF9WRVJfVjgzID0gMHg4MywKKyAgICBIRVhfVkVSX1Y4NSA9IDB4ODUsCiAgICAgSEVY
X1ZFUl9BTlkgPSAweGZmLAogfSBIZXhhZ29uVmVyc2lvbjsKIApAQCAtNTUsNiArNTcsOCBAQCB0
eXBlZGVmIHN0cnVjdCB7CiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc1IEhFWEFHT05fQ1BV
X1RZUEVfTkFNRSgidjc1IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WNzkgSEVYQUdPTl9D
UFVfVFlQRV9OQU1FKCJ2NzkiKQogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MSBIRVhBR09O
X0NQVV9UWVBFX05BTUUoInY4MSIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjgzIEhFWEFH
T05fQ1BVX1RZUEVfTkFNRSgidjgzIikKKyNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODUgSEVY
QUdPTl9DUFVfVFlQRV9OQU1FKCJ2ODUiKQogCiBPQkpFQ1RfREVDTEFSRV9DUFVfVFlQRShIZXhh
Z29uQ1BVLCBIZXhhZ29uQ1BVQ2xhc3MsIEhFWEFHT05fQ1BVKQogCmRpZmYgLS1naXQgYS9saW51
eC11c2VyL2hleGFnb24vZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpp
bmRleCAzYTZiYTRlMTMwNC4uOWY5OGFkOGZiODYgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtMTEz
LDYgKzExMywxMCBAQCBjb25zdCBjaGFyICpnZXRfZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxh
Z3MpCiAgICAgICAgIHJldHVybiAidjc5IjsKICAgICBjYXNlIDB4ODE6CiAgICAgICAgIHJldHVy
biAidjgxIjsKKyAgICBjYXNlIDB4ODM6CisgICAgICAgIHJldHVybiAidjgzIjsKKyAgICBjYXNl
IDB4ODU6CisgICAgICAgIHJldHVybiAidjg1IjsKICAgICB9CiAKICAgICBlcnIgPSBzbnByaW50
ZihidWYsIHNpemVvZihidWYpLCAidW5rbm93biAoMHgleCkiLCBlZmxhZ3MpOwpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBmMjBk
NmRlNmY2My4uMWUzZGY1ZDBkMDMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC05MzQsNiArOTM0LDggQEAgc3RhdGljIGNvbnN0
IFR5cGVJbmZvIGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICBERUZJTkVfQ1BVKFRZ
UEVfSEVYQUdPTl9DUFVfVjc1LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzUpLAogICAgIERFRklO
RV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNzksICAgICAgICAgICAgICBIRVhfVkVSX1Y3OSksCiAg
ICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MSwgICAgICAgICAgICAgIEhFWF9WRVJf
VjgxKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjgzLCAgICAgICAgICAgICAg
SEVYX1ZFUl9WODMpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODUsICAgICAg
ICAgICAgICBIRVhfVkVSX1Y4NSksCiB9OwogCiBERUZJTkVfVFlQRVMoaGV4YWdvbl9jcHVfdHlw
ZV9pbmZvcykKLS0gCjIuMzQuMQoK

