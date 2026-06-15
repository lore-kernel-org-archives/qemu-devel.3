Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5372CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5v7-00019y-JL; Mon, 15 Jun 2026 07:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5v5-00019a-Jl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:55:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5v3-0007iR-Ac
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:55:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoKei2481144
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ovt2M8AcLzFY/PEYWEuMy6HeJmNvjEOEWubnVI8F0EU=; b=O76755/7ZPwvyJTX
 PRvpMJxnTImmfYEdtWz+im+4SiYuDYTMuH5Z/f1XnkBxznPOpylkruKZeH16PnbH
 fPML/EB98y3c/s0drd4B/pHAUhVD/yIqajHI+7lwf0q82IQtQs0LhLsenwEmyhZ1
 FftQevmBwoJMFR+OR0mTEGeBD00pM1ASd7Ir6j441gKmbtciYa3PTo9V00KhTa6N
 qpoHE46f2vdvJSPNfQRgZPl2c9PNfZGp7oKtoFU+aWv9bF7tZ6+wo8b9KA9XKdfH
 x7yJ9kaU53Xuf9F5o7daL5GNRAvIZemdOfwQbqrZ9qPSJdO0+PPR2lOy1G0XDPs/
 S8Jkag==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete980pcb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:55:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157a31ac37so479889585a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781524555; x=1782129355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ovt2M8AcLzFY/PEYWEuMy6HeJmNvjEOEWubnVI8F0EU=;
 b=a7eUrX88+4q5ExbKbb1IkEwSg15At499x9tPL/1UdSC6SFCav69SaAglRjvX5EeA+K
 4CvzlITo7hKGTDKGU5TxXK1AG8F+PXBBxRLVvswdCWfJDNzJXG3+9GRHnp1Yf2Nk6+iF
 u6HOFpH4fvBT1g5XBcwF3Noqw6RgUSM5a7Er3Gt9RGpuMR98GlWmXnE+zKitjGFnNLWu
 /s2OKcN8Kd3XyskVaXquyJqf6qPAJEFgOLf9KA7YYwnEjIzDqgsABlEE147CUEDezG/o
 jd6gb0lxDG10Zc55o6GGHFSXEOQKghXWpgshAJdVzpuW71R9hKjogpHsgD8Pi/zvg0oq
 6iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524555; x=1782129355;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovt2M8AcLzFY/PEYWEuMy6HeJmNvjEOEWubnVI8F0EU=;
 b=Thv8UobgUhX+ovNAe2jG9zvhGjz6XbfXondRe6CYYbUbaNf2bDeVr4PuPWTiQ3xtLX
 DA+j3hwUGpI7xRoeGFBZlBsEWWzqDuxcdH6CFremB35Z7HpAfDvdi/a5YaKwfWTi06qi
 QmL4zq08+cvBAXz3W0/49bmYxrgp4fcXp0TgKeSPo4X2n1pSz7+AkVrWEHo1iIIkNsOX
 82+O5x1TWyyG+ky2fxBv2HsHxdyUfTL0ICYe3YYqsBSSb8XeiH9PAvqjnvqtyQviQSGO
 ucgx/Tzrq1lB69UNQwPjCbjx6d5Tbg75WmuHbVWLO0jI8WNC5qrSkxU/FMMM83B2z2Sg
 A3aQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80iIz6Panfws6TVJTfr/kJs6CCBbUdu+2yUOHrl+b08b+fiTuYM010yhMZ8H69USMRE7Zo4bs6Kywe@nongnu.org
X-Gm-Message-State: AOJu0Yy/4xjJI92w7yY1t0Pxa459XFo22Mdogmi/PqXnijVvF2V1SyZH
 hoZX3UZv8HsS9mIbU+xfjvIrzcXS1J3epq/VnU7TrAsPaHwBvA9+Zb76AhHg6BX9QO4z2MJUDkn
 OvILtAshbWpYrllja2dZPVR6dn9tpMDsKSzwh+bXqZzsY1c50yBaTgRSYGGaICxQ+3A==
