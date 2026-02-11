Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9556ECD6D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEjl-0002Sb-8M; Wed, 11 Feb 2026 13:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqEji-0002Rd-MQ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqEjh-0002rz-3s
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770833686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTFM3pmosNVVouzhnVqRfXyBuDFHw4cDpdky66gLEdY=;
 b=NrbMbuGWbG0hYjWWCjF890xz5WHejN2r/o2akWILGUCivBSdp+G4IR7Yv8PcXFGlEaLv1d
 H2Hd/MKa+UmNduqW+yE71NzBV3evGqHQd/18Y1nvNRccBCqNh+6Vx09tCtVbBImn7K+dEF
 w66wAP7mnc+FTqVb4BoM9hmKYZ/gwzs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-r6LgMRq1OfeUhYZRhD2LGg-1; Wed, 11 Feb 2026 13:14:44 -0500
X-MC-Unique: r6LgMRq1OfeUhYZRhD2LGg-1
X-Mimecast-MFC-AGG-ID: r6LgMRq1OfeUhYZRhD2LGg_1770833683
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee056e5cfso62818655e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 10:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770833683; x=1771438483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTFM3pmosNVVouzhnVqRfXyBuDFHw4cDpdky66gLEdY=;
 b=GZDtpQAMyvpmqGkkxpoBcN0CqxT+Tmv4OT1Y2vfq+snFCGIEtiI7bbYIuA2BMZ7T44
 pfLuuzi4Bh/kuVRYmc5Gp66WQThC3SyzfDejQz9GQxrJPJn+GD71KNOyzGKV9mZR8vub
 aPSlQJ1lnkT1+5o6Gc31foYmS6iJD4GPZ923WC2Bv7Wdcb3v39Hw4M+0/2lS3px1Ocxa
 f6bQ59nQCBsYB/8gyrg0SfqGRNfysKtwBhsIPg9gLKIIBbF32OeEDLc2IzxlSdLP+Js8
 UNlmZHswX3czYGGDAW76R9cd//yZ92TOQQqKnxyoYTEGfNvTTLnrHmp5e1DVjkcyv3pv
 ecZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrzlCXMezH7lP237kGPTBhOzutCfQ0dhzusm48RQ1E5j3Yz/9M4LgRc5mzk1PcCtpFjnzCWhRjqW/r@nongnu.org
X-Gm-Message-State: AOJu0Yzn08M0uM9GqBfFIYBrQ8ZmwHZXYD396V3nS/0RZzzYBnlirVny
 FyaGD/WrM2DNa2V90x34MX+736u6nKyiEx6iGXvK/hDHC9txS2L6VSJpghgHUTQOolL6R+WkxvP
 PTX0hqXe5akNTAZhD/AskRmc/OuQ1FQsKx17sqrqon6NzedMeDEIj1Dna
X-Gm-Gg: AZuq6aIM5DE2N9GyVWpx6WPCXPRClFxsIwbs9uTTSVdU2bRZ1b9YOo8FQUWRs/WY+aG
 cEIerB2/p2FYx9lX68rIn9YVk46gGTnCU0kTJGYah8OrTkqk5AVjI6/lwMoGKxSemhw/rvA/sDr
 8sYSp+OHsQNnKQ/THHwYqB3XV2IgrfaRxE9nPCArhX3DDkiwohi2uUw674fgqvg8bQfMRaa7PAj
 YypQbRZeaNubayDSaBWtEacuSs6I1WgtX+JzNtq4SIjTOY96YvGMc1Z1NbIk8NAC9IBfIIbpFo3
 b3a4GLJWACx2QGKVSkHXjk19f5Q86BqjL4rBUhmWwtdfl79zLlpIdTvEnsg6rySR1jUtEev7lAP
 74h6CAFKBS8qgtC+jrbbg83AZxrdcgQUr7zvyLMOPS1drqgyPrF1sZs+kjURUZGZ+4Es06Q==
X-Received: by 2002:a05:600c:4fc6:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-4836571fd03mr881125e9.34.1770833683115; 
 Wed, 11 Feb 2026 10:14:43 -0800 (PST)
X-Received: by 2002:a05:600c:4fc6:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-4836571fd03mr880775e9.34.1770833682733; 
 Wed, 11 Feb 2026 10:14:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d52bsm14716155e9.28.2026.02.11.10.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 10:14:42 -0800 (PST)
Message-ID: <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
Date: Wed, 11 Feb 2026 19:14:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aYzFeMh1szhJlJJk@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/11/26 7:07 PM, Nicolin Chen wrote:
> On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
>> For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
>> before the guest boots. In this case, the vEVENTQ is allocated when the
>> guest writes to SMMU_CR0 and sets EVENTQEN = 1.
> [...]
>> @@ -1605,6 +1605,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
>>          /* in case the command queue has been enabled */
>>          smmuv3_cmdq_consume(s, &local_err);
>> +        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
> Nit: though it is just following smmuv3_cmdq_consume(), it'd be
> likely clearer to verify the EVENTQEN in the callers.
>
>> +        if (local_err == NULL) {
> Does eventq need to rely on !local_err from cmdq?
if local_err is NULL we can safely use it, no? Or maybe I miss your
point. maybe test !local_err directly?
>
>> +            smmuv3_accel_alloc_veventq(s, &local_err);
>> +        }
> Should probably validate s->accel before calling it?
it is done in smmuv3_accel_alloc_veventq now
>
> Nicolin
>


