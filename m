Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911FED232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve59F-0000gJ-OV; Fri, 09 Jan 2026 00:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ve58z-0000Ye-7j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ve58w-0003sX-DR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767936875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5VNXWek924jdjL1zBZ1pwhuFs2+rEepzeuefkzZqqkk=;
 b=T8GNRTlt9hS9vYrpjLoSTmmCusXYCb4I5UXpSsNWD6ib4/o902sIsnmuuup89HHkF0zOaW
 i0Ce46/xoe3uyEbuZnHyhEHDK0zCS4Xb4XLUBkYFdNJFo4VcKPUytdu5uTH+hH4QlSO+vc
 Qlj75dikIONDAd3zbWQ6kOU7MzQxm0s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-MWlKN3XtMM242oI3AdbgAw-1; Fri, 09 Jan 2026 00:34:34 -0500
X-MC-Unique: MWlKN3XtMM242oI3AdbgAw-1
X-Mimecast-MFC-AGG-ID: MWlKN3XtMM242oI3AdbgAw_1767936873
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8012456296so353679766b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767936873; x=1768541673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5VNXWek924jdjL1zBZ1pwhuFs2+rEepzeuefkzZqqkk=;
 b=YmVa5Rs6Woa15B//GAg2IrvekVUJothwbArhUuatvFB6O8nW2zkCiMs/YJvm/oz34b
 PakAEuXxMP7D528lx07+isneqFbCciObDXXqF1+VJu+gsyFhoXvdPBKzNbxGU6uKXP4Z
 Rr5/jG4bBlADC+0S+U/vCTCVroJoidnTslS6WuLg6k3AcLZYuyGBNkyJ2iawEOjqT7uV
 gaiXeodl5iDOKzC+6p+vDFd2x0RX8HbGRTkMnkK0Bi+g68VQpqhdQ+IRzAjtnLgfiVvO
 Icgtlh5wAKlJaMBPUhlFLHT414UmFfyfQY4AGSe4pCzGpvRLpBLFkEf3deTwRBtd2bSW
 U3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936873; x=1768541673;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VNXWek924jdjL1zBZ1pwhuFs2+rEepzeuefkzZqqkk=;
 b=qBJaxywQjXsLg1wsxkb30ZK7kuzM0KXDzoSRlCyPSdMJBC7Yg+c5nVzyIES0Y6hYuR
 vWe6FxdHwozDeCr59/7yLceSaGIdH9S5MIgon0o6gYAk6nrMortYbNDlhIonYkp3Izyo
 9ByKWvHqf26/gKv/l6TUcZvIgexywmLjT/+GTiOjKo8ib3nV8xVcc7/jYBhHVn50N2K0
 n6Q3kWelG4QsRLTHlpfZ9/ufaNcV4xksKzn//B0pRS2oEIUUwMUzjDe3jye2MQ9VQI5s
 r+kYgFDrvBayzbSTVqxCOawcR536qgET6fIfQEsHadK8CVOAr4u/jxiVkwYiV9Hf1NJV
 DeWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm+qa5s7+VhJCRVvscm2m0C6swlp9c7AGdHSqmXiAwxXKlWAOG255k9zOiKx+g3pCuvD2nu3J5j/tT@nongnu.org
X-Gm-Message-State: AOJu0Yx3sryYKyVQXqkGN+rAySmxBqOxfkOeIO9VWYC9OdZs73xzMnpV
 30aeeB0TJykDGW/ynRjV1Go06WqTOuY3/H6DE7H4PkRNL5OPHx9eg2cFw2ndGEqg96HYF6faPE3
 Yed+cuaitakSGOtEslyQdtlaX7nG2DqpEt163T6s/HENmAPwQu+BX7610
X-Gm-Gg: AY/fxX4HrzCE3iOPH03lA2Dz3Igx/jFjneQqof0qyelDLB2YNK9pw6TyA+MmyPBWT/O
 IWXiIevGNrGk14EAbY8ut7qi5dJ3AfXLiRYZLTuyQAUyI6dBXc26i2wd6H6H7Va9SDzEuhiDOKo
 z8HdUvITwWfrElRK7/+UmSd5m6inHsb0PbG+EQQmEtEt6TOhmClQTZeuDFUm85auIQ/HjsYbMBb
 XZqM00n2TPTeNp2sT1e/QQAjDh2CwO618wXBo0IHb6pQSa+lNZf9Fv6XcqeKfmZBU10zZymb9IM
 vGO2kVSjCA0ZuBr5A1bvi3U1mzQU2llbSLaCqDvLcaUaWCeuIrSnffxC7uuGCtws6KPZdX1+OJb
 NvsFD97U=
X-Received: by 2002:a17:906:6a1c:b0:b73:58a0:e064 with SMTP id
 a640c23a62f3a-b844540cbf6mr865553566b.50.1767936872834; 
 Thu, 08 Jan 2026 21:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCGeprniFlade2vSRmTYcir8ehPy41ksdPyyH7JCZD8LOaoTA03wdzFPGYIZxnpUvvxr0+yg==
X-Received: by 2002:a17:906:6a1c:b0:b73:58a0:e064 with SMTP id
 a640c23a62f3a-b844540cbf6mr865552666b.50.1767936872369; 
 Thu, 08 Jan 2026 21:34:32 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a5118d3sm1019739566b.47.2026.01.08.21.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 21:34:31 -0800 (PST)
Message-ID: <8aca30e2-712b-4eb3-85b6-417537570ebb@redhat.com>
Date: Fri, 9 Jan 2026 06:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/50] target/i386/tcg: Drop TCG_TARGET_REG_BITS test
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-33-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 08/01/2026 06.30, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 37 +++++++++----------------------------
>   1 file changed, 9 insertions(+), 28 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


