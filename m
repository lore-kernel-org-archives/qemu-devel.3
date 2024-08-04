Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E054C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 06:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saV96-0001wN-Eb; Sun, 04 Aug 2024 02:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saV94-0001un-WE
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 02:55:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saV93-0005u4-GL
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 02:55:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso8204200b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2024 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722754508; x=1723359308;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OX8Rk+Lq414FfaG7lJeo6Qrsfti5OnBokurUA3C7dRU=;
 b=gt7UjfM9575I1dpzsu9BikzwVanOdPiDSy1Z4U4JXjQ/z22WG7fHC1tNpxc4faROHh
 uqBKHbAQ2iKHJjF0TCJ7d/La/Vc9ROP4DDLmCMJbmE47QdnI2DPwmKfn7fmGmQhcLsNC
 RI6tfJq+TSEc9ujT6FbgFnjxT7X65rY3aFhvuZ6gZ8jm44WyWjbBDG58oTBaiHqPPAPe
 VlpRIgsl+xpsFTajMFbBZ2aLP+rDC+j8YkzUWO6E/mZpSJxdyTMj44j63A3OdGv4/2GY
 hDpsRYsaTeBGR4TOMMirkdGoFRKooGnTdi1Puktf0nkJJHFfNwNyd1xIjgobenbV18KA
 R1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722754508; x=1723359308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OX8Rk+Lq414FfaG7lJeo6Qrsfti5OnBokurUA3C7dRU=;
 b=t8dIvB6WX/w60IGC33Qc0V2Y+fD/hjDbRf+2yub/6vlRwZNQXOKHUrehYrFPHiLzv1
 ODaF+CRW7OGQtUxBqlBCnqMXcCLQqB8EerPXehDSY3hekl3m4C1UUYwweaghGKK8R58T
 QegLH0ulXySAibOPfTv+4o+z87jgKvIWsH9W62DbVR/4f7cOcSG1kEr1H7zjDiUo9rWr
 GkUmKXNoK+E2CbUET/D5QAZ624ilVS77dcs4x++eakBzqPPVXytN7gdc6y/6LM3so5hp
 VOk03JPdfP+bOWxFaEQH9rvuXan+4vt5ILUg+4yMHwsNVv7sm9fH+F8yPiKEKxBXwu1r
 ZQQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpZFo/U1rS2ctOzlmUNdNF91KqaI0pRfO4VVpQIIM0G+rBuQ4o4KE5ZuG1exCKiAZxw5H8e9C+89sCRShAwjaU+eipr8g=
X-Gm-Message-State: AOJu0YxF0pGUyAbKGU/wYtyB71jYEj/BOIhaa7AE5iqczjhK98PMJs9p
 2vhuYZIyiyH+pbIYj6U1mMuWV7GBKjq9L+MIOqsRhCjFMqxA2RDuzCs63tfhcEw=
X-Google-Smtp-Source: AGHT+IEy8R8tLURiR6e0zSK1dwb7SgI8sdOz/svrkczAxWoz6PRGXeVYQt33R5bmLBZ0mdKIRYDyKg==
X-Received: by 2002:a05:6a20:4328:b0:1c3:18f9:16d8 with SMTP id
 adf61e73a8af0-1c69969d09dmr13850741637.52.1722754507939; 
 Sat, 03 Aug 2024 23:55:07 -0700 (PDT)
Received: from [133.11.54.73] (shio03.csg.ci.i.u-tokyo.ac.jp. [133.11.54.73])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b763945cf0sm3659664a12.48.2024.08.03.23.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Aug 2024 23:55:07 -0700 (PDT)
Message-ID: <32107cc5-293c-44a8-bf1e-c86f2ec6b0d7@daynix.com>
Date: Sun, 4 Aug 2024 15:55:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v11 06/11] pcie_sriov: Reuse SR-IOV VF device
 instances
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-6-fb83bb8c19fb@daynix.com>
 <20240802125342-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240802125342-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/03 1:54, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2024 at 02:17:56PM +0900, Akihiko Odaki wrote:
>> Disable SR-IOV VF devices by reusing code to power down PCI devices
>> instead of removing them when the guest requests to disable VFs. This
>> allows to realize devices and report VF realization errors at PF
>> realization time.
> 
> What kind of errors do you have in mind?

The type of errors common for any SR-IOV device would be the conflict of 
PCI function numbers; all function numbers that will be used by VFs 
should be reserved when realizing the PF. With the SR-IOV support of 
virtio-net-pci I'm adding, a user may specify invalid netdev for VFs.

Regards,
Akihiko Odaki

