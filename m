Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04370C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyyq-0002kU-1U; Tue, 25 Aug 2026 17:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyyyo-0002k4-02
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:46:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyyym-0006Pn-5U
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:46:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9lpi3116428
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 394q3AlTZeoz9r9gng8WMoqvGQx5WdBWxvgbkoZ6BU4=; b=Aj0hMCKazmgqr7Si
 0lyyShB/+vZ2jWrpJtDX9zKY2gKnR00aWMYVVGk/Gn8MkRJQFbM+WfJzD9ItwqUv
 TX4eLDEi6uVXTxcZcsjK2c9WIS51r3eJ//m2Yrn29G/NJ2IjVyWjyVyMl6bACJYv
 MOVVZaCci/EFbP6wSMnSiHztG8epRT5caleq8rm4GcNECVZTRod7Dkz2YeAieNJf
 CpHegQHYVMTzKHnQjXDJkFCDyMt4DcBCS2hKKCoc4x9tZnn8zdAzNkUwFDv+sDur
 W2AnMyYorGN9UtTfXPFNBsPQCwSW8nx3KHWUnFPXZCoWWdbApM5cZWG8u804pio2
 nV2WIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mrnc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:46:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso5365881cf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787694405; x=1788299205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=394q3AlTZeoz9r9gng8WMoqvGQx5WdBWxvgbkoZ6BU4=;
 b=AhWOQWzZERQn3z5N/Cr+x53R5Pl+SJD03g9Uo83I2ZJM5Mskh6szCqnUFwyY+p4s91
 41pkUtz6mTMz1JnuHTVIvmkkphWzSSTS7oYiZhvdgB+eWyRd8kbQYx9gZXdNN+FghEIe
 pnWIVA5DkuvhD8ytrcZV92FJL3t6xDdGK+69+wFCmMjxoom4m9kHbMsDgZ/xiED774jq
 5iS74ndAGkNrQimZlcwaqSGopgp5Pobc5ZJ+antF59EjIRDWNsh2vrLhgFvAx2ABSorF
 bDjkljtlahnoDduJVkKFFLB57r9VHIo4xa5/edMg+S/ne6U6gfDVUHumEEQJaOEKZT4w
 sfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694405; x=1788299205;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=394q3AlTZeoz9r9gng8WMoqvGQx5WdBWxvgbkoZ6BU4=;
 b=AEZ3C/mQUCctrZYIs1/+Cg2RFPsKFSxlmfghGESopRPM/mSUfIkB97hiIICt5SQu0m
 WTuqwGCzNVdiBMHfhXRK7s71OAvRVlhzKtnwa+x9Z4j99dkpAfMyxVM5eLLklTGbpPIr
 uwxqZagd77/pm9gBH84W/+l4AWfnu6lNNBZ8FIOlkrJVtfDfdThx+R/44JOuOkqKlPlL
 DBosXyFYB06XxJshOGnx4mvDDPFPL+RWA2eto3b+i7D07S/sI86QZTbPoOv1iGxrMBjS
 xobXN16SbRWLo93AUNHQik3f/TgRBVg0qqQ14aKH2O/tl5GJExznokAfbohhDVaaeKno
 Re0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrei3CDN8tCVhGBoN3hpBGsUcXmGJBn3EuOKviIVwxDg4T5igS0+bdTJO2gHBFVJ7CsLyeBcTV0W6mp@nongnu.org
X-Gm-Message-State: AFuF++ny0GnHRr38djPB5w594IIucP0m8Nhwe4YTHk2lV09ep1rZ2pAT
 u/3hV6tCAntBBRumc2FpORFzb6AjrLVOcf0Q+5V+AON7o8kPS69e7MxoJ8UmG5htjGM7BuCpT7G
 6yS5Kv+QV0a3SiNpkZ0FPRRTRzYfOczb8HL6UdyoarofjGYT9ZXsirV99ig==
