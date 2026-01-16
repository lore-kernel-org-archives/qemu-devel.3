Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82701D4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgexV-0000mT-FR; Fri, 16 Jan 2026 03:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgexT-0000m1-Vm
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:13:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgexS-0007Cy-Jn
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:13:27 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so875815f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768551205; x=1769156005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QUEsYDrAGzO73vIlE2XGwPkTlHQxGzzyCROJHRymws=;
 b=WvijHV26Ye+GgAZW3AuZ2ckNdgR4bLNJ3PU226n3D0mc5nSbIxdrL2IGjJhA9i5wE7
 gT3e6VAcYYRvmZCFT00xv/7VhMP7vVx7eGWcHfgEC1jtpi91X9944EzSpZrYgUxR3fcy
 KqT6zu7YjzIgAmEMAx+cOfwTJ7IthErap2/vy/XuyT+OWPQz2EAFFvKA6uY4y0Hvfwwa
 SuD2Yckm42kOYT70Cpksyah0bpiwJdEPx4Kza1es0xE67qlnI1YMBUU3WLyXj0Lok58s
 1lz5/2iSIgCvQppi9Lr2+AFg5GHQ3id1eqKz1DmIADqXOU4snAY6W1mSjh/UTf7jzm11
 C95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768551205; x=1769156005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5QUEsYDrAGzO73vIlE2XGwPkTlHQxGzzyCROJHRymws=;
 b=AodmfRf5/3rc1GB+ef7nnGzdgkfrp5WJr10y+eLW1RCIMOm5gO6+7hzvQLPQYQG6x4
 e+EMg/R3kiiCgL+IIaYpkS7qn7qegX66Urd7TQtqSEzy3+sW7zq9QPecHiRx1Nf2BuCK
 jBtYxTKZW5DSCh4ROGiUqZdqMgJ8+yphfua8ZckUiTISt0Samjk13YlTOrA5JIboP63E
 oD0d5VnqWAbJ2iP1DkCrJqNVLdJYr3FioSVj9yKhEkHQmz/OLaif+skaFaRpdSoqtrAi
 iZbWonI1ng1pLL9z9copkltKAux2OUsvuQY28cANvH8yMjPgh/ndU02yuUKwrhzUtiFT
 hkrQ==
X-Gm-Message-State: AOJu0Yzo27wUpGL+wajuIUaSLrdrs2OzMhx7nN1oNIh0/wBHT4yKqgzg
 eTfKusTcles5iTun6A63FHpOLkzrDqSQsJY6NHFfE4IdkzqvIYeQCW7e3D2J8WENRtQ=
X-Gm-Gg: AY/fxX6+zCGwdjZFKn9+McsGUlclNeRjRM/5HKhDPduCCCgaBNMSCU5YeJlV9oapKeM
 u6IOjL3B2v4Zdy6dmjAhcUybcgyJRuuB4rH8SuWqzBQgUq26oYQBuTAR4LlAArgV+5eYI1NLHrj
 gLhJh0RmaN9ua+iXWlH7wtHfuysCvNvvD6J9DyBCywba0G93g3IpkmaANt6XVFZLuu+5nwj9quH
 s0KxHcn350KQhVgkjP55CRq6bkkPSUJu0BFGevKXOAv2+yqYzrElA/umpYiOegJnr2DTLAYG5Pp
 NUCZjICGIqYCjcnFs/7yX4WYxneH59Qwc2Fvqmuk3BYPo8i8p8lRF4S93qzPg9r0shY6geraunW
 MZQy3GVcu+bSf+WIK2RGi3BdsZpIHpvUHTsSIdJAFC5Z9Qgg17PLRfAeVmRZl+hCF3n6/c+WfkS
 8c/90PBzAGaiErbuCoKaVkVGrQ12Smz9E+D8cee6vEDXtqffJLWn4Vog==
X-Received: by 2002:a05:6000:1787:b0:431:397:4c45 with SMTP id
 ffacd0b85a97d-4356a0673f2mr1832963f8f.59.1768551204820; 
 Fri, 16 Jan 2026 00:13:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm3876605f8f.6.2026.01.16.00.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:13:24 -0800 (PST)
Message-ID: <024e32fe-1110-4b63-bef8-f492671cae4c@linaro.org>
Date: Fri, 16 Jan 2026 09:13:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hmp-commands-info.hx: Move definition of "info
 accel"
Content-Language: en-US
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
References: <20260116005050.376616-1-dave@treblig.org>
 <20260116005050.376616-2-dave@treblig.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116005050.376616-2-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/1/26 01:50, dave@treblig.org wrote:
> From: Markus Armbruster <armbru@redhat.com>
> 
> Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
> inserted "info accel" in the middle of "info sync-profile".  Move it
> behind "info sync-profile".

Oops...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hmp-commands-info.hx | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

