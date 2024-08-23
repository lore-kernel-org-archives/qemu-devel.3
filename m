Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E35C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMVP-0006tN-K5; Fri, 23 Aug 2024 01:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMVO-0006no-3w
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:06:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMVJ-0001Hx-8A
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:06:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2021c08b95cso20914525ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389587; x=1724994387;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VThzSqqIv+UYAPrC0iVqgz4TD+xoL07JOSBvw6JdfEo=;
 b=pFDUX8TW7jfhcYd4/SfQ0mlyRAQa8NedKstDabVoZI3mAJL81ijbHFBRsfVLfgXDu/
 ngw6gs294g+0DimuXZLQltPyyMibEcAaQyEK8Gd5gNgJxp3eRlCW4JTOJXNw9GMHCtmN
 rpl4kQ0QMHOGx859z0FJpCCr/f5RaFMlHgd0jodJuqi5IAl1m+HpGtcMSComQjwXSuX3
 +7TVQ4cYbnaIhbjvI+8F46SoekuS94M3wcQq8Qn2NnaYimICf9tGzh0XxXMuO5hqH7BI
 klOq5o1c2IKUgWk2dg+6w4sBhpqmNssAgU5lKMT7iyQ7V7n55S+y2EiJWxYH3ZPmhi6o
 67eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389587; x=1724994387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VThzSqqIv+UYAPrC0iVqgz4TD+xoL07JOSBvw6JdfEo=;
 b=vNqVRm7Ly9JJd5Vu500HVrqP9MwMw5PF3QfUot3QBrXbZrHP7dZlknD7Bn08pHSRR1
 fOzP1J/nekGQI/0ZtBpk/H3J1wLB2xd+L0nI8JxIwHCZ9nmlvEdpxX3U9PNhXpy5LJOf
 0YG4daj492QakPLlX94oOd3TIsIGHGVV3z6q/5WVjST9/FOUmZJ0BLb6lIo4Y4qgFVTI
 QAsntnIBvB4RCH56mW+j1/Fb+0fScjL8Gux5HnbtrFSBwnrIqE3kug37HWbA3ADzwM5+
 hNE523Yt5dqFoPwcGet+nmhxIyfW25ZhabUKvsGgCHiSyInpwIAL5u+uDV2yJjeJdKwv
 IU6Q==
X-Gm-Message-State: AOJu0YwwgPvEG2egIkONnkNEBt+tNkHfGazWfR+SvrAobdvvMp/7bfqI
 A84M5OgQhyz0M7QlbPq22iENdVINEdjRURunQaxyAEDydFW6Kyih8qT0C/Ass0A=
X-Google-Smtp-Source: AGHT+IG1oe8qfxTFcwaSu/+d4KpN3PancmxX5AU5U2RG00/m7tL/7vvXhvyMe1AE7Y/uzgd63EViDA==
X-Received: by 2002:a17:903:22c4:b0:1fc:253b:5951 with SMTP id
 d9443c01a7336-2037ee06450mr88344145ad.4.1724389587244; 
 Thu, 22 Aug 2024 22:06:27 -0700 (PDT)
Received: from [157.82.207.23] ([157.82.207.23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038560f569sm20578595ad.220.2024.08.22.22.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:06:26 -0700 (PDT)
Message-ID: <b3dea897-bf18-4bd3-8666-7a2906f409d3@daynix.com>
Date: Fri, 23 Aug 2024 14:06:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v7 0/9] virtio-net: add support for SR-IOV
 emulation
To: Yui Washizu <yui.washidu@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
 <fb23e042-4daf-478f-afae-501b7b2aa3b6@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <fb23e042-4daf-478f-afae-501b7b2aa3b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2024/08/21 19:18, Yui Washizu wrote:
> 
> On 2024/08/13 15:36, Akihiko Odaki wrote:
>> Based-on: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
>> ("[PATCH for-9.2 v11 00/11] hw/pci: SR-IOV related fixes and 
>> improvements")
> 
> I couldn't apply this patch series
> after applying "[PATCH for-9.2 v11 00/11] hw/pci: SR-IOV related fixes 
> and improvements".

It was a mistake and intended to apply on: "[PATCH for-9.2 v14 00/11] 
hw/pci: SR-IOV related fixes and improvements"
https://patchew.org/QEMU/20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com/

It can be also cleanly applied on the new version I have just sent: 
"[PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and improvements"
https://patchew.org/QEMU/20240823-reuse-v15-0-eddcb960e289@daynix.com/

Regards,
Akihiko Odaki

