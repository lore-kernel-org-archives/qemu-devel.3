Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA766CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn8y-0003MB-8l; Mon, 22 Jun 2026 18:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8w-0003LE-Hf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8u-0006Hv-MH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbQiI2177924
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=; b=QXZGh4DKIZJfkFHp
 S7c9qJIliwgEiao2oWDtvFwEWmFBDrGvr/0yj/nhHHQQxVZA/MEqI6ZvkezcIKM1
 SM0nGyMNvX6Opof3k5wQXDhn1Y/7XHUUrhJDLsk7yzC0i6Gzyex6O68woA8VISSH
 rk4j9hckU2DwqQU3jLzUByC8hZgGksNoW2Y/LkXKjsscfUyRLyqb4WCZYWYCYCgL
 ZhMXyiKdv4vOl/0SF7i4Lp0T0Pm2b+obgxwRN23LybgFtEFBr1SGyYAXFgMIWCiD
 r5jV2gEOSbrMo4tRmyDIJ8nKfwmqcqkyvNhQmfuoJDSptA1zyN5XSLzdHuUtqEmv
 xj/1jA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hahc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so6662011eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167363; x=1782772163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=VmJ2pB44vJXp+e803FGWIAEp939ieJv6yY6Qx8Hoz8nxmKnkLo57ikpyLGny6wv1Sm
 kDNga6c5fQdlYJnen16zm+ADfGHUF9GHz8p4Gk16CawbdzTzW8cCt+mW7mNG68sI4Uz4
 6Kv2jDY0TVsfWqSIWR0ag0EzMhYTfPUAWn4ozNnOZ1brreDJPG9hwvi7NKNt84HmHh6H
 fDtxG2WVfXlnUcAXPfN2RhhB2q1Jpv9GEb0Us+L27XILbMZlzJj3icddNH3brIyKNaif
 oJU5IBYaHWClhw5F8ko7L2OMSwmj9SmzGz26xIuJnfFbJ3XLrU6SPVM16f+5w4EoQ3EN
 4Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167363; x=1782772163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=NqdT4DD4xxDxYxYBMIAmjOOAvoaAhCS1RxQs2dEuH/W1Q6Ha78IPzj5RrrMziR9Mx7
 DIhM3bXtkz7nwg5dYCgnjLrqvckmFYEQ1/uIdFDS42Qnrf/fu5zXQgkYFdl2VNMBVjpD
 us3CN1j6dm3QjmuhnJ8SNQs+8jYP/bSJA8GEmtzXuCzQZA+Y2ul43zUyFHkBWJthP60S
 5e0/dfhvvNj7nSn5b1W8PquNzQNp3pX4OTs9Df+MjIM0SpEsWw6JoBTDFvOY0a5Z7acA
 r/krebO7MSanIRU1cPaytcYwelWor+ODSp+iyL0G1zboBk45fjMIaSgsGrOpjtO2BqIk
 1Lww==
X-Gm-Message-State: AOJu0Ywq7DIvr4Eu42KDcvacd/Mp64Q/+Qy/H8xiA40gnBArIxpvBg8p
 9DUlnngazGoaPLCQTRc7375ec4wjFTEX9Hb6OpGpm3Us4FX8IjGbYt/g37RQX06XOwEnADkDcN6
 y7veTD8+LJLPVNmPvTbTTekhWL99T3zviZHg7nplAEFM9LMRUjbtXq2Fv3eFe5DiemA==
X-Gm-Gg: AfdE7cnlqXjGhgr9+yINmNbKt2233eydGfd3qcqdd0nUX3XIiSwEE+dI3fakcqpohrq
 f4iDXYZZ6JHTDhqJggD5cihO3aWUPvA4AjG7cQ/YOP8aWxweAuKEyv92T7cx7JHahLV2sipS5fh
 Jzlpw9+qCVR2ucITwL0WypmsNvBq2/fSNP+KO99zBC3mK+C3bg1APoPDEKtVZv+jV0gqdBv2/C6
 D8c1TBt/12DJvO8sD4DD0bRITPfrNqBP3PnhKTJAj7rkdlYttg+yCKZLbPlT2f/l4notMAqeJSS
 qRyXIlD/JDb1eMn2Re+thm3AaEyEHoKJaZHEDuFGSl4Rc9lx3Ejw3FdEmRSGNKO159XfTOTfLdX
 tk6P+6ZEUkv+OmiaCpL/DpwST+EZo9OmQdqqKaHUmrDol6iBCVW95/4ijHlQ=
X-Received: by 2002:a05:7300:578c:b0:30b:fb9c:f8ff with SMTP id
 5a478bee46e88-30c589f61acmr364401eec.6.1782167362732; 
 Mon, 22 Jun 2026 15:29:22 -0700 (PDT)
X-Received: by 2002:a05:7300:578c:b0:30b:fb9c:f8ff with SMTP id
 5a478bee46e88-30c589f61acmr364377eec.6.1782167362234; 
 Mon, 22 Jun 2026 15:29:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:21 -0700 (PDT)
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL v2 08/75] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Mon, 22 Jun 2026 15:27:57 -0700
Message-Id: <20260622222904.607771-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 1vNBJYPYtHBP2NcCydwgvSrP4CPmCm2D
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39b743 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=orAq0Iv1PZLbcfkgE-4A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1mYgrN97y73h
 Kf9Epfwu3buhwq0tqaopZrvzSQp/+vVDFfmcUJt0IBULtl7CQRql5FRpfkIVCuqvuzej9O7180X
 5/g7YhG7eYk2fp145Zw+EOYh1bL1+IY=
X-Proofpoint-GUID: 1vNBJYPYtHBP2NcCydwgvSrP4CPmCm2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1O2dWzqB6pUH
 CZGPnB2sH5KpSetnE4n+Sn53Ok1oJNkaTOqyN+yOf6or69O1YQIdvg/I7C7Foi0gOKWLBAHWqn/
 Nwn2dG3ePfPhW3SotzSBHCZM8ZSLlr+20+okLQi0M9PqQMeESHSsjMLvbbdEFd7DDjb8VTiwH2A
 4JzGfIA5J+MhDni1M1o50ltHaED7Ib+rzlPa6VunqgapHT3N5xs54Rtbfb/vxD89YWi13Rrfvx2
 cWzWdhJ20WpueVKvvwDym7kaOAEb3ObaJKv3/Za20KiKG3IKVfF1kgOtwVG3/mMnwjClHAnzrFL
 iIcWWsvCb+SWdjmMohHz3+kHBxYOjsqSHIvZRSEnkrX52H3jGhvz8UgqaLl/bzTkadEv61jwubc
 J2fmhFxVMSVNd2Pq/dVnf1VokWp/HXkBFYpIp3Q1u2z+23cipQyPiGNaDNYi+jkzJqw8aqbHzzA
 bTz2HBFYnz00RlhCbkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

