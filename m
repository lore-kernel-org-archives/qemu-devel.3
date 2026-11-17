Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TDamfgdb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TNAsqRuU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO7U-00067L-7s; Tue, 17 Nov 2026 13:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTO7I-00063n-0g
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:41:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTO7F-0001Jf-Gu
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:41:15 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQNmU923362
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k5l9NOjqVYOXqRxD/oTDvjEOtqUYuw0UH/N1tNLR2wA=; b=TDamfgdbBrH2epb9
 3O83PoQ8/eEnUTFqwWuyghhbvVBLzYiGvYngJGH1QSc4OF3utkcDm0XAtcF21YW+
 50S55mYjlG5RFsnlZeyZPQ64xeCBRNsLLF8wvpvIGsGAuhWgwXDeSrVOjSebMmXc
 5IJrJlXeanN1Go5GxVB+66aXrPXIW/4H0xdBRK2L+520n47toQaela9nehQrA0mO
 Lz3YX91znru1CVztvthejESuZuSlSP9dx/IpfuS+WfHOed0ETU7n/eVmOV7Hx9As
 lsZ57ak9eO9pGpUfPVszUEXVnugLqjGb5dIAlwIsNOE2lRGcSAxZCCFJPyAjGMuq
 f10qWA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms1h1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:41:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so200174eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794940871; x=1795545671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k5l9NOjqVYOXqRxD/oTDvjEOtqUYuw0UH/N1tNLR2wA=;
 b=TNAsqRuUwX5K4EsnnQJJbM/CY/NUhd7wTx3t7cJamhEN2hz19FGTt1bQzdJTmgY6RG
 8vpQkwgUcNInao3WZz/0pxXZm1cHmV6eLQOaDrzMRh93yJKeQwTKMKgF19s/EHCaBiZC
 tvvfTP1f24TkVKOx5gDfDKV3fHUlEOyYH42MYrT1oRQQiGb4Ge3mCGi21MJKJ/AS5KDs
 f/PI5LNiOOCb1Umxt5pFokP76UM1SCM0AO+0072Jgi8w2jZ7KmW6Btg+tzaJupUgp7Cs
 +lo57EMwIuqq7sNofrv/EMDRA5YhEXwHF2vmQPTRCVCL091tLztiqkmKGIBVLx7DloBX
 fyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940871; x=1795545671;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5l9NOjqVYOXqRxD/oTDvjEOtqUYuw0UH/N1tNLR2wA=;
 b=JsS8LIrFkbys71L4pRD+CYvoA7zP12HUO2HhrqcGJaYbN1ALaZILbt5Fl5pvuLRla1
 MIn0NYi4tOBXiLSaWie1tWMEMLjhq3GZeDR6LOajNtCIMdlSzptiU3UvwDnX+260XkmG
 JXrX66Bj7pHsz94TFUxC3F2Q2uWsQI/uysSVL/rnBISrrHUV217Mg4ZEFprKgh+7xBg7
 VjS+Kaeux7f+FxeFpk/CLHfYzGKgh+R8dujR3P1lhKflefgrtjJBJFXmwoC1ukA+DIy9
 cAT/FV62PWjO323nwvtLMpJ8uHCAQ7t9u2tkQFmkXTAiridwVV8x3j8D3iC441pe+IzA
 6Ebg==
X-Forwarded-Encrypted: i=1;
 AL+hErHGYic0dDPfRFmdTdxe7iCcro4O1n2OExsnDCaPDQ9tRtZtEBSGV095GBWP3H23Lf2qnfyz55wJEHaW@nongnu.org
X-Gm-Message-State: APuU4Z/usww7yXNxXp6tXKOXxWv9iDEhgCdbZLup5BptjtM4bnYfIcpr
 XGisakFWhFtDYuX6MhMx+i7+49gT5KPgH3NB1s2KuyjOwzBGjY4gHhFtOUikld4sl9QQAwqBPa1
 cwrRMAueY1yu+UIlV01V0Kf2aWQSmOxWzJj1JzSD9OfW+Xk6uomTEY15IrQ==
