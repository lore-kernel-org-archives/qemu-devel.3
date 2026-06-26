Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD2CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd1aL-0000ty-12; Fri, 26 Jun 2026 04:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wd1aJ-0000to-H0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:06:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wd1aG-0002Iq-Hn
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:06:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65Q863Vh053338
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 26 Jun 2026 17:06:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=V5mmGWBs2fIECnZwwIjUHkQVgdTLKknGROkq4aM2NWU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782461164; v=1;
 b=VPTuYIf0RX+5v4ZC//CiFxXpTR/EeKcHmfEpohCvm+lq3cvUmEac6JriZCQXgyyQ
 ELe0ba58IN8G/lSEXNIdusxh9aGXYjGjf83VnXYfL6I7j1Sz1PR+DmKIs//znS4T
 3meV0xBDFwrMkAzqYGr9Uzl5aGmpu76woldhw2y44T4XIMKF6Z8CLzlpwtqx4A65
 cKfvggoIedDyLj/U4toek70ddLKhWVqxJz0D6E3A1JRKRfu6C0z8yUUu85HMn2Ye
 f0iY2n7DdYkapA8HImFVuQ8FX9ktb8dhxzyuXZymkBxN2buv9qvodBeAhXEbSZ3C
 ZW7Ny2exm5BrDjripTt0Aw==
Message-ID: <afe6f934-2df8-4119-8e8e-a042946ab3f5@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 26 Jun 2026 17:06:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
 <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
 <2660c118-474e-4160-9b26-25694d02d676@rsg.ci.i.u-tokyo.ac.jp>
 <8dc8db07-acfe-40f6-b0a5-38afd9c2bb0f@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8dc8db07-acfe-40f6-b0a5-38afd9c2bb0f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/06/26 5:34, Paolo Bonzini wrote:
> On 6/22/26 16:36, Akihiko Odaki wrote:
>> I think we can stack follow-up patches that reject accesses to 
>> MemoryRegions owned by unrealized devices. That would make this a more 
>> complete solution.
> 
> No, that would be *the only necessary part* of the solution.
> 
> Embedded objects are just fine.  I know that *right now* there are 
> issues, but they are with unplug and not with embedded objects; the same 
> issues would exist even with non-embedded objects.
> 
> I still do not understand what these patches can fix or simplify.

The problem with embedded objects is that object_ref() on an embedded
object does not keep the containing object alive. This is inherent in
QOM and is therefore independent of unplug, which is a qdev concept.

qdev has a separate quirk: a memory region may still be accessed after
its owner has been unrealized. That issue is orthogonal.

Regards,
Akihiko Odaki

> 
> Paolo
> 
>> Accessing an unrealized device is an unsafe corner case anyway, so it 
>> is better to close it explicitly.
> 


