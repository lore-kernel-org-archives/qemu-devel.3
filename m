Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92A7C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmmWk-00056b-MP; Thu, 23 Jul 2026 02:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmWi-00055K-RN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:03:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmWg-0005df-IX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:03:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N4vSeU2850590
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5dIfXP4k7T0w/N6bzOXXDpCcB1UHw3MNkwDqEd9a3VI=; b=fxZByc1byi04YA+D
 129sKkwvYJwuMkEmUqicYka3ATZNeX6oqrWyNDkzqLXfSKHdv+rixrtUNRpx9NEk
 zvf/MsbfeE+A0GdIIX6MkB2dJa7UZNYUt3U8X+5bmOkDz3Dc6rLt1duQZ6wCA8iu
 Hki++YLnxNJIvfI0Jld3uZftgX5wk1c/z5QYaQXIV48yBi9sc0A6Jr8uhIFi+2FX
 NujOIOKCVfG9ow1gfCrA6eM64ZqC4RmpPcbpP0BGvAYYYjNrZXXUJcXtQ8DXjIAZ
 VeGWoYUzKVZl2aumr0wLUMUT1wcgt2/eS/II5iPNvw1M6M2BBcilbRCiCThh0LWe
 3NhrPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk275jk5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:03:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so5450601cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784786599; x=1785391399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5dIfXP4k7T0w/N6bzOXXDpCcB1UHw3MNkwDqEd9a3VI=;
 b=KBOqkl/P1voth13BoN3XP0pClhAU2+psm44rufVBtKNiu906jlcAKDwT21tp6Kzioo
 lW0NnzmqM8VojzdeqNLlmKo7KYmt6qAXFvD+00R5S0JYK2tjB2femWSAKcGJGpOt1HhC
 9pvY64wCWEFcV4FqKNjbxmY5GfRXoeeoIrTjgNe/O5jD7g2PRH1ztpmvtxkS8CcRlIyk
 pPT+5TDqCLvS14AjoW7QlFwv0tP5ggGX0zBfjXBklH1GY99pMhwVKh4lCcWzuJJlePC3
 ZVAjY5E2Fh61XiJgF8+U1HNRbyIzrK0+Z8YnycUL2A+eGpTkvbWZIBZs+rAWdC1nZ2iI
 8BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784786599; x=1785391399;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5dIfXP4k7T0w/N6bzOXXDpCcB1UHw3MNkwDqEd9a3VI=;
 b=F4FY0fnumUdRLxKVckNEMT3P+HvYvu9iij1brDQ3gpDz+/kj/yF47g8p/eRp/tgsbB
 wmI/y8UJCqvcBqH9u/3rSfUiBUkTxRzwwXVUGiHJqyJP4GLhbW3Ny0KYUrGa9Ok/wbpL
 PKVGUaNMUc+KOnnBBvEjRZNVFPMR+TB5Prf+lBrPjsMBVD1bausJxxeEPpwmhxsRLN6n
 hmCg3jP6PCpQ/foPV9FRXE8gfq4bY7dvtxqoFAR7LAhfNI44zDD29vDlEje0CDVQ4XKx
 k2yvu3Vy/msGT+56PmeMC9KyHkJyU/7hlKB3Yn3b+aWb6ifFr2J202mVpilvfeegG4Jm
 uedQ==
X-Gm-Message-State: AOJu0YxZ6tjSAJrvqhicRiz2hakVv3NuN4LYykOut/5ZbW7qv14WDqid
 rjYiZW8FWVHal7Hj/nVGz6Hinq6qIBt7/lRZ/Ut0sNvWpm4OaUT74zc89hfPPUgLoHUlIZ541lL
 eZlxGVZFTxOSkdOC5tqO65cyrZiDwmju9nWXIQGu++rC+MmJMQJ8G9G+lQw==
