Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D02606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J+RgxUYc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VCe6Bo4M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9g-0002Ej-9A; Thu, 29 Oct 2026 19:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9c-0002A2-OY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9a-0004DQ-CP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZWVW1348782
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VlEAWRoIJKDp8cIxgs0MxIO5fIsBUHbWNW0sLxKwecQ=; b=J+RgxUYc6ulbTGpz
 CtbSAX0DA6pUcd6Db04F/mOTUmECetYxTqz22EOygWHoHrD65c5UNSLeJ/nkYnJG
 13TPsz3++/RwZniua9Hwj5cS/skmLRE1zFYxbi8zR+N7EF8nj00DLxLpXrJe4EMP
 0+lEXgfjvB25XFfV5NlDwLfknvRsGbZ9lxnDukIzk0wZVal7WJeJ0qgrfJvqTP9q
 F7N8Jf2KI2PYR64fgy6+T4t1IOlJ+Y3fQw4n1nNcwutpFhY2SZZf+jul/og+yO7n
 yDadvckkVZRI2ZD4FwOeMKZ4XZyfukkbWALVkjbccSY7dHxXfQQKBEOtKNQ6jf5k
 EDQwIA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qg8q0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1ac19c6bc71so110392c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793315004; x=1793919804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VlEAWRoIJKDp8cIxgs0MxIO5fIsBUHbWNW0sLxKwecQ=;
 b=VCe6Bo4MoeNMKYhUNCX6dRRc7IxbDkH5xMacIbnAkCyHPp2N9ysYedLXY27TVNtgub
 BTwQZ3S1/72FPYYDtQI0ZoouJUa8x8njV32cB4PmbDcEz3tEowk2LWiudImz3JwjHTuE
 azktPRuv6ok4vPXGNmDm3NciOhRpXMFwM6tZhuzuR3Yy7UXUV+pUXlReZxrdEAKgD+cI
 k15Tt5zy6GftzmS5b8RJnGKQw7Yr6QxrX5MsUWcUt2D+uvLSYvQ4xjgRr1t1atOgHIMq
 ZCxTNMkk4gpU7PfiXaCb4+S9a08EagMpMf0TpbneXPP2OwqZh/n4nEFWmHQbS8UClZud
 D/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793315004; x=1793919804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VlEAWRoIJKDp8cIxgs0MxIO5fIsBUHbWNW0sLxKwecQ=;
 b=j51X1Ww669k9ED54Pa0QCDs9Hqv1BdNrdzAn75pfu2rqteSQGF/fWacyixOEOU6kds
 yR6Vs903jMkcnwGSozEY05eRiQxA36AzVOZB2YHeAVgWxsvdoaYrIHlCVqKVCWbXuPIW
 r6ApXLWdQgNkyqFLnTPhyOkupcuEEH9aOhRbZhDNrmIZNT27XRj0tk4FBirbvlNQ/MKJ
 dcIr9wQqY3YwmHHXI54KFkuTUfA8pVGtEdWJ5PoQs5vP1zpHgC1dwk78byIi7jCf1wS4
 LAh02li1rHDkAPLwFKQFWrQzWG8W5wBnxxQRJ8tbE7icIn69I99NYKRvUkQP3I3oO3tJ
 XI7Q==
X-Gm-Message-State: AFq9FYKH1nuVEGJfXrFwuJroC5GIkrv+tH8kdVjQK2gihIXFfpnrrw14
 Xl9Pj4iPdgh4WV/Bjq2QUN9wEyl1H3Om1fxX0Or5reE2sYoTiXXWpUVrOmM0Oiqyvr57nVxn60s
 fJ2i+7JlU5Rh4z478yTwfFYYVZsYpLHkd2N9a1hFbU9tYY+0YyoHQfCpft0ki1nzPVg==
X-Gm-Gg: AYBFou3UIAFSlFh70/8qvnECKoEQdnmzJkcBJq00NvNengbtBnHn6n2xDQrnxNIMi0+
 Gvkr2bQZf3qhddrxv424LMO+1UZ6sK7qMsvow1haCnoSNT5HpFnyIFkSDh0qKKxtUoMdxVdaL5p
 gb4LUSCMHqUWe21qSZVda1JFSPmkngQtq8gI8/bwZzg7t0JMugYF+AjtoCh/Le0XfDZGsJLyMF/
 9EWa09O6HPg7jITua82Ttu+GdMIi8+02D1Y/BxAodZ7Zob64OK7e5R6lE/ulgATSyIarTSuhaxB
 sAimsH6lP+F4cuYyUqc7Mcrf1ActFvs5URqMZBV8tpc+eh5GasxGGpYVjUgMX2svjJm8K55GyVi
 T/fALzKKf0z094UOLyK9DcG4/x2VyGz6QIrv8QmMEaTawK8KE3g64l/O/xCpHpadgA0R7JQHV/p
 kLcDV8T/kEy1nr8By0WnYG
