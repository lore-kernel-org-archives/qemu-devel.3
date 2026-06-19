Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57924CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCQ-00030g-E3; Fri, 19 Jun 2026 19:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC8-0002Kf-OS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC6-0001lF-RP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXprU2933183
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=IeySzHzlAmnEdQXM
 RklJB91J2USaguleIO8GNgZWj5Graz4Idf+kIb/kphR9BEn+RaXyD8ZmzU+ymYql
 y34mMI69TfDUY6u5nM9JoIb6zPJWSOh2yxCcAxNjSQaGwju2XvZMTRpHXlB+fmAm
 LzfeA8o1c04cwMcA2XYAAhioOKUH4ANzXlmpta2xx4DcZ6o6TttmFIOCBtdiKnsN
 YtbpJ9fkfqPRr1CnDoG+RY8XqF4Ijsk4ZcvNpASMab0+pRtsmg+TPUS1OZ/UfDo8
 0pC2TslvjaYCgrzgp6p5gKleuAUxBCcFyK9jqNHvxXkF83TdBy4Xh5u/4jVuhgBL
 S0DpZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qsa2ws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so530714eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910003; x=1782514803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=D1kDsvknw8yJwvsHir2FH7uZd2SHpGm4wGUIN0jLMNNzW/LSLo/nZ3gvAr2PmLeuWi
 J8aF4UIgdpwuvSEreOkkJI0xW52t7WhlbTtNptzxxViDvMMCotSYynQDp1t5eIapTPb2
 lwuZNDeTh4UmFT/4zgeP6adMGcSFKu3wiKIppyjo9UqW4F9sqN+KDORe1iX8ywQ856//
 SUpoD9mchZ8pNTTd2gGiRuXn9/DWp0+I5cxnBwEu22uHTrAxYnCz6T5yjq3vAb3l+y7S
 YNb4XiLlagVLaA5rusCm2uRieJVMwqijwyT7u1k0HuYU9Ljl48gvkFztdOu0z/Uw6xKN
 srlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910003; x=1782514803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=IlhdKrwaOg3nUSLR4uEdJe9m7fd2mVYfdYB9i0J9YlvurwfXIyKVOSryIuaFTNJmD1
 YjoPReYuM774sZQNO/fetdMbJFTCW1zUz1G2kErVDLQpa7W0ZyHOZ8tVoZ2H4KqdtxYY
 w24QNWqQSzE2XazvCMX5B6tcMo1ye98NlbkmbYJq8UNS5IqVoMs+LBJ5EnJfsY/GJ2ve
 jeqi5jw9QywzqmCu3qzN9+gCSl0d8mQv9y9sdE/goNq90GcZaDCXUuFMcNnn4lP8X01l
 nQxySRGff1meb+uujrEJk4Bki5bkQMmxCCSnPIZbCZCGCHtvcHIcvwzch1oN/gkwtvF9
 aSzg==
X-Gm-Message-State: AOJu0YzHeF66+sc/7WOVoNB2eu60ayB+o7Ws9a4CIKU6ETbFm+3PQ+KU
 LtX1UPv6p06m2MdCS7Usbi+QUI0MoJcOiRocCbERUd6NbhSG8p/vv9n3Q3ugcVWtJiDoBFZjvWK
 0A3RvvQNBTeS+w/m8w+SyTRiR2t4VSpJc9e0Qn3UxCDySDYIM/Z9bqPTE4slfllDCFQ==
X-Gm-Gg: AfdE7cnUqX7lIdHGdyQGB8bt0ytzTZNI1Ny/kYy4757ajDK5c+10Hq4Yr3HqglGFFtx
 nHXueZTJHMib4r6G6GVChaTXyXFLqgIOVbfDJlQZymoSG4Qkpo5aGM6GHXGUcIBsZERDtyriZqC
 EBYgebaSpDm/49UgzHvFkNuhym+w2gDEBDfPsp87p+gARUxE1bg2iWSneQ4qewBw2EeZ4YDdDch
 L8SgcrBrD6kSrIkXsKRAnDq5NtyRXp/msKUso7y/aVD3BBzRHMgdix4HyFOATq9Eg9LqV7MhYpK
 4Q7oKQ7yce5O3er0k9W6dOdxhEpT2/ZtgjyYnVz1EKSGnnzgH2vAN54vHnb/EwIIGEMT27daFGc
 dE8qNfyf7NoMzxtFeMvOznYRtR9h+E0zlX1TORezdIV/f7l8GSaAqLcqxfqA=
X-Received: by 2002:a05:7300:1905:b0:30b:f4e3:a2b0 with SMTP id
 5a478bee46e88-30c07156f4amr3412109eec.21.1781910002757; 
 Fri, 19 Jun 2026 16:00:02 -0700 (PDT)
X-Received: by 2002:a05:7300:1905:b0:30b:f4e3:a2b0 with SMTP id
 5a478bee46e88-30c07156f4amr3412093eec.21.1781910002255; 
 Fri, 19 Jun 2026 16:00:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.16.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:00:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 33/74] hw/hexagon: Declare hexagon TLB device interface
