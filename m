Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77CCCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 07:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBpKF-0003by-Cv; Thu, 23 Oct 2025 03:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBpK8-0003aG-2t
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 03:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBpK4-0004Pl-Ms
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 03:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761202875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WnGeHzwPDjiiBlJxqdCFdDkc6/33T6vq8MwVC6hmm7k=;
 b=Hbk1p+uPLON44xyQ3XegEL03WVPkMwXj0s5gmPg5kVFhk8nVB5PLw4dpnTFlMii8MHk1yn
 QFx04XNY0mOarmBOwfSrQUdx9dHwv4WcTm4UwGbH+0PcClo6SV6uHtKV9jtSzblpRiatW1
 IYqiVRgP7YDkt3kCSu2HpiPo9tYRcWA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-sCivY9aKNUmkWZbtDs50Hw-1; Thu, 23 Oct 2025 03:01:13 -0400
X-MC-Unique: sCivY9aKNUmkWZbtDs50Hw-1
X-Mimecast-MFC-AGG-ID: sCivY9aKNUmkWZbtDs50Hw_1761202872
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46fa88b5760so1481305e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 00:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761202872; x=1761807672;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnGeHzwPDjiiBlJxqdCFdDkc6/33T6vq8MwVC6hmm7k=;
 b=GawwiwLPI3xmbxWtUqBjoWP16Q2CWDPLwdhp05mDl47Huun8yVLpQPr8S4Y9N+u1RV
 065Ek9DH0qcRuGfnS00deQhCjKnl7/6FCdPU/voKpLFMvZZ/bCYgQCk074o9HnO7/M51
 ByzFudPpgGpf0Xqy8b0JFDga7IV0S+W4xovI+Psm18vecmwXAVcs+1md6Dvi5Tb6hdf5
 gVxrgno3sQDq+6d21AnCWEUtyu2Jy4WlxzV8b1ykzGz8b8hTReC3/m3o+Y3FWp/bTJqX
 u2gC2BSii0h89/BxTzBA9aHKxaOSnFkSAHHl43fca1ZlanujcaHzsbHGKo+z+rXZssiE
 JeQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHWeNAgh1MkHuuw8vTcZEo/XZtaGHsEYkxoIiEI+Z/0BGe2MVMqdDhuIdvcV1e7tS/VfF1muC3EgKA@nongnu.org
X-Gm-Message-State: AOJu0YwtZF7lJZFRTPIH/N4Ygsnzmnpx0QIXzbI8eBF3qQzhjtHFd57e
 FEx4YygrGgNGFM67t/P8wh3zVpFVT4JmVKWyAzK0+9YH2XtmXa9tPIO94DaazV9XWgUufaoySVl
 gnfNOdHoOTCVQQ8l6NoToGNfXo7anR7KFishXkLfK39LiU6YjTkGzxO2V
X-Gm-Gg: ASbGncvFc1gDNHyNj0f4pKpCdDYWSAYOwRxpBOM4xItFFAv4+HGFO9aOODkdmbEuSGy
 lLsTwXW2b9weNryjhCazxhSdagzzQVFZtY5+XgMQBro8oT65iKIaSBAa6S8Ev6wHMSrLaxm4P+X
 BnYkEtfbrgfZ0hj244AkI5qcoY2GSRtovZP+47dQ90jlvbAME+b9p8qpZwt2Cp8zqz+sNTeyeGA
 8TdTpq3q2gI8oMElwp8ecRy4M3u9UXTpqKwRhdAElsJKmGedfi+NL4mGhF1eIZutpEgHkQRCysX
 T7r9yfFVNTfPLPFh1Eq6+G4gweMi1s1u1zlcbBF6Q1fsuSZ9kU2GxwZITmbDSV6XJqtgBjRGC2V
 RSc4hm03XMXWZBTuw+NvwUAJGoMOZqnpkHlvY7HM=
X-Received: by 2002:a05:600c:3e0f:b0:471:803:6a26 with SMTP id
 5b1f17b1804b1-4711791d945mr181052585e9.37.1761202871929; 
 Thu, 23 Oct 2025 00:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiHSZSJ7Pt86hIQebL0az33XXamUCxKVfo6++kmwhHJhkm8zrJS8/KJQWSRhn0WFemwkvg2g==
X-Received: by 2002:a05:600c:3e0f:b0:471:803:6a26 with SMTP id
 5b1f17b1804b1-4711791d945mr181052245e9.37.1761202871542; 
 Thu, 23 Oct 2025 00:01:11 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f571sm20959645e9.7.2025.10.23.00.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 00:01:11 -0700 (PDT)
Message-ID: <f7817d99-f2cb-453a-8d3d-e28b592fa93d@redhat.com>
Date: Thu, 23 Oct 2025 09:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/device-crash-test: fix spurious EOFError messages
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20251022213109.395149-1-jsnow@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251022213109.395149-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/10/2025 23.31, John Snow wrote:
> When the QMP library was updated to match the standalone repository in
> 094ded52, I neglected to update the logging filter(s) in
> device-crash-test, which allowed the spurious messages to leak through.
> 
> Update the log filter to re-suppress these messages.
> 
> Fixes: 094ded52
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/device-crash-test | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 1ecb9663ae8..c1576e8b966 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -527,7 +527,7 @@ def main():
>           # Async QMP, when in use, is chatty about connection failures.
>           # This script knowingly generates a ton of connection errors.
>           # Silence this logger.
> -        logging.getLogger('qemu.qmp.qmp_client').setLevel(logging.CRITICAL)
> +        logging.getLogger('qemu.qmp.protocol').setLevel(logging.CRITICAL)
>   
>       fatal_failures = []
>       wl_stats = {}

Thanks, that silences the messages, indeed!

Tested-by: Thomas Huth <thuth@redhat.com>


