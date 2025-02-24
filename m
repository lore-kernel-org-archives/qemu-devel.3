Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D825EC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmVcr-0002cJ-43; Mon, 24 Feb 2025 05:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmVco-0002by-OX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmVck-00080U-1h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740392620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y8bB/SDrMRk7mDKiUuRfOmOSlZDdqdMC3nNpQyx7lOg=;
 b=LR7IljrANhMgFk+EmpR39YFnTezrEeQGK/Ls4yOVg86fBIHPA3M2o2NgqN60KU3iEkKmSg
 cwKvVnrxUWkwVhlD6eHqaFlEK5pqr7/lcEOw5Gce1ol77RQrcWpRCj2NqtMX32yN4CqdB5
 HTDUoAGe2jjhJfrJcgWJIJ1Zq5gLgHw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-wYy4i6oEMXuWZK9IcSzUWQ-1; Mon, 24 Feb 2025 05:23:38 -0500
X-MC-Unique: wYy4i6oEMXuWZK9IcSzUWQ-1
X-Mimecast-MFC-AGG-ID: wYy4i6oEMXuWZK9IcSzUWQ_1740392617
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so22488535e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 02:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740392617; x=1740997417;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8bB/SDrMRk7mDKiUuRfOmOSlZDdqdMC3nNpQyx7lOg=;
 b=HhldqtOyoN7IJay7hJ7MRcfANBQ0Uj3fZ4/rqIRMbZQr6MgBqEXmVgBA4aIbvr2pvo
 DsahXxiviUZeQ1JsAKQJBY0+qnRYG8VHmvRQp6nkyKW2wCWMIxuUjomG+JFZBipBA6F0
 t9+btOpazLoeEMiHPIwZfzZWgmcYMjnueWY4OHhkIuApsBTTiLyf2n7fcGJklm6+dYOP
 dB2u67CNS24UGmopqNkHEV8CV6s47DOKrpPoZ/4ExFt9aRStBrxqLr5nRkT0VvVGdN81
 7uUucM9k4RyALBr1YKmkMthuq1DWiRzZtRoaxM4+KZovqVdZFFJx52Wx0XmzxlQPVLrf
 cH9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/tMk2IeVA+9SpP6AKCjGVZvfPyJQ2ZicesnLjzncBvaB3DgDh7t+vCXReBv5gPg+JPao3zSQAjOUR@nongnu.org
X-Gm-Message-State: AOJu0YxRNcAYuwAeNOswC8r93Nu5VdODG4q3LTEKG4jk2M1LBmmVf8lT
 juUIOVPuH76AvzajTc0kjtRK2OId12otm1CHtNtmUqxzbUoq2EeMv+i+eQbyi29NlFdj2dCoHdf
 VilQwx92ltudD5Ez0Ne9lxaT0kp6O63ECQAN0EfJfuMnX8Haok39D
X-Gm-Gg: ASbGncv76OcDzxxoY7Aa360jnn08ssC80k5NiT9nCvr51aKmKBKMPZKkb6GeZu8dZ+z
 UEowEcEeIypBRzDlUO4ySjBbny3iP53h0onsSGTEU+4tL+dru1AMYSdr5OT8caGeiymVayrjgrk
 pPOFgwJudpesR2MfYflB2o3TPwSqlipFdST4Fwj8LcXzGyf4zGruT9jIjx26dozgktr3N0fEAGo
 dXpsrtNltUUhjY3jLl2VXpznVppQyUjbeAzLUFjt8t2/38GIHeQsRHAc0U+wVsG/CaGiXf3bLDW
 Scrs1gMlu9nJCxO22FVkv679+/iRMTsvh7+CMNjB
X-Received: by 2002:a05:600c:6b66:b0:439:96a4:d2a8 with SMTP id
 5b1f17b1804b1-439a2fb2c41mr121345885e9.5.1740392616823; 
 Mon, 24 Feb 2025 02:23:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhykH7k4WOx20q5ipZuRnr0OtNnZjnL2ZXiud1rmW9JoZVCzA+CrvA0knw+hdozNZxTwkaZQ==
X-Received: by 2002:a05:600c:6b66:b0:439:96a4:d2a8 with SMTP id
 5b1f17b1804b1-439a2fb2c41mr121345665e9.5.1740392616401; 
 Mon, 24 Feb 2025 02:23:36 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8121sm30727702f8f.88.2025.02.24.02.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 02:23:35 -0800 (PST)
Message-ID: <b74180f8-f892-450e-9327-87a47bd0a8ab@redhat.com>
Date: Mon, 24 Feb 2025 11:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] iotests: Add qsd-migrate case
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
References: <20250204211407.381505-1-kwolf@redhat.com>
 <20250204211407.381505-16-kwolf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250204211407.381505-16-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/02/2025 22.14, Kevin Wolf wrote:
> Test that it's possible to migrate a VM that uses an image on shared
> storage through qemu-storage-daemon.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/tests/qsd-migrate     | 140 +++++++++++++++++++++++
>   tests/qemu-iotests/tests/qsd-migrate.out |  59 ++++++++++
>   2 files changed, 199 insertions(+)
>   create mode 100755 tests/qemu-iotests/tests/qsd-migrate
>   create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out

  Hi Kevin,

this test is failing for me in vmdk mode (discovered with "make check 
SPEED=thorough"):

$ ./check -vmdk qsd-migrate
[...]
qsd-migrate   fail       [11:20:25] [11:20:25]   0.5s                 output 
mismatch (see 
/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/vmdk-file-qsd-migrate/qsd-migrate.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/tests/qsd-migrate.out
+++ 
/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/vmdk-file-qsd-migrate/qsd-migrate.out.bad
@@ -51,6 +51,7 @@
  --- vm_dst log ---
  read 4096/4096 bytes at offset 0
  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Pattern verification failed at offset 0, 4096 bytes
  read 4096/4096 bytes at offset 0
  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  wrote 4096/4096 bytes at offset 0
Failures: qsd-migrate
Failed 1 of 1 iotests

Is that working for you?

  Thomas


