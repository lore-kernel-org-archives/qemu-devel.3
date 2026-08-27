Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A3C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXSo-0003zr-SB; Thu, 27 Aug 2026 06:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzXSd-0003yy-Iw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:35:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzXSb-0006J2-AT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:35:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9HvT93978048
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g1yHx4Ee814g0XA3qlGc9mEeDnlyfhtuhU0XBGeoJsU=; b=ei6nR69EQ1fcCksI
 3xe2uaqFUjWJfooD+vNW+YXmWGqC3N/zVFG66JFsMTv8IP1KooIOBQrb9yMxAYju
 g1G/1bSxmqWsOnHdRbzFXjSaWDqyr77hbeehptdM5ckkXyyyOTn/VDm6BjF5UQLx
 G3HuhkiwDRp0aW3z4Y4KXha2Iv72FPK5tTsRl3aS+nEyAO3PmdyrKUW/ujJd5Ko6
 B/4/nEbyFtTFcxLyC3cPFaTCxLKyiSebZOmgf5sfF/H17g/kJ8plbQ3n0A57SzDf
 PuSiiZSRl1739HDk3n0MoiCoq8+YwRAtFTUHZz+FjZxbSrguqAOCin4EXh7b3AYm
 q6qYhA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egkb0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:35:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52cd0374265so34498911cf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787826948; x=1788431748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g1yHx4Ee814g0XA3qlGc9mEeDnlyfhtuhU0XBGeoJsU=;
 b=WZNHChNnwq7UYKrvoA1uyiY2Wkl1Yfd87JW+/O0PlPUJFDFUUtTEcuRkEGpbrk3JZ6
 NW0+aBfsx0lUKnPdGiFR8LvfDxpTr45WtN4cqF+bWfFM3gdgB6G/lpEr/V6Bqsptl1FO
 e9i3L5i2gnuFMwmwWd6+sWyLIZW+TS8JohZY6vAgj+Zh4HqNO244kUtRqvmSYVG7cf08
 eP84egsKxOJdtt4NHevLjbSgUima+R67tiAI15lZ1qyK9HMJrCmyBzGVCgrrbCcAJ7Zy
 D0W4YBKCU8ZDb20iLv9zZpMoRfiWUuMgmo/qzuJ6GjDL/YyNTWxt81sNd9S9Y26FZix4
 JFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787826948; x=1788431748;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1yHx4Ee814g0XA3qlGc9mEeDnlyfhtuhU0XBGeoJsU=;
 b=STWKPgVlvb8R3tn1hRNE2s2Y4DLpavQ2TWsB3j9XQUVrQ89EulHdRrpTdM8BOr/j5W
 XE7KMz/ZPR3NNPX93MKrxHCleUYAYTPBUDK938U3WNsybarMFKqMpySdrLKUDDsSzP17
 6jqZDRx/uMw3l6qqksdMgJRmGq5K9hzuLrVHxjQvXLWv1GOjRIQjONS18yplyqKzN2W7
 reIM63Uder69yJsjs2IYoXPbhYPU4ThdTNFxPbv7SoAdpQRdpNl7huH4Fu1GJgnNnXTk
 BA79oQ/aVc7QQDjSJ7rnaUHZZOf2uRMgG8svAPyFyh8VeCL94xtuR+kRZeYvUekfzs3V
 hwdQ==
X-Gm-Message-State: AFuF++nUl2taQaaFNnK13MYh7MLHNfiZdqrt6AbRI4KlJVbIaLdQCfV3
 HUXH9TyTgKH5JFxJo4SMFcmsDUaiiKm1/dKdZofBDYUx5Qpkv27wuJd/6DTFYB3OHjtuc0Bn0OJ
 DYhE9A6bS74Vm0lnmoUY8dF2f+sknc/y4yFPf/Ez6YP2MsIzjZ26PdgcDMQ==
X-Gm-Gg: AR+sD10qlpHe/uz+v0lfuHQCe9ED6KY4mKf2mkEURkAzLQTBBNbBcq3b9tUkClNsSF4
 Uxsj7W8dBHg8AyxYV9Nd90ExEO8vik8+cikld3HQ4dDcim7e/zL9SqmfZxP9B9XMQmPnEUkY46g
 k2L41wmEkdPdh6njT4rXS5/zjpAEKPvVoCPvtSd4/WCqD1hiBvEVwKrVYi++zeiXIxgMJF3EeJu
 bn/VZWyZF2E32HtGQ6ejew+6wQh45AVRSuaN2ipRwFAP2trFSUWr+u1vcg/QUiIY0w+GrStYu9u
 8O+DzwQmesa86k7wDr44AD3W0/ZSh587MbzzuVZ3U4v08ycMYxrEdP0WtDQyY0YbEC/TzpCLIZx
 XWMSU54Bn+T01o6I6nc5JLXQEWSVkqbppiw==
