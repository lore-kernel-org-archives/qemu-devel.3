Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BB7CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqE1-00009q-4P; Mon, 05 Oct 2026 17:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqDq-00008o-1v
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:27:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqDo-0001OB-It
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:27:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KMjRk2989218
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IcjB/AA6PR/zV/E8ebsHuIZL7N3CQ0ixFh0zCx6ijz4=; b=L86dIvXj9qDCnaXC
 05WESNYk1IcrPE/cfBA6bX/vw89RWeAQDZwpTg81Or8flnyyhd4h4m9D3HYnO9Oa
 rgd72zCNqnVJCfvxRMisZ+iiFa5s4arnhkjtUM+hDOrwcP+2+Csyrj3enA0preBf
 iRXh2RI6KsfPrt7X2lKeMyY6DqHUr2WtCDOCZ4tSLmqOdmJ7bvK6pBmGwZsDRoh1
 k8Hhs4RxJ+uVbmvsGZlqJMDwQB8WUw5lavxNCfsVmnp4ylblKc2CqXkDopgXvWyO
 xAkJ5WBJPEAi6PyK5yNriqK6qy6lyhp9Pl8OHR8U7+cnH6HXsaZMMZ6paSarkSR5
 Y7M6eA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3gpqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:27:42 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-150efa76c57so2426939c88.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235660; x=1791840460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IcjB/AA6PR/zV/E8ebsHuIZL7N3CQ0ixFh0zCx6ijz4=;
 b=cGsxM/h8OFYSbCTxWqeXRxhEacGmRgQWotrwG/MDhnkOZOV9BI0EEqZ36IRUmSgvN6
 Mf6ntnB+ea17pCHCaV3o8fk/sh+dzpQB5zzKuj5LEbdnxbLdXjllh1pTj4L3whPnaXqP
 15fLLMlaTR1cPdEPO/LfwWguQ9O7ipKYYb5z73dxvaX49ftzJuXawmtFIOznqVOPza6Z
 6BuD34jZl+V4Wv1Du1hfdl4on4Uk2fQtBykeAif0+ZRSn94sgLGRzcaBzO8Nu3A0tZLO
 yc5HH+GUCYY4AYg44+aNkoe6EVDn/TUvKHIAMnlaoikGQiwhZfWoaT8R5e/wErqOdzTs
 yUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235660; x=1791840460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IcjB/AA6PR/zV/E8ebsHuIZL7N3CQ0ixFh0zCx6ijz4=;
 b=RveG8NVQypavhTlRol3hyV5+MFUZPGmWqh2BC7PYuzhdeU5ql6iKJke8gs1/wazk9K
 tZLm72LOuorvIhzSSxH6ADrQh71xwf+3qgeL9TpSNRFs3CakP1eqKTCU0TvjVBNqddZ3
 W2qUaMcg2D4mQcpE+YGlcq1gCBRB4KtafmI1KX51mb3Dtf3wluTJFItzhpXRKpWsvcis
 kpQNIdgoaXQ7+pSteAqcAbKgCbBH66r1AAhrgqrE6HoQpRRSsTw3tbx5Ts2UuVPrduym
 5mrK8RT+ApGyPBFSJj2WJBgpkjdvQd1dAytqcHtepOo6oUUMbtOuRCbqbc88CvvIdIxi
 UOag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsRb7msGTQK/O2YZpZGrUT6NIXXRWvDP7r0Zy7ZxSmSiR4VH6AizSdatlauKcchHPO63LVAnljLAfo@nongnu.org
X-Gm-Message-State: AFuF++l2yI/aFCAaW7aH3EYOo8x4zHqNBbKiYvQmLerLlnQr6+oCeggY
 6gx8Q1gB3hcYNpqefPqVQCHoa2goDyztnslODpswtELcklLndY0NPTJd242UJ3SGVUtV5Q2TOCz
 euPAx/HT62Ya5GJu9YLYdqVKGMqeWZ46DnZTrz/omzu1hHZUPszCs17Jg4w==
