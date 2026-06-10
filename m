Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4377CD8C90
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXN67-0000Nf-Af; Wed, 10 Jun 2026 13:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXN5w-0000N2-96
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:52:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXN5u-0003FQ-Pb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:52:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFwpxR104534
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qm329memDd1u2DGw8pN99LtSE24ErBDfzPrscD45quA=; b=C2qAEH+UXvM7AZOd
 1ApSWKf9vSRvJ9dUh/+HRAgkfVF/7B59KGK6GajwSfIoR2GwJWsZCcccudhAUmSB
 lA/Ci6S0qvgocolaMsH026lYn0b35Z3soRAGphG8lG4XunpgBmIkV5Eky5fHE1YM
 jReiaoF7O/Bz24Tb5wdNKCGKluB6vvAIdD2iRPnGzpolpLYwellUgknMkdAReDRI
 G37Qa2YllPEYa1SY4m6VSoJ7MKP2QPJRrRw5nePO/wGOx440gtd4KOaWI+SNg/iS
 JEYb+edlvXMoVXhc1sW4CIrPniur8O3RVTwU1R5ABm6oeUaSkmvPF7Y/zg4TmtyB
 soPGkQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwneuwm6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:52:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13840d96f21so2568c88.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781113919; x=1781718719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qm329memDd1u2DGw8pN99LtSE24ErBDfzPrscD45quA=;
 b=WR8mz89ujk5596tt/zXchs7d8loyONsneYl/xdWtJ2xjFmYP8Zl/6/13EcXiOKNSXi
 3myOA6BC2P8frRQNIrZ5y/hVOE3K4cKcWp4oaJ3gIHsxaTHMAxdAfLFjPtAxLBNeIZAb
 5qwaCnautzEiiF8E0drvSv8Flo2/cWk9xlUo8GiVCe4OWrWmJAdi+BiVG1PoAG4lR2GB
 OCk1pcHfi9ZleOIKUegEh97LiTJNN+2rS6TF9Rl3VvsyuJmkq3Fw4BsliZc9Q8UlbBwE
 vBYKO1clGan3VtmIjk1CyiZs9TWMRmTZE1XF25baEIOvTTnEpqY0/t6/KIQjvc7DP4gC
 iB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781113919; x=1781718719;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qm329memDd1u2DGw8pN99LtSE24ErBDfzPrscD45quA=;
 b=LSkKwUNwxi/tAjvgo13FmE3Ujri8wtfCBoqowuVwuRKw6RmQ8aiqxtTFXeiXSwwcDa
 gGNWvTh7chMdwyVCr52GP5G5MUeHc/CozMxRFXCu+NB1AswelENeqQRGBcFWdafRWdCU
 fh0fLDhYE2oAypr8MMxx3Nvf/nLaFchWu4rZIuwpnmWVv66CDFezMrXP/dlJm/c9O8C6
 ox+51vVrWddkr4tQKFwOgyeo/70TXi0d+2eJyoJYGhZt83MvkgaHVRqn6r2gY85//fw4
 gU0MRvulA3ZF1IEHawxohuwbePWffLog/AOUoOWB159fhr36rmt/GLLz81p/H1Phvirn
 FHeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8q/B7AA6cIMWYX2velfJeQp4DXHVUWcR/POF42crdAAu+AZixtUKes4zTVO3ucGF88uzTcDLlLAI1N@nongnu.org
X-Gm-Message-State: AOJu0YwU1OxVbrhuZ/EYvzctJuXgA5t5E0WbB63WH7/yCkzYNn7xdtEY
 4umoPzg8RYPLOsq0mAp5BxwyvP4QKSXrX+JvJXdUNt6KQlTRw7wL697uAq00jSlYOKeC4bGgksn
 Kmf5OFS5kM4tdy2Xp5v4Mzh3HUh44C5zJ2YE8nKl/2mKHfJNJz90R9jFljg==
X-Gm-Gg: Acq92OHjhEFpIQ0TO0VV7g9vTLI8rX/9X4DLT00y2JUwygQFmn+XPsLDQ1QBWV0pU3Y
 SRNWKJE6sbWvzsUXVFEKYQ/t8cExCIM7lkeBktVhw/kiuL3KV5/o0MQMWDIL7uJef9nuCKxymP2
 YgVbpuYx5xpLUIbCSw2TvqWvt9v55GUy1VVNIDflhCMPgBQl2Yh0zY9wo9ZS253GxTZ1VORqurM
 zpFsPUxjtzPKbJPugsMEFDJ6D4WHKv1I3QOJDPWB6I5upTIT3VFjuQl/eZLzMYxJG0dmoXeDuXA
 YRNFUQemc/vYBDCO2W8giCfyO8Z+4t2C10Z9XCuqdUCXe2bmLOPIDNUCr6EWt0Exc4kediBnU9w
 8MRzDK96bXYb0YfeS6cLS9+EV+6eaTB7FRvTBB1Jvv4o5pWL7SEEfM5ShW+2fLLQ215+ZTmOXQz
 lv4660cZC3dnY2/R2jnN7/oeQH
X-Received: by 2002:a05:7022:6ba1:b0:137:ec47:8fe1 with SMTP id
 a92af1059eb24-138067240b3mr15479607c88.29.1781113919601; 
 Wed, 10 Jun 2026 10:51:59 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba1:b0:137:ec47:8fe1 with SMTP id
 a92af1059eb24-138067240b3mr15479587c88.29.1781113919051; 
 Wed, 10 Jun 2026 10:51:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54caef7sm19822983c88.7.2026.06.10.10.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:51:58 -0700 (PDT)
Message-ID: <156a4234-7d50-4687-a262-bd1dba7727f3@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 10:51:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: ensure "check-XXX' jobs capture functional test
 logs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260610121254.2870259-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610121254.2870259-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HXQTMFE2jouTUOMewDUZTBxQ_3_5DoWn
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a29a440 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=C1x4iakRHqDU71bddSAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: HXQTMFE2jouTUOMewDUZTBxQ_3_5DoWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE2NyBTYWx0ZWRfX93CYz7w+Kcak
 VhXfZwhng8fJM9CbB/QhPly3LYodEl5bsQM6tcuLe1w+uyby2taIhqDJ3He+ii4OaxFZZztFKbZ
 my1m+GWng1YacnQ4QwlLMObtQ6atm/v19U5V/9sev5fnR9/QVP0GWsr4ken5lZJHWfwqHVRf+qI
 ss7zrGJ/nM6VeraOZ1MPrpQXjCLF4UGcc4uDzclY2U4Bjs/CToyJmEJb3ZqSQS0Lsrg9UIi9A9v
 rq+5vV1EobxZKABjZzUrbrZyY2gebRJ553SrgENWYwGXUBvpUTqAbiOKarWRVRQdO5KJKoOG7n6
 hWLTXVYiQx+3LzAKfkDJhwiHmR+BCL9G1i3hO3Q/SwT/FOcQDYdaGXncaVVpHYz+vTy7EKLKdvF
 Y+vdpICYLzx5KuNWYL6auL8dwcetoooT5cBjyPcY7e41ksQ0h5ga4fMKbGAP/dEixajqI3ucWgI
 HXOT9s/4KCLTg5292LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100167
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

On 6/10/2026 5:12 AM, Daniel P. Berrangé wrote:
> A small subset of functional tests are run by default with
> 'make check', and so run in the context of 'check-XXX' CI
> jobs, rather than 'functional-XXX' CI jobs.  Thus we need
> to capture the functional test logs unconditionally for all
> test jobs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

