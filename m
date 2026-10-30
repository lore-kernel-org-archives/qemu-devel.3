Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89807606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U/nSIeaV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IDOMWL4T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMwJp-0002lE-Gp; Fri, 30 Oct 2026 19:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMwJh-0002l5-N8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 19:47:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMwJf-00049y-R2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 19:47:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtQow3568410
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 23:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xa0ojj3aOuX2vPhZn40ENk7zbPPb+DTW4MbgVWtSOS0=; b=U/nSIeaVMGAEWIn5
 a9hE0pxKh52ORKsL1EyvP6bwtvQ5Z1yZTVxHPZVFjEs6ReGtOmB0GUEd/kUerCGd
 Yr8Z7mEB/WOLzLiGnc4rJE7WvwXflMf4xAeCaU7DgJ80taE2yNZTiZuhjMWIhA+M
 Awk9mx6X/qXyoa9oC7Mv+L5yh3TRMlvUKslxeZXNNsSKMOpGcLMbi0CqjY3SOznx
 G0c6pSH68VHlfU70cEeCvTA2FQp6EM0W957nceYCxb6Sg9kvBwFBD8So8rqPo7x1
 IU8sbzsp9WVz4AlUVlM0jXaIgjkLtKjK69keFluFCrCfskCH33zA2fXMjzESaofX
 ia2OgQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0gc0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 23:47:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-537548d4bc0so31800571cf.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793404038; x=1794008838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xa0ojj3aOuX2vPhZn40ENk7zbPPb+DTW4MbgVWtSOS0=;
 b=IDOMWL4TuxN/dXPhF0tF4DY5+/m9O8PeF6t01PE7IXzAX7POtExhMtJ3u3wIKYXR+X
 Zi2bKe/QSIz0zELDI6suOX4hBppxt6mU6kFSDOd8MD/o7V5pNI6buUDwA9sxseMvNg8p
 Y5F/yBXo6x2VkgyladEk3EbVD2bd7ect56O77EK1rm/SnZounWR2AMySPogOHQEF9w6l
 /qA9K7gqNrl51da7iVKFKhe0/+j1uJuL9LIBKRhjPEa+cLdhfKLIaGpnF5RMjgTV8ymL
 U45MpWsF4bbnzMBgaymN7t5eQqICkc6SpcSyBnLB95RZCzhFUvY6NrqOTME777HbjvuG
 P5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793404038; x=1794008838;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xa0ojj3aOuX2vPhZn40ENk7zbPPb+DTW4MbgVWtSOS0=;
 b=V34AOGJMqyjBjJhoqzyKqviwP9UeRZlDfVXSgNqGHM7+7MV3o1XOUJ7514ovD/MmZZ
 IG97sAircqfs0/o3lJdtGS/OHQJ+pd1fCppgE+Pqsh5yy/StoK8pdkqAkdRun64aYwb5
 ujvH36LNCJScCL1t/jmlYSjZQ8Z1fLFKPXcRbavulEtTFCR/nK9kZN94veZRUmSFpwW3
 1nb1dCXJ6EVwAG2PEmRjW1yx2fooiuWtbFv0n2lZmg/puH33MoENs3DQAXspgs4KqICe
 0MxZ9XVLdqnOsHmIfICLiUbcwTRdj151fiUIk5SVnd3Wjs+xisX7Gm1FgBO/xs13k9ti
 9bGA==
X-Gm-Message-State: AFq9FYLju4NZLg/2EfgmN3X9HY9+L2aSJp7B0w1aH+QGyn4+WyL1FlUr
 YWEPDhEcs0BBa6YMPzBuYHxYeSulnnVHt2rRcSCI6SH5Nd5d8T6Z0EMs6bZMY5225i2LhZYaB6z
 HJ3ntYOb9mutH0ssahyyvP0ixKKpkXkY5aWOwFyrCAcz8yaTq/U3C3Mqxyc9p00BaOg==
X-Gm-Gg: AYBFou3QA6gAVBeKZjp0EyDejl3ow6fFO5XTAuLqAgsD6nulbRnuZbotBSuccbgqPt0
 6TyT3UcfBKx/F/adPqa3TJ2epCdjXyJPeWQZ+Vjz4YuUhWk61werVFSr055wuL7P4qBh38WYp3x
 5w6CwtkLKGIZfagC9aBkBsZlba2VXF5df2lhFKWZkq6tESY+5a/JTUuOMl8v4xo1q6Dq3f9z5Wn
 EHNZ8g4Z7fyQCPKEZc78qASxWnLBmBJK76rgNrkSOxQWRbQQTfoqDAXzY1KlqxPZLGK5lBgn01J
 1nyM+mUpbfGintleq2Z49ShtKldZWhoGLH34mJpLoJ7Da8y2IycoDhhda57jb3lbRbB7L9GI1rX
 dOkJc86WPZV+Ufd4LIJrB8Tma4oI6FN09OdM6iYW9e2kJQY8WA/1SzHsIBeOhs9ClC2IwVTVstk
 smnjdF/u0jhsNi7pKNBbgXFSGb6ZGfLDVj6x0Um4QuoKf0rZW66aga
