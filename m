Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEBCCDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOF-00041V-1g; Thu, 25 Jun 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclOC-0003iL-OJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO9-0000EW-W9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9kJgF1948759
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=; b=V6YXHORxC3+hjXnN
 9eVeXY5jWxxXj+qpVFcL+Vyd5U971kGOh8B5/Ke0JvwLTYsxEvstWHxJ8fJEtgf7
 lqXq7J5YRbLifYTvXYfdIGoCRgqkunqIOdFTltYyjlOSvULpHmobPjBcV+X4Ldql
 xEfsssQHhkGVKmX7gMfogGfSvHOV00P0Q9l0LrmPiL0BGzFCx0WzIreTTRTytSPy
 vn9zATYJuLhKN6DLkEeFeoKi14OaIJtwpfU2J9Ni6tthQBbHcm50+gxZqB/if3Y2
 h2/IWy4Jlc25IqabFCn/jWoZ3G9PmG8anfSW8UKTvgNYsD7TxPP2iOKR+eYsyHyd
 EABUGw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8su7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so9143969eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398937; x=1783003737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=Qs5K+hn59Io2P/l5vygWMm6kjfUUXIB9VJ+OjtcuhMl+rbJHINGqpAMPPkNqVSdsWR
 ZSMG06AruHQFKMYFb5I5kuh4Vntjo03wF817oSJX1wC/Xzo3BmJI5+pyjvPKeD4GKy0X
 aP9plUIFmDQJWU4RnzJ47Z6hliPnyypo7PuTC2GfsWE1rr1zCBefqHCI9eBGIMOXPtw/
 gklZeSAtJilNxxJdyCXfaq/tMftftfhQHwhRvqa8C2kZLuzeRir5B4vLT1CuUcODGDs7
 f3m036pTgyZ5FOHZPztdy0hVbg8FwDL75Wthz5Tof1lLumsR7daoTOCxsr/SswDezCDs
 TWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398937; x=1783003737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=Ufi8X/GsR9UZrI/abT+YXOE5do646MXZIa05NMos4c+35XOBkE0hEiuG9zq44eV4Rm
 rki1xN9/xlsDci1ZguAi5FjqmLN2bQ4CrIgdRU04+TIIAEIviWs2iE7/zyIC6JJPUUhk
 GyECwSChagkT9u/KQWa1fyplyO9Feo+5rq0WaunZPlKzFoFXAeWgD2VPOPz2J8jnVLbN
 8Ek/eZZxLkFpefTRHcjS1JaiL3g/GKBBdRpJ9nvoqtFPgMuthCYJO/d+Fw+8ngzOvCLR
 1thVG88hKWLgbUyDvAfHOfMq2pbjSdHxBflMdlMuHQtwHEvDDY9Tp7rQnpm3MLexH3/F
 vT5Q==
X-Gm-Message-State: AOJu0Yx1Lh1Y0IjX4QCM49iK1poSEu8DKnwd2Fw0JfC2HYEBY9whVbS7
 e6JRxRKpUuysFKQUP8Kyy636AgkoYJgVYoavhDG9QvdevkvV7XC9d9mgOsPcszuUD8Fq07YKefh
 aCLPvs+lJjke5AWMqXHX1Ti/PyN+n2EmQbeYyW/PaBMuG4FyM8xcYaex/eKCHWkrlhw==
X-Gm-Gg: AfdE7ck9TwGI8CjgDhozeEK+T/Agk+o2lQfyn2S4cpRkaFs+RcbzkKz3rDWYF3aUpPO
 5aanaBAxMZ2AmwtGX7KCeROOpNSld9D4aBriq++aLTMh8GONuIWnmJ6gR8usdnC+lN525plzicz
 GRecAo/fN4bpMpiEbNwiTmnjH6MLRPO8y0Mp+SXomJC0aTW0MBFXMICEwzcd3/+z1I6v4PE9Tez
 +xR6b5o1GpahfC/JJ1GbAv2PP0DlvZyGGe3+IBzJDZa1sG/n/2ovdG2ssO+ATpiWp1zqywtbAyR
 QRDDGSW9J7kkkfgkuAi/FTWRDxouW00VhWEfp7VcvpLsOBJwgUtyroB6aLcxRi6gOG7wGqkCvy7
 oqmg4+i42VvsMeJDKEp+hKSsa32FI5TvAC3/BBy+vji2V7U6//TAbfNd0pXU=
