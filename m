Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96114C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMPJ-0006Zb-S6; Wed, 08 Jul 2026 03:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whMPI-0006ZS-1u
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 03:09:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whMPG-0005pr-3f
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 03:09:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842UQJ1447477
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 07:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RxGDBdHKvCd6Bg1kbNKd4HE8N0+2FIImO/XslsbJX0c=; b=l75sKbq//GepUdsh
 kCnZqfBCr8rrHtzvQz6RuM6WkVItEhvJUHqELcrCLTv13gjpPLSCClrIuweIqCD9
 CUw9gYYWN7XrZFwCYHpC//54x966Z/LCFnOAsc37q3eXjhDR0vNvAmDHSvLLlzdc
 mZUPi4t3mWq5p9xXJsxHoBjLZXGZbfwu/CbFBbx9Sg6IOrCaNCgwVqEEgsj+vjz2
 CwNH/97KLqSrPYGDXlBSDWixpfmcJGLh6JEWz15hLc3CMHrQ8o0qpvl8LEsGL9iC
 lUlpGhxgkhWMwD1uMkscX/3zwWD0j2kR4GsD3NkXSRpYYfUG/OAtG6eArdoIKbAH
 rvUZKA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u125yx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:09:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c01ff996dso3213861cf.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 00:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783494553; x=1784099353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RxGDBdHKvCd6Bg1kbNKd4HE8N0+2FIImO/XslsbJX0c=;
 b=P9VLQp1mddRoznzemgDepEb/yWvkm4hOzS5IIsttWBuHrbDxo3gCGLIKH4wM7wmSgm
 RokWIZjQUDdnqhDTEO7BTCSiDcF/QxREyWVchxUPALJ3gwAy2cTAOFhHz4gfDNLkGyRE
 RLxed7JjFN3o+R0iErkYTNBNjBINzvUFEmQMsVA6I7G7UiDNKJFE5+ng7vZ+vJS7P5pJ
 Cn6Q9UuKJB8v0Q/FPK0eVBUrQj/PrP5rFwOmFe4P1gIke+c6aroGRDoCZV2Aozve2I74
 PXPtMnJnjfomhkJmr0XO0uovzHuhlZDRkve805skge76RZ07oAiq3CyHkPQcU1DaT2gH
 y9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783494553; x=1784099353;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RxGDBdHKvCd6Bg1kbNKd4HE8N0+2FIImO/XslsbJX0c=;
 b=e5IrbctPW6Ff3L0OvfH886Jv0SfPrVhaADuP0LkyDUSwcuaLaY9O6NkN4civaRarc/
 XHJCJQUBDZhrKW8iq+2eiPY3GvDKzF7Cg9iI6izsQDj+ssjPqInCsU0URIR6ErVSzMiQ
 bEPA7in25cbsaoQZaFIEBCqSFICK5EzbDXzWRh1bIyyvcS04g92yzUnnLmcrQlECQB5f
 TEJZ2Nd033P/kLLa3UFTOwZd7X6IcCzN7ol69M6n6NB6qVg/RWpS9/RHDrCI+vDqOCKM
 Z5tirc2Ro1wWIgyB8sjZY3xlJAKpEaVqv0AiDPrEmbt/j36aQgX8d+6DS9iZ+8FA+Dl/
 7E9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrimR78WsP+YQiu0OLPtCQSfVqgexTD7N9rIbfsvh1+g5y+Z9AUmWABHio8FRTBkXxxs4sjlnUvnOwS@nongnu.org
X-Gm-Message-State: AOJu0Yx+byTvMAfW/ye6J8JsPBUYEJQ5b6aKTCRdMaW68W9wdDTVC5Mc
 lDtxK/X4dA0GO4dO6SfUg+xsFjH0gamrieWGvx0sPr74//40e0uCjXJRki8icMhqfmNZ2ENsH9H
 IckxWJMu8OleG1Iap7nkxDGKbno5uBu7TyjpvCQjgSFK6rJnJrsPJcwicJq7X/5gnyw==
