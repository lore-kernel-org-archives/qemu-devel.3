Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54182C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYFq-00053M-OE; Tue, 30 Jun 2026 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weYFn-00052S-My
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weYFm-0003g2-1x
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782825110;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xxmLSENPR1sSMK9+/aPMPjVkH+BvQrkMchhb6zfZx8=;
 b=MVRx7TIdVgh+XHYklWOhQxmgGYXCOyfto5apixCU82BXXWSd9GhgmJfJ5nf1XOKTDhVtm2
 fL0zxE1smYXwSTliV0dLZOLsfR9gYyzT3eBga04jgF/3o+O1d8qbEtoE0PYUrg5Xn7Hgev
 PQlLhgs2Q/PHKF+3OAjvKflV9m4pW60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-B8xT1idbO9-Hk3Cvli0sig-1; Tue, 30 Jun 2026 09:11:47 -0400
X-MC-Unique: B8xT1idbO9-Hk3Cvli0sig-1
X-Mimecast-MFC-AGG-ID: B8xT1idbO9-Hk3Cvli0sig_1782825106
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4924725bec9so27388695e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782825106; x=1783429906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xxmLSENPR1sSMK9+/aPMPjVkH+BvQrkMchhb6zfZx8=;
 b=eIA5kDykef9HPt5xXZMAIdC+sBD2NJDixp9GsDz7HiQ9g+tMQFrr6fmV9lzZ47ur+Q
 rX4wmKXEBI1Yr7TpdkI5Yy3c/k0A5Eh5EBLhUnj6TU2CQOQp/D/1Z9y2L0+rh0ksxG4h
 FhLNP+i0CS9bWf1hJdz2qidMCRbM9+yHH6DF0naFuRLcTHBFhtDe+ODuhiIRFvZktrpr
 zVhsLdUvyAUffnu0qzHZwZbiZyn133NWrCTOmdwulJuJfH3do+7qIa1XQI05Y+OpcEjk
 Er3u/rJaJXheS5bsf1OVp44MrJKT5Ltk2zeUObFoyTw1ofUSQUCVVzw50RXTN7VQJH/e
 x7FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qBMTyigGnLtqN9CwU9j/QAiiMyxYABgSwPAjOfqkp3pXl80gtZopkrjK7/USN1gBD0lE5uXFwApaO@nongnu.org
X-Gm-Message-State: AOJu0YwOOQheaLTo4LzS8ExKUG58sFPaFn+bzReWR2sa1F+3O69RUs4J
 lXozOm7tCyksDfAQ51oH7YWh22Nj+/66ZJBA90+nk3DGmTrTrLcc/wUlds/nUc7pBg7tES5zQ5F
 PVjuYGdgXyXnRRrpZvPPltZ7UJOCymN4iI1xsRWqT2g2AE+U2jPFnNMce
X-Gm-Gg: AfdE7cmsw57wkKQPjpU44EGhGgv3S/PqXg/OWkWSkV2mwqdFKlY8kLz0Yc65AKrsrkL
 xxwAlwD1vHdopWvkf6ANqppOJ9K5BokqfIFS7eC1fiK0JU1cjm8Lwj3ryUcE70/UUBGAGKtH+m/
 r/CF+9a+iM9LkvqqEZ8A7sm+LJqIwMrvGxO+mtpG5alBAkcTexSIOZdwr8aDyPr7F5uMwVC7ens
 IByzUwndtHY1hDbf34DooIsDHQgbpdXvw6lsNnMD2JttSVH33jo/UMmJTQiLoAyXPSPXMAMgVto
 ATlWmQihdt2G7T5sDqf11oiYyBsMBhAZfbWpuc3UZ6X2Ete92G3TkaiwftdwUHYF/fcuifMcY9q
 OVbL4FDtVnYYdLznMigXwE1rlg9piuaPtOy+DDBjSmlzmC4kyThpMuz6l7qw=
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id
 5b1f17b1804b1-493b82b6360mr53630865e9.32.1782825106238; 
 Tue, 30 Jun 2026 06:11:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id
 5b1f17b1804b1-493b82b6360mr53630335e9.32.1782825105757; 
 Tue, 30 Jun 2026 06:11:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8c70aebsm77034265e9.4.2026.06.30.06.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 06:11:45 -0700 (PDT)
Message-ID: <d3840d33-5e34-4c23-8704-9e729559dc10@redhat.com>
Date: Tue, 30 Jun 2026 15:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.SPLIT
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
References: <20260630083042.2692392-1-eric.auger@redhat.com>
 <20260630083042.2692392-2-eric.auger@redhat.com>
 <SJ0PR12MB8614BCB8A6B565224E8468ABABF72@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR12MB8614BCB8A6B565224E8468ABABF72@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi Shameer,

On 6/30/26 11:11 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 30 June 2026 09:30
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
>> berrange@redhat.com; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
>> Chen <nathanc@nvidia.com>
>> Subject: [PATCH 1/2] hw/arm/smmuv3: Sanitize
>> SMMU_S_STRTAB_BASE_CFG.SPLIT
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Currently the guest value for the SPLIT field is not checked.
>> Also the spec says that values different from 6, 8, 10, respectively
>> meaning 4KB, 16kB and 64kB leaf tables are reserved and behave as 6.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 5e5a6a960c9..0a8d2fbb6a7 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1688,6 +1688,13 @@ static MemTxResult smmu_writel(SMMUv3State
>> *s, hwaddr offset,
>>          s->strtab_base_cfg = data;
>>          if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
>>              s->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
>> +            if (s->sid_split != 6 && s->sid_split != 8 && s->sid_split != 10) {
>> +                /* Other values are reserved, behave as 6 */
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "Invalid STRTAB_BASE_CFG.SPLIT=0x%b, use 0b0110\n",
>> +                              s->sid_split);
> 0x%b is confusing. I think either 0b%b or %u is better.
sure replaced by
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Invalid STRTAB_BASE_CFG.SPLIT=%u, use 6
instead\n",

Thanks

Eric
>
> Other than that,
>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
>
> Thanks,
> Shameer
>


