Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76A1CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 06:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umR0c-0006bB-BM; Thu, 14 Aug 2025 02:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umR0a-0006aI-9X
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 02:00:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umR0X-00036h-9G
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 02:00:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1964so264456f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755151209; x=1755756009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Iitk9w5rr+V2R23xhix63QDyEadp1pv94exfgHjEW8=;
 b=KulnRp9X6n4X8Ats8tkN4AxXolFaCrOFB27eUYolJgBZ1xAttF1hHIeJq/fdQmNTZ2
 /Je417FekURc/a6X173x4Gy3SS9a0P+tsXd5zcbZN7Klv7WaxtyIRg25drfAU/2p6qFv
 qogbx1JoC8Ckr6PXwrUGh+NPjBH9r1rOMQPhKMl7AgxEw3B0rfXELSHJ+5TOga00C5nk
 uRLPrTvpU0a2hhqiy4DYbbj4bBNI+MmkL2pKykNOtv61CijoWKnf6Wb8u/HOfal1scwl
 SC8AKuvYyiVZ7amw9dm/xwmfn16Q98BFSDh3WxK2LexxQVI9td7W5Si9k70qwWDfesOQ
 SKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755151209; x=1755756009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Iitk9w5rr+V2R23xhix63QDyEadp1pv94exfgHjEW8=;
 b=e+XLShDEodJWlRzzV/01+4eLxOXWDoGjrb46Nso3DkI/Kn0S73J2cEMM+wX5WG5/o8
 Y+9Fk8L03Z/EPU1rkyplsmgTixFSBWNDm/yiJrEDQx6QD3guRBUWvFyKX2mwr1lg3frJ
 eNLEHSltkFTOrpiYD+jxcaqwIfDbao7ZBbX6vSPXac3PTHPg03RDD3qB6q2TpEpRppFQ
 ejLdOL1u+wWC4LkMIYbwrRXsj46URFLgdb3j5dd7D721yL0Myf6/P1J2qNYGn7vBmkj1
 C4/L5YeMkMmX0EbW1PcIMBIcJUBH6aggDk4FsM1eAmQuGH1YAJrNftiiOmvtOgACVxAo
 ptqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF6xhOHJ2HyOBARgMYdyisxI4nUSGUHR7KEXrPyO8E9pdOVc2sGT5XJvMvVTX+oUiho8nq0CZ1rT38@nongnu.org
X-Gm-Message-State: AOJu0YyOY2ff+M6PU/JQpV14DsE1QK38UGQL9SaqXjvV2u3RxbNwVRpE
 oK86NfirrKEg3jqBJAm8ktOlgb4sECiVj7Ske2020J1a4034ibYEL9+/arIS/9XWiI4=
X-Gm-Gg: ASbGnctx+UksNSyvy4Q5xEzsCQy0WuWRJR8H04e/rf+DylQf1PbCDF5E68t8SfkCUxT
 SQ27jAxlhy0j4KIsu3354K74fJHtT1ExHRpSHpefj3BCPooUVakfaT18wEz9G1dj46A+/w/pQMB
 EP/tL4zipHRlrrCjXz1maLT5LFG+/yhv821QyRN4kmljmHSK86axWD71Y4ETawOF02aCK9k/ZjM
 WmSgLjeFFn6ce7769CKcbCgYAOroTW84OUHp/uTQ57tCF9AyrVfLHmuFzSjkkdlNh/sPWBFXzQo
 TPgZmE1RtUYqRviMbpNDLX8M7Op92HxYyl15XsPGpY537hNyfCK97dXo2sW6bJHJJUsKde4Kp6J
 lYTM7H/RXtAjInZmp9DN7cdxopXUg/hwUZq8XWlejC3W7EzZy2tUCg9VS0n/Vce7hGA==
X-Google-Smtp-Source: AGHT+IFmPqFpBlYZBRLMOjIgFYNYD3Mj0nxf+DRk3aCZcy9ncYbHGRhbTKFSVmh6hDn5q7JEzv3nZw==
X-Received: by 2002:a05:6000:240b:b0:3b7:fbe3:66bb with SMTP id
 ffacd0b85a97d-3b9fc3701f4mr1327361f8f.50.1755151209416; 
 Wed, 13 Aug 2025 23:00:09 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8f5d7deaasm29077508f8f.65.2025.08.13.23.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 23:00:08 -0700 (PDT)
Message-ID: <3c38d041-9692-417f-b1ba-8577818d7f57@linaro.org>
Date: Thu, 14 Aug 2025 08:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] hw/virtio/virtio-bus: refactor
 virtio_bus_set_host_notifier()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-21-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250813164856.950363-21-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
> The logic kept as is. Reaftor to simplify further changes.

Typo "refactor".

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/virtio/virtio-bus.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


