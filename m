Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952BEC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eRT-0001Dj-N6; Mon, 21 Sep 2026 09:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eRP-00019W-G4
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:52:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eRN-0004dW-D9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:52:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LDp69E836989
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +PltYelwuvegL5nB9DOSitBw7uB8TWktsNrRIT467U0=; b=jKjW7fV/6XMar25y
 JKKRjCIJGmcJgfQkFwLk7H/TnQblt1m7VYDevkbMxnUcxE6htSKO5ZjyvbyyGbJh
 KeJ6kF4pf0rpq5UiZH8ieFdtqo/qFMSvlSGSy2h4nxvsQX5U7b+YPfkXXSImblND
 OL8p557ZEglHUVNvi3CbWAR4NeDdYHf1NJ4PZwn4Sd2ffscfi2vrXUaVxtK/239N
 Tv515o/uMPZ1mRpvOGquALHJfjTk5HrjDXcqqP8laveQE6V9aEHWkqceCLC2iKtT
 cVqMK/r/CMHnwKvWjDnoupFfZcPsh6eTVCntQjw5aRl/R8fbb8XUiRCu+YZ8/I3b
 kne42g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq9juk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:52:15 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7a8e3cc28e6so902852137.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789998734; x=1790603534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+PltYelwuvegL5nB9DOSitBw7uB8TWktsNrRIT467U0=;
 b=GmrKjkhSSWg4O7j7Mjb9jbqczfDqYbXeYRMtm8WFZ9RWIKp1v+mqDmQLygyhxwHqqu
 F+l+WvlCRBqW+a7C9G7EZwOd38FNcASz2e2VigLPks//gWgpb/s4y4o48CGcUU+XAdzM
 ctX27HmMFu5yb2Cw91HO6dhAEmhevF9p2TXTPZQ96V8CLTP3260PZWalbqrCyiuxhKPg
 QLnq2gAoGMWp4IxZ7HyoZYE+AiVQQI5RJt/l96QsvfAqXkYI1gSgHYek/8R3JK8elW56
 3SKH41jJjjQBT0m9Ym6SyTzPLgd/gOXHTh5Tw/B6eB4WihyxFTVh72k7Cu35p9GPVQJg
 V7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998734; x=1790603534;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PltYelwuvegL5nB9DOSitBw7uB8TWktsNrRIT467U0=;
 b=bQnu5Q8seQ6gcJfvF8yw2QDJ/HnY8GzE8lRXQtrvl7r1CnkpHWW9YPhEw9fLd+r/av
 rCXk024+V7DBQV2SFCwVyDBMKZF6Mkz3ISI6YNw7N7VYuxcHykOEdImB7k0hQdKN1RWc
 3NVJ5KA45TZxAGXso4lE/4UFjCcJ0KuiuFeGPspaIDyjr6Pri6ECi4nUq+95EvUPCIg9
 HIsZVNf+F6VCNxdErfQcL3XF+LrjduAzQYMl9J0yFj6wdJfmFuqqpyyjK+Xdy152kF2K
 wFymTgsnuc3IxHiIY0xxc4nAO38YV6H8sSlp47V58bEO+M+Ok+W8+GxZVaAlMW2s728v
 A+nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByGWlfYIH745nTAtiAak1IOf2wQe+aoIfASVIDmU8Sdf80U6/6Nw27Xhn8OUYAxt+adiOv9iGDkIZ1q@nongnu.org
X-Gm-Message-State: AFuF++mADBDI73TMOl+A8tkMrx+aE8nCMi1DLhRtje+c/TrJAWDXiGQD
 n0uqzvw+VAjI/nxNDIeKwT4roBIXMNpHlEfiE6OL++MKCYJ4uAFgB1JaaD48XBuq2ZsTq9hH3Bn
 RaZAIHdmivpVXijy1lk2PyPlIm+XysbAXOg2/vcfszu3F5dDchivtzeHa0w==
