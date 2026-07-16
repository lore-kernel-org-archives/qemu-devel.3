Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201B3C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQC6-0005Y0-Qm; Thu, 16 Jul 2026 13:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkQC5-0005Xb-8v
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:48:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkQBw-0005b7-Sh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:48:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSkkD3395516
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Z2VZqfIHb19VZ/Cq0V83D/zeqEgjSsVM7xES1oGVo4=; b=Sw2oW5tGURqHU5eb
 zuJYY4BDRzhED2xW4RIRGVLB21LReRD/m9ZQNmnkNBehX9PnYACjholTYWDrLNww
 fWdrBIXAlpKrjOd2EtbYDFESsJbN6937XE3z+GS2BmKbL4HvW18D17yUlhbA2fSb
 oXmvDyFhO2NVMX+nBSeVDyQMq/2VunNyASyMYWl9JiMN3NTqZ2OKP3sqPWo0EKyn
 okHEZrWZ6l36xHrtP7Sizmoc/FNHn8+36nUxSuDCExyUh08CC5IFdSe7T9ezUiw9
 AjRO/77P8NBGA7weg4MUnZprqf6qruK7Q7fbBfgcDcS7PdrTbukaiXm5xevXChPA
 Qt7t7A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19cfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:48:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so5928304a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784224089; x=1784828889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Z2VZqfIHb19VZ/Cq0V83D/zeqEgjSsVM7xES1oGVo4=;
 b=E1XAOpQHhSZV9Crb98Ka6SAg5I2AZ3Fqq/vzYhzVaQG6ip+biBkeo6+7326/HpdZtA
 JLq/v5g0/dRxsqiPEsKkDyeHXpGP/b6SDTlv0ovHsXAjB0962p+fWC+8lzsVnPwUnK+6
 ATTjwVm+S03brft+eqKTL4ZkH9xidxm9M3GUaAzbpl0JX/qh/cYbiApmYF0f7b3VHCmB
 2CebKo4iFFsOFsIAyFkTevWI0ir0Xjh1Q4JhpQc1jONyzP1MSSvqFqIjK2vDjHpg4PQM
 U7KvbAZnxVzPJ4O99s9mg/sLrdmlOCZgNdyAdh+k9RLSRfq30bPqy195lfQCehMRPYfM
 5vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784224089; x=1784828889;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Z2VZqfIHb19VZ/Cq0V83D/zeqEgjSsVM7xES1oGVo4=;
 b=ZTvTQAQ1VpA8zpe8Xx26ssaFNJUM1R7HY7mZMCB3+o7fP6LJDwxjj/PphD5PfEu5lk
 Hp+EJV8uQGQ2OYnv7F5KcJ8cq8vEh8oYnO3jm8nrVj95ITRGogOoPsQoF59JzORfZnQt
 3DNZR0MXLkzoQ0mIjNrK0wvPqPasoJhb2ufKT3PFu18y3bgQYnJ81F/e04glnhMcNb9X
 BKXEJuKq/ZK+fBe6Ehe5YHYcZNqXG1W4DvI4hgSsr5w3yGm6DhElTviELbceQFZCql4Q
 eJz9D2zPpr1QVOWzBCuIT3v2QGZQAxyxY92Q3LDCzrkMhfmLUCZMc3ktDiXykV2ASmwq
 uQxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJf0BQhG9gAr+ThlPw/JfaUTbL7/OrT9K6w0bEI7jjYvHa0NPo1Y3IaJnbVbosZ55R3WTWM8GY3iq3@nongnu.org
X-Gm-Message-State: AOJu0YyfnFK/oJADejUXS7PGqbLGpjZNihMaxvki2imu/x+yWTZ7Qwd3
 AEiDQfBbHTHMVJuO2eGsuoqJGV20WfaJTU4lwDTdKBEkB01G2X3KkVmeEcVNrMdWk2UKQSl37pk
 qZmgd6j9SliJ62obJpm5BfbvlQsLV1dF6WTSj68TKNnZ81NvR4Ku+myVbTA==
