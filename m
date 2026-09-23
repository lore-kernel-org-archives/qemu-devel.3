Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9FC982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Eql-0007Ja-5v; Wed, 23 Sep 2026 00:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9Eqh-0007Fc-3u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 00:44:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9Eqd-0001DB-H6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 00:44:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3iRLO3095794
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eX0bpIMqSsgGyZqiKt7F6H/FlEg0DRL1wbDyZ0VLzLg=; b=hMBos369f21Mc0DE
 b6e0iY3XRHWdA2I1daYFXTFVqGuLUjGj19nzK4+aB8BrOb9OdC3bMGsZJcLdIN4W
 qbqUY4TpxwXlwHOTdbhXlC+6e6TJU1lNtePnAx1DZlC6Ijbqzb5cB6KdMZZ8H66y
 uawjBA9Y662RXZv3avc8MIAIrLJ7Z8KHZNTvsV10RtdSInCCdfYYAeCZK+JvY0wF
 dfM1Ik9ODRNfeld1EmjwDFdkohEnV3SdT18CW1pwZRpOoyIAGbVXWSqepu34Dt5G
 ZAwNn4VQ183D2Ey5Qv6DF+UYhHKcuLZZ5hMlsGt2Bol+vtPlyxYz5YcceBr1acnB
 Lb5oFg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428ru47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:44:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9393ac4961fso80141385a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790138683; x=1790743483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eX0bpIMqSsgGyZqiKt7F6H/FlEg0DRL1wbDyZ0VLzLg=;
 b=PFb3dBe+pm6s/TvoemNP6yq9XDbqmMTJlDZh5gVJrAssQPWAYJxiM1/1E9r2o180n3
 7RsSuiHnqZmQDttQPo0cuyjOWn9qmE6naPqg+WnDm1amuZzloLAQ8D8OJDWK+POgMBWI
 jUEx9TEMqhpracUK7X/ZkQmx8AszYiu8Aex1+DTOKGQl8U62C2ITL6GIaeobylxte8A8
 crLlQy7HzmoIDaqPzlV5YlxotVrxzihMsIm8oqr1xxbBo80+huKojwQvN/APEOQDZ3H0
 HdwMBOait9GYZwnzzzMxLlvTn2AhpgXDm6F/Z+05aHvpuYk+KqtBJsnBvIdG7gBC98EU
 /enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790138683; x=1790743483;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eX0bpIMqSsgGyZqiKt7F6H/FlEg0DRL1wbDyZ0VLzLg=;
 b=tZxdft8c0gbZzgctYOhxZBEXUvaansnPLXYZTmPgafCuPo72UYnhT9Y7F27OqjNOCT
 J/3bXoiGDg+luzbPtSP0duZtzKK7X7PMOzUHxdC1l7k7lYb7VpOWrYCSXicng7ak2nBA
 mhxWDVfJ7nXcBlOa5FF6RZuVACTfFIwCb0JfmHQBUaWJcDLSlInttcRMQPZozcZZy1W8
 o1ryK0ibuVhKUP3ERzrrg0QvGL3/RPZ2dBZxQQqjjgoIXIiWDyd+lvyh/wIvIz774kbA
 OgNUkDOjyZNG0XHZJBS0NibQh165iErc4l8ZKI+KsCx2cW1N0OwLloDB9L0PXKhxk860
 Sezw==
X-Forwarded-Encrypted: i=1;
 AKwUvBynMl8OsN80Bg86cs9LoJkvm5nCNlHQ+AWOFnMzTIXaMa3HSdZ75QJ53HfZn3O6cp/iS54ovRxK3vzq@nongnu.org
X-Gm-Message-State: AFuF++m4JYzDX/3eDy2wiuVIj7mJMSxEjZKBK1Ms7ncLRmvZP7SIKlRA
 E3Da4yjr1Dw1xwJ7hGnL890SW3keTyZB+yaSxZUdkDWkvVKH5lAoAnurtLIUiOj2T8W8RYtmFCi
 ej8YEQiM0caTjv+7GZaLw/3/NQ55wtSxKaiC/tfXknGLiH67HyzNPw5ktYR///kXVGp8t
