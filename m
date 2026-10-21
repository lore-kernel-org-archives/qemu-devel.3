Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E8606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JeNFsb1I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBa7UZOB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZ5E-0000aw-2g; Wed, 21 Oct 2026 12:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ4v-0000LE-2i
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:22:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ4t-0005C7-Ao
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:22:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU9UZ682672
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OlmhvxrzpcEkzmZclPYkH5MqTlejvbrYD4DFnBjBNCg=; b=JeNFsb1Io/XihqV2
 YkE3QNPRuYnjGVkV3MOoFFsMnYFWVr/EDZd/ILsqtD9XTnXp3NHe2EXKuNNxtSjZ
 UyxK8yIVJmVBJTPrnqT3nEHIpdw1eHS9SGcYxLIPT0yT1DyyH10qyShbXJ2Nexfk
 6CiOWfwkJ+/wZtAKRBSXZFw/P2wQWx/pDoc6dcdok2uLb2ueMzDt+5aj4oa2vXNi
 7GSUYvXTyZCu5NQeLILeobEWO3HteWtsNMhooKv6UdJ0h+CUBSzfQ0wVdjccvp34
 NuPHxRn9jx2hHLjM66J33ADmMoc2pFhFqCQr+ugxM54D2bToS5c8gw5A8gYXCTJm
 CYgLMQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrtkm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:22:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-366c279b454so1784735eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599729; x=1793204529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OlmhvxrzpcEkzmZclPYkH5MqTlejvbrYD4DFnBjBNCg=;
 b=NBa7UZOBrd2MBiZtf85zYUKBJdtvhdsMBYdeBOetI1Sy7A5MSIx1CNvVUcajQHd2mv
 bjkUgLkwgTY/WEsmgiJWj8BdsZdCGAWqPaGPxUQr0uadFdY3/v5oGywqzRo/iYL80zVH
 xbeyYV3fDzHMhkU0nBe0T7VmbNAMaaptCOMS8C7+V/mz+wHXheLLqd8i6yE8KkWPsdTJ
 fv1nFT5nO0QLV51eYDv8U38U+3Yp/FxP9nqYT9QprkXbn1mZ5IqAsXmDNZ4VccY5CtuC
 SinZEkUo87Q/JrkobFYpSJoDUB5rwSvujr1ZKMuHRAcBGnrPMZxXxlR5OK5AxYo4dcN4
 gpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599729; x=1793204529;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OlmhvxrzpcEkzmZclPYkH5MqTlejvbrYD4DFnBjBNCg=;
 b=t6EBD5HB5KEa6PYOov5RY+pMu9ijgFx6/5tCTD198ffRMQzWyqVskS4DvMgjwFy2h0
 vnEachX01M2RBN5913R43KeIZBE2OiuoFki9NEAL9tuSDDNbFyD3XO6KPTEyAQd04s2n
 GNcm8Rcy+55WgBuwaoPAuxN7MhDbxetc1qt3HcudXss6lRM/uCYn36SYu0fOL+TBWhry
 FYbz19yAkn7BMS9EMUwFqLkGydXKch8DyICTX1S4RTCVS4F7J+Wh+f9tPEZAAC8f7XFo
 8GI8VX7hSpmFAkHfY2Yputf1Trhw2EerSl51E0CvXoaYCCLALIzk1Zfo+j73soE9xcQV
 DNhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuRr2pO/Dw3LndFFmUDTYQej+gNbt/tTfx1f2FIYLMdN9VviaooAsINiGIH2UEur0f90bESgrYi54n@nongnu.org
X-Gm-Message-State: AFq9FYIROAkcZmb6rVqWiOxLf17vrDgqxdp5aXXa7FiD393z1gZoPoip
 w4pTi9CMGK6u8qG11gjMl8/JKpa5X8rHKScndToWG2OD2rt6F7rvo9O+t1800NGafRtp1zftys/
 jGIRgFJFm1yJXBHRv15pvlgw+JpPuaLn0GsvcTW4Y0W8FMge56nO2EaXpXA==
