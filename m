Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486A7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIg-0005Ax-8E; Mon, 29 Jun 2026 09:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHr-0003rC-A6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHp-0006Lk-6Q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuGe2601187
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=; b=eMrC2K+0+lJI+Znr
 vB3SFVzo1/joTsl3knvZtHtaU1aCgQxEhHPXaAb1SLBbuTkV997LtPemsTc8FRsb
 Hrpw1zfyuV0kosGCzPF/WZuRS8wpm9rQdG2cTx6SLt9sv+/0iE4stH6fc8BxD4QJ
 rdqfJnTAy2YXq/F1K91qdUjMnos6P5WMEQ2nPAws5WVn1IOzUMofl9A2c0hkCTFR
 FGOc0RTdZ91JVDtgEoS98V+kSNsE7zNJUPKTJEokrKnIAOmCZEe2eprsUVpKjfWd
 esIHs/BOwFv6k63iwByrGb5OOrmwm625wJmoX+pw7zrR4jb88zRYSeMTkxGVZmfo
 4AlKzg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw93am-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c79e5de32cso26130665ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740661; x=1783345461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=LzTC4bNDN51uf5xkOk8gsTgrCGEd0LtVM+U62+fKiTnCb7ekvL4Bw1vEevdJUPuO8Z
 A+1YdQN2LvNlVUaeJCsYDMe/Um4DXHW4ONZGdCTPQyMTB8GdREp37i5aO08FATab7R3U
 BePT413W4c4+M0W5JRC34/aOJTO3OnpTKsSzrD3/TwhsL2stH3o2oFV+WjZaWnu9CPKt
 5FbpzJkaqYCix8p3R58mCXZHomBu0CHsa7kgd4vliyzKZdOlxGKTEZSPoXylXY86RUih
 GSPRv54qCcO0zy83xPNyYZbgHbMWEbyp57eXfxbDjRYZDc7mSXfWrJyaFF0n1PPjdHLJ
 brDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740661; x=1783345461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=SFxsXPH7OnLBaX7qry8L60blY/N7ovg+Pa/GslYObMCaBVsqMN8UPDvIuNLocuatJ4
 eSFzURIhyo36eWWFa0GYwwytMjGexV2Vvm5Wwb//N44OIES4tWYlzqwfyGZkV7fFksvw
 PEglUmia/zWxQjJPd/7qGxU+hDR5M2Gd0imAoY8D1SZpO3MUntHhvCw17T0dUyOKgH3u
 w0N5jbbOjHFysucjBSOsT3AWIzCBo9l6i1DQKkFcnO4igL51RtEVnu46PV53iAeQ7Gbt
 mW8zgNBBjameaibd3TQIhrmYtolmWEQ3e6AGfOEcuxig1m9AKeN77Ehb/OowrmP25/Tc
 Hk7A==
X-Gm-Message-State: AOJu0Yy6OW0hjd+IiK+5olRHmgVzW/iwz6EU29/3knIE4cwoPdegawl9
 IuCsQ14Q8yOAACDEIY/UbTku05FHudUUitr1RJTJIGW49EV9rFB4uH6SpCMINmf8e1AyblQbqQL
 aumwuKpzJOSyFCcpcMAqZpWN/10m+SG869lgp7vili5sM1PtM3E5pdTjeNlv2+RRaOA==
X-Gm-Gg: AfdE7ck+/yVYOQc38RlYA0fCl8qMlO30Hp/qGloKArutCNca6IJ6006gb82EfM9YPNz
 34k7n5RxrE7s0yTO8PKwRaU4VM19fFYs+pJbaey4QLs3BQCacZ6aEL40wVBm2fWMYfYZyGWlEm0
 rxs12ef04sQEFUkRFbVnedwltEI36MWrH6zid7lbl09cWaOjW4yDdNUqwa6K1SXKedlkpZ8yhBo
 8vQVoDsJvJfcV5PDvi1uFP9p3AiQODMpd34Tihd93RoqlnYLvBz73QwHCAUuJW8eBzP9z+cAWXA
 buH+q6dRlR2XaAF9N6+862M95XHRN1Po+EocopefV1hj1k4VXeHkxMQsvXpwgUQIdXfLF3DC6+h
 WKzeXn73PUctGWiIwTaCg+WKx1lxgZXzhmhvsKAZrB+XOxaRZFslKUm/yWio=
X-Received: by 2002:a17:903:191:b0:2c9:c083:cd50 with SMTP id
 d9443c01a7336-2c9c083d4a6mr58457095ad.17.1782740661100; 
 Mon, 29 Jun 2026 06:44:21 -0700 (PDT)
X-Received: by 2002:a17:903:191:b0:2c9:c083:cd50 with SMTP id
 d9443c01a7336-2c9c083d4a6mr58456825ad.17.1782740660586; 
 Mon, 29 Jun 2026 06:44:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 66/77] target/hexagon: Add TCG overrides for transfer insts
Date: Mon, 29 Jun 2026 06:12:21 -0700
Message-Id: <20260629131232.2487780-67-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX5XEJKyyDUh3+
 qlznpwQ5Q+VEqqIkn/TrTZuTlgzOGv4tR7LYHuVTUplUv4FW5h8gxTx2+YEh7x5GNP6QwF7/LFB
 wPZ/tYqum10E8UZjn5QAWx980eV8+bU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX8R5iMi2Elk/a
 KF8EXttHCXT1xsmdmKiwtkGW+Jlg8BERcoKHMxPlIRcL2gxN8TqnaXKxZtfhgKAB/yHLPobNW3J
 ZZoJV5zYX3KO6gl3xvHigYEYXTP6HzQTTO1V7vUzgOJXQBjKn5/OhLvw3iI4oACl4A2zkAAYfVf
 xHaSg/X3R3Ak806rQNTLs3OdksEW1ZsVYowCS6DHVKw8aI5cNF0dsQVA6JDBzlSDQzEDimftJVr
 u7wIkUh0TSCdY/HToLc0BpPdK1ccNaoa26DSQTUFPYpaIX/tkAsoQYl82e2zZTcTUsvLT9PmqRr
 9IvdBXR8uANnvbGdYjtl4yngYMwwGFKkA9tYnCTWKWa56ibNnzTTpT126s92K3Czl4grArcZNHG
 nGpKQHbIK7mZHV0l6vtCPKkUK9BjpLNIpo++VBy2ynsEahwhVi4JrJjXCGMfPpG8seC2rrl3s+J
 NvoAi/uemIIjIsRbYnA==
X-Proofpoint-GUID: TinJzsQrI7MnpuvB6p3dx5WcjDCXwZNp
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a4276b5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TinJzsQrI7MnpuvB6p3dx5WcjDCXwZNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDY4YjIzODk1NDI4Li5h
ZjUwMzIyMTRjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

