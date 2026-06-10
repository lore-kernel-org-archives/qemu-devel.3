Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6223CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXN5z-0000Mv-L6; Wed, 10 Jun 2026 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXN5q-0000Mf-Jl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:51:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXN5l-0003EW-Fe
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:51:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFwgYi1997174
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sKnjt0vDznw72DUfmUhMLG0Cj9MH03SmYk7im+4v4IU=; b=DDLYQLWDa4dJmDWl
 GU0+E4UPOtWWnNwsj7gWzD+artCq4mh1jqpXsVf25gz0wF1zMUlnTCh04F0eQKrE
 5+Rq8y5pZVmyfj3lvdvA8youNw8bk6aLTn8xmhmZIwlEpRn2L3l0+J/w5CIzS3uX
 /8wzH/QTCodRYlVSOvOmDK2iVDzCMQhk/Km1q8LCnwqiAnJJt0/YUCl3rg9jWoK6
 Td0QvHVyM2GR9iIaSTpVdgsW/B7R6iQvxNrrX/nvyJP0vJO5lQR0hTx7wZ1NHfR9
 rdz0ggVkaTPst3+ZnwfZ8/N5QvV3W1BrxFPr4ysypNASStgecbMea9O7weHXQLgA
 ccWEGQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kdbbbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:51:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ec73b015so2723704eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781113910; x=1781718710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKnjt0vDznw72DUfmUhMLG0Cj9MH03SmYk7im+4v4IU=;
 b=AJt7ABj7NV+cTjwgZnSa7gcA9gXomjMy3osvFjxESLTWfrMW9UsuwiatXb2OyhI0by
 7H8S3h+YMNS8Q0/vt9INtnZhh59OEcao6GFDnS9NMV3lHTLgXuT0Lh47ZfZ6sxUnJpXE
 KdEL01ne2pMItmw1NX6sacwB0FPq2Qn7AM+CrajaSHUlK0SQXrFVOHpNDrIBEe9xSl/0
 WCrlrhoGtbgS5qSsBk77Rmbm1M4DZyPPqfKM4TuNhDzHA+m7CY6vGxz0Dw2adIEWe12j
 SdL/XV/x/OvXd28SgCv8w4wAgvv6IwQhJHXjW4pEkytXZ3BRQ0wQ5ufFYVOcWzaC3cD3
 ClsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781113910; x=1781718710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKnjt0vDznw72DUfmUhMLG0Cj9MH03SmYk7im+4v4IU=;
 b=k7eV4DQG7pxYmGGmRmpUaU627/jp8m4Jt9P3+97a0ZzHtrhGuCwfBGZYWuhsNC9uQ6
 Qbf3C88knHarymt3jaVzPY8QlXSuopob0HnqcvSRMm/sE/C0y2/xilcRr8qDkHfNFVgn
 ln0C4rWJstQy928bqY7769i+MVYfPejqOKIm3dkENmcCq/xH0qaer9qhMwT6v2jkvPqW
 vrCV+aShNP5dF4xqMLMPxKxlxCJKhii5Nmm5z2TxlyzcsXSKuHo2lsQp950iqDU08S3Z
 5amWhbbORehcsc28uRdNc76gy/eWwFzWZ8NZ4nnfEENrIZ/K8Tk0XweUKJ1DRWBy0UDC
 zSng==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uMSJf1NteWp0q8AoJo2QZVTodfg0+CEhVWq2yRaYDxH903st+V6YpoLg0DjR08HPrrmIx2VMSAyzL@nongnu.org
X-Gm-Message-State: AOJu0Yx/HTOxBNNt5scNW/yTX5EBk2+3r5QOs/6cVbtKrWhKILoT5AU6
 NUD4xuXYzwBo5Q4AZPAhAiy6DaLtRPTt6pXt4bYr3WWtsmveluYtjpJTYdjp4CUtIRE0Wbf+fdP
 5nsrrkjwVT2OAlomULWB8BaAuotIgqZeFIatGvyrP/60lKVJHn69NVT47Ag==
