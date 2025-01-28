Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5693EC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqmB-0006qe-FJ; Tue, 28 Jan 2025 13:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcqlw-0006oF-M0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcqlt-0000js-Vz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738090631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P3SqFG8TvR2Yj5t5UzS6QD3ai+nRrbkULdEhDWx1WEg=;
 b=XOuzIfTt5hlBNWZb6XfMeuetnCmVpnbdfWcKC2kQizW0yg1+UwIXjT7n6+du1IuKNi/THD
 eHDR6aSS4KftzqHc120cyAVrpS6hMGPo+h/Q91mKje0bokQPEmZaujyErq+3qGwFwdPi+m
 AdQSxh2TrSxwCmX5AbDpdy5zAiSyRBo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-xOM0U8GmMHaoqGbOs5YI8A-1; Tue, 28 Jan 2025 13:57:10 -0500
X-MC-Unique: xOM0U8GmMHaoqGbOs5YI8A-1
X-Mimecast-MFC-AGG-ID: xOM0U8GmMHaoqGbOs5YI8A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so32608685e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738090629; x=1738695429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3SqFG8TvR2Yj5t5UzS6QD3ai+nRrbkULdEhDWx1WEg=;
 b=wUQkMFL4a7ZI/hOtNKK5qQa2aF1+APQGBJLkI1fFqK4m4OxvM5oJahXeZqwR3KlyIX
 D6DZeCTdlu+pzoV+e9QkMfWJz9eM0VpaYrvqnFqmt2hFkqETiYsn/cIph4bfTy5KOTmH
 lMKmGimQ5pdVv/zvx48lncH7cHiHo86UEV4zGBh9tXRSEqj2CCKAT+OFY1uByohex5vk
 wwm2e6iay4s9MJbLHXYg4PxVmMC47B2vuEiNR6snNGXefSG9HwIDW7x8tHgxreEWSUCe
 JSCKjeDTogmHfJk7PHTH8sG+tffypUQoFDEQvii2gpoEkJAq3LfJfbYKyiP0OtHUONQw
 K9VA==
X-Gm-Message-State: AOJu0YwDGTSKpt6IicemaRordsawzQmsj0/NwjWosi8J1PoS0X7szMxW
 jjGWTAV4f1WeJs1QVOhIja7T0yN4lzRBLEJX4SBzceKtyyGCPM1E4K9hwRHdI6eTpiLx6+SvNEA
 uRTYcvy5g3qborzCuY4CN1jHn7xJMoMxY4miBHWRofWWB6sks190FOH1V14IAbgFIlrGSU7foJo
 fzuXngAgv2oBJZGhK5b5NKPCWjOWUe+88H+CM=
X-Gm-Gg: ASbGncshQL6U21fA3nhk3q/TphfjOzSsBnsz8IV2nYiEg8k5NKqV8oG9SG/c3GsacSL
 DVNVBKuj761AZcbyaGlAQYV24Sh5iGitYgbklEpxw1a87qDLrwhXxIU3OLcBpAqFTMTj/taeeBs
 tlbwVaZOVzcxy4fAfSHHMmiB8y0NNZQQleAG1Ec2NpIHyyhdI9rE83uu//XshOXJLIsdOgIAzQ2
 nIj9Q65NFncPRtPEQ9fNj12JwlD5fERJpL6SmZyaVMaCjnUNXp4W5GmwOiHwKt83pWorwm0UtwL
 cBspYOoyKrPUoPPA4An/lTMpYHt2Av/WXGweMTSbqbSGJSlGMEXuvf6wR2G3ToTgXg==
X-Received: by 2002:a05:600c:4586:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-438dc3ae051mr684905e9.10.1738090629101; 
 Tue, 28 Jan 2025 10:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlQaJxV2l1/zIax3pHHv+yhbY42NLNMRaMfHuLiBd90sbAS+/mT/t+UbjLfZNA4tl93Xcr+g==
X-Received: by 2002:a05:600c:4586:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-438dc3ae051mr684585e9.10.1738090628592; 
 Tue, 28 Jan 2025 10:57:08 -0800 (PST)
Received: from localhost
 (p200300cbc73fce001be76d7f3cc3563d.dip0.t-ipconnect.de.
 [2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-438bd4c6fadsm176564905e9.32.2025.01.28.10.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:57:08 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 0/2] s390x: support virtio-mem-pci
Date: Tue, 28 Jan 2025 19:57:03 +0100
Message-ID: <20250128185705.1609038-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is based-on [1], which adds MSI-X support to virtio-balloon-pci,
but can be applied independently.

Turns out it is fairly easy to get virtio-mem-pci running on s390x. We
only have to add MSI-X support to virtio-mem-pci, and wire-up the
(un)plugging in the machine.

Tried some simple stuff (hotplug/hotunplug/resize/reboot), and all seems
to be working as expected.

The kernel in the VM needs both, CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_MEM
for it to work.

[1] https://lkml.kernel.org/r/20250115161425.246348-1-arbab@linux.ibm.com

v1 -> v2:
* There are no transitional/non_transitional devices for virtio-mem
* Spell out removal of "return;" in second patch

Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Boris Fiuczynski <fiuczy@linux.ibm.com>
Cc: Michal Privoznik <mprivozn@redhat.com>
Cc: Mario Casquero <mcasquer@redhat.com>

David Hildenbrand (2):
  virtio-mem-pci: Allow setting nvectors, so we can use MSI-X
  s390x/s390-virtio-ccw: Support plugging PCI-based virtio memory
    devices

 hw/core/machine.c          |  1 +
 hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
 hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.48.1


