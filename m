Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC0EC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 10:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbe8u-00022p-Su; Sun, 18 Feb 2024 05:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rbe8s-00022a-4E
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:11:26 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rbe8q-0006td-8n
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:11:25 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 05B504E6012;
 Sun, 18 Feb 2024 11:11:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id CkRlypygTJKD; Sun, 18 Feb 2024 11:11:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B99FB4E6005; Sun, 18 Feb 2024 11:11:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC71B7456FE;
 Sun, 18 Feb 2024 11:11:15 +0100 (CET)
Date: Sun, 18 Feb 2024 11:11:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3] vl: Print display options for -display help
In-Reply-To: <4e007fd4-294e-4969-80a3-2508a518cea8@daynix.com>
Message-ID: <8d9692b5-b0b3-c98e-0681-9043ad7d533e@eik.bme.hu>
References: <20231216-help-v3-1-d51db92740d0@daynix.com>
 <4e007fd4-294e-4969-80a3-2508a518cea8@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-904143461-1708250796=:48230"
Content-ID: <92686dfc-6e27-1a21-14de-52b8023d2ced@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-904143461-1708250796=:48230
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <0f91b51f-16c2-ab48-1c44-ad2b07bc209a@eik.bme.hu>

On Sun, 18 Feb 2024, Akihiko Odaki wrote:
> Hi Marc-André, Paolo,
>
> This patch has Reviewed-by: and Tested-by: but not pulled yet. Can either of 
> you pull this?

I think we dropped this because it's not consistent with the other help 
options such as -cpu help -device help that print the available options. 
What we need instead is e.g. -display cocoa,help to print help about the 
specific ui backend which isn't what this patch does so it's not the right 
way. To do that however we probably need an expert on options and QOM 
because it does not seem easy to add such option. Therefore I don't ask 
you to do that instead but this patch is also not what I wanted.

Regards.
BALATON Zoltan

> Regards,
> Akihiko Odaki
>
> On 2023/12/16 17:03, Akihiko Odaki wrote:
>> -display lists display backends, but does not tell their options.
>> Use the help messages from qemu-options.def, which include the list of
>> options.
>> 
>> Note that this change also has an unfortunate side effect that it will
>> no longer tell what UI modules are actually available.
>> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Changes in v3:
>> - Dropped qapi/qapi-commands-ui.h inclusion. (Philippe Mathieu-Daudé)
>> - Link to v2: 
>> https://lore.kernel.org/r/20231215-help-v2-1-3d39b58af520@daynix.com
>> 
>> Changes in v2:
>> - Noted that it no longer tells the availability of UI modules.
>>    (Marc-André Lureau)
>> - Link to v1: 
>> https://lore.kernel.org/r/20231214-help-v1-1-23823ac5a023@daynix.com
>> ---
>>   include/ui/console.h |  1 -
>>   system/vl.c          | 11 ++++++-----
>>   ui/console.c         | 21 ---------------------
>>   3 files changed, 6 insertions(+), 27 deletions(-)
--3866299591-904143461-1708250796=:48230--