X-Received: by 2002:a05:7022:5f15:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-1ac5d88c71cmr647173c88.13.1793315004229; 
 Thu, 29 Oct 2026 16:03:24 -0700 (PDT)
X-Received: by 2002:a05:7022:5f15:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-1ac5d88c71cmr647132c88.13.1793315003632; 
 Thu, 29 Oct 2026 16:03:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 6/8] hw/hexagon: describe HMX in the device tree
Date: Thu, 29 Oct 2026 16:03:08 -0700
Message-Id: <20261029230310.1632334-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Lb1uKEMEV2oZCscX6QIViJe5M0MbeyRQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfXyxOhAFvZQpZX
 9f3bhe0gVFEL8Vp9zESRmbSs33xGk9yH0Oot/gVWsiiMUkRKC7LTZ72Mm3SfrzMpiXx0cIEGjwr
 KLk+pj5ws8NRItgUHpiwH3zuY3E0rbs=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae3d0bd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=FJ_Db1yowrU-949eLB4A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: Lb1uKEMEV2oZCscX6QIViJe5M0MbeyRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX0Z1RXrMTLcTq
 oxEWOmqyC0Xh5reMDxU4CPmSmnS+0OposXNG6oA4ikLI0pgqL//19VqXkkdGx7hx5WYzea9rWLY
 VvSRdvl0York/pJMvvabB/vYqO5J4qMepv/zhW5ikJfG6mzLyJh5lfHLn4fAExpSk+UKhWoYgu5
 TOi+GFxq4DficUdkV4TVjnjyNnANr8dkG8X7+w4CdUk8NraJx/2u3RYUeg1A2FMNJunjc0g96uj
 T8oOSkieMHdqwGtl1ltwPqT5VfGVmFDyNQyItCtVZ9MjwP79p5Ny0QkwTONNgNV6CMHUSxacVBn
 QWqCTGlqGhUdh5zRuL1JzwuscjKfbYKaM9taaWmFiKgPDXzpANXWdx1OZ/BnP2UD4kC/nCtqZeq
 JwknREznQ30a+luW0H1qQPbyQdIgk3Ga4ttUXnPw4dL3JBv3lI1eMZeB5XWaChVzrxKTEZHQOLq
 SZP/RKgcNiCfmlzuDJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

QWRkIGEgL3NvYy9obXggbm9kZSBmb3IgSE1YIHVuaXRzLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vaGV4LWJv
YXJkLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2h3L2hleGFnb24vaGV4LWJvYXJkLmMgYi9ody9oZXhhZ29uL2hleC1ib2FyZC5jCmlu
ZGV4IDNiZjA5ZTRlN2M3Li5mMzhjMjQ0YmIyYiAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXgt
Ym9hcmQuYworKysgYi9ody9oZXhhZ29uL2hleC1ib2FyZC5jCkBAIC0xMDYsNiArMTA2LDEyIEBA
IHZvaWQgaGV4X2JvYXJkX2ZkdF9hZGRfaHZ4KE1hY2hpbmVTdGF0ZSAqbXMsCiAgICAgICAgIHFl
bXVfZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwgIi9zb2MvaHZ4IiwgInFjb20saHZ4LXZsZW5n
dGgiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHQtPmh2eF92ZWNfbG9nX2xlbmd0
aCk7CiAgICAgfQorCisgICAgaWYgKEhFWEFHT05fQ0ZHVEFCTEVfSEFTX0hNWCh0KSkgeworICAg
ICAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCAiL3NvYy9obXgiKTsKKyAgICAgICAg
cWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgIi9zb2MvaG14IiwgImNvbXBhdGlibGUi
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicWNvbSxoZXhhZ29uLWhteCIpOwor
ICAgIH0KIH0KIAogdm9pZCBoZXhfYm9hcmRfZmR0X2FkZF9jcHVzKE1hY2hpbmVTdGF0ZSAqbXMp
Ci0tIAoyLjM0LjEKCg==