X-Gm-Gg: AYBFou39/KlQ9bkVsz6u9LCvZGmXosX2aCAFQXndS4d8iqlPJcMGmlQnJWp9NxcK6su
 ga9PyJfg8mHBm0SktAwXcbo+WxgtN6akbcAPOoZ70l1kxtFV/2RjKE7Nrh8bnU5/W6gNe+bH+8X
 +Fp98s/OiI4tdBxjTaLYOq/K+iNehG5LH19WVwHniwMU/qs6ZIBkcMofq37FrGfk/0ppYr8iRDM
 cw5KmOP7vs+GyEWQvj1opsQZeT7+COY7xTT6pwQoneSt7hAS4HgzGs5baPUlqLufg5eAa3O3OOp
 aBxmljL2XQiG2j/230rCWz1YNdTM+6WOHLHfiSwg5aYXRwbXTnRv6OkN1TixOqiVJszFegy8IYN
 rzWfqFcv5NzIClu7fuSO7EawCTEiODDh7NaXPU6YCbu/bz/BsG0LiIZ6veHD5z9EfsxWF2Q==
X-Received: by 2002:a05:701b:2305:b0:143:2973:3240 with SMTP id
 a92af1059eb24-151c36c0563mr12085420c88.29.1791235660014; 
 Mon, 05 Oct 2026 14:27:40 -0700 (PDT)
X-Received: by 2002:a05:701b:2305:b0:143:2973:3240 with SMTP id
 a92af1059eb24-151c36c0563mr12085386c88.29.1791235659423; 
 Mon, 05 Oct 2026 14:27:39 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d852a56bfsm917626c88.15.2026.10.05.14.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:27:38 -0700 (PDT)
Message-ID: <cec39c89-ee27-4408-806f-85e6c73915a6@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:27:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] target/hexagon: add v81 HVX compare, align, and
 convert instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, marco.liebel@oss.qualcomm.com
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
 <20261005032616.1293829-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005032616.1293829-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Beapnf3Ydf_M-dHtPkoUdzvICb8vb1oa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX11jZm//csblh
 iMcIEhGkakqu8K4e6fvgbz/hCi6CNIk7EnY6huLahyoiT9c207K2z7c3qAaMBONnJKhltPbEfBP
 ROQdEepERvhzdadJl+AWpHIsozQVW7I=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4164e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=l1EwPZTvEZe5bsRDspcA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfXxWbWNdDIOTsN
 E1imi2O85DwFTXlvEtN5EmTHSh0I5cHOk87ryIxNgHi9xGttHtzl5ehUVkQ1WwGtRK0KhPCY6U4
 bykJqA8CKhfIfw2kdDR5CPADWxv1OPVCjX5/au2ZlK07VRHcPTAxLSLH8K98wlAPZG9SiQ1yW2r
 eQInDIkam9XdSn1+3G0DB9WiF8mWdSyneRS8/ULNZdoPc2Y7SdP9ydR8YxdBBiwnJNHp0QkaYvt
 jHmj0az1p48BiKM1Ig+LlepuTkCy7no6mGPCU8bagwbfM6l2a/0jfRw3ddn2K/nbdqpRYbIytw7
 DZb7yama/FTmFYLmdVZP/ZpNi/U3jfGs6MH3D18UOP3WFKy7gQGRAZnjMfdbNCmFfSa4jPqNCIs
 V+98HFcYGUoWE8WT7VNjXgVhFQO0VkqF+4AAGXnSpqqHhOy0l6kR2oqq4v+aoU1MsuazG7ppy5v
 3SXOr4N42KEsaUWeg3Q==
X-Proofpoint-GUID: Beapnf3Ydf_M-dHtPkoUdzvICb8vb1oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050084
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/4/2026 8:26 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  2 +
>  target/hexagon/mmvec/macros.h                |  2 +
>  target/hexagon/mmvec/hvx_ieee_fp.c           | 15 ++++
>  target/hexagon/tag_rev_info.c.inc            | 13 ++++
>  target/hexagon/imported/mmvec/encode_ext.def | 10 +++
>  target/hexagon/imported/mmvec/ext.idef       | 74 ++++++++++++++++++++
>  6 files changed, 116 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

