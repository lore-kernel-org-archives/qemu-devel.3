Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F51C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQjb-000852-7d; Thu, 13 Aug 2026 04:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuQjX-00084h-5E
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:24:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuQjV-0000ii-7F
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:24:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g8nb1072479
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /eGJOEZJCBV35v5Sw6T/yPImkz37I1jswQUb8IAtu8A=; b=hP5SBbCeacdeFfLu
 De3k/cQ5hgfftF2wjquYQcnsPtCm9X3vM0++FwTzPWaIIDV3medFuq5TGAgjB13m
 faFsZcQA6Adilird4156zNaEF2MxVNPKq3E+JSvOj7qfcvSeabl8F40jSIUjY1CC
 ax5dDvo+VfwGiSKBFTNVf9U5w5+H9YFHAghvisCnZODrV1gGY89nQtmKOpjiOSWk
 t3u6Bq+SwE5zuysiSoO7O+0Ka+CsfD1q5iovmwLnkS1mk+sB6yPNkGzuf3ZDZp9+
 36HFnSmRpxjsvwzk6H11WpSpbyV4ei1Ku4rfnnalWMcJG2vj1QTsBfkWzXS6gEps
 8yoTHw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14syhbmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:24:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so1541371cf.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786609447; x=1787214247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/eGJOEZJCBV35v5Sw6T/yPImkz37I1jswQUb8IAtu8A=;
 b=dNrPFnjL6CRiXLqSUepksjl0Lji8+po2eVXkEw69v6w4SnYndWH9IKzxDMIJtz56oN
 a0+oG4SSYUePUhamXcM9sQ3kdITQjs+gxQxXQ/KzrXc/Y6yc2aBl3Ha/H0Clmn/TSG9A
 Up8chpHViDdkrlppZLkK+ufEJ8lafXdWEN32W6dRj1eRBqjzjqyCgmC+Sk8ULxPZpJJR
 WbObuKlrPVZans0sClGBdUaDCZKRj6M/jIuS3nTZ5mOnpD+sizYbW4U98x9crqaU9mNW
 cGxNCAqnaDsIlcLPo/Z9s/0plVTFP77un9u5J5djXw6Y6EiWH2H04o5r9etI1AIXegKy
 qIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786609447; x=1787214247;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/eGJOEZJCBV35v5Sw6T/yPImkz37I1jswQUb8IAtu8A=;
 b=qLAKWCQgDF0+B8ueHqOWANVvEbGDmHAIczvsgnF2clY9KWUf9rVzHQaKiJLe73mSEQ
 ykHcHbgOMd6tjCg0N/3rJlvNuPWQ+sQVnZ2nhO29N3xkcmT4NR5AHmrTPzzKKiQRLURB
 iqbIvvKzC6dAJbS2V4nQmKSigeOP5iFDeBmZBy/Ga6XQxp7nTktX9zc/zdzvhmyEfcax
 41/+ZGh1fTBIz2dMM191XW97mRg+Lclp9jp5OhaBou/BVGogmYj4Ne3K+NS181cChM6Z
 OxK5Ojy8CY0HYcBAU5zsqzNU+p+CW/LYvwm41DMXKLQWCqLSfBukxiwfAUhQFF38gium
 mb/Q==
X-Gm-Message-State: AOJu0Ywe92VpDz0saNauJEmpWH6hp8f6Ka9Np4ZJnE50FQ1Wb99R8fPw
 iTsqjkAGMC4MYDsBwvTg82dYrlLANoYLw76yqoCi10+K6sdO49N+g9nbuulIXC0PJhOuUmmRHlN
 IlVeBYJTCrX63HTN6/WkrgYLq07QqOqSy6WFkaEGgwymzcGJPLJpOqnAOOA==
X-Gm-Gg: AR+sD10EbtMq8rUXo34u1DOMwQilSC1TreAiwANHsFgbcR1pVHEBm1jum7LZZf1z5D6
 43W5lggbzOFr7/6oiXS3TV32uDtwAFX+BYpUFhhGZEAeOexqDF2+0JTedKWAdyiGSwQqXf+hlXa
 kliGaxEzwnyJoj3EajcEop2GK4UlwJQ23aZC2y1CyQU/GZRlixb6+BW/ppGVrODcsJ3Xm+RR6XU
 fLyfOAJe059EwdtCTNbX9ZcUfwUtmWlg++P+3+m5l4g7+bYkfS+w+VMPuRecaUrIGwriImlaYH6
 vEFsY535bD/evoIA2zRP2DKY3O7S+8LvsLUTs4wAXkZbaZtiktFIHgQBKVS9T61Bz/EYaZz3DRJ
 oYBNerbeqYMnHBeUafYdE+Nj/51JKmgBLtHs=
