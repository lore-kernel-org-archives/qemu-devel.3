Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5C9C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WF3-0005vz-Ez; Tue, 15 Sep 2026 12:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>)
 id 1x6WF0-0005vN-W0; Tue, 15 Sep 2026 12:42:43 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>)
 id 1x6WEt-0006Dv-41; Tue, 15 Sep 2026 12:42:42 -0400
Content-Type: multipart/alternative;
 boundary="------------oWxnpPQ96j5IWZAjhUGlEAYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789490552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9PATGAQQGH7eJbKfpErqBb/PP37lvz+lx4bWi5cR5E=;
 b=l8ZTZ56fXbmCwV8L6P/4QZ4zbsfHsTXOGMwcHfzUx+Blj/qm/PpoaHFNA/L05lH6R7sieH
 oymZTqsohsVKFZZINbcct3E5BiWTQMnyO2AVH61smijftkw5opy0LMPw6Qagk61wG3H+z9
 lekMyR74EpZeX2JDGW56SgPDo7t12aY=
Message-ID: <1749cad8-1651-4543-8a2b-aad3c1168328@swemel.ru>
Date: Tue, 15 Sep 2026 19:42:31 +0300
MIME-Version: 1.0
Subject: Re: PATCH] hw/s390x/s390-hypercall: fix potential NULL dereference in
 handle_virtio_ccw_notify
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
References: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
 <597e1a7a-8720-4356-91ed-a7c9fa416312@redhat.com>
Content-Language: en-US, ru-RU
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
In-Reply-To: <597e1a7a-8720-4356-91ed-a7c9fa416312@redhat.com>
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
--------------oWxnpPQ96j5IWZAjhUGlEAYT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This is the reaction of the (dynamic) static analyzer. We conducted 
research (at the request of the quality department) and found out that 
it could work. So we created a patch.If you're sure it will never 
happen, then, of course, skip it (and I'll have to work hard, because 
the quality department is digging into everything).

