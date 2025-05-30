Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C55AC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 06:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKt4d-0001xa-Ks; Fri, 30 May 2025 02:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKt4c-0001wv-5G
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKt4Z-0000FD-IH
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748585907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5HFt5J00MwY5g7CgwAmj8fkbqmktfcpDa7fzujgEWMU=;
 b=Gwse/HHKb4Z11QKqkJPMlkyyu8zQWRpkprFFrA0Zzm/BFmiUkY3OLC4VoDAuLNAY6s2UXs
 RNsfkcVqHB58YhTJevUP6VMmwmgj7T+ZRo9YTEFO6aiynbBGbMCrtNHeT6J1iGfiNGYt0p
 Q9TraVu5s9RfC1GT10oa8c7iFLbXDig=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-pvil9k6KN4OJv0ylwP9hgw-1; Fri, 30 May 2025 02:18:24 -0400
X-MC-Unique: pvil9k6KN4OJv0ylwP9hgw-1
X-Mimecast-MFC-AGG-ID: pvil9k6KN4OJv0ylwP9hgw_1748585903
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-602df3e7adcso1815861a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 23:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748585903; x=1749190703;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HFt5J00MwY5g7CgwAmj8fkbqmktfcpDa7fzujgEWMU=;
 b=w1rHoMBNz0nuxsVOCmIRoYXqHYA+t02AT0wIXJ8yWWcMQc7SczYH8SceT7CyEFrT+k
 DijfLMnLnotqbXKP+lAMP9ck0zBFhDNu8gmNh39WRKvelwn0lYwBN8h6xPEj9fipvi9H
 id3K/MfvCpVLSyOFfJR+ODHvH7Yfl6plj0uBSYoc7XZmumYjcDMlbaulwImJrHUlIO+U
 liMbP5Qx/x94sq7hkwNEV4E2At7g+VLIlOeOW3XelagoE4umt6HhV7EH/MovJmtpdh9z
 ppFAbussm5n68/imD36hQQUDG0DU/YgLnNlKMmJfXtp6l1dPtXaWJV+3PiRPJv7WJJq1
 7Rjg==
X-Gm-Message-State: AOJu0Ywe33q6BamzxX4M9zz7uh7FMogtPH7dlAfmdSKH4xHdbX0yIuRF
 CCuCw0J0/jPOR41MPubh0zjeoD4V0N286vdOTm6LnCR0D1qTxeb43dbgtg8S2dbDBTEFbcjV2UP
 YMudVH48YvPaXkQjMlaS+J1+RHc3tUC3YykCOCSLAYFHGfzXxIMkU+43XoDLSLyeAEWY=
X-Gm-Gg: ASbGnctHnVUJoC9xxDz+XJLjzUCQIgTcBxP3qcsX8tg5J966GF/GtOgwW60p5749ztt
 wiWSG0TVj8pOkRbWXaM/4KUc4bOjziZ8N61U/1psJfRix4abxbRNW8wygPQEcYp9dz/08ZBDNIQ
 Fo6XW8YHpZ3PrKZZtMXKAGM9rRWNQ4le4JuLYkB5WUYrZ+cvv3l/4dgQY7Ztktwt1ZiMedoIwS2
 lCpMVB3JDuk3XtE0WuQVEanfOteOXPtq7at1+I3BEV+zBEVBUBoI40aFFvD6kg9UxiQkKa2ODnB
 hTIHb8u9Yr8S2nERyU0qwyAFPJ+/V952HhNPQgqgyHEU4hHduiIQ3IdxKj4CRao=
X-Received: by 2002:a05:6402:13d2:b0:602:3cf1:44c8 with SMTP id
 4fb4d7f45d1cf-6057c1b5a94mr937421a12.8.1748585903488; 
 Thu, 29 May 2025 23:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaqMciS8kXcamRQ3BFDiEIDhaqoVXf+Jax0DoQ6wgsC1vRxvlFlLrlevl4qQL8K6eeLaBZnw==
X-Received: by 2002:a05:6402:13d2:b0:602:3cf1:44c8 with SMTP id
 4fb4d7f45d1cf-6057c1b5a94mr937406a12.8.1748585903074; 
 Thu, 29 May 2025 23:18:23 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5dd13sm1108850a12.32.2025.05.29.23.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 23:18:20 -0700 (PDT)
Message-ID: <b374f581-fdbf-4fad-ab10-45394211c0d6@redhat.com>
Date: Fri, 30 May 2025 08:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Armbian TLS certificate expired
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QXpwWZK3KeGZ-FVFLhu7CCv8PCRbGZ9MEJK5nS_jUWquQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QXpwWZK3KeGZ-FVFLhu7CCv8PCRbGZ9MEJK5nS_jUWquQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/05/2025 16.45, Stefan Hajnoczi wrote:
> The OrangePi, Cubieboard, Banana Pi, and replay tests use a sunxi
> armhf Linux package URL that is failing due to an expired TLS
> certificate:
> 
> 2025-05-29 13:37:56,005 - qemu-test - INFO - Downloading
> https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb
> to /builds/qemu-project/qemu/functional-cache/download/3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22...
> ...
> urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED]
> certificate verify failed: certificate has expired (_ssl.c:992)>
> 
> I will ignore these test failures for the time being. Hopefully the
> server admins will fix it. Otherwise it will be necessary to find a
> working URL for these tests.

I just gave it a try, and it seems like the certificate has been updated 
already? Anyway, in the worst case, we could also try to switch to http 
instead of https for this download (we're still checking the hashsum to make 
sure that nobody messed with the content).

  Thomas


