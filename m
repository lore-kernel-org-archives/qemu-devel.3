Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4DECD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpL5-0008FL-8j; Tue, 12 May 2026 11:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpL3-00088n-5y
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:48:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpL1-0002Ra-B2
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:48:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CC4PwK3320941
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3uQgeM/nqVXsGLqYFKkJhZGuBXiqyTJdtHptH0BGH+g=; b=N/qvU7EmKISjQ7nA
 B5fBsOehGrH2YeY2rsv8O+lE1hvX01aDnVgu0lhni29OQYVT91/9aE7eDD53vX1Z
 JK90U2yyVe4DQOx2e3ZphNls6PUIkYccBb2GV6SelLuJXf62OBkV60IIm2Wc0bcV
 VTCUa28rPdXN1i3Vm4UqpuiT41NRezoSQsCcNJuRSxg1X+z7BAe47t8QlNs08WIb
 SP+V2HWspAE+z6mI/O8tLNT1TYcu0fMyPJhDTp0Vrv9wt1y+x1byDw0EtejBXjyy
 LuCOuAqw6EP8UmlXC0zg1LTfM9ku3vreD6MTfaTOHpjGHBFwiqQSw11rqMcSrDBJ
 EGWLgQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1ru3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:48:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso4437132eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600881; x=1779205681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3uQgeM/nqVXsGLqYFKkJhZGuBXiqyTJdtHptH0BGH+g=;
 b=KtigYJG0+/IuPylX6vyuwREjkMLW7lpkWi/QIED/TKEE0moKs39nRpCH3tv9YmnD+t
 /gWZJmWK2DA1w135A9bY/8zZjHP5LQSDm5DyTZ4EF30DAlKZeCJokDv+dLW52dY+vvqT
 3lKB7YYVb0gn4FBb5xZSZSFYYy+zDjpRHL3Xn7ly0O6Y+VohG24pedDdAVe3lOCFGHe7
 gSYs7s4e7F/RxRMQlU5vUL4/z4p6GTRwKyfKmYPUzGYePB/XJuFi9SXr7E5z+bLy1S6R
 duBYkWAfgGobQD66LIP/z8vjIDOcCH6xku840QwlB5oIRMQH6VVeJ9OSs1o4V0knq+4z
 61uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600881; x=1779205681;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uQgeM/nqVXsGLqYFKkJhZGuBXiqyTJdtHptH0BGH+g=;
 b=gVHcv0CZTV7RI/GiH71skxg+4cZugg7Zce++8WKbksFcSnmB07QJtJqyEj25fXss/1
 trW6e2BtyR8Qws7nnDYn9TtwPSrWcan3uj91DrfZAYZWKpXk5ivFK/ul0cuv8Hnv9vC9
 9mNEFFjb9mm0AizKnEkdNEDdquh4/X+biPbnhB3jejYLZARXba59fmW6HUO8E9b7a1Bu
 5DRZHEmbL7eDZXKxGFE/nmXhjDXY2kYAM1dzcVhq5h8I1MFKM1eNe65deTVU3bhBgVzp
 jqDkDsCycckTE5NLBjwddsCD18+ZD/otHqSBcSniXmzzlmmA0oIIRMwsgdYjfxCFJarO
 jT0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FR+Uh8uHJxfagQH2EitAi/3oOAfNt1LWcsR2W7wNI3oazRZ/xoUfHQI1HNuSL2VHirJtLoLsLqGFt@nongnu.org
X-Gm-Message-State: AOJu0YzNJFTNetmoRX/95U5W7xnUncN/NMuxtyQeabGDOOoEQq7qbpTu
 eCbp9QQYKy2c/aKugUD57iemWB2iRp2V14XQR9b2IPUT/qaU2LnkDMdpnx5oUTDe753X2suJLf+
 CBgmW5udDqLvAeLRl5rG1T3MMMg1qdya+Hn0b2rnMJfuIxoYM1Jc7u8fvHngLO1oulYYv
X-Gm-Gg: Acq92OG5oe7inbH3m+uznutlVbtuhbGHoaR2ObX63rk/U+PEzcpcIaOinxeBaDd1LsE
 gIo0+zqJS7nZhz9Y5fY2zEc7QlCi14KM1uAokioqGZgn9jwSOgTWyvvNq5fehtIeRio7pQVg9FW
 a6nVmP5452HAXI6Dp3Tbm3yAIJEYBpiR4k7cxJgKrOordAKxOc8OnC21aQbI12szSZtz7Ovq0Wq
 eAnbGZ8DMqAeRrjtYNKw652zU6kJlLXk96+ViDZz7Dz4HBrnQ+uIqP0xu1iDFrkr/gMnpwhAuTr
 XLOaXJpQoVmbv6/bSGHh5Hbg3CHfGcXZqmi7NmSfQaqpsKrnwr7VDCYwUgIWzroETN3B7x/Dowh
 FjTp18Y5dsOzG+2j4IdNZ5CHSWpCbIiJAzx7UvoL+xjNl1SrzUeGIhef61O5fCZ27mXkl2CagaQ
 BgsbGP48Uk3oQR/g==
X-Received: by 2002:a05:7300:148a:b0:2d9:3616:d897 with SMTP id
 5a478bee46e88-2fb4d68f9e6mr8483069eec.22.1778600880859; 
 Tue, 12 May 2026 08:48:00 -0700 (PDT)
X-Received: by 2002:a05:7300:148a:b0:2d9:3616:d897 with SMTP id
 5a478bee46e88-2fb4d68f9e6mr8483027eec.22.1778600880272; 
 Tue, 12 May 2026 08:48:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm22934874eec.23.2026.05.12.08.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:47:59 -0700 (PDT)
Message-ID: <bbb5e7e2-e7ac-4af4-bfd1-59c83196f14b@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:47:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] gitlab: remove I/O tests from build-tcg-disabled job
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-17-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uC0xdLziiYAfDBMSRYdXCBVqrEuV4Ijz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NCBTYWx0ZWRfXwXcucbvweRBc
 5AGln2lItFl1fg/agoDZm0D4DUZLIZCMPQaQyBKLbXMQt74FrwSVe1hC1RPVKm44wYnfUEsgtv6
 oQiLmxA/4QWt3C/S7LFDI+yS4z3skpksD5km9GsloEOilK9qNBtj26hIYGg5r41cRBFHfbonmwv
 WjP+1IhC+kyFAy4//nRIi6VdW6SWofSduHYLjGJQFQ5K7iEIbLQkBOcl6PJ03P93kbDn45UT4RG
 k2M5QTyF+hkgO6KYCFg7KSHdV8cX1iMNwW27NHDzPp2s5pVrorVs2TClms1h7QF1obrwJ9dB36K
 s1wdWb7VSBgQhrpfMaR+PnDNTce0UFvvcKCUoTtVDpQpBs5KI8AjF//joK9cD4zqKbwW3pI0WPt
 FLlYAV5RdQ7qN10IAaAoupWgJh0YFCgP4q2htXnATnkAAOzv3zP3xWbxOKpP6sGGob66wJ5a20B
 6JqlA4Mpa5wel/XSjbg==
X-Proofpoint-ORIG-GUID: uC0xdLziiYAfDBMSRYdXCBVqrEuV4Ijz
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a034bb1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ALR5NVEir7OJCsLUjbAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120164
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

On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> Now that we have dedicated CI jobs for running I/O tests on each
> supported format/protocol, we no longer need to special case a
> run of a hand picked set of tests in the build-tcg-disabled job.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 9 ---------
>  1 file changed, 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