X-Gm-Gg: AYBFou3Oaudvk7k54d29x/sVl3BMDDSJKEZMAy5tAZXizHbal8McCVaO0S+5xYBwP8Q
 2lAS699GLVLUeYhhZJ09U24CVnnWZN9Fs3Q2JLmcqw+emOkeDjhB09wxG0OkEtGba3qC/XLUJED
 5m40GQOyRfjvzK0fuevRNeRy3xBqDpdB148s76k1pKinjo0+wb2BoDSO2MpzewymzmTtX9gYn5o
 vdSGPlw5XRp3KPcZ3LsAI/5jJRPE08p4WzzWLNZc1nRwwtIbIukV8T6q7F+N9fF/kEjcUCR+X+b
 9aLEoxyoAH9FYfoR1jh0aijbmfQQy6lU/ym+c5am3v3kH/a5VeMh/K5FWcjP/mVjcww5U/wzE9c
 9K3o/+Pr0gJ2mzRAFyPUGWD2SuorbaV6ILarBlx4cvNkkss4yW9qc1NjgM9USSSqAlhKcDw==
X-Received: by 2002:a05:7300:e70c:b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3674cb37bb2mr3728488eec.15.1792599728474; 
 Wed, 21 Oct 2026 09:22:08 -0700 (PDT)
X-Received: by 2002:a05:7300:e70c:b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3674cb37bb2mr3728444eec.15.1792599727808; 
 Wed, 21 Oct 2026 09:22:07 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367412b24e3sm7543414eec.19.2026.10.21.09.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:22:07 -0700 (PDT)
Message-ID: <befaf3fc-1c32-4a5a-906a-d13cf2abcf25@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:22:05 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/33] target/ppc: Dump EBB exceptions names
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
 <20261021031407.24862-20-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031407.24862-20-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QNhBQ3kpeg4HuNg4f-aZSQPjQ_f8-53Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX3J3nceqzVyz8
 1N5jxmJ7CuNfKVNFM4d9XN2yWq5l2Wb8L2C5kjQnJJAsAo9AWxxGKKMV1pYSiWU7zFa2T9knuO9
 /pglNrK3pu0NFgHt7luqscs1sCqVxFg=
X-Proofpoint-GUID: QNhBQ3kpeg4HuNg4f-aZSQPjQ_f8-53Z
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8e6b2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=4GMrmK1NxY-Qm3nL4oIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfXyr/+/UQV6tvz
 rZgHLYYxvFCfhH1sE/aPsLFW+nuhH4CM1E/36dTlBF1yZsB32E3rRHFrQIMF7H9MElvrFwuG+oY
 jGIckrLslqLFbGuM0W/m+A13hu1IkOtsCZpkfHodVu4OfRoQ8V7P9D0yUVR4VTklw2SXMGhZ3Zc
 hy9phH4kyfbyxtAWSC95Uyn9iColFwhPp3msgZsuFly6w2lthl9TLqZhgGOq3urCc5UyWue3LKT
 i9B5iRu/V2okA/M1ZEBKXX9jzGdl/BrDpftQblRMIXg/HqSzFWgs7pZe7dT38iJVRiQ1r2nr/hH
 QCiuQB48ZB3jRvq4g6VYKIhh+LeOwK5Kd9nLHMol6mEWMSJTILVWRJec05VFIiKli67y6nGRsqJ
 lX/jsnNA+RVemUHOLr08CrccsZlNcvUiQWRH4toqxK2pMHlv3+jNM2kKvOyIkKTqF15avaw4Hnd
 6tBLh+iFbnmK6Gwo6qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:13 PM, Philippe Mathieu-Daudé wrote:
> POWERPC_EXCP_PERFM_EBB and POWERPC_EXCP_EXTERNAL_EBB are
> raised on POWER8+ and logged by powerpc_excp() with '-d int',
> reaching g_assert_not_reached().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: cb76bbc43fd ("target/ppc: add PPC_INTERRUPT_EBB and EBB exceptions")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/ppc/excp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

