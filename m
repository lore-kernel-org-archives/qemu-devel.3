Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790EBC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsG5-0006Eu-9s; Thu, 11 Jul 2024 07:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRsG3-0006E5-8v
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRsG1-0001zQ-5V
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RepNjDrKM17OtqEpwTT3OkgP5dg0DjC6+fnF9BH9a0s=;
 b=Unm5k7a1OPHcUxOLDM9QwaAeJJ1I+ufjBo3kS5OCi++CaHk7q8GCO523Y+5yihz85YCluD
 3eI8kdeI138GBzDXZ1L8hiXkBXklYUweIyDxnRjAe3gLFEKbCW+RiAEgOyKlNvlHgt/qZL
 W179OAlgmRL0ROC07Wg7b6Y7gcDgfO4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-VNecJeMSP1mkKx686rSzkw-1; Thu, 11 Jul 2024 07:46:37 -0400
X-MC-Unique: VNecJeMSP1mkKx686rSzkw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77c9c6bdadso70988666b.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 04:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720698396; x=1721303196;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RepNjDrKM17OtqEpwTT3OkgP5dg0DjC6+fnF9BH9a0s=;
 b=jxQqvCV29n/h43sfRbXHEjI9Fl6/pFRFOJccCku3BQn87lbkW9DLXRjcZhn2sAc8+D
 fHCfRep7zZL6YSkJsh3QORkh3PUVz9XFbGdTdfNj4YADq73LXIGCEhQhR3ohIR6lNv5r
 MVHM4cAo3fV3JxWur5nDoBhuTutmSH9I13mCTXJfUxj5tFISC+w1nCS7dLDPzNA3Blom
 NpugBkKYm9XbRNWTCMHc7j0DIc+7HCd41tFSwyQzKxn1MyiW9EjjvDIQ1CYAzylPpZ1v
 j8BIsUHS/k7rZ0IkyMQZCgRcoZtOALcT3ZnPtkqvOGSZsFEaKmDu0l4XSRUNUI59oUxz
 gQyA==
X-Gm-Message-State: AOJu0YzjKZ55+Jze4AVjntXSxVn7hBVpHmS2W331+uzcofOD9XQi354u
 H3WavEVbJUoUXEP4VTMftA4wJbdXpYur8EdEW5I3e/pWUZrr1skODsafz/2q/21bl0P3yHqxnh2
 0yJ/iowKglcvElke70/CyGqoMowJPimY/cEZ/H8fzzYac2bmoQVDC
X-Received: by 2002:a17:906:d105:b0:a77:cb7d:f356 with SMTP id
 a640c23a62f3a-a780b8854d5mr464101866b.51.1720698396047; 
 Thu, 11 Jul 2024 04:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFInOWzOrQEiLbQ9+MtnXgJi8C+6yD773N5v83mKUDalEmZtzYQxOK2nfLEz/hJjGt0EASwag==
