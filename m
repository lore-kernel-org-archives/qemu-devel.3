Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B175BC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqIm-0004Tk-56; Sun, 27 Sep 2026 10:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqIZ-0004T6-ID
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:56:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqIW-0006Du-KR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:56:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1mfTp1937555
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yCkHhUOi9E5TeRZUD7MQwmHijkcbCNgJnaThv2LPi7Y=; b=EZEaOcX1Ny4DOIV9
 0Cpj2Jg+9JONqqrpSfJlxCYVqcPYxU7+gH5bUukGKGkaEGuR2Oa7Oqk/K4Q8hrNR
 W9dLYy6zRtdWdLoiKzIDwpM7/OCA72EOrtnSgMr0fihoSphsuDFDTJ+CZfOkJdIT
 BQ84x4cGr3R6z1N2oPRM3xqh2zUL+/xrrhvj5ZTZ13VK4O69ZO+FqWQ8MohjADQb
 MFszi1f2YZAZPl0/f7Pa0YgQ43dzlqE4k9Apzcuy8MQPBGbmj45dVrRQsZcLeeiy
 sqKwOQe+Jw6vZrvR/J6bKLEtmPBfzcZUzFco1n3j/WXgCO0BuVwQxNfnGpolZ052
 yeOeZA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb5uy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:56:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c6a0d2122so129295085a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790520970; x=1791125770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yCkHhUOi9E5TeRZUD7MQwmHijkcbCNgJnaThv2LPi7Y=;
 b=NQ5CDfhaYa7+amGYhcE69d4+TMmjjolND7FD1Bh/yljtIF9n7oKYwDCiuEE/lEfmnT
 p/wVdn78nSykQifvuKIJl+lX8hRNBrL+CLP9dgKNut9VphOuPW8dANyw/HPaeYBvdLwi
 4mwfUiyDimcItRkgauAKcWQ7eFAFuvAeoncFJPhqOkgqeiyfM+ncPAFgvSRxQ3wLqYWm
 97UY91pgz6pPcBC5v28/VLO0T6QRU2G9cxT6OYHPOpem8ZDeSzJzrc/s0Aa5KEpiDN/A
 tuwBl7AvhJGbKS5mF4veBBydiWj5sdJjhrV8GNr22QYVkXFYozmKGzRox20Um8ZcJq3n
 y4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790520970; x=1791125770;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yCkHhUOi9E5TeRZUD7MQwmHijkcbCNgJnaThv2LPi7Y=;
 b=VFPyvvqQILeA7Mhv+J+dNZaPknLiBKnLark4QEYcKad/NS6xijPI3RMd55OvGH5xbp
 99E0TN81zuduTw0iwkvHC+YN0HVf69lQMq/yRPe4rm3+POMF6rgclgNAIP5pTj30oHOQ
 ZjZDzeKDDfmV02/tIf1MB3HpEsBHl8x3F87xta2VYD1q170vCumojrUoSp8Z9H6hoAgb
 b6LNYiSf6KUleuS9rQ4W9HClNZ70ou8V2EroXwTtAFGnufWG2NFzYIcS+mwfXcpze9gW
 rEKKrYw+vxvAOUcqFeudxvVbzhwwcYxq/QPxAatHTZelyEbGidpcAU2JKfA/5zOb49kI
 xRDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzubycyuXaRaco+faaIhI7MmVYAI0eBO2r1zmWkVxNKXaO0hisjJ7w1zYX2TfG1MtL7xfJjyw5klo3m@nongnu.org
X-Gm-Message-State: AFuF++kon8/aSZGJIukRtcOzGAgvaPxi+AlX7Dvo7KzqtjL6zMRvpM54
 trwQsJYPFNoX1PYGwEcfdwk3IJd/cAVrKowWDBBLt07B59VXHP88+ZglpMYXYxkCys8T6D8NILs
 60vKaREBC0BALwTpsIC1Qu8jyCOlPgL5tDVe5fbwMm9YkUCqzWaLpPTh54g==
X-Gm-Gg: AYBFou2kBD/zXd2qT9R/JvqvOanx4lv2sIloRZqBx7fljPMTOd7XLbz/7aoeF/K87F8
 1aO2NguP5V5rXLa6/TwkJrptF2FvVJdFp4YSiwqCGnA4CRJMNp/LN4yLF+sL27Z58h7WAs+AnAm
 ati5uqYBAFoPLvQGo6je0vFSOJsiKzFJ0SzqZQxclrX7SLx35DLaK6AV9d43dtz0hc75qZpGYh5
 /fiKTuWWHWdgLtePekwDlkYEXU2a8DEJJxJXtrLaZOGefZB3+3qARGqKDFb0queEXFIxe5rd6ZC
 bHnwPDUkiZhqXP47pN3d0b6c+R7h+b09QGW9u8zZ7q73OVBl9b5iATiYjjwvru3bC2qbqjZeK1i
 n01v8TOD3DLNmpj7rEybRE8toitjffn2inA==
X-Received: by 2002:a05:620a:880a:b0:939:b55a:3c7 with SMTP id
 af79cd13be357-93c43ca4152mr1479766085a.41.1790520969656; 
 Sun, 27 Sep 2026 07:56:09 -0700 (PDT)
X-Received: by 2002:a05:620a:880a:b0:939:b55a:3c7 with SMTP id
 af79cd13be357-93c43ca4152mr1479762985a.41.1790520969139; 
 Sun, 27 Sep 2026 07:56:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017656c3sm96707555e9.4.2026.09.27.07.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:56:08 -0700 (PDT)
Message-ID: <7f241dc6-cfea-40ef-8c4b-e422e68eb190@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 084/101] tcg: Use unsigned for flags for bswap and
 revbit operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-85-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-85-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VJ-q2KkQq0fvuzDmhZKnP5jZO9Cm4iaI
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab92e8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VJ-q2KkQq0fvuzDmhZKnP5jZO9Cm4iaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfXyvtpbVabPn4Y
 fqbdvQQ+R0vjmD+DQYJd+yLfwXuF9W5ihhpujqtNKfg3j2AIiEljkW0YkvQk6GP8iWe1VXjsRiE
 j8ZOP3WgNDFG9R1fCPzG8XO5kH0Z8plWdzLA9Zez86aqlE8+JqiU2u7DNpPpJb8y7E3OFJ/3D0h
 03aAVbPWFbDY0sPyFWYRWAEqlXOY3mm/ZVlN9QYZ7b5WWJ2hbnSa+bFo5xq1knc3TOLKF/tAgLw
 jO7GtJ0aE6CtWomKAxwU9UED2JhBmYAIsCwMQF/7lGJsNLHmBX/nV3irkgsfjB7wOId9fwOnZRy
 f1ZLTA/0SqhvfKSKynXrB51eFT3hiFa8yVe5+1+etUyurdUsr7GM9B0zW54q+cArQQRTPtKHt6J
 F6aIfeM+H0wt/Td7RPh3TJyleccQ08PeVmpl9UwjxUnESFc3x9D84gNw6RrgX/kFLBJWovwct5L
 5nXEWiXisealTmF5WeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX6Ctc1zfgPtMX
 SAmhk61EGb7TQvANwzbWj2BPMEBW2G6KuDaxVtGqTYCwcM0zu73beWGMRmCm+bHjcMBG17gcBZx
 yLP7p+YxNZvfWgGk4rXE0eGjANaan4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 8 ++++----
>   tcg/tcg-op.c                | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

