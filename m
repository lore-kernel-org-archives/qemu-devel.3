Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fbxYGzEO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E51txvR/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAiu-0008PA-RZ; Wed, 28 Oct 2026 16:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAir-0008I0-Ew
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:58:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAip-0006OZ-Nb
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:58:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIkJsh2546880
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XlL48vNyI+DE5hU70EJ6TsnawjalskKZlPGkI4s3ZFM=; b=fbxYGzEOxWTv9bj6
 5iWMORk/OIuG7+CJislTEAqvaN3+3o6moCU+20GHxnDcU9ILGjv65y1pKlZMfNGr
 weNy7i1OY6cpEJdUJ6sDK/iXpYURyUlScNAmjfFS71SbwAgVYhbhhxLEEk16fAVG
 s9l4PHJA1UAEC16V2r+3dYK+F3M0pTHcDzgtTMMyNcvEKaBqdbSBO0VZoReMPaAy
 8ccD5yroqFs6fNIFqhtyijDKkuYNy6Yyv7UkJsu+eIVTEyrfM0wdMNjS8E8PDY/Y
 7Vo3VLUqFJ91bqn5xHTUEHlRcOfOIRaGoNK3ofedMTHJ6xY72qI1O373xtPyGuyu
 bRMZLA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc0fds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:58:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so1914561eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793221090; x=1793825890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XlL48vNyI+DE5hU70EJ6TsnawjalskKZlPGkI4s3ZFM=;
 b=E51txvR/M4iq1y4L7GZstRXYy+VvwvgKf6NnOR3R24IuCZ0BPluk1jd5mZ3xZy/7/G
 FMHWfXk73csUCvb2uLA/QKBGHTbKqx5FEIkxpr9ljtbdkQzS8rcoRQOWa3Rbvxrc8y/E
 uzo8f1ymFtzDj27LCmPByME9+Meq79DfGnxkF2rBMBOJ6dEjpYdyrbmnDHMR9attJcn4
 NxERMjZLtclAyAVcelI95h5+GGvWw8epRzr/g8ayyNd2ExcYyd5CBzEQ2AmYwEx4HgeH
 pnukOA5w7s20kP/YV/Ds/Qh4jCgJgQLYnW5Y3KqzpXD7VmSKlRAkiDpQz55RLzJ3fJI0
 t0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793221090; x=1793825890;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XlL48vNyI+DE5hU70EJ6TsnawjalskKZlPGkI4s3ZFM=;
 b=u6ejy2EAQOg2H6SiC28brrTWye2dSZZuN+qGhEhtTPG+HE4hVrQ+Qn8OQil8Fo+gtx
 02shhRHD/b3PreviBpbp3DwAu0LnNWsQ2xYMziGFx2lL4+2B6fdgAMzI6+Un9MX+C0Y7
 eebI0XwqbXfGCpqGg5hyrVBD+J3dVVD+EStQgmuabCW65qmWRSPDIFR2JaPUaWe/m0Oc
 R2Av55EmTvY6IbaEXd6dfCWHZtw+a7GI6CBOW0Y2j8OMgMzLWDvhOP05mwX6BFkvVlqq
 jKwtzAUT+yXOjK2eWaPEGj6zpqBj9qW0fXUQ+HH+mtiRreqTjWHnk446yWrJ3PVqCODW
 CzeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ/LnQJ3svW/lFUbiEm4XzEVTNiD0gOc5VxvvO9HeX9t6tGIwzz6T+tte+y3O/ceSNLwX60Q6uOC8A@nongnu.org
X-Gm-Message-State: AFq9FYLwmb89vph7hODUNkCVodS0CcmnvVJLi+dtb4K1taNzPxCRhElh
 prCPwLsrBLVq/lR/swr5D2fbKL5BgLD+SA6d2+G6wHUf35+h4CWRXKVftF0Gb9HnRJBb/9QTDyM
 0OQGjQmOmfCUMfKJgXxF/AqxPj1+cYOgYXrd3FNpOhkUm2G9A69Jftt+4Pg==
