Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A06E91291
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuvA-0002Qf-Vf; Thu, 05 Feb 2026 03:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnuv9-0002Pe-Jd
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnuv7-0000DD-8J
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770280859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J3gp0Ln3yxPXhScx4NkJWpeRWvK5HQsQPhjbDIHsDsc=;
 b=KwZDwEgm4QnCet6uVlLQVYZT8nMC1QJhmSWsLQ23LohgrwFrY0MvTiaEp7JFlnYJcXgNrE
 h9GLDijPYGfzGeAe/jzBeVSXuKUlmxmaSTtNo5Khe8/rGu/GiD1MtyjdBnAJbLhi2TPyvz
 E8oZNxx5mQ9vusHFGT0YWH142Os4dlA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-89fXqNaEMhuPYtJB--c3Lg-1; Thu, 05 Feb 2026 03:40:58 -0500
X-MC-Unique: 89fXqNaEMhuPYtJB--c3Lg-1
X-Mimecast-MFC-AGG-ID: 89fXqNaEMhuPYtJB--c3Lg_1770280857
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4cdso728544f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770280857; x=1770885657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=J3gp0Ln3yxPXhScx4NkJWpeRWvK5HQsQPhjbDIHsDsc=;
 b=jGxXImy/McSe1zr9y5EzD8vDzmXWhXjVletwYbahDRti27xbfg9SkshtOZhIHJefQV
 A2ersRX6GwME670vdE0gCPARGQpNO3jKjz9iyOPn/sozEJbPbOWYW4nQ35VZVUntV+9l
 rzwvGZnlg3meOIRVd8rZ5pwO8SoLuWneeRHATBWXER8D8ayv8PFt0iSAKUGv7NUX5J8S
 wYCmqi56wgW78MFWKO7w2oC5m8tsE0JrzpGtd02ujalYj9wRUOE1fE0PYZTzRaVu8JDr
 WtMG7iEUnGg9fbZwpehXD3kqdmH5S4YBzEUYiUiSV4kFqx8kleSF6jIWtaomiEAL3TEd
 A7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770280857; x=1770885657;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3gp0Ln3yxPXhScx4NkJWpeRWvK5HQsQPhjbDIHsDsc=;
 b=eoWJpwrvwjneu0+Rmzt4SQ6ajtqWFvAQpHAoXS2AxTeQDbcebtKFkbcAaxZJhPCVAo
 25zdRBs0LhdL+bn8sQJbNKQWbiqjPVS3EXht37Elm2hBAif6zywevmw1K8hg2mifXfii
 K4b00lYmrd6qIVLUeUxKss5a8Yp74JeXP7ZKYoG1xYKHDzQjQOuGa8zREwl8CokO6juv
 ZNI4IMNMHMyftsxH8ey/Yz/FvEVdOzxCLUS2PYgxOtIMF6pS6fddNh353We5Kr2V6U7P
 bi5K2FGwyKGrUd+Mlc6AW0fg7cL8LqJHgjoLvqDsAQrmFgtUOND0vXmWvjLyy6xm8Mm3
 VZlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbfuUrQTZeo0vEf5L2F2fWUXALMmtHRdg0xhDB/0+0F5940hZgBt3q7wDCdL1C6/KGCytd/QL/1Lc9@nongnu.org
X-Gm-Message-State: AOJu0YyAoMeG0eWqQely/k6Xdfj/ItvKksKDKTM/Ua8PKXgtISBmz8rf
 ygXvWNSsewR25PEvon/WHlqg5XNCb25StbOWJR8GsBc0/2kUYL0xrqkH+AJyxyz+Aw48wASsWoO
 Hh+B79XhE3HUM62DoFsZ1HlWsj0SxW+qRH0RiYnmnmp6j/iyB9/J3VD7b
X-Gm-Gg: AZuq6aJeMeVwUexSUNWFtZno9s8hRRb4Uy50+ZpfakKlXmFgIADP9I2xtMKGQ906W77
 aO2tHJ6Sb5o8ztbNR9nePsDnhA6GXoDPE2IfaGgyc4wbhAI9gsHC+Wsa8n1fqjB7+c3IZY4mki8
 SEKiF/XDNSKRwEK/KBLDkOtG0y1rGtQHP4cvu+mGEBFvz7y3Jz/hyTXffQGNxlUdDL+8mbnoIOF
 3CO5DC/Dsrk//kVLgdlOG1QlruYZBHIUBNcKRN1JeGAqCrgqRB2LDTWD2ex6VpUBbHoPH1s1cJ6
 P1Nm4V8IKvssjOuOpBLVKePCHj2mJXrZ5pWa/TQvz8K5RHam6ccZs0V3MLC/spni7JMJjnlQv2w
 lu7pimlU=
X-Received: by 2002:a05:600c:8712:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4830e980229mr81114375e9.29.1770280856735; 
 Thu, 05 Feb 2026 00:40:56 -0800 (PST)
X-Received: by 2002:a05:600c:8712:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4830e980229mr81114105e9.29.1770280856326; 
 Thu, 05 Feb 2026 00:40:56 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d835f0sm39795085e9.14.2026.02.05.00.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 00:40:55 -0800 (PST)
Message-ID: <31a839b6-2396-4b95-88c3-8ccc82cb42be@redhat.com>
Date: Thu, 5 Feb 2026 09:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Switch to my NVIDIA email
To: Raphael Norwitz <rnorwitz@nvidia.com>, mst@redhat.com
Cc: raphael.s.norwitz@gmail.com, qemu-devel@nongnu.org
References: <20260204194923.17704-1-rnorwitz@nvidia.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204194923.17704-1-rnorwitz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/02/2026 20.49, Raphael Norwitz wrote:
> Signed-off-by: Raphael Norwitz <rnorwitz@nvidia.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b7ed4fccb..92808fe5f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2789,7 +2789,7 @@ F: tests/functional/aarch64/test_virt_gpu.py
>   F: tests/functional/x86_64/test_virtio_gpu.py
>   
>   vhost-user-blk
> -M: Raphael Norwitz <raphael@enfabrica.net>
> +M: Raphael Norwitz <rnorwitz@nvidia.com>
>   S: Maintained
>   F: contrib/vhost-user-blk/
>   F: contrib/vhost-user-scsi/

If I've got that right, enfabrica has been bought by NVIDIA, and I can 
confirm that Raphael's old mail address at enfabrica.net does not seem to 
work anymore, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


