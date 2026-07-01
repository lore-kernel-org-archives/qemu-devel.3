Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevfB-0004ZO-TZ; Wed, 01 Jul 2026 10:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wevf9-0004Yh-G7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:11:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wevf7-0005AF-LK
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:11:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8okK744654
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 14:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f9M6ffqp+O1C6cnUKTROzF6bcO3QKmoO+LrbijWPOhY=; b=Za54quXAY2bI/UYu
 wVCR4UDYMX6O0jiQVClIF+UD2szwFKD6vsizTT//2q7fVMVahKINdsnXaFk21FU/
 B7xSqJShV+m8eLhMO/7Sh799emeeSIJ08a5ZGs/t7ShnQI/8wsrNf8XSfmKJcTxa
 4FZXZtz7WX56Gi+5Xl2z8zfPKvuY+/k5cuxaWYFthVaVyXxIDQJ2B8lFZtm0q/AM
 jls45kgogE0pFAsYmDh63zItC7sFQFTtDxCQdnoSmLski7H3nw4fLXsc1gyO3aKJ
 eXc7/lj/nuRlXhcfKm1p7CkYhS3pak3y/AkIpjJ13r3SV7cRrxunfICK9O2CK5+d
 O/Y4yg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0thw8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 14:11:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-966c4d68d91so97651241.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782915091; x=1783519891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9M6ffqp+O1C6cnUKTROzF6bcO3QKmoO+LrbijWPOhY=;
 b=jeQbDBonN2dz3V9g8oNt/+vvFOarNOsZJ3WPoYjnjV9V0G2YcCR8diWdj+yQxBVOUE
 mPPopcRtXY+jop2dztj5YbhrE+5VLwyi1cdceaW1KtKtlpd8syEfQZt7LkF2Ajs//Gsm
 bvVAqgravEHa/z5BuRSt8pmo3Zhg2bqFVYIjoFbH6zhILWc+bjwniJUWS3bNVhblbdML
 8urkNKvVUrv3EneT9Ss9oC+kkbsOKLjohTa0bNc//sk2C0hVgjJM7EZ9Ti/IIAIjU9/w
 OHYUzkoCJ9eDceyuul7LSE/HxnVpcqJzxHrkkboKGlY68YMFixtA6bBAnye4shWo9WqW
 p2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915091; x=1783519891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9M6ffqp+O1C6cnUKTROzF6bcO3QKmoO+LrbijWPOhY=;
 b=VXuGgYH9rRU5S5NZ3AxOMIS6Sct0Uit5ltYnlBw5q5F1kTwXnAnEOGP/U43zDYZTaR
 WdTx+M0b0caGSHJJfc+/FOQfYgxq5I2YilIBCwJAiODyYsO1OUzhKqX1HUT/ChRqHK41
 VJfA1fPxkBB/aemF47UCHam0GBQqKjYRv4jmI6pOeoKOBoJDASJzeoY8scUlS6PQqC3/
 DgZtYShXBTnaZWIFWgnYx2a2XhZq+r+NAdoapSh3ZZWxut2hdFw1Mu/+7q+My2sFZUZm
 Du4rh1befyNdo5SjYlhfH3n2qwrWiFidMn0kWrjh5aFIdB5Qz0PfM0ws5KlCHmq9cwWs
 n4BQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOQCT9jCNignWwCoTlSC8P73MNJ/MOwso/2rqpT5+wDK7s8IG5YXSfOhpLGvco1ig1Biz4TITrzWyL@nongnu.org
X-Gm-Message-State: AOJu0Yy2uVVSbgQsVoMuHVi7DFuAUAogVFUOGvnmH08pGNgg5tIrNaTo
 GCdqklHHHeDhHHD24eIDzGX7lOFlM4wPvE19R49CurHaVbGJ5Z9hFzwTabD7CcwIDglz5p4asCK
 ouoUAN6SE0+Na4c7Ymxc5HC1tICfL7Hq2m+43L2ZW7KAPmK7bM/3A49gEKw==
