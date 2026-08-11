Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA782C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtg9E-00071M-Fm; Tue, 11 Aug 2026 02:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtg9A-0006sr-6F
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:39:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtg98-0003Nz-Aw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:39:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMq2Ne2705468
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NNDmmU8JN91tYzPsew8JfpR+4pkt53XwLQNgf0ic9x8=; b=mj0rc1dYthvkr4sS
 +Z3fgVQPphcrhP+XhugGVTf0dWvp6B8kzzCmpYe5JuSt5AVNt/CK1Ox/7LR5pL5Q
 B4Km5iCxpnEaoSdJSNcufpHTlIksEgwBw6hxnf/AqVbOSN696nRWslBK+UA9/Cs7
 2nhR1e0bQJbp1S6t2u1LCiQZjYj1htWB1K4mXZh0M1axHpERHZB6HUoaWoiN2ows
 udPoY3dJKlj7YZU6nn5xeivaerbOL2tCGaMq3ZScpztEC0JqzX0KGk3d3294Cwrd
 HJBUMJJLgD23zTGOqGnUItEu8PG2ZAbnQ0brQFf72Mjf9JbT2wmFeSbN7eUn3lXM
 xHN0uQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk62r2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:39:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso24297961cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786430372; x=1787035172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NNDmmU8JN91tYzPsew8JfpR+4pkt53XwLQNgf0ic9x8=;
 b=QZzn3MwIXw07v9+hzWD8Ws9wLGVUOdoGdKKZZRAIF1qdYEsrXDhMLoS61/PUrQPVKm
 HKfET3dkE0q/QUEWFc5+Tq6nqty8JRKRlV168kYy677ND1txzr4y4v91F6wpAXuf88eo
 yiOabMaQJ8d2o1/xGlZEbA/OJ/kbP2YCvlAy5Y13PNWYribpIYReJkqZk+yYvnqfTtLh
 SOb8PcUGmMr7f6uy5zmJUg5zaEkXul+2w2wo5qfehaQ3ZTJDQf8x3VREZk8vsnR4a7a2
 28zyLtrBvQkoieq37gMh1AFtI3ZOqdPoQ/MmKy/u6xnvwd7Om2Q3uvsTl7vT4bJyKNMV
 0MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430372; x=1787035172;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NNDmmU8JN91tYzPsew8JfpR+4pkt53XwLQNgf0ic9x8=;
 b=MXGVZATW9ABlSxgdLvlkzCQJhIC7O4UqSlysEb64nNwpq2mRpw3RFx3naPu1chrUuI
 eTPARDEkwtwjR5y4ovVkKbpq5FBMrn/GKAnpoNoOtZlma4twHs6JUFRynmF8Qs9yRDJk
 UReFXRO2vPFhK+T7fDmo/ivfWeGxLXh+XgRMVN6LbPCo/LNqPadW3PDoeNR7U5hVXtWN
 V02Ax8DEhA1WFGyf3Rij+i58B/YUUZuW3Sf1Ot5JRmbL+eQaVPKrMS8m0/FB4lMOpZk2
 4ARhnWkxzKvPQ5J5mMYveNbQcDbNa6Q7BNMi6oxOKZKXLimJvu2vHXCLQHZwrIplOxvm
 kk2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwEhz5HNl06iICWTN4Ovc6z1TjssN0Oot+OSd5tcE9sBVAPJQnK6nBYvVzL6ugToW9O1xpxlmGwmcy@nongnu.org
X-Gm-Message-State: AOJu0YxJ9mzTKQKUlyzGPVfDRt3Wm5Y5jeQFin9vRxVWZTEJcBjHWFvq
 LK95WDXaRUmgaPrmHqpIb5WhMMNEdtderO4iyYa1AWf04YWgBH1I6xtZAe6cjU1acSFihRf5Ymx
 YRx7iRqUgws3nccPFVTFDPd+em+IVyM5VGGByhiY6DiC3Tp8Yha3su+jNAA==
X-Gm-Gg: AR+sD10il3/3Pt1c+D7Vu42asSq0r4Aq3ul+/EtPz3i/G/jmRcWHsOXAVZv315wqA0+
 D3f8gONSHJfe1283W83jyCAZJde99YoTg+6gDGpWU2Zgd3nG+Xtp1y1Vuq23jhpY3EAqEhuL4cG
 BJhD1teLmTy4EWY+BspogoblCNT+bb6ef9rs/DBJFMHNX2OgHafXF2WxQvO9u9uAqOwC9h+U3ci
 2E2AMxVZKvxBpLCvPJJFqb0ouZP6za+3kXsAYw1JzHuiHgeEKnsac9djrZR8QZW++KN22JrXsbf
 BQikp773bFQ1VxQWX3gzIDSCtOqiJ1mUFWrnylCVS7uKtdjjF8K3Zm0nd2U/KeFFHFNZgu73XyL
 SRFq3cJUrCpy4bpbbkA518rVh4EVeNN3oZ8tPvgQE
X-Received: by 2002:a05:622a:15d6:b0:51b:ecbb:206f with SMTP id
 d75a77b69052e-52d58626e8fmr8014251cf.32.1786430372358; 
 Mon, 10 Aug 2026 23:39:32 -0700 (PDT)
X-Received: by 2002:a05:622a:15d6:b0:51b:ecbb:206f with SMTP id
 d75a77b69052e-52d58626e8fmr8014151cf.32.1786430372005; 
 Mon, 10 Aug 2026 23:39:32 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977ea4033sm15915525e9.4.2026.08.10.23.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:39:30 -0700 (PDT)
Message-ID: <866d7b90-54c1-450c-97be-8b14dfed016a@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] tcg: Add tcg_gen_revbit{8,32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7ac3a4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mJBMoDSwUPQtsoXGZsmrc9FGjPs7Wz5z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1MyBTYWx0ZWRfX3+6F9Ue2T6uS
 AuRhZkWjKuyu48epPn3m/HeoetWJ0SoM15TVSOHVtPsEkAbWHJwJ3bzhBFIYy5CXPj705rfPJGx
 4JwZKY3c/22NUHkl5PJ/XkmwLaq3NFE=
X-Proofpoint-GUID: mJBMoDSwUPQtsoXGZsmrc9FGjPs7Wz5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1MyBTYWx0ZWRfX+Pb53vi9g1sD
 DQEP634nyRoevQP+lKIRYSjjT3laMffDcyv6Npe0nle70v0J9uDd1gCS5aflN0dXj8NfQb4kmBE
 3Ueh4tBYn4VojVNsNOkpZ+Y4S0CSDMYTxfTZ6i0R1Z/i7GcA3GAQa1ffKJi1foDey1htX0rKugK
 iqw19+p83lQz2l4dN5cQ349tfDcqLHoOt7nRC9mpIRLKd7ed7uIvA7trXF+kU/5hpU+r8qhvIH1
 mB8TalbQDURxBoFYQshlcO/GzMxmW4KVjW9mQR+NAAAXceeitjbKvHsBOEVAaTS00Dkc4StJMOm
 plNHI0Z29TXqxEXKMeZE08KW0kotz4PNldfSwjUUlKi4SsvDN9irR6PCQa3lvn3eX6raj9LgJAS
 1dGE05mzKIBSiu288AejBPddss4kyMXniHNYYwtai266PCkSNkCG2E5lyLxih67VZ1ZDGbhuwZE
 x3zH4Tqt7ZzsPsEyqzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 06:55, Richard Henderson wrote:
> Add generic expanders for reversing bits within a word.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  5 +++
>   include/tcg/tcg-op.h        |  7 ++++
>   tcg/tcg-op.c                | 76 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 88 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