X-Gm-Gg: Acq92OFi1+FzTvEETrw1wfWaFDoELIGLjDsZe0F5wJJRcK7ieWtyECWMNxBca8ZfiKj
 JOTUBB5lqki5TJV0AMARUSFmtUEBEtkkNmtOijbVfvF5y6t10bGrX6aNrlzxUoAaLdTmxF9wA2y
 paGXSz3kLB2Rp6zoZUJ27vNWtzwrc6ifvPaPN7YKT9KUbXLYjYoOTDioOTRSXCmrhCgL7APYOJV
 XHhJ8P1eUzJPiko2aofRZr1KVejbk9t3TeAhi+ezPezC5B1GAUKOgfZEIwrOkYgXpp5lgckpoel
 8wK/iyQEyPktNDvxYJDCsU7HcBfr1J59Psngnl6uBn56RaMopFF6KCcSn9V7PMjAjkfUZCS4vIx
 yvcH0FENmc1A92EnQW+KXvPYQdMChM2J7exyM0nGIpFzIfoME1qJM8aOtn1msMsRdTfc5V6zB
X-Received: by 2002:a05:620a:2806:b0:915:e602:baf8 with SMTP id
 af79cd13be357-9161bd40c9fmr1977037185a.50.1781524554971; 
 Mon, 15 Jun 2026 04:55:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2806:b0:915:e602:baf8 with SMTP id
 af79cd13be357-9161bd40c9fmr1977033985a.50.1781524554587; 
 Mon, 15 Jun 2026 04:55:54 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937938ab02sm3287281a12.17.2026.06.15.04.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 04:55:53 -0700 (PDT)
Message-ID: <7f1d00e4-cbb5-4ecf-92d8-4fac63ebf742@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/arm: GICv5 cpuif: Remove ICC_HAPR_EL1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
 <20260615105029.2898872-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615105029.2898872-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a2fe84b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eTemkp9eSbVEyWtS1TMITwAk0ozMSrD0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX5J4MurQyZiFS
 9wwowybDkLU1Yz5JeWbDneAnjMArn0GTWScEC+2n9B778hpIL8KlOzc5Glwl1dE3orV+ejf/3nJ
 7v5CLcFbR5qfJT0kuwW+H276mrU25YE=
X-Proofpoint-ORIG-GUID: eTemkp9eSbVEyWtS1TMITwAk0ozMSrD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX9xb8tdc/qsfI
 SivzxAzCv9jiSuzOxqfHHb4lw5DxlOYFXosQA/3+aGxCKGpbn2+eQiHByHv4r+Hecso/+rGTyu6
 thgoCuQ3lBfLoXudLpW+wf426qLvCrniJlb1OeRzCodr/QuxzZC/Cl6y0kRD8WkggH+nOmBFwDq
 DbuQ8jhJJlZg0+AaTe1o+q46nWMnesiGm27Wof7/zJ9AByYIHvRLhgt4Krtw2toP9PgEpF/tdgb
 nR4yA6elSQB60HLXCFERjyYtELZYn6LpUoKHja3ycCVLpURR3SdLFkpjtnfpJYdbrzw/HkPTJH5
 RLa4gamnlNNXXcjS5ViUB12hojRVYjC8QbFXc7yScCLGmAfhXEvM+MCNlGmFBwclgMkEppbIVVO
 DsZpUd52VTTg828HLmhf+kiOdJtR4ukAdcFUSjdE7PrvydbOO9awIbvCjKGak68Qjeep9NeyH7w
 2Cue0y9MahYZE7Dw5Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150126
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

On 15/6/26 12:50, Peter Maydell wrote:
> The ICC_HAPR_EL1 register reported the current running priority of
> the CPU. However this can be easily calculated by reading the
> APR register, so it has been removed in the newly released A.a
> version of the GICv5 spec (IHI 111701).
> 
> Remove QEMU's implementation of this register. (This is OK for
> us to do without warning because our GICv5 support is listed
> as "experimental"; we anticipated that this kind of spec change
> might happen.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 14 --------------
>   1 file changed, 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

