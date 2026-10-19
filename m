Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802A60724A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BopgX6P2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=etQR9Ecn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpjj-0008B2-Iq; Mon, 19 Oct 2026 11:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpjh-0008AX-1E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:57:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpjf-0006um-Cu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:57:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOsx72268928
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tvt9/5eiB+fBPdHHkr8O2d+punn4Mv4L3Gs5+cjK3KI=; b=BopgX6P2wN6Tw3hN
 TVqpbACPutKB5MW2+ekpb47U5LCHSz9H+0ndoFt0IJJNCuM0lkiJk6z0dacK4Gd6
 dmIHcrFETHnEAxdOCUc3oI0D9G8hTBvv6ZYl1ZsvAy8ux7SQJQrvKhI5Rh8lIk66
 TDxe1nj4o+vHYqSvv5taxI6u5pGc0aUs1IvlJX3vunIkuTdEyvFPfdplh5p4duZA
 tJjPsclw9SZHVo0cpYSzUCejLleSIN7UvuT44aUifTuU6Qskv5OExYV7cSPD2DcE
 w8LJ2YcF3bzpqDd4bEsqAM5V/srww5PxtA9e+JUPPeJp0Jeee9wSIJzkh3C4sIiG
 9XXQBA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rj0pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:57:13 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso3385822c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792425433; x=1793030233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tvt9/5eiB+fBPdHHkr8O2d+punn4Mv4L3Gs5+cjK3KI=;
 b=etQR9EcnzG/ZjSjAsB3kDGK5g2seWUuDCyQTiPenMvFCtYBFoIuPl56FGiwhfVs07G
 8pk1fGy83C6Lka1PpkG4/wAPQICtcGloPP7f/krg8Qlya3r1+9aN+7KrmE2V7Ny09ch7
 dz31uP5IO+I0OoucGEVim/4vFlH6id8ieuU4l/QqMdTG3QDFs+TeXS78wLgT8uvHbSoc
 ooHCy+cjqZ8Gtih9YSnOdfl6Mw0Rb193zCw32RUgDGEfIvfChKYCNuel5KGa2DUVKISg
 YD0gvvNwLsYwJAxX0s8wIN97qFDOMp+bwLI2M+RKwN9QzTTe3fFmXMOA3u4rQVWp4NJ/
 e7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792425433; x=1793030233;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tvt9/5eiB+fBPdHHkr8O2d+punn4Mv4L3Gs5+cjK3KI=;
 b=XBYj0eQxIQyRQaUoBOiafj6oRmBKWtaFIGO0OAwghDze5DT8RDsPHdbR82SW08KwKp
 7mGkTsqKv7VnU1ioJpn1XWzb2QK3T5ah7Ehd+dmm9Z0IcaeUbKaAZQph3jUQ4KlvLFei
 MbD1GwfehastIsHB36OUZcLeZ0dvivxJsyLu6Ite9wz9mqyjafz6gbrt3zVO0vJjna1J
 /RBaj8h/RF78zSuK2d/0UA4HlIf+iZ6knR+GgCEeroNWXQ7iQaNtfKp4y+setkybyRid
 6VT5aZFXIiZUvI25Clq7IEHBRr7Kcg5RiV4K2d8q1/KgPj/aYX7zr5OgGYzAPps54ej1
 VfXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydCunSLwz+658oOpk3Caj1LuyZ+X3CRO5nKdgZ3KWSTGueKrkDupSylobnTgnng4MTKtAvxO4CEBuY@nongnu.org
X-Gm-Message-State: AFq9FYL4O5RTGmlMq3g9H2eSYuvc/radWoZrgIYTrnAfZcKMrGK/h+ba
 ep4pbx4hej755L2bXxwoGrnVlvb8IhkyhNuXayFDNdJOajem9vKSBMD3cYnKOL8ZQDxNhm48yWq
 /+/eh587aXx+JcsTU848a6t2VvgcAw3Di8dQc4ZMbVVTT1gV7ASgxObJmmg==
