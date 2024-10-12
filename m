Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9343D1A456
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 09:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szY48-0004tm-2E; Sat, 12 Oct 2024 05:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szY46-0004tU-Mu
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 05:05:34 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szY44-0005I3-Ey
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 05:05:34 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ea53eaf604so1077848a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728723930; x=1729328730;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oJVTM4KeOebon4LsFCJBK3/XuqgGRjiKQmCnf89jVCk=;
 b=XNV6sp+avwuer+5RxYya/d8qU8xRqSWm6tiGtXCkiuySzaVVRfzfI+1NGHjjfet+Ju
 YIKtq+tNHMFO5IduEBhjKOB8pTc02U8mVinUGF3YEWM02eI62n/a054VmvjFf0u3qlM5
 pm4QK+/h57zlGtuLGbtLvl8J+P/YVRVY+rZwm6Q/UlC8IwUv+HFPXj8OliWKAClfH2ST
 VAENWSdKl6faJ2MWO4uErC70BMwWnAWlAwnYoRj77bnp2a/CMl9gmfDzVYjIvfjjQaxU
 3BUUwDHf6sQe5EuuXKToOqw4jsPGJBxIs/asF5ZetW11hf4cPRXow3PYVzxyFEPGrIfN
 wKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728723930; x=1729328730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oJVTM4KeOebon4LsFCJBK3/XuqgGRjiKQmCnf89jVCk=;
 b=GWJq4ijyD0KBOIVbVrG3ZiOpJ3mqhdrDMphF9pOMdJou5XW/J3fuKc3aP2tq387Qbs
 35kJu525AwiGgAwMQWwEQWa0+pwvCZmDXMAokb5kTZKc1VcyACRJAoK1tT4cnHHzrxaD
 dCvmjbDHZCFjwkHFXBSYd7AMTF+jeJWccGvky7BmzqygdmwIhOOOAoxQtpIFuv8PMBbY
 +9ORm0NbDu5mQExpjSrX28XXOGviNUpm0lREOvitLaSA+Vji6VdNPBBQV3dYPA2PhDJA
 9mCaLrIipm6gUTe6ErdSS+7Gl0oK4zbCkRHgYn6byt8X5596+z2ZAMUBgaZENPPCjeAe
 fz0A==
X-Gm-Message-State: AOJu0YyZdTm1rhFOvTu9G52lbJ8SbKKe7+TtVZzGShWKwN31TNnTc9HJ
 g/rhw3S3/HpwUe7+NfWOId4bDoiN/5JBC6iYeg+nEuldbuLSm+tS1wgVzC8PYN4=
X-Google-Smtp-Source: AGHT+IGc4a2SDLCJlwwUYfLW1go6NkGeh4wIZHp7yi4F2gr5K+6uHLjVp6/7WUD3DAnlLyeWxXIH6Q==
X-Received: by 2002:a05:6300:4041:b0:1d8:ae1a:4cec with SMTP id
 adf61e73a8af0-1d8bcfc3640mr5341459637.50.1728723930531; 
 Sat, 12 Oct 2024 02:05:30 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aa939b7sm3822600b3a.101.2024.10.12.02.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 02:05:30 -0700 (PDT)
Message-ID: <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
Date: Sat, 12 Oct 2024 18:05:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/09 16:41, Jason Wang wrote:
> On Tue, Oct 8, 2024 at 2:52 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> ipvtap and macvtap create a file for each interface unlike tuntap, which
>> creates one file shared by all interfaces. Try to open a file dedicated
>> to the interface first for ipvtap and macvtap.
>>
> 
> Management layers usually pass these fds via SCM_RIGHTS. Is this for
> testing purposes? (Note that we can use something like -netdev
> tap,fd=10 10<>/dev/tap0).

I used this for testing.

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   net/tap-linux.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>> index 1226d5fda2d9..22ec2f45d2b7 100644
>> --- a/net/tap-linux.c
>> +++ b/net/tap-linux.c
>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>>       int len = sizeof(struct virtio_net_hdr);
>>       unsigned int features;
>>
>> -    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>> +
>> +    ret = if_nametoindex(ifname);
>> +    if (ret) {
>> +        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
>> +        fd = open(file, O_RDWR);
>> +    } else {
>> +        fd = -1;
>> +    }
>> +
>>       if (fd < 0) {
>> -        error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
>> -        return -1;
>> +        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> 
> Any reason tuntap were tried after the macvtap/ipvtap?

If we try tuntap first, we will know that it is not tuntap when calling 
TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ again 
in such a case because they precede TUNSETIFF. Calling them twice is 
troublesome.

This is also consistent with libvirt. libvirt first checks if 
g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tuntap 
otherwise.

Regards,
Akihiko Odaki

> 
>> +        if (fd < 0) {
>> +            error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
>> +            return -1;
>> +        }
>>       }
>>       memset(&ifr, 0, sizeof(ifr));
>>       ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
>>
>> ---
>> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
>> change-id: 20241008-macvtap-b152e5abb457
>>
>> Best regards,
>> --
>> Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Thanks
> 
>>
> 