X-Received: by 2002:a05:622a:3ce:b0:527:7a5b:ca67 with SMTP id
 d75a77b69052e-52e423deda8mr129226171cf.20.1787826947699; 
 Thu, 27 Aug 2026 03:35:47 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:527:7a5b:ca67 with SMTP id
 d75a77b69052e-52e423deda8mr129225391cf.20.1787826947123; 
 Thu, 27 Aug 2026 03:35:47 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4d08d86dsm40967145e9.12.2026.08.27.03.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:35:46 -0700 (PDT)
Message-ID: <4522b97d-5399-4bd6-867c-eade341afb9c@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 12:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, stephensportia@gmail.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair@alistair23.me>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jJAqvnftYPrye6Z1HWjwniIV8y4sWBAI
X-Proofpoint-ORIG-GUID: jJAqvnftYPrye6Z1HWjwniIV8y4sWBAI
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a901304 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=t9496tuAAAAA:8 a=jNFeHvk_SeYrjZSZ0a8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4NyBTYWx0ZWRfX/kHtqT32Xaf7
 uKh9TOBiOVT+ak3EUBydGjXaa/8ebpsP0UUpZN7N9xuotBoHFZGkVarJaGBt4pYPHsNKfRFgHXn
 MeQpPNtw4ijwaC90Rx6mnNc3vZjjItdg0fVyS4IkOyVLg+dliUGKykBqJyQmm9LYw1wrhnVXDnE
 7AqjbDRz5z1lTP69hiBfT8/apvweceGLHdvNXWRTpo3OMekAnm/v4F02LridB0/7tQWuf3woe5j
 47KTlb2MRwpPHm0qoB1fOsTQ8jASdy80cBC7OQp96PWRujIv5p8mXe7u6g+A5VqeNpnNg35igGI
 FiBC7lv8hSS5iTlDHjMOzFezvK7gB97tC3zwXRq3TdpbbNw3w2X9tavlHg2K45qOKFdtKZKY70x
 UyyOHO7HbZw8BOwnXY8lSR+mqBQylzwBanj1QPJsSgIDTy8kHYvPIyFqYnZPf2lmFQzgSYpwSCK
 wGO4qve0N6oz6wPueHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4NyBTYWx0ZWRfXz14JREuxoFFq
 pS6Z0RgiL3wPJ3LE2gRLfwMHTQj0bK39+OvogJfD5gwQEm3jHDQ9b3lr5oNEptsfCM4WzF23KT6
 tsLtkP10hb8hT1wx+W+FGWA2VtIis4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270087
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

On 27/8/26 11:19, Peter Maydell wrote:
> On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
>>
>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>
>> The ssi_transfer function comments say that it takes a word varying
>> between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to transfer
>> but there is no means to indicate the number of bits that should
>> actually be transferred. All child classes of SSI_PERIPHERAL class have
>> transfer functions that, despite accepting a 32-bit tx, only transfer a
>> single byte; m25p80_transfer8(), ssi_sd_transfer(), ssd0323_transfer().
>>
>> The current implementation depends on the SSI model to know
>> what peripheral model will be attached and what transfer size it
>> expects which is error prone. If a SSI_PERIPHERAL model was written that
>> accepted 32-bit transfers, it could not attach to any existing SSI
>> models.
> 
> What is the motivation for this change?
> 
> As far as I know for the hardware SSI protocol, it is indeed
> the case that the SSI controller (and/or the guest software) needs
> to know what transfer size the attached device expects: the
> controller just transmits (or expects to receive) however many
> bits it is programmed for.
> 
>> This change updates the the naming of ssi_transfer to ssi_transfer8, as
>> well as changes the return value and transmit argument to be 8-bit.
> 
> This means that the API will no longer work for a controller
> and device that aren't 8-bit.

Yes exactly. Clearer than the mail I just wrote, thanks hehe.
> We happen not to have any of those
> devices today, but why specifically stop them working?

I guess remembering having see forks with 16-bit devices, but
that was few years ago (I know forks don't have they voice here,
but just to mention the current API is working for them).