X-Received: by 2002:a05:622a:a15:b0:536:5f01:7016 with SMTP id
 d75a77b69052e-542b6f4c77emr59361101cf.38.1793404037614; 
 Fri, 30 Oct 2026 16:47:17 -0700 (PDT)
X-Received: by 2002:a05:622a:a15:b0:536:5f01:7016 with SMTP id
 d75a77b69052e-542b6f4c77emr59360901cf.38.1793404037194; 
 Fri, 30 Oct 2026 16:47:17 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-543fcb3c30fsm8449751cf.13.2026.10.30.16.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 16:47:15 -0700 (PDT)
Message-ID: <05fe787a-fb5c-4203-879c-062303a7bfed@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 18:47:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] target/hexagon: implement mxclracc
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
 <20261030024110.1986536-9-brian.cain@oss.qualcomm.com>
 <CAJ+KCYMZ2m7W8_xvOvA=uwUSt7AvaaSgD5Ngc-PF+ZWJFbWDEA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYMZ2m7W8_xvOvA=uwUSt7AvaaSgD5Ngc-PF+ZWJFbWDEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA5NCBTYWx0ZWRfX7h0dhT8UhDQY
 Z3GBYB9YgwKxkyH9Tr5fD4VF5CHkwN1QZHp46SGsi4OawQyesl4T4JxXXhbmSnClbsQiBn3OBzs
 o92g+QEyiqYOkYvhNLkcxQYtO4GEefGtSRi9UszGOQZanjnsd/MTzh/sSTlaPJAFjSJimeNsPup
 t/R0bFD4VCfT/px2TV/ID0VSrHYCCGTY9UpUuZ48yhvUNKAtuc9t1L8l7/7D/DIb+kVgGEUsjL8
 av3UEwSz/Pnkr98FPnZY8lsXcWSgMTD6iSjQL9qj+gq2SEn0uCDWm+GFB99FMEyFNniZuBUvbLw
 YdS6ZDShL0ZpXRZU9qnfcpQ3LPnliNhuSR0JG7X9Vz2Xjk7MWh9SamEab6A4/hRrHy4eDt1Z8lF
 krcaLD3kjypW2M+NeMgEHV9d64TVHxKrdKhHk4ZacBfRvE4AP87zZM4dQQ9R+a5yYxXiR7eBbUi
 QhcSrBV6Ir3CM6XQrSA==
X-Proofpoint-ORIG-GUID: mGJ18B5YNNTTb_BuPI5yzhUWOG5pcHow
X-Proofpoint-GUID: mGJ18B5YNNTTb_BuPI5yzhUWOG5pcHow
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA5NCBTYWx0ZWRfX88N6di4WnA2X
 Thvpn07KTnMUAYJm1OBp6mm2irVwv39DWYSAy9ECQLSaaaorwNBW77U7BV+tlSFEodXcn/P5OzY
 /1VdIjQ84S29H0+IIbG15U46U6qw/0g=
X-Authority-Analysis: v=2.4 cv=Arx7T+9P c=1 sm=1 tr=0 ts=6ae52c86 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=PNBS9oBbFst-8Hn2rtUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300094
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


On 10/30/2026 12:47 PM, Marco Liebel wrote:
> On Thu, Oct 29, 2026 at 9:41 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Implement an HMX accumulator clear instruction - mxclracc.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg_hmx.h            | 13 +++++++++++++
>>   target/hexagon/helper.h                 |  2 ++
>>   target/hexagon/genptr.c                 |  1 +
>>   target/hexagon/op_helper.c              | 10 ++++++++++
>>   target/hexagon/translate.c              |  3 ++-
>>   target/hexagon/gen_idef_parser_funcs.py |  6 ++++++
>>   target/hexagon/hex_common.py            |  2 ++
>>   target/hexagon/meson.build              | 17 +++++++++--------
>>   8 files changed, 45 insertions(+), 9 deletions(-)
>>   create mode 100644 target/hexagon/gen_tcg_hmx.h
>>
>> +void HELPER(mxclracc)(CPUHexagonState *env)
>> +{
>> +    HmxState *hmx = env->hmx_state;
>> +    int i;
>> +
>> +    for (i = 0; i < HMX_NUM_ACC_SETS; i++) {
>> +        memset(&hmx->acc[i].fxp_primary, 0, sizeof(hmx->acc[i].fxp_primary));
>> +    }
>> +}
> The helper clears live state before packet commit. A store fault in the same
> packet can leave the accumulators cleared without a commit.
> It also dereferences hmx_state without checking that an HMX context exists.
> env->hmx_state can be NULL here, because gen_start_packet() only checks
> XE2.
Sent a v3 with fixes for these.

