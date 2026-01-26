Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AA7D13C30
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkONW-0003lM-B8; Mon, 26 Jan 2026 10:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkONV-0003kp-40
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkONT-0005ce-Ju
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769440783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qH4xRMGaEDJjPWwAVeyd+Ysk+yKlLFbC7vgctu7Mf0=;
 b=iSSF5c1BPcJ3JmS/D1pBC4UjQPCfmlaGumw4KfwzUe+dV3ceBAXpxV4yc65L3q6KU++IYZ
 H123240bWSyY09Ms5e4qzz92h/TnuIob2JnHo/Zh4gWpD1lCMoSEa/o0i10Nqyru+6ut4L
 pzp+2uwq+9K/Gg68JqIYYBqqGWNludo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-69ALB2xuP8STIMzihZOA1Q-1; Mon, 26 Jan 2026 10:19:40 -0500
X-MC-Unique: 69ALB2xuP8STIMzihZOA1Q-1
X-Mimecast-MFC-AGG-ID: 69ALB2xuP8STIMzihZOA1Q_1769440779
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so3084079f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440779; x=1770045579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qH4xRMGaEDJjPWwAVeyd+Ysk+yKlLFbC7vgctu7Mf0=;
 b=urfj/VwWjDLdEznr02i0wqPPjHe/LYwEsOwpVeXrV+/JjMG3qROhv5tM72xIAvf1f4
 jC8jOTPnJTrY1Sf8+FfGMxpxFOcYZk2bz3nQmVF89cznqStBGKyUtpe4+AvPuIhRz7A+
 uG1lqYwTCnn7tl8ni17mNzaOGL8i7f3rJk7I5vAKes2XaF+ozHvMK2juuhyakpVkm4kI
 Ny2/dmWHw7WOdb7LHaPlulFtfLvWx87xDaLEbswODvlbPa5G6uJOlbalbNTzY+kVrUqq
 cAUSTzhTuBXj3uxKmnHsAF67ub2fl2hHn0jw/+1tzASFDLZbj4qCaz3nsrbuJcdyJKgX
 ulQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBb+Hdq2SvRSQEe7Rg1pWDRoAOSUbkYlPRr0qvLq1xIR/wD7I/TK9TIoYY5Yu/ybOXmK4parmF0FVW@nongnu.org
X-Gm-Message-State: AOJu0YxxNoo8SlrZxDD/1n1EcSA69XPUd5ebn2cswVyWonOcxyUfUVZU
 7nRl+nLipGeLNM+4SOHJeUHzkd0sUpgiByRsRAnl6ejahf3rGJofRUJtFcyANgYoJC2HzrklFlK
 L8IqWTBPSRz+mDzFhTzp1OI66D8CIRCQGuclkxa9aYrwF0GJaHn75IBkf
X-Gm-Gg: AZuq6aIIwet4VHKxV3uoWVbo30YrwL72np+O9EGwncZDZj6SXuOESa5ytZrNj50zbHy
 b+JzEniHk/FEE8vIt99ONC1deBViC8r9z+AOjdp9RQfdhCk/avyGwmKioz9c0+Ukkl88hZ3ZXvI
 21qV52AGPElR/z0wLL7/pEOXkIv0QMBBXf+TN5eFdj/1DicSIU/Gd8HiWCnTvz7VRqw1rn6+5Pk
 o8EhkvcrBeZ5NUyXMfXfaHNqfz4vWcvI2Y1yx0cExJJUJMvt348/SGwJDzS8XnhXNzstBe/WiMY
 mSdUxwzqhlOlayLhmkItBH2dp8Uje5VuUJbDf3AK55joDcWHoLDVuwMpqj6aMA3EU9geOp6IWGB
 hSPf05fTXK8Ce+gKjB05KXVpD1onSPsitaUEU2AKaa3mmSvtY1cAfzHhNcg==
X-Received: by 2002:a05:6000:24c1:b0:42f:b9f6:f118 with SMTP id
 ffacd0b85a97d-435ca145820mr9229130f8f.15.1769440779007; 
 Mon, 26 Jan 2026 07:19:39 -0800 (PST)
X-Received: by 2002:a05:6000:24c1:b0:42f:b9f6:f118 with SMTP id
 ffacd0b85a97d-435ca145820mr9229071f8f.15.1769440778452; 
 Mon, 26 Jan 2026 07:19:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7474csm31731079f8f.37.2026.01.26.07.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:19:37 -0800 (PST)
Message-ID: <e3120a16-efd4-4648-86c0-61564218d046@redhat.com>
Date: Mon, 26 Jan 2026 16:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/16] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 nathanc@nvidia.com, mochs@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-12-skolothumtho@nvidia.com>
 <aVLb/zDSDda6eSmR@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aVLb/zDSDda6eSmR@Asurada-Nvidia>
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



On 12/29/25 8:52 PM, Nicolin Chen wrote:
> On Wed, Dec 10, 2025 at 01:37:32PM +0000, Shameer Kolothum wrote:
>> +static void tegra241_cmdqv_event_read(void *opaque)
>> +{
>> +    Tegra241CMDQV *cmdqv = opaque;
>> +    struct {
>> +        struct iommufd_vevent_header hdr;
>> +        struct iommu_vevent_tegra241_cmdqv vevent;
>> +    } buf;
>> +    ssize_t readsz = sizeof(buf);
>> +    uint32_t last_seq = cmdqv->last_event_seq;
>> +    ssize_t bytes;
>> +
>> +    bytes = read(cmdqv->veventq->veventq_fd, &buf, readsz);
>> +    if (bytes <= 0) {
>> +        if (errno == EAGAIN || errno == EINTR) {
>> +            return;
>> +        }
>> +        error_report("Tegra241 CMDQV: vEVENTQ: read failed (%s)",
>> +                     strerror(errno));
>> +        return;
>> +    }
>> +
>> +    if (bytes < readsz) {
>> +        error_report("Tegra241 CMDQV: vEVENTQ: incomplete read (%zd/%zd bytes)",
>> +                     bytes, readsz);
>> +        return;
>> +    }
>> +
>> +    if (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
>> +        error_report("Tegra241 CMDQV: vEVENTQ has lost events");
>> +        return;
>> +    }
>> +
>> +    /* Check sequence in hdr for lost events if any */
>> +    if (cmdqv->event_start) {
>> +        uint32_t expected = (last_seq == INT_MAX) ? 0 : last_seq + 1;
>> +
>> +        if (buf.hdr.sequence != expected) {
>> +            uint32_t delta;
>> +
>> +            if (buf.hdr.sequence >= last_seq) {
>> +                delta = buf.hdr.sequence - last_seq;
>> +            } else {
>> +                /* Handle wraparound from INT_MAX */
>> +                delta = (INT_MAX - last_seq) + buf.hdr.sequence + 1;
>> +            }
>> +            error_report("Tegra241 CMDQV: vEVENTQ: detected lost %u event(s)",
>> +                         delta - 1);
>> +        }
>> +    }
> This part looks quite similar to SMMUv3's vEVENTQ function. Maybe
> add a vEVENTQ helper in the iommufd backend?

+1

Eric
>
> Nicolin
>


