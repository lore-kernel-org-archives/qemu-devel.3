Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093DBC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcdU-0001O3-Ef; Thu, 01 May 2025 18:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcdP-0001Mi-8j
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:44:03 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcdN-0005vH-PD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:44:03 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85df99da233so144211339f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746139440; x=1746744240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OU/fhQ/0MfsVEzAPd+/ENMVEjIJDLcvEYVjg1p/Q9rM=;
 b=xDYejWDcYOLL9UBBPC1HSIjZaIHR9uozGZ7cLFr74Lmf9Ki2GQYZTNGXDaLovi4OJO
 oVK+dyKIBFx4CZ+vAFwdu/b0CJZCXBjuZCEkURLtvL+DIzErGx503vJRBa78QdYm1vM0
 r16V+ACduZInGMZr86QjhZKaJxghmutjxFVv4xZntTdpr/6yVoATpIIOsS42U+2Y5cCP
 Gx9bPzH3hViiK2FDfa7lN5+WZA6ImPf24qGxAsBFt3LybulRFJK7a5g2FyzePTyL1uGY
 fkt+PQbq+94drEJQoG2qG1+S+1uJnlTWQAcyQEN+OXx9ACUN+5dZjobmVHX74YUDBZrL
 Q8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746139440; x=1746744240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OU/fhQ/0MfsVEzAPd+/ENMVEjIJDLcvEYVjg1p/Q9rM=;
 b=DQDhHxNNU5mlURw1FxwBUunSOSbRV/sTvIuVaHRWs5KJxK2JPUStf6aKT5G/z+DoT5
 ZutCwy7c/xnRkWIJ2L12ZwW8mI9BXqpulCoLVWc5QeuI0gt6IndHI5BepXNRnDSpsDMS
 s/7GO7BSVHFCiV/D+BEIzaSw6TKH52rFTKB8bplu+GYgtepz+xmMeFA9iohEHVUxsCfN
 vGYufE6KmRw7i0cc+JHS9iUUS46yevRqhMJ9nL3CebeTP3MBznmoLoJZSFzxziXtsU2r
 cnYjPl7nyE+XGV8E6r6exMq2EXVpGDnqC5tWpdlXeEFENeDVCRo+fgUeHDyzGPS+9Xdl
 CPqw==
X-Gm-Message-State: AOJu0Ywg5+QxXqVaLAtmcgqM//uUt/lrZXIUHWYsYteBvb3aDlHk8tw8
 OeGw7HXRrsC8ndSOiOOhZJtrACdNox6dVtfcm2hd9IeqeSqlCQKUAGs6y7RcDQM=
X-Gm-Gg: ASbGncvK8G2kfMvb6qdTSZSdJ3QK2LUA1yb4vlz5C1BRMnYJHzW0l4E/lB5+GI11xWn
 w+MKoZg+IWS3cVDv56G8fkL0AnDgPnEdeCaB6c6GITreOKkXChzRgxoFkYe7w+59zwGnEl//qgQ
 zfNpsstSngYtK9vHIiPUdR7Xp0h1lsD82RaUg1o8+4F1a0KhKKzRWcWk7DId6Ai81KtqAKRIoOJ
 NUWR3aI9Se8NlP6Bp7MhabhdUsryYq2epzMdi2JxgBuuvQrC8zaTeWvAiJ8qr5EqNCPnvigizHG
 yo+OYL5HzngXDK8ErV/hW4JFQZJ9c1eLgYbSl9JdxUeX3KUaBeQ3qTHWUZ71m50EGX1rDFsz07m
 3E/hlUw8jamWfjQ==
X-Google-Smtp-Source: AGHT+IENRHN0sgfUtG19jACGXfqSywNtI6Ytu7OCF3YUYjbNl0sWaIkEiEjUgy+BPx+vkL3gT9Ha7g==
X-Received: by 2002:a05:6602:4c85:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-8669f9b2694mr134314439f.4.1746139440390; 
 Thu, 01 May 2025 15:44:00 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa584729sm27625539f.45.2025.05.01.15.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 15:44:00 -0700 (PDT)
Message-ID: <fa59ce13-5bb6-4f64-9ab7-adf7d641fbb2@linaro.org>
Date: Fri, 2 May 2025 00:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12
 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-9-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-9-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/1/25 08:38, Thomas Huth wrote:
> The s390-ccw-virtio-2.12 machine is older than 6 years, so according to
> our machine support policy, it can be removed now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 14 --------------
>   1 file changed, 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


