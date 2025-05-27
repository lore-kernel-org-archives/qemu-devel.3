Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292FAC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxWi-0000Zt-PO; Tue, 27 May 2025 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxWc-0000ZT-CR
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:51:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxWX-0004hu-9O
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:51:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234b440afa7so4825305ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748364688; x=1748969488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QUZetYv3OXczGvVhpoXJW+0CDSkyqQZirzQKomHGUFc=;
 b=WXxZpqA6+16VQ2QivKvgOGQpfSmVWT0ROvJCVpBPJ+ITmfIddL58Olqx0jYHj8RWGo
 6U7Yth4kle00EP58tXwUN5i9WnNzVPgCy4QocKh27CJfPDQmUBmOYST+r09bh6t/UTAB
 EXZ771rkP6kHGOhvwC5fae9FKAoNHwyYpXixT6k0YxfTRm8nrb2qmzxaicvh3lADWbRI
 XXZzaIcDblEBn++DQIVqgekDPPl074OzR+RzEjcwawiBL+NvoK+vaqVA8EmZjizYh5Yk
 Tp5gGn41cNROgJQCKDSnoY6P4BfV0Q7EyzySnOcih7WOqlxNUVfx9fDGCCw9+PJJvqSn
 mFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748364688; x=1748969488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QUZetYv3OXczGvVhpoXJW+0CDSkyqQZirzQKomHGUFc=;
 b=seKOGjrMRjHOsqbpeRT6caBDGuEpi7qDjQ5tC+cs6mP5yuSjOpwXvZm+Xtoa3hcAbT
 O8L+7UaQSoZBIi7L2r6V0TOhNz09MZeWfL9T1BYuxbT0D+2/3heO1LFhmDer/I4Bs6T7
 gBgi8FtrS+MyleR058BqBiRJ3AeympIK+YClB0GJKXaEjuk9NfOibb+VOAI4CHTjGpmi
 s1zMFfnQSyGeDlJeQhDMtWtcGcKE+W4cnsnqfzbXW+FYEf04YzvCbqmP3gUDuO5njjEh
 i2w69NavKS1jh2Y5cyOSmInuLvcQNwPb5OF8qAwfUYZQxEHd2NIDzKlZO2KSak0IOzc6
 AO2A==
X-Gm-Message-State: AOJu0YwrQBayqEcr5p8FHw04gKdYLFxrAtEDZpTHXBxOc8JQ138R38yL
 eNNYhVxCOzYMXECcF9tHY89gb7x91p+HUhBxNak8hckpt/O+bHe8ClP6kZOxbCEY+BI=
X-Gm-Gg: ASbGncsW9SB4Luate8qkZ5zNyMvecQesbgjGdS35U8fdbd/7OQWmk0lPr0y4ZtD97SF
 eKGENwhfMvZ7074wOowaYyeuYiphAlJj0pQGyOXTdK+UkwmhITxmtE2Ou7qakU+YMb+KqK1n6BV
 4U38sqbZW2ydvuHOJgRcu7lCfyV3gpNsnhaoXAlGQ1CxiU7KYejDmk0hB4NBvzvnBTe/QKmO9wm
 55TbSF1CI8qPfGAeNRYzsmGxWAri2Ry6BtvJ4pSTwenHSM8BKA8ETJk/54WPaj59Bx+UKeXV43Y
 dGV9xibS6/kfZ1Xml0bgdZSHC+J82Oy7Fvh8N1tkYElMKEqBDiNO03X5QqlfBsPN
X-Google-Smtp-Source: AGHT+IHqUcNZAdZq619fXAC2IIJB+38GZ6GGjFqJMT8KXOG0w95YM5cd4jckktOmC8iK5kDC7dtE9g==
X-Received: by 2002:a17:902:d4c4:b0:234:a139:1217 with SMTP id
 d9443c01a7336-234a13914camr33952495ad.18.1748364688583; 
 Tue, 27 May 2025 09:51:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23414e86538sm62521225ad.184.2025.05.27.09.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 09:51:28 -0700 (PDT)
Message-ID: <d2666050-5ff3-4807-87cf-dfaf43ae9c9f@linaro.org>
Date: Tue, 27 May 2025 09:51:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] qapi: remove all TARGET_* conditionals from the
 schema
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <87frgqnr79.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87frgqnr79.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/27/25 6:00 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> This series exposes all qmp commands for any target unconditionally, allowing to
>> compile QAPI generated code without any TARGET conditionals.
>>
>> Based on original RFC from Daniel P. Berrangé:
>> https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@redhat.com/
> 
> I picked a few nits.  I'm happy to address them in my tree without a
> respin.  If you object to any, please let me know.
> 

I'm ok if you want to take that in your tree, and address them directly.
All the comments change requested are ok for me.
I'll answer on individual commits for your questions.

If you expect a respin on my side, let me know (from what I understand, 
it's not expected at this point).

Thanks,
Pierrick

> Series:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 


