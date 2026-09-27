Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC140C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqaW-0006cT-TW; Sun, 27 Sep 2026 11:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqaR-0006c4-95
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:14:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqaP-0007rV-0N
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:14:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R2DH0o928650
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d9MOYhgq3f9aeianf0/cQHhXcqNUZQrXvNTqEnashPc=; b=IGY+4g5Tp7U6a8Ik
 hBwQYB5980nC0MHMxdG7PUE6lXVmdwIY7kJisW33ncy0/CUD+BOTYU75oo+eKZmR
 LcyyaO7yR36ZrEDiRjB7Vhqy94PRkq+mo2mRbfZiRU083CMfKqyvSc+3sKRgIAYz
 zTbbefVQHSJWL1sQmomlljUYK8/mNgH06g0vuEfnmwjRhTAXHh9NY+BSa42gIkFB
 WBlI7ccQOYokPW1kll7mC55WciAtcwRd4f3NLWDWTwB+v9Ud7e0W5vxH7MPrffiw
 0x8PTsrzRR+GFQX53br8YMcd0Pk0X0ojvuXIBQQPRQGOchXPGT3Lt2viouVsVPfu
 LiZe+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek370-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:14:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939c30aa9a0so237284585a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522078; x=1791126878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d9MOYhgq3f9aeianf0/cQHhXcqNUZQrXvNTqEnashPc=;
 b=YwfbgZQLbUGkRNWlz9BTKlJX0tPjvDdg/xNG5QHnZdoE82xxfSXC9PrfLotjLKFbGY
 34MBjhzlHidn0FpPfCR46DXDfdEdh1G6iOG3s151Ris/XRA5RJ32Sdk5fh8XnZpjZ385
 IY8oiPhtiV4fM6LoXfLtNIdlWcCS9+Ygj1kQVxpE7/bMcKziJmfz9hcU6uffDYGco+UW
 wtdOCZ9D8gnsOJvKWC76GO7AdoQDa8MSA4icPqaubDxQFs18IfdZEsGDzXQD7IJ5gH7l
 RrnMt73va9zCdrtpqKvxDpzZmwv7RhO2CzIdbOBqMkRovJ+MC+hTBMaq1aJUQKQ/uwDI
 erlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522078; x=1791126878;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d9MOYhgq3f9aeianf0/cQHhXcqNUZQrXvNTqEnashPc=;
 b=AHv9J4g3CPuZSBU03zUH/VyLYeIOp/Iei71MkfMnAbciGF4v4oTn59BTYqE+Q38HR8
 xWAitFzIAhmm9RT3/vHA64YJc4M3JsyRvlPRq8EgFGRNptzPpx+aGmN7sxRs9FDlKWpD
 88EjLUtK5lOYSYSY4QMn9RyVB3yiz382d3t5GPeWTRQDy1tA/Luq4jaegyV8Ehw8f4lb
 zI3chvfPee1IxijqofDJVY9phgIvc3Xk9I/eJitUwvPfbULcNs+vsuEZWYhphgdYu8mF
 dd/T0lwUN4T1BGsXTSuQgiiDbonPFYoSxEsiC6uHUKAmACDDhojMvBUk0/V+p+xuZW4U
 6lVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQY/6rpbo7GJCSfInq3d31rVfYc1AXXDKHcRtytYlzFcegT0ZZA2YWbPJM9FHxYo9DBxeoD1j2AQeR@nongnu.org
X-Gm-Message-State: AFuF++kbgK+nHL0AYhRQdkcUtlni0Bkp/1FENcnk48vJ5jDdq93KHy6X
 rQ4LBZDzPrr220aUVlDnGqEgzDwYtdPTgKQjJ/Ueu53qqXAg+dP7+Py5wVja59d2gYm+skYmVo1
 cXsHCVyBL73QKOYMRoDaKHAGewkUOCMNWjIMy+sAn7Gr9y4FOQKoiDomxWQ==
X-Gm-Gg: AYBFou0iavcCUpwMfr0Izkmmo/yY1mxD5u9fKk9bByiDktqkbxb80RAo+oxl/7KWMC0
 Dw7IW26sES3bGmaOY3Smb7wOqUFWYZBM6B81wqGgqw9YDg4IdV5whDqF7c6INbbn6PHBfx5rbna
 /JrWw8MwQ3W6Of/9aJA5dM81qxc+grz3ZntmlEN2jIZ8bm4pUASq2NswWUi7MUcqp2r4C2YB4qA
 E89WcOC212CTwtBlIlPI4fgMvPK35dwmSnGPXfqWbVlE/6Qm2OQjYk0Bcr2MR0ZVIdt42KltKhb
 5pNvA2nANvVJwEoehERTdWaDCf2IZaFQPQeYBEw0w+omKy9JJASl5Ji4b6wSIwFh03ngkQ6C2+c
 iHaWS9S8DzoKYteT0ifhSndvYb9WPuoP+iw==
X-Received: by 2002:a05:620a:4005:b0:93c:2c15:e513 with SMTP id
 af79cd13be357-93c43d34652mr1617918985a.63.1790522078187; 
 Sun, 27 Sep 2026 08:14:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4005:b0:93c:2c15:e513 with SMTP id
 af79cd13be357-93c43d34652mr1617914385a.63.1790522077629; 
 Sun, 27 Sep 2026 08:14:37 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ed6esm23007853f8f.29.2026.09.27.08.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:14:37 -0700 (PDT)
Message-ID: <74e5155a-b4ae-422c-8307-f91725690b38@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 008/101] tcg: Prepare for easy temp lifetimes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MCBTYWx0ZWRfX0sK17N7kMXgq
 5ITkzvZsQFgh3UN/ywgVrygGmwJTOuP7qaQLL2P4OF7pmA2vhVktsjeMpRCTyOWBuS9Ocxk89Eu
 HzC+hbENCAIs0i5EbTfSGu86lhnpIx66vW1Z3DZnk+qtccl+ppPpOFGdsq1aUC9iIJRI9C24P42
 vqle0NtCb3wsK6QQSH2n1riobS0cP+LPEkRerSfKyor5wtYnLalS9MLxxM7ISETnC0JQz6pwnSZ
 IVBm+ahkEiskHNCrYSCf/IcNqGlcxnfL+t2Nrcc53Wj3G/+bHAf+CA3aQ8ciLeo3oyr28lhDGf2
 GkLezv3ENZ8JfUZn9p4blLLAbyfY2ggISu91ZdrdlcvveMagrlw77RBlcgdUYhZcCL3GCkl0uFM
 cwcQEzCKloVolR3UdQm2yd5eqLaCl/9djXcSlhEncdI3ar+8FtNsJclhDFrNKS92A3pfZQ1vo//
 l8399n2o991WDvVgQzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MCBTYWx0ZWRfX+WILy0T2j0ul
 dZi/Kxu/baM5KO8vUtTjbnunjtZcLW/h8SJT8575opkhvoeSDydUgcQBpkZZ6av3/1eM5zeakes
 FnE5U7bNip+yzt9pkWbvNYzWRFsZ8io=
X-Proofpoint-ORIG-GUID: YMNkTN3oq1wCqTXZSp0dBQOtGDetZJVR
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab932df cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YMNkTN3oq1wCqTXZSp0dBQOtGDetZJVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270060
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
>   include/tcg/tcg-temp-internal.h | 2 ++
>   tcg/tcg-internal.h              | 5 +++++
>   tcg/tcg.c                       | 4 ++++
>   3 files changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

