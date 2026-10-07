Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830DBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOlN-0008D8-37; Wed, 07 Oct 2026 06:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOks-00082u-Si
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:20:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOkr-0005tv-Cm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:20:10 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jeMK3194063
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xdnvxDLuV2fnxCVR3GADhRYTlbWm6bym+D+rkcSaU0E=; b=D0ajOLjpOTLvXiK/
 fCyoWaM9gimk6kK/xksD/97VjQFcHnXAuobMj5/9cISW33Jpy1wdgCbIPQJaC+vd
 mUqFkk6pQdc8guTTkUL6hG26sRa935ilh9FicrZlG0Dm21nOmkaALCM5a2W+bnMn
 3f2y3tETey+SHhd5qzR73Xuo0a0Cziosw2NNwl/Jl8HUZDZ7RgjlPkkDfMtiphb9
 sFK2M9pFNSoEW0tWcT9yloCmecEq1x+dblA+BR29Sk3XOA9wFI3CRdN/Ins3mB9i
 yKnvGDTtIyA+IfCeO/ae7kM667FNjl+1p5fCxtawp6eX1vX2k0Z4tPTc3SkVJt6x
 5379Wg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541uksyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:20:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so662765585a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368407; x=1791973207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xdnvxDLuV2fnxCVR3GADhRYTlbWm6bym+D+rkcSaU0E=;
 b=Svu0illwf5Ug4SPhB/cUP/+Cd36b1tCn+OhtwoMNMGrqXZA+wWMsMwrAWVf1ei1eGn
 5n9g7WItpu27Uur2hZpvGeebB89qzeXiOubZoKh5YLeopXxro+fje7/PutVIPHYytjyX
 +fkYaQYJOG5J/jOYHBH7oc86yhfsSyLa0OJsMr2Rpdjebfs+IeQmo6opCOptqgzWJzMQ
 ez2yP7VJ+ckI/Yn4i5MX4xQcFpXbCYvWpqmQiD+U+JvCTw+7rTq4sYOk9Jayc85p8vBH
 DTJ+pAQnCMVWqKVGhPZqomv+3XVs5cAojcB3olBDnGZHugPrQoIfHNG4yZK3caYnhT59
 amdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368407; x=1791973207;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xdnvxDLuV2fnxCVR3GADhRYTlbWm6bym+D+rkcSaU0E=;
 b=pFC4rrRS2KfiyH4hfPRWtD5uz5F5Je5R9LaPtvwpNk1bRhtX/+7IeZVj8Gl9NcHTPH
 l3d+M9VJpdbRPGhNFxlRRmBB8sk0aQXA3O2us2IDEoded2om8eQI2ZEczf9dQl8zQ/+v
 n8EEdTfUqKdHaQbiU903G+ICuNWDt5lYbhDIoqS9lnWl2dACBWqxvNhiyEjoH4euhQn6
 3NN7hVbKZNrmrAdu+k9qbeF7ZJs2tSDIAy5Yghmiku1QsGQ4yO4jGjLPfVSdNl7n19vQ
 8W4D3DIR6I442yDgfbRDgVMtuqNroImdGUBmA176Qny8cQd58/BhG3L9fgQlGp5nQbWp
 rvFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaKn5L8iSx6PCL4TLtlxq9JFnl/RYHimF71E1CfZk9MsvA+qOizRF8UzzFYKOkdi055EPvAJyjoSLG@nongnu.org
X-Gm-Message-State: AFuF++nw/q3zNfAksEhXTfuhL83kDd69Ed0tUpdZkTx3G4ClBmIraW5M
 Ni6+EZjkhgcy4henf5qISmND2N8HW7Nsx0KnYmbdZ7TC6rnqk4gNx+Rk54Q1tv98r2bHrBnNQRd
 qoDFpHsJeqGh64OFCEtgIAsNiyS1HzaL2nUD6PwZlRy88lGAP2r0iinqceA==
X-Gm-Gg: AYBFou0CmelFISphE+3jH4q7am9ZaR2zoLQN6OcclNu6FM0W+Qqs+BcaRSm6sRu2+Qb
 mgxyxOiXewE8x1VIcYipnNCAQG5w8AZmpAqVOvIhS71S+RdphYmo7GWC7p3H/IVi7PDJPlPTDR3
 9UvzXWr2Dxa2oGsGZzH3Gs6A9D4Dx0bxYwk1s4tKyZPTUnCj/pNPhqs2lNEX2wKc9IIpG2E3vC3
 hnqLWXT2ucEDZMNalZbWlD0MeyxV2xYHS/24fmSwvpAKxWRsOehtgGf0hoFP2YCoczcQmRJIdwk
 A5wPoKxKh747H0JtQRIuChUVPjkmte0QT0q1oVfXros0MEfIHEHyh+f/+2lS/bA1GcyTGsI+ZPt
 ECqt9biZkD2fwSA5ULdGqK/bBuukpcgGO9w==
X-Received: by 2002:a05:620a:4091:b0:93e:4e27:359b with SMTP id
 af79cd13be357-93e9b7760d5mr340006685a.24.1791368406821; 
 Wed, 07 Oct 2026 03:20:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4091:b0:93e:4e27:359b with SMTP id
 af79cd13be357-93e9b7760d5mr340000785a.24.1791368406037; 
 Wed, 07 Oct 2026 03:20:06 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c50f54sm132887705e9.10.2026.10.07.03.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:20:05 -0700 (PDT)
Message-ID: <6d807b6f-7f14-41be-aa27-673e12209dcc@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] target/riscv: cpu.c unconditionally check larger
 MXL
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-8-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-8-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MTpmkMjWKXopQexf1eYqbRb4hbEBGdA6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX5pf0VkHQZFTK
 qe4/+w1hu4FNKIFL/GyEq6RmixhdfgqBtmGRVgcMKwQ4sCVGBKizED4EePjylCTswN4G+dPrJMH
 WvKpi8m3462nDGPIA/jYTWhJ/CMTIG0=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac61cd7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX3Gp2waZliba1
 ej0erdzQ8crmSlAlnxTTIeeRJQkSSdkLF2vsdP3Aguj87hc7E6YSPjsweTisi9Pp4+5LL7c+9u0
 XvOIJ36wjLSIHCBazwhM6Wgq9lxwM+JJTqY1uzXEWn4wUWegYJTrOAbAUNIlBXhYG1FWvXihptL
 OR21yasUKiNTvkPdmXoOTJ5//MA4ZJJZCmZ1DPYBCvXGo2nk/M/i7VUWnA7jcosgDYkuHHSnM6M
 pb+Xu/bDsvaEIGBoTs1PDnnwbR4IWcre9EpA1D+fq3uGEIXppc1S1FC72nBy3szK+/5pXuDwJgn
 C/JhrGYKYEKnqFF+g4tVk7Tga9/dF3Q9Hrwn1A2l3y2uC+LQzKuxgh59XMC7KFUUF0Ipn8Nxwn1
 zIDPorFFySVv+RJJroTIvMdnYUEUwpZolC4dvkMsCCw+zaxumhFEDs+7FTkCwRMaU9Wo6D5qtPE
 GHyyOHqCvSBZ/oAjbJQ==
X-Proofpoint-ORIG-GUID: MTpmkMjWKXopQexf1eYqbRb4hbEBGdA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070041
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

On 7/10/26 10:43, Anton Johansson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

