Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD1EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 13:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYm5S-0003zv-SL; Tue, 30 Jul 2024 08:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYm5L-0003wo-6I
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:36:11 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYm4Y-0006HJ-7e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:36:05 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-44fed0301b1so26161271cf.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722342844; x=1722947644;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdUh6HcQ4adt/jIrPH/oP+y+xFt8uHU7twjVYClZzvA=;
 b=rqKBmechFk47J51Pa0GLtdZFzUQ7DYoPjthEVu2kNhAZ+W861HHIbTyCvfangUnPTq
 9W423HvQWCflYRA8jSju8oBzZadcAhr9CO3TB1n0ZgzgAwL/pYvms++Wr9pYxfuBmS2p
 MwQVWKTz/Qac4n1NGOCXdBQmvBkAtXDOyt/e1dd90Ohzmbtqg+nei5yYLCS6G1LtKet1
 W+0JBwDb61Ip+hu6IxcX9JwW+eCkMHV6DNQdMDjn/7bjrR5OLvlaFgMHWEImB2hpR7b7
 k7TrPzLvZ9lxUOhvT5KyZngX8blMZQc9DQpjJrPaMHRRN2Zqmjp/xYxLBKWns9s/vnHW
 mrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722342844; x=1722947644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdUh6HcQ4adt/jIrPH/oP+y+xFt8uHU7twjVYClZzvA=;
 b=w1a4oy8cIxtI0Tsvzf2m6upNdVvrX9OGtKsz/euhi8RcTBFs6X8Uogp77fouztJXas
 LibvZTvsPkAU9P4YgOzlC5hlILqMY7CJn+tPoPpFSsz6LhvFxSW3DAunwWTDqqmdd+To
 uNXPsf5GHe1wnTxHSdJOfmGjMPsUfR//jFkSmKgCMCFU0Hnr6S1dYRskm88OAhLD9X06
 nuVaaaueaj4vU6DsJZxOiiPQOIf266JTIFmuar8AMlCWyXkNKoqYDuY1K9aSVo30bpC9
 TOivmiNpFl8Upg/ufXF9s33fur/Myj9VJkqwPNnWkRy09hE3LnSeF1ZoCMLNJwl1OtQa
 9P3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgCD/k2GPYRKuxZbT7Hmt+TYahVJ0tbSeHIl+tdlKSFQj/GOkLeSTCR6dmSwAK6/Xtrjy3vNnCtkITEm2JDqWZykNHX5w=
X-Gm-Message-State: AOJu0YypCj5bp/zUSkiY0723WxVolCRavAhX2QxHL6GE/izC6AeGPab+
 +kh8JLzl2VCCfXacwL88MziXnL0GXJ8gMep9p5vMCUl2JDObmvR7ucyEtoCt6BGhhBFZ9O8owgw
 LNfU=
X-Google-Smtp-Source: AGHT+IHX8IkzkPLGLWjRdKmld2onQXR7oasW4hP1RqCvudyZIpeTWCTTbPigVfEnzusr6nsODJnCXQ==
X-Received: by 2002:a17:903:1110:b0:1fd:8904:ecf6 with SMTP id
 d9443c01a7336-1ff048111b4mr92409535ad.21.1722342385384; 
 Tue, 30 Jul 2024 05:26:25 -0700 (PDT)
Received: from [157.82.204.132] ([157.82.204.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f2b80bsm100189425ad.205.2024.07.30.05.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 05:26:24 -0700 (PDT)
Message-ID: <125b333d-36a3-49d2-84e5-76a5f9d23a48@daynix.com>
Date: Tue, 30 Jul 2024 21:26:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
 <20240730073712-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240730073712-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::82b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2024/07/30 20:37, Michael S. Tsirkin wrote:
> On Mon, Jul 15, 2024 at 02:19:06PM +0900, Akihiko Odaki wrote:
>> Based-on: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> 
> OK I will revert this for now. We'll try again after the release,
> there will be time to address s390.
> 

I'd like to know if anybody wants to use igb on a s390x machine 
configured with libvirt. Such a configuration is already kind of broken, 
and it is likely to require significant effort on both side of libvirt 
and QEMU to fix it.

As an alternative, I'm also introducing SR-IOV support to 
virtio-net-pci. It does not suffer the same problem with igb thanks to 
its flexible configuration mechanism.

Regards,
Akihiko Odaki