X-Gm-Gg: AfdE7clYr3+JkSL07QLHw0PPUMiVyQ+3McF5oCWlE76Tu9z+wMbvyZNCzHvSdOTtj62
 uY9PXF9dHSs/ZQ9nzBEWESFW7RhZobp3DkUGeHan9Bs7e89/puUY5oDIslzVC25UTfuJU068BzU
 +4GwFDX1aNvFI9WytqO/Q2UkQ4VuKN2rfOaBjjS7FQUuSnLYlw39e1S3F/9FIj7B0lzepYoXx1e
 0dLIIsnDVrS7okiCjclUKVOFESJc178mXbRrMuSoXN1nLkJF9qqH91Yu2z+AO3Wimty3pIzTS+C
 T5f7o1Wc7JeTjhiXrphnX6SYllwWMc/amEg/hMGOSAPTB/gTwSeWqJJXxZH6TC/8A8qjyUwMTvo
 +Ff1pVlI1DYRQ1OnNnNLaO0qC9VuihjM8NPmryHdLKH8qfKslUKbJGwFgb6kstQ==
X-Received: by 2002:a05:622a:2486:b0:51c:19a3:4ec with SMTP id
 d75a77b69052e-51c8b41f33cmr13473691cf.69.1783494552703; 
 Wed, 08 Jul 2026 00:09:12 -0700 (PDT)
X-Received: by 2002:a05:622a:2486:b0:51c:19a3:4ec with SMTP id
 d75a77b69052e-51c8b41f33cmr13473511cf.69.1783494552234; 
 Wed, 08 Jul 2026 00:09:12 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm43303730f8f.37.2026.07.08.00.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 00:09:11 -0700 (PDT)
Message-ID: <925684a5-68dd-4a7a-9a9f-4bdbe41c7b0c@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 09:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c9NU8UaxREMGdK6-VNkJQFPqazxao7Ie
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2NyBTYWx0ZWRfX8EVYyvf0uZhA
 g6YEPWJiDF3K5YueqXSGaPj88Gu0D/68hhFi37ZySB9+7y3iWSwxvPjeu/FuKtFhGb9eb/3XHkZ
 qZEOVKuu8Kb+2JohYDNW/06JUSiQtIA=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4df799 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=RmJfDS9GIJ5RUS0hiXoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: c9NU8UaxREMGdK6-VNkJQFPqazxao7Ie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2NyBTYWx0ZWRfX2SKfC3aCBY72
 GKKmTb012pcPgD1q5vovo57adQ9Eswx13VVrMTC905MsMuQtoF6RC9g7nwvkfxNFAxBLUW1nRP1
 u6dyC6cSLTFAkyfyfbDMlCPLgbQtW6bsoFy2HPU0Efa3Mn0ZO6uMWnLrYtrK3rElUQo6/A3pxOF
 k4xaI+L+Qd9aGtyFKfzj8uFcLDJGKrkfdsiyNjNbQw71tlJjRV2dH/MdO6XYHh51hrCmj4QTlEh
 SupcI7vXY0GTq4/AAqeGRGh1pcvY+ph3PcQTIioV5foj502r8rRxfzqZxOkDBRBPjWKuY652O0F
 z8PcRmFh9TuiSNRiqk0DYR4hxXzXNbipQ8+ESE8fo7SwsywBCceVlAuihrATSPyd6u4Y3WFBEph
 seWVprbCcTGvb9w//KMN47TEYr5Mnqs8+oUf+oQkQJlfsHOHymyfjiIrYigxlCZagF4kdDyHJe4
 JFNft+R7x7KLr+umfBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080067
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

Hi Mark,

On 7/7/26 23:32, Mark Cave-Ayland wrote:
> The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:
> 
>    Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git tags/qemu-openbios-20260707
> 
> for you to fetch changes up to 9e3508dce0045de26ec8cab064443c92fdd15288:
> 
>    Update OpenBIOS images to e5ac46dd built from submodule. (2026-07-07 22:07:16 +0100)
> 
> ----------------------------------------------------------------
> qemu-openbios queue
> 

FYI the output of 'git shortlog --no-merges' is welcomed here for
submodule updates, that helps navigating QEMU git history (no need
to respin):

Adrian Chadd (1):
       ppc: bump SAVE_SPACE to include enough space to store all registers

Mark Cave-Ayland (2):
       .github/workflows: update actions to use latest versions
       config/scripts/switch-arch: fix build on aarch64 and riscv64 hosts

Patrick Georgi (1):
       Doc/website: Add a conversion of the MediaWiki site

> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>        Update OpenBIOS images to e5ac46dd built from submodule.
> 
>   pc-bios/openbios-ppc     | Bin 677200 -> 673104 bytes
>   pc-bios/openbios-sparc32 | Bin 382080 -> 382048 bytes
>   pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>   roms/openbios            |   2 +-
>   4 files changed, 1 insertion(+), 1 deletion(-)
> 


