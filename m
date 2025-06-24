Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357EAC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 06:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTx9J-00085S-KO; Tue, 24 Jun 2025 02:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTx9C-0007xd-PQ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 02:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTx96-00088o-UA
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 02:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750746515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XtS28GFK87UlefidfQAqXygXLsTgxyD6VYBMYrwE4DQ=;
 b=d1WH8ZRljNCknZT2ybOVCy8fXAxlDPaJsUhRa8tU9kmucbsuC8JZIMB26PwXqTyCciPUWj
 v22SMUViKOPjkNr/zCOXxeLohpyvgiwEqnhuyFi2glVec8dkDsyModzrsrPSXRxWeq2I82
 iGRz+wcaQoDLoQusSDIuUhjQpbRkxYg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-9SHPl2cnNnaGuZQpeZCvqw-1; Tue, 24 Jun 2025 02:28:33 -0400
X-MC-Unique: 9SHPl2cnNnaGuZQpeZCvqw-1
X-Mimecast-MFC-AGG-ID: 9SHPl2cnNnaGuZQpeZCvqw_1750746512
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d90929d6so917105f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 23:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750746512; x=1751351312;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XtS28GFK87UlefidfQAqXygXLsTgxyD6VYBMYrwE4DQ=;
 b=rJYLXUXJVsoEQGarGJ2bAED9638VkxOZXrZinlxuuphaezqdZExLD8gqvWWS2WnkZ7
 3cqAGaI6EaAYwUIR9A4tp1ax4axnE1iu3el/VrgHBPDot35Upcn9rc+Jfh2hd3Jqsldm
 BDsnd2HehcRpzUndKuFc401lc+NLIlTH7ZIBFCgTPl/GFsMMaK8gl0ZLlXlEjG1u0mha
 czjk58zOlaSqGY0/MwgBL7MBod8T2oe5ls2LtG++mfzz7WYFZknItmfH71jcIRzI4H9q
 SpPBKA+AWQXYy10Uvj/LdmD8HD6YlRIrclRq5xSg+qWHhu6F8QCpClVqbQ7u+1svDBMU
 VgVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKG7XdsHcWm5gdmGuZ4i1exTqUi8eR5l+IPxld98y7GrKEsvRzpa4EJx9ioGwunibx2Pq5WHZeswUs@nongnu.org
X-Gm-Message-State: AOJu0Yyv2P+z6G0o+CC1WUsfCrQh+w6M7gEGE2NX8AGeG/UUOOW68KFj
 SFQHXi+UrXVlWGvKP/o0Mzh1xU1eb6nUJNDKdCLqRbS0fdVKR7CyixqV/PqXzvLbguqud0jkb4y
 yfl0H+wkHuTyBfOqsYEyASQQMQTGm47q++vzZuUg9Xl8/hX40OnlIiXwm
X-Gm-Gg: ASbGncvQOCGiav8Br4V67Hj9kHVDGSrXJGL6o6oDPOwk6CM35XjQsVkvJ3h8j5rdGgm
 iG2S/4hZXQmzW1BQl/6Ki2E86WzGXx5/DqqO7VfZ1LVorNiJt9vPk+1pExSfnluLfbIGYjUADpY
 VSj7EWqMAQErk02GF0Tv94IQt2BQduvwWIoDxiMr8g5DSsSvbbXNwozYZvzt7Ycesmaeq8TrHTM
 c4CcYyCJjL7hy1cE5gFxsxOl7iTNaI0pNoqvrzaP2E6bHPOoVNdF/UlCEV7T5HZ+NVbYeChBB+9
 HtNwKFqXDpX0sS7v9T5ugZB0mGzKImS3o+p9eWLccIDWCSYcYw4HzocKVT+S5lY=
X-Received: by 2002:a5d:584d:0:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3a6d130d4bdmr12805389f8f.39.1750746512092; 
 Mon, 23 Jun 2025 23:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnqW9y0uR9xN5g9yMaNRYLPm9tdUP8jj+Pu7YGXgyHfGO0IE7vEeg2M/ICZnN87uUUXYyrDA==
X-Received: by 2002:a5d:584d:0:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3a6d130d4bdmr12805357f8f.39.1750746511689; 
 Mon, 23 Jun 2025 23:28:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8113b00sm1082420f8f.96.2025.06.23.23.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 23:28:31 -0700 (PDT)
Message-ID: <e4e7a238-6438-481d-ae6c-8263730bc239@redhat.com>
Date: Tue, 24 Jun 2025 08:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
To: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20250509174938.25935-1-farosas@suse.de>
 <7a850346-8ae5-4dd2-b4ce-7ffb1cfeabd1@linaro.org>
 <1cd816d0-5808-4caf-b38b-9e4ba10680b6@linaro.org> <87sel9et69.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87sel9et69.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/05/2025 17.37, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 12/5/25 16:07, Philippe Mathieu-Daudé wrote:
>>> On 9/5/25 19:49, Fabiano Rosas wrote:
>>>> ASAN spotted a leaking string in machine_set_loadparm():
>>
>> What about ccw_device_set_loadparm() in hw/s390x/ccw-device.c?
>>
> 
> Yep, that one as well. I'll send a patch. Thanks

Did you ever send it?

  Thomas


