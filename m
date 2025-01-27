Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F2FC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcReg-0004hR-6j; Mon, 27 Jan 2025 11:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcRec-0004fu-PY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcReZ-0000cK-6m
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737994076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ffIslbuC/1CboQ3Cr3u2D9chDxuPHg1QMexSVesY+kM=;
 b=N0c1nV+Phbm1+GCkmq5prIKnqIkkTtXH2rR6/wb2Lqb1AL5WKRsQN/L6IekCmc7OdHoGF5
 +bj5f7RtGVYZNU+/QrOxcazcWWxpol5bMxDJlpwFauXK40C+x416wECSlg8LXDF7WnUCGo
 gQrXzKO9Dp3BAw6XMSmp2Nfsrjo+XoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-w9BwvdEjNQu7R0Y_wjDTXQ-1; Mon, 27 Jan 2025 11:07:54 -0500
X-MC-Unique: w9BwvdEjNQu7R0Y_wjDTXQ-1
X-Mimecast-MFC-AGG-ID: w9BwvdEjNQu7R0Y_wjDTXQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso37795055e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 08:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994073; x=1738598873;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ffIslbuC/1CboQ3Cr3u2D9chDxuPHg1QMexSVesY+kM=;
 b=bpei68yq1178OLt+464Naji/uAnte/UqqA62hqHBLRNLPTczjZ5hzAQAcNhbLwcUmS
 DROzsE5ILtYPv20W2t9d9OSljNi16VaHXZVAbbTcX9/rH4tZuCA/7GmlDhW+AKQNLSi2
 hs/Ciozh50bht/wHOzkR3p5f/HmKbddtGtgOi8UvAXTO6tRJgiSV7ofV9J4539IAbk5r
 fz4lHzJshwOGLj8vw7cdm+uOfhxeAUaj4M1FTV99SBzLSN1uKHJMuO0DVG3chZz/+sGU
 K+2JuPRBLtfR4gMcs0QoyAUTTWX7rAxljgQ2jD2zYqgA8Lyq9vx/GnRIQRuGaFVEBPDY
 dfxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtpvoYdL2nZ9s4qliDjtUsvT9fm8GnY2NdSZrqo2I1ERPvqWBpH1hV6ZgdNYCCxcFavTfxQ/8bUgwh@nongnu.org
X-Gm-Message-State: AOJu0YwklFpeeSzubi3UapQpuGXC60jhv8/bFDuKGthxoK+EXMnL3f2z
 QQC1BJ+6CsmnWM3rzgaiEA3KPlFAVUAZurxhzgNvcWqQKWQI6gg06yUYfFeMmAb/+5hI/RKDVM7
 N6H+t1O0Nf/W/4nmbfmtkK7HCFJFaSyVqDrJKiiykFme1OJ37J2ni
X-Gm-Gg: ASbGnctt4cOyk3JoovTQVa1vsxNN1ysKf/sVMmvcDI6AYECItKSmmWusS51xbleFI+6
 n/Lc/wgfzAKp5nSaAOEhzN/5O2Vs+m+KwG3MfFLSYEw/Fpb0qzrrEuP1NT/tNPesBmmecxIpfgB
 mwio+9grU3398wvP7gxvpSdtUarPYxtyJEI9n7/afdk+JRl2jARj7rQ9NjdAJIgxqmzyFNBokLq
 3XlfwFknge2ArGEIPJD17EGsJaMsm+OwLKqTRyOSglDXhpR8VcAxtISyWwo0wz5wijaP1ESIip0
 3loBShwX5vDhBOoSZxq07uhtJtXLzMs42raRorGFUsi/Vmh/195e2f3R8zrfB5hpDVbrzqkhi/5
 ykcfCqyGMny9ocaPa1oS9qnMvWe3jGBgN
X-Received: by 2002:a05:600c:468d:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-43891437546mr343470555e9.20.1737994073664; 
 Mon, 27 Jan 2025 08:07:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjHCoN3IFrsKJljwzGURa7Kyil4Updrk7tDVN1+sdVa4lo/CK0xe6eYzlpZgBa9Q8NqbwUTw==
X-Received: by 2002:a05:600c:468d:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-43891437546mr343470175e9.20.1737994073316; 
 Mon, 27 Jan 2025 08:07:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c?
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4c75c0sm136205785e9.31.2025.01.27.08.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 08:07:51 -0800 (PST)
Message-ID: <29409e1f-9e11-4259-812a-0ce5a935b08c@redhat.com>
Date: Mon, 27 Jan 2025 17:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] s390x/s390-virtio-ccw: Support plugging PCI-based
 virtio memory devices
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20250127142824.494644-1-david@redhat.com>
 <20250127142824.494644-3-david@redhat.com>
 <270c3c94-185d-45d2-a8b8-34f8d21a9cb3@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <270c3c94-185d-45d2-a8b8-34f8d21a9cb3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


>>   
>> @@ -589,10 +593,12 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>>   {
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>           error_setg(errp, "CPU hot unplug not supported on this machine");
>> -        return;
> 
> This looks suspicious. Do we really want to continue executing the rest
> of the function in this case (though there's nothing to execute
> currently)?

These functions are usually a big switch-case statement, so the "return" 
is actually superfluous.

Note that this is already what we do with TYPE_CPU in 
s390_machine_device_plug().

Thanks!


-- 
Cheers,

David / dhildenb


