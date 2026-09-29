Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094EECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBX9y-0004CR-TE; Tue, 29 Sep 2026 08:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBX9w-0004Ay-Sg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:42:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBX9v-0006Uv-A6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:42:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE2tG1491809
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VZSVzjMQNWeiWZZE1h7IDtMS+7VEfWgjne3Ph9HosNA=; b=IYkDwrbUxRdPDaoL
 5rdjDiKBzS0z9A2f0nBMbTJigY3G7lSSVUQhcwasuPp4aNGqZLocZ5v4yyftb2ys
 +ix5qt9bI/2sQdzkF3HmNsoI+MYeg27PLr+eLZ/9qlL5ymvIfYGp++BDhrvmp3bC
 yiSMyAkyT1cCJpe38chglMlcpSHW74hggE3AgifO+Sv8n1kYpjK5TaHaZmPT/IG4
 JcBk2Ex+yDOm9UooFJf1CbEc1nX8sNc4C/C0NoomA3q8GU5Ka0hp8Y6kfzouudWH
 sUc4K0LNhfhNvO3I3pQ2TvA1YlCzaTl+vvgmmloepFHzJ4NoUXWlogSqZOAHY8W1
 sUrIMg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4s02j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:42:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5c205127so495697785a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790685726; x=1791290526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VZSVzjMQNWeiWZZE1h7IDtMS+7VEfWgjne3Ph9HosNA=;
 b=gbI0/GbmJ7+gZ3OKhdXPY/57EdBg9pJH7wjxmiqJRwOcwbisKwqgmmtjDdBoOpdZK/
 sMOpNbIQ+ZLq5jGFsS3Rq8b2DcOgD3YnvnioICmsZfInq8az0mFmz7hszRQ3+LjcqDPc
 m4UIUcqYuSFn9B3ZiHlnhjx/5UyJlVlvklqk/oACWl4wH8h7jnUrdBvNyfUSBcSd05e5
 1M3kFNMocEmzFoBFiDpaUBQW/RW1N7Rz41BeL8ds5LuI1zgDfdj7bHGYUGmn+r7lN/SM
 GERhZ7Z2Gjd8gcWcHW7Ipr/4BhDd+GilNDbmdVq9+L4KlWK7g3hDRNMp7eeliZjU2zAh
 7Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685726; x=1791290526;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZSVzjMQNWeiWZZE1h7IDtMS+7VEfWgjne3Ph9HosNA=;
 b=kguPn3vQu2mzYvJQE23bRjtqelAzcU3kjtXTQ24RiwUZdc9Pndl6yqe+Xkj8TuPys/
 ZJGEsXArlDljWMNGAjAAU91DxjY3KrATY4Sax1use9Db+sBQjoG4H7vw8R4SvEWmDD8Y
 ogGv4/97s16W/rpUNA+pRA8hl+/UTdcXWcwXd/EdMen78igp3rnlGeeZ2bFPzseG940C
 Sv/EBDppKTrDHGZvjuB5NqCcr3yDYumQrunU9KII7zY8gZFz/8MtxMirj2OLkIM3+68o
 kHnmFtOaS5+rLQ1R/Ape+KJxQpQ3QuJd+YCl0H1Il1CiSyw33gWN68e7RphfccCIaRsj
 H4kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMVuoii54UaYoK9gqTf6gKabIDM+mTnMmTFgeeSI/RzRJQJhFki3NPGsuEceRdrR27bwLrPJBdmhqn@nongnu.org
X-Gm-Message-State: AFuF++l48BxwMAcb9PVqCf36jZByp18YPBj1/ydETF8R9tAiJLWazB3K
 OavrZZGKXBC24FTP5EH73UJkhZA7tBv+FDCp26OZnWGmXF/NojGd6x5ZeTIxIlxP6Z/cpfCeOLw
 RhHFahIgQfjwtJqwV38m+LcEHMoNh0GAtn+L0YZ4Lb9WPfwaHVf4k3F206UhodOY2xA==
