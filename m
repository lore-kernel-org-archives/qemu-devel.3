Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE492CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvFa-0001ZN-AC; Thu, 08 Oct 2026 17:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvFN-0001Ym-Pd
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:01:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvFK-0000tb-VS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:01:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0QC43387184
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qfydXlVgJmn6Q9ttfLdG6PO9nTixqJqdondX3XvCx5E=; b=Z/RRy4q+wpt458Nq
 QDUWtZCkAUmzFB+IrQazZsPOpdrs7ivRefsXFKvJQjlZ09g5VieV+pnUfBurQq5D
 b1WI1JQfl8KQ29ufHS06OnQOFdqme3mm/gclRqhw0/tmi9IjR0CYJZM5FDPAGeWG
 uPzL7SS03NCZpyi/2ZZDwji7OAzZ2zIIkJN0iLSeobJtbV0V2wxbZTFCQLruV1KM
 RNySMScMVNk7lvDaF180iyQ07PQe7GM8yP0gqDdZo5RoMfODjNbFK2wFD9WfLav9
 IJzfmAs8SXHezgX3sA7nhTvqilzY9mgnH36YulUmhKrOCQCl0zFf93r4zOHIBEJV
 FTujdw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrnex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:01:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso4932056eec.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493304; x=1792098104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qfydXlVgJmn6Q9ttfLdG6PO9nTixqJqdondX3XvCx5E=;
 b=SXKN6caoH8tB5gvMBJVf9DQo9ooaAPq1b/m8m0RgMw5XnuHk4DzGjPJttVeCXIy1Kg
 KveOiU3IgofaqEa4VYFJdN4VxInQOzbhVcMDjybayPPfgvVczLFhMzbuoEPtHX9sT9N7
 2OpU64Whu6WQQgF48wTgBZhOB3MhEXjUWGkYs1cemaWstauDV+CdGzlevFevcurRUyPP
 GIwSal0q/oOYERKJ6cvdrgRal/7o9iwD39fICA5d9IEydytGacrNd3K3LMiwxphDyb3m
 /He/NTY/q0WdwBkSZDny5azbeLu6OUbUszCujziRhwtIk9DqxUaoK8aVQbzBtSOpPVd3
 3UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493304; x=1792098104;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfydXlVgJmn6Q9ttfLdG6PO9nTixqJqdondX3XvCx5E=;
 b=SkYp+Y2bKT8C2Tt9lxZw0Xdbdiz/6kIeDknhcvJvOqOhWX+UifeM4pkga23ULHeI3q
 qQBUXFw8RrdgcU8yRjPDB2DrLyLfaydsIPAsK6fgl7QaBmAZqtuPumelv8jvW7z83RiB
 o5WLsXbVGK5+JuegsxrCdYLxo/mi0WWc+A8NCpcErtvispUCT0hFeu4cz92bGztCg15M
 7httV15no8pFIRj2Ap1K57oIvLso0AUJiMBq9x/O56gTYuFjI4h4jV3CH5DQ/KWVJ5lf
 E19eVuXuWkSttHng0OBNFM7uXy/GklmuTq8eb8Ov01to7jx7kTHzLP7ODfhwVXGqUddb
 9DLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEfLFMkmJfJUGsYWxFrYr42E5VHCb9cqv+Lt0YWCEkHYM37mZ7oheSzSbTICbslQxmHP/K262iBeYF@nongnu.org
X-Gm-Message-State: AFuF++kTKz9XziF8lk+3Jmjg8V3yFtb6zSES1ncfcBRLR5/bGs7sVTz9
 rWhi36MWoyDcL5cbB9weofRsR9L3YHGb4+25c+ozL6gah0U9pthyEBLA5KV/TrUmXN9TVwZhHga
 8Q8HkXR4QouSjAenTLFS6UcLARB4+gqPOqw84uBCx+SnYmYUuvsWpl0Hgfw==