X-Received: by 2002:a05:622a:54b:b0:51c:c6c:9d65 with SMTP id
 d75a77b69052e-52d73be13b1mr40165741cf.1.1786609447240; 
 Thu, 13 Aug 2026 01:24:07 -0700 (PDT)
X-Received: by 2002:a05:622a:54b:b0:51c:c6c:9d65 with SMTP id
 d75a77b69052e-52d73be13b1mr40165361cf.1.1786609446862; 
 Thu, 13 Aug 2026 01:24:06 -0700 (PDT)
Received: from [192.168.69.208] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e54b31sm22265595e9.4.2026.08.13.01.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 01:24:06 -0700 (PDT)
Message-ID: <50260678-269c-47c6-86c5-a148b6156bb9@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 10:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/23] monitor: Rename MonitorQMP @mon -> @qmon
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-18-philmd@oss.qualcomm.com>
 <178660214825.3552881.16834360265143429528.b4-review@b4>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <178660214825.3552881.16834360265143429528.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7d7f28 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=2Jmwnru2tnUDhFS7Du0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NyBTYWx0ZWRfXwBn6FcUAtdGb
 KVtIObRoMk69t0DDe1iJWaI8flRVzLLSsI3dRrAcc/VeL/GiPTHlKGRgBfF3YRoUv6PRIotLyuM
 FtwIsZJwPocRJbypnVLBIcAGvFzIAy02AbawP48m8OdDmwcbMRUfHakv0Q3vFgjt7zpIjPCGkSF
 /sfcmvulUDvqoqqZasfjVtuROZEBxWJ53FlMrNPEc3pNxLWFnZAnj52YBOlLvicZsSz4h6IM9SP
 YlipAfhNkOGvNvFOvgrgcopFCuOvum5T+zwJWIRp8ZZ3TBOqUpg0DO4VuqgLNeJA6djA8inl4j/
 5YVVSYsdR8QbKkvbBSpv6bxf0LxVxxXDHSBG22Mg1VQIdmAhT9kvIbE55eHnCeB26ygCZdgXH7X
 tJYLlmrrgoF6aQ7c4ReHa41Y15O0UavNtRezj3rSME6EhmGRrRL+Z6HAVZp58hnyfd61ASRARva
 pg8ULRdTzCBTi09ERjg==
X-Proofpoint-ORIG-GUID: 9BLZDB39RqzbwfFNi5EAK_gDYoGg7E_m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NyBTYWx0ZWRfXzPnnlZcFBzqd
 tJz95WHpry/2Dyx9WBJWbyhEPTZCcATJHebWa5DOg56Ik6NGeZeaXOjzWfUTBQTwuZZ4WBF8maj
 3Cswdwj8zUljeARHHdxIXzvGcE+/7Z4=
X-Proofpoint-GUID: 9BLZDB39RqzbwfFNi5EAK_gDYoGg7E_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130057
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

On 13/8/26 08:22, marcandre.lureau@redhat.com wrote:
>> Mechanical change to sanitize using the following patterns:
>>
>>    MonitorQMP *qmon  (this patch)
>>    MonitorHMP *hmon  (following one)
>>    Monitor *mon
>>
>> Rename @mon (and @qmp_mon) as @qmon when the type is MonitorQMP.
> 
> This patch and the following are conflicting quite directly with
> the work I have for --disable-hmp.
> (https://gitlab.com/marcandre.lureau/qemu/-/tree/no-hmp)
> 
> Can we delay them?

I was expecting something like that, sure, no problem.
> 
> fwiw, I picked Monitor *mon, MonitorHMP *hmp. I didn't touch MonitorQMP*.
> 

Are you OK I merge patches 1-16 (now all reviewed) in my next
misc PR?
I'd like to put #19 and #22 also, which are both HMP and removing
the "monitor/monitor-internal.h" use out of monitor/ is a good
cleanup IMHO. If you agree do you mind reviewing them, then I'll
update the thread mentioning the queued patches.

