Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C69C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coO-00008Y-Hs; Wed, 02 Sep 2026 00:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coM-00006j-8A
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coJ-0000KD-GT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6823JPxQ1025989
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eF8RqxLrvuk2CLDFYv0pEEjgULI/TA8csQSHi7utusw=; b=WCxXvhScIBI2iTvG
 y8k5ZapK+VtOEIwdgx/86kiUBwMCQ26dPosGoh3zDw7Xv7Py3Fn6wpgg3XLgYiVY
 niBr6eWpkXXTuScWvVHbzL6k2dqMP+XwpfoL8XLa5TbWC6mV7Q74GzgxZmAAO0rc
 X0WrVMWsq/6u17Dq8o+sqMbm3wRAZ0vYDtpQsj5CeecLJzk+pPYU7Sninhn7K3BX
 wivYrmmZktoOHJi7cFUleCF2B/Ua8D3EKNVJdUiwtXUHI1r+a0jor1+r2abzOv7/
 f7KOy1Ncr3HAR7mvsb7rEK/Wqi26bLSdHwXppIQUaLFerMLIRILFmjIUy+5ZMWPs
 naZefw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gebsx08ab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0aso981641a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324173; x=1788928973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eF8RqxLrvuk2CLDFYv0pEEjgULI/TA8csQSHi7utusw=;
 b=Iq6ZEtY0Nx2TcsZW2Ey51amCYHlPOxEthG+GuMvo0Aiwj4RMpd03xD/DUpb6ZZDXN4
 8OV4rj91XS9Nqj77F7E/gZdGiZFp/Vhce2ix3cASEeG6YWbu56Wt9snwUyeJCz0k5l80
 CPgeiJVIoaLwks/0kMzj9QIqOZ+fThuEj5ZpzBZ7e4IZ336KF9r5YxVzLE+rVzwSRvxh
 dd98wdEJOvHf7p6n9NARK/+dZZimKIDAQj9rwY3W2uFk6cMFBNL2pijReCQK8LhTS1iP
 W0DAF9iDOWBUp7L8xC6Ypa0gPwrl/+51mH6CiCdk0nMZLvRk6zHOkmn4yK15OFSY+qJE
 pk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324173; x=1788928973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eF8RqxLrvuk2CLDFYv0pEEjgULI/TA8csQSHi7utusw=;
 b=ABkgikkwEsxO7UymnL+QWKZA5Q6SoXC0D0aZi+8ZGVvLggM+eJN/Xm3/yTpJW5YuUr
 YBc7DFsjkrzrDzC+qweGuMhtty/H3jfnWLa/IuGUZK6IdnihFwgE6sXDSFI6ogLpTVTc
 diJlr59uPgVkslXZSZmUK+8vuIudI94uP+tOtgyW3nXmweMFW6qCbe+ZgZuaa/8MGBfW
 tXS/pd3uU42p29KsPMcgAYP9afa4sSjhQAfPH2diBOBPga5YXnUyV2tmyYDzukfDM+ch
 Y/XV+CFRdurXGvKAhlM0Al7G7zPQowemHG/NymygyZof/6f9b6TmqCa48uwxraamN5es
 EVfg==
X-Gm-Message-State: AFuF++kdicZoJrXuTmug7R3rgL48hoElOTI831WDBrtqCsxmV5SNi3qk
 5/GTSW3uVQg0w8zbN6ds/YMhGZlX+bDwk2LIcD2YdOD5zRWCz8MGurqYUNYBd0UKQuaG3UP8Mah
 kx+jV4K9Td2y4duwcFalxCs5xr3wfXRS068uJV1ffnh5kcolFRfQ9sLaI1CaYFWNQ8w==
X-Gm-Gg: AYBFou2tFfkDUZ7uzDCMBqp9ODJEgLijU92v8d1Pn8kZL5BKC/cL1nhfpxyzso3ID+U
 H8G5eh68aG7bfvoAAOhUxy3JUBde8dxRUEwPORN93KkJXghcMgfhkURHpdPf/jF4uGWzP9KrxfQ
 CWg/zeAu6HtKsDfJrD/DeVe3CYKQU+wsIoPfE1KM0VeXbxGyBGdDX0yCEmo+wLVn+LC1lQGFlam
 /o4UXxZ+FwnTkkM96m/7KkUDaafCua/0dVSJu5G1WbsZ5DS9FO/a2MedGj2w2gLXsFXp0GB0CrS
 PYEL5zxX3FOpDw++3ePSwGN+W9tpmBHAlEc1LiyGHJO1Bggrlr5u19pocEknbG6rC0Z1Ya+V4Kf
 LkbK7bAXePmVMZzmRzDy5ecQUV8qF8s/ZC04NsyLI1nXc8dxz
