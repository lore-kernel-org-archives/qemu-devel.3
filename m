Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 07:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarrL-0003Ui-FK; Mon, 05 Aug 2024 03:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sarrE-0003Sa-Nj
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:10:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sarrB-0007Cy-G9
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:10:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70eb0ae23e4so7236145b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722841806; x=1723446606;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fokt5wozGra5SCB9gEb2R68L3YNDR6Y6CY6GKhUpbxA=;
 b=Qo63Z3R7YEo9DAXZWb/6pTu1pRn3C6K59Wq/YUTgaNaZbe5HO5SgYIg6Oae0wAzqqi
 kfTyphMGISPbg1RdOqVnT3AhoOT9GbsQpWPCfOiIJ6lBWDiHMgVkbklteoFqLrZzZUEg
 lpdV/PxC19qXxSdKa+ZFI24FLuSW8JLxS8YSKHkefuMKty4Vupy6ILF9X87E2FVPELBe
 amM+zCp+h1W5P1Ubqckw3x6SocTynwW3TQTb3OkP63zyG23jjdg6WCIbtZsVM1+5x8Zn
 lSaFe7tNpM8Kr3mDKCPLJ4Xv+yRxcd7eFh3RVYYCK14l3EhA6AhHp/eBEoUgN4BGW3u9
 z2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841806; x=1723446606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fokt5wozGra5SCB9gEb2R68L3YNDR6Y6CY6GKhUpbxA=;
 b=nvOPP2KrmTDGacwMV8cb2UQkEnr5mftxs6lLP+B+W6XbIKQx+o7hXcSH3lsGSDYWRw
 RgP7yJtI/udwtusp1M0XqWv982XP+AZPYZsZ1MQ2M2c3mI43KFJo5cpFva3C5Qnz2lW3
 fHyoZo92vp23CUP5cOxD5miM/wrb2NrPpbg9syJMbNW+RLgwd77Sphzz6xKkz1WGg/mZ
 utgmzTPLAXsruf/1URaaxnRplqqymtHHDPUxen5q6dcBb1J49BjYyVD217smahGLGymR
 xlnKhQxnGdruFKG9s6B702psAqGw6GXv5cKXO58hfCuACEfxKrJXaMyq+5plR1YqRPpd
 7tWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7t/GwmeAyE6IMBCfAeDh6mtqwnQNe9oJkC0wi+T1tdMYIhU9IK/xc/KH/Pti4sTn0LQvr7jHSBLoIt8jxmxHys8AEjw=
X-Gm-Message-State: AOJu0YwFB6LihA4eg8A9GJqj6deDCv48S+BQB/RJzB5UV137ReuiDJYj
 WkUtE1/p2im1hzm228Cb5016yfnLP5GwVJd3CmAkfDtIw8wEpUafo2vFic7HcPQ=
X-Google-Smtp-Source: AGHT+IHhiQMhe+6oBFoQEISANdQgdkcYQ/IXf69DtNfva1zz4t7+mu5qHGyAeQOkil22TPPu64Fasw==
X-Received: by 2002:a05:6a21:32a6:b0:1c2:8fd1:a47d with SMTP id
 adf61e73a8af0-1c6995284d2mr11694577637.6.1722841806480; 
 Mon, 05 Aug 2024 00:10:06 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed14f38sm4795666b3a.184.2024.08.05.00.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 00:10:06 -0700 (PDT)
Message-ID: <42a4ef02-a14a-41a2-b1a9-357511afa163@daynix.com>
Date: Mon, 5 Aug 2024 16:10:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v12 00/11] hw/pci: SR-IOV related fixes and
 improvements
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
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
 <20240805023719-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240805023719-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

On 2024/08/05 15:39, Michael S. Tsirkin wrote:
> On Sun, Aug 04, 2024 at 06:01:36PM +0900, Akihiko Odaki wrote:
>> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>
>> I submitted a RFC series[1] to add support for SR-IOV emulation to
>> virtio-net-pci. During the development of the series, I fixed some
>> trivial bugs and made improvements that I think are independently
>> useful. This series extracts those fixes and improvements from the RFC
>> series.
>>
>> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> Changes in v12:
>> - Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
>>    PCI_SRIOV_CTRL_VFE.
>> - Updated the message for patch "hw/pci: Use -1 as the default value for
>>    rombar". (Markus Armbruster)
>> - Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com
> 
> The igb issue is still with us, is it not?

Yes, if you are talking about the problem with s390x/libvirt. That is 
why it has for-9.2 tag.

It is actually not specific to igb but also affects nvme. The upcoming 
virtio-net-pci's SR-IOV will not be affected, but it is not present yet.