15.09.2026 19:32, Thomas Huth пишет:
> On 15/09/2026 18.17, Николай Зорин wrote:
>> SWSA#4992cdf0-415c-45c1-be1a-71213467347d
>>
>> The `virtio_ccw_get_vdev()` function can return a `NULL` pointer if the
>> corresponding subchannel driver data (`sch->driver_data`) is not 
>> initialized
>> or has been cleared.
>>
>> If `vdev` is `NULL`, passing it directly into 
>> `virtio_queue_get_num(vdev, vq_idx)`
>> results in a `NULL` pointer dereference, which can lead to a hypervisor
>> crash or unexpected termination of the QEMU process.
>>
>> Fix this by adding an explicit check for `!vdev` before verifying the
>> queue index and its capacity, returning `-EINVAL` early if the device
>> is missing or not bound to the subchannel.
>>
>> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
>> ---
>>   hw/s390x/s390-hypercall.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
>> index ac1b08b2..fd2972c0 100644
>> --- a/hw/s390x/s390-hypercall.c
>> +++ b/hw/s390x/s390-hypercall.c
>> @@ -44,7 +44,7 @@ static int handle_virtio_ccw_notify(uint64_t 
>> subch_id, uint64_t data)
>>       }
>>
>>       vdev = virtio_ccw_get_vdev(sch);
>> -    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, 
>> vq_idx)) {
>> +    if (!vdev || vq_idx >= VIRTIO_QUEUE_MAX || 
>> !virtio_queue_get_num(vdev, vq_idx)) {
>>           return -EINVAL;
>>       }
>
>  Hi!
>
> How did you trigger this problem? It should not exist anymore since:
>
> https://gitlab.com/qemu-project/qemu/-/commit/e5cb62e7b6f9
>
> which has been included since QEMU v10.2.
>
> So please provide some description how to reproduce it if it still 
> happens with the latest version of QEMU.
>
>  Thanks,
>   Thomas
>
> PS: The list of maintainers for the s390x part of QEMU also has 
> recently been changed. Please use the MAINTAINERS file and 
> scripts/get_maintainer.pl from the latest version to check before 
> sending patches. Thanks!
>

--------------oWxnpPQ96j5IWZAjhUGlEAYT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span
          class="ryNqvb">This is the reaction of the (dynamic) static
          analyzer.</span></span> <span class="jCAhz ChMk0b"><span
          class="ryNqvb">We conducted research (at the request of the
          quality department) and found out that it could work.</span></span>
      <span class="jCAhz"><span class="ryNqvb">So we created a patch.</span></span><span
        class="jCAhz ChMk0b"><span class="ryNqvb">
          If you're sure it will never happen, then, of course, skip it
          (and I'll have to work hard, because the quality department is
          digging into everything).</span></span></span><br>
    <br>
    <div class="moz-cite-prefix">15.09.2026 19:32, Thomas Huth пишет:<br>
    </div>
    <blockquote type="cite"
      cite="mid:597e1a7a-8720-4356-91ed-a7c9fa416312@redhat.com">On
      15/09/2026 18.17, Николай Зорин wrote:
      <br>
      <blockquote type="cite">SWSA#4992cdf0-415c-45c1-be1a-71213467347d
        <br>
        <br>
        The `virtio_ccw_get_vdev()` function can return a `NULL` pointer
        if the
        <br>
        corresponding subchannel driver data (`sch-&gt;driver_data`) is
        not initialized
        <br>
        or has been cleared.
        <br>
        <br>
        If `vdev` is `NULL`, passing it directly into
        `virtio_queue_get_num(vdev, vq_idx)`
        <br>
        results in a `NULL` pointer dereference, which can lead to a
        hypervisor
        <br>
        crash or unexpected termination of the QEMU process.
        <br>
        <br>
        Fix this by adding an explicit check for `!vdev` before
        verifying the
        <br>
        queue index and its capacity, returning `-EINVAL` early if the
        device
        <br>
        is missing or not bound to the subchannel.
        <br>
        <br>
        Signed-off-by: Nikolay N Zorin <a class="moz-txt-link-rfc2396E" href="mailto:zorin@swemel.ru">&lt;zorin@swemel.ru&gt;</a>
        <br>
        ---
        <br>
          hw/s390x/s390-hypercall.c | 2 +-
        <br>
          1 file changed, 1 insertion(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/hw/s390x/s390-hypercall.c
        b/hw/s390x/s390-hypercall.c
        <br>
        index ac1b08b2..fd2972c0 100644
        <br>
        --- a/hw/s390x/s390-hypercall.c
        <br>
        +++ b/hw/s390x/s390-hypercall.c
        <br>
        @@ -44,7 +44,7 @@ static int handle_virtio_ccw_notify(uint64_t
        subch_id, uint64_t data)
        <br>
              }
        <br>
        <br>
              vdev = virtio_ccw_get_vdev(sch);
        <br>
        -    if (vq_idx &gt;= VIRTIO_QUEUE_MAX ||
        !virtio_queue_get_num(vdev, vq_idx)) {
        <br>
        +    if (!vdev || vq_idx &gt;= VIRTIO_QUEUE_MAX ||
        !virtio_queue_get_num(vdev, vq_idx)) {
        <br>
                  return -EINVAL;
        <br>
              }
        <br>
      </blockquote>
      <br>
       Hi!
      <br>
      <br>
      How did you trigger this problem? It should not exist anymore
      since:
      <br>
      <br>
       <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/commit/e5cb62e7b6f9">https://gitlab.com/qemu-project/qemu/-/commit/e5cb62e7b6f9</a>
      <br>
      <br>
      which has been included since QEMU v10.2.
      <br>
      <br>
      So please provide some description how to reproduce it if it still
      happens with the latest version of QEMU.
      <br>
      <br>
       Thanks,
      <br>
        Thomas
      <br>
      <br>
      PS: The list of maintainers for the s390x part of QEMU also has
      recently been changed. Please use the MAINTAINERS file and
      scripts/get_maintainer.pl from the latest version to check before
      sending patches. Thanks!
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------oWxnpPQ96j5IWZAjhUGlEAYT--

