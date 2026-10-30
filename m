Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3630606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SuVqVgv6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdRoOABQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMuu5-0004Nc-BO; Fri, 30 Oct 2026 18:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMuu1-0004NA-4Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMutz-0004eo-92
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:16:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtPq43463643
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5sDVrHbz6X/LNB+sK7rQG/vsDEmO010KxAA9MnKEhGc=; b=SuVqVgv6/KcS8mnk
 yLbl4pp7iqmwSp+bMXWyfGWuwiDnoxW4FrqCxdimkQlIhBuX+HfPqeAEh5XJmKVU
 yVSdLkuY+kBKBMtUHjDCE+CyyS6VUPNvFIRI2PyeSWi1njSrEpP28HKWNrDkdYIQ
 +jhd6DdNOdixL2zw8k9BXofx5NCA2lrQpA8tewhTJpKCucPoR5gU4FVyTM7X7ReT
 H7WByzU2aIJQ7ads/dm2pgAaJaEUhIuzeTpDFwy5fIUpOYvg4oQ9X+kRiqQkgaNd
 3S1BRjIW9dEH2IjCnzv8oMUewwhQG376zV53FkG0oBpS5/iUjiS5A3eKpS9gk4pd
 XgDzjg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0861v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:16:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a3451ea93so1855149eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398599; x=1794003399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5sDVrHbz6X/LNB+sK7rQG/vsDEmO010KxAA9MnKEhGc=;
 b=gdRoOABQL0TB4NXmbO5TwOnWX1IxMwzm1uhEP3VR7Et95q7Nb+0vxr/dKpxzcFgBK4
 p6nhAUOVHgfZoSsNY5nV1Re/dgFrUpIzZSA6WamKZZA4P9gwxtRK0B9FEKWSNufhIVP+
 JKe5IQCcGS84iqhu5Z/sX/YNCMeNZyYMd8a9BwtTSlXbSQn8+OEkW1ajAVTFbEn0AvK+
 1VzZvS+dSxGWs3r48DcA+FR7Tc8JqFmQU9bh6j6DJxsdCx05+p+wILAc21nACIQ0U01L
 ZLcAEdDw2ggGGU9jgeipmzPc3A74ae/JXNpCohXJqUYoa58Danbdr+kWWU/DPih2eb7t
 9GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398599; x=1794003399;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5sDVrHbz6X/LNB+sK7rQG/vsDEmO010KxAA9MnKEhGc=;
 b=sDA699voLt0VkaVyBfv48GOzsUdMjef0jrPlwNslMl/8dEbySXO3HVWp8lRLU+r721
 6l4UdyrOoZiRD0bXcCJLIWdYvk9WJZeEun7UJxDykgxkUkEUDL4+83u21RlsbEnvnzWk
 hRPJco+HP3BmsH9Xq0LZRkTFYkP/8nNKWUXVHDCXMzarr9dArOAi1ZWLGRDTusiDSv0p
 yAjvb2eVaXSOue5aD4HP7lCjvU2eAGEgd+zEvX5Fvin7WiAfG9zagHB9f9A1l3tzE08j
 qcWseQQENbADp0qJkCc6yavWLp0PdTtlxfeUmsd1lPqlkztsWu8S4tPwrvEVyNJHxEAl
 KKrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjVfiTfrmzsJj/n2/CWJTKwYSdtQhNkBPsK4O3h3C/Yc/ybz7/qiZhW6Eus0T52RJKoMRPzrXq6QRt@nongnu.org
X-Gm-Message-State: AFq9FYKlsjBZryiAY3tTgLztqBD+BUIcbA1SShS0UUOKwydjtqk8Lxor
 Cd5BjUKnI6nhb83sl5bavBOTU7Yj1z/KEE6jDYNgYnylQj2/6fGysvXIjK+TAP40FT1S8ef6E7G
 Scw06VSt5TNrTTd0I0jYmP31l42zkKNFBawCBY4MdmgXeY6yJiMWPykwdSw==
