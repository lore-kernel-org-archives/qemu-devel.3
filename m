Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DDC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 20:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEx1h-0003Ro-9a; Wed, 05 Jun 2024 16:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sEx1f-0003RO-MP
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 16:14:27 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sEx1d-00065S-3M
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 16:14:27 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-374981661caso948055ab.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717618463; x=1718223263;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XQhYX7vLoEk3suFOzUD1nladi4AnjLy/mr8GItM+3F8=;
 b=EQ6/agGOlsgPOIMAJII3U24nD5oSAYpAzUaP8WPK3tva3T0516+Hn4KOodJNcxCwAz
 DLRgNC7GRknq2AsVVtvIP7qxd3Yog3KCT3z9MfvddNEUa3Wq969kMfrohNhXBIw8lyT7
 loHW47JE6Iexx0XGJDedggTES3Hk8I8KF4YmIUhylVfalhNfOr74075Cd6drEvQoe0DH
 KWbho1yjaI31maGRMvy5jFMCIOVkZeDl4Xic5wQmEfbIt5Tf3zz/x9XSnnigeY73zXbb
 orZITVY86bkZgee/cGDuXCx6EkkRztZ7ZQRF10WR0w3T4uidzfle3fOESbkBrl9lpGdN
 wOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717618463; x=1718223263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQhYX7vLoEk3suFOzUD1nladi4AnjLy/mr8GItM+3F8=;
 b=m5jvIjCurGm3Inqfsch16uLPCNGG+W56B2ql7ufJN5U500s2Yqr+j7+FGdiL/E26m0
 fAjS2bP2aWn7G8CAZUnKrEIbVlgd4gDMoQYijge3peRX7bVcgy1HGJ3G12TQkfqr10bi
 BezBnEf2FBHUsgZEj1rNHfY+k5OKHCfxgPteJlHXXZEYi+TWOforw1l5EGndC+GnGmJe
 71NGgCx4slnZq1CICIbRr3w1xkojQRz1mUjTpt2Q51X43KKrCk1JplVxMtHOyAvfAzDR
 ZOcNM+mN3+63M4WJAuiDvWp4LbnWyTlXNMSCs/jf8qdYQQkj9uG+ljOAXySKYYEUhbRl
 oLYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmBXVvfciamYuIr0qccw+gTLI33eemlp/QPui16LbxLRj0hDb3h9rgQfvjU0A8Nm5Q6w2mdK9YxJ4AnmnXkJHgjWXk9RI=
X-Gm-Message-State: AOJu0YyYDmi4mQb1XAU8k3zIC5NwvDp01ceCWJZuG2sBiIscggdtwRKb
 pzmRj+T/HYE48XJi7TQu7YgXQkpd88freMeu8ko30WNPLx8yVjqDZ0/RRAXZS/k=
X-Google-Smtp-Source: AGHT+IFOm9H3Jt+hdhkaGzjmwEzuHyIiyH8CVNhZBWWM3jDKCN/FylRkWoALYcu+Xq6Sat05+ERBUg==
X-Received: by 2002:a05:6e02:12e6:b0:374:a667:fc06 with SMTP id
 e9e14a558f8ab-374b1ef25a7mr40743905ab.8.1717618463152; 
 Wed, 05 Jun 2024 13:14:23 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c354b945a8sm8777561a12.23.2024.06.05.13.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 13:14:22 -0700 (PDT)
Message-ID: <8a2f0c43-1d48-48f3-8ab2-dafebe252ca7@daynix.com>
Date: Thu, 6 Jun 2024 05:14:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-8-jasowang@redhat.com> <ZmA8r20rrbCxKMEY@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZmA8r20rrbCxKMEY@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/05 19:23, Daniel P. Berrangé wrote:
> On Tue, Jun 04, 2024 at 03:37:42PM +0800, Jason Wang wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Propagating ebpf-rss-fds errors has several problems.
>>
>> First, it makes device realization fail and disables the fallback to the
>> conventional eBPF loading.
> 
> AFAICT, this is not a bug - this is desired behaviour.
> 
> If the user/mgmt app has told QEMU to use FDs it has passed
> in, then any failure to do this *MUST* be treated as a fatal
> error. Falling back to other codepaths is ignoring a direct
> user request.

The FD options are more like an assistance rather than a request. When 
QEMU does not have a permission to load eBPF programs, a user can get 
the eBPF programs with the request-ebpf command of QMP, load it, and 
pass the FDs to QEMU.

A user must not to use the option to pass eBPF programs not included in 
QEMU since we don't have a stable ABI. Nobody should want to do that 
anyway since the function of the eBPF program is restricted with the 
virtio spec.

Regards,
Akihiko Odaki

