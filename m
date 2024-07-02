Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58614C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfd1-0004ut-Fy; Tue, 02 Jul 2024 11:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sOfcv-0004sF-E6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:41:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sOfct-0001T1-H1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:41:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso33748095e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719934861; x=1720539661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZkpS+1UDsevnPj75ZOoBRNDlLd41VosKwCDdE0UqyI=;
 b=Mu0e+1SIdkJ6ZoFyu/oUpepGaY8/htdE2oAdz6mR2WrZYBSOOcM+a8d/UtKIKqvGdt
 B0XMg6IG7dtVmYAjaI6js5Y50UXIBnfMzaG2X+UZ0NfmAnZa7kQCBBB9lANZDLvg35yB
 yI1IRjmFSVVYGwqawsteeFVxhME3eZxZkt1LufddWXDBxDRA1qt9FjU33fv5SYRftYHf
 p9x9fNM5HP7C06+8sM1OshWL9HjSNiRsDJgEH1C0wKoMflPsarEoz92jYYSGu9yN2g3W
 vNdH7pXG1AFp2VNS72tj7enpFyfU2IAN6YNSDK+PKRUT1jWT3llYRJLPqotF/UHDag+h
 gsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934861; x=1720539661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZkpS+1UDsevnPj75ZOoBRNDlLd41VosKwCDdE0UqyI=;
 b=FfhQ2Ds0NVIeCzu3apZnGjWVt5wQIn3HLXCZ40zLBsV8bmuFr7lDN3sHbfOFEbjj0z
 xlZA/jCiKyyw1e8d+EQFgHUKzGyCWL11FtEPIX/CLfIrOuGthf11TUdv7BmQKY0SoDQx
 bHKGd07yPURHcrjonUV4vyAWrIoLFVJa63CiIF86hicknQXiWyI+Cliqhl2xuee4arvf
 pdCB7HgMZiOZNsg2x60o8K1op/naG9s4diowEt0K6izCRe0iTv4aT3Y2dsKkWSfDva1u
 Wjep3Tvn7OElK2JI83ipmyAhbnP+gzPb0xGonBtlPbNNK39T7ajX2JGwgotXQg0dFMlU
 41/g==
X-Gm-Message-State: AOJu0YztoUtFRzcRmH4xMcpVJd28WdqqSUGYcOhAD+JGg1uXQtDzjfVO
 8aaSBCH7eVj2BjT97g6jmhOKTJxi4i+R/RQPkkmvplRV91BfBhRDEHXs1w==
X-Google-Smtp-Source: AGHT+IF/9FG0YkyvBCbt3jbVhDRslzQAEFQ1stsGDYSPv+wa0aQ9r9z1991p32mr5NBQvFCHwWrXHQ==
X-Received: by 2002:a5d:50d0:0:b0:360:8e71:627f with SMTP id
 ffacd0b85a97d-36775728503mr6755146f8f.59.1719934860556; 
 Tue, 02 Jul 2024 08:41:00 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:b26:7100:7654:8924:d030:917?
 ([2a01:cb1c:b26:7100:7654:8924:d030:917])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1481sm13572719f8f.55.2024.07.02.08.40.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 08:40:59 -0700 (PDT)
Message-ID: <db513eaf-548c-4931-9507-13b8eba37e98@gmail.com>
Date: Tue, 2 Jul 2024 17:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
To: qemu-devel@nongnu.org
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
 <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
 <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
Content-Language: en-US
From: cmd <clement.mathieudrif.etu@gmail.com>
In-Reply-To: <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=clement.mathieudrif.etu@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 02/07/2024 17:29, CLEMENT MATHIEU--DRIF wrote:
> On 02/07/2024 15:33, Yi Liu wrote:
>> Caution: External email. Do not open attachments or click links,
>> unless this email comes from a known sender and you know the content
>> is safe.
>>
>>
>> On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>
>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 98996ededc..71cebe2fd3 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3500,6 +3500,11 @@ static bool
>>> vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>>>        } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>>>            /* Interrupt flag */
>>>            vtd_generate_completion_event(s);
>>> +    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_FN) {
>>> +        /*
>>> +         * SW = 0, IF = 0, FN = 1
>>> +         * Nothing to do as we process the events sequentially
>>> +         */
>> This code looks a bit weird. SW field does not co-exist with IF. But
>> either
>> SW or IF can co-exist with FN flag. Is it? Have you already seen a wait
>> descriptor that only has FN flag set but no SW nor IF flag?
> Yes, my test suite triggers that condition
I think it comes from the kernel function intel_drain_pasid_prq 
(https://elixir.bootlin.com/linux/latest/source/drivers/iommu/intel/svm.c#L467)
>>>        } else {
>>>            error_report_once("%s: invalid wait desc: hi=%"PRIx64",
>>> lo=%"PRIx64
>>>                              " (unknown type)", __func__, inv_desc->hi,
>> -- 
>> Regards,
>> Yi Liu

