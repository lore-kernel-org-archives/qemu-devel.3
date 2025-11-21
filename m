Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB1DCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd5H-0003MP-0G; Fri, 21 Nov 2025 21:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vMcqv-0005XY-24
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:55:54 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vMcou-0006je-Ie
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:55:50 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5957d7e0bf3so3419749e87.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763776407; x=1764381207; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0P9ALXqp5ahzshqnxDvNgqLa+xNJ7DDRA0CYy777RIA=;
 b=YSkSZIFtUb5KuOPIHMBrUBgNvlxoSmCZhurszPNrdNNSYgp9d2NBhchJ4n/kr76Xia
 qHzQxbVwClJ3vL3sq9Rcq31ZodWGWzm3Xh3TkIxETBJd7BB9a4tFG4Z/5Spq1v2bzJQ6
 3yxZIjnYzwvhD6pv18Vt7k4F3aiSnFU5+LXObJkNF2QNIEuWa3At54lKED33Y55furfT
 FQ9/9dIgaWYNL5AQKWAUcgkTct9GfYIOMWsZgEMoJCzxXRiCaUs/lEU88Q8uhJv6flLI
 cffbFjK8+cGZBf3qkc71+muJxZNxwT1U3sVDu3vYU3QI1XNDmVp/hix74W8dMUSmE2NX
 Bl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763776407; x=1764381207;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0P9ALXqp5ahzshqnxDvNgqLa+xNJ7DDRA0CYy777RIA=;
 b=ps6rJRAPoe8ebcTlA7Frt4a+xnBgAf7HVTSP3Lf6Si5EDRu/Hmwz4N8WmP/xGtX9FH
 f4WyRHJ1gUYjjFhAOpiTqy4Fo70B5e4PyNXkTfSwU69hmkjtZJl+T37nHrPIJmDMAcGT
 ABTBE50iDNQOZ4HP/J5jgx3Q+YA8lK3Z+DtDQaiSbpc7jOIxwibVGttGN8r5RLNv/u9U
 i6JLhpgsrGL5Vvke2N1oEDl5vePiE0iHzmr+o3FvwiMATCUg3jEGydEOiiYjXAUxUWlS
 OdA4vlKu1lsIsRj279WX9h7EVGvw8ju+aasqkK6WS1GJLS5inFAFOdHAP4UzGTOdOCE7
 i+9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkOrlu66cpTVmmYfs8H9tCukhRAhgs+SzzgcNJ6ZzQMeDUq8i85IiG+uT0br8pP5Am6ODMyTdlgFPa@nongnu.org
X-Gm-Message-State: AOJu0YxajHQ6ID5pEHTdSJV9oLtng8mBDdEx31dCD2IXE4qwLDfFQue4
 7s5OqtlbmXvI89AspfqB/KlPkIxvRamnxNosKctcaF0JATESPTr2S9126+dYuLT5
X-Gm-Gg: ASbGncshknNsVhYe40QCk/MidiX1zvffQTDds6EjtqJswgnVjt89/SW5NfRn6puJJOX
 Xt/wxVx0bz5JBWSDMBM7oIidCevDDhuCMrw5YpARb7qK1jj1U2g/JNS6bCHeFycDtQao4o5gBkk
 S1dNaRbr1JP9r8R5N2VH5zIMf4eegXtp6AWsAzBhcNYMX7tvcOYZSEdHmnCYOsf8iJ4AHVhNb/I
 NXAbtvEzQuFUkL66N0d64xmvNImcO8ZtQI/S62ZlvsPSUpHnc0DgQO5fczOZx4YRSgY+w6V/Bfs
 Cl0skpom/t6R7oPKtAnoEToXEHAL0+MHoOKPryL2dKK9JEnZV/lrOiVqrQbVLZtviOol8cjSoo8
 guIbsUUdY8S3uvF3iEqdeukJUXr079tuZcT+3KNDE0wLwHhbEfOKZ5xmsxeTGxpOmkFDn+ga4FD
 hfkbVUVULPNcdtttjo7OTUICgh
X-Google-Smtp-Source: AGHT+IFMF3A2OHmymfwj5r78abovEt3ogVbTrx1PLOqPl0wn2dXoxuaiQHXIHyYF53zZ6ACtdKfhng==
X-Received: by 2002:a05:651c:1111:b0:37a:4277:86f8 with SMTP id
 38308e7fff4ca-37cd802f8a6mr8538391fa.10.1763749936754; 
 Fri, 21 Nov 2025 10:32:16 -0800 (PST)
Received: from [192.168.43.207] ([188.113.219.44])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37cc6bcb8c4sm12339041fa.47.2025.11.21.10.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 10:32:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------9TghQpIqZp4HkljZXvrcyK7k"
Message-ID: <f5fee3f9-9075-4d73-96b2-5d026500e295@gmail.com>
Date: Fri, 21 Nov 2025 23:32:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/9pfs: Follow native symlinks when security-model=mapped
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
References: <5e07267f-b990-47fc-ade7-934209ea942f@gmail.com>
 <13890690.uLZWGnKmhe@weasel>
Content-Language: en-US
From: Andrey Erokhin <language.lawyer@gmail.com>
In-Reply-To: <13890690.uLZWGnKmhe@weasel>
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=language.lawyer@gmail.com; helo=mail-lf1-x129.google.com
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

