Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BBF4613D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4hfO-0006Ii-81; Mon, 23 Mar 2026 11:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w4hfE-00064d-77; Mon, 23 Mar 2026 11:58:00 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w4hf6-0007z1-OA; Mon, 23 Mar 2026 11:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 To:From; bh=NBd5CC8iIWClqebrf+oO0dCEhOq9QvIxqIi2dsxBFIc=; b=fsIR
 rKRa3lylr+wi9ezZdwnMxx9bNi+4rIO1a+V5+voIVqODJpxx2IIhCHWnupFXknlR
 8zDGDHNp/7IeHamQnW3IWTyDyG8Nj8G5G+TzIc8hS8Z/xygZ3AEBRoRtcQXfAabv
 u3Ogze4Tm6VPNrs82n0UvZ7M+fa8NueHSZhdjOg=
Received: from [IPV6:2408:8266:ba01:2dde:d488:e165:11a4:9190] (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wBXvg7YYsFpiNTxAw--.1738S2; 
 Mon, 23 Mar 2026 23:57:12 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------Rk41Iv0XiaB600HD5c7aTA0S"
Message-ID: <6f0e0760-296c-4720-a542-03732e4735e9@163.com>
Date: Mon, 23 Mar 2026 23:57:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] PL080 add transfer memory and peripheral
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <cover.1774099044.git.dingtao0430@163.com>
 <6ade608e668d8fb9e720639333a48120bb814d41.1774099044.git.dingtao0430@163.com>
 <CAFEAcA97JFytdf1ZZfoMX-Rt92kfOgq304WahUWD2tQY6WsW+w@mail.gmail.com>
From: Tao Ding <dingtao0430@163.com>
In-Reply-To: <CAFEAcA97JFytdf1ZZfoMX-Rt92kfOgq304WahUWD2tQY6WsW+w@mail.gmail.com>
X-CM-TRANSID: _____wBXvg7YYsFpiNTxAw--.1738S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWDur17Wr47WF43CryDZFb_yoW8XryDpa
 yaka1vkw1kXa4Ivwn7Cw4xtFyrCw1fJrsIyrZ8tr4DAwn8JrWFyry7Kw1YvFWkCws3u3W7
 Cw4jva4UWa1qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9SdkUUUUU=
X-Originating-IP: [2408:8266:ba01:2dde:d488:e165:11a4:9190]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4RiZ12nBYtiriQAA3H
Received-SPF: pass client-ip=220.197.31.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------Rk41Iv0XiaB600HD5c7aTA0S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Thanks for the review and the historical context. I don't have a 
strong use case for peripheral DMA transfers at the moment, so I'll drop 
that part for now and focus on the bug fixes first. 1.handling the "last 
transfer is short" case 2.fixing the transfer size register decrement 
I'll send the updated patches shortly. Thanks, Tao

