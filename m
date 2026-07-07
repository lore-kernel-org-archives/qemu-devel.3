Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2357C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Id-0004wz-16; Tue, 07 Jul 2026 09:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Ia-0004fq-SH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:57:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6IZ-0000Jf-DJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:57:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8qju3768479
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XbQmfUPbDeiiKIAiqY/LG68gAdMRWI1U39cpYvkzZ78=; b=JZ4um1dVygcTRr45
 ucsYeOlGcQLOFmNyTvYkdV5V3pY5uYz9gLtHLAUq7Pm5qKkJ4kEwTruW8G4GG27I
 gwWK3Dvj23jclJxk9eQZh2bb40sEO6Cb881t9jXk3RNxWKSwrq/I470484sEElgC
 kuVDMmfbQJdiANlW51/rDQW5WCGYrNOA49jNvFJYNkNbhVyiFsn3b7OzH94Lf2B1
 WYy/qNA6o9WkzBQ82XKOENzVxjcx22jb7IExJYyE1ojeWEe35u/XsdOuhvy8z//Y
 MN9LUozamI4NBJaumQCWw56l/p5IzH9DcUai+xe5+Fl0jHHwQaDpAIF+TX6T4RMr
 jwYv6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj7arcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:57:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c19493ac2so40066161cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783432638; x=1784037438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XbQmfUPbDeiiKIAiqY/LG68gAdMRWI1U39cpYvkzZ78=;
 b=HgwyGITVLRL1+c8m8/5dPVXsKU2XcwZen9g13aXgp021lBPKBINLbpDaYLyNTZdlX2
 2h3vD0z5EcGGc9TF70iK26ieBlji8i+vecjyooXx5F5imVcBGSTkTO59eLcdro1AHcJ3
 y4mOZNQpt9mLwmoumMWBSTkKwAymX3yhjbOZr88KZz2Uo9O1ef6ORP7E1TwWJR7XXlEn
 Kn0cLGASJoXhb+cL7SMMFYvi5e7RR5vFCUoDkdDcvf+CbMyyfUpOTv1YSqSBXJtMGRqn
 CucuI+wAbWC27G2ZIUzYQvv3RNb5MyxvVyoc6eJ7C8z+wVv6NCWBeerVmo/ON8WtHyh3
 Emsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432638; x=1784037438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XbQmfUPbDeiiKIAiqY/LG68gAdMRWI1U39cpYvkzZ78=;
 b=oN3/bxHY7jtqndJDZOX1C31ofnbc2S0Jz39qYCZXPhipZH2Tci+FnXtdGSFOoV2Nq5
 2XR0CB8dF71gWc4hW8KYTmPZBOEAktRwbhSyddgqrPs2E4SJDS8yY32oP0tidARHUgFx
 C9qqURMR011+PnjNHx91J0rXoc+sKw+eWD4KY/i5herUpJs15rw9k3AJIo4UXt8tq+06
 xRiFxXqFkzGOWBI6fzTGmjAOV1hpB09iKLnBs3otocNww1WUz+pYPc/VVLEWyTLy8x0x
 7ARJrGRBdonrYSSBamKaA2q4P9QdLtxIN7YHXzdPZlFG1uy5DdCCkFFgPPG1+1MbYEb8
 CS7g==
X-Gm-Message-State: AOJu0YyYnYaYuLhF7K9sa7X5C73ffga/XV9zwwrUN6BVdB6V35/LuQCm
 V9l/lyyV9REALYELD+GR0B9aNtO6gGfrW0kfztYoojPFMeQBncUMDckv4rpdNjsz/k9OdjZ9Nyt
 eptfQg9aMA51m/N/j2lef8KiwXMWZ1O8mBH2/+XiUWOj/5SseslWvDy5yu+5nde2IaA==
X-Gm-Gg: AfdE7ckmAOocMM8am+/lbWiZRoEMjeYu3JZx9+Uh9Pg4V85Wv9O+4EW3jPm7KfQdk/4
 a+2ZfQRuanytAYdB7CO2PfcjNwWQwZ902WSoTifSBzMv1soOkpDx1BLgOptSGdZuR2BuQa/IZGV
 e6pq4VPfxse8VwDzp3dTWO9439zWdNMkHLKDHCboAkDj35TMRSsdc6jh8Mg8g7ldYpzT9FJvzmV
 7C2AbI49UMuomn8I8Gy+enVtpd2hVacOG6hUfpROy0kp1LJX3Ie9M6MUvprBm4Fn6nuN1MlJmX5
 iUo07908u3udk1n4i7o/g53Uxbm5ssSq+XASG9lAqGO/NhP3lCJqED39jnXMLLoyw0zlT6+QKy3
 /engIlMWi1WxwW/eIaupbnXmqm3pZwflYL7FVMDRDycUUli0c0iRIRJP+3G4uZg==
X-Received: by 2002:a05:622a:4d0a:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-51c748ecdecmr59102041cf.48.1783432637701; 
 Tue, 07 Jul 2026 06:57:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4d0a:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-51c748ecdecmr59101651cf.48.1783432637258; 
 Tue, 07 Jul 2026 06:57:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad84483csm148991566b.17.2026.07.07.06.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 06:57:16 -0700 (PDT)
Message-ID: <0605b7ab-9d82-455b-af3f-d136be23a9c3@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 15:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Chao Liu's email address
Content-Language: en-US
To: Chao Liu <chao.liu@processmission.com>, alistair.francis@wdc.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, kai.liu@processmission.com, 
 bin.meng@processmission.com
References: <20260707132701.71164-1-chao.liu@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707132701.71164-1-chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C2exaT3RFCN0O6b_53DVOQegsPadMByy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfX8/BlxoLiAqRL
 QTHrGVFUhhkriLqSUO9eOgtptaNvt5XOKKnPClcC7iNkA3gkNdzRDx5x9nsY1WRZfYTHNUC00N0
 egx4fqQWOBWArX8jSDsLo37N4RvVALv03ipxseor9i8Qncx9igbeCsyxuURkh6ao/nOWSmAqq7h
 ocaaSkFR9HQ8wc/0bwbvnN5aTf+1knVzVT5XT3JwdR9B+60KctZVMU1U3wyRVc7cg3QBOubpRcS
 TRt7fkdtIdUAm+OIz2v75JxRmCwz6KCEfc0mXjUwhjX92Rokgt+9lMJlnq4v55155HksQ/NL3Cp
 bdDSmk5ZN0/XJ9oxecyKwpExzUHRw4H1QQ+W2P3sgcCxZsGvZocmRBZxAGQLSuFTKjcV6fy9Lv1
 zP1AXvRnISCPnqQiwO5De08Oi6FbiPRmwRf/EZKuAP07CXW0JZQvFvIGYxw/xQx3Opg1rjLha5c
 M223xsPJ03pTB23tcGQ==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4d05be cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=wBMkrUD_mxg2Je2A1FsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfX3r6ifu5ChG70
 WUB/eQUTgnydcLqBn0AOodXKeJOd3FtLSm9p5Vap1GgW679ie53pnHjPCK++2SkVKIfZWfQSRr3
 0HrlhCuw3bxT0xI6ebkltfZRvRI+JUo=
X-Proofpoint-GUID: C2exaT3RFCN0O6b_53DVOQegsPadMByy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070136
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

On 7/7/26 15:27, Chao Liu wrote:
> I joined Process Mission over a month ago and have verified that sending
> patches from my new email address works as expected.
> 
> Update my MAINTAINERS entries to use the new address for future upstream
> contributions.
> 
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Cool :)


