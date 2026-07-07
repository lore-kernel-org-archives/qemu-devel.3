Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DB1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzAf-0005qj-54; Tue, 07 Jul 2026 02:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzAd-0005qJ-Mx
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzAc-0002Sa-5o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:20:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667498mO2650096
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xbSkgv0wPlKbcETyRTdSiUqP4WAu8bndcbOlsDp/9Gs=; b=hef1GIn4CJXBASp5
 cwqBRrJkiG4gg7SChxlk8CEmCeVLrdSM2HYFI1qTJeHg1d78/wlTndd6L5APe9aq
 ktUlQuvhSnERWbzTHBNasrfvk5YC44pRMkufu2cVmcK6d34aS0p3jKanlEjUTS2s
 FZ5cfrSbVabHzr4nVl50f+pSZBx0QAFBBExmv3ahuXL+EE+qHQt+4aHWeeK9o/Tx
 /rCVDL6XFFdti5dR/4zhuOBDNNEuteP2zMBAiXawC1vEQxTbbLnKgaIKZ0OMnT68
 lKTlm1t9udLolYAGOnBEeGks/JxJ/bTaMt2vHfWYM5H6t7wpIuJikjcxR7OkdIPp
 jhDNGg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw2u88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:20:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef81cc115cso2730866d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405235; x=1784010035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xbSkgv0wPlKbcETyRTdSiUqP4WAu8bndcbOlsDp/9Gs=;
 b=iVeSVAwavhSlG1sI+NDShoO5b+T8POE2qIwSB5vnMwypjk6HEWOoSXLZaDpodlivWy
 OvCudkSZq6PS7ZVZX+t7SFFJlwPx8ZECluHkkv/ouSdn6E8gGj4BewdBfs7J03E5OyIg
 7dw3X5Cw1dsb09re5LlpDTnIiNn37T5jrmkAOv1Cmjx50iuxFym9GYQ7E1IU+YmFuFoW
 oT12WBsCqy1W490EU8FA1RDXTmXK8G6RrsJi4zpz8TZU4fYgFhMo3tOW41Q4TdVzaNs0
 a6WX2LFCLr12b+fN1YSiqsSgHNjWfV7Kk2ZLMU6PYpcvtjN/jvkKvyqhihRZCdoYhhYj
 2HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405235; x=1784010035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbSkgv0wPlKbcETyRTdSiUqP4WAu8bndcbOlsDp/9Gs=;
 b=g9o1vlAAmFaxYE8RdJOLBdutM2UgeqQFbW8dVi1ci4S7tzO8R3eK+BlBQvdU8/YfEB
 DCzXLew2bVnyWvnB0mWmxR4z4Je4eiQwHKapPRv9KNjgI4O/HzdfXPSB/ldxct9FgtE7
 64xt7UlGSHRyBDRbZlzc5IKSe3sNRNp1YosMWOgi4HT5q8ZkYW2HIK80VG02nQbWNlzY
 SqR1to3lolrBnx6TmUTNuo8vr8pjmILxB4V2GDzNBv1U9sCV7V1NrD4pa0UEqYyHpdGN
 EPdHDE3K1I01C7qLGCGr73J1ypW4buUQdXLejQU5nxocSpPG/dZNSzq7LX09dcQElOLB
 PA2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RppdPFgCObuuufKmBOz6oP7R8QtfGs/EN7gfg0yTVfSha7WuDe8EW2O/aqs9AaQiRWiWrtY0P25ET1K@nongnu.org
X-Gm-Message-State: AOJu0Yy1/7jAVXTO51r2Tx7nfaRe50Ce1aEVrgN2B02NHsXoxyyvq2E4
 Kw0/KeEIc7n8Jktn/DiYXCmNKsphDlMUa6E6wgwpWuYCbQyRLNmcOnR4ooQ0ENMFkTU0hVKqylR
 KNdoMpFPfCG0ATwWbEDUhCArxfWzIKrAxQrnjAmV+v7cgM5xieFsmme/Zmw==
X-Gm-Gg: AfdE7cmxfWi1jzRfyoJMa5B67MDqb/vhp2bnc8gcBh1wE4pW8bH54oW3co+SBxN1zT4
 8isrBcaUsTcq2JoxJtIX2s9AM7eXCVyUbyALVhFxX8lqpsQSsHrTTDPKCrUUWYDrX3AUnqbYxS1
 tLntR7uqA+GWsK/n6UTFDroZqQQpzjmwohb3uBrNjD2eEOqxcSgJqBOw377r0AfwYliH4NBdH2v
 x2S3y894oATxJ/Um2GAb1TDypLqCnOKvSVbVcljk23w8tDHvmGZCBZrEQyRArXpjC4Pi5wtBHZH
 pT3tZ60go+Vp3LrN9S5lvxb8p/kQqsUQi0s/jtabeMlH7hZoKdM0aLJokQaBD/XEMPTseXcQ3fz
 4cbTDp3HwuwPC1JQbc+F9/7OuII50NuYAv09glQ9738V/d+MEcjmDgK852CMkPA==
X-Received: by 2002:a05:622a:1146:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51c7a46d23fmr13936861cf.8.1783405235357; 
 Mon, 06 Jul 2026 23:20:35 -0700 (PDT)
X-Received: by 2002:a05:622a:1146:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51c7a46d23fmr13936741cf.8.1783405234985; 
 Mon, 06 Jul 2026 23:20:34 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm30019172f8f.28.2026.07.06.23.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:20:34 -0700 (PDT)
Message-ID: <13387d44-b5e9-4e08-90c1-612ab88fe046@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 63/91] tests/tcg/or1k/test_addic.c: remove unused
 variables
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-64-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-64-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX9Ti/TKh/EwXr
 ztPPxd0ccYXQOcbqMAy4HXyqCwxemek1A/ZAZ4ay6U40tudzl+VmgAd56WbqoFJ7W1/DmYMvTUM
 HnGlQswih6nsjAgU6dqYSQzCZwtjEkQ=
X-Proofpoint-ORIG-GUID: HR2_atskvEvw3-pbcmAQs67VgA8LJ2fN
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c9ab4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX9inIEHj8j3me
 bq59SV0a64OMqNR9OjPnVi44gsYcoTPsPkx37c6WeZfKmsqdszkjf8Go7EVBY1rcYPBogg5x5q6
 Kven/HCZjkwKTNbhe5sj9wi7FrSD40bmnBUyI6IZosBngvEotSy10Bxd6wHlzVp7QJ2hEkK+6N1
 dega9+Z4bT5sLgV0NDK/BBJzwOjR8iVXbCjyIeD5WoyJg14f56zZEmV02ma2t4RZ5NJcDf7qtSV
 B603okcjf0z7jhWnVYi4tzYBqhKDrYMj3XgIxpFD7ryX3GgN9Q9G/dSImlel/pbb8Yk9YLcVIpK
 r0bgVFV4SFiZhUWI4hxr2QaBuoTj80xefW3IIxnZESNcA9+lrn5pYCYcowi63HPYQHTQwx0Dtcm
 iYjQmBN4NcT5mUkmi3WT997Te9xJ8UImsN2OrEyRczOiuzhaHbgnZe7/zf32VD83siX5unvIOpc
 Xjo0EwGBolJq/PCcGkQ==
X-Proofpoint-GUID: HR2_atskvEvw3-pbcmAQs67VgA8LJ2fN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/7/26 00:33, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/or1k/test_addic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

