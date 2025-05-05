Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63294C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqql-0002ur-Jj; Mon, 05 May 2025 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBqqj-0002uK-1z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBqqh-0002FO-Cr
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746432408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3cWGKy8Ph/aNn3T518rHxHvC3K2U91HBVqyT3Q9z9tM=;
 b=F2Eh4U02QB0uhG+FGM8Adyc4PBpylbU96MktcePhsCpI+NupaJrCvlNHFfFLSSBOc6ZOTt
 TLSGSScFwc1cw1hDFS187NccDL2KR7D4KV6AJjxfkDq+uco4Sa6bK9nh8sA6VnQfnNzhn+
 nmmRF948rMxPUSs4jLo3ZOwpSwbFBsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Q_17BNhBPfOtiVlZm_xOAQ-1; Mon, 05 May 2025 04:06:47 -0400
X-MC-Unique: Q_17BNhBPfOtiVlZm_xOAQ-1
X-Mimecast-MFC-AGG-ID: Q_17BNhBPfOtiVlZm_xOAQ_1746432406
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so21404675e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 01:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746432406; x=1747037206;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3cWGKy8Ph/aNn3T518rHxHvC3K2U91HBVqyT3Q9z9tM=;
 b=vXQgq7Nb3cqUFeCaeaR58Z/ltgp/7ahRxtnGz7XhMVJa5E5X533BGcKelSB222WKpr
 kr4JpBxPRMuA8gELO72MAmYwbsXpn9tDBP+iH5SrqOkUWkB0y5MOIoSerwaZnwYk/4cp
 q627TmMGe3d6QTQ4szl31vdTzrUA7ro0fAOzPJZAzwt6hUWdFuDFu/+z2BW6YdXaVDwX
 ha1yHv+n/WXUmXnpxG63UogWMAAnOCgE/b3KOexASndoyV0W5hcGL/4Mi4gprIT3WeI7
 XBa/2/ML4D19xHUib30y9Nq380sdO9rcZ41IjDeQ61uc1wzczsn5CrgPrROql+LUb6ZK
 dIDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCiP29R1aS1dg8NuBioquhkGJtcsPlggAHPcIxo6nKsei6UboEp7I9fDl7oU8Ce79mEPA/8eYe7IDC@nongnu.org
X-Gm-Message-State: AOJu0YysPvEDfgw4bvmxGDS9xoohdWZmxGpNguBeKyHrtGxLURubeJ1n
 pTWyMk1PsmbSh11vKbSJsV1lX26kkb1kFi3zyOnecwLYvKd+zcD+k5NPUya8vzh/nNms1YMAfTL
 xsfRgLnEPHSuSuA1WcIcQXnnuEY8Lqm/kMYkcsnKwN65mMnlXIenJ
X-Gm-Gg: ASbGncvxR9pN4NNDDwJuNVNZK02DkNlBTnZRRKV4hLcPTzN4HYN3n4PfDq9M660rIIw
 5H5hEXQzFRqPGq46u5HVXSkoxDVZj6K+6bN+gdP2IO707etzMeTLz/En1wuC2fRJLJzV4mMRX8Q
 TINmBZYGLIgDc1dUE5KeMkLYlLKs/UT6Ywr+ApZB831StMzZg1RKuwDwXi0khrwPCnHX92RY2+Z
 LePkuN8+AyzwFFprzxoGv8zcsgq+4arAQ8mrYoCx3qc5EJ99a8nLIaCOjmUP2fjKNo4ytYV1kqV
 tHgdttGZfmlQKMLAbjEGyvlkOp3jC9Twd+Zy9g/F
X-Received: by 2002:a05:600c:3492:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-441c48dc057mr60997375e9.15.1746432406226; 
 Mon, 05 May 2025 01:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfPELW8rQmM11D6q6IY7FsjRLOcptsrh1uAGNzTd+fPYTsq77wUrsKG64/kYh+l1P61d7gQQ==
X-Received: by 2002:a05:600c:3492:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-441c48dc057mr60997045e9.15.1746432405796; 
 Mon, 05 May 2025 01:06:45 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b287desm170865355e9.38.2025.05.05.01.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 01:06:45 -0700 (PDT)
Message-ID: <66c69049-efb1-4d40-ac76-f66e92d33b95@redhat.com>
Date: Mon, 5 May 2025 10:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_DONTDUMP)
To: Jon Wilson <jonwilson030981@googlemail.com>, qemu-devel@nongnu.org
References: <e703e0e8-8207-41b6-b2a5-6d6544816fd3@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Bandan Das <bsd@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e703e0e8-8207-41b6-b2a5-6d6544816fd3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 01/05/2025 10.42, Jon Wilson wrote:
> Hi, I'm a first time contributor to QEMU. I am using qemu-user for fuzzing 
> using LibAFL and as part of that including support for address sanitizer 
> (https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm). In 
> essence, this requires that my process running in QEMU requires very large 
> (albeit sparsely populated) memory ranges (terrabytes in size) for the 
> shadow maps. When ASAN detects  an error, it causes the target to crash. As 
> a result a coredump is generated (which would usually provide a very welcome 
> opportunity to perform a post mortem), but QEMU includes these shadow maps 
> in the core dump which it generates quickly exhausting disk space.
> 
> The function vma_dump_size performs only basic filtering of the ranges 
> included in the core dump and the implementation of target_madvise 
> disregards MADV_DONTDUMP (which per the spec it is at liberty to do). 
> However, it would be very helpful if QEMU were able to exclude ranges marked 
> with MADV_DONTDUMP. I believe it should be a simple case of adding a flag to 
> page-protection.h and using pageflags_find to update the flags in 
> target_madvise. Then the logic in vma_dump_size could be updated 
> accordingly. A more colourful and easier to read description of this is in 
> the following markdown gist (with references to the code in question):
> 
> https://gist.github.com/WorksButNotTested/becd7a1f89690fad89b3e8b44ed7192d
> 
> Would you be receptive to such a modification? Is my strategy for the fix 
> correct?
> 
> Many thanks for your advice.

  Hi Jon,

no clue from my side, but qemu-devel is a high-traffic mailing list ... in 
case you don't get an answer, please try to CC: the people who are marked as 
maintainers for the linux-user code, that might increase your chances to get 
an answer (done now).

  Thomas


