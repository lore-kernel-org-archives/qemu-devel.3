Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D58CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 19:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wREfC-0005ML-F6; Sun, 24 May 2026 15:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wREf6-0005Lr-2c; Sun, 24 May 2026 15:39:00 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wREey-0001P3-4Y; Sun, 24 May 2026 15:38:59 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 30EBEEC0176;
 Sun, 24 May 2026 15:38:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 24 May 2026 15:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779651529; x=1779737929; bh=ahyVNhz3wEh/hFvLmefH4QWi4K8gLWpD
 IyLo7HPKIGk=; b=RFiS6tNE8ETPRLA6+9pCfJ79E3/HKbxw1EiGwdbz2cGCttVU
 ui7H+HLkITJGljpERsYSk7udmlpK6+VEpl+CKQ+UEBSslFCVIq4O8Tn5//qZUz99
 W7Fii/3Cc9QXe4zeCQOfGwxkE/GMRm7/F/s+G74p1GA3BVtwng6pYUZtMf7lsGMS
 wCJS2XDElLDkvt0ItUzH9mPPOL+TFUuYlNiK74jSw9At0+luwORxYOZ/d3t44TXb
 61mAjgFkhqUvgR428ISFgwlgbznPXVJI5+oNT9n324pfLjZJFmZlys7Gl6ZtyWsI
 0XcX1kHEKMrFlsB/ReGRvRNmD+eF3Z/sSdl2Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779651529; x=
 1779737929; bh=ahyVNhz3wEh/hFvLmefH4QWi4K8gLWpDIyLo7HPKIGk=; b=g
 r2bqqwS/QtkEuxEoh426tZeElnWBS83KTJpS0B6zPjSoyHef6smMp+5dhRr2nSbr
 LrYku/rD7LklZlTm/tt6el5K9Pw2um018NmaUxlhxx5QeuxdNW3IScWCrGk2KD/t
 oUa9jNwI39LAnTXUkVclns6lq76EXKfxCkEMQWnTNRbBnnqm9T66WJLRkUeOu5XR
 TqyjcJp+NSoZPbwNLlntWuLgr3pbNdIeJSDFU6LeEuZUnvQJJ+XdNlUZWScS465i
 fbTDMnFSiJrgofNiNjpyVcpvZqwqYUr+QOTR+sXZKtkrI0Om+HJL9t7PKhsv4J4z
 i76FwJbSvDJtrQH6Bdblw==
X-ME-Sender: <xms:yFMTalwsX_ZD3qWU4NCDSaWxG6WDN7fh9M9rs9jrAVcAk-Jx9taAGA>
 <xme:yFMTasRLX3ilSrHxcd57iFb-twlhb-rphoQqm0UKG7AFIHg1BU6KvugIyuxUR266X
 tk4cz5-Iou-kqtHWy9DienNB_wJ98KLKhL8u_qE3y4-ZBNEjx6cdlk>
X-ME-Received: <xmr:yFMTakVoPx0hBTvFYnDQY5Jrq7-xpTtyqV_FEa-WYBwDRtNVXXJF4EZulw6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheeijeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpegtfffkvefuhffvggfgofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeetleeiiefgffejudelhedthffh
 udehieetkeeufeekvedvieettdekteeludfhgfenucffohhmrghinheptghouggvsggvrh
 hgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeegpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlqdgsohhunhgtvghsodgthhgrug
 epjhgrsghlohhnshhkihdrgiihiiesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggr
 lhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonh
 hskhhirdighiii
X-ME-Proxy: <xmx:yFMTamZxaTqeypWQ3SNk-R5rUuHkRjS6oYyFNWFWlYphb6IZxCojTQ>
 <xmx:yFMTai0iEEbxcONuVtPTJLWTvu_F_w9b08Jyb42tcUBNvKucCoRxhw>
 <xmx:yFMTaghJpSn-s1BXmw3HZjNgC2KNFzItDO7hhszafhg28pDb2-3w7Q>
 <xmx:yFMTauZbSAaQqV9XBWHAT7j-mF0PMonC6jT8dQDJY1zLk59sGcayuQ>
 <xmx:yVMTap4K2F2SeAl_rEk4yFsqI9fV48gOUY5vFj5RdHWAf4iFRYJo0H_t>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 15:38:47 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 71daebc7;
 Sun, 24 May 2026 19:38:47 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 May 2026 15:38:47 -0400
Message-Id: <DIR5TCZMOLFO.UIX5XEIKFHCW@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v2 1/7] ati-vga: Extract ati_reg_write() from
 ati_mm_write()
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-2-chad@jablonski.xyz>
 <da45694f-3c2f-ff3f-1364-1cccf1c46c05@eik.bme.hu>
In-Reply-To: <da45694f-3c2f-ff3f-1364-1cccf1c46c05@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Thanks for taking a look at this months back, Zoltan. It's been a bit but
I'm picking this back up.

>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index e9c3ad2cd1..33f8e211dc 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -530,14 +530,9 @@ static inline void ati_reg_write_offs(uint32_t *reg=
, int offs,
>>     }
>> }
>>
>> -static void ati_mm_write(void *opaque, hwaddr addr,
>> -                           uint64_t data, unsigned int size)
>> +void ati_reg_write(ATIVGAState *s, hwaddr addr,
>> +                   uint64_t data, unsigned int size)
>> {
>> -    ATIVGAState *s =3D opaque;
>> -
>> -    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
>> -        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data=
);
>> -    }
>>     switch (addr) {
>>     case MM_INDEX:
>>         s->regs.mm_index =3D data & ~3;
>> @@ -550,10 +545,10 @@ static void ati_mm_write(void *opaque, hwaddr addr=
,
>>                 stn_le_p(s->vga.vram_ptr + idx, size, data);
>>             }
>>         } else if (s->regs.mm_index > MM_DATA + 3) {
>> -            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, si=
ze);
>> +            ati_reg_write(s, s->regs.mm_index + addr - MM_DATA, data, s=
ize);
>>         } else {
>>             qemu_log_mask(LOG_GUEST_ERROR,
>> -                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_in=
dex);
>> +                "ati_reg_write: mm_index too small: %u\n", s->regs.mm_i=
ndex);
>>         }
>>         break;
>
> Is it possible to access MM_INDEX and MM_DATA through CCE? If not maybe i=
t=20
> needs to be cut here instead?
>

Good call. I've confirmed that CCE is not able to write to MM_INDEX and
MM_DATA. Type-0 packets seem to be ignored when targeting them. Tests
here: https://codeberg.org/cjab/ati-tests/src/commit/55ddfe401f1fe5702a5f33=
3b72b22e70a815fa02/tests/common/cce.c#L101-L134

This will be moved in v3.