X-Received: by 2002:a17:90b:562e:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-39af57ba71dmr729506a91.3.1788324173301; 
 Tue, 01 Sep 2026 21:42:53 -0700 (PDT)
X-Received: by 2002:a17:90b:562e:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-39af57ba71dmr729446a91.3.1788324172732; 
 Tue, 01 Sep 2026 21:42:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/28] semihosting: add ftruncate helper (to be used for
 hexagon)
Date: Tue,  1 Sep 2026 21:42:11 -0700
Message-Id: <20260902044231.843004-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: UEiSsCJ9kvq37qXIhO2hTst95uxQ0ZiF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX+yVhFhKUbDon
 rDS7mF6yD465xYCqPxjcWb4tyQ5TE7JM9ocfjdftd44RcXIVlVKEXYPQ2Kh6Bu4AJZxjNvujpUc
 1cG7CKsoC6OME1gWc2QSltpBmlutL63f8qEsJF6AGJbG3JzHoZgqhR345JZQ7/pQf+wHu9AeuI9
 evDzzvknfyaSZNdS20hJx7epe/t1gFPITDqf1PWJJw53GagztaYTCCiwtdv8RcceFK+kfDlb9Ba
 SN2xm+B6Jihh/6tMfCi07QKR/SbLAlkBvHYnI5I6A00xaZO/eBib+0PYW5ZGSBxZyLPAh8EAJEq
 O3LH0vDQH7n309Yc+mGnabYB/UywMMNDmUqppwGDekz1BeL4kaqAgaN7WNveosb0qcG2o6uS6vW
 meidCN9GSlSv2bWEJC6mPPz8J6WCge+D/GMCa/W9rbdU0FNxiWNK4gzvn3hT8SlMTd0fKn6GkHA
 O4yzaWMLGP5/93pk/7A==
X-Proofpoint-GUID: UEiSsCJ9kvq37qXIhO2hTst95uxQ0ZiF
X-Authority-Analysis: v=2.4 cv=AufeGu9P c=1 sm=1 tr=0 ts=6a97a94e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=uJe94fD4SakSd_PNSRgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX+9KC8Bpi+oBk
 FJhr0kgRu9lgGSUXxeERek19MFQLmU7nf8KNheS0ls/0uH7SqbLnFtg1+TGuOw1w7aOvznBLvgx
 /VTWoextK3duLDzWPxGnR267uW0ZsQU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKVGhlIGNvbW1vbiBzZW1paG9zdGluZyBzeXNjYWxsIGxheWVyIGhhcyBu
