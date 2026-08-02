Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D82C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX1m-00034Z-5k; Sun, 02 Aug 2026 10:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX1g-00033Z-If
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:18:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX1e-0006XY-P8
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:18:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6sK61791427
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rzh9lbeS1AObNZSX6XLgZe3QshZHwXhjCxdzsjeEgUM=; b=Y1Imi9uH+x2IBYI/
 rvelQPZIT8yBsLFCXEcTYGlg/kqCWyvOWUrcmHXJRerxf+qsydSt0KxCEohvY9jg
 uctvyyKtNAar0wcqqES5WNf8pu6dDGM2o7N2gs3CRjNi+HJ6aiNNt4e31OF32Yzj
 Nx4EHSYSnxsi+JqgrXUA8a2hIQpF19M8zuiWZeaxfvXgk+rEz+uBpV73R+WlOHVG
 3YLck4hUqtqim1x2JOzg4CMk4qRoOjaSMkhsWI4MTukSvTeBFDItO3QIxn6KLc6M
 ZYqTzJnS0D0620wMWLzGcxXPxFE620HaizK1DjfFY7lPvYaHPNAvPudMepyGAHb3
 gE+pgQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx30v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:18:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d137a68so47613481cf.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680328; x=1786285128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzh9lbeS1AObNZSX6XLgZe3QshZHwXhjCxdzsjeEgUM=;
 b=MQOipdIhHgq5xQDI/T+jXIigKEzbLGSCMKqndB6kd6rPcg3L7VP+/NyvnYRfMp9rky
 LGLtQ7Na+kBXPiVxZJ5ILIIjoSJhRzRngC1m5RPK5UypWKZhxJQFLpz0bUKXYEwyVKUC
 SLHHQK1l6/AGszoa+L5FIoNUFWJ0ZXtvuHzxPa9Dz9PosSgayWTeVB78MUAl4RDaR4Lu
 v4vYLLyE780BSXrMCqojwxYcpMnduKt5EYNQTjH+ZruLSBi4eRoOTaXckg+lCaYLCv72
 /c1JsZBfDLOwqf3VJR9Tx7Cm7wzNqXKFjq5245WJPPv9AdAp/PMAJ4kUbj5JZAkoFUII
 UFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680328; x=1786285128;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzh9lbeS1AObNZSX6XLgZe3QshZHwXhjCxdzsjeEgUM=;
 b=Ii7n+I781nrGwaiWIM7yzyEBk1E8wnxqH6iWn3PCHqj+aeqzSLnUsh9Jg0R16lwuZJ
 pOUGO0bPvVbV1bwDAcvO3G3qMd+irkq+fvli3FPhUNy1dRnW6DyvEhrK2JJbbnsLvlOT
 nkrJ4G6mqB4ohJg0GQB0qGZQuOVTfVyfcfEjupV/8VdKh76HXOLdtNXcAwoJmXcQI4lf
 KQtuSaItBMKlTq2EJIFrMxLpMeldXsDxpN+wRJ9SqWt92k0UR3GGRtIRoMx2wzCBiWL4
 8iO8caxuDwa0QDOPP0CKCCFGyrBHTgBOaRZSzdpuTS2iD/jlZw399MmlQ2goUfbYwkqC
 l21w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyBpZq4rYgx/9bjBG6hKHPqzjXXj1x5aNPmSt0inLBQJ87rSJAHYSbEs3E1aVIUVyubWGJ8H9FQwt8@nongnu.org
X-Gm-Message-State: AOJu0Yya7qOGlBJ1xJ/MoeNdhc62Xmxk7/xZ7aPa4A+KC36Q6q3p0jAg
 h11PB5rYY66kISMfKJwJ0Xazi8YhaQhd6VfMtvjGDA3VV80RyUTr/thdi5M58GuLHNwwE9dK3Kl
 ///0psJ08wFzOKW5OmkTenHGAgQoSFJ9GiEIbR053IboaEesRFSscezgHww==
X-Gm-Gg: AR+sD11I5KeknuoAbnakI0p8+oAgkr5036vpO068xsMFpDmjO+XByHVo6NhPgBGIpZy
 qLyx1wMDie9ZWG86yei9oOF8gLerGadSVfGCVfL8NSP7k7fvQEYx/jWNQTFsvptrD8T/EjAd1sB
 IyHSfTVyoKQFzoXOWX1jcdW1e9md0km5hOUSIXjYSxdJQMIorkqXasOG82FnV46J34Ib1uvbLQS
 D3NwfARYqGN26oai+Wg7t0hHFhSRWO0a5m5cpbnHuupG6PmeHvIj4fTSineXRye6FWAKOhoyEjg
 /bv+mOCg508Z09CMI+NM2g93gSVnzEosVzJg0/46ufSH6piFOPU5/6/K6Kljxfzg6Pe/bMWjZJS
 DoBbqoIP4/VGSzhb3L0pbXsLXN4CgoMlAxxQTXRDBiw5HrSBpgX4=
X-Received: by 2002:ac8:7c48:0:b0:51b:7af7:77de with SMTP id
 d75a77b69052e-52b566abe38mr133390011cf.14.1785680327691; 
 Sun, 02 Aug 2026 07:18:47 -0700 (PDT)
X-Received: by 2002:ac8:7c48:0:b0:51b:7af7:77de with SMTP id
 d75a77b69052e-52b566abe38mr133389471cf.14.1785680327281; 
 Sun, 02 Aug 2026 07:18:47 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b67529sm146522685e9.8.2026.08.02.07.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:18:46 -0700 (PDT)
Message-ID: <cfb8dddf-8d3d-4b17-947d-05c473ad69da@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] target/s390x: Convert op_st8 to op_st
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXwrJ6ozraseH9
 8Ou7gRh0acCcrekGRoMo6tAkzaTTWMuvKoWTb/L6gXU8+J4DZVhiswgBiwUrwq+TyIG2n7YEs3A
 pcZpfv1e2Owasv5nK7Orp8hZ0Rhf7TrrGp1j9EAKj+7ScAnLMOzZsYWWyydAmstai29dw0n3vqm
 3F5ph3RIsIx76jPSquIjP5gxW8cMNR4vrBD2hfGsRDe3Li/xLKhMNW6QkXdGQ+uwyGV+p2H9MWJ
 TUe6vsMasQK9jz0aysEe9rLkTqQsP3xP9anvnSvRgs6/RRCn82MfokMtwCDQHAg2PBqxLVKV5AG
 OtJ+SjuCkR9/Dm3DOIWRF+zFGPOgx/s887FGxxpCMmK9gtYFycb4gazC8aYCya0vJqYj/5I7uVu
 hysXHYQmeuuNaSnLfK1ZsmCmYUrCgwhZCE54gZV5aYKy7E+luCJbiZ92lB6gHVIjksu6BbB0vVt
 9UNtoJ1l7wEpJ1LXFWQ==
X-Proofpoint-GUID: l5Rc116AiR3_0c-Q16T_jTV0BPpAKn8k
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6f51c8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX7mdzmSqyrn4r
 ozpOTz5QAZUdD3Nn31FzTnsJAb76YLfcxQ3uQps18UsG1x+tNKh8tA/vRRIjDbJKCScykttLNph
 ckS9oV3hHdpbjIrFC7DyoWPHJtZGOSg=
X-Proofpoint-ORIG-GUID: l5Rc116AiR3_0c-Q16T_jTV0BPpAKn8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020126
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/7/26 20:56, Richard Henderson wrote:
> Begin unifying store operations by storing MemOp in insn->data.
> Start with op_st8.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 4 ++--
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

