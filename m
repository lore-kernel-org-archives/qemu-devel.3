Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA801C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 13:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shUCg-0003V4-28; Fri, 23 Aug 2024 09:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dvdugo333@gmail.com>)
 id 1shUCd-0003NW-Ow
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:19:43 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dvdugo333@gmail.com>)
 id 1shUCb-00017j-SV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:19:43 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-44ff398cefcso10017881cf.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724419180; x=1725023980; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGc0G3N40+BWZNFiNrREc2fJgIKErOaM7xJszOW7jOo=;
 b=gbMnTbkadpCzw2Y5XLEVQpzOvHuPcklY+JcDpapbGt/O+k78u6f/yJs/PDIF6iEXOL
 osvRjRDsQfD90FTyc6o4c7jfT0ApVqwUpgXapZQguE1bB5jeLb/oPXkz1r1pCH/wMY4C
 ihAatqy3IvPdTsH6hEBIvL4VpPXM5wPQo9tMyRvR03KI7zpgrLSV8e00q5G6lkD12F7V
 XyaysUYneqOPyWFG2cbbxoSBZD/ilIO1sgLJBbcolgwLR2Iggky2I/tuc8q27Wi+fZsA
 /XcRrRWDouJY+fsWBYCQ/WNnJ3EMMqPSx9zgOIvN4W4hr1ewKwNomJz3k1JeHu71xVHH
 4moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724419180; x=1725023980;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jGc0G3N40+BWZNFiNrREc2fJgIKErOaM7xJszOW7jOo=;
 b=je9gm1JB9b+8gqml8y/2XeobfZGhetW5J1h2U4GK3BmFGf1U9ckNed91ldBtU9eLEt
 IzBjRJqQ/EFNfI4PEU5354+n5lA4EMVzpYMt+BCxon/5TZxHXCBV7rQnTLIAjgAe2ByZ
 WQxATiJ6sOnqoBbQIFImAXxWMWBR9fC8JIUBE2q30WmsPs+vv6jZXlLYZtdyLqx0ZPz7
 apsTjbU8Z7vAeOKixXlwJBW6BCNUopwAPIAS5bV66MVYaXLENkt5o8weyZ2cz+0zbQXD
 52QIM0e2l2e9pfFSjFVV6cKXxVWfpzjZE0BEkKLpVBT7kUonfwhAGFuqW21g6UWBQo2j
 d0qA==
X-Gm-Message-State: AOJu0Yxe3uD5NERgn/OrbxEAglu3yTkn3X8GjE/qqomseJG8Jwj1Zxys
 JYNl0cy3shsYXWnxye9Y8TeJvts9StiOtHWuEvYHbhUbJBP0i84GTzsQbmlE
X-Google-Smtp-Source: AGHT+IHoDHFSFhghRojVxfKCFQPBcHXHctxuScSHLHeEtlNHSSvxwkzrBf8dVL4UD5aWB29XY10Ziw==
X-Received: by 2002:a05:622a:4c87:b0:44f:8870:185f with SMTP id
 d75a77b69052e-455097b8596mr31250421cf.61.1724419180458; 
 Fri, 23 Aug 2024 06:19:40 -0700 (PDT)
Received: from [192.168.64.4] (pool-100-37-231-152.nycmny.fios.verizon.net.
 [100.37.231.152]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe196a3fsm17176261cf.60.2024.08.23.06.19.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 06:19:40 -0700 (PDT)
Message-ID: <9981c499-13ee-4e68-b15b-b4fe184b0950@gmail.com>
Date: Fri, 23 Aug 2024 09:19:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: DUO Labs <dvdugo333@gmail.com>
Subject: Creating a vhost-user-vsock backend
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=dvdugo333@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I've been studying the example given in `contrib/vhost-user-blk`, and trying to match the code to what is in the standard (https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-3050002), so I can use the code to create my own vhost-user-vsock server.

I think I almost understand it, but I don't get exactly how do you correlate out_sg and in_sg to the header and ancillary data (for virtio-blk, it would either be the data to be written or a buffer to read data into, and vsock would be similar), respectively.

In virtio-blk, I see that there's an inhdr, and outhdr, but vsock doesn't have that, so I'm not sure how to map the same concept. Similarly, does `elem->out_sg[0]` always map to the header, and `elem->out_sg[1]` always map to the ancillary data? What about when you are reading into a buffer --- should it always be read into `elem->in_sg[0]`, or is that only for virtio-blk?

