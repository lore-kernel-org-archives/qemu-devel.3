Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66E1C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljO9-0000Im-BJ; Mon, 20 Jul 2026 04:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljNd-00008t-TE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:29:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljNc-00021t-C3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:29:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RgWE1774812
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sS2DFJoDOAen5lutOa6h4WIVLuCPa/Bz/G7//rqLTD8=; b=GNz802/H2uKG19sB
 G1ZNcWtI6CFNgyBR2xyTnQXWtpBThopFKCWtlAgv8TF5hJC4wnJ9KkBKVDRWYdu7
 Zx6iXS+cBOx81AaO2f2AR9ToC47udJux4wjh74vprGX739V0CNIz07QqPbblzfr/
 sF//yZBQ8slPgKWBam2vTBwdgxFNkJMuq1mvwlmQnftEDtKi72T+7ZtpCV+UfpIl
 xZohOxQLaICTm+nymP8wQqrZnxpjeavyGHvYqvJIHLNMBwFizo8cetUbNy3NpbhN
 z4/HHKn9MiOj+GDEdCKjFYIbwvKLjNf6C5f6cqsd0s6dXmC2QFkqkIVb7iEXbfkf
 3Yub1w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af56d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:29:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so235928641cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784536178; x=1785140978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sS2DFJoDOAen5lutOa6h4WIVLuCPa/Bz/G7//rqLTD8=;
 b=X2wynRkn3v/EDf8O65b52Bw/R5LqBFM5LIKZkStDJGU9ywVLVllxvbRpr9T+ySrS62
 9bV1a+6DzB/kWQ0UHFsC8mQIw7FremeDkAs7xyZxLg9GZAoMOmSwOOyx2rrnZXXRdamX
 sxrdmbX2RaxqOrL35sHpQus9SXVKyDSDhaXtJo+aznslWuBKvbQFKWjv3vXgtC4SRvw5
 fZZXQ6d1FuDSEUy1iHf02AXK5UtbZkA8VvwVhmYMarAfx/LcSWaxj5QqAxbu8NOG0glc
 ozoeBjoqY0vLAH3YCGvL65agAptHuDm2Rxd2xyQX2lzwPaFdYh1aOHkYZ7yXVmrN19rc
 Qjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536178; x=1785140978;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sS2DFJoDOAen5lutOa6h4WIVLuCPa/Bz/G7//rqLTD8=;
 b=Q8Lf8MBCuOIYlS/+wsGVujsqaJQn72N0YsurYUeLMrtt2raTl1ldF9TRtuB6leOR/A
 L+WwXwPTW05L2dUDFFxpR8DE2t6EuSRo/Q4k/lBs4LOHfP8AlUe/Hy5CGj9RdgDeZB8g
 5b0X6t8nwd0a74xn3nk0XZ2cDwdmC1smIEAILHUXHtrRd0svYktxxfEpwr13BlOaPovT
 57B1rUS17R/d/ma9sPUFyKbGgIny+JTVvNq5VM5B1Ji9Nz16/4wBYqLhFOkAj9vSelab
 4yidWdTMg4Xj/I3t0jRG/9qq1NpljLLKkXVpJ6p6iuu47C/RwVTuu1T4OMoN9bmVZMlD
 YsiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOTxvzmGqrVM95W7LxVPcfjGkdey1G0t0jZBwN2C0M9G5/gmBFD6difFU/VoJpd4jo+LBBNaR0EI1X@nongnu.org
X-Gm-Message-State: AOJu0YwVKEJu+W4y0gR1v3yme86rLN2jxP3GKRHNtIswLwSbJybmJfu8
 TznA553qWgxm+a6ufqXQ+XaFdx+iBpDBC4Z4tIx+CakiDqV1ggD5MTSB6d92cGxdFn2oAPIM+JN
 Cx0WTS9HISmR634yOxRhyxqqfbb58V8TjZ/oaCmoP5zToEEGnXGwCiLrx0Q==
