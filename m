Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49676C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyp7-0006yW-FD; Tue, 13 Feb 2024 14:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZyp5-0006y9-O6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:52:07 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZyp3-0008Qw-Hv
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:52:07 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-59a1896b45eso1924324eaf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707853924; x=1708458724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+0JkGZyhnmDg6vZHgvKkEql+8YmPfYmVR2dGbwCzWjE=;
 b=coDLi8KpdmiKV6VN9gzxAbtRDcpvnfkW7qIYfooXZzCpYW+3eFNlweAe64FaDUrBzE
 4cKv5PNkVopQw/piveDmoN+0yW7luWiLrPpcbFykwq9/UItFHoSPt22BB1s/gqAolppB
 FwJ7SW891m1fyHtUCYE/ZOArBWcGAmgdIQLdoa1xRsSk1nAqupfNn0GmRsjTIm0mIC31
 jG/yIYdx2c2RRs5gWbtw1e5gKMfyCdsuwhbiv2w/AyBp1hR+ElTP/9G4cB6YDhbp6UZc
 uDpT+cGXH1uj00YxRyeInHXHazuvZqCQz0j2U8yxEEm9/aY+ULAruDsPPICcegbUqAQ9
 bRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707853924; x=1708458724;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+0JkGZyhnmDg6vZHgvKkEql+8YmPfYmVR2dGbwCzWjE=;
 b=NJVpUjd2qWbFo4hOcw7yt/nxF1ZDeq2km2Ewpqk3RiShQKGzMIBHDMnR03byFxbTZL
 c5wRQrMHYiywCHFqVAqE/owHqPLEhRZS819T7rdeP3RV1p7vyqTBUWN/VQiz6okruVOC
 2Pxsrj2QMdG/AQakj7W1nk2nIdddpiPX1YVLgZHWHHtMN3Ixozufa2m7HC+k0VMrcwlH
 P2Xw0H7cYTAoBKKAILNDbSP/3tWfKcvUiNVm/0BbTme1WDBdyw/OMuSzw7qDudtwIOwE
 DXpsek3LfALJvX6DLdWudM9oThdLyzAQ1ENLiD25Pv+I0QCI8R9mr2z5pWa5Yj2yjDah
 X0vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaOhBhrhVyWYotFIomUuWiJ5W3j96l/601ob+f+l3FgDv9mTEhLU6kI+oTL4VP4WFmCDlZhgmZ1d+KnjwTwsohshRa8Yo=
X-Gm-Message-State: AOJu0YyxSvzqBNelQ+mNVLT4NKUejLfVklhm605LTVYS2gj93W73J5p7
 WpvvwmNnOd3/rXDuP8Rqhsk/EnIJElkX60YKML2uigY/NM3DDTc1l70SVw1zuzs=
X-Google-Smtp-Source: AGHT+IGP5U/du8a5ouUQo3lotega7+iC25epOx04LtKS98w9VDTGWUn4d0PIcPm0qI8Yh8+dsA4D/Q==
X-Received: by 2002:a05:6358:2c8e:b0:179:1f8b:445a with SMTP id
 l14-20020a0563582c8e00b001791f8b445amr351305rwm.22.1707853924088; 
 Tue, 13 Feb 2024 11:52:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVOFsQVUEi3y9QfCvFnU/VcuFWnVY6wnf4BnOTVQk7Cs44AB3tO8v9R8VT4Slur9CO+1/R2nTVhIO/vZ/megJziRdPP6Dc=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w12-20020a056a0014cc00b006e04c3b3b5esm7756420pfu.163.2024.02.13.11.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 11:52:03 -0800 (PST)
Message-ID: <927ab2ee-32f7-4a58-a95c-afdb8fbefb6f@linaro.org>
Date: Tue, 13 Feb 2024 09:52:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/33] linux-user: Split out mmap_h_eq_g
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-22-richard.henderson@linaro.org>
 <3f75hcwrqjos5mnrm3yknx2c7ae5pvh6bofbpvfsjbxiinrnnq@wmyrvxma4uki>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3f75hcwrqjos5mnrm3yknx2c7ae5pvh6bofbpvfsjbxiinrnnq@wmyrvxma4uki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 1/29/24 05:12, Ilya Leoshkevich wrote:
> On Tue, Jan 02, 2024 at 12:57:56PM +1100, Richard Henderson wrote:
>> Move the MAX_FIXED_NOREPLACE check for reserved_va earlier.
>> Move the computation of host_prot earlier.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/mmap.c | 66 +++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 53 insertions(+), 13 deletions(-)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index 42eb3eb2b4..00003b8329 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -527,6 +527,31 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
>>       return start;
>>   }
>>   
>> +/*
>> + * Special case host page size == target page size,
>> + * where there are no edge conditions.
>> + */
>> +static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
>> +                            int host_prot, int flags, int page_flags,
>> +                            int fd, off_t offset)
>> +{
>> +    void *p, *want_p = g2h_untagged(start);
>> +    abi_ulong last;
>> +
>> +    p = mmap(want_p, len, host_prot, flags, fd, offset);
>> +    if (p == MAP_FAILED) {
>> +        return -1;
>> +    }
>> +    if ((flags & MAP_FIXED_NOREPLACE) && p != want_p) {
> 
> Should we munmap() here?
> I've seen this situation in some of the previous patches as well, but
> there we were about to exit, and here the program may continue
> running.

Yes, when the host kernel does not support MAP_FIXED_NOREPLACE.
Which is rare these days, admittedly.  I'll comment as well.


r~