X-Received: by 2002:a17:906:d105:b0:a77:cb7d:f356 with SMTP id
 a640c23a62f3a-a780b8854d5mr464100566b.51.1720698395409; 
 Thu, 11 Jul 2024 04:46:35 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d?
 (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6bc7b4sm251857766b.43.2024.07.11.04.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 04:46:34 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------6L37yea10o3eSTCkvkqwK6H0"
Message-ID: <b45513dd-d200-4a10-bd9d-d129bc8b8528@redhat.com>
Date: Thu, 11 Jul 2024 13:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Always reset vhost devices
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20240710112310.316551-1-hreitz@redhat.com>
 <CAJSP0QWMKZxQTKuhQ1dASm9xqfWiumLz7ciVZy2APjPhT4VuFw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QWMKZxQTKuhQ1dASm9xqfWiumLz7ciVZy2APjPhT4VuFw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------6L37yea10o3eSTCkvkqwK6H0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.24 18:28, Stefan Hajnoczi wrote:
> On Wed, 10 Jul 2024 at 13:25, Hanna Czenczek<hreitz@redhat.com>  wrote:
>> Requiring `vhost_started` to be true for resetting vhost devices in
>> `virtio_reset()` seems like the wrong condition: Most importantly, the
>> preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
>> up in `vhost_dev_stop()` (through vhost devices' `.set_status`
>> implementations), setting `vdev->vhost_started = false`.  Therefore, the
>> gated `vhost_reset_device()` call is unreachable.
>>
>> `vhost_started` is not documented, so it is hard to say what exactly it
>> is supposed to mean, but judging from the fact that `vhost_dev_start()`
>> sets it and `vhost_dev_stop()` clears it, it seems like it indicates
>> whether there is a vhost back-end, and whether that back-end is
>> currently running and processing virtio requests.
>>
>> Making a reset conditional on whether the vhost back-end is processing
>> virtio requests seems wrong; in fact, it is probably better to reset it
>> only when it is not currently processing requests, which is exactly the
>> current order of operations in `virtio_reset()`: First, the back-end is
>> stopped through `virtio_set_status(vdev, 0)`, then we want to send a
>> reset.
>>
>> Therefore, we should drop the `vhost_started` condition, but in its
>> stead we then have to verify that we can indeed send a reset to this
>> vhost device, by not just checking `k->get_vhost != NULL` (introduced by
>> commit 95e1019a4a9), but also that the vhost back-end is connected
>> (`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).
>>
>> Signed-off-by: Hanna Czenczek<hreitz@redhat.com>
> I think an additional SET_STATUS 0 call is made to the vDPA vhost
> backend after this patch, but that seems fine.
>
> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>

Thanks!  I agree that double-sending SET_STATUS with the same value 
should be fine.The virtio specification states: “The device status field 
starts out as 0, and is reinitialized to 0 by the device during reset.” 
– I interpret that to mean that (re-)setting the field to 0 is always 
OK. Hanna
>> ---
>>   hw/virtio/virtio.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 893a072c9d..4410d62126 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2146,8 +2146,12 @@ void virtio_reset(void *opaque)
>>           vdev->device_endian = virtio_default_endian();
>>       }
>>
>> -    if (vdev->vhost_started && k->get_vhost) {
>> -        vhost_reset_device(k->get_vhost(vdev));
>> +    if (k->get_vhost) {
>> +        struct vhost_dev *hdev = k->get_vhost(vdev);
>> +        /* Only reset when vhost back-end is connected */
>> +        if (hdev && hdev->vhost_ops) {
>> +            vhost_reset_device(hdev);
>> +        }
>>       }
>>
>>       if (k->reset) {
>> --
>> 2.45.2
>>
>>

--------------6L37yea10o3eSTCkvkqwK6H0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 10.07.24 18:28, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJSP0QWMKZxQTKuhQ1dASm9xqfWiumLz7ciVZy2APjPhT4VuFw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Wed, 10 Jul 2024 at 13:25, Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Requiring `vhost_started` to be true for resetting vhost devices in
`virtio_reset()` seems like the wrong condition: Most importantly, the
preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
up in `vhost_dev_stop()` (through vhost devices' `.set_status`
implementations), setting `vdev-&gt;vhost_started = false`.  Therefore, the
gated `vhost_reset_device()` call is unreachable.

`vhost_started` is not documented, so it is hard to say what exactly it
is supposed to mean, but judging from the fact that `vhost_dev_start()`
sets it and `vhost_dev_stop()` clears it, it seems like it indicates
whether there is a vhost back-end, and whether that back-end is
currently running and processing virtio requests.

Making a reset conditional on whether the vhost back-end is processing
virtio requests seems wrong; in fact, it is probably better to reset it
only when it is not currently processing requests, which is exactly the
current order of operations in `virtio_reset()`: First, the back-end is
stopped through `virtio_set_status(vdev, 0)`, then we want to send a
reset.

Therefore, we should drop the `vhost_started` condition, but in its
stead we then have to verify that we can indeed send a reset to this
vhost device, by not just checking `k-&gt;get_vhost != NULL` (introduced by
commit 95e1019a4a9), but also that the vhost back-end is connected
(`hdev = k-&gt;get_vhost(); hdev != NULL &amp;&amp; hdev-&gt;vhost_ops != NULL`).

Signed-off-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think an additional SET_STATUS 0 call is made to the vDPA vhost
backend after this patch, but that seems fine.

Reviewed-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a></pre>
    </blockquote>
    <br>
    Thanks!  I agree that double-sending SET_STATUS with the same value
    should be fine.<span style="white-space: pre-wrap">  The virtio specification states: “The device status field starts out as 0, and is reinitialized to 0 by the device during reset.” – I interpret that to mean that (re-)setting the field to 0 is always OK.

Hanna


</span>
    <blockquote type="cite"
cite="mid:CAJSP0QWMKZxQTKuhQ1dASm9xqfWiumLz7ciVZy2APjPhT4VuFw@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 hw/virtio/virtio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..4410d62126 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2146,8 +2146,12 @@ void virtio_reset(void *opaque)
         vdev-&gt;device_endian = virtio_default_endian();
     }

-    if (vdev-&gt;vhost_started &amp;&amp; k-&gt;get_vhost) {
-        vhost_reset_device(k-&gt;get_vhost(vdev));
+    if (k-&gt;get_vhost) {
+        struct vhost_dev *hdev = k-&gt;get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev &amp;&amp; hdev-&gt;vhost_ops) {
+            vhost_reset_device(hdev);
+        }
     }

     if (k-&gt;reset) {
--
2.45.2


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------6L37yea10o3eSTCkvkqwK6H0--


