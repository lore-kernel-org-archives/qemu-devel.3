Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176D2C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 09:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFBq-0004KK-8z; Thu, 21 Mar 2024 05:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFBo-0004KB-Ju
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 05:58:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFBn-0006o7-1V
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 05:58:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33ec8f13c62so540755f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711015101; x=1711619901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ZtyLFOPB9MjhJzNZy6X5uE9fGTY7A6ngsKAHuC9TJk=;
 b=HCrUzFABzP1yxWjY+gEgwvQ1OXy/RaEosys4h1+67fRRR+Qm33JAGJc3szwsbkZriQ
 eI3FsXfosX9P8/aSk5STW544FErm4ZNrfn2W1xbMuQfMY92htgO5rsne3c/brIHMwHK8
 UfaDQbVY05QAHgFaR471IdBcnVW7Qv8pf791t6rsMF/S4GLUF19420EOqlhsJBDXl33v
 faUkNtToVRV/pf9+cl2GwSO/L6kPy91RZdkndvy7IjqxqXab3KS16ieqTSDi/ivVwCZ/
 z9VUH68XbJpddDc/NSqNPqZU/um6x1kOvwlZPGiI+TwQ2wIX5U6MVcjSLpivXMH6xm5h
 cLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015101; x=1711619901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZtyLFOPB9MjhJzNZy6X5uE9fGTY7A6ngsKAHuC9TJk=;
 b=WhkugJHjLEVts9z3B47sN0T+Sq6lSo7Db6202t9yyatP4BWR3jup8dBzNt0lAkdjRL
 BUdNhStKRNBwXlOtWjdPkhXH/ADQdlqlXZ/0wu0dnM6K5S2oZ2nCJj6Fvd6d97e46l3b
 Z9iXLG//uG8wwNj2Zspy2QFvxD5Fw+3iijbI4N0ATU5cHGSOTZVv37EfdZXlo61tGUTT
 N2wP34V+E2YuWjW5BRMb9l0eE0egQ1ujYkxRXXTF+JUA7D2+GoyeoVDC6+N0UIl3uIhX
 qAbkoatKwOLojZVcXmk8Aw0mzKBIqpW91DHRzUWgydb+zWIZIcOuUJ6qVPkshU/eatDy
 znGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjSa2+N39z6HZF/ZYdwGZWzcsNlLMi1LpKqFjsQZZ2QUAo5/slTwY/kqZexIn5GHG4uuAmpNgNpHxzErfh6LXld/lqhMw=
X-Gm-Message-State: AOJu0YybbRUUvxTsxEjnOCtnVvgMAe/9VwYZLdeY7WffNI0XGTxq/DvF
 /aeZEgZZKf/k0H1A98j7AvVtv0nVb7vul0oMLI4gyT7uyHOYjfS5XncreUHbWOxVMEFRDcOFG7V
 0rjM=
X-Google-Smtp-Source: AGHT+IHnTBotA0KDNZBTBoX1xqLZ4BD5aimkGAvvi2IO3129+bqffOYJXGcwsRXxZDigop3sQfB4MQ==
X-Received: by 2002:a5d:4a88:0:b0:341:8c2e:5001 with SMTP id
 o8-20020a5d4a88000000b003418c2e5001mr1144921wrq.64.1711015101125; 
 Thu, 21 Mar 2024 02:58:21 -0700 (PDT)
Received: from [192.168.167.175] (10.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.10]) by smtp.gmail.com with ESMTPSA id
 u3-20020a5d6ac3000000b0033dd2c3131fsm16802094wrw.65.2024.03.21.02.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 02:58:20 -0700 (PDT)
Message-ID: <4322e0ae-ea2b-40b5-95dc-5f9b2049aacc@linaro.org>
Date: Thu, 21 Mar 2024 10:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ui/console: add methods for allocating, intializing
 and accessing QemuDmaBuf
Content-Language: en-US
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
 <20240320205018.3351984-4-dongwon.kim@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320205018.3351984-4-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20/3/24 21:50, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This commit introduces new methods within ui/console to handle the allocation,
> initialization, and field retrieval of QemuDmaBuf. By isolating these
> operations within ui/console, it enhances safety and encapsulation of
> the struct.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>   include/ui/console.h | 10 ++++++++
>   ui/console.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)


>   void dpy_gl_release_dmabuf(QemuConsole *con,
>                             QemuDmaBuf *dmabuf)
>   {
> @@ -1145,6 +1199,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
>           if (dcl->ops->dpy_gl_release_dmabuf) {
>               dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
>           }
> +        g_free(dmabuf);

This makes vhost_user_gpu_handle_display() crash, see VhostUserGPU.

>       }
>   }
>   


