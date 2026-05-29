Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E2ECD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dl-0004HZ-Mn; Fri, 29 May 2026 17:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dj-000488-LG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Di-0000rp-0B
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIdlN4203284
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=FCSPKMm0KpkYZ8+O
 2mXtthKybjgGpnDfrwD/nJ0eM6fQkxGa8spoyDl/46s67RLxdV16FNhkZOqSEhlm
 /a8s3rwRLRluWBPiENfjPN3zFWzPEMkHuENSOU6f7eE3B1xIEnIB6mb9s1b4b8tc
 YfkxBJLFfIndRc9lu2gikwzSHrCUn8cIxNIaxpgeK0UEDR8QU8UJCT4PZwp6Q0wY
 FFCL7GPworDGSghJvLa3DUJQBxohxbDUEXYaVOeC6MNecytUBRJBp/Kj2pk/t1Gu
 377lS+gN3eTX/PiO8MseghZZJvdQ+5zU0C/PhuE9zbguVOZ5lc/CfWs57XQVSvkB
 Bb0Adg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8r5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so2001398eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091900; x=1780696700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=TXrz7mJQmCqViL1yd0P3kPUmImeot5oNFVTVrftWR4kIjCNWK31J1NLYpuv7QcXPOG
 azOC4ByZIb2FjKToqF6nO/Z9oSR0RAyLE7jaFZmxIdImBggKFrnh7RL/fYVfMgF3B4vu
 onQO/TUbNebi4DS7ZtDQmjsraRsus/ocRoYf0UXlOh2ajAM27a7szAkNkejtaEkPBew2
 lWfbkmdVX8g2XNJt+PMvhHMZojIrKL32QPPoq/WKxuTxtnzUS7ibLzxtwbor9vU4AVEI
 BIzv0z4cRZRJEj1tj0eGP1KvpC12oq1jU/2p1ETijsFlBhpk1yIgxCv5hjQiTZlO3B6U
 WmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091900; x=1780696700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=BHA5NjiVgCsRcYYSd61e+1lozATcpHELFmJoSAralUILmT0OON8XPxD3aHGzI8NEer
 kdvSc/r9UVVSTRMnqbCIQbLD3ghzb9rGSCuH36/iGAU5XP845Yk/6YRNF15VrazrEuyG
 rizZUi0l7DpwvdARvo7RL0xbANlfRdL5fQHmHVz39Qd3qfzRN+kGCPZjJUyLlBO3cELw
 q1fUQ2Imr+s7ty7gWQdmzNXiZBNO+w5kjWqW3/PWD4rK8Kay7rEMknEbnPrWbKnESnCA
 5dpULLAC1IiX5ITViS72dX6z8vlU+JiBJ4vj8xyEMtgdSZHaVBp8E6zG2uZxB7DccfVu
 kpsw==
X-Gm-Message-State: AOJu0YyvBH33JrfNVBs0flHsZGyitP0aPz1Ve36stfAu6OIgb2jrYdW3
 e5N8nIUEPdh7z3mpAKxCoJnle9oHUpeLaZ+UgabIvQLN3fTroDhZ5uKCvvxlDGWcgA4NQYNIS0k
 26nzLDoAZxvzfuxk/qXJTj7osxU32p71oSL6F4DhuMWe+A/xKLxc7PwAAmoBA+hnYAQ==
X-Gm-Gg: Acq92OGyzg0WxvJmgrOnezl5/Mh8y0pz3BvLv7gmtRYbFfPVBX/2Q/Qt7KGPMu6lH/v
 d08zmZJIihZAaKlxaCBLYqQ+7qL8rBQQq7vSMnN7/NQlIndNfSuJ6vb41+glXgKpylFex6qcdLI
 SzPSQrQDjnd7H//jmQzEgeWqw2y187HGMKS/q8WXTPZx5FuYoj4OH3WNiXzwPzeu0TRPOdIfiox
 FVhtvnh/473tQ9OJXKWyF4JBr6l6ZHUSwlrLlZbcMAx9eWWuZja/JY+oKhC9MGb8axQVSkdefc9
 QAsjL5w8IUN47yW6WkxcPLHoBvC7Vo4VW0R0+URR38X8/D2+x/flTls+WzarztKblGtc4G2V7NU
 PYayXeZamWQE+VRWiHBn7Akqv3F8+hgZogTvd/JCuY5rNuWFjXZIJizgr212oKHEUZB9AL8nETg
 uPm2/N
X-Received: by 2002:a05:7300:8605:b0:304:de43:130 with SMTP id
 5a478bee46e88-304fa4cfa07mr873058eec.2.1780091900167; 
 Fri, 29 May 2026 14:58:20 -0700 (PDT)
X-Received: by 2002:a05:7300:8605:b0:304:de43:130 with SMTP id
 5a478bee46e88-304fa4cfa07mr873037eec.2.1780091899618; 
 Fri, 29 May 2026 14:58:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 07/28] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Fri, 29 May 2026 14:57:45 -0700
Message-Id: <20260529215806.608770-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXwuyxVjJ5IfJE
 yp7L4bPFi0eb/wrmsw31psfM146b/osn6yCDcDfRrb/+Bakz30EV1Fp9GGhMhhedlPPx5CzYaxC
 AlWJS/ySNRLSZH4HrQOCNNWgQFFHvKlvTKUEw3w1DdZYsCjN+nwHunDVDNBFjixB6L/oqFfpO17
 dBrg0ZiWYAMql6J9wkm7YuCw3cf/8THDbKUmXSu9LG7EBQ1d9gWPbtibQHGgur5roFX9UDBi78s
 I/JNc+oXN32IK7tsbUGqxr/RzljDSP5PnPOPR1tyZthSsaXQ7qkjpF9sOkIBJpDynUQOOFw/GZo
 PY5dzyeYidrnahZ+crcDm57OWWqPN4o74acxcI5g7weOzYtA6KDgYE4ko3KmUEB4aqh9sOyCpTq
 UAP7C+xTZU2HdOAYngqa0ioiBUiX8xLgCnRNcYaSMXZKwIf4x4e4fR0ROMobjPTs5MZ/4XsBAO0
 M4ELaZ3tgLl+BXmcVUA==
X-Proofpoint-ORIG-GUID: dLtD7hUSG5WTqaut2fGcEZqvT3bo2n4a
X-Proofpoint-GUID: dLtD7hUSG5WTqaut2fGcEZqvT3bo2n4a
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0bfd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

