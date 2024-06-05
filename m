Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F5FC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 20:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEx69-0004v4-VL; Wed, 05 Jun 2024 16:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sEx67-0004uZ-Cn
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 16:19:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sEx64-0006vb-Fw
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 16:19:03 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7025c5e6b94so171281b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717618738; x=1718223538;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGmNj5U9s0Ukrms4ASkOuI7wb/P5Lf+WDkeNFyTWwS0=;
 b=1zFHxvfnABQ5BnbDW3X25tQV+Mrz1z4jkw+JWLcmMb4Gr7YUr1xfd/6zi7Nvd0N465
 1R+LvdLw5mPyEqdlM3905iD8erswu++XDPda2AFkZls4rUozOPOdIaYXV5x8+mlcdg9t
 FdZcbDskg+ujVCPP76qvuNLslRVHOBF5GsrY0jHF0XaPGjVXwT7ECqzQsJ4yjjpkj+EA
 ReqfbrU3vUANV8pd9Hp8mwzz7Ehet0oZh5ui7y7+DUE27sJlg7Df7EzbaU99P8QXiqTJ
 ICqyIvo0I7ofNigjbG0rl6WIRA02WsYlUNc8RimpvLpr1kp3WcsnJaKX/YroKWnAEATE
 EqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717618738; x=1718223538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGmNj5U9s0Ukrms4ASkOuI7wb/P5Lf+WDkeNFyTWwS0=;
 b=AwUwJW6Kd85A3iB3dDWieRbeghxz3mt5oD+siga5brkcBEUbj6aJUb0KxxFbX13RKA
 wA7xZRhbnFduX6tHdVJlS2cnfSC3n+ve7+HIh5EnjqfVpeegBM5jvJ+DypQ/gXsI/iLd
 VMf97YGRLFVDXOK0cbn7ygCuVaXDjtVLbv8kU6WlSuvYoA1kDCOCOLUyBNDOj108btvp
 4zrmBOUKakKGT8BrnpLgtG8FDM7EN1kHk+1ropJ6yO0mkB411CFdTzP7Ymp2/8IecyIU
 ujKVfJNLtt1jTy86elmge0hMciWNsGdJLhKusarCPO0PhrzWfT2vJWqfLM+hHcn2vfx7
 dRhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfeak35rynJoOQP4md02KF4cVi4zum/NqBiBXCRnf/ndB/I33JMFRw+XVX3ee6ZmpNJZrKTsh8vXI2pkE593c+A4eXCe0=
X-Gm-Message-State: AOJu0YyDwCj2ae8iSQC5IXhIqVh9DD/qnRF87RAWfuNxjp2ljTSDS/CU
 FfxtYe96HBh4uS/CgBqeCD/oj8/LWdV2gxylUh+ymiHiXnyo9EmS/24tUvl3idbX+JmEj+GEBva
 j63w=
X-Google-Smtp-Source: AGHT+IE4FUcX2Lwrq2oErw5/TwYu8AN3HsPfAoyWJRPDTA+rvg573TqTBYsIhdzVoz8MMW00+yaJGA==
X-Received: by 2002:a05:6a00:1146:b0:6f8:beb9:c0e1 with SMTP id
 d2e1a72fcca58-703e56ce879mr4144112b3a.0.1717618738274; 
 Wed, 05 Jun 2024 13:18:58 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70262c7d382sm5945079b3a.106.2024.06.05.13.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 13:18:58 -0700 (PDT)
Message-ID: <ff768984-4c5b-41eb-b302-ec11a49fb676@daynix.com>
Date: Thu, 6 Jun 2024 05:18:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] Net patches
To: Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
 <40b59ff0-e3ff-4631-aac2-83a3214d28b6@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <40b59ff0-e3ff-4631-aac2-83a3214d28b6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

On 2024/06/05 19:14, Michael Tokarev wrote:
> 04.06.2024 10:37, Jason Wang wrote:
>> Akihiko Odaki (18):
>>        tap: Remove tap_probe_vnet_hdr_len()
>>        tap: Remove qemu_using_vnet_hdr()
>>        net: Move virtio-net header length assertion
>>        net: Remove receive_raw()
>>        tap: Call tap_receive_iov() from tap_receive()
>>        tap: Shrink zeroed virtio-net header
>>        virtio-net: Do not propagate ebpf-rss-fds errors
>>        virtio-net: Add only one queue pair when realizing
>>        virtio-net: Copy header only when necessary
>>        virtio-net: Shrink header byte swapping buffer
>>        virtio-net: Disable RSS on reset
>>        virtio-net: Unify the logic to update NIC state for RSS
>>        virtio-net: Always set populate_hash
>>        virtio-net: Do not write hashes to peer buffer
>>        ebpf: Fix RSS error handling
>>        ebpf: Return 0 when configuration fails
>>        ebpf: Refactor tun_rss_steering_prog()
>>        ebpf: Add a separate target for skeleton
>>
>> Alexey Dobriyan (1):
>>        virtio-net: drop too short packets early
>>
>> Andrew Melnychenko (1):
>>        ebpf: Added traces back. Changed source set for eBPF to 'system'.
> 
> Is there anything in there for qemu-stable?
> (NOT picking up without explicit mention of stable)

No for my patches. Some fixes bugs but they are pretty minor and not 
problems in practice.

Regards,
Akihiko Odaki

