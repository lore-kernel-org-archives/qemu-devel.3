Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B917CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLSw-0000Pv-NB; Tue, 19 May 2026 10:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLSu-0000PY-Q2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:30:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLSq-0004PG-Gy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:30:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9vCOb1054939
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GhkGPFKhBOPBQI9Ph4UFGOJvDEoMpv46c55u6e5bQu4=; b=Saie5QiGfMfwYFBB
 RH1TjmAQLA73bwuQ/dF2qd4y9SjaT2SvRFzSpnBL1ne0k7O3GT3Q/qnkzX+ccBJ9
 JC3jedz8KF0sSDaMnayy3TeTK0Wj9yUD943tiXidhwhqD9yeXLwbXhplmrpLE3vY
 FjyEuFi9bFNmm1E9pewChMRE4HssJsR1/EZtuMV3tS2dKPKSmFYY/3yABRpAk8wv
 5pnZvpKHSlj8AN42FnwOxoRcyIjhIDZ1o0eKnjQ3WdDZXAk8YkgigI+Jl3/+Upkr
 2AnbNgglxmieME2ArkzJfsWe+Do0cAobVwQyAazb4xsBH9r/+1aqFPySdygYMrLR
 WYCj9A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8npas2gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:30:30 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135f2aa4742so339265c88.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201030; x=1779805830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhkGPFKhBOPBQI9Ph4UFGOJvDEoMpv46c55u6e5bQu4=;
 b=dA0CnapDPgdwEZePVCh1R1KxCEmEFSiaAqnzAAZTmZVZrNsFcjLPWs8KV9Unleq31/
 +cBUX8x8gaoLb5ohNdyiBgC1ARSmGu1afQU+cEk2Skc7SpSedlqhnFRdXHZW1SaWZ5Z9
 hf80g34WoPE+A7mhqokdZrxhGbhXFjVY4rMNWxjbyqks6DH6F3JXpuJBVMCE/kV8cY8F
 imqtL/pc+aLbILppRRloRWSEhjKiMUSGzOOScleQsvgFhCVNMDEBV3nrG0+XTPkWWBXv
 hG2njn5wSyOozgCNlyszwRXLgnhZAFD856WyTT47p+oQibhi/BBKnjcQ+vZRmGU7ryvh
 EMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201030; x=1779805830;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhkGPFKhBOPBQI9Ph4UFGOJvDEoMpv46c55u6e5bQu4=;
 b=noPLTEOk4NsUtzUsOvqYUylJK+8kFXj4LhsLgnpNg7ZiAYXjx3ffGxEZCYzbJ/Qvi1
 WGYfVdbvW5rFbN4rDObuauQYuV/Dp1eKLMrjPvH6SWzbShjf1hQTQx12tS3EZ7BzA/TO
 76WSLg3xFn8f53Yum3nRt8VLGe7mCqwOTg01HNkyD/A9j/KjI1dGmFUrc6glmN0JIUdw
 ojWXmUOAT5IRWxKGhtLHwNuozbX9Ifq9S2BGP43237coyuKlix/EawIq7lxFssdv8f85
 pZWpL5Mmk30eyb+i/jdaxG5NZyirNvsCjwo+CwXfytzu2+/yU3k2UjGQ+gUYT83KsxZ4
 /TfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LaqA2Jr8/A3RlyL3GZbAushRnKwkbmASzmhrVXO7Gp7kjfVHQHa39FnE2B9mjM3ktvRnBUUEQ/XT3@nongnu.org
X-Gm-Message-State: AOJu0YyzJ0R7Lf7ftQz79+t1IPKEjWo8weFq+L/CVI7Ue8Z8zzm9Owep
 1K+60mAnNk6ZZWh+rD0S4HMw3G0D7Av5hBI0QRiqcEEImI9zpPXXsDN2ibOQVNToYalNy1Fd0Ob
 y7hvo3sIN7p581hbyQIbxvREL5eHj4f5jUr9NomwV7sCMU3JMnjWdzbcz8w==