X-Received: by 2002:a05:7301:9c95:b0:30b:9b64:4a3e with SMTP id
 5a478bee46e88-30c84b6c547mr3750681eec.1.1782398937433; 
 Thu, 25 Jun 2026 07:48:57 -0700 (PDT)
X-Received: by 2002:a05:7301:9c95:b0:30b:9b64:4a3e with SMTP id
 5a478bee46e88-30c84b6c547mr3750635eec.1.1782398936925; 
 Thu, 25 Jun 2026 07:48:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 73/76] hw/hexagon: Add support for cfgbase
Date: Thu, 25 Jun 2026 07:16:30 -0700
Message-Id: <20260625141633.449487-74-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX0+Hyr9iVsGca
 bcpgvyjcFMSmzWB1i31Xl0R6Cw70m2CMooArK8Su28BkVhMXhrk4a8OecSKRt38Zh1vb3gpzoP0
 6cVa9aWI+eEjXNkuanoB3DnZwalLWIg=
X-Proofpoint-GUID: iCN8cP_dW69aqeyPZeIGwmQjAcAxM2To
X-Proofpoint-ORIG-GUID: iCN8cP_dW69aqeyPZeIGwmQjAcAxM2To
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXyigOAQSo/vBt
 0Ki/RnbATWH0lLDN1SIjdF7WX1YWrjxXjZK11se49RzGB0zQbs6JYzu/yE34BL7n0+syXdPEeV2
 Ien/pu8QB8kni/Kwwo46WEyeSGsY3rMHcb3kTEwaxxO27/vA6SliBJsHPzDHn3UEdamahHVpI7R
 een7OPNBUBBD/1f7ebvwcPxKAsNwWqEv+gclZugroF8CmdR15nRIXFuy11KrmL0iLbfD1gWUowa
 IOlK86kJRB9CisiRlR87OtvFMBEgJh8EneQDDmeXIk5wZWKGahpRSFyBaLf+nMIBx3EkMQoQcCS
 zmbtEaQ1iJ3KAOFgEamxT5oRra/W7s1CzlkJjuyECxJjKNI/pCyEIFPlqGwScfuGWMO7WyRrrUT
 FLxlEHn57+mqXRqfO86ijFywYGLrx/uc1wkD2cjrsLCjtl+yi+Twqo6mrFBQK0tZM2qDX7+39N4
 QwoHGXK2DsNQWE1S5PQ==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d3fda cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNw
LmMgfCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDEgLQogMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ody9oZXhh
Z29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKaW5kZXggYWMwMWQz
NTk5MjguLmFhNDkzOTkzMjI5IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0xNjIsNiArMTYyLDEwIEBAIHN0YXRp
YyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCBy
ZXYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2RldiksICZl
cnJvcl9mYXRhbCk7CiAgICAgICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoREVWSUNFKGNwdSks
IE5VTEwsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorCisgICAgcm9tX2FkZF9ibG9iX2ZpeGVkX2Fz
KCJjb25maWdfdGFibGUucm9tIiwgJm1fY2ZnLT5jZmd0YWJsZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKG1fY2ZnLT5jZmd0YWJsZSksIG1fY2ZnLT5jZmdiYXNlLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwogfQogCiBzdGF0aWMg
dm9pZCBpbml0X21jKE1hY2hpbmVDbGFzcyAqbWMpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDA2YmU1YzhkNDk4Li40MmQ5M2U1
ZGE0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKQEAgLTQwMCw3ICs0MDAsNiBAQCB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiB9CiAjZW5kaWYKIAotCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKICAgICBDUFVT
dGF0ZSAqY3MgPSBDUFUob2JqKTsKLS0gCjIuMzQuMQoK