X-Gm-Gg: AYBFou0QuH2wxRi9euS5Jpjy/NzpP0tcFGiDi2iv4Vak0rLf8vmEPGoqQKzWNapRAPv
 DqupbOLbmvp3aDVOvDRs61aGpHhQJTkAjYnyRfxRGshIutG3ydnMhiPV8t9cwnqtBlSTcHSHHyU
 SM1HgKClaX4Fft+YaQEDQVLf886ERHtHwMtW6ibuxvkw2Nv8gl1g5fxoRwFS/8AMY0vVCIy7WLL
 IJyFEkhdEsGek+U4KgJLilYJ6E90WMRYmUJvCrXDF1qCWT/2/gXngtiBgoKaiKQbUwaF8/j72TQ
 Old3VdOFeJyDPH4BeeBztkunsVARYLDkl7ejx+4S74B8pz+Fzsceaj25B2gvFdMsGxmvcj+new0
 LOOz83br2os/NZ9IRKaQfrfaXl8/IuO+oTtpPtpXq9c7jGUOADJSYI8l5x0I/erAHCYhW2gwrNA
 aCi7hYOG8EO1rbzeXHkqmmxYJCAr05TneBDV4xljl1d6w=
X-Received: by 2002:a05:7300:d082:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-36a423af91bmr4996589eec.16.1793398599378; 
 Fri, 30 Oct 2026 15:16:39 -0700 (PDT)
X-Received: by 2002:a05:7300:d082:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-36a423af91bmr4996556eec.16.1793398598641; 
 Fri, 30 Oct 2026 15:16:38 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42662f23sm12073289eec.2.2026.10.30.15.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 15:16:38 -0700 (PDT)
Message-ID: <94a9a21a-20bb-4f04-b944-80bd8ac9fa54@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:16:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] target/hexagon: implement mxclracc
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
 <20261030220840.4142885-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030220840.4142885-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qwWB4K46JLc5mF3jINw98PKoB3wI67kH
X-Proofpoint-GUID: qwWB4K46JLc5mF3jINw98PKoB3wI67kH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX+u1NSKrtdKBx
 ySmakCDrDxetRaEWn6aQnySZqBM+WULdMUedE36wlNtt+oBSfwOKRywVsqCzffjJ57TJyd5Pwif
 WZmk34GT+fSpMESujVp7194iZP6OSKQ=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae51748 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-wHZNx0Tp_DzaEcSXckA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX2Htn0xX3xknX
 aaMBieuxyif69n798OoveldutN5Y4EJLgRvhkM9OhUOuwkt2Spy8X9a7+xtfW6+oyZRAutjXimC
 35Iugdof+TPAMO5FGyYzj9HXLQOBV7neiiXmmXM0V9qeQH0AAPix0MlUXcO6dcU39zzcEfU5ALh
 lsZaZ5yClSGS2UDifwyjSISB/n7gbx3P+64SH1ZTqibG4zzv79Ns1KAuotSRxRVlEONQy2yK9pE
 xEzaK+nHKxrjwbm7eEN6xh63S0UXE21w2xQPQ7RMo1+D6vLVv9oTrSQzKvdAanGDhoDhzxPu+kn
 YOdzeD4IXQ/WwMJIRlu91jVSCl39MFxV6EL3VijQ42NqKbv469Tzy1AdbsIbzBA3IPIKCFXBkNf
 DBmV1eIOnqF7opoqSAA/CjRc9Zm2wDXHOJz3I5rLCxnnl1fsmFw1a98PJX+j5hsVrGMxOPvzYjd
 YEhukl0MM7gX9lZuZPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/2026 2:08 PM, Brian Cain wrote:
> Implement an HMX accumulator clear instruction - mxclracc.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hmx.h            | 13 +++++++++++++
>  target/hexagon/helper.h                 |  2 ++
>  target/hexagon/genptr.c                 |  1 +
>  target/hexagon/op_helper.c              | 12 ++++++++++++
>  target/hexagon/translate.c              | 17 ++++++++++++++++-
>  target/hexagon/gen_idef_parser_funcs.py |  6 ++++++
>  target/hexagon/hex_common.py            |  2 ++
>  target/hexagon/meson.build              | 17 +++++++++--------
>  8 files changed, 61 insertions(+), 9 deletions(-)
>  create mode 100644 target/hexagon/gen_tcg_hmx.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