X-Gm-Gg: Acq92OEesURsYmAIWngy6y+uzJ0YYqnXcpa/8e1+P9rC6bvw8ZuVyJ/3xgkZ6yEBpRH
 rSTs+9YH0TZoxe1QM5FHfjSLlbXWIwKcZHl63Hv7sAayab/uEPctrH45Mu7zsD+hBKSiZzKrIeq
 v75WljEDl+tRuyqEGveuQhrwMUY6iZhcILjeYO50DlzTy7p4LS9W4VaKTG5pw7oYSAIf5hCZd0x
 eZMG592Ts2SuC+hKLZZS7V/DOzIUrI+Q3UYnoaw+N5SwvS++NCUuQgaQJr6loGkxShGc8liYJUZ
 qdenKsi9OaFfdrbybQUQtiM2Qo3FwLXEntrjpNW/u1nTxEDYYiAdUDhPpUJq/1mwjsh/pXAGjTt
 v6BxSCM1eSqLAmsa1L28y0H2tEOjeb3FIT17lJhs5T+JK4cQLd0Ai6QQ=
X-Received: by 2002:a05:7022:41a7:b0:130:6904:8c17 with SMTP id
 a92af1059eb24-1350451e28dmr8510376c88.18.1779201029701; 
 Tue, 19 May 2026 07:30:29 -0700 (PDT)
X-Received: by 2002:a05:7022:41a7:b0:130:6904:8c17 with SMTP id
 a92af1059eb24-1350451e28dmr8510344c88.18.1779201029071; 
 Tue, 19 May 2026 07:30:29 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2351c3sm25281395c88.11.2026.05.19.07.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:30:28 -0700 (PDT)
Message-ID: <1cf3fd07-b0a5-4860-a501-c708c4dbe49b@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:30:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] MAINTAINERS: Fix
 docker/dockerfiles/debian-hexagon-cross.docker path
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfXwr7IR7JquOuD
 u/EJtwcPTef/xT6CO31xSBzbbN9vbEPWxgIwqKfy1/kPptfd+Nc7CAx4JZbt6F3kkcuCpN17SgH
 Q02rogBrNYbLs96q+bU31/EbzsnvKLzWgHtBssuTR7eYFqeM+wVbm2zr4bjaFM9LCPFCkH3ZcmH
 6Ulu+5Ai+PI9pIlfz4cudt5+mW8hoR0xmFpnyKRhmU/o45I29pLCpIL1Hc9EXPPiGiGc0v+lsjy
 aSBaCy5JucIYDKs1yBcZomQT7HNF1sJyU2UZ73a6ulfXimWmzZEYO+4dOtfcxKjgmeRb25mUbIS
 G1ddzuYas/2AkxKEwNIY6TH4S4oghydwXsfEq9XpBf0nQ1N3FpxwxtFMkMnFmpEwA91mKGpjJaG
 rn/25wwcgiNaNwN2XRc+pn1APTUQ2RFXWYMt+rgLlmQqMNOVg/dDdKbv/8zTKIt8vO6IjpuMsp/
 FPKQG+yj7kjk6164Z6w==
X-Authority-Analysis: v=2.4 cv=NrjhtcdJ c=1 sm=1 tr=0 ts=6a0c7406 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1uY1wWxxPgQSxTV79psA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: M4qTgY9yu3CAQHwViZnR4--GfpvsIcCh
X-Proofpoint-ORIG-GUID: M4qTgY9yu3CAQHwViZnR4--GfpvsIcCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190143
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

On 5/18/2026 5:22 AM, Philippe Mathieu-Daudé wrote:
> Fixes: afbdf0a44ea ("docker: Add Hexagon image")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I'm surprised we don't have an automated check (checkpatch?) to entries
in MAINTAINERS that don't exist. Should we add one?

cat MAINTAINERS |
grep ^F: |
sed -e 's/F: //' |
while read entry; do ls $entry > /dev/null; done

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

