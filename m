Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32872C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX2i-0003ji-Lr; Sun, 02 Aug 2026 10:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX2W-0003cD-4O
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:19:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX2U-0006eY-Kv
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:19:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B7BM71603482
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /r2PS6egMKvC3RKwpPfgYxXvvww0oDpa7td8stVXA/8=; b=HHWRJ9xi1+nnuN9B
 eUe+VHYQdHbITjk9d4HrwzVsYImqdHg545tby5wiEd9ARkiD3EizBIMf6/wQA51t
 /gkBZ+mA/EtoONXixyRBliuBJKKcwLxHKReJ89aV/FImmfUX+0/vu02wV6ZS5JwP
 9GxCZEXAUS3Ld+Wr5gvW9kwb9Re8s0ZW24asYOzUHyPWBW6XSuDfSDWbg9eSOiK0
 eeggloAaG5TwpNON/2eE/pxESzaSolEw2RlA3fxIlrFbL6mDQgqaaLlh8Vi13I0R
 nBn+g072fAO+dGvTdSDNOzK334ohSd4oI+1LkL5aOuEHQKv9VcSl8qly99b0Udjz
 nQ/S7g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8vtb1ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:19:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so26542491cf.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680381; x=1786285181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/r2PS6egMKvC3RKwpPfgYxXvvww0oDpa7td8stVXA/8=;
 b=RlgBavrB3GnEooL14jUGZVf2aBlcXmPMDHs3CYKOSyZJS+fci3LVnihqIprrCKY7Ay
 E7+g92A9WGVA7OORJLYmAWyMNwkJSM4PnVGJR+vrqowods3vDhtNIGwioOg0Q3MO8gsu
 g4CcYG8iohQM3eO1OaYyh+IIi2Homq2mDvqPxluGTDVwXIAuWjBQ00bL09aTDTzk9w0S
 sFycRWHC8kZ8kYa6+k7Tuz3hBuE7Bik9LQgo9xiDdGQ+oS+HEU8M/hYRkWFjzGKWOXqs
 H7CxdH+QZqGURtejqbn1XEvNuTqkzR/CAoRBarr0ikvSOm9AcWGcLUoK2iMbt23Q4dBP
 SfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680381; x=1786285181;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/r2PS6egMKvC3RKwpPfgYxXvvww0oDpa7td8stVXA/8=;
 b=Q+g1sBVqouo5eA+vsWdQNYesWJeyFhbXMa9P8mLHCgGcc4tPq0kcLcT34EOHrzOynA
 DzEjQvki5+tJAraGuo8Xns6UPdu8qgVZNKTZio8AMzAoJ001gBUoa9iQWnyzyzKoXdU4
 E4TJfXJPgP25E1cRc2w3O9ewo5ECg26amR/oalKOJHWuvAQTePbF1KNYMuV1gcOXMWCf
 0vA7bLvVo1ewbMik7VDiyA4pQIfC/gHM1nNh8zkgctXfbIpu9OeGI/O2ALZm6MmlJeHo
 9xt8tvzh2wOSJeUgAO+3CirZUyuDzxdN6XPrAyBYIlWie/kOg+43ToKSBq9KKGsnMpVc
 t1Mg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6RzDwxdb+OxM132CmEOl/A48TVT2W+APmxUfRPeZpvEnmLUdszrCfwhmt4mkIb7eb3YLFwbRnHqVy@nongnu.org
X-Gm-Message-State: AOJu0YwQYq2llCR5HP+MWF407mJkvYnMk4eOB27dtVPjuNw/8Di/iUq2
 gW8mUAC56RCBLdmJD5LK0HRmTlQqnd5UlfBwA0Hyjij84lqFKCnKrfXXd6p+a3M3Z0mrnhfPtTc
 F1Fr4amabZZgETlFSfZk0IwZm1JjtNMRHwdW0aANqILyGxwRPe+psvGiN3VpqAv0L7g==
X-Gm-Gg: AR+sD136nrR9zeuTZ/bEdj5W4+nucROd/zKoGRDyJ9Iayaet7ik/b0Cmf/EuBezqhrN
 kLKPNcCwzlwzn6K51dam8dFKr7kWYA6J20T2PX2KXQq/zrEEYtcj99eOf8VEe8Akxkka1D1wQFc
 7Gx/cnoVaWz4923e1WwvhyHH7lEiju1HuzNO1FRGdyp/1T0VHXW+UAMCKgC2oCWkPWpSrGdQoD2
 JJZVYduY81g6/fX1QH7odS6O6LRsNvDKL9Vr/709yxts1oalllqoIX/csazrEdl17SkDQQq2D6Q
 KbSh/VgZyl4HplyvyjUKozN96DOCslsRM/jFpWjmn7jkVh8yIbJXejxVcHpzYBGSEqSFWoMr3UK
 GRZC6vV8foxwhc0w+M7mFe2NQ47gpl68+V1ORYjL1btQ0ccNX6dg=
X-Received: by 2002:a05:622a:580c:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52b4c5dc695mr144370251cf.19.1785680380822; 
 Sun, 02 Aug 2026 07:19:40 -0700 (PDT)
X-Received: by 2002:a05:622a:580c:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52b4c5dc695mr144369921cf.19.1785680380460; 
 Sun, 02 Aug 2026 07:19:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458adc9sm25804679f8f.27.2026.08.02.07.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:19:39 -0700 (PDT)
Message-ID: <0c2408dd-938d-4c48-a52b-114fe5581636@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] target/s390x: Convert op_st32 to op_st
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX/juto/CC1nVD
 hH0iMDmFm5cBY25EK5AqzYcC3GdIWlf894vMaCvrdaGWClBXlhw9IWoD4HAcVk9mk+tvphZO6zd
 RWja7gF+7PvWTXQW7OSmuiH9EBzBAHU=
X-Proofpoint-ORIG-GUID: ZbbnRbuTtZygLX2TOTl-av_L-ZgAczg7
X-Proofpoint-GUID: ZbbnRbuTtZygLX2TOTl-av_L-ZgAczg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX0IGnGCTNS+si
 EC/L525GNNLuhOiXp+85Ey8KL9gymtmH5z81TeAjjhnsDqG5pax71HpRZw5KeRWhvtGBlww7lHy
 Q05K+54W1lK+kiYjJ2A/A9RF+870JxuQgX20HG0bYDQmPO/CrmSvwjKAj5xagOvTCbnlT29W47e
 /tdS9w6NIyRkPwR0xVoP6Ekxr6QJ3k2BjUEZBlbLH6biUcjUAnq6uIHuZpk9D8okoGlwS3PMLSD
 175gG08hWLbC1FNLIffOzuta2dr9PPL3njLF/EksMgck2hw98NlyEYaRxF2kJA0yfuicsC6RVB1
 a6wXQGNMwuUtFxeGcXYHUUYjafqtJt4pLoDOkD8JWrGKLwG06yQ8zCMnMNff5glkJamYBOB9qHN
 yEI+V0znCof+KUCWllUi5N6eGE5sRUZz+po6tgfnq110QrS5JS/Ams7bojCNS7NefytLOhdU1eR
 DaOH9ne/KWwyqNDtCjA==
X-Authority-Analysis: v=2.4 cv=fKMJG5ae c=1 sm=1 tr=0 ts=6a6f51fd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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
> Note that op_st32 already or'd in insn->data, with the only use
> being MO_ALIGN.  We now put the entire MemOp in insn->data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  7 -------
>   target/s390x/tcg/insn-data.h.inc | 12 ++++++------
>   2 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

