Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF77CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9b-0003ce-1m; Mon, 22 Jun 2026 18:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9X-0003ar-JJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9V-0006cd-RP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZkvO1629368
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=I89z62XBu8jy8Jow
 NhGG1QGk69+6qCLFryaja777xGwIhkoU8QZegRez4Shzq5lDA0UEhlbQ7aBERp2C
 a2pcBuGkjz8zQF/1IbqEPzwEDpd+CxYPSr6IJgxGBN9MJN8FAjredtF7HFXhcsLb
 agUAu5N6AYAseFRI76tKiwV2DhdSB73OYhZ54iNMCkUayfHU8aShow6bUEQI4P0T
 veBBxB/SjGPQJ/LgoshzaNW8JQpUcTBPVDzmXuj9y9kI2LzSzgKGSGR2RQxidnne
 xUEQ1H4toXl1XGSiZiqCTP2At25Yfgn84HhBGxdfPjHy8OX3wBWXi5GHnws3vsK3
 VzBDFA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3cq2f0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c42d96713so952209eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167400; x=1782772200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=bkO0byMCChTi7YtLlq3Lo5SagUaOvqXintC4D0JZklJBAcWaOCKhSc8W78J6+tP1ek
 ZILwwL1pdR+We3fcwznvGJxRNR3H4lXmodFNkmRhUyrp6c8mYn9dv9W6UvrIAgPJanP4
 GFBuWmmhict6AYlrgPWX07LniNAvaoQe2uEbl3PW4YLry74npVooSIxnlWRonpi3UfHt
 oncjV+uWGo04PE4xcS31IUIN/Kn1K5unI/pEPebpu2vlrIsHmz1xVatlj9DS3LKAZLAv
 TisLGCJzOwT7WAc94MGUcLVwtGCXOhHJfhR5XnInrerpP+KYb3esFE2SBtft3LuPQXin
 Cmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167400; x=1782772200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=iQ39hyZ4cnPugQS/SQi2KqdmkAg/sAK8SNHJTXIbeYjkrgQ26N+aJzMg5lTEYuzw/a
 oqXg4uRftzXBQYvjk5olxSn4iOHUCPPfVS0WKkMDPCGmlUp6SYN3VzJrUbU7qjPMPJz9
 J55hnpGd1Gs/Wtb/vvG2qKC9/LT6kp6RSqR5QgQXi7GKFWQY5DXK9Vrua+UL90Cp0Jko
 9aHlmbl2J9YRkj5tMTGmUKKmZ4e1REd4uOmsg8+32bXyaupKx6Z6lRxybncQk8KwECGT
 uhe7Fcl8DpY0t4FaWAQeSLaGP3sF/y++8O5r1pUNSq8pJrZiL00WEKMzp1mrIpd2qCuI
 8Iuw==
X-Gm-Message-State: AOJu0YxGW9oGl0+ta91+AcRwG48ADJtq9vZh+kslvtTmubewnTFvG7fF
 LKseIJ+thyos1+Mgn/WOFwMZKAsPtQJvti5rJpEEEq569yZiw5qec61pvpnZkDWrP6Pg3qiMCt2
 y1HlL5fIkJg+fZ9jTpt5MHTrXxcOdKccXfHZ66sVkIoCepGRMMjuk+wiY4//U8K2/Ig==
X-Gm-Gg: AfdE7clBcbNPvh4/I2/wjeXUgH9dHmOqL6thFO3dBu7Ake0+Ilh7v7Lbl7KctT29wtm
 pzMoVMDqCKB7cKyeI1oyMr5ZNtDxBqbdqt/BsfAPA5Tth0ykRn0VcyUsYFhprX7GsbOkS6mCkZO
 xlbX/JSIydjNDtzCnonPVpE1EHBSJggy5ELl+vAJhMP2EKwh9rRNskyPdyOXn1/WhPLel4mYHJH
 OBQEyz7bJvlVzwnR/IhOl+A3nvdnZQkXFZ/iManG+G3tJ9eQaSaGXSbArJDh5V+HCXEic2/2u6n
 gfSwuMhe4XkNb+9wsVFVDr3q17nuSTa3rhnaw/ye25QtHcsVbe86XLu5rdxLVDbMWT+6aax83Pp
 diLszTwetTf46GDKnWBik6ekcEDj6XrFHzWkopPnb+xAxo/r6xS5Wvoh/b0M=
X-Received: by 2002:a05:7300:2210:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c06e0c664mr11175646eec.18.1782167399757; 
 Mon, 22 Jun 2026 15:29:59 -0700 (PDT)
X-Received: by 2002:a05:7300:2210:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c06e0c664mr11175628eec.18.1782167399217; 
 Mon, 22 Jun 2026 15:29:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 34/75] hw/hexagon: Declare hexagon TLB device interface
Date: Mon, 22 Jun 2026 15:28:23 -0700
Message-Id: <20260622222904.607771-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: QL3bmzAmbyOZ6C7DBhfIxoUHJ0k0bghZ
X-Authority-Analysis: v=2.4 cv=VKXtWdPX c=1 sm=1 tr=0 ts=6a39b768 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: QL3bmzAmbyOZ6C7DBhfIxoUHJ0k0bghZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX+JWI0GPdTvT8
 RyY/xjXj2pOUgTNaTZh9IYFZS7hniBGE8gz9/VAWbKVvnmw7jaCxHyqizO+qdm1pOkkBYPNP934
 wo4P3AIUgJ1qkwtbKAjpjtTCGux7/5jsQHeUKxWTM8UyoabLnU4qq1SkIFL0D0iCGSALI2fATdg
 G8s5VaMVM1p+iIHCkqj3tWIONDI4m5S9fWJR/JpfqXoFEX6Kysfs/DhAt8foL5PV/XRaQKcgk+W
 /U1HRe4iEJkGEv7W8t5LC1PnUQACQXbvR4NPrVYP6kXcUVem+MBx5++Ob6+EEeqkLIrhBwKZtje
 tbtkfieiukGSlP4UkoeF2FGJ5vgyIVdRvdG4xzJFvCe+PiZmCyi1Iq6eFBy6qHY4Qr2Nt6MD0t7
 CgCifqV5bG7kBScJo31YJGHE5NnxTSlwaevujHx9Jegdaa/5BtsGya5tR/roEMEWdHLYwIJBteO
 4SCN+q3nS/LWG9E4b7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX8m48/VxvyJMC
 xlANRQPGLd6bU6h12ZDKQNvwsmg38Etij5xqpYMKR0cGvJuQPzpY0cwEb9kc2SIUyEeSSNhUo6j
 SWMct0+Yhq0zWF1frCQwLICo+LV6Ymo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

