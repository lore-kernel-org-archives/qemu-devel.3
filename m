Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A81CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOB-0003bU-Fx; Thu, 25 Jun 2026 10:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNl-0002hH-TX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNh-00007n-EB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jswO1919005
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=; b=ixsQyWkK+/5HpjL7
 ljTjA6Tirj1Bfxw3pg69979GN+HWgGivluOkLZm9nBmFZfoak27LN6Da49MDbKql
 V5AC7LvkEYyYQ0zG1IG4UvVn8JY60Y3izybenSIAFpGzeKOHJRtTZbZMgOz3YZKe
 lnA+jj0TsD40dRazT0hoX+x/Rvcdk8YySRuN/cnFXq4GUwsYisWPWN48SBUYfrAA
 l1Ku3A71bQDdZbHNuydZgRn4+OUY4H2hAcLN9SeaSZQd1RGJ3cFLI3jfvMl6aHMu
 2RYnKx3iQ2xEFuqjABloLYTROzx9R9Gb385nUt1Si68TATCJdwvS2UegT7pMvrU6
 kmkoow==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuaqmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so9141659eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398909; x=1783003709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=RJkzzgLSOcQFAKjjGnlT6Gt/rLm1YidAUPWuj4tojfpZirMKQ9u4n5cEE4zJO1egU6
 qt1zH8Yl3asNY5TgYf0Emdig5AgMGZogIbA9kIRcVILw0lPfAmfnOOnWGfCNjKXRNi6C
 GBuxmJHdQRg/UU2u2SNWsV0CaExiFJkkCmSV0c2KYQTWHAKeR4dIflxbJxWiTf7/Sm1K
 TEOhYKlkxMJV6J/T+1A1vfAdZx760CLDc97Yc+tWiK9UcNH0DDU4O/D2MYyZJZzYcNm3
 K4r+7yD3QamaKN+xp6BprVXWQhSCVlimcZ2QHSEsqwd4S4ZFC9tSdpWmIpai6XWUiPcK
 umzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398909; x=1783003709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=D3K38lAJS5zhTxIeChk1Enb3Cx+FcHswutQ/G4JfglaML401p06UJCCD4BZ7+I9uWQ
 79jSsKwYOSB39RycTHX5orGPlPr5SE8971EpRANnjKxX0/u9S2CIy1FjvqzSZJC7D2W9
 6+EsiHUORUJx3XHktPvw7Ijv0aFV663FA1TcEN0rV9o1Fd3msEdM1XGv5Gp21bqS9D6Z
 HgJksx3ZAKvHgX4/Fg24MY2ii7ziyASDJXFVHY+rHikkHzekuFD7HO0z1DF8k1yspF/x
 uIcxSCLgualSc7JJHg6nR28uwwyBQVQjOQAgYXDZKrAXcFN6Gg1A6rIeRhr4J39dih0P
 SqEg==
X-Gm-Message-State: AOJu0YwY2DvUl61s9KxcCku4yqtuDpvLrlfF0Zr2GGluk1d5swa4Pa8F
 1iS34ixxwvFx+jpMVaT2ovgznnUvvzKXcbXqvhGe1jhsvdzaQ8tXickFhpzymVNj60apW/+yhtR
 09faHlf4qevTff9pmUQ5Js+sf7/jmdNFMxYBMECxrYB/YTrdu6jIAMj3sDK19NhJ0cA==
X-Gm-Gg: AfdE7ckKk6Ezji3XKPNNUEeOOI1Ud9Apbwy2gLLLTSm3/3q+zqACMTICBmq8tSIKYnT
 JMOCAHP4zhAVPXuq39ShxaBXGxWifGrQL9dShPD3QvVXaqXVdMbqo9RFF/57Nf0PyaNFbAqQzbF
 tZDDuHqR4Zh6r1PHdWb0pvIciwvzfiMFnGp9RNKFqtzBXhWYkHDjin+sQMxBv3XwMnBKFGAIYiP
 yyxtlqyhtJt7u/AZ//Mxeh3CfRVEhyyVzuHUmxU4RrCo47C+3hTaFyycHLJvoyn7Lal/FRmmSVv
 lUapLcLgauuZ2rbDnrUllXFyrzf98Az/wmKwYtSyRf4DqlQH24ZYoXNgUb4G1NC39SPPksO7Gll
 w58NVK5FIAqSv1AK3vgqei7LADNpG8QcjVdJqIYhbSvVlDrj1SAys+e+xmW4=
X-Received: by 2002:a05:7301:9f13:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-30c84b9dcc0mr3023186eec.8.1782398908581; 
 Thu, 25 Jun 2026 07:48:28 -0700 (PDT)
X-Received: by 2002:a05:7301:9f13:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-30c84b9dcc0mr3023154eec.8.1782398908052; 
 Thu, 25 Jun 2026 07:48:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 53/76] target/hexagon: Implement hexagon_resume_threads()
Date: Thu, 25 Jun 2026 07:16:10 -0700
Message-Id: <20260625141633.449487-54-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: NQL0vkzk85z0MIGVqo81pls7GGq3QjI_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX3GZ20Y5YN6Xd
 Qh5txeUwrONb9SSUzFrC+vP651Kvh3TwQ1rD/2hFMlakvmggbyItUzvZCA9VpQYvjIIyRwJP5OM
 ULaNwxSUYwKbApKoMUdZuwoXnb76R3E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX4nHhby3rGqra
 6x+cgjIey7Fq5fpcpwf2PEMlCVMAnMv9smX2394NktuzHW0YAdfjeJ/oTaHMr5DKbUV2yTdEa6s
 D/6txo9PC4+pBNWHeEGX7LB7ldY+hAzr5W3vYsn9gRv9KVLDD0LhSf9OZbzkZxaa+0mMJD9jTtj
 Qjb7kQUxrALuSgGkH7vyc3WJvGztYLvkWyu50ctheNejCk5Pm8vGRQoo2ZSfryIDkAuJSCLLQMj
 lqo24YntK04t4fqK00/aiuYnzdJFg+BZq29+ggseTPw7eCyrAv6vGmODZcUOfXxKxXBGCdMq3G9
 dQFYhwZ0VfCpUMBy5p64Nm6vjgkB/H5CM2ltKnMG6Qi0jPjfKhY8FUL5AySqZ5bwauALY3g6ynD
 zW8nPmQHqXqiHEH9z2By7tV4yn/gJp3b9T0Rge4//8L+eJkb9fG4lxHb4EXdC9CW2USd9RH2OY2
 3x6vlFet3+84exy6q8A==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d3fbd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NQL0vkzk85z0MIGVqo81pls7GGq3QjI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggOTJkNGJi
OTcxMjkuLjZhOTVhNmJjNWIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTIsNiArNTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRkMzE5
YTI2MzdmLi4zNGM1NWI1NjBjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDEsNyArMTYwMSw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

