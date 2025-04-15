Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05065C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dqo-0007BG-RC; Tue, 15 Apr 2025 06:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4dql-00075c-Qx
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4dqj-0003wd-KB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744714144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zvtGEAiZIFaknmAurD368DY2mK7BY3UeBwg67boPgFs=;
 b=DEWZv4lD7R7tn9FjSAP5QIWdmxsWtnnIZ4l3ZIyb4a676y65kySCZZEu2k6rJ3gnnVJrmv
 n1ScSkWuoTZvqhhVirvfb9B4KaLZ1/HksSOnx5tMsA1VSwdINLAdyRLg+ihUifrKtxVxVD
 /4+cAl+ewHKXPdlT0VPa9nGaZMSM4HY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-xHcSaUzHO_y4HdvJ4fmduQ-1; Tue, 15 Apr 2025 06:49:00 -0400
X-MC-Unique: xHcSaUzHO_y4HdvJ4fmduQ-1
X-Mimecast-MFC-AGG-ID: xHcSaUzHO_y4HdvJ4fmduQ_1744714140
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39123912ff0so2120163f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 03:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744714139; x=1745318939;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvtGEAiZIFaknmAurD368DY2mK7BY3UeBwg67boPgFs=;
 b=aaE4trD7S6U3EzobfGZdD+JebQuimNabDDu4c1hcYahtV6wpYIuk8lzLZ2di4DN88O
 nGYIo7zEPb8AKx+c50TkFg2PrBU9wePkaC5FmPQT/NmzpIUGO+L10VeCHAtKig/paPov
 XLB59Pap1Ox6apUtM1nBXoqNB/E2ftsKl20fcIxI8lcUHBVkpWZTHRyIJJ/1t1MX+is/
 QqvxKlkNjp6o52AZ04gQZhVNvxlBGk4l9dHA5Cm5MOAGQRPSLPcC7+CIK+f133PUcYJF
 5f2+SJABCKQe65X7qGRWE6T5WxmKR+KSv47op01LavVOG1cW9dSALBkk/vAFN7eV8bo7
 E/BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb8gtb64Z04qQgHlkcvUMLkUPH2yUSLDQ39eDp3R+HuFde/1JI60bpopuljj3TqTWLeYbi1I5SRuaL@nongnu.org
X-Gm-Message-State: AOJu0YwV7xRvio0+l7DEBOqhrIeYhIE0b/Fb4TbIE4Z9onfuuxCEYdWv
 jP51Q8tIWUAW4nMHmeyyBi/EaMsrNJWUtRr87RUQu7/tBZUioNvKuEAri0RLd4Mz7mxxSkG1Boh
 LhX8pVui5VYz6HZjv0t14F61c6ao7yJnnJG6GYgb9jpq7wTZoWCgv
X-Gm-Gg: ASbGncss6ECfbxNsYgcHnJrEE/uE8PEnDCLv1dzFdmVbIjN9fVTdVwD8yJkDuEsRzHK
 03Cluav6gKZx4w/t4eozIU0+UkBLuYtDTqP6AR6uPfgaleYjuVFsWVRpylRjo12k8ATei18hdvV
 aRHMrLelcvZVJZk3BqFOrD+2MA4deJCWs+8NVjhziWYTfruWZtsi9tcsa68FWTkBMw15B8tiEoY
 P9IMt33NJY97MsAOj37j4kHRsBeRbtqB1SVQBo1dbm6XPO8BOkWTSNnQOCNnruvE1VOP0W7baxg
 J8D5/UZlBRgTS6YHtqL20fi5CoakFX1xOe+vqXcNBFk=
X-Received: by 2002:a05:6000:40d9:b0:39a:ca40:7bfb with SMTP id
 ffacd0b85a97d-39eaaed3dbemr14516965f8f.54.1744714139627; 
 Tue, 15 Apr 2025 03:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZfJbtGeYWI/OVSuLFyreUEyPTtV06TxGO+CUFdCey8rvzT3QEPPnao11SvnvW2zugpa57qQ==
X-Received: by 2002:a05:6000:40d9:b0:39a:ca40:7bfb with SMTP id
 ffacd0b85a97d-39eaaed3dbemr14516950f8f.54.1744714139257; 
 Tue, 15 Apr 2025 03:48:59 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf44577dsm13887962f8f.94.2025.04.15.03.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 03:48:58 -0700 (PDT)
Message-ID: <e5e18317-16e2-4145-a433-6958f5f65dad@redhat.com>
Date: Tue, 15 Apr 2025 12:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] python: be more selective in hiding mypy subclassing
 warning
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20250224191152.2123003-1-berrange@redhat.com>
 <20250224191152.2123003-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250224191152.2123003-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 24/02/2025 20.11, Daniel P. Berrangé wrote:
> Use an annotation inline to the file instead of in setup.cfg
> 
> This has the added advantage that the mypy checks now pass when
> using 'mypy /path/to/python/qemu' as well as 'mypy -p qemu'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   python/qemu/qmp/qmp_tui.py    | 12 ++++++------
>   python/qemu/utils/qom_fuse.py |  2 +-
>   python/setup.cfg              |  8 --------
>   3 files changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