This is a multi-part message in MIME format.
--------------9TghQpIqZp4HkljZXvrcyK7k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2025 17:20, Christian Schoenebeck wrote:
> Andrey, just some minor issues from my side below:
> 
> Git commit log message should not exceed 76 characters per line.

TBH, I'm not used to sending patches by git, it was just an e-mail message, not a commit message
>> QEMU issues:
>> https://gitlab.com/qemu-project/qemu/-/issues/173 (from
>> https://bugs.launchpad.net/qemu/+bug/1831354)
>> https://gitlab.com/qemu-project/qemu/-/issues/3088 (dup of the first one)
> 
> This should be:
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173

Fixed in the attached patch. Or should I start a new [PATCH v2] thread?

> The other links can be dropped. They are already linked by #173.
> 
>> Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
>>
>>
>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>> index 31e216227c..b4f8be2c81 100644
>> --- a/hw/9pfs/9p-local.c
>> +++ b/hw/9pfs/9p-local.c
>> @@ -468,12 +468,14 @@ static ssize_t local_readlink(FsContext *fs_ctx,
>> V9fsPath *fs_path,
>>
>>            fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
>>            if (fd == -1) {
>> +            if (errno == ELOOP) goto native_symlink;
>>                return -1;
>>            }
> 
> scripts/checkpatch.pl complaints:
> 
> ERROR: trailing statements should be on next line
> #33: FILE: hw/9pfs/9p-local.c:471:
> +            if (errno == ELOOP) goto native_symlink;
> 
> ERROR: braces {} are necessary for all arms of this statement
> #33: FILE: hw/9pfs/9p-local.c:471:
> +            if (errno == ELOOP) goto native_symlink;
> [...]

Fixed

>>            tsize = RETRY_ON_EINTR(read(fd, (void *)buf, bufsz));
>>            close_preserve_errno(fd);
>>        } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
>>                   (fs_ctx->export_flags & V9FS_SM_NONE)) {
>> +native_symlink:;
> 
> Semicolon is unnecessary here, isn't it?
https://port70.net/~nsz/c/c11/n1570.html#6.8.1 Labeled statements:

labeled-statement:
	identifier : statement

Can't be a declaration
--------------9TghQpIqZp4HkljZXvrcyK7k
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hw-9pfs-follow-native-symlinks-in-security-model-map.patch"
Content-Disposition: attachment;
 filename*0="0001-hw-9pfs-follow-native-symlinks-in-security-model-map.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

aHcvOXBmczogZm9sbG93IG5hdGl2ZSBzeW1saW5rcyBpbiBzZWN1cml0eS1tb2RlbD1tYXBw
ZWQKClJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9p
c3N1ZXMvMTczCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgRXJva2hpbiA8bGFuZ3VhZ2UubGF3
eWVyQGdtYWlsLmNvbT4KLS0tCiBody85cGZzLzlwLWxvY2FsLmMgfCA0ICsrKysKIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody85cGZzLzlwLWxv
Y2FsLmMgYi9ody85cGZzLzlwLWxvY2FsLmMKaW5kZXggMzFlMjE2MjI3Yy4uNWNlOTdiNzZh
NiAxMDA2NDQKLS0tIGEvaHcvOXBmcy85cC1sb2NhbC5jCisrKyBiL2h3LzlwZnMvOXAtbG9j
YWwuYwpAQCAtNDY4LDEyICs0NjgsMTYgQEAgc3RhdGljIHNzaXplX3QgbG9jYWxfcmVhZGxp
bmsoRnNDb250ZXh0ICpmc19jdHgsIFY5ZnNQYXRoICpmc19wYXRoLAogCiAgICAgICAgIGZk
ID0gbG9jYWxfb3Blbl9ub2ZvbGxvdyhmc19jdHgsIGZzX3BhdGgtPmRhdGEsIE9fUkRPTkxZ
LCAwKTsKICAgICAgICAgaWYgKGZkID09IC0xKSB7CisgICAgICAgICAgICBpZiAoZXJybm8g
PT0gRUxPT1ApIHsKKyAgICAgICAgICAgICAgICBnb3RvIG5hdGl2ZV9zeW1saW5rOworICAg
ICAgICAgICAgfQogICAgICAgICAgICAgcmV0dXJuIC0xOwogICAgICAgICB9CiAgICAgICAg
IHRzaXplID0gUkVUUllfT05fRUlOVFIocmVhZChmZCwgKHZvaWQgKilidWYsIGJ1ZnN6KSk7
CiAgICAgICAgIGNsb3NlX3ByZXNlcnZlX2Vycm5vKGZkKTsKICAgICB9IGVsc2UgaWYgKChm
c19jdHgtPmV4cG9ydF9mbGFncyAmIFY5RlNfU01fUEFTU1RIUk9VR0gpIHx8CiAgICAgICAg
ICAgICAgICAoZnNfY3R4LT5leHBvcnRfZmxhZ3MgJiBWOUZTX1NNX05PTkUpKSB7CisgICAg
bmF0aXZlX3N5bWxpbms6OwogICAgICAgICBjaGFyICpkaXJwYXRoID0gZ19wYXRoX2dldF9k
aXJuYW1lKGZzX3BhdGgtPmRhdGEpOwogICAgICAgICBjaGFyICpuYW1lID0gZ19wYXRoX2dl
dF9iYXNlbmFtZShmc19wYXRoLT5kYXRhKTsKICAgICAgICAgaW50IGRpcmZkOwotLSAKMi4z
NC4xCgo=

--------------9TghQpIqZp4HkljZXvrcyK7k--

