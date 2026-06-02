Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702A4CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUPDc-0005uh-SM; Tue, 02 Jun 2026 09:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wUPDa-0005t3-DH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:31:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wUPDV-000560-MF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:31:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3FBD08076F;
 Tue, 02 Jun 2026 16:31:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:9a19:8d4f:85d6:2048] (unknown
 [2a02:6bf:8011:f00:9a19:8d4f:85d6:2048])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id VVfqWO2aN0U0-c2uLxeaO; Tue, 02 Jun 2026 16:31:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1780407091;
 bh=CU6eErxBzN586XjLlGgT2bayAwQ+P0kzhbuSmQ2Jfv0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OJv06T0DFokWv9sM7fDmuZ5EGCVbUWOMLWL/X3TnbJa+wd3BqSLepe7I4ZPPNZGwz
 hmkMH3N4ox2rY9jKpufXASeXuX60Xv935w6+ijp9mH14lykmg7OBIqpN/SB8LZDNXw
 QHuzEqsnEMp06PqUhnNq0946ZwC900KPsGTHXZE0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <db095591-539f-4c56-899d-d1047272f030@yandex-team.ru>
Date: Tue, 2 Jun 2026 16:31:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: calculate UTF-8 characters correctly
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260601171008.159147-1-vsementsov@yandex-team.ru>
 <ah7TydWv9e9hRNFO@ChaodeMacBook-Pro.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ah7TydWv9e9hRNFO@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02.06.26 16:16, Chao Liu wrote:
> On Mon, Jun 01, 2026 at 08:10:08PM +0800, Vladimir Sementsov-Ogievskiy wrote:
>> We do check UTF-8 correctness in checkpatch.pl (search for "patch and
>> commit message should be encoded in UTF-8"), but we count bytes, not
>> symbols when limiting line-length. Let's be consistent.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   scripts/checkpatch.pl | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 2189db19f54..711539bdd7c 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -7,6 +7,7 @@
>>   
>>   use strict;
>>   use warnings;
>> +use Encode qw(decode);
>>   use Term::ANSIColor qw(:constants);
>>   
>>   my $P = $0;
>> @@ -596,7 +597,11 @@ sub line_stats {
>>   	# Pick the indent from the front of the line.
>>   	my ($white) = ($line =~ /^(\s*)/);
> line_stats() still expands tabs before decoding UTF-8, so tab stops are
> computed from UTF-8 bytes rather than decoded characters.
> 
> For example, `é<TAB>X` is counted as length 8 with the current order, but
> length 9 if decoded before tab expansion. This is mostly hidden for C
> files because tabs are rejected, but `.s`/`.S` files may contain tabs.
> 
> Since this patch aims to make `line_stats()` use character semantics, it
> should decode before expanding tabs, or make `expand_tabs()` operate on a
> decoded string.
> 
> You could implement it like this:
> 
> ```
>     @@ -588,8 +589,9 @@ sub line_stats {
>      sub line_stats {
>         my ($line) = @_;
> 
>     -   # Drop the diff line leader and expand tabs
>     +   # Drop the diff line leader, decode UTF-8, and expand tabs.
>         $line =~ s/^.//;
>     +   $line = decode('UTF-8', $line, Encode::FB_DEFAULT);
>         $line = expand_tabs($line);
> 
>         # Pick the indent from the front of the line.
> ```
>>   
>> -	return (length($line), length($white));
> With that change, the original `return (length($line), length($white));`
> can be kept; the extra `decode()` calls and new return below are not needed.
> 

Thanks a lot, I'll resend.


-- 
Best regards,
Vladimir