byBmdHJ1bmNhdGUKaGVscGVyLCBidXQgdGhlIEhleGFnb24gc2VtaWhvc3RpbmcgQUJJIGluY2x1
ZGVzIGFuIEZUUlVOQwpvcGVyYXRpb24uICBBZGQgc2VtaWhvc3Rfc3lzX2Z0cnVuY2F0ZSgpIHNv
IHRoYXQgSGV4YWdvbgpjYW4gZGVsZWdhdGUgdG8gaXQgcmF0aGVyIHRoYW4gY2FsbGluZyBmdHJ1
bmNhdGUgZGlyZWN0bHkuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMg
QmVybmFyZGlubyA8bWF0aGV1cy5iZXJuYXJkaW5vQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1v
ZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNs
dWRlL3NlbWlob3N0aW5nL3N5c2NhbGxzLmggfCAgMiArKwogc2VtaWhvc3Rpbmcvc3lzY2FsbHMu
YyAgICAgICAgIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hh
bmdlZCwgMzEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvc2VtaWhvc3Rpbmcv
c3lzY2FsbHMuaCBiL2luY2x1ZGUvc2VtaWhvc3Rpbmcvc3lzY2FsbHMuaAppbmRleCAwM2FhNDVi
N2JiOS4uMzkxOWFiNjRjN2MgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvc2VtaWhvc3Rpbmcvc3lzY2Fs
bHMuaAorKysgYi9pbmNsdWRlL3NlbWlob3N0aW5nL3N5c2NhbGxzLmgKQEAgLTc1LDQgKzc1LDYg
QEAgdm9pZCBzZW1paG9zdF9zeXNfZ2V0dGltZW9mZGF5KENQVVN0YXRlICpjcywgZ2RiX3N5c2Nh
bGxfY29tcGxldGVfY2IgY29tcGxldGUsCiB2b2lkIHNlbWlob3N0X3N5c19wb2xsX29uZShDUFVT
dGF0ZSAqY3MsIGdkYl9zeXNjYWxsX2NvbXBsZXRlX2NiIGNvbXBsZXRlLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGZkLCBHSU9Db25kaXRpb24gY29uZCwgaW50IHRpbWVvdXQpOwog
Cit2b2lkIHNlbWlob3N0X3N5c19mdHJ1bmNhdGUoQ1BVU3RhdGUgKmNzLCBnZGJfc3lzY2FsbF9j
b21wbGV0ZV9jYiBjb21wbGV0ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmQs
IG9mZl90IGxlbik7CiAjZW5kaWYgLyogU0VNSUhPU1RJTkdfU1lTQ0FMTFNfSCAqLwpkaWZmIC0t
Z2l0IGEvc2VtaWhvc3Rpbmcvc3lzY2FsbHMuYyBiL3NlbWlob3N0aW5nL3N5c2NhbGxzLmMKaW5k
ZXggMjBmMTU1Zjg2OWEuLjA0NTZkYjBiZWZiIDEwMDY0NAotLS0gYS9zZW1paG9zdGluZy9zeXNj
YWxscy5jCisrKyBiL3NlbWlob3N0aW5nL3N5c2NhbGxzLmMKQEAgLTgsMTAgKzgsMTIgQEAKIAog
I2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKICNpbmNsdWRlICJxZW11L2xvZy5oIgorI2luY2x1ZGUg
InFlbXUvZXJyb3ItcmVwb3J0LmgiCiAjaW5jbHVkZSAiZ2Ric3R1Yi9zeXNjYWxscy5oIgogI2lu
Y2x1ZGUgInNlbWlob3N0aW5nL2d1ZXN0ZmQuaCIKICNpbmNsdWRlICJzZW1paG9zdGluZy9zeXNj
YWxscy5oIgogI2luY2x1ZGUgInNlbWlob3N0aW5nL2NvbnNvbGUuaCIKKyNpbmNsdWRlICJzZW1p
aG9zdGluZy9zZW1paG9zdC5oIgogI2lmZGVmIENPTkZJR19VU0VSX09OTFkKICNpbmNsdWRlICJx
ZW11LmgiCiAjZWxzZQpAQCAtNTQxLDYgKzU0MywxMyBAQCBzdGF0aWMgdm9pZCBob3N0X3BvbGxf
b25lKENQVVN0YXRlICpjcywgZ2RiX3N5c2NhbGxfY29tcGxldGVfY2IgY29tcGxldGUsCiB9CiAj
ZW5kaWYKIAorc3RhdGljIHZvaWQgaG9zdF9mdHJ1bmNhdGUoQ1BVU3RhdGUgKmNzLCBnZGJfc3lz
Y2FsbF9jb21wbGV0ZV9jYiBjb21wbGV0ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIEd1
ZXN0RkQgKmdmLCBvZmZfdCBsZW4pCit7CisgICAgaW50IGVyciA9IGZ0cnVuY2F0ZShnZi0+aG9z
dGZkLCBsZW4pOworICAgIGNvbXBsZXRlKGNzLCBlcnIsIGVyciA8IDAgPyBlcnJubyA6IDApOwor
fQorCiAvKgogICogU3RhdGljIGZpbGUgc2VtaWhvc3Rpbmcgc3lzY2FsbCBpbXBsZW1lbnRhdGlv
bnMuCiAgKi8KQEAgLTk4MiwzICs5OTEsMjMgQEAgdm9pZCBzZW1paG9zdF9zeXNfcG9sbF9vbmUo
Q1BVU3RhdGUgKmNzLCBnZGJfc3lzY2FsbF9jb21wbGV0ZV9jYiBjb21wbGV0ZSwKICAgICB9CiB9
CiAjZW5kaWYKKwordm9pZCBzZW1paG9zdF9zeXNfZnRydW5jYXRlKENQVVN0YXRlICpjcywgZ2Ri
X3N5c2NhbGxfY29tcGxldGVfY2IgY29tcGxldGUsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50IGZkLCBvZmZfdCBsZW4pCit7CisgICAgR3Vlc3RGRCAqZ2YgPSBnZXRfZ3Vlc3RmZChm
ZCk7CisgICAgaWYgKCFnZikgeworICAgICAgICBjb21wbGV0ZShjcywgLTEsIEVCQURGKTsKKyAg
ICAgICAgcmV0dXJuOworICAgIH0KKworICAgIHN3aXRjaCAoZ2YtPnR5cGUpIHsKKyAgICBjYXNl
IEd1ZXN0RkRIb3N0OgorICAgICAgICBob3N0X2Z0cnVuY2F0ZShjcywgY29tcGxldGUsIGdmLCBs
ZW4pOworICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICBlcnJvcl9yZXBvcnQo
ImZ0cnVuY2F0ZSBjYWxsIG5vdCBpbXBsZW1lbnRlZCAiCisgICAgICAgICAgICAgICAgICAgICAi
Zm9yIHRoaXMgc2VtaWhvc3RpbmcgbW9kZS4iKTsKKyAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICB9Cit9Ci0tIAoyLjM0LjEKCg==

