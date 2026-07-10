Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5404C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBTi-0004p2-ET; Fri, 10 Jul 2026 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBTf-0004kZ-Gv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:41:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBTd-0007DL-UQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:41:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AD5tVM776079
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZUSlR/eq9P0HIJ3wzacIFgrOBTGUVZTf1Xb6h/LhNJM=; b=VS5a1xdBRP4H8Eir
 AyogvoLCaN8oA9k8cvpUVm78dDfwOwMunJSStblwEehVHnHSIMjbazjKqCuHeggO
 b90iMD6NfsrFmmdvLOnr0nADuDxaNQF+abuA8SS7bNOKwaZdaMV8ruOpbHr7WOld
 BdBjAoFmq45haVh7qFtANh56mXk0GfPQDUoP+3nGmEizzmysthFjIhOBsFiOj5HE
 4hqxosQldwPaoGEdRWIp0UCODA2vOpjXkhul3UjC3Xx5dzPU1cckCfMOUJzy2kNR
 Q0fjlpuSucaWGy5Ao2w/rumRLLGHY4NXaGSKAC+1cu+vQha7AQWUB1YbCtZvFnSF
 TxZqJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dgvqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:41:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso9718431cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783690871; x=1784295671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZUSlR/eq9P0HIJ3wzacIFgrOBTGUVZTf1Xb6h/LhNJM=;
 b=AtbxhFnxOo27oXRHroDfn+m/45dUENlDHJnO5vZX0jJjF2Qgoeq8J8/l642KA5sv5s
 JNEAT6uvP4kf6YTe4GRaNrth+m37VLlFHWrWn0CPH4zreC9/1vP4b4LRprq2I0GcolSI
 cwF4G9LyxLUcVyokBDmnG8Lzobh6vaeeMjkc2SkuxsKad3sfoQX4qaE4sNZuOWFI801C
 HCEaHD0VCqExVSzig1AT2GLXPSwlOJbnzjSbwuR1b2+5KMmkpQyVhYjsxFE4aQZgiZDJ
 mtPNGvriJsM463gozyHxfmd+pPVHIA++wDClhZbaJ1MdvuPCd/3NrOAiUe16Fsygazw+
 jkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690871; x=1784295671;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZUSlR/eq9P0HIJ3wzacIFgrOBTGUVZTf1Xb6h/LhNJM=;
 b=N+YqBJ57PRZHDZ7/DeMXSDWQgrMgPpjOLhE10+I/LWrw57y2FnvzHurQpLpWHeLvMh
 f4jji9DOMqHwV5MMoMtLEC5jWjjzhWI7I1N0rJlYZpIILlA8xaHpuiym1Gs4p2emsdJS
 ogFqrflA+/+KDZ18x+9wQbEABtOcCUMwQI6uPAfTG9+mkEqhWpx0FwJg2YN7pBe1orOs
 rcreXd08wBFKZnSUBmXL3wp+0cVrvJ1/GjE6L4+BLhazFR2Go574KqpfdQEOjHtJyTir
 NtbjebhmdxxsjH4AYOFMqGhoP/7UAPymuNTs46iyxICWeMZcON6mbFtW4ei6s3j0qYQ2
 0Mbg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3WHABTeLuOOIrVVz8wOsai5/slbeONRFGYvN913EX4RkhT347tzY9TqXVVnm7BSTLYaI9VctZ+rpH@nongnu.org
X-Gm-Message-State: AOJu0YxG001T5QOX0+JtRvIXpSGthdfkyyjgvMc8GoJhej1dewj52s2c
 4KzoBe3itnV9yqlDUHa2CXLEdH0RZQb4D7qzrMpbFo6v2pHRjmHXtreDh4t9jnxPiV7rjZpHqrS
 2J5LNtAmekb2X4B8HerQCNkB284LDqY/CUi/A+eN2+TywDs4JdS89461xxQ==