X-Gm-Gg: AR+sD13evlkN4u01EME72OBAB/DbLKymSPWPD4xODnvN3dp5YxV1CdP67SL+77lzeUR
 sN3ObsLhrzKmCUQYKNJF/wOjpacAG/hcrnnhETuPmrXtpTn0PokryW3wVQlyKGAzWExnsarDEIb
 yW/+/yhVixGFejWALRZ9j68aBOvIubxdiDs46uXV1nvtRU9awC6dtvOcBM95s/2Arlr74SE4cyD
 UlN2t7sRR1x3+lY8dYWAl2Ce3md+w76etdMgBZS3q1BDrp5o4qd1klkFhGY8dwix6dclbI9FsWi
 AFez5LA75EyLI61nsb8RciT2oupaxH95AmTepHHN2DwJQpyZVw3IjDgVA5FqV/3QJCN3ORnr4Sj
 ITa5GgHFZzrFe7pN/RHjRH5V6xxqjFi3jiPel0oHqsSELyG0wdas=
X-Received: by 2002:a05:622a:8c:b0:51c:db4:3cb2 with SMTP id
 d75a77b69052e-5283df63187mr14764321cf.63.1784786599039; 
 Wed, 22 Jul 2026 23:03:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8c:b0:51c:db4:3cb2 with SMTP id
 d75a77b69052e-5283df63187mr14764091cf.63.1784786598447; 
 Wed, 22 Jul 2026 23:03:18 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a508aa6sm126057685e9.7.2026.07.22.23.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:03:17 -0700 (PDT)
Message-ID: <d30675f5-4719-4622-8a2d-c50ff0d27eb7@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/cxl: convert cxl-type3 to three-phase reset
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260723011625.1117034-1-junjie.cao@intel.com>
 <20260723011625.1117034-4-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723011625.1117034-4-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Q53iJY2a c=1 sm=1 tr=0 ts=6a61aea8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=9aJME8LnsKA-8nNKvUIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfX6/2LIQC0VbcF
 lt4H5PuSmI8jEzZdXsTNvTMzbZfAFhLXACnHTKs7Zeiau50uYuSIbBKJf4Qggd5lxE8b1XM/s5W
 TTQcJ4a6WIABOgDz1Jjs8Iuwp1fcy8w=
X-Proofpoint-GUID: P0h9tC5N8ragt02_f8b_9lFUVZmXO_kh
X-Proofpoint-ORIG-GUID: P0h9tC5N8ragt02_f8b_9lFUVZmXO_kh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfXxDYd0JbnVRPl
 G+HnVwD5fVEiI0QgNAarn4yLkdeJOqpNXFQtVbIbRvRRwSsuklRBh7Fcm+vTIE0Q6g+lBfUN0jG
 fw2zRMwWMICME3XFxFffNuk9Sab/WdVBgVkF8Xi3GSnj08xkF9oidrbujDzZyUgfgNapBOLf7N0
 lKRRHrLEw+yqGTmmeu8aP+jY42BZ0YkdsfoOch+kaBFYdjVFnpoNwYwBiTS6A6CHpokG9BOt92G
 EctIbq7nHn1IqhsRn/mcz8JQ1gtdhf/QHusEMJR5FSg8Sra/Ffp6oYsQNMcXVCtDdkvgiQaX0Bx
 ldcxVaesDs2uHoUxQe19iFaZjDS0Jn+OJdcT6EXnD62rfnFrO/XnNBvy/0nHmkiSK/Sx9XBlq/w
 WFn7ITObAxQp+OXaREuyruc2fOR3fUxUzwLew04ATO1H4+7tWLMQJtOJfe1p2eLX1jD+PidxUTz
 6PVXsqs513A2uYtMgIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 23/7/26 03:16, Junjie Cao wrote:
> Replace the deprecated device_class_set_legacy_reset() registration
> with the three-phase resettable interface, following the pattern
> already established by the CXL root port (cxl_rp_reset_hold).
> 
> Only the hold phase is needed; enter and exit are left NULL.  The
> parent hold phase is chained for correctness: TYPE_PCI_DEVICE installs
> no hold phase today, so parent_phases.hold is currently NULL and the
> chained call is a no-op, but capturing and invoking it is the correct
> forward-compatible pattern and mirrors cxl_rp_reset_hold().
> 
> No functional change — the reset body is identical; only the
> registration path and function signature change.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/mem/cxl_type3.c          | 16 ++++++++++++----
>   include/hw/cxl/cxl_device.h |  2 ++
>   2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

