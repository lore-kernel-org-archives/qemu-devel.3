Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E150ED0C84F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcCf-0006lV-Og; Tue, 13 Jan 2026 06:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfcCe-0006jR-0i
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:04:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfcCc-00073A-Hc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kmjYB0ndYp3UYujGMt7pRYV9FbwOgXCrWaG9AtDpkp8=;
 b=gxVXdYRIL+RSYfvAMADkvxQzbSVNOYwGhQHhrAVjaP2vOzKMqGjV2o8vRa8WEuRgb37gwi
 ees7DGgRoEAD0NXTpAtcElDYis+N2WB+o6BXDIBtLH8sTiFYsPYNZ7OdY8f+PQCcj8GU4K
 dFDqLCKjfv8cEd7ZnNh8PrfgkBeD1vI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-jox0Y9vUPvKAePs1Ocu7ug-1; Tue, 13 Jan 2026 06:04:44 -0500
X-MC-Unique: jox0Y9vUPvKAePs1Ocu7ug-1
X-Mimecast-MFC-AGG-ID: jox0Y9vUPvKAePs1Ocu7ug_1768302283
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so44903155e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302283; x=1768907083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kmjYB0ndYp3UYujGMt7pRYV9FbwOgXCrWaG9AtDpkp8=;
 b=WYTDSLeRu/OvmyjYCwnT/ot/jelKPPhE4qJzYttrVU91LWcRHIxSfszeEQfAnYqe4m
 Tr6Luy5F4a0kJqi9mjq7CCv4UMEEtV4SxmF4bq3Fjs+rhvDnm6vB6VrVNyLYTFlGBeYX
 4tWW/RA1qJ/hjRO9mt1reGOo+qXZSK4T/EUYIYzuEzgvN0URXqh5VriiwxPJwUnXODzs
 wiKzpTy022uzv+frhnhqgYNjJrlIHM6uz9UeyvpVyRy1onYA2Wm79lP//m0dGQEKw+Zs
 HGR+hwwsdgmbMz989MYkPSZKgS0wL5TY9SLQl9ULRsJLPclqUdamaswZ094xY283/L+L
 dhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302283; x=1768907083;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmjYB0ndYp3UYujGMt7pRYV9FbwOgXCrWaG9AtDpkp8=;
 b=Y3A370fZbl514VCgLivcpASkr0KU8p1YkktVM9M4esx4xCycIwFaqKFztOtvz8/iIu
 ace4aCCSp95cEcB+h70MFqkK4Ygl3NCdddmu/RLPMWCKOopcOLm1cZOJadkCSGi7INc3
 ef3v3raEqDqwT320Whsno0+JbMGxJZOdroRFD0iiWGzQg0HYuJKOjT/94g5vqNFx+ZTU
 FGqOXIniJiqryjlU5qamicqwwd0YtzGxy+XcuOgOxxLxwHAO/elNmiVG4KXMuf9SJFHi
 X9eFTCqGebqLuElrdeCQBUUx7g6AocHIGkIqiCOZnBi404tmEDIvKDvhyEgsBiBsz2qc
 bA9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Db8rGUHkmK67HbIq0LiHzPiADY6acgdXjLt+SYMYVea9qrHwleqBfet1KnPoPGvys9Rx3KIkOvRT@nongnu.org
X-Gm-Message-State: AOJu0Ywnvw65fIC47caZR2nZeh1r7pK3A680oWaVgQDSIC6nO4XiLRiJ
 GdpWs4a672Zrd0ni0qrxU59P2VFO5KiOFkDZX8lrpFZ90CuROjGAZSPEyQRzKRutwe+W6obquih
 SQl0Fzx5fIZldEjzu1N0iJOih+jKxbDByiDtTz9Rw/rEm60CBe3WLqKyD
X-Gm-Gg: AY/fxX6qHHud+6XUlZWbtiRfHAcuX1jZo/vt534Y17YKyKwAwTTcgmi5FaboDUcgIOz
 vhFdHcEPV2yFTd4OD3dfFrrwWPtV6OPtN4Xq3da0gvLQKUFCdC/4ZSY6Q226I3a4AlC8Xe2XLSp
 /U8YRsnwj5vRGPT0TD/clCc34SiGn5P3IQS8UuLT++UeOmIfgyCoy7aVfCHYn4s9yX82NYn6Q6A
 HZBSUQg9nhBIaAHuNal/IDAWF209WIAbOeUV6OGNj5kKtMk71r2+nzfhvbhBsgB5zC1ih76jBpt
 xIPyqjhXoYE5gZ2T0B5w/DmVycF9ZWBHuphWghf1WHy0tNEJguNIoZ+u6l4UwYJqUZxMlYZLL7u
 YqPyg1MY=
X-Received: by 2002:a05:600c:747:b0:477:9d31:9f76 with SMTP id
 5b1f17b1804b1-47ed7c284f3mr23709615e9.12.1768302282948; 
 Tue, 13 Jan 2026 03:04:42 -0800 (PST)
X-Received: by 2002:a05:600c:747:b0:477:9d31:9f76 with SMTP id
 5b1f17b1804b1-47ed7c284f3mr23709375e9.12.1768302282558; 
 Tue, 13 Jan 2026 03:04:42 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa07sm43620741f8f.25.2026.01.13.03.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 03:04:42 -0800 (PST)
Message-ID: <d9f94fcf-30d7-44ec-abac-939874be082e@redhat.com>
Date: Tue, 13 Jan 2026 12:04:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] scripts/mtest2make: ensure output has stable
 sorting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-6-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> When debugging mtest2make.py changes it is important to be able to
> compare the old and new output. This requires that any lists in the
> output have stable sort ordering.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


