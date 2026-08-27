Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11ABC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVM9-0003gc-0Q; Thu, 27 Aug 2026 04:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzVM6-0003gB-PP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzVM5-0003Lg-6t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787818860;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdSvTeBfLysofWli5ed9Pk2UjOgKDdG69Cf4fAXhbcs=;
 b=WEue74PwnT9wCqiU4IxWgXaWQpMEqkTmc1hK73ya/DsryfANDG60mnSwys1Egh6yGGr5PD
 hvU3AHW9RPp8dxFHeKkpPPV2BY1dT+zuyl7GGxWaPaG/gnchY3IM2EBBlDkV+y/0p7yMlW
 d7TXPLnjzoheeTMBbj1qnva/MGrojSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-9j8kJEi-N4eT-Y3t0D52tA-1; Thu, 27 Aug 2026 04:20:56 -0400
X-MC-Unique: 9j8kJEi-N4eT-Y3t0D52tA-1
X-Mimecast-MFC-AGG-ID: 9j8kJEi-N4eT-Y3t0D52tA_1787818855
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49a1b4ea633so5600265e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787818855; x=1788423655;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hdSvTeBfLysofWli5ed9Pk2UjOgKDdG69Cf4fAXhbcs=;
 b=IkSoH3ZBzvrhxFOYhZGr4+01ZyyllwCYoZvtWPf3w2O7AoBLICGw1vKNV8ekVIswKE
 cK1Q9ZIKjNq6enYkpj41agQ/aQu0R/uoYJcJwpGUNCYHS7Eu8+qiMa4EBsPJPqggMc08
 B/5bvJmfwxP6GrVv2+y6TRl3ZLLmmw1xc0jWZytVkgirUSCn/LQ4pANbv8LBBngdTbtb
 DcW2E3nTjB+jSjms7hKhTU605FvL2a40NPd1ZPgp2Or1K5grCTmEIZEZ7AcnghODQxWR
 YpYcb0qqzLj2wOf5Pwow9PlfjOpr1u+Yy9V7vsdhIEc9ISocSV0fYQCycngUQ8XviWhG
 WtWw==
X-Gm-Message-State: AFuF++kfaI8J8IUxQvjNUaGsui5nB3ka0/qNuYDef3AdWcJ3a4MaI46I
 2AdMchHDLBCfSCPjflinlrg8/verK4uSZrglQIbevjFusRh/oVAHEvgE/EPCgHKyrUIbAyZQshe
 w7krdFlH7klRDocP7ssWpHZXNWzHEyJIWSywWrQSzjaLfGOVCvGyEjsRi
X-Gm-Gg: AR+sD10wr9wyLBRcBzBzhznJjFa3Y7jX4oYQ55qpQA6dmRowQMjyS83dCBsR8lxipc/
 QhXpc2gtmxGP7rwKI536L4bC958IIgzzzX6F47Da/VgG0bXGWxbrvDlr8f44CAGIwVpb9e6vvbp
 4XPzP7olbp8pIGA/HVHx7gXDN1LqBCFUtfC1rghxeIJuU+AX0K6NPmvbcLGqLjybLBoQmoCp1Yi
 +RQyAaTbQKKlks+n7P7A+X3jL9iQmbVsBA50am6UfszMce8eoct8UinXvYAnmHuAitjLd9OtY35
 I+OeIjOUZhr3Z2m9hVc++UbK5LJP8WcCjRW+X3rye1LiNwSWlEXdbX9GpGQt7seV0a1dS6QFIbf
 BLuTx2rTXGi+KKgsb+GG8PypvrGzirvtBTzYTw38DbIEqgAW2
X-Received: by 2002:a05:600c:3baa:b0:499:ae94:be05 with SMTP id
 5b1f17b1804b1-499dc6a3e86mr169025525e9.0.1787818855213; 
 Thu, 27 Aug 2026 01:20:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3baa:b0:499:ae94:be05 with SMTP id
 5b1f17b1804b1-499dc6a3e86mr169024705e9.0.1787818854838; 
 Thu, 27 Aug 2026 01:20:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd55dd4bsm52286485e9.3.2026.08.27.01.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:20:53 -0700 (PDT)
Message-ID: <612d54f3-929a-45bc-9c7c-1e3cbfcd71eb@redhat.com>
Date: Thu, 27 Aug 2026 10:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 05/28] hw/arm/smmu-common: Add security-aware address
 space selector
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-5-tangtao1634@phytium.com.cn>
 <94e049b6-f144-4494-a089-2bef2251ca07@oss.qualcomm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <94e049b6-f144-4494-a089-2bef2251ca07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao, Pierrick,

On 8/21/26 12:17 AM, Pierrick Bouvier wrote:
> On 8/13/2026 9:24 AM, Tao Tang wrote:
>> Introduce SMMU_SEC_SID_S to represent SEC_SID == 1, meaning Secure. And
>> then provide smmu_get_address_space, a SMMU instance-based address space
>> selector. The helper returns the per-device memory or secure-memory
>> AddressSpace selected by SEC_SID.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>  hw/arm/smmu-common.c         | 15 +++++++++++++++
>>  include/hw/arm/smmu-common.h |  3 +++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 8e40ba603d3..54a6a9f4d62 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -30,6 +30,21 @@
>>  #include "hw/arm/smmu-common.h"
>>  #include "smmu-internal.h"
>>  
>> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case SMMU_SEC_SID_NS:
>> +        return &s->memory_as;
>> +    case SMMU_SEC_SID_S:
>> +        g_assert(s->secure_memory);
>> +        g_assert(s->secure_memory_as.root);
> This second assert is not needed as we know it was initialized in realize.
agreed, with that removed
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>
>> +        return &s->secure_memory_as;
>> +    case SMMU_SEC_SID_NUM:
>> +        g_assert_not_reached();
>> +    }
>> +    g_assert_not_reached();
>> +}
>> +
>>  /* IOTLB Management */
>>  
>>  static guint smmu_iotlb_key_hash(gconstpointer v)
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 6ea40f6b074..9d6e2d3038f 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -43,6 +43,7 @@
>>  /* StreamID Security state */
>>  typedef enum SMMUSecSID {
>>      SMMU_SEC_SID_NS = 0,
>> +    SMMU_SEC_SID_S,
>>      SMMU_SEC_SID_NUM,
>>  } SMMUSecSID;
>>  
>> @@ -188,6 +189,8 @@ struct SMMUBaseClass {
>>  #define TYPE_ARM_SMMU "arm-smmu"
>>  OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
>>  
>> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid);
>> +
>>  /* Return the SMMUPciBus handle associated to a PCI bus number */
>>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>>  
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>