X-Gm-Gg: AYBFou3hidcHUpnDYJHJr6QD4jG90gID+Uv0JA8Aoz9RKDfBw1RU3DeErnEX+OV17Pw
 7qMz0o2N0lfVGjVnEX7UpwaW9W+mY04doeIobjapXnAb88RMwQgiKQAz9WlrLucJ/qZPx0jDmlD
 8X0dkDvY+HYjJT+pWKBRjtPtdstgKBa1xU7G0Qcy1aLYnxg6YXKO2gM+nteAX+hUGwy78CS1Qe2
 Ghq0krx84xrF/XPjUZKXUGOTHyEcHgSiNOynf6G9ZBJXVQkJjWLbN9BWMy9CNMovLAU2DGIaUD1
 V4Sa3xW45Wpb7S9WiukH4QyOjQ0lSUGd/02XyswShWA7uo8AFz30XKzaQ5KNScuYugdZhi+0DK1
 Fdu8QBokESLyS+qeBdnT0CVcuQTFCIpNV0Re8VR3OpFpJgnrAWDrsOkhtLSdbO8rG51b3tw==
X-Received: by 2002:a05:701b:4251:10b0:14a:fe37:cdf0 with SMTP id
 a92af1059eb24-16a17a09a3dmr20064c88.45.1791493304037; 
 Thu, 08 Oct 2026 14:01:44 -0700 (PDT)
X-Received: by 2002:a05:701b:4251:10b0:14a:fe37:cdf0 with SMTP id
 a92af1059eb24-16a17a09a3dmr19877c88.45.1791493301706; 
 Thu, 08 Oct 2026 14:01:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm713450c88.5.2026.10.08.14.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:01:41 -0700 (PDT)
Message-ID: <86a129c2-3f1d-47c2-8fe2-bac9ac466209@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:01:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] target/hexagon: derive HVX storage sizes from
 types
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
 <20261008003711.3984454-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008003711.3984454-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac804b8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=HZ-xMkApz0Urxva0tGEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: FYF1P9eoVLwxQ4eY6hOVz64RrNxBQ5x9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX4Aq4frqktU6b
 4OPBpnnIUL5ksKa/jz11zPUYXgaJUU9tGhKHQzrcJecDu2vHWWHPOuuYm6fMzkj0B4UC/fB3lDk
 JWmqN5QrWJ1BngxE4EbM175SevTU6m2lT5i04T1G5lgBrSkqZaj8pGBZPSYX7+v7ZLH03B49mZv
 Gry3wf+CTHdqeyWkxAa1eqCkoaI4kbb/wJxGUkHTSehEt4+doPxnGfesmkU1NRj/mraGauUxNob
 PG1Ez5g8HOPdVku3CyyR7kc0DiZL5lB1r+DFCSAvAEs6G9dv8LzYmXpfgvPDUG/ZTO1s2MqPuIa
 wJ5Zk6LPEJFzKk/0xbrg/n8i7j/LTgoYFiin7W2YM+JXYFlLEruiqiWhwJUeDHnZjxjXStVkzZb
 pZBijcCKhCyA1fPcpdhjn03Lp3WDDf24t5FfzyqZ60T1Hd/LKhyn687IPPBeEaQuW0gozoUcTp2
 QLXy2JAVgRsHA4IrvEg==
X-Proofpoint-ORIG-GUID: FYF1P9eoVLwxQ4eY6hOVz64RrNxBQ5x9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX8vdtnY1aDpLS
 76ksFR4rG31xMu9Q3zn5gLPHagwZHhzWPElJpKNwo3T6FlhxPmH6an9m/CtJ3SCjEa/Kcj6wv+I
 uG6e74SrdQxgdvQAkJh2oy7oSa6grTs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080083
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

On 10/7/2026 5:37 PM, Brian Cain wrote:
> Use sizeof_field(MMVector, ub) for vector-payload storage and sizeof(MMQReg)
> for predicate storage.  This makes the intent clearer and binds to the field
> instead of a max-size constant.
> 
> In particular, these bounds exclude MMVector.ext, the QFloat extended-precision
> bits.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h         |  2 +-
>  target/hexagon/mmvec/mmvec.h |  4 ++--
>  target/hexagon/cpu.c         | 12 ++++++------
>  target/hexagon/gdbstub.c     |  4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

