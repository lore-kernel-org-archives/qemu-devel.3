Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE4BD15D8E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36zd-00057O-Hp; Tue, 22 Oct 2024 00:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36zY-000576-LL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:59:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36zW-0000Wk-2p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:59:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71ea2643545so3280897b3a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729573171; x=1730177971;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NTttboZdr80Nd4mzu4z0SrXHKG0CYywzMGko7KdeUF8=;
 b=DVX1voYqDal1BMd9z/7a3I1Egq/mJq0e55FfZYbEnoNh9cKraAQarOWyaLIKGV3e9F
 R4sdT+8n0tZ27F+O5sFmy7i0oua7uoEZj0IwPsiL7wPdOE2SK3460AtEcYj7bGHr4Pxi
 36br28Qc5xmZQGBtqhE1MDcf3Jt/NuecaEYnxprV83lZRZYfDtZnRoJqLxugCTQHPWpX
 OgPdnPHLBWmX4SV/meeLpoIJCcy1PDOWhTaIelsivWqTp2sWG53FywQDSiovqPp+EvN5
 8cAtgyKSjGipix1l+YsG9fzaffC/mGTyrjNc9TmGhC2eM3Ow2pDLpXpzEW6CT8omdl1z
 XqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729573171; x=1730177971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NTttboZdr80Nd4mzu4z0SrXHKG0CYywzMGko7KdeUF8=;
 b=gVazUtqotDBTdjIJQRl0ux/oDsyu9hD81TwAJ4ugp2RNvAC4h7W4hfDf/NDPbhC13e
 6Tbu9NXIhA6YsHYE0ZZEjNYlJtsoZ7bnIoYb3AvUFD1nu+TEJhfpUf+CiiiYEXV5SJXd
 FiEMv59Frqv/9jL6y9nZ/A5l+QjNqygAtRKPzZXYWHYJaY0pNh2J6M7nLq6VRw0iE5Pz
 P+GY4ArS0oDagUoZjmKI9Va6VJYvTkqCuIhbGFEAU/ydZoOZC51uz8sOC1WWtinhWFGK
 yvvRZlpjVqCuR9PkwkzfJQ1lAG5RPnEjfAJRSmEGsInxXYQLUZnh+SjTRBzcYz22oaFe
 0wEQ==
X-Gm-Message-State: AOJu0YwSPpEqv4aWVxRIQ1Vd0nnL87FYYJo/e7B14uY0oeL2xjD1tMwY
 A2TB3PFsdq6tZrbuVSBFtXVvFW1s+oTJ/d3/IGWTs2ugfc6elvbF6kRDq0TgTF0G02nO1IqBVS/
 6kg8=
X-Google-Smtp-Source: AGHT+IHrnRkqvZhCntn48N2+vvJf72w6JAHzx1We0xn3pmWjdP7lkS11dZF+eMHmgfXgZDwToGIThg==
X-Received: by 2002:a05:6300:4041:b0:1d9:542:8d40 with SMTP id
 adf61e73a8af0-1d92c4a3118mr19357145637.5.1729573171629; 
 Mon, 21 Oct 2024 21:59:31 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13eab63sm3924051b3a.175.2024.10.21.21.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:59:31 -0700 (PDT)
Message-ID: <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
Date: Tue, 22 Oct 2024 13:59:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

On 2024/10/18 17:10, Jason Wang wrote:
> On Sat, Oct 12, 2024 at 5:05 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/10/09 16:41, Jason Wang wrote:
>>> On Tue, Oct 8, 2024 at 2:52 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> ipvtap and macvtap create a file for each interface unlike tuntap, which
>>>> creates one file shared by all interfaces. Try to open a file dedicated
>>>> to the interface first for ipvtap and macvtap.
>>>>
>>>
>>> Management layers usually pass these fds via SCM_RIGHTS. Is this for
>>> testing purposes? (Note that we can use something like -netdev
>>> tap,fd=10 10<>/dev/tap0).
>>
>> I used this for testing.
> 
> Anything that prevents you from using fd redirection? If not
> management interest and we had already had a way for testing, I tend
> to not introduce new code as it may bring bugs.

I don't know what ifindex the macvtap device has so it's easier to use 
if QEMU can automatically figure out the it.

> 
>>
>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    net/tap-linux.c | 17 ++++++++++++++---
>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
>>>> --- a/net/tap-linux.c
>>>> +++ b/net/tap-linux.c
>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>>>>        int len = sizeof(struct virtio_net_hdr);
>>>>        unsigned int features;
>>>>
>>>> -    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>> +
>>>> +    ret = if_nametoindex(ifname);
>>>> +    if (ret) {
>>>> +        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
>>>> +        fd = open(file, O_RDWR);
>>>> +    } else {
>>>> +        fd = -1;
>>>> +    }
>>>> +
>>>>        if (fd < 0) {
>>>> -        error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
>>>> -        return -1;
>>>> +        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>
>>> Any reason tuntap were tried after the macvtap/ipvtap?
>>
>> If we try tuntap first, we will know that it is not tuntap when calling
>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ again
>> in such a case because they precede TUNSETIFF. Calling them twice is
>> troublesome.
> 
> I may miss something, we are only at the phase of open() not TUNSETIFF?

We can tell if it is macvtap/ipvtap just by trying opening the device 
file. That is not possible with tuntap because tuntap uses /dev/net/tun, 
a device file common for all tuntap interfaces and its presence does not 
tell if the interface is tuntap.

> 
>>
>> This is also consistent with libvirt. libvirt first checks if
>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tuntap
>> otherwise.
> 
> This is not what I understand from how layered products work. Libvirt
> should align with Qemu for low level things like TAP, not the reverse.

This change is intended for the use case where libvirt is not in use. In 
particular, I use mkosi, which is not a full fledged layering mechanism.

Regards,
Akihiko Odaki

