Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EB606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MvhOz6El;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M/KW34kA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcYq-00046L-Mc; Thu, 29 Oct 2026 22:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYj-00045A-Tk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYV-0005tP-0T
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2JquR2933740
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VlEAWRoIJKDp8cIxgs0MxIO5fIsBUHbWNW0sLxKwecQ=; b=MvhOz6EltLw4NnwQ
 vMXag7Nr22H5Df7UEX1IQSVDbaXQSDe9liy0QQdR+GQbIzqM/KvRs7tGooc2Yrku
 FUhy3tFbbz8SeW2CCuOsQY62RxrooSI+cCET0l3vktlPpQ8L5v2AYAcwcwVIY9fS
 8uBoqwiGXScPOC+a0ViJF+Ypy+szi6l12/2LNitRPIoEIEwC6TvgcCc2DwEWC1SV
 7/Dv2z9KcP2F8AXPjsKiCG4ZtTZyknp1lCouWzjoSSkcWldzIa053u6tGYQ7fowr
 4GQUuODMEIVB6nLExYTtsdAd2/Uq2tszJI/OsqTcFTjbe0uxMGFcBdeMgXIEOUqd
 xPg7Rw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rgvjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so565846eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793328080; x=1793932880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VlEAWRoIJKDp8cIxgs0MxIO5fIsBUHbWNW0sLxKwecQ=;
 b=M/KW34kAG3JWoLJOs8Nh9NVuT4J6xJ9vlEo3L6/ejawnLy+0JFZSqt9RNabpZhqgN5
 cReSBJFNk6qUkcX3jj1hvJv3aG6EiJFBiT7jinrHBPqGH8BNjAY+XdjS+TBYm30xf3GI
 M6IujjIPE8AXR3rCR9Xvhx3NUoap/do793viQHeYCagNDjk0o+px0zhXNRyK3z9OE5+A
 F2NZb5PUQ+EjXEwCl2gFn9YLYjAtWed+a0KNE6xB/FFDzyTBFAprzBZpBQZGW4oC4ZTF
 xFQeyvpq3ZqdIA2UxgOVO09V+knAQnyGb+gqZ+8J5OZx3ABn2VxhUiGfwXcTHmldnmS9
 geHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328080; x=1793932880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VlEAWRoIJKDp8cIxgs0MxIO5fIsBUHbWNW0sLxKwecQ=;
 b=ouDJX3gsU9ZVF7CeGQUQ1g/qoFMAwwHo8deixUSR9lKS2ahmkdpFINyijLlEBRD214
 QQkWhKNksPfHVLtw8iYtDWJweLLLV3gRO/7L3S/F3YyLrdEpz95yE4LGG1g2j3Dxy9wW
 NSkXLC0WBFRCM0UpmVQhwlJr4vNOEPQBTlrPTh7+IOCfjjGeM4+6R+itJOhzHwLDxAeM
 3/SQ0sdX3LN3V6d2bXvFYxn/m1m8dbBkXp2itfAOt52Q0ENQY0gUWZG+LwVEGQsfF5kp
 jcViWAWAve6Zv1iZTTGNohxs/dny9x97UdrKEPSmU9HE+nkkmwXqXU0ZdKxCdnGYG7mp
 3Z0g==
X-Gm-Message-State: AFq9FYKq9fR9JpAQy28pkXQ6QwkXjAAsKdLNBNSqPRdEstZsY51cqMJX
 MRjtR52PTD2LfSBAIdnKjFMTKSql+SFjezBDzzNSH5gqkCYD5GW6gdrcBgz0TWOBZokw92DlwwF
 jKihWEX3iGI+T02uHEubR7hyan5mZEjOtI1IjuCQPRXPkCXo+TM4vWiNCtSNYGmwNuQ==
X-Gm-Gg: AYBFou0Gn2cKuqJmREDTsVfcfC9lqYshDWvErNBs/v1pIZG/jcya4oTRqoAbcmNfkFB
 fZl1o8rBT0FbdEipLSUNLfeX5bSX3kVRHWXsmUeFPhzg0gAiv1VOHvYqkJKIKRt5ToJ8kOfE0ml
 7+J94LqjVCi2spgbusGSCroCEipG4hTB4Vx2FC8Q7emQcuhmFWAvECFgXFgahWlB+Bh1/30QWhY
 b2/FOm+NxfnDR/aaZZ6+uZiduV6Umi5iQnBb2Af7U3z2QzEDhL5e96+M9tdlkeRfEprIFMZYcVs
 X9OKmDwTg0+GHF6Vs3gMiO0sFlUbcoantWy/5G7O0IHtTjEv9YgwYveNdn31ntLuPlPPBh6NAsM
 yPeuqLaFPcYeLlIEVNUmZ55OaRES6ufbgEyzQPbNvF8J5CWDvMbFEWXv+0QXgrg6zpGyAjdk+Et
 n37rrOAKe4j/Gk32vPbHWnxA==
X-Received: by 2002:a05:7300:3aaa:b0:369:21a:dce0 with SMTP id
 5a478bee46e88-36a42345883mr1701118eec.6.1793328079689; 
 Thu, 29 Oct 2026 19:41:19 -0700 (PDT)
X-Received: by 2002:a05:7300:3aaa:b0:369:21a:dce0 with SMTP id
 5a478bee46e88-36a42345883mr1701075eec.6.1793328078585; 
 Thu, 29 Oct 2026 19:41:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm2704624eec.18.2026.10.29.19.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:41:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 6/8] hw/hexagon: describe HMX in the device tree
Date: Thu, 29 Oct 2026 19:41:08 -0700
Message-Id: <20261030024110.1986536-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: gMNd_cEdgF3ZQgRFmX7lyPQ9Z6NK70AW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX9ud8IqI8FHvR
 WR2igjrv/ucKu6Obbfc77JF4eS8j8vZXEBtpJ05n7wBgpFx6BQphW/Z+xEYG7xIWsvI9U/uECyF
 s51qNTljt9BL9SiDBfP0w55+IsAffP0=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae403d0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FJ_Db1yowrU-949eLB4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX7o1TW88B046S
 M+BKC37vO44o0SwxuBglZ+/Q6Rs8GQClDt8PSoJ3E0Gn8t35EJgtgSJXD0Kic/nrCRKc8EthuAs
 eBJebe9R3WzqCCb67S6n6ZFgcaylsAA3B1Y509qZ6VrrwXorh0SHPGASM25o5PNhOqbSRA1r3P4
 dU5JWWf8SwMQHagY81EoXZQzySMwkIw3cK0k4p4qo9y4LWmBoyMFUsHhxcyg5mUHhMo94mt0wop
 OVIh/sHbVuO2S+2FR7rPNfw5gi15oA5DXu+rgl+pD0GCNhJUAjqAwkjMfRThJse6vNZW0WK4xoI
 1fiO0KLNIxN5cqWca/Tqbilxdy4P9+w2PW0LV56BoyG/HRVA8DfQzHRKSsAuA9VXe4inaWhd3FP
 KjJF+jICEnChYg+2SYgskYEyvUGhgfLe5adgkwrZyVFUVNSULsi3sMWSMAzCavMBpowrOq/2C1g
 XsdDvyEwvM0FblFo4EQ==
X-Proofpoint-GUID: gMNd_cEdgF3ZQgRFmX7lyPQ9Z6NK70AW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300010
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