X-Gm-Gg: AYBFou2M6lcjamXY7snLDEEihhR1IyWkyfLSVAIL7UskRCyL6ftg6zhQRwJqvShVI7G
 Woafrc1i7XLM/Qy+s+wJFnFpWNPIwrgt/Ra7kzld0Oj/if8TuRJyUMYET1tY+r9YgwzinEGAx/E
 Q0K/aNmRE2rWbCMKimBLxvSYTGIuRUd6ogZzJ5RHhO1u1pmrqjPwReNNGMOkfhdPGqkhhAHRvpd
 S1CYXDDxzyxb4BnEgx+tj/jBkCF/Sc9+WDQ5cmEV/+xg+24YH1+hlqALerNJCCNHAnMe0xvXV+Q
 qd9AKCeQk+9YJYj4UqHrTJ6gB9L2t7OOPMczXFqpZpIOpkQtY+j8RIJhW7VsOcWX+V60IlO6x2x
 Oj9h6ZmAkemPQwrke3oEm3jtMpCxTTDv6aA==
X-Received: by 2002:a05:620a:7019:b0:93b:c6ec:7825 with SMTP id
 af79cd13be357-93c251af05bmr249704785a.47.1790138683248; 
 Tue, 22 Sep 2026 21:44:43 -0700 (PDT)
X-Received: by 2002:a05:620a:7019:b0:93b:c6ec:7825 with SMTP id
 af79cd13be357-93c251af05bmr249703685a.47.1790138682854; 
 Tue, 22 Sep 2026 21:44:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889926sm5255535f8f.36.2026.09.22.21.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 21:44:42 -0700 (PDT)
Message-ID: <7c824508-3149-43be-bb96-cbdc983ef764@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 06:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Set CPU_INTERRUPT_HARD unless no
 pending irq
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20260923031029.127490-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923031029.127490-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab3593c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: f4S4Zmera36tSINTeStcjM6HWwPXoJTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxOCBTYWx0ZWRfX9mPg99jbP/N9
 ny1VnTQAMz+Oigyqk6mGgD+0rMCsSgLh6Fmsl5xn/SB928aClnu/SI+FH8kpCajgMC8UQo0vosi
 GdcqmirtyaGLxX+QSR69k1Tp9J4YoFOI5Z6SQc2EviiAJn4hoYEXNQkHtcfQM2fVCkOXq4/d3zt
 sa3/IXS7EE9aVH9f1geX5ze9guLhz4319PGzskxBveunsj+rXH245sjAym1Am8cnvT2pf3Rxxds
 rvhP3XMCim+x3cClWh2GmTar0EzUbrg9Kd09E/1OT11g0Xny3pLNdTJHxSGRh6gWevJsojAShmF
 IjlVnWmCvKPBdD/qYXZzJp6D0LqvQXCfuX5xgmcKKiQ9a+GVQ0mkJviJeLBS4cYwPGRedinVJRf
 IKKNLsoNWv6PTx6PJvWqwFy7MPBCavCXq61fB9UJeQNdA82yX15FnkX1/KnOzDoGWwwvdWn8Cdn
 +raxgTooC9cB/iBn/yQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxOCBTYWx0ZWRfXz2cHOezaqy/b
 FZMzjEeuac6mSExj1ntNfQZSCJ4ThFsZBijfYBdAyWBp/AeN+nsu52MTRpJD7yxiINdmeDWDrhD
 2S4nlL50/AUi7Eh5d1IvQUpY1vWvTlY=
X-Proofpoint-GUID: f4S4Zmera36tSINTeStcjM6HWwPXoJTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230018
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

On 23/9/26 05:10, Bibo Mao wrote:
> On LoongArch CPU_INTERRUPT_HARD is set only when interrupt is injected
> at the first time. Function cpu_interrupt() is not called if there is
> pending irq already, this will not set CPU_INTERRUPT_HARD bit, however
> QEMU TCG framework will clear CPU_INTERRUPT_HARD bit when handling IRQ
> flow. There will be new interrupt lost issue when handling old one,
> the similar with other architectures set CPU_INTERRUPT_HARD bit always if
> there is pending interrupt.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c            | 14 ++++----------
>   target/loongarch/internals.h      |  2 +-
>   target/loongarch/tcg/csr_helper.c |  2 +-
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

