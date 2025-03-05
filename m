Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A800EC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiWK-0006Pi-8j; Wed, 05 Mar 2025 01:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpiWB-0006Ne-Bm
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpiW9-0003eJ-H1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741157167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QJmF3al7TjAEXYJ+NwN/XKXpVmlRJV9PVR22W1q2yLM=;
 b=Nv/VF61hAoT6WTgawSy401nKyBdGuI8RfYzWRlq7yiPmIV8T/yfL8eUF0sth99RMuKG3O/
 49TVXBx/t5YtO7xQh79UvMLapNibd7dDJLQeeAiaktOx5sJ0T/P8wDJ7JR8vP3LomaMlH7
 E5LYfbVter4Dw1cuB89q7G+8JLo4FbQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-HUdB98-ZPK6s7HWuEetlng-1; Wed, 05 Mar 2025 01:45:54 -0500
X-MC-Unique: HUdB98-ZPK6s7HWuEetlng-1
X-Mimecast-MFC-AGG-ID: HUdB98-ZPK6s7HWuEetlng_1741157153
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390eefb2913so3340522f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 22:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741157153; x=1741761953;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJmF3al7TjAEXYJ+NwN/XKXpVmlRJV9PVR22W1q2yLM=;
 b=TUMTpBwbFUldTCsGqKsYH6tIhYu/jNKAsZrD9Z4eC+plFAZqb/9BHnbD52JKdWZwgq
 +Foh0uL1cSleslWRxibxOOwb2V/98DpU1C+tmR0TV//vf5QAHzcrlDoWDdWWDbORpF61
 lztJXo4mv6BwLg7T8hqeilnHjZSdhIRYj5JNu+pNyxzqwvulRO0JZbWoUtFR7KWK2QpF
 tNVYMICEP5xULyJwq+VgPGkVioUI6gjUPtzQXZTktwfr2MIA7n7kvmd2nkNwa6rCFVXg
 HHVitiCTfGfM0ls+2DEd6/yA896wqutnedWUACCYSkXEMLX+3OGc8cxkDvF7Ghnkko3f
 IkwA==
X-Gm-Message-State: AOJu0Yy4P3/dIONUIP8+CgXvgsuMjNq6hacbxwtpB1BB02iGb3GxoneI
 uTBUEcGvdl8J3qafnVuRnPqFFw8UvQd8NJ2D61X6kwqm9RwQxFc6hnSY5p9NKALTfjWOM8Z3xfs
 HFbrhbPh7dgW0IOR8nkgsI48tGMQhyB/TP3K0BLYtyOyEzpTZLXK4
X-Gm-Gg: ASbGncuF1rpMv8s3wux2DpEupyiNnQ7cVCid7dk7M9Euvjx7eIYhb6w21p6xsrYOlS/
 MZMYsPV9OIT/cX0eIg2JfbaYMW+Nk7ByWP4bwwDXUyzdYPJj/o6NK2AFAj34tfFzqKY7sAUmh5P
 vILWCgAYMJY051gyqoRXhjhwRqAwNCEwLBN9iQUIL0pcF2E0Hv5l5eL9YQ9shRfabrovRLQprem
 IDfWlUDBj+e5XgITS9lVWoIiwquqe3y77fBvFBHFm1OS+PupNxw4b8jdbeMyde4dVWiiYQlrfdZ
 9dZbCZEcaqp6dtLPu+hR8TQKfegZuJVpJ4toL02IC+MMkfI=
X-Received: by 2002:a5d:59ae:0:b0:391:10f9:f3a1 with SMTP id
 ffacd0b85a97d-3911f7bba1fmr1539186f8f.35.1741157152856; 
 Tue, 04 Mar 2025 22:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXErMUNZhLV6ipwB1/2ZwuyDTXR+uxS3S3Q+2A4gR5QMeVUQKVwvd9UmVQYZaxJxHAvNv1ZA==
X-Received: by 2002:a5d:59ae:0:b0:391:10f9:f3a1 with SMTP id
 ffacd0b85a97d-3911f7bba1fmr1539166f8f.35.1741157152525; 
 Tue, 04 Mar 2025 22:45:52 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352fa3sm7748915e9.30.2025.03.04.22.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 22:45:52 -0800 (PST)
Message-ID: <569db74d-15f4-4eea-b285-4556ffd7d60f@redhat.com>
Date: Wed, 5 Mar 2025 07:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Remove the boot_linux.py and
 replay_linux.py tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250227110014.21048-1-thuth@redhat.com>
 <87mse7wph2.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87mse7wph2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 27/02/2025 13.18, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> These tests are based on the cloudinit functions from Avocado.
>> The cloudinit is very, very slow compared to our other tests,
>> so most of these Avocado tests have either been disabled by default
>> with a decorator, or have been marked to only run with KVM.
> 
> I have no objection to dropping the boot_linux tests. However the
> replay_linux tests could do with porting to use new images (the tuxrun
> ones?) so we have coverage. Otherwise we only do a simple kernel boot
> under replay and that covers a lot less.

Ok ... maybe we can also extend the existing 
tests/functional/test_*_replay.py tests to do a full boot ... I'll have a look.

  Thomas