X-Gm-Gg: AYBFou2UhWpUTy1mVyFZTjKRcugN4HA9QU8S9RGmRmKAQzE38niKvZsHRcqstNGCtPt
 gmQ4vd9jubv1k80qKCjfNlkxFXwmBd5QFzumsq8SS/T3ujxKM1uLFR/x1NXkublIoN1x0UsYU2p
 UoQKu7HAy0wZ826FFIm6f5hekkvYz3Vtf1WVct9xLMdnmAZvu+zaHDM5tMB80h9LS1NP7GsfY2L
 aRBxkbC0cI98M8fZzMeuql1DIgT3SKsRNtakjFTb7zlmshZr7FFEgPdWC7xMrfaGkAeess+orS5
 5PlWsMYnTZItXgugYo2dN1Q59oqpR1y8Eu0WFJjcZBiLKfGfkzLj5TfbeyDGOMr6Ds4/XGD5TIa
 gJU7vNF9B4x99Po2f9wF+7U2NDEqd7SKdtiD8zWZmMc0p88QQn257WuTYdCfFNHkLjdSwRuxesF
 xJ/sxzoxVObPQ433No02vxaW+A5yIAHRzNI53Vu03IDuw=
X-Received: by 2002:a05:693c:88c7:10b0:369:d486:457f with SMTP id
 5a478bee46e88-36a1ff47261mr5149332eec.2.1793221089424; 
 Wed, 28 Oct 2026 13:58:09 -0700 (PDT)
X-Received: by 2002:a05:693c:88c7:10b0:369:d486:457f with SMTP id
 5a478bee46e88-36a1ff47261mr5149292eec.2.1793221088698; 
 Wed, 28 Oct 2026 13:58:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238dc80dsm10537923eec.9.2026.10.28.13.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:58:08 -0700 (PDT)
Message-ID: <eff95e42-b1e6-47af-9a53-a8b0cc073ba7@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:58:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/microblaze: defer PetaLogix endianness default
 until init
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-13-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-13-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae261e2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XtNXrodKxUSRXBvcK-oA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: kG4GrGUsaRfhiOqNUesXDjc651H9J6ak
X-Proofpoint-ORIG-GUID: kG4GrGUsaRfhiOqNUesXDjc651H9J6ak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX2cOphzt3L63g
 7k3WzMLxOF6SH01AGZjzw22EWWfVxr8Ch+4mao9xIxcAzIBfpsIuiNW31RbVje96HNvWxmxPdnO
 Dw3/kAB1fYWGCYvgQtjyqbdJW8XFh8l5jJq5hu5EWYKMgnaG44GVSgJjFemeGMIeNwKsXysRbr3
 82d0uHeSxDXtkHwus0V/QU3k48bCbESvoBOwK/vpQBSTKzn9n0II2QnvOscbd3139/Sc355y001
 4Z53ZHtQcohmgfVOCEdQrqGA0QrTBFDQn4lX4IXzeDmKlnBr6yZa0EhgfN+ojYYAioB3mgTZ67T
 sr6Jhfi1dEAHBv7yN+4PS1yhaZ3OAevEmZEqUn/GuqGpcFWxRrA9vTYz5lomu93VJtNUDRwVjZ0
 ikDiKxqK7kBLa4wTO2/z1JbPaBk8519sHA3fdSAzJnR/Wn4fj3wrTvJ5uLaaGWazPAgPJdTvabF
 isGYPV4k2tt2tS7lvSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX5F0xxbnbZNuO
 mZy5svLZP177wTvihfHtnnV9Q8L6BrLVFifWMne8Etswt5c8n+iSfv9jqgVgvc0mBEOxCi2r0RK
 3jizcfvNliQDYwtG9DfYFplhOwF/Dg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> The PetaLogix machine read its endianness default from
> target_big_endian() in class_init. In a multi-target binary the target
> is not selected yet at class_init, so the default cannot be computed
> there. Set the property default to "unspecified" instead, and resolve
> it to big or little in petalogix_s3adsp1800_init(), where the target is
> known.
> 
> Until the machine is initialized, endianness reads back as
> "unspecified" rather than big or little.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


