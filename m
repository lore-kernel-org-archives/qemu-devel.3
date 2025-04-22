Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27791C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77nT-0002oc-5C; Tue, 22 Apr 2025 03:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77nQ-0002n0-Rj
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:11:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77nO-0002fO-O2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:11:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso4617588f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745305913; x=1745910713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSA5XtzE5Vo4AjYxD3tmJ7zuCoqKYGo/S8l/u/ake1A=;
 b=urBSrNv8xnJ9PRP9K0EVrWBPnmy/ZXlUk0ma5hcM+l4ejNK7mqpn+58STbrDlIGMdq
 dHrq4mpuMtjQ85gwbgaFKLFJo4qqn6U44h2g49PozjuTsB1xSOBZEKsXvtHn4edxaaaF
 2NNvL5rcG+l/yZ6y0mMyG6qb7qhf4YzrbNS9RRzndaDb6O+OXusrrmg0FvKodhFSfGAq
 qlgn2Vjr7fhkH0Nik0OCToWMuNEoo7EE8IhWf/X+KL7U37bF8mh1dtScCIRFyVLTPk1g
 v1PVCTcWePPbpQqwwoFBwEstnlVK6E+CsQYJ9lpdyh3bWnp6ICsQ+/6X5lVqfptHI6bg
 U04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745305913; x=1745910713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSA5XtzE5Vo4AjYxD3tmJ7zuCoqKYGo/S8l/u/ake1A=;
 b=FYug7gFBAgEP4NulTyLz3ROXc/c7wKjZS1N8WeFHs9++SS5yx6jxLTDAmWo7DxOOmu
 ai+AfPFJSiyuPIgMzSBWrP0mfpXmYdAoFNH1BgvCppxhMzhLHMRIxJI3rOSPsWs65gI7
 Itnw7VehUmv0fGYRSUPegnD/RRQi1TVVlQZcCzlMz3dYyLReqpjNfMF1M3VgPrmqueAH
 K02GaTjlzlg4FOlOKgEWovwGFB2qQflPAUl0Mn6YL4lesgnA0nWm/h+Z5MftflML2diL
 5V3wzcQnjp4uqk2YoVa/Tb8CVx7Cq3uj1zR5cXAYmKIthUlX2w2IkvExg6fPMHUrBUkp
 yPMA==
X-Gm-Message-State: AOJu0YxqDNDURfyFprogUfd1UYXZb1f2XgCV6tNhErAcSNXbW48cn/pJ
 5//VtCuNpS93gEOMDdGB1STCIQESljCpRgbzSgDEHKFz8NAjSA6KGA+4Pi0fCsI=
X-Gm-Gg: ASbGnctWsdT4tGj/SenMJFNLfbymp1km63ouCX2D/vdfsJs20R+HxD25Z1kdouivan2
 ODAjUAxj+HckiRCM05FZ2IIiikxIhDuomn5/4hpfTkBj++UyNS6r834189zG0cngIDXIgFO9JNh
 38qovRuGHjKWwr/hONK1SQW3WwkzpZABNOfjOGnm/9kaOm1g7mP8TGSIts+recqcMKxAHVcOsBB
 u/0I9CRL065JVmOM+v/uZCoxGCHl7mtMozv08dHsIzc8/TM+GvcA5urxMKPGezew3kh1+TsCprH
 XuNpnkybHkdRiFmlynrzvT/ykpFkRH85D/1LrLPoL2CWz506Ou+IA75IhhI7ZBfbkHW8L1FwpTi
 xRDGMBhGk
X-Google-Smtp-Source: AGHT+IFJOk7rY1bJUjyw62HSrUxqR4ySE4LN5IFqKtpWi87L0WMvO7clZlPGhqlh1y3XQHB0YWzv2A==
X-Received: by 2002:a5d:6d88:0:b0:399:737f:4e02 with SMTP id
 ffacd0b85a97d-39efbad2f10mr11585897f8f.39.1745305912826; 
 Tue, 22 Apr 2025 00:11:52 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a498csm13961184f8f.85.2025.04.22.00.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:11:52 -0700 (PDT)
Message-ID: <292632c9-4492-4071-9100-a7b165af3e97@linaro.org>
Date: Tue, 22 Apr 2025 09:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_block=EF=BC=9A_change_type_of_bytes_fro?=
 =?UTF-8?Q?m_int_to_int64=5Ft_for_*bdrv=5Faio=5Fpdiscard?=
To: Eric Blake <eblake@redhat.com>, Sunny Zhu <sunnyzhyy@qq.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com
References: <tencent_8649D99B33E6E6665A0EFA05B97592D70106@qq.com>
 <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Eric,

On 21/4/25 17:03, Eric Blake wrote:
> On Mon, Apr 21, 2025 at 12:19:14AM +0800, Sunny Zhu wrote:
>> Keep it consistent with *bdrv_co_pdiscard.
>>
>> Currently, there is no BlockDriver implemented the bdrv_aio_pdiscard() function,
>> so we don’t need to make any adaptations either.
> 
> If there are no drivers implementing the callback, then why have it?
> I think we have been moving towards more coroutine-based callbacks and
> away from the aio callbacks; if so, should we instead be deleting this
> callback as stale code?

Could we add a comment in BlockDriver prototypes about prefering co over
aio implementations, possibly mentioning them as legacy?

> 
>>
>> Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
>> ---
>>   include/block/block_int-common.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
>> index ebb4e56a50..4bf422d733 100644
>> --- a/include/block/block_int-common.h
>> +++ b/include/block/block_int-common.h
>> @@ -507,7 +507,7 @@ struct BlockDriver {
>>           BlockDriverState *bs, BlockCompletionFunc *cb, void *opaque);
>>   
>>       BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_pdiscard)(
>> -        BlockDriverState *bs, int64_t offset, int bytes,
>> +        BlockDriverState *bs, int64_t offset, int64_t bytes,
>>           BlockCompletionFunc *cb, void *opaque);
>>   
>>       int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_readv)(BlockDriverState *bs,
>> -- 
>> 2.43.0
>>
>>
> 


