Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F875CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Cn-0007Rr-UF; Fri, 29 May 2026 17:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Ca-0006ny-9S
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:57:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CY-0000Zo-P7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:57:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2IJq198999
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=oSvApiP1L0XB6b0s
 EUjyAuK6GaF9MrqB+0ubCEeHllt/Eg0b3y7qEog+YGL3ZzJTNX6fTbUOQyMmh5c+
 mD3loF0i3Lhsw8cSutwBJF7rcUGS/fvn7Wg0CTBSXaydNhUMcvc04LQO8dNmF+RW
 iI+ecmQIo3g4Wb34MVMlbLTS9fPKWH2assVxvV1S+oAbU6IHPBdUj1SXGO//thY7
 KpCTEtm1iN2EnS5eyAGC24B5wtd5FBmTq3V9qNmzsg+PFT8PlFNQh1uIDTCOxxYm
 8XfKk4XYXuAY1RKdEawTD0bnR0l0EJiul12UsspXpUeSVkYEh7Ypam0AQ0MN/41F
 Rhgw9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnhxqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e7fbfaf5so5107532eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091819; x=1780696619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=ckQWi9Fj7l88k87ixQfcxyPCY6L/E7IVWRpVw8OetcLAvcogli1dwZTziVXe3J84LB
 4cPFxkw0kKf1X5njBasVrmT4Iw+v3uPuZGwOPUip7ItfW8Xnf6orfihWUQkqyBG2BX3J
 IfufUHS2pdZVLDjPYLZaO5LjQcvmmFHCWRxjS0BIxfwP6swqdHRsmNZMyqOi1C1dqS8T
 lRR63DdI23mwqrpb+iA3jyAATp18TXd2Xf+OLAIU3/A1H+51ytFJKiFiatE6pYsLja4F
 vuByiRjZUGfE99JS/vvH+G3V1pZldPYsMq/TAoSqs5knsw1FqPp/DbveBd9KYgNkX1zH
 MWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091819; x=1780696619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=gka00QQOfPXcQ/VAPO9Jag7bxcTVICh1Q0zfcis3YL+UgTtrVwUAHpbHLXoTGB1fEb
 GXeMxiEQNMF9rx8ES86yGnuw+NZK0uBF4p7Ev713A4nWLFmLPmo7Bu93hUxjIhOg9H1S
 mBhqcv71Jqdt2HRjumlp+nm+U1qny6uefMhejNAPua+Ukl1ubX0Q+A1khuWlEEC7ww7+
 reY1+Y2hu4vRN/ITTHDowelH8czn/qEjDEgst6YxBtKc+oQ0V4zSMtQtYAmSjET8vU0Q
 pIO4qEITxqRaBhOu/vdNRTQUckJGCOHmVJX5EfZHTvdfmg4bQh6yKJ/h0Vm2QxKYZX1x
 WXfQ==
X-Gm-Message-State: AOJu0Yze8RVPuQx6X7ysLTpJGgz2utjywNU+93GIne0mafJ2SPK8M4g6
 /zgWSiYrPvySlaS01w7SOP03pBQCbhxtuYTigbRAsn7KoQlOx2DDd2x2xYwITu9KMUa0LsJyKYc
 thvLcc4QXZWUBkHAqGbWUqb6U2jxONHd+j/gfyeNhABOoaR9krnIguv3S70BVuPH7Xg==
X-Gm-Gg: Acq92OGZpVyj1mCE3lt/9uzBHntHoBXx4KnmN1JfX94tGotWYwj6k6o5Gb1nbbvOnu/
 jSzgkBLcCxPo/YR1OOghy/BL+P62vZkur8uicwNNv3DF4aP2HbJIt9WgbSViHavZwZRLV6wQlGb
 LS5Boq4OTMyP6wqXBvSwPA2IVCCE9aqGg2wrrOVuCcSzdF9TSBEA/tMDfF4TgPSl76waswM49+g
 +nxr8Gyk2EwTcD9A8rl9xqdZF7cqWUG+ptvASGXBQ74SIFol1cgNiN04DciovU2Yn11dUN/LMLK
 q6N4ldHyjXrYL8kYkLqP3KysYGipf7jOhToamFLvKsfg2JmRZQCZQAG24OOapIlHDn2/rSIxuv6
 35SZKVMHiE4gq40GuXQjL7AhCI9KAE7Ze7Ajz7LJb5rGInlnELCzFHZLDUK83f/0BZ9b2HeEAkn
 V6SMuJ
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-304fa69c7ffmr849903eec.34.1780091818900; 
 Fri, 29 May 2026 14:56:58 -0700 (PDT)
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-304fa69c7ffmr849896eec.34.1780091818467; 
 Fri, 29 May 2026 14:56:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 37/38] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Fri, 29 May 2026 14:55:53 -0700
Message-Id: <20260529215554.606133-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX79Fug0Qunnmi
 3H0p8iUeO6H8Dbc4C4eYjXaagYRKHQ5KkEQC9PQECpc+urMpPI74Ui33z85XmYQ2sG/4t1lEUJr
 0xqDwwrVOKUPkyVGWgDPpXbjYNdAJ+GTUEI0sCEVIJt0aums9qsHB8rFqgjFcN0C6rEOJsu+ZfR
 3hk5KmPPnP7+QX26KVPcaXWFIkXtceEMZgVt7q1fk7v9ndBuJh8UEJ1+9VGJvOjzWmcESyy9fBb
 EaDdXiCudxvRgUh8mNNDootQhyB8a9beeXumpVzr6trlW55CuiiLIRnDcLctZDK6q0Q4MQJhR5H
 qWGisGdgD5L9oQQL+3tGNaG9TAd9s/2PgBxgHi+0t1na6zk4fRe2YOceZXjJx6GENoq3QBvN7/r
 9O+63il7JN8MwIvESOm4Mxbbp1L3p/JPumOSkrFpeoM0SG3bKvkJuzWYo34w67DFPk8naQ1R+92
 ZIhVwKo+/UIuQZNFKLA==
X-Proofpoint-GUID: Jox7B32EZDNZRvXDq4PWEr7xQKifSMcC
X-Proofpoint-ORIG-GUID: Jox7B32EZDNZRvXDq4PWEr7xQKifSMcC
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a1a0bab cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

