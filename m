Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFC6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 21:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taiTZ-0007i6-OC; Wed, 22 Jan 2025 16:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taiTY-0007hY-4D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 16:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taiTV-0002dV-Po
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 16:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737582081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P8EZFhwmIpURRMUXjVRHCWOLS42efD9s8ASumHMx10E=;
 b=UlcQNm+hWouWi8E+Em9RMtiVi+lBxM6SFZQwN/JxfNlEVQOkdr2T+T0sKUQfKw7AZzI4RR
 LdiQ/1iX1ODxHXnR6bjmRrDFZBsVUvHcO9p7wGA4Vah/7cpEVCjBWGVhxPZf1rJXmYE/BX
 Baxzl6HDWpiikKBWQ6Vf9sCggBqHIAg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515--0-zrYPGM7GI5VWBbpUwMQ-1; Wed, 22 Jan 2025 16:41:20 -0500
X-MC-Unique: -0-zrYPGM7GI5VWBbpUwMQ-1
X-Mimecast-MFC-AGG-ID: -0-zrYPGM7GI5VWBbpUwMQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso55175f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 13:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737582079; x=1738186879;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8EZFhwmIpURRMUXjVRHCWOLS42efD9s8ASumHMx10E=;
 b=fdP2Yq+/D9qk6ySkOoI+bq3qMSzxoqnN/BeSq8C7acb6cxYQ9pmklKHeLf9mx5ZASC
 TgsWt5ixYOxms0SFOwZv+BZwGWnBYqBwlNV4GTirCKH42ut9LBoa+JP8GgAcHCzFKOiJ
 9esywVGCvKajw3NaMqS5qtIEsDfKC8S79yKgvFlSYPdhVbLjQS00XwhX/dKnIRc/XM1B
 //jpRJskHKc8nwfVhMG/w7/i5LjOlr2E4Os5Eo6kHdcW9yQORiUj3JO6hDSX/+x925El
 DmtKkPc0etNcr8puf841hSRnLSTUV8qfw+6RCo3S/xbjbKCXPdML1k1c8EDe27oldzqP
 14Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWouGoDl/HDNGvtGMJDSpAdPd2JVFM4reFKNMGL4rxsrFaSICpwluQLc+YVflHyxd+kczBzm6Kdn8Jo@nongnu.org
X-Gm-Message-State: AOJu0YwY6mpDLTDKKfIcalyNHlljrvfFIVgk72bsnCksa74J94tYVY74
 KrTIPdTNa6bir5PzcBHh1iliMi2eNrvt5hAbj+Mjts9228NJ8luWq9UJttwLgKAAQDb0OIVOpCZ
 5kURYol9oBCZg1vfhVAH1oJJRn0gdVxO7Xr5UCTdY7B5A2Sol/2wntmLoVviJFz8=
X-Gm-Gg: ASbGnctb78tK1juAndXJc6Xlwl7bsYt91l0Uv7yYru6vZMqAXZqwNEISxhv5AhZCT9B
 wZjRdkJS8CvZtjDSQMwpX6EBrKc3wRuYUS5FZZp8ynZgUjww0bo28AFS7+87PTb0h6cUYgYadNS
 ex+17rpyRWs1luNRpoG3qVwWZZCuPso4SDi0fwmEkDgpAU9oZH/RXr1Iy+mnhqq4K6DQKrTI+tX
 7en2yqN1Ho2/vF2KRfx41pRYm33xB2p44msAaryOagjvZ5kwwXFeH6vUXkPaRilzwEgQTJnklWA
 szXRexOnmACoJfUs4uwp+XD5592lhVSCaCAlRlxl86OtQ5oO2Rcl/swVBA1ObMfT62Xo0ScTLIk
 wRh9EKR7tCwbOo85YOgLg8w==
X-Received: by 2002:a05:6000:188c:b0:38b:ed6f:f012 with SMTP id
 ffacd0b85a97d-38bf566e472mr21276066f8f.9.1737582079336; 
 Wed, 22 Jan 2025 13:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBRWi+NSvOOgwilkMXEhRme+8t0R6Q95NMhcapnqy4KdJtgQ5/Ino4GW51J0kwmQ+clmuVhw==
X-Received: by 2002:a05:6000:188c:b0:38b:ed6f:f012 with SMTP id
 ffacd0b85a97d-38bf566e472mr21276052f8f.9.1737582078997; 
 Wed, 22 Jan 2025 13:41:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:db00:724d:8b0c:110e:3713?
 (p200300cbc70bdb00724d8b0c110e3713.dip0.t-ipconnect.de.
 [2003:cb:c70b:db00:724d:8b0c:110e:3713])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327556dsm17347891f8f.71.2025.01.22.13.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 13:41:17 -0800 (PST)
Message-ID: <b8a278aa-f6d5-49cb-80c4-acefe912a9eb@redhat.com>
Date: Wed, 22 Jan 2025 22:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] system/physmem: take into account fd_offset for
 file fallocate
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 peterx@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org
References: <20250122194053.3103617-1-william.roche@oracle.com>
 <20250122194053.3103617-2-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250122194053.3103617-2-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.01.25 20:40, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Punching a hole in a file with fallocate needs to take into account the
> fd_offset value for a correct file location.
> But guest_memfd internal use doesn't currently consider fd_offset.
> 
> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