X-Gm-Gg: AfdE7cnaGFCfUg2D03tdiJJbNeDfjYB3vDEDve25sUsx+TGqiPvMc6M/htcZ5UsB1U9
 jUwlSDMftijpDokYF7xMdhLtb2GKpD8NwlhCcWSEzu6GHea/i3ClXD5EoB9/DKoa+Yj1mADU11W
 okaznFgiKe2Qtgzl8AD9nKKumy2E4y1C/rxRieMxyl6LnNWQ3aMQ3DgB8MoPrN5AM+85UZoY/vs
 CprC/flgIZ1EjPf2CFKVIAZ1NUqz9wo30VUvaFgigZ65YvT5wMbcV4X6GFhF8O0zDY+RMiIljd8
 +sWk+X+9DCHnkyHHz5ET/A7h0LEDT4CtzTJE8+MNUta6fU2Yy/kJ/aSURR5oVBxltVLE8wkG/Gk
 itZXbKC7BCJi/7ldzSpAgM9702/4b4Ldn0NfxZWnr1YB4oozcI4yqozwArBn0vcOWSh4=
X-Received: by 2002:a05:6102:5093:b0:739:4470:d8 with SMTP id
 ada2fe7eead31-73daa581a0cmr724390137.26.1782915091354; 
 Wed, 01 Jul 2026 07:11:31 -0700 (PDT)
X-Received: by 2002:a05:6102:5093:b0:739:4470:d8 with SMTP id
 ada2fe7eead31-73daa581a0cmr724349137.26.1782915090841; 
 Wed, 01 Jul 2026 07:11:30 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12891741e8sm279416966b.55.2026.07.01.07.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 07:11:28 -0700 (PDT)
Message-ID: <99728d81-ab13-458e-b893-e0f4d8a7aa84@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 16:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/mshv: zero-init msr hvcall args
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>
References: <20260701134214.419806-1-magnuskulke@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701134214.419806-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Jonb0qiNkHZdbwNdC7xk4Nd6aohp2QeN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0OCBTYWx0ZWRfX4n2w8IejX//Q
 KruaZzFjpQhkU4jb+finf39XQncbPX02hvq5Z1XKeIW1+bfP5XVx+V2sM9KNMkYWxBxUPN5cgEH
 32G28BJjBdE/AlzcID2+Orof9VwgDLQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0OCBTYWx0ZWRfX7cT2Z4IUN7zI
 +QjhlhAkuhE5EL8K8bd3m3vlOlIxqCf2w7MZ6ZSNlxGcgyDnlmqyIoCA2heKerynCVEQOsCRzy0
 P+6FtjN1GIwj3NPQq5nkRGxbXVGwM4zOnWYHcswUHTcK+8ztrZFB7qR7SSTJc0PSlKfQDqBpkwz
 vFJn+/EI45ycZbGwzJPm1UZwerSupG3DZyvpfxUT0u95R3eSxEmiKcr6FZbIEEnaL/xhtxAljJR
 gi5ZGoBtIwq2np7ZPBt9oh6oGFK7q3D9X31usNLw/zNOJvIvzmBELr7T07Jjy6TuMhsqaxqL6iG
 EcprIaZxi68d/RDabe/fsveI+22ydrfAUc0yK7zOXmsjty2YcWsyzsPzyaNZ0P+dB0YqWfMoyl/
 n1EPndRe6cgkd0u9MsqIuXnv5fyT24iZcMVk9YSXstf12SN1YI6p672hAQRtMPIpUV0n5wFMblj
 Cl88A1K2PP46qOttXkQ==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a452013 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=yMhMjlubAAAA:8 a=EUspDBNiAAAA:8 a=gMQFvG_s1_ppK5Sky0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: Jonb0qiNkHZdbwNdC7xk4Nd6aohp2QeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010148
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

On 1/7/26 15:42, Magnus Kulke wrote:
> In the current code we leave the argument arrays for the get/set hvcall
> unitialized, setting only individual fields. some fields will be
> populated during the hvcall, but in any case the arg arrays will contain
> unitialized data (e.g. in reserved fields), to which static analysis
> objects to.
> 
> Fixes: c38eb12c85
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   target/i386/mshv/msr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index 8c220a9942..a35415ed9d 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -326,7 +326,7 @@ int mshv_get_msrs(CPUState *cpu)
>   {
>       int ret = 0;
>       size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
> -    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
> +    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] = { 0 };

Matter of style, '{ }' is clearer. Otherwise this can be read as
"uint32_t name is explicitly set to 0, hv_register_value value is
implicitly zeroed". Anyway nitpicking, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>       size_t i, j;
>       uint32_t name;
>   
> @@ -386,7 +386,7 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
>   int mshv_set_msrs(const CPUState *cpu)
>   {
>       size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
> -    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
> +    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] = { 0 };
>       int ret;
>       size_t i, j;
>   


