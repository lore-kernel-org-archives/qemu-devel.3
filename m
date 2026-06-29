Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1228EC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBn1-0004GL-PE; Mon, 29 Jun 2026 09:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBmz-0004Fg-P2
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBmy-00034K-5m
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT6pX2618925
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=011SrS5GzZCft5XXyTaQlyV1WtjpEAOEvGsDEjZd6oU=; b=Zv
 BHhrTBUq4e0lmoy8+5lTToV/2u0/BT1XhYB90twLHkbONkZJAuEK9Y6CbYL0qs4s
 Cglg3Lk24yj9upFz3kmEpa1Tfz5/LxaZg/bH0X+1ZeV7qSddZLMqFcM9KlfBP2VK
 f5aeZjOfWd6XmOCTKQcjBtJndJ8cULU34VS/NccefnNZ9oyruxHFaF8VV5LIDbaC
 xzMWIj6Jxs8rmnwDABKWCNbxun8AKJYd4f72eJROseOjQwcqEu+ARQweKJSYSTk5
 FnB2k6u0ocZiPQTk7SNCEF4uZu84Gb43v45EfvhLRWsxlcUFAwNpUb3Cp0revLZD
 G3vMh17HdO1iBXIARpSA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrr2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso5332788c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738758; x=1783343558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=011SrS5GzZCft5XXyTaQlyV1WtjpEAOEvGsDEjZd6oU=;
 b=jfrNtIcp92Z4vQxEkfnkhAAhXXKXk2w3iHSxZUxCZulZjws9sSuz2aI6XWmqHLAIKe
 2d3VWfeUTIFAFOpvAei1r0est0sHHOJke3KhJMLObycDRZI932EolCO6sUuR9NSeiJ/k
 Ep8qPeANcd8X/QWdfjVdbSkVGY2vzazSzDKh33bA7n/HS7XUP1+xcPEosldLqwuWn8Of
 md8ah0StR1LeMhvdac8qenimQTtE7kzAKUwE7CPkLNj83cFPznolESUQ76UrxRpAIEJq
 bgmG6sk0CRlPOAKvNF4pKWSrQnsacbm0//Sfe2izThmPsEu39OLY+dGtsTXvxYmHzN3n
 2UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738758; x=1783343558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=011SrS5GzZCft5XXyTaQlyV1WtjpEAOEvGsDEjZd6oU=;
 b=E2F+hRrMS9z1TEDD9Um9bb6R58FARtkj9hfhQBP1XnFnlTsIHGgfiRRduFby01OJLT
 ZZqGqpV3C/UOu1XB711xseX3G2honuJCkZAlKavAjdYFK+qGmxE2dTa3XxNKYLDVwaQ1
 hNzu7fuN/83gpv3GZP6isK8/BLXe4Oqlwc9CqYW25OfA+fWNQjZJRP8aVPLp+mv6o13u
 sbeLdp9Le3ILEJ92TFz+Q2SFqHVI+n8zsFNvbNYWrpSWN/WfXfEw2nHcphc6y3Gr7S4u
 gP/+7bDHqIZ26DW8wi6xcvRsnSxuM6n/ojSOc6+qcD2Zce4s9P8x6MKWblxeaF3QKI1r
 UPsg==
X-Gm-Message-State: AOJu0YwjePQnlEAxd+Ydue8SdFmBWoSCtqqwez2AmJg0j19jWytDfyxM
 4qwFt4wMQ+b/ddzurQAk9hEo32DWHAtT4rHOudnjlNiLF6qdw1JqqPkwHyyREhVNMaeBxOvcLqi
 l1hZK4gKcGfSeSXR42L7wBEEztogNlSe6yrSXXCfBCY0vVU+C4pE9Tcs0BCFQkA4kYg==
X-Gm-Gg: AfdE7cmHN0F2h/bt7yCI07dsgBj82UBFFt7MmGSs9EiaYaYMy5xWWFMtHSOYROqtvTH
 3eBUvkJ3LwMnTQPH59UD/QM3lYo3n6eAmQaIKjGXAqCoxlJTY5+Y3tajVdsbXZpzNR/om6VFnk2
 TIyLaQqpFmhMgRtgqqPYMOCpkuYOX23528OptPCbo+neG/3Q+p5vqiKCIbnghq3b9qIm/EkVpVR
 hvR4ChR5coC8CX/6UuNx62BlZl3VaZ2AMl02pUB6+OUo6pKINNSyctohPrxJseSTnSe/Rw3RHcf
 aU1sMuRoszBgOfup9xglIgxLiwqFmHiiZZuqn8I7XZHTbMVQiXVo9/74gsJSJi4sVl9v3Bjh8nc
 aIVYH0W/uZnj3c4+ahTURsDC4jA8gGRNRhzosZh3d13DTouulB7Vy8GbTkhY=