X-Gm-Gg: AYBFou1fKsyJ9xxftPxGQoKKJGFSjeOXG0zBxskyYghH++VokoaJqefWW2WTLqtFLD7
 BXNEPVNSTpAXdKfai7B5YEG+oZYls5hLG+2aZonpFWOjl6McNnE5lo/AYc1KpEPTRBA+vxAOGZm
 CekS+PdhodUihi8U2fbZanPiImE/3fKq9a3DXSHf2C8y4HM9wbtWsCQhwfuoaZELac9n+YuQD1z
 LH90ocrtngvuPUBiS4ejNnc3g/5g7dq00fWLIAViM+fwuiUzd4L6jUPGOmsuKJWPhc2autlrncD
 /fBm7DA6eD3VzPAtVs8Sf/IyHSbczGX9gb7MuDliQnnMoNrERuFsDkL6jxlB6CP9Jzy/0WwqJGn
 qR9QCBnuy9phEHf1qnA4srchdo8nMRyEo1hPlL+mYuz4TYvE99YL/vs7GmNdlnlqYvSgXeQ==
X-Received: by 2002:a05:701b:4354:b0:16c:4eef:a526 with SMTP id
 a92af1059eb24-1851238bde2mr12752503c88.15.1792425432435; 
 Mon, 19 Oct 2026 08:57:12 -0700 (PDT)
X-Received: by 2002:a05:701b:4354:b0:16c:4eef:a526 with SMTP id
 a92af1059eb24-1851238bde2mr12752464c88.15.1792425431770; 
 Mon, 19 Oct 2026 08:57:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831996071csm30366204c88.9.2026.10.19.08.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 08:57:11 -0700 (PDT)
Message-ID: <5cbb7146-4403-40f5-9f41-13fce3dfaa8f@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:57:10 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/tests: add an alias for all TCG tests of a target
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261017073952.1346449-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017073952.1346449-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Aolpc8rWtHBQOvt9AUC3wn5j_MHBVMgO
X-Proofpoint-GUID: Aolpc8rWtHBQOvt9AUC3wn5j_MHBVMgO
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad63dd9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=8qsUK3cBa2MkJvFa:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=--kmgXq9RwlOQe7paawA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX5mzhZ6Uc8rO0
 aYLRFI9uyxTeajRZvWV8EBHDInCHFxXI2VbMzYVjzCVIKWS2QWdjzT0xlAntLtAYtLBo/yrGGTT
 aMO1hTsaiaDPLyMVUfu6mdBrac3vzdUJ2gDpN+3/PnFzTFjjpbdbVPvHQP8NKAejnBRlEjMuRoe
 Bo9Bj6gnDa/OIrF56slcaoMKxcwuNTWC/v8KCUUEsaVFaFh2gU511ZkkjGSOBi5GBCCPoHKn/rr
 IpdAGTBJlex+FhF6Q5fpi1CtQ2sco1u6gXz850+Gn5mIoL1uKinzQg1y96qZfqkcx9sKhFfWMKT
 pir9URFP9gj86GnhJZG4SgpHng6ytmFAX9n87P6cjff5xpYc084qKGGcx8Eye1o0ruCrFM5z6T6
 +Ujsc98Dt799eAgkOGdhiAzf+252YYmHpkpoC7awDj2KbOn118kcRTWUdIauQwmo5FXBcK+oqjp
 osXDs2Q+fg9iB42CK1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX9m04eYp/8p7X
 AQfA2rpPwSYor+qskdkkTXWpW7E1XZk8he4St9+AeJPakjzVjXSc9DpwZKoCtdbr7+IiFppKi2F
 /QVWsoXtKUiUl+6NjpVnmq/9+jm6igY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/17/2026 12:39 AM, Paolo Bonzini wrote:
> Allow building (without running) all the TCG tests that are available
> for a target, so that they can be run manually.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/testing/main.rst | 6 ++++--
>  tests/tcg/meson.build       | 8 +++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 

This was merged into master (1c8440e9162d7f98d8e41ff4de0ccacb08fb65b8).
Thank you for your contribution!

Regards,
Pierrick

