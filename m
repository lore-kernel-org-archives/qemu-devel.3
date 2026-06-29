Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E51C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 03:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39N-0001ar-A1; Sun, 28 Jun 2026 23:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39L-0001ae-LZ
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39K-0006Dw-0f
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d2bR1562427
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=; b=OnhTk1yBcjYMwlrK
 WALtTI2bqEkHZdCb7LHGqFFipI8heJZM4vHu8DBb22WQ17rh9WcU6J0cr//rmH8R
 smDK44lnkFf8hNM1/MxEiVjhAJrqc025eKQlLjGr9Oy5s85eWopdqvLFyv3SUx04
 zrdIKsA2uww3X086pDoKbz1hRfMEJJGlir2eD76SnNH3hY4Sf4wE751MMvURDue4
 y+4h8Dr2EHwIvLkLTwM/d3PWOWzoFk0/d1KYQ1u/Hs0wVDBOZAMeU+dOCDRw+shD
 aeSm3Dr9Y1Mp8Rx2DvzLNDCfM+TG5ayY5Phev96vFC+K1ppl/xq6fxtL13kFJaFy
 W7Phjw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuvd1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso4870565c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705537; x=1783310337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=LBlaMk3DO7D7acVxBBcdcMIRMI1iaEQPDdZCcGU6kSfzW/V2DZ68GkcpH6LH/lb+xs
 nd3g1IsvyXQTxDjnQU4SR99Yzdp1QZdplvnb0fw756sXLQUHL0eUT8RBV2SFiPvUtFFl
 Jnu6Nofnvd7yGwwadPT/3aqjaKOBcrbqxbe8ApYgw4IYEsEQXmktaKTWLcyQlPZEIGIn
 f64fSf4g62YxWM0HdEyLliHJsueBGpVs2UMeXjSAwPnXzJY4Br5iokSLkGG2KcJo8WLb
 C5wuWhqvmoiQbM/h1IbqrjAbbkQkG47BbN2+wKTggQOyy4bbAyZpf2w3UPQPqjCGV1L6
 0Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705537; x=1783310337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=gavIgK9IbEdPwhFre3dsz1z63HQiSZ+Y0Fw81W5rUWEyNGh3SxWj1e3Of+0ygdLXsB
 JovvX1tXSIl1ERGqsRJ9Dtg8EDhrK7CIYu6CklQ277IZwClFikvumGUuKrUlpO4V82eM
 tdkz6GWuGIp2uEptAb+4UEo4GkH7T4UgZaLNPpZWaEdTezS9BGFImUjJh1+GFGNd7t5Y
 ctl7gU5T9F/NdW+qWTxsB015Ay0I/VjAHFIwlgzwIGK9kotrHlEgwtkHstuLFRNgR9Zs
 GMZO7HV/iG1iFOaxGLIzRTWBFy90vcOovS0OjDJAusmXof35ov1bJknqYSN7omyAR9H6
 wnFg==
X-Gm-Message-State: AOJu0Ywcl0wf6LL0bWbyss4v596o15AgF8gk8qk/DsEdbJD3Qj59UMqa
 q1ZH3/UN86bwBo0mVUNqJR/ZdmWyBXnVCc1CNpAbArwGAbxYjVAV2WfmHLbNNvXjl4X3JyBX3e5
 xye1+FQgEHZJcpXcQoDHkimNhV1wzyXO5pfO9ydSSD+nOx69NGfFCqobc0eBvAdh4dg==
X-Gm-Gg: AfdE7clHNUC3QI3D1MTAcdnl8G2JRQD/fY8S0ehcc03OqVycNIQPpw7EEvOInTlMlv2
 gfi2RUWPKYXAcXYoZFTygz0YHz/ljJHN56A5TqP/V3Fa9N5ZcTrOBRzfDYx4PIX9r/HeCJ1VUhn
 wCe1C/uZp6v569kKsj8ilmlmYGBSN0D3bkZQBvan3VCLlwoA24kiX5yu8NptotCc9p1IzJhoNLW
 nbNTKkR95tM0+130dnPR0/jL/lHuEOykoKTvVvHgtE/sjBCsv5zpS9mHZNpUYa1LuBQVzox4fNH
 loCzt9zC7OTeQsEnLOqqKJIriYnkb9lBf+A8ebX24vSAYep/pTTTEXPVXGihzAy9545Jqa+eH9D
 QQ5qihZE65Lo9TzygI7gPFtK9Aw2CzrWf5MVKAC77Iu5QAu6CX9r1eDGR0FA=
X-Received: by 2002:a05:7022:160a:b0:139:cf4f:3b80 with SMTP id
 a92af1059eb24-139dbb1250dmr10838097c88.34.1782705537460; 
 Sun, 28 Jun 2026 20:58:57 -0700 (PDT)
X-Received: by 2002:a05:7022:160a:b0:139:cf4f:3b80 with SMTP id
 a92af1059eb24-139dbb1250dmr10838083c88.34.1782705536931; 
 Sun, 28 Jun 2026 20:58:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL v4 11/77] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Sun, 28 Jun 2026 20:57:24 -0700
Message-Id: <20260629035830.1520296-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX9zlEl8O80xPr
 AFxO/1kx3Q5ay40kkp4blZETFttBf5fYQhJVCcHTa/chBdYnt6xsOeKEd20Dl+d5v2IhZwS4hdf
 hGhTnfFkQak7z2O/8sui9jH04TW1rKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX68QnF6NNkMQZ
 Xikh4YgDRPKOkp92Zpd9lYkZ8uZnoiljzAI/9vdkHHRnRhe9F0kfhf5iQANkw7LS9ooLkBov/v9
 iKhsFXJi/4Zs19SKLHiuM9FsKYjlu5RKC4ESXv/ZAD4+Ir1F8miMgDqX3NeFqzk/7Jcka08HVHc
 N40e/sJdPt2fWkHP0cjn4v1ahgVqAU9XYd9mjbTKXIJioy6554vjqmw6D9HxLRHU/zuA553+X7P
 gPN802Y9iIAlunTVxWI7EV5ra9VLQ2FLGigptskFq/tOTUczgVDTnbglDAJ05yNTUS8vK2mdj2c
 taKV2HOAga2j4L70ccXEK2gFZBk7SU4M2hoarl+Y8vSYl8Z+GSxqnhqWTmYlsU2AvcQ2ceWbWQO
 QswTDlV6inPoWXK6hYEERhjBdhUYSK5LEJhMbiPqV+XF+irHdIQBzWmqSXf3bcHLQBVzrizrcQb
 /AjwzAnFhhnrPHkcemQ==
X-Proofpoint-GUID: QGj9NvLof-oxP5vdfdPFCKD7H_aJfYhA
X-Proofpoint-ORIG-GUID: QGj9NvLof-oxP5vdfdPFCKD7H_aJfYhA
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41ed82 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=orAq0Iv1PZLbcfkgE-4A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