X-Received: by 2002:a05:7022:69a0:b0:139:d66e:687f with SMTP id
 a92af1059eb24-139dbac859fmr15434670c88.24.1782738757895; 
 Mon, 29 Jun 2026 06:12:37 -0700 (PDT)
X-Received: by 2002:a05:7022:69a0:b0:139:d66e:687f with SMTP id
 a92af1059eb24-139dbac859fmr15434642c88.24.1782738757332; 
 Mon, 29 Jun 2026 06:12:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v5 01/77] tests/docker: add flex and bison to emsdk-wasm64-cross
Date: Mon, 29 Jun 2026 06:11:16 -0700
Message-Id: <20260629131232.2487780-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a426f46 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=dTW7Cx3YwPv8u8hf8ikA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: jjvOZV2o-lUYKUJ_X1QWDGvXOIdLtbEf
X-Proofpoint-ORIG-GUID: jjvOZV2o-lUYKUJ_X1QWDGvXOIdLtbEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX2idM0E4/UBzz
 5fJvqK4UtlG1f4SQB/eS+wG2tOema5RoO/mwUutP/I1OK+CZKBHqqGMq+IvWrIetz/ucHUq1gv3
 8bzHnQjRKUVdFSSSkU0C7xixNpNRjrSCIK7isOn5k18BAsMqI0OwwzpFcZr78br6FeTjqc83Fh3
 OrRy96FWFIGB4tQeSm02ihjaUgBuehXZexAfr96Ky6XLDGa6DHLJ7hRQ3WdTFsphaWDdRMaSA/Z
 FwGq8kSME2zoOh0Js1q/OW4fl2inz8LyK7nhmrUr8otmIWC7R17jMAW0bAsXBOgwgnfvfNCwXa4
 Te/JoucYDa0pg1ZdU/K0QnAQ8863KtVt/HDMeiQgz+VttOkr1Um5Kv0TrzUdxT1zpTN2lWqnyIX
 tAvSrccYr7UFhatGwIfYwJB4kYKSw0mtBYR/IamjEFcODyExifvEPy/KhrHsFQSz/RJd6fBaeuJ
 ddc7tFY2VvTh/xyzexg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX2aB7NVlOnyAH
 7OSyAUMyIOIvCMvIRZp2oOh0z8AvD2yQe8lXVb/lPUrIzk51j3teMnXEVX4nzvFMgJFgEwQKizX
 pnZ/tjVmD59a7x50qqaeiiRpP8kiDLQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290108
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

VGhlIGhleGFnb24gaWRlZi1wYXJzZXIgcmVxdWlyZXMgZmxleCBhbmQgYmlzb24gYXMgaG9zdCBi
dWlsZAp0b29scy4gIEFkZCB0aGVtIHRvIHRoZSBlbXNkay13YXNtNjQtY3Jvc3MgY29udGFpbmVy
IGltYWdlIHNvIHRoYXQKd2FzbTY0IGJ1aWxkcyBpbmNsdWRpbmcgaGV4YWdvbi1zb2Z0bW11IGNh
biBmaW5kIHRoZW0uCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL0NB
SlNQMFFWazZ3c09uUEFzcEM0WWZYUnA5MHNhS2liUWZENE1rLTQ0LVJRbzBrPXozd0BtYWlsLmdt
YWlsLmNvbS8KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IEtvaGVpIFRva3VuYWdhIDxrdG9rdW5hZ2Eu
bWFpbEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZW1zZGstd2FzbTY0
LWNyb3NzLmRvY2tlciB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZW1zZGstd2FzbTY0LWNyb3NzLmRv
Y2tlciBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9lbXNkay13YXNtNjQtY3Jvc3MuZG9ja2Vy
CmluZGV4IGNiZTIwYzcxOTNlLi5jMDRhNzQxYjBlNSAxMDA2NDQKLS0tIGEvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKKysrIGIvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKQEAgLTE5LDcgKzE5LDkgQEAg
RU5WIENYWEZMQUdTPSIkQ0ZMQUdTIgogRU5WIExERkxBR1M9Ii1zV0FTTV9CSUdJTlQgLXNBU1lO
Q0lGWT0xIC1MJFRBUkdFVC9saWIiCiBSVU4gYXB0LWdldCB1cGRhdGUgJiYgYXB0LWdldCBpbnN0
YWxsIC15IFwKICAgICBhdXRvY29uZiBcCisgICAgYmlzb24gXAogICAgIGJ1aWxkLWVzc2VudGlh
bCBcCisgICAgZmxleCBcCiAgICAgbGliZ2xpYjIuMC1kZXYgXAogICAgIGxpYnRvb2wgXAogICAg
IHBrZ2NvbmYgXAotLSAKMi4zNC4xCgo=

