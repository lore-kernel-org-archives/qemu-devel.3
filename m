Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786B0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQ05-0000Cw-3J; Thu, 01 Aug 2024 03:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZQ02-0000CH-CO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:13:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZQ00-0004WF-DE
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:13:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fee6435a34so45714825ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722496398; x=1723101198;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tVgr57FTV1SVKVqqB753hPBrihKhaQwzPVGFDZ9u7L4=;
 b=wekM2IWkFcTA5aqubPE3fK/b7gB4fj/WJ0F6U+Iau7HTSDloND9jRvSYbzH8iz06f+
 OgsOBXoqqbKmMMc94Yj2tZCYFObw7/uiP7GuhZsp9byK2PfMGJ0zgYJGHlilRxlN7g3J
 LhOiZXBNRuPWYFG03J0G9gzl4WnNGdHltFrFPsPaeMIWh38Qq8+pZg+V7N9NY/eYBhGk
 BV2HZH2dfAWTmq25APGNO0A0g6vPkpFm7zRiGnYkVSopEhfeAqbwZ8CWi8o4U5lKbBwL
 fcqC8XVnXWwNw0ZLMMs6Or0jt+LofAZTs5c1s22dC/VtnNx0C8cHi9u11FYEmYvrt2DL
 c5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722496398; x=1723101198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tVgr57FTV1SVKVqqB753hPBrihKhaQwzPVGFDZ9u7L4=;
 b=XEdOWTCwWItlL2Bd6tTv11SUgCts08UzkMzcZTnL9XfVN39U8kN17e8YS2ZAUDyAdt
 DcQv8d1zz5FndtR/XT8iAAizDm1pLfZOr7uIj1TT+BLJqBgNx5mQh5R9eA7f568SZrUL
 MAryp9O6j84Li5ETCmaja39z/bUDpH6bqxkkJoituDCjSTcuWY96TZCfG1GJzUTyBXeg
 5FSucDsQM8eEgCLJ1YBb88AUqzYMpxT+HTVR0HJhuVlgaJx3mfwFHLjiHKd112VomiFN
 Fd4g8Zx8Czj1WZUtyxBH6W21Nhf95KL0vXxon4h4//c5sXdmQx2aDWw/4XoTwid5lkYD
 qFzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJK9fOouKfaSHXd4qmegpbaeyIB2TY6oQqO7IMIkUydOFPVgj3J0j7lZ1T1s+scLmfj6Q+e5tEOW2wRQXaZIzqiZ5DpG8=
X-Gm-Message-State: AOJu0YxARsWxzxyuL8M1bCAwird/424uPgHIG2El6oqNqzZl4lGQ/hZl
 q4igetcYGt6jNN76aNUtI5kNi1M4gSE5uur+oOPQ9RcGXR1vV3nZ9vTfMfRkLmk=
X-Google-Smtp-Source: AGHT+IFYs3Lhu/H0LOn5nqz7jk8CbVFxnlgJ9iUxVUpluAnFUS+kKJTux1udzZKlL+I5IyhnpzUaqQ==
X-Received: by 2002:a17:902:ecc7:b0:1fd:7293:3d70 with SMTP id
 d9443c01a7336-1ff4ce56c89mr18392805ad.8.1722496398517; 
 Thu, 01 Aug 2024 00:13:18 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f1cdcasm131380405ad.198.2024.08.01.00.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 00:13:18 -0700 (PDT)
Message-ID: <4c37d308-a666-4c43-91d3-99368e643c1c@daynix.com>
Date: Thu, 1 Aug 2024 16:13:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
 <20240730073712-mutt-send-email-mst@kernel.org>
 <125b333d-36a3-49d2-84e5-76a5f9d23a48@daynix.com>
 <20240730135602-mutt-send-email-mst@kernel.org>
 <1dd86a97-f81b-41aa-b7f7-8a31fe7849b5@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1dd86a97-f81b-41aa-b7f7-8a31fe7849b5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2024/07/31 17:58, Cédric Le Goater wrote:
> On 7/30/24 19:56, Michael S. Tsirkin wrote:
>> On Tue, Jul 30, 2024 at 09:26:20PM +0900, Akihiko Odaki wrote:
>>> On 2024/07/30 20:37, Michael S. Tsirkin wrote:
>>>> On Mon, Jul 15, 2024 at 02:19:06PM +0900, Akihiko Odaki wrote:
>>>>> Based-on: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>>>>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>>>
>>>> OK I will revert this for now. We'll try again after the release,
>>>> there will be time to address s390.
>>>>
>>>
>>> I'd like to know if anybody wants to use igb on a s390x machine 
>>> configured
>>> with libvirt. Such a configuration is already kind of broken, and it is
>>> likely to require significant effort on both side of libvirt and QEMU 
>>> to fix
>>> it.
>>
>>
>> I assume Cédric wouldn't report it if was unused.
>>
>>
>>> As an alternative, I'm also introducing SR-IOV support to 
>>> virtio-net-pci. It
>>> does not suffer the same problem with igb thanks to its flexible
>>> configuration mechanism.
>>>
>>> Regards,
>>> Akihiko Odaki
>>
>> Sounds like this needs more review time, anyway.
>>
>>
> 
> Using an emulated IGB device in a s390x VM is not a common scenario.
> The IGB device is not supported downstream (RHEL on Z). However, the
> change broke the s390x machines I use for upstream QEMU development,
> I removed the IGB device as a fix for now.
> 
> The Z PCI device model has 'uid' and 'fid' properties which are set
> by the VMM, and in this case, they are auto-generated, hence the
> conflicting ids with libvirt. This is Z specific but, possibly there
> are subtle use cases on other platforms which could have similar
> consequences. Something to be aware of.
> 
> 
> Also, and this is why I thought it was important to report. Creating
> PCI devices at machine init time (with -nodefaults) in the back of the
> management layer is a no-no. libvirt requests to have full control
> on the machine topology and this change seems like a violation of
> this rule, even if VFs are kind of special.
> 
> Daniel, did I understand correctly the above constraint on the machine
> definition ?

It is problematic even if it is not init time. QEMU shouldn't implicitly 
add a PCI device without letting the management layer know.

For the virtio-net SR-IOV support which I have been preparing, I'm 
avoiding automatically adding PCI devices but instead letting the user 
create VFs. However, fixing existing SR-IOV devices (igb and nvme) will 
require more efforts and possible breaking changes of the command line.

> 
> 
> I can't say if we should revert for 9.1. Again, this Z is specific.
> The changes were introduced to catch errors early when the PF device
> is realized. There is no doubt they are useful. Some rework is needed
> to avoid the conflicting id issue though.

I think it is a good idea to revert these patches for now, and add them 
back along with the virtio-net-pci SR-IOV support when the next merge 
window starts though I don't require to do so. If someone experiences 
this problem in the next merge window, we can advise to use 
virtio-net-pci, or to specify qemu:commandline to workaround it. We can 
start thinking of making a breaking change if neither of them satisfies 
the requirement.

Regards,
Akihiko Odaki

