Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7FFC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 21:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIbOD-0001lf-AF; Sat, 15 Jun 2024 17:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sIbOA-0001ii-Tf
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 17:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sIbO7-0004o8-NS
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 17:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718488600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcHHdiCOQSbFEbxWGmHVP+vhV5TFNN33TglrL5+1rf8=;
 b=MTU0kubEBZAm817DbjFKlQmn5P0D+tLisIoPvZUK4QJdddwMqZvA/Vf5aGnhSh5qAWBYb6
 5i4kOkZgSddkhh8Fouj8Gn9i8OQxqRRhKFZaNMcdg9haYylgLnjmzJcZgRu1CBLTgZGHIu
 2+C9/ick8daTFRQEjXrK3gSPvDsrACI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-9TR4iX1XPOG0BuT5oVLpNw-1; Sat, 15 Jun 2024 17:56:38 -0400
X-MC-Unique: 9TR4iX1XPOG0BuT5oVLpNw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4218447b900so17086365e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 14:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718488597; x=1719093397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WcHHdiCOQSbFEbxWGmHVP+vhV5TFNN33TglrL5+1rf8=;
 b=rp3n6X9jErYCACN0WVLG8qT9iQKP/pYzL9EMlk35ufHWtEM8dvUmemfwBi36UtQFQ6
 oviuHFEkHo4vd6QTGXXHStJl0NGPylnrS9T87GiNQa6rvD2hSE0qV+pXxvtUM83vjOBd
 iVWImxbBnkIrd2tdbB3PcEMPzlxJZrMo21FJ96D/a8yGc3GIIws4A8nHdM9uIzhwn3IX
 LJ/ZjFeDw0pglNZWUHNx5D0MaeYXXxIblonl/fF2/AcnbA40v4S3jsW/IUaRy60eIt02
 uqp2r49IpVhLFJXrULY4jSawQNgfCgNxsD1h4GjAU9DlL3fkw5UaeG6uKEbpkY6KmtTg
 crFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvngFDsiCBhe4rCYXo3TkDZhFroKEx/6f7UWPXN9jk1B5AYhmNEGSyGnT7URggeg4P8Y1+rs1U6A2sSK6tQSuw0E7B0FE=
X-Gm-Message-State: AOJu0YxUHtpXiWAXCZ4EjqM6LZfL3rAwJsQWH5YMIlQPCuDRc+qxPGjq
 iGR2Vli85UUkyz+rnEUxUF+4lWhE3JGsMniUio29p+nJpEq6Qtx10tuSTo6NuYKoDpzzpbEeBdF
 1Vc4PcOT6oHyifFmezlC/wbuE3bENgQT4ERJKfq22sV+uM1ouI25D
X-Received: by 2002:a05:600c:3512:b0:422:fdb:efb3 with SMTP id
 5b1f17b1804b1-422b6fc46e1mr79017025e9.12.1718488597483; 
 Sat, 15 Jun 2024 14:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgXWUa7va4LLpxN/XwQCg6i8tjtYtV9kaJb/TYWd+npccGvKPNmQUhGChEQ1j/g9UhjTMgHg==
X-Received: by 2002:a05:600c:3512:b0:422:fdb:efb3 with SMTP id
 5b1f17b1804b1-422b6fc46e1mr79016965e9.12.1718488597103; 
 Sat, 15 Jun 2024 14:56:37 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9000:9100:a34f:49ce:8596:8d47?
 ([2a01:cb19:9000:9100:a34f:49ce:8596:8d47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320c70sm110419585e9.30.2024.06.15.14.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 14:56:36 -0700 (PDT)
Message-ID: <ad8f7b8e-ad7a-439b-bc4e-6b226cb6af8a@redhat.com>
Date: Sat, 15 Jun 2024 23:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] aspeed queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240614072620.1262053-1-clg@redhat.com>
 <828dc03b-1e7e-40f6-80fd-0f5d56f362bd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <828dc03b-1e7e-40f6-80fd-0f5d56f362bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/15/24 6:14 PM, Richard Henderson wrote:
> On 6/14/24 00:26, Cédric Le Goater wrote:
>> The following changes since commit 046a64b9801343e2e89eef10c7a48eec8d8c0d4f:
>>
>>    Merge tag 'pull-request-2024-06-12' of https://gitlab.com/thuth/qemu into staging (2024-06-13 07:51:58 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/legoater/qemu/ tags/pull-aspeed-20240614
>>
>> for you to fetch changes up to d9f6311f5393da897e73be8a29c261125d0c1ac2:
>>
>>    MAINTAINERS: Add reviewers for ASPEED BMCs (2024-06-14 07:36:09 +0200)
>>
>> ----------------------------------------------------------------
>> aspeed queue:
>>
>> * Add AST2700 support
> 
> Fails freebsd testing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7106081732
> 
> I'm not sure off hand why this wouldn't also fail on Linux...

Yep. It should have :

@@ -332,6 +332,7 @@ static const TypeInfo aspeed_intc_info =
      .instance_init = aspeed_intc_instance_init,
      .instance_size = sizeof(AspeedINTCState),
      .class_init = aspeed_intc_class_init,
+    .class_size    = sizeof(AspeedINTCClass),
      .abstract = true,
  };


I will resend a v2 next week.

C.


