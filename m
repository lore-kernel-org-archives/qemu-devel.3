Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73225CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 13:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzEVP-0002aD-5j; Thu, 18 Sep 2025 09:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@freebsd.org>)
 id 1uzA79-0005WL-4U; Thu, 18 Sep 2025 04:35:39 -0400
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@freebsd.org>)
 id 1uzA71-00028m-40; Thu, 18 Sep 2025 04:35:38 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R13" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4cS88l5kKkz4l1N;
 Thu, 18 Sep 2025 08:35:19 +0000 (UTC)
 (envelope-from aokblast@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R13" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4cS88l4kcGz3gJ1;
 Thu, 18 Sep 2025 08:35:19 +0000 (UTC)
 (envelope-from aokblast@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1758184519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGWsEyyTNCRjdeZClrgROu0NaO+T1l2OSaIp/9dq2wA=;
 b=MllAaW6SfFEedhjWeNDHNaNXRX78JbuQyFXrqoxfBecna+WkM95qiZ3wt66dUj6aQ3l2YR
 kWtXFJDraYj6ian00UgCE6XTyMK30hB3WXtyz8lJqlpuGouhC9xmWvgjVRQvOOzV0DPCBK
 mfnx2HpSUimLtqZ1FFugL6Kvx/j3WvSCmoO9FCNKSQFWQIPBsDb9PrvGhQ74N8WDCOZtFN
 4CD3MWes1S1PAHnSYKhoZCtVI+2uq0gHbbltcPUVioTmMAiJjMKmTy/roE6x1zYWXEwAEr
 YhMsEnt5MqIJnTagSwjBLmzuT28JE53/bP3aEApfwgtloi3g+zk6Mf7hdWn0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1758184519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGWsEyyTNCRjdeZClrgROu0NaO+T1l2OSaIp/9dq2wA=;
 b=tUJdS7yMlOxlKO7jzSyfeVc0VGLnSL+3FJLX7UGOIiTCKMtkmr8C3RcB0nN7lGkseq/zVs
 IkzYvsXL8D8wIMhnMZElztye+Oo351h4mjeuzedcvmp6Fh15yH2K225jPwiM5AqokLnrYO
 2jUYaOz46XEwymDMhUdbBWalfH3lxIo39hb46GVc3RzpVE7LHz8FhJcEv/ZqIZUYV2M499
 Yrwla+8k8C9jpLbHb11qqsr2+G8cSxVerUWT1M1tkHd/4I1FqW5uXTee3Z2mpCIq2Hw6St
 ateD+5yWX178ChW3fVUIFQRmdflzJWo5Nry/6xHgDRXe3ax/0vspkF5+WdNNKg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1758184519; a=rsa-sha256; cv=none;
 b=JXSsrKpgvpvrk/+UNwP1TnRHwsh2jsHoII6OYTnKJsU/Oar5ELU3Kv2e3vXmoWR8Qet9y/
 kQ9APFtg7y99iKJuZMJotz/bBtaEsOPPuRjkLos4cgGqZ73HQIUm7WW7BG2ezZPbcf+P6q
 +8x2zVPE0mceqOfjwVdMyumk+Klo7RGCIePk0LAtcKDTobwMNYUWXAXDRL7jhmGeJNim+I
 /7MiT+74zqIej0XWrPVa+Tf9ClbiScwJwR0R7S/B4aytfH+5uVoJkMNlLxk2TdYIf9pLHZ
 g2wB3dG3qPat682uGQVJEFCE0LbE7EmbmdvWLwuK+sB0VA6XLjSD1UdmSdbkLQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from aokblastdeMacBook-Pro.local
 (2001-b400-e271-1dd2-850d-8faf-2637-ff5e.emome-ip6.hinet.net
 [IPv6:2001:b400:e271:1dd2:850d:8faf:2637:ff5e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (Client did not present a certificate)
 (Authenticated sender: aokblast)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4cS88j4vdyzLgB;
 Thu, 18 Sep 2025 08:35:17 +0000 (UTC)
 (envelope-from aokblast@freebsd.org)
From: ShengYi Hung <aokblast@FreeBSD.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org,  QEMU Development <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hid: fix incorrect return value for hid.
In-Reply-To: <89ef2af7-d79d-4460-9c01-9127f906ee51@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 18 Sep 2025 09:14:47 +0300")
References: <20250915175730.27825-1-aokblast@FreeBSD.org>
 <89ef2af7-d79d-4460-9c01-9127f906ee51@tls.msk.ru>
User-Agent: mu4e 1.12.13; emacs 30.1
Date: Thu, 18 Sep 2025 16:35:07 +0800
Message-ID: <m2ldmc40qs.fsf@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2610:1c1:1:606c::19:2;
 envelope-from=aokblast@freebsd.org; helo=mx2.freebsd.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Sep 2025 09:16:57 -0400
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


Hello Michael:

Thanks for your review and reply, I sent the mail to qemud-devel about a
month ago but didn't receive any reply. Therefore, I send the mail to
qemu-trivial again and forget CC to qemu-devel. I will be careful next
time.

The consequence is that if the guest operating system want to check the
actual transfer length of a transfer, it may be regarded as a failed
transfer since the actual transfer length is zero originally.

Here is an example from FreeBSD:
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=288968.
I have workarounded this issue by ignore any error from hid_write.

Interestingly, Parallel seems to share the same issue and can be
addressed with the same fix.

Michael Tokarev <mjt@tls.msk.ru> writes:

> Please always send all patches to qemu-devel@ (cc'd)
> (in this case, in addition to qemu-trivial@).
>
> On 15.09.2025 20:57, ShengYi Hung wrote:
>> The return value of hid_keyboard_write is used to set the packet's actual_length
>> and pass to xhci directly to allow guest know how many byte actually processed.
>> Therefore, return 1 to indicate a successful transfer or it will be
>> considered as a wrong xfer.
>> Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
>> ---
>>   hw/input/hid.c | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/hw/input/hid.c b/hw/input/hid.c
>> index 76bedc1844..de24cd0ef0 100644
>> --- a/hw/input/hid.c
>> +++ b/hw/input/hid.c
>> @@ -478,6 +478,7 @@ int hid_keyboard_write(HIDState *hs, uint8_t *buf, int len)
>>               ledstate |= QEMU_CAPS_LOCK_LED;
>>           }
>>           kbd_put_ledstate(ledstate);
>> +        return 1;
>>       }
>>       return 0;
>>   }
>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>
> and queued up to the trivial-patches tree.
>
> It's an interesting one, I wonder what the consequences are -
> for having this at 0 all the time, and for actually making it 1.
> Did we miss a byte somewhere with current code?
>
> Thanks,
>
> /mjt

-- 
Best Regards.
ShengYi Hung.

