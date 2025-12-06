Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEDDD339BC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 17:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRvoY-0001Y4-GG; Sat, 06 Dec 2025 12:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vRvoN-0001Qn-1r
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 12:11:14 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vRvoK-0000t2-TV
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 12:11:10 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79e7112398so538822266b.3
 for <qemu-devel@nongnu.org>; Sat, 06 Dec 2025 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765041062; x=1765645862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSVRXgFvdlTozpbgIPQVXY+4I3NghqWBB5ikd9iGo3Y=;
 b=APCrK9yza0wP45bdlOUevJ0gf+KHDYilITDfNNyhYWJl1pVVQ6ck28l5xHYjZ1xmme
 qduCT7Cw5sVnFb8gURgJc+htE02ENnSpNxhwPrEwqlFazqBDAgYyW80m3JyldkSYew/Z
 3lMQuQpXnKsIyGlX1xtfqYlGYiPyGDGk0ZHFNhTKjT0bf+v0NYf3c4aqSMuQkZqxDQ+P
 GdIEDAn4Gb2DB1QHwySYQD8+o3G1mE5brb01G3qfO9zPi7/DUEzIFMoO9zNcpNCv5hTo
 S7dsHCumwvrY5le1mc9tn9UXDCHsQo6CLNm83WhGqiCE/p+ZqGUisiGxZ3dhGSTj6el+
 unQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765041062; x=1765645862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSVRXgFvdlTozpbgIPQVXY+4I3NghqWBB5ikd9iGo3Y=;
 b=ZksfLW+x189UhGj5hbrl1NHgCTYXOXxoLeZpzszkf7FKu/rJgzj6n7fWxHzEFuI/3K
 QhJO0qVmWMkWwyZZ9ZLTBWOcA4KsO0mx6yqQgN3nkNYibXQOZlLqK+gm+gqlP8wDu/Qo
 QtLMpaNcLUwaMOC73+YAHwRlyiORAYDBBvEEXCUmJCz+PHbmXXNOaY6coK7cjryUZWLb
 2fGoes6drUg3j7qjfmE+3QLJqPPeYQkFPmFdWjkb7qdKzXXsY425YH5jerRzMQfcLcI8
 KcSd7DHQXeIjVGqpDFU92TEv17sOPCIYpnzTGrGoFfLrI0cO37XyuiK0QYoJP09bkLPq
 Me+Q==
X-Gm-Message-State: AOJu0YwdMqJ0qdbD7AghvOKgnGNK8mcwVX8RZqLW3MEdgdzq18T9gCQB
 6fM0nsW4mpqr7wyeJUPoHMIDKebreuUYqLro8af3uXyDysrBVejW4vgIFaJmOg==
X-Gm-Gg: ASbGncvhzDJgfSF7Xlr8VmCqcQpxnDQVggyMr/dbU0gUmIkc0W9VA1t2y87b/EeF5xv
 l4VeRqr8KjbI5l0E3sH8s4kuoKevpiFbJaOblgSucT49ApY25K+zDJCKzvb/flVr6sAtd6MGmyf
 1Yozmhj4AJ1PDu5SiNpWoENln9ZMbRy664fb0ye2M08RZIGkp+1aYC3Up/Fckoi5+ZdgqV7emVR
 4ztIEhVN6RiZrslxn9EiliEjQVEex1NnxauYYyPltcRR/t5FVwcGKxmWoXSWFxXdTzUhernlB1R
 zr1qViykTKl25pzODvlrHF3ScqtDYo28EveFSZB1T66b7i62OH+UvaPbfvvPwYiKiPw6pyNm2OI
 6jlfB07BRycnpto0M31v4+3aawNbbT9XYg6KqkSTkTYp41U0s50QyzYjZIAhe1hrHLpTkugjGMd
 v0ujeiynQAysCk8Xb8EWQS4grWA0w4xjEJ
X-Google-Smtp-Source: AGHT+IGQ/P6ZqAlQjmQ/3YzOEYJp5UBYi53AGbNpBC89+4UVtoHXytD/CddDtjOcE9bzUPQ3+/Yh2A==
X-Received: by 2002:a17:907:1b0d:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b7a2435ce1fmr282286766b.26.1765041061889; 
 Sat, 06 Dec 2025 09:11:01 -0800 (PST)
Received: from [192.168.88.252] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4457a42sm672762566b.14.2025.12.06.09.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Dec 2025 09:11:01 -0800 (PST)
Message-ID: <c2d79567-6b6c-4222-b1df-550db57ad626@gmail.com>
Date: Sat, 6 Dec 2025 22:10:58 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <5030911.GXAFRqVoOG@weasel>
Content-Language: en-US
From: Andrey Erokhin <language.lawyer@gmail.com>
In-Reply-To: <5030911.GXAFRqVoOG@weasel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=language.lawyer@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 03/12/2025 15:33, Christian Schoenebeck wrote:
> On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote:
>> I was trying to boot from a directory tree owned by an ordinary user,
>> and some daemons weren't happy about non-root ownership of some files
>>
>> Example use:
>> -virtfs local,path=rootfs,mount_tag=root,security_model=mapped,uid=0,gid=0
>>
>> Works with any security_model
> 
> First I thought do we really want to open that rabbit hole and add permission management to the CLI options? However I get why this might be useful for  mapped[-*] security models.
> But for passthrough it is not of any use, is it?

Prolly none, just a side effect of how it's implemented.
Can either make it an error when used with passthrough, or ignore them (use default -1 value) when copying options to 9p fs context (with or without a warning)
 
> Also while it is very handy to have a short option name like "uid" and "gid", for the sake of long term progression and clarity an option name like "default-uid" would be more appropriate.

Or rather default_uid, to match other options style? But uid/gid also kinda match fmode/dmode :\

> The patch is also missing the required documentation changes for these new options BTW.

Haven’t added them yet, wasn’t sure there would be interest in this feature