X-Gm-Gg: AZFdTZeD6Dd60CbPWYahPkvBeZae+2YRfMDMcnCzt6VtFWB8RQr9mZxSDA9Cu67NzYi
 JKXbCbvDxWdhKG5hMyLNOQRVryvxH6y+FmFF3WLO15AXuwcL4w4++mrRDkhd6//G1CJ9uCIY6Yi
 oEV2HqU1mSV7ChdxuqcfMAFdcChwWVH2/AwCPHnYq+0YPMZW0VjOimZBsKT6ZOS+SUGs5ssFsoK
 MSH4V/enpmkwF3LX1ucEwcT6jxixxvbyGokR24gkjrSqqQXEtlsQtMm7vw4hvbX+utHnYEsQOUQ
 o09Rf2DRO2l0CJ7WNlzaJ+fV1it/2Q/uDF824Vul/NzylqFds5D2TmFVnBB8rlzBBwYgFJZfew7
 +NWNtXgPI3GM9Jn4UrXSW8bvFUvQ0R4KJt9TY54/0LP4UMmtxiGgRtEjw+/r8L2OQF7HivFV8aT
 JhJr4MXCfZf+EmUtKE2TTsh39QdiynVNPW3etIVVVIZPA=
X-Received: by 2002:a05:7300:fc14:b0:36f:5746:3364 with SMTP id
 5a478bee46e88-38281215bb8mr262560eec.28.1794940871046; 
 Tue, 17 Nov 2026 10:41:11 -0800 (PST)
X-Received: by 2002:a05:7300:fc14:b0:36f:5746:3364 with SMTP id
 5a478bee46e88-38281215bb8mr262538eec.28.1794940870369; 
 Tue, 17 Nov 2026 10:41:10 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563df84fsm87472829eec.20.2026.11.17.10.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:41:09 -0800 (PST)
Message-ID: <e182e374-421b-4465-baf8-9b5895964402@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:41:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/hexagon: read the old predicate value
 through C4
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-2-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117183629.2002840-2-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX5uQzmmjdIlFe
 qLdIJyL5R0/brsy0t5vQv2ZwcUHp/W7Hy21dLGp6K8jX14Fppn/qfzWEyBYu+mkw1H1gnKi9XcY
 i8bwRw4FkWcvnsltSEyIpQF8y2k05pw=
X-Proofpoint-ORIG-GUID: CYj8oQ5l-cu16VLXYJ-z1K2eELqWGgXD
X-Proofpoint-GUID: CYj8oQ5l-cu16VLXYJ-z1K2eELqWGgXD
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afc9fc7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1yJ8gBRUuYsls8p9yqoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXywClBT2KND5g
 8mHBIbCv61RQ3i10B8LTjKQydKZblSy0HmPr+IbLXeTcXcHxOdNks8KzMAxlTTnzi6PtPLA2qm1
 Y6gQ5vDSLrBZFGLNTdiBLZDKsLjtcQMvlqkYhZanLvkQcL+HW16pkiBNnsIyTwPGh5mWLW1Mq81
 iVPttDXdbQSmo6rK3vH4pi9blQ0djRLNMmUakohUzf/sWihWKrJWUqHD/7YaIgMgNcViRk6F6Uw
 vjqGc8KvJSUo1W0YnDp/j+bWv/nHMx7aNi22NJXvf7Hoo8wWDlAW13688vB0hH8Vi7MqATRcbKF
 nZ5PAADmVbSAdEFWKysci/ij+cGdDtephtAM7FEVJ0Rox3cEv+i0TQnOs1sQG0rO/sI/EZ2B53r
 0Tn+eqvwFl3w/ByjnoAab/VUfLQkmbzYksPe+9bHc4UfqZr5CvQKiuFvQO3M4bndBIU1aGx4OPZ
 zmVbOmwbMijdKT/n4hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/2026 10:36 AM, Marco Liebel wrote:
> Track C4 reads as reads of all four predicates. This prevents the
> packet short circuit from exposing a predicate result to an old-value
> control register read.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h      |  6 +++++-
>  tests/tcg/hexagon/meson.build   |  1 +
>  tests/tcg/hexagon/packet_user.c | 38 +++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/hexagon/packet_user.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