X-Gm-Gg: AR+sD13BbnyaOYPPBxaOrWMwmj3CtKbOJXMBfeSbpRbKhkUqB3+8M28aaneA0poX7YN
 8vu5fXnMGQ5+qzt1nQMN09unsIPpAhoNK3qJm5QTcsogPxtJswImkXj6wOpg9cgPceyM20bznHf
 W8/XCsYVdyanClb4fQCiXZ9F39LYXTsWg/KZ0qp1L+2HQTsZBzsG44PMtwolr/nSGB3mg8GWKYt
 Q76OHRKeH/VKy+Adl5s09mXm1oMiIWtKfpDwTLEkyTdLTeDuKftksp7BDS+xwCL10cK4WYSCQQP
 zeY26hyN6/NfJY80DNqobt7eNILLjIzClyqwH7VnFB+RYtxeCdPotyLR3pwctwb0bEVt0Q+Aklc
 hWok4krKjC9VWFwVPBYo4vOoll407K8votZOZTvrsjflmzirmSzM=
X-Received: by 2002:a05:622a:6182:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-52e422daec2mr24487401cf.5.1787694405462; 
 Tue, 25 Aug 2026 14:46:45 -0700 (PDT)
X-Received: by 2002:a05:622a:6182:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-52e422daec2mr24486991cf.5.1787694404936; 
 Tue, 25 Aug 2026 14:46:44 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm684413f8f.13.2026.08.25.14.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:46:43 -0700 (PDT)
Message-ID: <3c1280fd-9906-4c98-833a-40ef6f0b267c@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 34/49] error-report: switch to use monitor_cur_hmp()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-34-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-34-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NiBTYWx0ZWRfX4xj/2jxJPDx1
 FMsgOMLlILxhwDH1cDE3oRQWykB0iMfoigGC5DL6ScZzr85e6zCxLaP3q34M68ze5A4l5SjFate
 V8Z5kcon5EPeNiLO+KJMrKQ0/5ZFYCs=
X-Proofpoint-ORIG-GUID: lWlUeqHuwpsMKKkFcszoyhiaw3NN-WV0
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e0d46 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NiBTYWx0ZWRfX86EoQ4PVnBHU
 xIRt1cXXmSUScBJvF1n7TaUEengEjwfmhApHRJG9we26w5jfWBwZGnW8+rrAtyntuIDhszcN4kw
 08WlsV8zc97sdJm+1Q+kXdR9x3CQmLQEuRNGv2Dp4cIRoo6DjcKEOGa17u5LRL56rH3h1PpjrWX
 aa8Fk3Hc6NgNQ0JxkWjSRLeXNGfVSekA5QSTekKy5VnM/ahHvv58foRNUDEQ7rXRtuLrox25tZy
 yownWl3ok/VdTK/6f3MkOcph/uvexbMgbUfCAPaSfpH7/harHew8O1Tbn9ajdn3fuygJ1mG+DRb
 MK/oePWb+IqkmmglacOmpQDQLo+p5e+3kBj1dVxIKJenz1ThYUDfiZIWteCVyz+vmSjh4AI1FiS
 OJdIWgIVaZqClZUj6k033q2qVVbGDpoWxPLiEszxOozs2AlxuhA6+i0risOR7a0OP1tF4M/noeJ
 8m+4nQ+WpPRBlF1CHGw==
X-Proofpoint-GUID: lWlUeqHuwpsMKKkFcszoyhiaw3NN-WV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250186
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Thread through the current *hmp monitor, a non-NULL pointer is
> guaranteed to be a valid HMP monitor. Adjust doc comments.
> 
> No behavioral change.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   util/error-report.c | 69 ++++++++++++++++++++++-------------------------------
>   1 file changed, 29 insertions(+), 40 deletions(-)
> 
> diff --git a/util/error-report.c b/util/error-report.c
> index aaa15bc79827..aa278de6646a 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -30,34 +30,29 @@ bool error_with_guestname;
>   const char *error_guest_name;
>   
>   /*
> - * Print to the current human monitor if we have one, else to stderr.
> + * Print to the @hmp monitor, else to stderr.
>    */
>   static int G_GNUC_PRINTF(2, 0)
> -error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
> +error_vprintf_mon(MonitorHMP *hmp, const char *fmt, va_list ap)

If you ever respin, error_vprintf_hmp() would be a better name.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