> On Sat, 21 Mar 2026 at 15:47, Tao Ding<dingtao0430@163.com> wrote:
>> On the interface, 0~15 represents single request, 16~31 represents burst request.
>> Access peripheral data based on the validity of the request. For the convenience,
>> we only respond to single requests. The number of data read from the source and written
>> to the destination is always equal, with a value of max(swidth, dwidth).
>>
>> Due to the lack of data preparation by the peripheral, it is necessary to cache data separately
>> for each channel until the peripheral is ready for processing.
>>
>> The width of peripherals perhaps not possible to process all data at once,
>> so continuous processing is required. Read from source is achieved through "continue",
>> while writing to destination is achieved through "goto".
> This has tangled up the original bugs we were trying to fix
> (that we weren't handling the "last transfer is short" case,
> and we weren't decrementing the transfer size register by the
> right amount) with the DMA transfer code.
>
> Can you start the patch series with the bug fixes, and then
> if you want the DMA transfer implementation do that second,
> please?
>
> thanks
> -- PMM
--------------Rk41Iv0XiaB600HD5c7aTA0S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <pre><span
data-slate-fragment=3D"JTVCJTdCJTIydHlwZSUyMiUzQSUyMnBhcmFncmFwaCUyMiUyQy=
UyMmNoaWxkcmVuJTIyJTNBJTVCJTdCJTIyaWQlMjIlM0ElMjJ2eHdXZzBvMHd6JTIyJTJDJTI=
ycGFyYUlkeCUyMiUzQTAlMkMlMjJzcmMlMjIlM0ElMjJJJTIwd2lsbCUyMHByaW9yaXRpemUl=
MjBmaXhpbmclMjBidWdzJTIwaW4lMjBwbDA4MCUyMGFuZCUyMHRlbXBvcmFyaWx5JTIwcHV0J=
TIwdGhlJTIwcGVyaXBoZXJhbCUyMHRyYW5zZmVyJTIwZnVuY3Rpb24lMjBvbiUyMGhvbGQlMj=
IlMkMlMjJkc3QlMjIlM0ElMjIlRTYlODglOTElRTUlQjAlODYlRTQlQkMlOTglRTUlODUlODg=
lRTQlQkYlQUUlRTUlQTQlOERwbDA4MCVFNCVCOCVBRCVFNyU5QSU4NCVFOSU5NCU5OSVFOCVB=
RiVBRiVFRiVCQyU4QyVFNSVCOSVCNiVFNiU5QSU4MiVFNiU5NyVCNiVFNiU5MCU4MSVFNyVCR=
CVBRSVFNSVBNCU5NiVFNSU5QiVCNCVFNCVCQyVBMCVFOCVCRSU5MyVFNSU4QSU5RiVFOCU4My=
VCRCUyMiUyQyUyMm1ldGFkYXRhJTIyJTNBJTIyJTIyJTJDJTIybWF0Y2hlcyUyMiUzQW51bGw=
lMkMlMjJ0cmFuc2xhdGVkQnklMjIlM0FudWxsJTJDJTIybWV0YURhdGElMjIlM0ElNUIlNUQl=
MkMlMjJ0ZXh0JTIyJTNBJTIySSUyMHdpbGwlMjBwcmlvcml0aXplJTIwZml4aW5nJTIwYnVnc=
yUyMGluJTIwcGwwODAlMjBhbmQlMjB0ZW1wb3JhcmlseSUyMHB1dCUyMHRoZSUyMHBlcmlwaG=
VyYWwlMjB0cmFuc2ZlciUyMGZ1bmN0aW9uJTIwb24lMjBob2xkJTIyJTdEJTVEJTdEJTVE"
    style=3D"white-space: pre;">Hi,

Thanks for the review and the historical context.
I don't have a strong use case for peripheral DMA transfers at the moment=
,=20
so I'll drop that part for now and focus on the bug fixes first.

  1.handling the "last transfer is short" case
  2.fixing the transfer size register decrement

I'll send the updated patches shortly.

Thanks,
Tao</span></pre>
    <blockquote type=3D"cite"
cite=3D"mid:CAFEAcA97JFytdf1ZZfoMX-Rt92kfOgq304WahUWD2tQY6WsW+w@mail.gmai=
l.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Sat, 21 Mar 2026 at 15:47=
, Tao Ding <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:dingtao0430@=
163.com">&lt;dingtao0430@163.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
On the interface, 0~15 represents single request, 16~31 represents burst =
request.
Access peripheral data based on the validity of the request. For the conv=
enience,
we only respond to single requests. The number of data read from the sour=
ce and written
to the destination is always equal, with a value of max(swidth, dwidth).

Due to the lack of data preparation by the peripheral, it is necessary to=
 cache data separately
for each channel until the peripheral is ready for processing.

The width of peripherals perhaps not possible to process all data at once=
,
so continuous processing is required. Read from source is achieved throug=
h "continue",
while writing to destination is achieved through "goto".
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
This has tangled up the original bugs we were trying to fix
(that we weren't handling the "last transfer is short" case,
and we weren't decrementing the transfer size register by the
right amount) with the DMA transfer code.

Can you start the patch series with the bug fixes, and then
if you want the DMA transfer implementation do that second,
please?

thanks
-- PMM
</pre>
    </blockquote>
  </body>
</html>

--------------Rk41Iv0XiaB600HD5c7aTA0S--