X-Gm-Gg: AfdE7clHC0QUxhf3K73SCH/Z8ofAyN/2y4B2Sqg70hRpK+AuPPdIKm2P0Uugjk0BmOH
 FX2XMGnM51VnI0jIyf8NAkQve4a2mDbL/iE6pcqlm6vXMcoWNDSh8FwoP5sPJHOcd4M+73eksHi
 e+hvFqGz+7cqFJaUVSsKEGQk4DHnc8yjuJUyLBmEO5QUDmgH7keMgkTMqMtAZI+lP1/hV5l3Glj
 YXtL2B81dut9bdax3odAnF1v17GSjHfTX1GHqltJ+iI35yVi9xV+S9+ngdXia6rB77zrR34XxDH
 I8hBpGuT4a8dCzHtnQUSNBXctPbkzg+GtU4tMBcU3hC/s2dxAMJ+hctsomAbnso2BiSEJxkq0wU
 Y3njTZlsx9iOlUjPdA2ol+6ntx7P+dcyiEKWyWf3+Aj+Pe+RrUps=
X-Received: by 2002:a05:622a:1e11:b0:51c:511:c5 with SMTP id
 d75a77b69052e-5213c8e2f6cmr130787931cf.16.1784536178324; 
 Mon, 20 Jul 2026 01:29:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1e11:b0:51c:511:c5 with SMTP id
 d75a77b69052e-5213c8e2f6cmr130787761cf.16.1784536177976; 
 Mon, 20 Jul 2026 01:29:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f69e5eff1sm19352499f8f.19.2026.07.20.01.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:29:37 -0700 (PDT)
Message-ID: <a8e58b3b-55f5-477b-86f4-d826d85aa544@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] target/arm: Imply probe from
 allocation_tag_mem_probe
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX3TjXrztUWH4u
 SVejf09fUG1RkjcVJFrzr8KTFAs0bERQcP4oUvKKrRH4MstxKQ2uFILCBWsWP4MPcpQbRFdTyBp
 eMk1spr2fcEE+vXbFWPwd73c7hMPBwQ=
X-Proofpoint-GUID: Y9Gj4rX_ugqT4zeR11hj5vXME2hsXk8Z
X-Proofpoint-ORIG-GUID: Y9Gj4rX_ugqT4zeR11hj5vXME2hsXk8Z
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5ddc72 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX5nS79QcEvLNL
 9N0XuMfvtEKHAyH0xo9GPNSo5hV3rpIVhlfGdiaDhT82ld7AL55Yb2jKRhAq1//32NWZzzdBbkg
 QYc1wtPjLCLbSxyCWVe/ykNMgBm8sR8yYhHY+95sbVAnhXeoQpRS96ftU0AOiHp+dtMUJyMfsag
 8KYvxy4MzNmf6uWxo4QfkgnZZoyJHpRb/d6ADqYwYjyjNNgk9nZfkIkj/7WnCI7NBhoEmpd7DrD
 z5zoyEVkUAP+VzdpnRYMYBqzMLxzTAiYfPwDeEhQCqY/GQIUFYvEmnaQSRpEO2mTaHaRFZloRxG
 snjqowtCbnFO5qG20hqD/Yf/cdcg8VRp2HTGI5uV5MLym5XlEdGXWamDdZXWwKNx4KLNX5vAyEv
 PxyBKSB9e6JYGSiVEZODOv4sYnMUmoKcVt1SR6mPFyRKfpOkkL09YUn80lihGPukSUhNSOcBfux
 ob8ad5MRrsVtunMNt3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200092
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

On 18/7/26 01:22, Richard Henderson wrote:
> Rename current allocation_tag_mem_probe to
> allocation_tag_mem_internal, then create a new
> allocation_tag_mem_probe that lacks probe and ra arguments.
> Force those to true and 0 when passing off to _internal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mte_helper.h | 18 +++---------------
>   target/arm/gdbstub64.c      | 10 +++++-----
>   target/arm/tcg/mte_helper.c | 29 ++++++++++++++++++-----------
>   3 files changed, 26 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