X-Gm-Gg: AfdE7cmWU1fjSiishRG+ke3rhh/2dSif2nvvSt6siE60WDn060PJIPo/7gRuzfY9hEf
 WrJpVzwSu4RVlKtmZ5iClBzoCpWQd0MAzzbqPy3ULrmK3cCJdzwokRnt2LewXpBI2beefLHhUiE
 YXTXyTcbzjyN2OZA8dUEpfQe3Q5SK7EVXT8LF8xpv7ACuJdt33ZoWhtnD0GHP8XH7WyDmFlCrX5
 AhLEVrE/s9JagAdejp7+5WLCfjeB5tMolfKSEYq+RvoBgfM4SlZzz86+bdcvD2Bu40xik81bLUz
 4C6quqhmLM184AaqCp7+OvcODOvpQgiMaL38IKTF04wLkQpmvopqSuqv2JsVuGxJrWNQAbix8FW
 Kjnh6cwiIUHUof0FJ6I37ZTPqtMbddEdYpKjtZiXiOtHjWRXtl4yeGsJwNluUjhdFCOUN
X-Received: by 2002:a05:6a20:4308:b0:3c3:67e9:660d with SMTP id
 adf61e73a8af0-3c36c3b67bdmr8887145637.60.1784224089469; 
 Thu, 16 Jul 2026 10:48:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:4308:b0:3c3:67e9:660d with SMTP id
 adf61e73a8af0-3c36c3b67bdmr8887108637.60.1784224088815; 
 Thu, 16 Jul 2026 10:48:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6e9edfsm13713796eec.28.2026.07.16.10.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 10:48:08 -0700 (PDT)
Message-ID: <19f82cfa-c7c3-46ef-95d3-c8c26f0dacb6@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/docker: ensure container command is probed at
 most once
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260716102515.1503404-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716102515.1503404-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a59195a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VMQfhjUgHwDC8tgg_nwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MiBTYWx0ZWRfX4h2NBu/38UjM
 D+sEVLs82XmJXqURqyAdl4FC6SosL1KUpK4/XF+fh8gv2H4AIs1mm6ORUeG1rl2OHNqD3tKN83R
 67xET02suH32yFUvYqZ7vnqhEchPCVKUCPao/lhoD3+sJV0965HE+02vwyxdbqFRkzepKkV/ljP
 14BGjDHIFm2Ffz8MnKCkD6DLdMsOmFxLKh9R98c51AWPziH2NZSOGtCtRY7ycsOvmgKIE+H3sGd
 Zp6eVKqpBdIsyMNgSyYWxoDKcwSlQjotpjATYqhVMbjLTALDfqb4sB/kxJyxSiPJfMDLsm1NEDT
 EEfNl0hgqWKdw5kNW5ninGYFpattDnJckLCIiPyZsL8YIND6BKHLrwPelMH0J0dYsP83j6GTV57
 IPX/bNHWLJhCexkmQU6fC2tCYRo7Rg2CJhRtKAV2pt4XDQmg6o0nGus1h6nKKe44CTxS9Kd4FHe
 Rfv9LnPBaCQHEi4NsCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MiBTYWx0ZWRfXyOOH0oCHhv1D
 825FTVWWU74N3ndXAPSqQRoh8vcHm7NuMhDXrzWNknSsxXS+Pnmfi6C2WMDQPMjvQ9CQvNNkAgZ
 hWtVt8FZMWDm3V58YZcP+6DwyOd70/o=
X-Proofpoint-GUID: l7ykp6a6ZpjvinyrSs1pXMT9vsOe8kCO
X-Proofpoint-ORIG-GUID: l7ykp6a6ZpjvinyrSs1pXMT9vsOe8kCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/16/2026 3:25 AM, Daniel P. Berrangé wrote:
> The '--engine' arg accepts either 'podman' or 'docker', which is
> not sufficiently granular to map directly to a command. This
> means that  docker.py still has to then probe the exact command
> to use.
> 
> Meanwhile the 'probe' command prints out the full command to use
> but this cannot be passed back to docker.py to avoid probing
> again, so the caching is only useful in the few case where we
> run a container directly bypassing docker.py.
> 
> Address this by replacing --engine with --command for docker.py.
> 
> This in turn requires the --container-engine configure arg to be
> replaced with --container-command.
> 
> With these changes the container command is probed at most once
> during configure and never again, while running in an unconfigured
> tree will still probe on demand.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> In v3:
> 
>  - Avoid bashism when testing probe result
> 
>  configure                     | 25 +++++++------
>  tests/docker/Makefile.include | 13 ++++---
>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>  3 files changed, 40 insertions(+), 65 deletions(-)
> 

Thanks for the update, it's working fine now.
Also, docker.py run command is now fast again when given --command argument.

Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll pull this today.

Regards,
Pierrick