Date: Fri, 19 Jun 2026 15:58:30 -0700
Message-Id: <20260619225911.159473-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX/hExlftVjjuB
 rsRleJGVd1qmg6S+X7xGipmlkRcYyhmEuPJAF4Rk13jlXWeqEM4BU7H9e4LW+iHQ/Yfd45TEA8+
 8pFXMf8rqfGapTUoIzhTQN12FZneaeER96A4csXk44xsR7iZOT6dwStYSVTM7gfK9BPobwtM9+f
 3NO/p+iLEiaYrhA2RGWJ/pJzn90gyCtzZ21Cp7mKVwY6dsH1IFy/XvxWnabaH5YTsYK9xm4eNpQ
 ff1CxuDQvafYNTA7kZPBJxwKSIDuqCGKN8bl8mv0eLMMwwcxs3HzCvVwoC1UOL8ATbeV5t4FSS8
 14j09wkL2Mfrqjy5VBCBnQaqMnX1q7e1G5LpzmCZF0FC4+tWz1qAXE15GD/perNgHqdf3tv81gi
 2dDE2QcALKuFhoT0zWO7HXqe/PrhkFHgXnyPn3Ch2EBvZkpGDrwLTxIn/o3UqFY81NbVa0lUEHq
 A53HZXDexrPG7GduBtQ==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35c9f3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: ZIWWDuJzCBx9WbiqEIkG1Pqmj4EaMs9_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX+aptZY/YuX6c
 JxoAjMTkTXoEFBF7t+sZQksD4PMQJFeMcTu4gIGL3V5GzanbjjY3OjUsH7LVDf0nHKKbbTfzxO+
 DH6gj+vyOi1ZC3gJbIdFSXDvLoDzLdE=
X-Proofpoint-GUID: ZIWWDuJzCBx9WbiqEIkG1Pqmj4EaMs9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
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

QWRkIHRoZSBoZXhhZ29uIFRMQiBkZXZpY2UgaW50ZXJmYWNlIGhlYWRlci4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90bGIuaCB8IDQ2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl90bGIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOTBk
OWVkODQwNDMKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90
bGIuaApAQCAtMCwwICsxLDQ2IEBACisvKgorICogSGV4YWdvbiBUTEIgUU9NIERldmljZQorICoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaWZuZGVmIEhXX0hFWEFHT05fVExCX0gKKyNkZWZpbmUgSFdfSEVYQUdPTl9U
TEJfSAorCisjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMuaCIKKyNpbmNsdWRlICJxb20vb2JqZWN0
LmgiCisjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCIKKyNpbmNsdWRlICJleGVjL21tdS1hY2Nlc3Mt
dHlwZS5oIgorI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIgorI2RlZmluZSBUWVBFX0hFWEFH
T05fVExCICJoZXhhZ29uLXRsYiIKK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25U
TEJTdGF0ZSwgSEVYQUdPTl9UTEIpCisKK3N0cnVjdCBIZXhhZ29uVExCU3RhdGUgeworICAgIFN5
c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgdWludDMyX3QgbnVtX2VudHJpZXM7CisgICAg
dWludDY0X3QgKmVudHJpZXM7Cit9OworCit1aW50NjRfdCBoZXhhZ29uX3RsYl9yZWFkKEhleGFn
b25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCk7Cit2b2lkIGhleGFnb25fdGxiX3dyaXRl
KEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpOwor
Citib29sIGhleGFnb25fdGxiX2ZpbmRfbWF0Y2goSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQz
Ml90IGFzaWQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgVkEsIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
ICpQQSwgaW50ICpwcm90LCB1aW50NjRfdCAqc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQzMl90ICpleGNwLCBpbnQgKmNhdXNlX2NvZGUsIGludCBtbXVfaWR4KTsKKwordWlu
dDMyX3QgaGV4YWdvbl90bGJfbG9va3VwKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBh
c2lkLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFZBLCBpbnQgKmNhdXNl
X2NvZGUpOworCitpbnQgaGV4YWdvbl90bGJfY2hlY2tfb3ZlcmxhcChIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDY0X3QgZW50cnksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBpbmRleCk7CisKK3ZvaWQgaGV4YWdvbl90bGJfZHVtcChNb25pdG9yICptb24sIEhleGFn
b25UTEJTdGF0ZSAqdGxiKTsKKworYm9vbCBoZXhhZ29uX3RsYl9kdW1wX2VudHJ5KE1vbml0b3Ig
Km1vbiwgdWludDY0X3QgZW50cnkpOworCit1aW50MzJfdCBoZXhhZ29uX3RsYl9nZXRfbnVtX2Vu
dHJpZXMoSGV4YWdvblRMQlN0YXRlICp0bGIpOworCisjZW5kaWYgLyogSFdfSEVYQUdPTl9UTEJf
SCAqLwotLSAKMi4zNC4xCgo=

