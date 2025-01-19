Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9494C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJnE-0008M3-Lk; Sat, 18 Jan 2025 20:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tZJnD-0008La-BE; Sat, 18 Jan 2025 20:07:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tZJnB-0002bD-Gb; Sat, 18 Jan 2025 20:07:59 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B3894E6000;
 Sun, 19 Jan 2025 02:07:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id jGuCkFNVtorc; Sun, 19 Jan 2025 02:07:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5032C4E6005; Sun, 19 Jan 2025 02:07:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4DD8074577D;
 Sun, 19 Jan 2025 02:07:51 +0100 (CET)
Date: Sun, 19 Jan 2025 02:07:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] vvfat: refresh writing long filename
In-Reply-To: <7b87000c-bdb4-41c0-8fe0-9bb0c4e8cd85@tls.msk.ru>
Message-ID: <e77b7bcf-8629-3034-fd2b-9d9bd3744f07@eik.bme.hu>
References: <20250118182109.2695C19E94D@tsrv.corpit.ru>
 <df622cbd-32a1-29b3-5518-fa4d5e1d7c40@eik.bme.hu>
 <7b87000c-bdb4-41c0-8fe0-9bb0c4e8cd85@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1871395700-1737248871=:91016"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1871395700-1737248871=:91016
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 19 Jan 2025, Michael Tokarev wrote:
> 18.01.2025 23:54, BALATON Zoltan wrote:
>>> +typedef struct lfn_direntry_t {
>>> +    uint8_t sequence;
>>> +    uint8_t name01[10];
>>> +    uint8_t attributes;
>>> +    uint8_t direntry_type;
>>> +    uint8_t sfn_checksum;
>>> +    uint8_t name0e[12];
>>> +    uint16_t begin;
>>> +    uint8_t name1c[4];
>>> +} QEMU_PACKED lfn_direntry_t;
>
>>> +static unsigned write_lfn_part(uint8_t *dest, unsigned dsize,
>>> +                               const gunichar2 *lptr, const gunichar2 
>>> *lend)
>>> +{
>>> +    unsigned i;
>>> +    for(i = 0; i < dsize / 2 && lptr + i < lend; ++i) {
>>> +        dest[i / 2 + 0] = lptr[i] & 0xff;
>>> +        dest[i / 2 + 1] = lptr[i] >> 8;
>> 
>> Why not uint16_t and maybe cpu_to_le (or whatever that's called) if needed? 
>> May be simpler than handling it byte by byte.
>
> The dest array is unaligned - this is, eg, name01 in the above struct.
> Will it work to use entry->name01[i] = cpu_to_le16(lptr[i]) here,
> provided lfn_direntry_t=>name is declared as uint16_t name[5] ?

I think it should work, I don't see why it would not. The compiler should 
be able to figure out how to handle unaligned data where needed, you 
should not need to do that by hand. Or I think you'd get a warning if it 
would not work.

Regards,
BALATON Zoltan

> I haven't done programming for quite a while... ;)
>
> /mjt
>
>
--3866299591-1871395700-1737248871=:91016--

