Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B9FC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoSR-0007j6-4r; Tue, 13 May 2025 08:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEoSL-0007h5-3F
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:09:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEoSF-0004Xz-5B
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:09:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9203B55CA60;
 Tue, 13 May 2025 14:09:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id P3g0WZ4F20RT; Tue, 13 May 2025 14:09:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8C43655C592; Tue, 13 May 2025 14:09:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A799745683;
 Tue, 13 May 2025 14:09:46 +0200 (CEST)
Date: Tue, 13 May 2025 14:09:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/3] ui/vnc.c: replace big endian flag with byte order
 value
In-Reply-To: <caf9f1e2-fe92-48bb-92d9-17e5a5f61476@linaro.org>
Message-ID: <05d3c581-19b3-bbeb-3607-2009a08c2267@eik.bme.hu>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-2-berrange@redhat.com>
 <6c9f7141-8b2e-4b58-9ade-134a7289cff6@linaro.org>
 <caf9f1e2-fe92-48bb-92d9-17e5a5f61476@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-314734786-1747138186=:93514"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-314734786-1747138186=:93514
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 May 2025, Philippe Mathieu-Daudé wrote:
> On 13/5/25 13:08, Philippe Mathieu-Daudé wrote:
>> On 13/5/25 12:08, Daniel P. Berrangé wrote:
>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>> 
>>> It will make it easier to do certain comparisons in future if we
>>> store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
>>> flag.
>>> 
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>   ui/vnc-enc-tight.c | 2 +-
>>>   ui/vnc-enc-zrle.c  | 2 +-
>>>   ui/vnc-jobs.c      | 2 +-
>>>   ui/vnc.c           | 6 +++---
>>>   ui/vnc.h           | 2 +-
>>>   5 files changed, 7 insertions(+), 7 deletions(-)
>> 
>> 
>>> diff --git a/ui/vnc.h b/ui/vnc.h
>>> index acc53a2cc1..f2a627dcdf 100644
>>> --- a/ui/vnc.h
>>> +++ b/ui/vnc.h
>>> @@ -323,7 +323,7 @@ struct VncState
>>>       VncWritePixels *write_pixels;
>>>       PixelFormat client_pf;
>>>       pixman_format_code_t client_format;
>>> -    bool client_be;
>>> +    int client_bo; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
>
> 'bo' = 'big order'?
>
> Maybe 'client_endian' or even 'client_endianness'?

I also thought bo makes no sense. What's the problem with be which was 
more obvious as it is? If you need to change it client_endian would still 
be more descriptive, I can't guess what client_bo stands for without the 
comment and even with that it's not obvious.

Regards,
BALATON Zoltan
--3866299591-314734786-1747138186=:93514--

