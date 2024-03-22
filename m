Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F586C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 11:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rndQn-0005GG-Mb; Fri, 22 Mar 2024 07:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rndQm-0005FQ-Gp
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rndQk-0007Zj-6h
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711108283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c+MhZzsQ3nfnPscuYpKrUsimAvR86kvlI2svcxdjtKo=;
 b=YQMYhP67u8njhYB4+tK38WviHnGAHC3ELkWTyygZJrmCZqR0MFVhcHxkDm7BY7ECqTYATr
 vcGusLFPgMOa+vGvw8lpSKiR2GszKN1+giMEytTIjtUU1WLQ/OwnCDoCTCId8/renM0jf5
 92avQz4nolNdpOqX5NaZic+/N+PpmS8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-TEIAWZWGPoqiWa59Jp7czQ-1; Fri, 22 Mar 2024 07:51:21 -0400
X-MC-Unique: TEIAWZWGPoqiWa59Jp7czQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513e50a5aaeso2246760e87.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 04:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711108280; x=1711713080;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+MhZzsQ3nfnPscuYpKrUsimAvR86kvlI2svcxdjtKo=;
 b=W/+P/mCpJ8D/X8+kOxr5KvHluDLBlAVr7JJbW+S4ZiudJV/qTzjBxCH2//Vw4DM7p6
 bp6kfvNmlXuM7HFnX3PoBIc6lLbAG/CJomZfupA7n7fSR0B8BIAEPs7A2jhpyExExo6i
 76uByNgQEN32fA1afa+2hmOJXGJHEI1DpqpWURAKCOmLizvRspWpFMzxWQTBhJFcmUEP
 HpPlomZsORKYcqkRbAU3SwrjlFoxg34ye945nNdb74MUgorbXoSfAub2MbTtmGrQzQPh
 jeXIIlIrSpZY9JpduPzWE8esBo8JvRc3uMVQ/F8e5ssw3rLDBGTNgOH2zChFLhYLjVTx
 MCeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFsmHlc7ncm4tmldkifmGiBcSwZ5wAjrdFOzYrpgy2MdxEX/Wy5ZeBamYSb71pRzfG2Xd807YZ8nsWFVAlmIYfl7hBd8E=
X-Gm-Message-State: AOJu0Yxa3/flGqWmH3gDxNLS+QTxdvoaWkxTlV2MZx16PJsqOiE7cNw8
 4G58ObzP0HWqW1WHgqdYBPuc4pYnU9+waQ95TcsJcSUG5JAsN3CV/Xi99QKv4XchL5ZTvoFausM
 D/CAIGj0wuR5B/JU6YS8pkHDqKsHTBHJPqo7HV7IEyfEpgpjgtClf
X-Received: by 2002:a19:5e54:0:b0:513:cd70:8db0 with SMTP id
 z20-20020a195e54000000b00513cd708db0mr1383959lfi.65.1711108280258; 
 Fri, 22 Mar 2024 04:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYwRH2oeI5u3MfO89jve750zjDlh/NOT+HaBJljGem7Nci95379yCTfsM/PR09Vtt2FcOVQ==
X-Received: by 2002:a19:5e54:0:b0:513:cd70:8db0 with SMTP id
 z20-20020a195e54000000b00513cd708db0mr1383948lfi.65.1711108279876; 
 Fri, 22 Mar 2024 04:51:19 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-50.web.vodafone.de.
 [109.43.177.50]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c511400b0041477f95cf6sm2857786wms.13.2024.03.22.04.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 04:51:19 -0700 (PDT)
Message-ID: <d9989432-bdfa-40ce-b161-58f8c4421de5@redhat.com>
Date: Fri, 22 Mar 2024 12:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/unit/socket-helpers: Don't close(-1)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240312183810.557768-1-peter.maydell@linaro.org>
 <20240312183810.557768-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240312183810.557768-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/03/2024 19.38, Peter Maydell wrote:
> In socket_check_afunix_support() we call socket(PF_UNIX, SOCK_STREAM, 0)
> to see if it works, but we call close() on the result whether it
> worked or not. Only close the fd if the socket() call succeeded.
> Spotted by Coverity.
> 
> Resolves: Coverity CID 1497481
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/unit/socket-helpers.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
> index 6de27baee2e..f3439cc4e52 100644
> --- a/tests/unit/socket-helpers.c
> +++ b/tests/unit/socket-helpers.c
> @@ -160,7 +160,6 @@ void socket_check_afunix_support(bool *has_afunix)
>       int fd;
>   
>       fd = socket(PF_UNIX, SOCK_STREAM, 0);
> -    close(fd);
>   
>   #ifdef _WIN32
>       *has_afunix = (fd != (int)INVALID_SOCKET);
> @@ -168,5 +167,8 @@ void socket_check_afunix_support(bool *has_afunix)
>       *has_afunix = (fd >= 0);
>   #endif
>   
> +    if (*has_afunix) {
> +        close(fd);
> +    }
>       return;
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