X-Gm-Gg: Acq92OH27qLrgtE7fhqqwgjTdbUELlu6qZEcs6oesCXc0atwyV43NVPPH+Yi18k5gYA
 npmI4ITVL0AEk229M3gcIY3IFmF3pD6l0fr13Lf2mH7SWXt5A6n8F/GXTdw2HZCsQF2xY4ARg+f
 uw2JYsFeIZdX8j02sRvejuISz5l+C6R53Zl1MNj4AJ5p4mkgfDuOEj0JOZqh1Mp4U7V3e2vLRWW
 +POXU2cq8cQeKlV6y7IZkxAs1L0f3R/C/hCZzLAzjb0p3XX028Z4jRLWniwrqoFqT9nYFdefkdL
 RjTVSGuQI1s+5YqDhtTpv1ALGUd0geSQkk6yXilo9D8F70/P/nfK02XxBzcDCdlBAYUPgWv/oSC
 R2UwDwrkWnIBsjZg44DIsqY3nNrgjx0Joqdmuy2JhyOO9a1ARotnXJutwVMmJnddtYxNsn+WvB1
 UStueY3Rkj8AqpLXFo609D7l8o
X-Received: by 2002:a05:7300:c88:b0:304:cd60:b6a6 with SMTP id
 5a478bee46e88-307d635cce1mr6075043eec.30.1781113910277; 
 Wed, 10 Jun 2026 10:51:50 -0700 (PDT)
X-Received: by 2002:a05:7300:c88:b0:304:cd60:b6a6 with SMTP id
 5a478bee46e88-307d635cce1mr6075026eec.30.1781113909797; 
 Wed, 10 Jun 2026 10:51:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm33754335eec.23.2026.06.10.10.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:51:49 -0700 (PDT)
Message-ID: <14ffa965-2a4a-40c0-9062-915ebe3aedb4@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 10:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: disable macOS jobs in forks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260610091700.2772973-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610091700.2772973-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a29a437 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=RljxU7T_rXKEf4E3K2wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 5Plak6efI9WPSNd4jdWVOiFgiPSBhiyh
X-Proofpoint-ORIG-GUID: 5Plak6efI9WPSNd4jdWVOiFgiPSBhiyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE2NyBTYWx0ZWRfX0LVMKOuyZpWr
 XiJoEIe8Qp6Cpz1bzUyXz0aRxrkp6TrKoz1CZ64T2OdCVl5MfXgWpN4bT0V4NuHw0TCG2U4yWjy
 Vq7doDQ4BAaZzLzECto2Qze176aFYYXI5kk00RzxVQ1MEcpr2hqRnoiuuGncWGo1T6gToCmLd87
 jhfNHo1Z1Zq9Gdv+ycqCSILe94XRnwWtAUG98XAPUb0p1JwUMDEtvNi22bCF+wQBB8F0HhDD6me
 md+GR6PKooM6e54WA4eOeQT3NYPL4ElK4F7vcDkmKwfFFOkPB0NagiW98iSGjzSHMK9lK34+0rY
 3D7NFq1Qb+jQ02DHYMDeCMg1P28Qpr24Ufux1Hw2/VEfBUHfjGx4yuVPvE0ols4yxMsmz25v9aZ
 IMXkniiTjugK0xntZz6sTjl/771g/jmliLfoHdtKYs7cs5Tv9JRuCWNOLm0WTBQqNDWxtI3Db+n
 PbUHN8yKvlYFzEjDt6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100167
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

On 6/10/2026 2:17 AM, Daniel P. Berrangé wrote:
> The GitLab macOS runners are only available in Premium and Ultimate
> tier projects. This permits their use in QEMU upstream via the OSS
> Program membership perk, but this does not extend to forks of QEMU.
> The macOS jobs thus need to be disabled in forks, otherwise all
> pipelines will immediately report a failure due to inability to
> access a runner.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml              | 5 +++++
>  .gitlab-ci.d/macos.yml             | 2 ++
>  docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
>  3 files changed, 14 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

