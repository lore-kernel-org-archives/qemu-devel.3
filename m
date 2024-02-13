Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785BAC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrjP-0002a6-V4; Tue, 13 Feb 2024 07:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrjL-0002XX-IL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:17:45 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrjJ-0005AE-M8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:17:43 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso34180815ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707826660; x=1708431460;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SXrE7j4odyf4d+oxwoJT1kvPsBQn7TpPvBpLvOWp9Wc=;
 b=NgsXnMzC5VVysQYqINSOblga5Ve6ZoIAhW9mIwTVA3wHGIcgPCuyBa0Oxwm9u8dfbr
 u3XS56Ay+bp79EmcBQslDDJA/MfWIDxlZrF4YpmxZnJvuGdMgSRw0QEN1E3B8xrMcawt
 znq8Mbc2p5/jvubw0QDse27bHlO/du1b/ryT7XbKB4sO2ZEbejsK6RD6UJkIjoXfSp78
 Eccotgcv4zgQe9L7t4SqARFy9OIRegUWirmmst/ONqy+2HzEkr4mt9k4zgsTP9AgzQue
 hfcWCutY4s7N6dkY6Yfc0cB9gfABhdXw30efmp+r5/R+Yvs6SLBg5oGDgjiLO7JgH7Co
 JLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707826660; x=1708431460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SXrE7j4odyf4d+oxwoJT1kvPsBQn7TpPvBpLvOWp9Wc=;
 b=Oi+QHHfXr7H9NbwKKLO75NUpwGpP5GGuJsZcLsdb3M/mHLoap24FOWlYAnb4cy5gU8
 CF2HcaTnEf9PKxotUP4Mq2EhCJV6pqrooGYVP5NP275Xi367RPb521iBV0vmxkVhwl12
 PRBpuH+PwzgKHsKYXTxsGv+wY1qF700KGNIN34gNEumiJJlE2U/KhqerrIYkZjXY5qb/
 Ea3BVBIGE3gn5Osyaa93I8sZ9IdBL7sZSkuHMRU5KU3ZEvqV0ULiotoRjCHpPfjE3VeI
 /ErPlN1aiuF1lA2MGr6iNqBAofNtsZpBJbNVcKS8Iy3zO6gQ54mXZ0gEUPRvrl/GhB16
 QNvw==
X-Gm-Message-State: AOJu0Yy4Urp/jC06UJXEbfC5VeznWmUxyieb6zDZAjg6MErp17YLtywp
 mUDAjV3sB6AIS/PJWDRn2Ez0m7RlzNZjvIQZiJYuRd0eRa0kRVsuWBLRAcrzLKM=
X-Google-Smtp-Source: AGHT+IFdfL0zCbNK/Tw6qbcVDZWFQTb9MR/Pm9MJmAbI6st+GSOZGPgLtUp0j4cOzJTdthvL5zTo3A==
X-Received: by 2002:a17:903:24e:b0:1d9:b423:7a9 with SMTP id
 j14-20020a170903024e00b001d9b42307a9mr12077942plh.24.1707826660239; 
 Tue, 13 Feb 2024 04:17:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXV1XOoI3m/hcMJLh8QKKyC056jIOOb0Khx7Jr+NUGc4xxpBJ3rF+IEpMWgjSJRmIoZlKsEt9P+j0g1o3c9Z9qx+DQTZ+/d4LvUGXeHKkMlar1O3yznI42TnSxujl3gDbAu+w3MqT52mloJIPixRncYbmv0gEYJZVGon1oL+JS8N1uBeanZJjnPt1q/Ts8/fP48/ltXQPZ9juC03jhIpWeJiIP2Yf83z7T+1YbH75x7xqtQ32z6bfxGzwrnhUv+dDnlPlaGTIZzHImrf3b6VHHicEOLmR916MKo6bQKCJkExBjL5c5quVzLj3+ac6/3DrueIZu/VxqAKL99oK0czNWQMvjdcgkNcCx+iuDiCgVzF75xv4RmN1/LfCFvbzOrgR3gCj1QNjUpgWKpw0J/Rv2ih96H+oTT9RfagA==
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a170902ec8d00b001d944bf2d83sm1987555plg.7.2024.02.13.04.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:17:39 -0800 (PST)
Message-ID: <fce960cf-a482-4c09-83d0-0881d4e0fb29@daynix.com>
Date: Tue, 13 Feb 2024 21:17:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
 <20240213060116-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240213060116-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/13 20:01, Michael S. Tsirkin wrote:
> On Mon, Feb 12, 2024 at 07:20:34PM +0900, Akihiko Odaki wrote:
>> Disable SR-IOV VF devices by reusing code to power down PCI devices
>> instead of removing them when the guest requests to disable VFs. This
>> allows to realize devices and report VF realization errors at PF
>> realization time.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> It is simpler for sure, but I am worried that all of these
> unused VFs will consume lots of resources even if never
> enabled. Thoughts?

My rationale behind this change is that the resources should be 
allocated when the PF is realized to ensure the resources are available 
when the guest requests to enable VFs.

When it is necessary to allocate resources dynamically, the conventional 
hotplug mechanism should be used instead since the SR-IOV interface is 
not designed to report resource allocation errors.