X-Gm-Gg: AfdE7ckvRPdBWuPSA2VwXPuSkWVGNYiXdohBBmaQFgnkPTgzImbG2oYnX0bXTYFvJkH
 SvhNS+l9T0X2sjX0F3anMvjnC+UlRDFLPzbe6L1Z2VshNXAwceJLvS8AsVpCLzkBR9MrTMnmKr0
 quuIgrYkmvHZRNEQlFCDTlIEs+ADrIHGuZOlZyVqEJcQ131+MZXdUs/o/nR8WG73mHgdH79cwc7
 LAoYNMu5ayedSJy2vdgjgqgEAAPCkAhh93b64rZpERtqMHDcLP/3yBSMhJ/fsJgTRR5kYrZBf0m
 AjTurAJ1+P3q+HvuSGN1thpSAwJ7nfzNCpg8iiqD4dGXUkhbcGO28RElLdz4seMRFWq+PMBEMz8
 53CkCeZf4gdJQLfQ4+hE1MvJU+8rd/743/07t3rZoO9XVyxBf8r2O/TNtfqVxIg==
X-Received: by 2002:a05:622a:1dc7:b0:51c:94f:8ce with SMTP id
 d75a77b69052e-51c8b43334dmr127451341cf.34.1783690871354; 
 Fri, 10 Jul 2026 06:41:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1dc7:b0:51c:94f:8ce with SMTP id
 d75a77b69052e-51c8b43334dmr127450981cf.34.1783690870912; 
 Fri, 10 Jul 2026 06:41:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm60276145f8f.5.2026.07.10.06.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 06:41:10 -0700 (PDT)
Message-ID: <e484499f-5453-49c1-ac94-53f107039ad4@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Print simple help text when calling "-blockdev
 help"
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
References: <20260710093654.466642-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710093654.466642-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfX+sxjEAKO40en
 KvlZiPkP18rdhQUND+gEW3adXmwoWcDn4XnTsMFA0anFewCAMS0GP3yLamIy2LrCL8yzEO4TQj5
 frCgXxUPuzXYFxRWlKpx8Qd0H2nK1KQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfX1s/74JpLTnDK
 AnyvWuPMVXKsVAFBtAbsLAKcHxqjpJWRAN0PA8Q9KsOjLPtpf9sfTv8UCqVm7Clf2JQCBGsGFZj
 8+yUOPovXYN2+6630DSxsKth7DApVMseD37zTYvM2aNcXBM6eXQfg97r7AISNTprN9wFWZLKqdl
 LljmoU0jyTOseEjB+Kin71cZ1q8jVbdpZzTGrtE+ES82qguAmmfmI4l7WObeYoqzG/0zVD8SO7g
 CMT1mTzLOZ0dKlBMCaNLQG8PU/gY7xtbRAKiGtWzbqihZsVQiUOcEgscXi9s/bfqyttxA4T2BDE
 oWLo6TtHt3ylj9+t//zN7AMgkbwYhY4iwSho50g9w7J9KqiM/UcTpWYknb6hNXZ2o0kQH7F/KLk
 uVRJ9nt5rcaDNVtSJ1hrN46FbzIiifw9GmVBwwz6lUcFYIF4hAPSN9MJuiXGoQjowJK1w+0pW0T
 wv5GvjeicRShtQAxjiA==
X-Proofpoint-GUID: zFknklwenP1gPilUPh7HcuV0H91RoTF6
X-Proofpoint-ORIG-GUID: zFknklwenP1gPilUPh7HcuV0H91RoTF6
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a50f678 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=NH7WcdDz3NN_igdxw0gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100135
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

On 10/7/26 11:36, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Other command line options like "-chardev", "-netdev" or "-device"
> already present the user with a list of available parameters, but
> when running "-blockdev help", there is currently only an error
> message. There is already the possibility to run "-drive format=help",
> but it does not seem to be documented, so this is not very useful
> for the average user. Let's improve this situation by providing
> the same list of available drivers when running QEMU with
> "-blockdev help".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/block/block-common.h |  1 +
>   blockdev.c                   | 15 ++++++++++-----
>   system/vl.c                  |  7 +++++--
>   3 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

