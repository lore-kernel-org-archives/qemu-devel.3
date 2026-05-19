Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133AECD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMPL-0007kF-RF; Tue, 19 May 2026 11:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPMP3-0007gs-Iy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPMOz-00026t-5k
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779204636;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbFnpEON0Fz2Cokbg36/sVGM6cgSUagu+eJrzPU6cbE=;
 b=YusdUu/ePtijwQ+qHjHsU/dQZq17xFoT1+Q3imTCRpjCbxMhc4j9YvtFE0YMe+tfZuiv8d
 BgU3aJvd/VIJyIq9qRWGE6ZSuzwp81oHs1O4bkKoRY6ngX2PV8j514hmln19vsq/1x65w0
 nltCRxIxa+oTYG4bYIA9Z2Jb+HkuTak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-vI7hxhREPsug-DhGXhZj_w-1; Tue, 19 May 2026 11:30:34 -0400
X-MC-Unique: vI7hxhREPsug-DhGXhZj_w-1
X-Mimecast-MFC-AGG-ID: vI7hxhREPsug-DhGXhZj_w_1779204633
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48feb029961so21958805e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204633; x=1779809433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbFnpEON0Fz2Cokbg36/sVGM6cgSUagu+eJrzPU6cbE=;
 b=gpPn5HvCVtik/uS23CuFSeYoxldT1dPq+clajK1dhnRfP5h5TDFVak0SMqCKpAjomU
 sazGFyVaCxfXSrFobq7JzVHHRDG4tmPGz+Ef+y704rV6ZSnTn2SE0yjMIDPn3LJKwgAJ
 SZww5I7Z6IG+CtDKX9ZcQLOv6EDHLKu/2wqpySEpznyHrl5JcMKbkOMBH6TDW9t/Gi5d
 Ez8yYU+Dx6Y3odlExHw7b5XrmDWtiF8SOVcv65JxKKE8VUhMCRBq5jAMx/2ykiUBOsDy
 fyiYdEwdxeSmdXtoZjTn6U0IRVWQNOjzl0l3l8Tdw8/LZhVYoC4jX224jXj0VsWlFwSN
 axxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nkPJpqWRM6tiYxkGR19ZeJa2BNO+u0sG6IMraGHImTf0gWijOqxDncO2H4ABSANSY+kgtVdhkxjrM@nongnu.org
X-Gm-Message-State: AOJu0YxKiOSokmHdB/aNCV+BkH0jbld0/IEvG1BoRnSogEBITOV21j3u
 S1M4+aCs0u56mPDA/PVsPiGi2Lu6DMogh1zHX2vcz5ez3+M46SNg4mI1sp2JyxYD+BITZ180iXg
 Y+PU7PF9lG7VaZR5ALJYENHXG8KrA91XOxC25PvPq3F68ySWOHGQOrHt5
X-Gm-Gg: Acq92OFQcRUO5CbVJ9oCOS2PKE0hT/B8NzWEMsJKFl9svpoqoMdidTT3X2m8zxYMnVN
 i2M0jFeHkg1Go/oMkPL495WCrxTl0y1yPWVqLJMSPnmn9kj2GSyEfQU3AiC2byf3kudothqbsYf
 KIQU5OpLlSRP5zZJ+fXqAzqQgcW50tkYq1DfSwkT1JmzkdwfIWc3Vurz+gpl1fku7i+Oc2PpBfa
 pU/+nkJJkbA8EmCAZW7PShghEnWH4xt9FZ0Cr8YTSx0t+Oh8A88FIkT9czpZURgsrPjADN9pq2L
 OknlVQK6pRe9XWgXkf9k7Qj7RdPw2ndrrsFHGB6lhe9gjptCP/Fa78uFDdYrAnbd9xK63ZRly6+
 WydYshJbKrBZaBqyCUqR2RwsWxu7HoogunEVIZsrYoMs9eYL3pdEWUVn0DboRDF2FCn2hDQ==
X-Received: by 2002:a05:600c:a102:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48fe60da919mr234142815e9.14.1779204632963; 
 Tue, 19 May 2026 08:30:32 -0700 (PDT)
X-Received: by 2002:a05:600c:a102:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48fe60da919mr234142345e9.14.1779204632561; 
 Tue, 19 May 2026 08:30:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm42999648f8f.11.2026.05.19.08.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:30:31 -0700 (PDT)
Message-ID: <13629ab2-f89c-42d9-9be1-8341e8146835@redhat.com>
Date: Tue, 19 May 2026 17:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-3-nathanc@nvidia.com>
 <CH3PR12MB75488C9306659D939ACEE203AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
 <cb3f2ace-be0d-4b5a-ad3e-9de541a2444a@nvidia.com>
 <CH3PR12MB75482526F3E2B515168A1E16AB042@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75482526F3E2B515168A1E16AB042@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/15/26 9:55 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nathan Chen <nathanc@nvidia.com>
>> Sent: 14 May 2026 21:07
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Philippe Mathieu-Daudé <philmd@linaro.org>;
>> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>
>> Subject: Re: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value
>> for "ats"
> [...]
>  
>>>>       object_class_property_set_description(klass, "oas",
>>>>           "Specify Output Address Size (for accel=on). Supported values "
>>>>           "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
>>> In smmuv3.c we have;
>>>
>>> case SMMU_CMD_ATC_INV:
>>>          {
>>>              SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
>>>
>>>              if (!sdev || !s->ats) {
>>>                  trace_smmuv3_unhandled_cmd(type);
>>>                  break;
>>>              }
>>>
>>>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
>>>                  cmd_error = SMMU_CERROR_ILL;
>>>                  break;
>>>              }
>>>              break;
>>>          }
>>>
>>> The above !s->ats will be true for AUTO case, right? I think
>>> we should change the above check with smmuv3_ats_enabled().
>>>
>>> Also, since we modified the ats to OnOffAuto in the previous
>>> series, I am not sure the above should be a fix patch or not.
>> I see, I will use smmuv3_ats_enabled() here to account for the AUTO
>> case. I am not sure if it should have the Fixes tag either but let's see
>> if we can get any guidance on that point.
> The default ats with previous series is ON_OFF_AUTO_OFF(=2). So even
> if ats is not visible to guest, a malicious guest issuing ats may end up
> getting forwarded to host. So, I think we should fix it.

good catch. Effectively you may add a preamble commit fixing this in
this series with the corresponding Fixes tag. Even can be Stable to
apply on previous 11.0. version

Eric
>
> Thanks,
> Shameer
>
>
>


