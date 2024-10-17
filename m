Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A45D3C531
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 20:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1XKf-0003gY-UG; Thu, 17 Oct 2024 16:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>)
 id 1t1WPg-0002zw-1R; Thu, 17 Oct 2024 15:44:00 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>)
 id 1t1WPd-0001c9-Nm; Thu, 17 Oct 2024 15:43:59 -0400
Received: from [192.168.178.73] (p57b42979.dip0.t-ipconnect.de [87.180.41.121])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 84CB1DA0784;
 Thu, 17 Oct 2024 21:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1729194233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cQrZKfwUc3T34hED9aJBdMJ48jOFA8eL4E5HsSU/pCA=;
 b=CUBS1rd7ifJ6+4hrQFCYamAo2ZG3yvH5aV/t55RYtQ4FCGRwwTPK0dkwQzVHOuYG4vyJo7
 TpTGaGjeL7pFfuhNVqy9ViCNESE/edI6NmjGqNoXGwq8T1FEZtfzlOWOEXybPckiba3FsS
 UDgcJtInAfagZi9hAPsEOKeT9oL951M=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de smtp.mailfrom=sw@weilnetz.de
Content-Type: multipart/alternative;
 boundary="------------oWKNztQGK6Vkz8uY0KumXieR"
Message-ID: <bc8991ef-91af-419c-beda-f0ece8eda019@weilnetz.de>
Date: Thu, 17 Oct 2024 21:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix calculation of minimum in colo_compare_tcp
To: "Zhang, Chen" <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowang@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240909204254.1446800-1-sw@weilnetz.de>
 <CYYPR11MB8432028036D306D2FB6F4A359B9A2@CYYPR11MB8432.namprd11.prod.outlook.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <CYYPR11MB8432028036D306D2FB6F4A359B9A2@CYYPR11MB8432.namprd11.prod.outlook.com>
X-Rspamd-Queue-Id: 84CB1DA0784
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 14.00]; BAYES_HAM(-3.00)[99.99%];
 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:~];
 RCVD_COUNT_ZERO(0.00)[0]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action
X-Rspamd-Server: v2201612906741603
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Oct 2024 16:42:52 -0400
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------oWKNztQGK6Vkz8uY0KumXieR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It looks like nobody has sent a pull request for this fix up to now. Is 
it trivial enough for qemu-trivial? And maybe qemu-stable could also 
apply it to older versions.

Stefan W.

Am 10.09.24 um 04:38 schrieb Zhang, Chen:
>> -----Original Message-----
>> From: Stefan Weil<sw@weilnetz.de>
>> Sent: Tuesday, September 10, 2024 4:43 AM
>> To: Zhang, Chen<chen.zhang@intel.com>; Li Zhijian<lizhijian@fujitsu.com>;
>> Jason Wang<jasowang@redhat.com>
>> Cc:qemu-devel@nongnu.org; Stefan Weil<sw@weilnetz.de>
>> Subject: [PATCH] Fix calculation of minimum in colo_compare_tcp
>>
>> GitHub's CodeQL reports a critical error which is fixed by using the MIN
>> macro:
>>
>>      Unsigned difference expression compared to zero
>>
>> Signed-off-by: Stefan Weil<sw@weilnetz.de>
> Looks good to me.
> Reviewed-by: Zhang Chen<chen.zhang@intel.com>
>
> Thanks
> Chen
>
>> ---
>>   net/colo-compare.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c index
>> c4ad0ab71f..39f90c4065 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -412,8 +412,7 @@ static void colo_compare_tcp(CompareState *s,
>> Connection *conn)
>>        * can ensure that the packet's payload is acknowledged by
>>        * primary and secondary.
>>       */
>> -    uint32_t min_ack = conn->pack - conn->sack > 0 ?
>> -                       conn->sack : conn->pack;
>> +    uint32_t min_ack = MIN(conn->pack, conn->sack);
>>
>>   pri:
>>       if (g_queue_is_empty(&conn->primary_list)) {
>> --
>> 2.39.3 (Apple Git-146)
--------------oWKNztQGK6Vkz8uY0KumXieR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>It looks like nobody has sent a pull request for this fix up to
      now. Is it trivial enough for qemu-trivial? And maybe qemu-stable
      could also apply it to older versions.</p>
    <p>Stefan W.<br>
    </p>
    <div class="moz-cite-prefix">Am 10.09.24 um 04:38 schrieb Zhang,
      Chen:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
cite="mid:CYYPR11MB8432028036D306D2FB6F4A359B9A2@CYYPR11MB8432.namprd11.prod.outlook.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Stefan Weil <a class="moz-txt-link-rfc2396E" href="mailto:sw@weilnetz.de">&lt;sw@weilnetz.de&gt;</a>
Sent: Tuesday, September 10, 2024 4:43 AM
To: Zhang, Chen <a class="moz-txt-link-rfc2396E" href="mailto:chen.zhang@intel.com">&lt;chen.zhang@intel.com&gt;</a>; Li Zhijian <a class="moz-txt-link-rfc2396E" href="mailto:lizhijian@fujitsu.com">&lt;lizhijian@fujitsu.com&gt;</a>;
Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>; Stefan Weil <a class="moz-txt-link-rfc2396E" href="mailto:sw@weilnetz.de">&lt;sw@weilnetz.de&gt;</a>
Subject: [PATCH] Fix calculation of minimum in colo_compare_tcp

GitHub's CodeQL reports a critical error which is fixed by using the MIN
macro:

    Unsigned difference expression compared to zero

Signed-off-by: Stefan Weil <a class="moz-txt-link-rfc2396E" href="mailto:sw@weilnetz.de">&lt;sw@weilnetz.de&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Looks good to me.
Reviewed-by: Zhang Chen <a class="moz-txt-link-rfc2396E" href="mailto:chen.zhang@intel.com">&lt;chen.zhang@intel.com&gt;</a>

Thanks
Chen

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">---
 net/colo-compare.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c index
c4ad0ab71f..39f90c4065 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -412,8 +412,7 @@ static void colo_compare_tcp(CompareState *s,
Connection *conn)
      * can ensure that the packet's payload is acknowledged by
      * primary and secondary.
     */
-    uint32_t min_ack = conn-&gt;pack - conn-&gt;sack &gt; 0 ?
-                       conn-&gt;sack : conn-&gt;pack;
+    uint32_t min_ack = MIN(conn-&gt;pack, conn-&gt;sack);

 pri:
     if (g_queue_is_empty(&amp;conn-&gt;primary_list)) {
--
2.39.3 (Apple Git-146)
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------oWKNztQGK6Vkz8uY0KumXieR--

