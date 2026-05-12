Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D2ACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpBd-0002sS-0s; Tue, 12 May 2026 11:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpBT-0002q3-49
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:38:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpBP-0001x9-62
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:38:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CChAbm1410273
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHeoAaOSqCjdtNu/nGKoMX0c1S+d6iHw+afoa2ZsaEc=; b=f3EBVfoUOcnDeoUH
 AGDmvXsd1VJBjeYrufF1ZWwRfh247hTYzI7hOilRmePRoqHT2mQy1J8OcNJTva/d
 MkAaXJXBdm7o57GZsYdql/SExoXDG8wuleXBtKYa4T59p7k8YSg9UJW9vId4wFeu
 dQ4GBnFzfForpgelw632jNd4w7TLVYOVivaXgo1JmuTuqSAHjVmwhJxVlaH2imvt
 LGkW9qLPRvgb2iEF115ece4OPhogUpq9UUMIN7CCrzjuitlXNQ2rOOL6jtWxgXo3
 pvS9JEmPmAv/bHdzKCx1HA7rMAy/IaPJ3t86mi6vrUjikxVQDtWQ6GNeV6D0UbUZ
 Hj41Cg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f30nmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:38:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso7713578eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600281; x=1779205081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QHeoAaOSqCjdtNu/nGKoMX0c1S+d6iHw+afoa2ZsaEc=;
 b=PBmj/y3dL80Pzgs2afyPYEUOBGFaFGtI4QSZVRvYcJycOCQb/dk+clz79FiRNNhfVz
 RFaQJJ6ir4jmMwSHBVlkTyvEoUhQCn+k4FU6Oq5I0J5tKUaqJnJrKhLUZBjkdaQE0hs5
 imVBYd0FxfP2v5gfrkoL1+NFZ2XPHooEqmbuaC534yQhB/aqa8hdTqED449IcYBDrlnV
 5Cc8jxASVYDVWxDPhWGmhhpVvKtbj+rmSGm1SdJve//8YskKDA1BnFbgOCV2EKLQPryW
 l791yf11WruPq/nylmah8FbIGDbt3BWwFHF+EH9n3cmm8yJof8zEmlLDZ3h4+dp1uBn7
 qnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600281; x=1779205081;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHeoAaOSqCjdtNu/nGKoMX0c1S+d6iHw+afoa2ZsaEc=;
 b=T+I2P3RYZBnve36AECkkx27qHD07iC5m7t0f4o4IcoZefTG2ozBQQzFPLg5aODThQi
 esJmBnH39/nCH+pN4W9RitykHypYUd7D/Xy7sdk3gIUUkT8uydQwikQADTeaSsYNxkTB
 xb6qKqWOKegzOF+KbWPq6YHtr6o4VHkzceGEPS43CAcgndr6D1ffZcMXDrjrIEqdeFFL
 39olCqkdGGzlK9cImhw0RLUln5PO1FNknMuugaC1ztdLiBRnWvDxs3eTwcbJVkZldbZH
 QdAGQQ0V13K7rNi3vb4dhxwgyaOD1dOeMue/ErhbaC7J++f126640CU3kSuhXF1YnqkG
 SjUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UDUxQrBANyE/+owgn8C13SWSZ0CtFR9dr/pVQmSx+t+c4y4gcfcg0kFewfKMA2DwK031yWRY8K/4E@nongnu.org
X-Gm-Message-State: AOJu0YyYpLw023QdXgib5RJrkWEB5rrtG4PkHr5f6N14ADaFieJwpoqA
 U+IcDIG5l/WMFkR3x3wpKkOwCyYehlC4cerdn/Gjm0HuL+ckznWGIVDLSUaaTLJDPh+i4GU5cJZ
 cLas79/2nz52TldKc5AoEjzrlRT0HX2TbBa1nLwq+jwrEPNwZsynXkElwhg==
X-Gm-Gg: Acq92OG2KGAlQlLaA5YnjfCaTpyPiRte0cv68eIum+79me016jmvflomTsOJX230kde
 AWnqIN0Ex061q2ThId0ErWuvACwdFLfjW/lCR4cEzzGr6FOgGrbFdxgsrebMuFXFFZSeXvdBU7v
 Vye5qtnEfYm0Mo0YhwIPFbEw6m0Msc85roUrLw1/yNklh8iG7fmrFeLXw9UGoabZZM+oz9OsSZL
 zaM0vtpODTokRu/kcr62wX5l4a1HkqQmMHle/DZW5cLNCoNT3Orsdzuoy1r9JPU2GwielsbxqYQ
 /AflS6AaY1cWni2MjjkF8q4fi0u2ipfW5gdAyTwWLjJvWej5+UO9fPU+FQD44J1XepDxCM0KsaI
 fCpsMFeH5JipJp71G6P4thH6HRC88pGeIPwnRgewCUtvlRCfKRM7WfbC9F7fCvb6vS+4ckMtCwF
 dMXhqj1DoaoUQo0w==
X-Received: by 2002:a05:7300:572a:b0:2df:5715:82be with SMTP id
 5a478bee46e88-2fb3dbf97e3mr7166252eec.2.1778600281375; 
 Tue, 12 May 2026 08:38:01 -0700 (PDT)
X-Received: by 2002:a05:7300:572a:b0:2df:5715:82be with SMTP id
 5a478bee46e88-2fb3dbf97e3mr7166211eec.2.1778600280738; 
 Tue, 12 May 2026 08:38:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8860ce1bfsm18928718eec.9.2026.05.12.08.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:38:00 -0700 (PDT)
Message-ID: <8ef13bfa-126d-4562-8cd6-35bab48a5068@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:37:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] python: bump qemu.qmp to v0.0.6
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-2-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qG5xuOUBMnAjx2MDC7rvjUKQU-hdSNz-
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a03495a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DpzXOLuaSw-WtlSWPbEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2MyBTYWx0ZWRfX+/D61usV1OVQ
 2y9olBxspLXQo2ZUGHLWGBV4pRO/yCDmhgjkBujr7eDQA/AHjWYiTFgFLANQ5l6BrJ5cDX2WBqN
 quhgxQyHMkhtyD6QShDfHvd9JBTT9cHsJLTftxfJwyYyU5tsrzu4JG1CUcIPXSIyIv9qQThRY7Y
 fQ/0zsV14ceS0pND7C05XG9K8/pTe/BIiQy4XMgUbjJIt5PpGXpg6MSPiLTHp8UjCwixE0kFbfN
 sWTW5ru5V6qVvhTXAboAw0qHS952dVKHci7rg1YMVJMx3XMRrpYhrLwmBRPNhBcUuBCjmhTvXDz
 TQFqJVPMFt6NV6Z7K7IyKKSk9rwX6mQByPz1qsiPTvaahRzFDswKl+U+eRdjGEcMbV/7QbwBNyF
 Ld/7rUMISkFo6g3ekh56RjplT1MDnn0rBBqJMkYQKqvQ7wk1fJftTKSbHLaMpoKtTwPveW3eKEa
 WVbK3DAy9Bda9HIxEqg==
X-Proofpoint-GUID: qG5xuOUBMnAjx2MDC7rvjUKQU-hdSNz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> From: John Snow <jsnow@redhat.com>
> 
> This release removes some deprecated warnings for our use of the old
> sendmsg API on older python versions.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/scripts/vendor.py                      |   4 ++--
>  ...ny.whl => qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 bytes
>  pythondeps.toml                               |   2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl => qemu_qmp-0.0.6-py3-none-any.whl} (64%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

