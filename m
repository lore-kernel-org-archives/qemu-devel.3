Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044B8C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raAAG-0003TM-RH; Wed, 14 Feb 2024 02:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raAAF-0003Sl-3z
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:58:43 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raAAD-0002Xl-Kn
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:58:42 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5dc816e4affso1412792a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707897520; x=1708502320;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GIiWJdfrTHXeIl0JfICVDhn+u7AXFAh1ZuXAl+jsxHs=;
 b=GAckDXtgZOp83TFukdU1zwgIGGj1uC5LqO9/woD/OdXoy1SX+Mrqg01FzoZJljHtrl
 IpbL9yt0PEEEHKiHQVV5U+t5J9u6s2hUruBTpElPWqEQUpRkj3wKOYZqemWVHA/lmD2o
 py7g/aTVvDSOFFKHthw/I/O5CH0GZ32KsTgaAnsDKrMw4027b6s8Iln3Rr0v12dYJCua
 5HsFXD8XbMN7IJ8je5cbm0H14qdetD8IxR98BtNR5VWlKJpKqM0x08GXrTk3sqW2cd/m
 ImT0x46AmhizHqeLiPyKhTaMA402TCgU9RtSAUuP6x+H7AJm6iqmDXd8wHuT1gzpuUxu
 dLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707897520; x=1708502320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GIiWJdfrTHXeIl0JfICVDhn+u7AXFAh1ZuXAl+jsxHs=;
 b=I90grkeGoMCPzt9yUPPHOBhW29TV/lmZA1IjgDacE3jkmmq33al8BxgUpvdAqGM6nN
 CtDuUVjEb8eyFyEMEZa8i1MaMKwhPVtbqw5iTP3EWwPdRRo6HB7MMgLCalmoKW+NJ7nK
 eN+Ibl4V+BLLcyByktsyBKA7S3MJdF8ZtFdUdmKg9B2I62H5GepFy/wx8NcrtZpYqB/P
 CttoXc+y8Xid42ZUXM+A0Q+7L8nP8f7QOHlKOP73eI1lFP/nWnLvZ97Dm06VIp5swvGZ
 cLw8aW22wspIzRXzpKi2XqVqSOXAOb8Wn/T24xjXj1n+31ovKtcWH0+qzQmIcNQ6sGZe
 9r6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmbDKF68wFJ6n7CHHULx8O9LkNZwlmLxH0H8EL/1pfhUQjO3erKs0Je2XOd23lf6RmLK8QJtkBlgDrST58rk2biTEM3NQ=
X-Gm-Message-State: AOJu0YwUyMHUNTp5BJaJFWUm/LrXAGvycaUgYPQZi7DI1PzPzCZU4WQY
 UzqOnFe8qbA5KZIK2rg01XVF2/olAfNka4VIp0yTv4jit+vUwxV9BmYYv5YcbfgHVtLNODMIb8M
 g
X-Google-Smtp-Source: AGHT+IGZWZWAQL3CcTwSRsLL+WwUjoTa8K7hFHeZcIwwPR0WknsqCTcJ/KLlIIdwFvzcriSl0aVFEg==
X-Received: by 2002:a05:6a21:918a:b0:19e:ce54:4731 with SMTP id
 tp10-20020a056a21918a00b0019ece544731mr2369440pzb.50.1707897520387; 
 Tue, 13 Feb 2024 23:58:40 -0800 (PST)
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 sl13-20020a17090b2e0d00b00296f4fc7e60sm762944pjb.12.2024.02.13.23.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 23:58:40 -0800 (PST)
Message-ID: <05044456-50f5-4d18-8de6-42215145cb55@daynix.com>
Date: Wed, 14 Feb 2024 16:58:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] pcie_sriov: Release VFs failed to realize
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
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-7-89ad093a07f4@daynix.com>
 <20240214025430-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214025430-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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

On 2024/02/14 16:54, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 02:13:45PM +0900, Akihiko Odaki wrote:
>> Release VFs failed to realize just as we do in unregister_vfs().
>>
>> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Is this fixing an old bug or a bug introduced by a previous patch?

Old bug, present since: commit 7c0fa8dff811 ("pcie: Add support for 
Single Root I/O Virtualization (SR/IOV)")

