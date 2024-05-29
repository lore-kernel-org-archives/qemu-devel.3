Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA2C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDu9-00052a-Mj; Wed, 29 May 2024 03:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sCDu6-00052E-Kk
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:39:22 -0400
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sCDu4-0007uE-Qb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:39:22 -0400
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
 by mailout02.t-online.de (Postfix) with SMTP id 36F3B24627;
 Wed, 29 May 2024 09:39:15 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.149.164]) by fwd88.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1sCDtx-3ivmVd0; Wed, 29 May 2024 09:39:13 +0200
Message-ID: <0ebe1b01-b1da-4d91-ad06-81a84330166f@t-online.de>
Date: Wed, 29 May 2024 09:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] MAINTAINERS: drop audio maintainership
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240528083858.836262-1-kraxel@redhat.com>
 <20240528083858.836262-2-kraxel@redhat.com>
 <CAAjaMXaucLgfWVuf96ZbjDyXxw3yZ-yzuJeZGK66ib0oCq6r6Q@mail.gmail.com>
 <bixbyxczbjxaxvnlt5zj42g474qi2kbus5fzr7ojzuomrm2372@gjrpjzvbdx6q>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <bixbyxczbjxaxvnlt5zj42g474qi2kbus5fzr7ojzuomrm2372@gjrpjzvbdx6q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1716968353-E7C423AB-EDFA5262/0/0 CLEAN NORMAL
X-TOI-MSGID: c636948a-2d19-487b-9892-683bfcb885ac
Received-SPF: pass client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 28.05.24 um 12:02 schrieb Gerd Hoffmann:
>   Hi,
>
>>>  virtio-snd
>>> -M: Gerd Hoffmann <kraxel@redhat.com>
>>> -R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> +R: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>>>  S: Supported
>>>  F: hw/audio/virtio-snd.c
>>>  F: hw/audio/virtio-snd-pci.c
>> While extra reviewers are always helpful, someone like Volker would
>> make sense, not someone without any contributions:
> Matias volunteered to help (via reply to v1 of the series), and for
> 'reviewer' role I don't see a reason to be strict.  'Maintainer' would
> be a different story of course.
>
> If Volker wants step up (I see you cc'ed him already) I happily add
> him too.

Hi,

I'm sorry, but at the moment I can't step up as reviewer. As you
probably know, I'm doing this in my free time and the time I can
dedicate to QEMU is quite limited at the moment. I don't think the QEMU
developers need an unresponsive reviewer.

However, I continue to read the qemu-devel mailing list and will speak
up if I think something is wrong.

With best regards,
Volker


