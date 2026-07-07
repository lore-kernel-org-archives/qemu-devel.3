Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA8C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2jR-0005ww-0N; Tue, 07 Jul 2026 06:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh2jP-0005wd-8o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh2jN-00009o-Ln
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783418924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EALeJ7ciJp4A4HhTfSbRQK0k7Zid7nuJPHOXi+PqNEU=;
 b=TNzHQjsGK8YuBQBkhCCt2vE5vkglmsigI47VvBqFdgpMb5qm+Z73+sNWO+1jbPMcUTBLfF
 PLIfPZUDCuGsrXZQPF7wa4m76vrxcSMHWwhEaeeS0Ggrtylq6PlesMlX76J/DVc5fL60mz
 DM6eAFPFABW6jlMJhCeHZvzSjpKv9rQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-2ZkQ4Zu1O0uGHgx5A1oXAA-1; Tue, 07 Jul 2026 06:08:43 -0400
X-MC-Unique: 2ZkQ4Zu1O0uGHgx5A1oXAA-1
X-Mimecast-MFC-AGG-ID: 2ZkQ4Zu1O0uGHgx5A1oXAA_1783418922
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473941177b0so3669202f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783418922; x=1784023722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EALeJ7ciJp4A4HhTfSbRQK0k7Zid7nuJPHOXi+PqNEU=;
 b=Sri1TtwASh56ykmul6773iUZBZQzw4LGwkE3mJ/yhOtv0fYmxMJ4KJ5/XVjU3hZ6wo
 OQ3yV8Lqf7zt8wdo0lFUP8MfnWfQp584+qycpV2upe2rNYGQSZ+jxEYH+DXm9vmCBtiv
 QpJl77B3p7D2fS8yP0fANi95+LjpQUdnJG3U5ocYXOJUNHxT8hIdF3i95MlzEkUXHL4m
 pZtxdkpuvR0pKfLRjnHG3ukVMwb8yP8eH4BX2Pqoe0XFt53NbHvMe5OqtToIUY32FePY
 0IWrW5O05zGYVzX4s8pwyODsYoBO4Aed3oxEhBDBfyFMQ41tAhwUpOFKYbdjrz7aDJ0Y
 qjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783418922; x=1784023722;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EALeJ7ciJp4A4HhTfSbRQK0k7Zid7nuJPHOXi+PqNEU=;
 b=SdA10GLM9zdBu66XjUJInGDOfknAzOrS0yOXaYTiW+fVilYJRs3LOmhnHcfCN1Y3vs
 Id7pcze880PVadt7+Wm+2Ng2bU8pOEMirXVpt7s1vYH/K0HUZ1fas8/TSkwFD8JpZMo/
 IkPI6kpWPn0qyAqhCd2KPS5idtATIjNNehfkIgHHx72Elsp0cIjEJt34vKumvY6G41rP
 TIZW6mkZHbRO3hQ5yXA4AzyIUZqVd1h00JpOdwY1ITJlyQxHkO6K9iVwJKZtAFmBh/t9
 ZVWp1rDmF0Ajvg7WfxY9ykIFeCmv9VIx6OATbUCE/5z6zkwiPVQv65dyWxEVBuC+lxtH
 Zelw==
X-Forwarded-Encrypted: i=1;
 AHgh+RohitWA1U2IFT8YY6xel7KCG5FrOaUKK/3vXCh1tDDK/wBBPjUI+tI3XsUCJb1yZhtyGp1YXYReDaja@nongnu.org
X-Gm-Message-State: AOJu0YwP49JyjnPtxKwZcgUi+DFBgjxHB6Cj8/jj3JtSTe/bhrAa/VYE
 WeNpQRPVSNAKOC0WiHePA4AwEn+A9MNRuD43UFtTwsf2U6FV4OHdZZsFLOsbQDzcDgc5jLd6IOP
 XsZ3rc8bAoOYBIc6l+SPfbOEPZ8P7AMaIuuUF91/bVaszXo8FwJvktjWrBrWZ/ssQ
X-Gm-Gg: AfdE7cnxkBkFtGv/Rykda/Vhs79FJb1oiyEYzWTPMPbA4lNPcuQnpneUmeOvBFZWGN4
 BrPLmeYncPN5pTbapqdPFHSJPPNQJUXrUdSkP+UNvi5meiGcgiLHmSF8tncG8k1KdGS4DXowdwX
 sX8q9Vyk6KMOxJ9v8N7hVXHotRr4UvBKZKxPB5gyuXwLyyyrzA4m0WK2yMPdfh4lMrDe3+Ex9E/
 IOLDM/bO4Btx15kBwCIdDP0hppImOG2BK77GPjP38Zvf30pViX2uqZIN6vA4GF9SCqu/KogW8Nm
 2f8nC6hTKyTNauAOapl+1MSUNdD8FsBwmZlka4AO5JvwuVy2Ci+s+fivmIKswY0xqtCpoXT3UdQ
 FPALBJw==
X-Received: by 2002:a05:600c:46d0:b0:493:e034:a3b5 with SMTP id
 5b1f17b1804b1-493e034a3ecmr29828325e9.24.1783418921760; 
 Tue, 07 Jul 2026 03:08:41 -0700 (PDT)
X-Received: by 2002:a05:600c:46d0:b0:493:e034:a3b5 with SMTP id
 5b1f17b1804b1-493e034a3ecmr29828055e9.24.1783418921347; 
 Tue, 07 Jul 2026 03:08:41 -0700 (PDT)
Received: from [10.22.2.34] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm32942475f8f.22.2026.07.07.03.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 03:08:40 -0700 (PDT)
Message-ID: <44f185f0-0107-4a08-91b9-631981009f51@redhat.com>
Date: Tue, 7 Jul 2026 12:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: Do not list -enable-kvm on MIPS binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Miao Wang <shankerwangmiao@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260707095723.36591-1-philmd@oss.qualcomm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260707095723.36591-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/07/2026 11.57, Philippe Mathieu-Daudé wrote:
> When removing KVM support in commit 630decdfccd we forgot
> to remove MIPS of the '-enable-kvm' option help. Do it now.
> 
> Fixes: 630decdfccd ("buildsys: Remove MIPS KVM")
> Inspired-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   qemu-options.hx | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e44b47de681..ccb71743ee3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5163,7 +5163,7 @@ ERST
>   
>   DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>       "-enable-kvm     enable KVM full virtualization support\n",
> -    QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
> +    QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_PPC |
>       QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
>   SRST
>   ``-enable-kvm``

Reviewed-by: Thomas Huth <thuth@redhat.com>