X-Gm-Gg: AYBFou3oYRQ72EIZk8XYCFvsf/yAPRN3K/lnJFyd4Q9qplPZKi0RxoxZyfRgbWdS9QD
 Z3cArNjMlnvonSYBzulEvWH0H5YL9uPDw+L2NTQSM3ZJ4qn0rWoZhPxCh2xlJBOmOcR6Id3/HA9
 FaAJldN9+7/C3XxoA+9cv3dfk0L/xvUu6v9uWmnAqAhWiOnuGpvvCoB5D7x/ctkwgIQyMUoqasf
 Yw4QmkEecJiNGBhO1GhkBQ/AFYBvEeCLb8BCexbNCvKzWG8nrN2SJMw8zBSG0nd9ILNhiTEXCwc
 twn5uLpTjN2IhSo7WYZviSw7RQacSskVxAYFoBKpQvQ2Z3ua0Dw9Z2eVdlpOJSYg5Bqk2exSzu8
 tRMwW8fQqAIahCneQt88=
X-Received: by 2002:a05:6102:631a:20b0:7a1:f2b5:6462 with SMTP id
 ada2fe7eead31-7a1f2b5658emr946615137.31.1789998734451; 
 Mon, 21 Sep 2026 06:52:14 -0700 (PDT)
X-Received: by 2002:a05:6102:631a:20b0:7a1:f2b5:6462 with SMTP id
 ada2fe7eead31-7a1f2b5658emr946557137.31.1789998733901; 
 Mon, 21 Sep 2026 06:52:13 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc5755c40sm301730315e9.3.2026.09.21.06.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:52:12 -0700 (PDT)
Message-ID: <fa6da813-8609-4d23-8fa2-f12fc8c1dde9@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] target/riscv: Stub out kvm functions
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-5-f98c5a244636@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-5-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LIHV6wa_pqeDzp5yXbfZ3YEmOQZtvPto
X-Proofpoint-ORIG-GUID: LIHV6wa_pqeDzp5yXbfZ3YEmOQZtvPto
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab1368f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMSBTYWx0ZWRfX22nLFLhXsMTD
 QFQumf8L/RZhEkyRmuZK+QVZDCVCSORo14lCakKxiQXdTzsqQ2FxMOkv88c28TLFXGpz2sPCgfy
 zurh11DkXSks9s42nIotAlxKj2tSB3QPl9npJXKic23QcTdh8oRiFpzGJ2//ScHgM2U7jUR/0w4
 EeSnryH2ztOTkPKJjL9LTO6WVzKxV0lAktkBA4Q4ygXYTP5sHkLIsCavCHajfIkUEtfLS11UGhz
 G6Oe5zq8SAbJCFC5KOEORXFQwoGLTL6l9iFBUJkf8uZYSqxlKmtfNBP1OFiIaG66ITzWCtjfs8I
 v3b6Ck6H/iS32Q6TcSvexQEB12xTm1y9MTSCzh5/0Xlhx0mGHAkNSeh1dI5ay9n6/dpT2h7pLHW
 WzoUXdDqnICxkFVpGX1WaJE1E49QcMuVgpwdAaPtU5owqMviv87oWosAQdGe1qT4DEiNqx112xQ
 mfqbPkzjV+CYb7IjA9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMSBTYWx0ZWRfX+fWlrHyIaZB0
 phK3fMBa0SqWYKtX7TPkvaU0RAoQbn+mXurPjUHZk2REt1s3+sDRof6Dj7Ng/pVkHSpoLlO3K8D
 AAz9C77jaH5MZlOpZa4n3kck4NpkVp4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210201
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

On 2026-09-18 0:04, Anton Johansson wrote:
> Functions used externally by hw/riscv are stubbed out for non-kvm
> configurations, allowing a single compilation of hw/riscv.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
>   target/riscv/kvm/meson.build |  1 +
>   target/riscv/meson.build     |  3 +++
>   3 files changed, 27 insertions(+)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

