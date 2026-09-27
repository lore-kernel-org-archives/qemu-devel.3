Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978B0C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqDZ-0002SK-J6; Sun, 27 Sep 2026 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqDX-0002S4-0w
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:51:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqDV-0005jE-DW
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:51:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxRuc1329881
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F8NEGC13ZzOIb7M65qsZYL/Yee0GTPzwz/UWA1YeCrU=; b=pEd6jtK4h8kXy/IT
 tnAaG2BHkOrJKg5OTyRTKY9Kvi/Hq287DFwMdanQDK/xKelYm2+WCsrK7FBu55AZ
 3cnkTwKNjXaceaO+fPYKkPxRY2SpOq2yu1mW+qXzKqijjBHaTXzcOn7AyntO17VO
 e1srTLhL1QW+VglyObfF7TBQ3VulWhHV6VksfL1niAb4fooPwmq8BINfYHyAzvVD
 7nWrnT8jtOBrCHHvPCsWusB2n4ft6w/mrLwXXxZUpc2eIvxXEJIJBYYfmXBzL+Mq
 Ymqzle6MK/UqHLhN0wDWPcDCNUCvIsyaALou/Y/PFgqezxUFFxKylMlexC4vn9Y2
 4B8gFw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50sb9sj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:50:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a183a0e93so511132385a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790520658; x=1791125458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8NEGC13ZzOIb7M65qsZYL/Yee0GTPzwz/UWA1YeCrU=;
 b=alJYzGediN8ZpRhWd95ft09ljGfDE4GQif4Xews0GzLtt5XHs3YBpsErPcLaiJF511
 Pwo3zoRUmByj9DVbsMHY7dSdQ9cyCp/51FoN87w6GuHfSad0zxKzo0KzcMYmMsVQ2glO
 OvgMlA7Tm8ms6GZu0vwF58ZPWur9tELwSEZM8S+iPI/HyI6POSs6hobr+O237w+wYrVn
 36FqsvwQI67ScF4ReQ6kvkxskofOXdUrNYr9864Ey2dPMy4LT3VO8A8JPaHosSZpizjJ
 KXYPDW7KSUqUMUaMeWRwcSmY+gnhCFjOhjqj6jxvxkJVyNopprri/ha6skBvCuJrJfoR
 SWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790520658; x=1791125458;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8NEGC13ZzOIb7M65qsZYL/Yee0GTPzwz/UWA1YeCrU=;
 b=xvDeycPd4Il/Qhs0mVTzUoZoo1GGuVDRWXz2Dlf6HWRukbVQPBqaiJwbmFk/LmPPbx
 UWH7W5T8f/vPhhg7HfDSY6gbRzRRmqgNZWa8+/j75dQMlxT2hyWMWOgQOcKjS9Cco/65
 t650BM/3vGoqpcQuPXOac4oztp/wuP6njWMKdqlRGUsLdYsC5n45pvh5CqeaZs4RtMlC
 eY7pW922ch/5+Hw9508WHphuphr3XFzMHCgrWw9oFfjqB9BCMxGYsITJUGMeihs4WNWQ
 q3iO/6Z1A37hW61Y/VFa+P+/bs6ysLtBvcT0HdeIkHKt+o9FmUb9YTP0kPrZw7Qp/yfs
 68XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/o2C68CnHoLvY7+r9nzrlJwpxAGthqqECF/BgRpJQNArA7hrKWFGcXONH7q4bZfIfkhAEtPfryFdd@nongnu.org
X-Gm-Message-State: AFuF++lXyp28XTKKd/pqeCuWjngpU05OkP/ilj+bLK2JSb+LArOxRxkv
 nbymwuYruPx9ax1tpZ4OHE1DHQpqZAXWVbRGbuMqn+3bGsq3OiejAxcQzJAPNDdPSP8896s+7R0
 GOek9KSYgJKeZ/NXCClzYXeGLIJwfg6UeXRpaEFo5yQ7rjMm0lO7kSqgbyQ==
X-Gm-Gg: AYBFou1kAeDOFvPm6tnsR+amLrrEyQeSjFqDFIcb9owChduRL8Ji3RRmCRlgm8CgN8I
 9LmKtvj82JxK9xd+ystEzUzy60XbSPIGQcyJf+WiGohdjJbJWI2CPuttACpUzHhfdrJIdsDmabj
 SXabQOPeWABEwnXReWtNUqt3D8fbLG3nayDihUz4ZKHhcb9wztztnbynF8GqekzptcZO7gA7FNl
 T8CqCXv1P29uZSYkcajILT8N8CqicjmIppx20YTxKx9HtX8ZogpOxjD6pp+CHo2CnwI1TD0cxpt
 5N9UBj1aV3GrXeZYfWC6bJMt1CTqhEoXNY1zxQw35XIyINdhJezEktbK2y/wKHWj2wCFRJIXS7R
 y1kOGTTLXPhd59Ro84u/uN+5R5ToDAHtCyA==
X-Received: by 2002:a05:620a:4692:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93c43be3c72mr1552101285a.25.1790520657753; 
 Sun, 27 Sep 2026 07:50:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4692:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93c43be3c72mr1552097785a.25.1790520657344; 
 Sun, 27 Sep 2026 07:50:57 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001790022sm83345815e9.13.2026.09.27.07.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:50:56 -0700 (PDT)
Message-ID: <3be72542-655e-4722-8583-1ace1cd93888@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 001/101] include/qemu/compiler: Add QEMU_*_NONNULL
 attributes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX/t4pcqK+/shr
 kAyuRG+5D4CuvDbik3yAo2zChXaIa4bgtBLem2EV2d1pGf93/Y61b88yIdRtsJNbqIdUUYwos35
 jZ1cQauxvDMzrI0uWjEmCOll69Vl+3c=
X-Proofpoint-ORIG-GUID: LL6cOPZYY20TD1Pu4NBr2pQsmcRZZMne
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab92d52 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfXx+29Z8OXkQBf
 BUWRSfoHKxYnzvgv2u181UcJCJQFWkmiQ1z4nW/588/DAYBcZzDWJbjtD8sjJ9zfA3AyOyDUc2O
 bi4eAnbjFLTId5jslvDgLbzjHiaCPmQxYtAPv4vbcLH+YpGcCasQ2tvn+xC2yc6RDg81bdW6VQg
 pyVVQHGhupQVgY0ilyITAAc4RKzuN3Oq69KXYBbNj0UTDJVpQ5YLk9BGPaP/nJK+pJ44ZRqboPN
 0xIRqVkOC74cn28dcdK+Ykji21tVjBlbLemU/bBX5mpaY0+IxHIPEFKSK/A+Pdi6F3AHA4F1q7U
 oWludDKhbS6bHQHdGVYm0ZSwctN3/R95ZkKpqhgv/+eSPDFF7CYM2einT98OVMAPhHrAoJZsTyA
 wiEKo70j8nbPaRojkNVEKSLATQOhN5CERY4JN5NrgppROBD+u/fmNsGB9VG4vCFapYm/09ZNmWK
 XbvOmDbkJYSpTwNRWkw==
X-Proofpoint-GUID: LL6cOPZYY20TD1Pu4NBr2pQsmcRZZMne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/compiler.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