X-Gm-Gg: AYBFou3757Cc3LFUiKamDYKnRBcSjm6W4ZJa08ygtoIEaRrRHsry3+92bAokrxOcPsl
 zFAHt3iL65+rEsl1kaKrE6FF8gzicxIvkI9QpJR9EW/9f9bnnghQNo/GebSx+wj3W6khBghOVf5
 6DFjHwS1mWVMI26KvDRW+t/qkayupM+KA8l3RxI0TQlHefGUXuPpxi/qGWgVrmfJj5Mib+x+L8M
 mP4GjaTMw7QJkp7XvIrMo/PkSCmccaLqJgmDNqDb9I8eNIxZu29BfCPmAZ+vSBZore6JrP3EuFx
 EYTIIO1Xq2SDucTVAurJrJwawU6n8L0phLOHPM2ZJ9UsVRJ0rDy1EWgJW/myMnJsREoeqQwtDz5
 +6UZG34lLGturV9Gugts/v5WMAQiBybohAZvKtz20CERj
X-Received: by 2002:a05:620a:404d:b0:939:1864:343e with SMTP id
 af79cd13be357-93c43cd2420mr2422892485a.40.1790685726470; 
 Tue, 29 Sep 2026 05:42:06 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:939:1864:343e with SMTP id
 af79cd13be357-93c43cd2420mr2422886685a.40.1790685725773; 
 Tue, 29 Sep 2026 05:42:05 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cf8402sm1085945e9.2.2026.09.29.05.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:42:05 -0700 (PDT)
Message-ID: <32479653-d921-47af-b847-c76a682f2c95@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:42:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 009/101] tcg: Generic expansion of tcg_gen_mov_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX8esdsU4DCC+P
 YsgBmzVj6KjWDLHHcjm/HI1EWkW2y7I8hfJFLbY+uXZ6EDiTBGxyeXXyV8lxSHgV9Wkz+YpcMe/
 MPEzaqbTqk7qXF9JEU9pT6YxEdkA/Tg=
X-Proofpoint-GUID: A7SQoBfHBm3TWRnkXYccYIrlSHqViidM
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abbb21f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: A7SQoBfHBm3TWRnkXYccYIrlSHqViidM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX5gPHRli4T8bL
 mBVUxc7bo4v8ARz8caZYJzuwWASEl+NdxxT/vx5g9swq9SJGt0/PNdvg3ZRGeotYVvliA9pe9Ef
 q59TO2U4j13A0kG0qBdTCo+obpDliGdcX9EhiuL+7piFzeqCP4GUgbTcLzrohgkGw8BHO58geVC
 si0WVegesJEDjVOiwydeGRp6uKnjsothyrMXYrJZSGySJxnfpkkT+xLyXRw9wfqAAgO5BgVcC5H
 sWNSbMJnS1wYOLlbzNl6PxF/qQuHaTpfw0EefmSGhsoJ1uemyGlTiyRbi4DiHe3QmZHfeu4CGSm
 i5Am+TpDoUjigVMzUqRzUvAJfn3mhlZ9kj3fpvxpdQNdv8NzVDjJyUGWj6wzxtlSajQViMH/pQv
 wX8NaKMK/+F+Ubsv2hBbWTnpiwUlJNl1DaEtMrMoGj667fY+wSc3qKc3Uhydeu/mqJoGt8zLOUG
 VvfxNzo/kQvglSFFkTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290050
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

On 27/9/26 10:58, Richard Henderson wrote:
> Begin sharing code in the expansion of operations
> for various TCG types.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  | 29 +++++++++++++--
>   tcg/tcg-internal.h           | 23 ++++++++++++
>   include/tcg/tcg-op-def.h.inc |  4 +++
>   tcg/tcg-op.c                 | 69 ++++++++++++++++++++++++++++--------
>   4 files changed, 109 insertions(+), 16 deletions(-)
>   create mode 100644 include/tcg/tcg-op-def.h.inc

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

