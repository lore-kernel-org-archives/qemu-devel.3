Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B9C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqi4-0000qU-Mz; Sun, 27 Sep 2026 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqi0-0000q8-HS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:22:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqhx-0000GN-Te
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:22:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RApbso2376652
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6qI2DMDTq9aogRwrOh2kWUFVgzy32t/g1CQ8H1LZguM=; b=oXkRCr2BkqCEBCdH
 olpwWpNkp1Rm/BtQHlAozFqt90Ma5B2iIyNr84Z4af1pd91o9JpmwTm4Ra7uO4dH
 fw2Kl4gRXrvQsTYg07GsO1PrXVjmqhD/Al2LP73k03JxbD5FE8rEOIcL47XoSA9W
 vpWFx2bccrVXth0Ps+VucfA/Dx4XlAsAmZnESYg9fguZFKrF0DJz1k3paf/+ownr
 5CbY9mKxPZVm7wPx7wgHkYt9rvfVZxTAzjH/9CebCJBAB6+bmzqRkE2NscHvQuek
 D0jYnjB52nqdc97MdqC+Ng6RFcdRxg16aJkSwFGiEC4tvrcylKJyhnsTcJE/7mcA
 s2iNhw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp3g8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:22:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c673116e3so167004085a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522548; x=1791127348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6qI2DMDTq9aogRwrOh2kWUFVgzy32t/g1CQ8H1LZguM=;
 b=Gs1wy9QUCbRgqKhFbEqvtA5i0Z9unoMc9KD7qPQvqqEZm98MON+IndPr2L+N8vquy2
 isnwE7TK0of75hJwB8inYGYWX2xywBmNzYFI+oOOGzFtva2mcXAj5jxkQ3O/nkVvTWQO
 6muQoIqfGdOacftiNMkXg80710PzQ0Pm17rjavWzcdwqHCVjkSfd7ThyFFQbFn5eKBKa
 VhurhTpkCeMnKVAQOmDC47JCCN9ypG5JKDVroZPsNLchX5QmSBuhtGF2BqNaQJI3si2w
 lucC+zvfMn7h3YNtybTaze1urnVD933GjsusoFJOY5462OSWJndroPRkelfNsvLPO9p4
 Locw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522548; x=1791127348;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6qI2DMDTq9aogRwrOh2kWUFVgzy32t/g1CQ8H1LZguM=;
 b=U9xVKi9eyDwGKPup5NKHgT5Bnbx+3vdMC9npVt5X3PBjAul3CioH5NLGPeyajpV0dE
 e4D5JkrY9jDPGyp9N3evK/Ic+u5mB32ctah1xD5IkgwXTHW3MvtfvuDShsNj9S2jLsgq
 XZks0lhdqZyJyvM07SxT6Zv9jY5w2Ha+i2J+Ps0YoqZWfq+arW9Wux9wAjPYX0lYx/Eq
 aJBJx2EQE9jWPhqrvlwFa9o0R0fN5Xsjyj1Dt3wKrDnEQ4ULcaoO6IVhjd0jny/96lIN
 D36CtfBLf/4N1hVHtPADFeV/day7m+FA0S6OctUeZgNMxNQsLsuUOoNc2EOU3BsDWcOO
 osMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw42qZn14WnG+5YvZHvfEFkgk9s0rdEy4d/32GzzEYSYdCl9IeWHrwrdkQIrOK5k9gEH+g5AOdBZ2l3@nongnu.org
X-Gm-Message-State: AFuF++nsQWPAgfsjikKC8zoriv1e+QkQBCh686qx5zf06kay+8PnNfFe
 WPXaUIcQ4nXrXHrUCeK2YsftveMwcHvGY7btlo/Ns7JYPyc6byyPa0sfqnR45L+g+HdsgqJgC6a
 LlAiVoXxtNrsSYXwwVkYDmzjZwACE8DW11URWbCHsWH70k/SLGqN2sBAzapwzIohqoA==
X-Gm-Gg: AYBFou1Jj28LTAJzP+2XvTUtHnBMvY8yLEuOKMW5OUAXZ1xnFK7GcMdz712xizMaIK7
 JA3a+S825whtJzeMD+tqMlJWesaL31dEG0wZwFnom7g21cCDrE+jBra3Lw34rcNxJT28Fi8UboV
 HP8cbWmidr26Ehg1BUGt+l6oDqj6Mzj+u9jKb+29gWr4MWhlgD+0YK2t2DtD3TyqA9pRfvlLHHv
 XYLHEhKvi7/c8CzMQmReu1OIPphNgtDhAzbceZRzH3wGP4UhN2PXq3Cv+x4cUBx9gTMANkJJYOH
 i1e3WaExiHeffDXVlHJx7YcpgXn360QFfVVUkUl6kjFdDJJaiOgyXVnXWeQ4oiaGlSaaFCAHTTw
 F7GOgubFV0R4BhfvhzsT8BaNLmpKvOsFpdQ==
X-Received: by 2002:a05:620a:72d1:20b0:93c:5c60:c3bb with SMTP id
 af79cd13be357-93c5c60c706mr573348285a.62.1790522547871; 
 Sun, 27 Sep 2026 08:22:27 -0700 (PDT)
X-Received: by 2002:a05:620a:72d1:20b0:93c:5c60:c3bb with SMTP id
 af79cd13be357-93c5c60c706mr573344885a.62.1790522547346; 
 Sun, 27 Sep 2026 08:22:27 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6456f8sm20617510f8f.26.2026.09.27.08.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:22:26 -0700 (PDT)
Message-ID: <da61e797-c3ee-46eb-add6-b5cb37b7e220@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 014/101] tcg: Generic expansion of tcg_gen_sub_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXzKd44ri2NSPi
 pxkT5sjinHXRWnFqHci5wqF6qEVoirBz0h9oyqjEWzzK0WWQOSFrHhKzj6+uFAccS6IWczhPKrF
 F9qoW9fIv5ENJCYTl/GtXiifuXJmZYeZzhjTqEId4lfhPfCmt250NnTPUHEm8UxVDpxl5dd+cc1
 9/blxa35p56eauHBvft8ZiVTu6JC2Pl4rVfsGyP1N//MZqvPSqac1hawr2wRYWH+9Zh9Dhto/8G
 28IVQY5VIZ6umer7Oe2s8VYb8SzeO2GMz6A/sGq8a/DK/SG7IWy0ZHyLF2J6PJtWO5t08tTNRxo
 76d6mAClzu7jqL4y+ByIwtEJzR1c+cSbsZkd4tg4TTwKfnvmL3CVZIN3MOsonYwWdmlMRw4Eo34
 QXv13BMMbtDBSu6Fg+2IPrkNPHT90U1YZCLsIEW/Q/BrHEOtrOxud5GB7jMF1DRRPED62g8uJaM
 Kvp36fPqY98YyctUb9A==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab934b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZSz55xfidKxXIdRcICAni078Vep5gHQy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX+aVXaRWGJIVO
 rNFthF1U0pbBW58Yc5onfniBetkNt6F/b7n5LSGtY9nyqT1S3eNHEJPb1j0o7DEXKhjpQ4NG9Dm
 c9aOQuhfTRp83kEVpTKgRwcib+suLh8=
X-Proofpoint-ORIG-GUID: ZSz55xfidKxXIdRcICAni078Vep5gHQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  3 ---
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 13 ++++---------
>   3 files changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

