Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8B9CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWDV-0003Vu-0V; Thu, 28 May 2026 04:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWDT-0003VB-41
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWDQ-0003gL-9t
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779957343;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7p32ZveSOYd79eJSK7Qr4Uf8PGaqfR2i4ZQxMCYgJM=;
 b=UVdCXeSLoSNMAXCDCokm6aV+M1bH+Eu3NfaWgGpZ3AAV0WLV3HY0nTbgNlHPoXSt5ESze9
 6iyEVkBCxQA4rlIIegD5mIjphLesm1xTNg8nWUw5mGuR5h+HUZuply7WlRH8h1C6wUTRsE
 Bj44lQ14JirRr7nMKJFHnb2pw85wiP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-ReQMM3ypMyGKh1254m-_1g-1; Thu, 28 May 2026 04:35:41 -0400
X-MC-Unique: ReQMM3ypMyGKh1254m-_1g-1
X-Mimecast-MFC-AGG-ID: ReQMM3ypMyGKh1254m-_1g_1779957340
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd396daedso69173615e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779957340; x=1780562140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7p32ZveSOYd79eJSK7Qr4Uf8PGaqfR2i4ZQxMCYgJM=;
 b=lvBts2FH0ahG8y8grqrxdo+GS+2agcjQLOzeJ+U1kIDm3nFoRClAb5PIjEGEltANmT
 2eMYzXWtQjYX2pmNf7wMGdPOUcsJW9kRL/Mz5TDvWPSRQ78iFKQHpNO+331/s2ft6plA
 AyVexnVBVv6OMnLzN2yxjQ6rynxNhc5cH4cnLxZi6aKVgf3zxTwHusq6jWBHwtlEn/9H
 ZU5Hevy/KDDg022NXy84oLJFZF4zbyn/zrqdlXlVIknCVepkaneln8U87vfjgr8gxe62
 OsNYvIi9SiilyxHkrXMZq9+2i5MQt0Fabkz5dt5keoQi49cHzobZllhqvkv3iOa0spIR
 2kxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UqqQJw+mYF3BPDDragxX5gYAOuX3d3546vpan+Wy2Z18AausESox8NO2lSMcqlVlslQgyHIKEFnC5@nongnu.org
X-Gm-Message-State: AOJu0YyXNHux7YMoB1wNvj6XmaTr2v7ANGEjHlJkc5KXIWfwPFa3GfUv
 UuGb8BrzBeCXPxhl0NgVY4TX9Erv3JCNiRQP3G175nZVZWftz5fad2nAWxGTXvS1adqaxjHkHRo
 h75jbbRaCRMyJ+7L3zE1edMVlkgACbQfkA9OHds6Q3ETT14lbVFVRaRHU
X-Gm-Gg: Acq92OF/rpfr0uEn7VSoVr5+p/SBJw1zguClaWJoX0d1HGPbzq8F6ffwX0jEasmfRW7
 CUrg7XLSH7gzCIPDUNdSBlIBPpvKKTTnhvhd5Db7JLZ8j7hUCYstXNmPhmipZ2N0lCW/qtWdPyO
 dXfmpouzWK5SMm0wneB2w+q79pOnr6FNJGs++u5uo/PJ54ASU3njBEThPjoESpK1A8d2j0aCDWh
 Xraek3lpFgBUwym2Wj069IO5KWF7XxGSmHW2Wk3vRQwoYF8AJttOLwuXQdZqG8aimhprCWJRkYL
 F5j1DDJBQwGKMSpIaXUI4Oy1EDeps+L2FwuyuOciPGHLAV5SukBpa+h+CiL8cWUjXDzCNVDXL/k
 5Fj+bpXpHQlRz25hrEIgzhD8xolOA90GMnjcRiprO6DUGkJhhRbEa8kEdA9J1je0clXoqEQZ/le
 UxThMN
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-4904248ad4cmr334141305e9.4.1779957339751; 
 Thu, 28 May 2026 01:35:39 -0700 (PDT)
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-4904248ad4cmr334140895e9.4.1779957339327; 
 Thu, 28 May 2026 01:35:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a902bfsm43631575e9.12.2026.05.28.01.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 01:35:38 -0700 (PDT)
Message-ID: <f4d57564-12e3-4f04-aa1c-4b828049dd15@redhat.com>
Date: Thu, 28 May 2026 10:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] hw/arm/smmuv3: Update ATC invalidation check
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-2-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260527221631.612026-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 5/28/26 12:16 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Use smmuv3_ats_enabled() to determine whether ATS is enabled for the
> guest when handling an ATC invalidation command, as setting the ATS
> property value to 'auto' will resolve to ATS being detected as
> enabled in the ATC invalidation check otherwise.
>
> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
nit: Reported-by whould have been more suited
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5c2855c377..0c65dc8c91 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1528,7 +1528,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>          {
>              SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
>  
> -            if (!sdev || !s->ats) {
> +            if (!sdev || !smmuv3_ats_enabled(s)) {
>                  trace_smmuv3_unhandled_cmd(type);
>                  break;
>              }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


