Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1224DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnC-0004Kf-AC; Mon, 29 Jun 2026 09:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnA-0004KF-St
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn9-0003AC-Fb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5H1x2728776
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=; b=YuDi02AO+dwU8NI5
 oU6127/6TWM90S2tU7ciDLtVop88HUCtOpfvzdSu8ydXk3DLmc6qnF4cFhnHWV2F
 nVH5nIPpel4Fw4+qeuTzJNuzcZv0nEaNiPDWf4Vydv83PzX5ca/JPYsfDxk9TYoQ
 pXmC5XYP4uxVJxvj5BsGZFZ7aAwR5M4WPd9NXMV5q2cOZZsEtoFfdLuprVYZ1ExH
 1L/zAR4yQ2vBGmabrSBhz8tn8TCoQIsjHTKT4jFTFdKW5ixxK/SOQHFK8mR+BXq+
 /pwlkLjDvKlnWn7dDJBcZBXSgZ0qESBxkxTJ98vjuCKpJzXub/TCjd0kVgO+CMPH
 g6/5vg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8eyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:50 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139ca26403fso1574983c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738770; x=1783343570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=L31BITWxFqepq6fLgJrtVxT1A3ogkFe3VOd+ZwB3n2KvEmkQq2edaot9r3zWtjVFpa
 5zqTRdIKKjmqEc00NASP1nG4nt4gmQvhb4jRSXRuMx9b2IoRJzJEnFTIQhwELYmv15UI
 OFDleFXRyo7o9ZoZzXxpKVJMJqN5zwvM9fQ0twHABqcP02B0hSXRy7+P0yqSz504n7FC
 M2367MJ9cFtZxxwdHGHA7U4EGsD+lk5zcF816QU54onKvPLk69zLCfDm0UD30/yc3YCa
 a7TzxQ9Tso7EncNujQcsG8FZSL3MHAjNHjqvsJOTjuCOOSmQGMUhHq3QorK41FIsN79j
 l8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738770; x=1783343570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=ARIfEztAVu/wPvwqgTvxQntbNdy1Bs2G9VLQnbinUYVkbV1n2o4xL3HRm1wLNN9c7H
 kYqpqBDZmEvFH0AHbkpI0aLTVgK59clrR6uY49ku6Dd1xUCBPRsT9kYX0RY76RVgVWJZ
 6gh48m7XaHIWncdaAY4C+ajQDGScXMzGTBWrQaJU73REA//bTrMlwpAEUi03sjktr9GK
 Hx2sS7JWmjB2GCtQ391Lyal4isF7KTHT+SepQ0Jk81XS4uz7MTXDWOkSI+x+kb25y5rA
 TB0Dq2Q60C+ytzmidqMCwrbBoxobAinRawV/C3ljY/3RIh10qP0lz7TEPvsmlpLTpUUI
 XlSw==
X-Gm-Message-State: AOJu0YxC1tk98Nx4g0IeqQ4OwX1qtrXx/HI2fsHgeP6p0Zi/1CvFgv1U
 JMXkjdoL3GFDIL9bR/nhl7fwgq1DuUAyTkR/ftVaQ3N5xvqXllx/gfBy+hTalKqIICehpv8jis1
 j1hAwWnBtLb8ED6zUokKt+Ci0Oi4UV2MwePWoP3b8neqMXfOwlAG7/a1KdniiPVN3UQ==
X-Gm-Gg: AfdE7clE6e39PVLD1l0KaY8d5j7Ylqa7nGpXoIyilGyKj/iqHuQ9nQdi4gh2KlLi7zj
 UKrDLlEZDzb7dNrqNqAiq/dA9/n4SVQ5V5f8YW9O850tLrXo9CcWFDreAwT3d1Ztc3gAwDqH7CC
 EDnVpH5W+7heQs3vk1piYy42bFbunBaAUlcPmzJjMkwUX/HgZGQAvNKy15qw0LE5DTshjq5/7Iv
 WSrAxmTT2SDHuib0JVZTXcgfrRXnEl39xghlY9nhEKQjBit8iZyx918439Dx/LzkMTAiphisCCh
 rPMKJwvwyhP0LL8O8QCrNfq24j9SPbOI7/XxcgT13ExrvstqJeN1GBbRwVWC2vxKAGFRzETIXgA
 1exwFo4uM7H5Bee5m+jLirpxXQ19dDNpEn8SpIDVFRU7WZv2eSR08s/EOQ4A=
X-Received: by 2002:a05:7023:b0c:b0:138:14dd:16ba with SMTP id
 a92af1059eb24-13b22714f85mr392133c88.38.1782738769675; 
 Mon, 29 Jun 2026 06:12:49 -0700 (PDT)
X-Received: by 2002:a05:7023:b0c:b0:138:14dd:16ba with SMTP id
 a92af1059eb24-13b22714f85mr392107c88.38.1782738769167; 
 Mon, 29 Jun 2026 06:12:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 08/77] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon, 29 Jun 2026 06:11:23 -0700
Message-Id: <20260629131232.2487780-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5VKHqSD2d3UmQ-rvaGjv7AnZwiY3e192
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8ZMSjAJaUb2t
 7hAF8UMDM/kYAuWC48H7OmwUw5DWIBMU+zrV86Hghx4fonG9s1YMmN4fT7Vk6ujOq0haHqYSJSl
 BxPDC03r5ahGV9J5c5YrGCQU6vffFc2UTYAYCoRrcd1bnqmJpwwv2bAOZAE2rhU6ivw4iiVH7Pl
 D5zjZkmhFi9Vjk9T/LoZr0pbPueeScFHd73ZDuIQWGJheI6og4s1MpxvFT6G9cCmURrzYsyJsSN
 u6H8Fr8sA7JscA+7Qyjfg3paAw3e8P7ZitDTYkFuq+cSyfpx/7YaIJf3QYnRmiKsoO6L50TEXod
 ivaJA89XLWfSMxoN9sY9cOlqS7iAUSUsi3QOf+NO4bVKzloMoD3RTouvjnKFAr13ORgiNrFyxYF
 C60jZWUUo1bhSXUm0pi8WlSq7weXkvUi7tsz1vs2zm3PUZNTHOIp9PHwVEedt8g2UUB4WXOhQFz
 D+Pd1GAguwvtWiqcLEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXw14jG73kAqYc
 9p1ozxrbhg6gYgSngUIcGd/pTEC1TZjd9Oj9/Yok69KFdRBfJDo5xLhWe1+ANj4Ix9BwM5vDniQ
 AIDHBd38mWclYAl7H9k9+cifs3uvpY0=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a426f52 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5VKHqSD2d3UmQ-rvaGjv7AnZwiY3e192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBlMzdkNWE1MTRmMC4uMjgwYWVmMGRm
M2YgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjQ3LDcgKzI0Nyw5IEBAIGRlZiBuZWVkX25leHRf
UEModGFnKToKIAogCiBkZWYgbmVlZF9wa3RfaGFzX211bHRpX2NvZih0YWcpOgotICAgIHJldHVy
biAiQV9DT0YiIGluIGF0dHJpYmRpY3RbdGFnXQorICAgIGlmIGF0dHJpYmRpY3RbdGFnXSAmIHsi
QV9KVU1QIiwgIkFfQ0FMTCJ9OgorICAgICAgICByZXR1cm4gdGFnICE9ICJKNF9oaW50anVtcHIi
CisgICAgcmV0dXJuIEZhbHNlCiAKIAogZGVmIG5lZWRfcGt0X25lZWRfY29tbWl0KHRhZyk6Ci0t
IAoyLjM0LjEKCg==

