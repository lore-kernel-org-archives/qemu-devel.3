Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95245C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlSp-0003gM-DL; Tue, 30 Jan 2024 05:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlRh-0002t5-52
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:34:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlRL-0007pw-Gd
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:34:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40fafc8bd6dso558825e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706610839; x=1707215639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=baUqftMoz6U7OXEiwuMNQpJPxz2f90SqVirgLSHQQmo=;
 b=GNPeEUUP2DyI7IgkdOs89uAwVEYf+Kh4gGFBRg21413yY1cRKVeQNSjJaFLNpb5s6K
 danavZaFRniBtDRN+Oqar1CmsixNHj3kPzDAiWBJVAfuZ9Sf1JCoD52yZKdMID5Aze49
 DC6ao+m6KVRZ4rX1v3V6dXZ4GDfVDczz0nLXpwTjk4inTM7Oaiv3jh+Zsr6jMGCu9EhL
 bjmmx5r8uk/SQf7xdVyqmLSBZoCkbdu/IMAoyYlo3H7lBXYBU702mnToaS00mOvuP3/O
 UWDAvO/kl5Db1tTttDEBnZOwwYYj6oh1OGf5P8ZZr/yTdA98GzdBdzpOqvfizuId3etV
 1GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610839; x=1707215639;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=baUqftMoz6U7OXEiwuMNQpJPxz2f90SqVirgLSHQQmo=;
 b=BcoClb+BxK80gUGrWP8vUQuboIuTmkHJu+235In7rLouiPqSdLpNRtvEJeVy3M8Yue
 KtmnV0FV1vaFShKKgDtMQAq1d40oYRZbrvn7ZVNplPgbfjiojPCt9AeZ4iWDvPQ5oEJO
 TJ5PrGLBu4ivpCowqSqp7BAeWdz1ldbW5nJhqbOUxPNgGtsa5fAbCYtN31eiOuZvBzuc
 sBd5LlJ3FJvo/xDM5csjX80V5kKxWuGQ+LBYm/3PkHUy+I8bPgiqfyYyuld/8LAsEiE0
 XzYfnwgZYVT9ervqm4NuxRV34uJdZEJsVel8bIAXnOjpQw51YPZgERahB2kt1tm27iah
 zlKg==
X-Gm-Message-State: AOJu0YyJRXsZXIryQ7fFbQZnB6FGh1/8KCyAXeEXSE2NXnTXexLDmmbc
 xqnijaKi8J+yHLUG2peukRlTAwP0KoaZ7EocnPb0VOBrVjtBkjRIZhbY9uxjBIo=
X-Google-Smtp-Source: AGHT+IH+Lthc4la5q+bEffzJLKhPzAJ9GsSUInTysUBPMDRvxlOd88bYvP0YzW4DHpXmYkUmIrZRkQ==
X-Received: by 2002:adf:e4c4:0:b0:33a:e838:7184 with SMTP id
 v4-20020adfe4c4000000b0033ae8387184mr4937512wrm.2.1706610839625; 
 Tue, 30 Jan 2024 02:33:59 -0800 (PST)
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 r6-20020adfca86000000b0033aed7423e8sm5087472wrh.11.2024.01.30.02.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:33:59 -0800 (PST)
Date: Tue, 30 Jan 2024 12:26:54 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
User-Agent: meli 0.8.5-rc.3
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <ZbjMNZpX9kYyw5hW@redhat.com>
In-Reply-To: <ZbjMNZpX9kYyw5hW@redhat.com>
Message-ID: <82lcl.1qg7az61g8ip@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Tue, 30 Jan 2024 12:15, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Tue, Jan 30, 2024 at 12:11:07PM +0200, Manos Pitsidianakis wrote:
>> Check if a file argument is a cover letter patch produced by
>> git-format-patch --cover-letter; It is initialized with subject suffix "
>> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>> exist, warn the user.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>> Range-diff against v1:
>> 1:  64b7ec2287 ! 1:  9bf816eb4c scripts/checkpatch.pl: check for placeholders in cover letter patches
>>     @@ scripts/checkpatch.pl: sub process {
>>      +# --cover-letter; It is initialized with subject suffix
>>      +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>>      +		if ($in_header_lines &&
>>     -+		    $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>     -+        WARN("Patch appears to be a cover letter with uninitialized subject" .
>>     -+             " '*** SUBJECT HERE ***'\n$hereline\n");
>>     ++				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>     ++			WARN("Patch appears to be a cover letter with " .
>>     ++						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");
>>      +		}
>>      +
>>      +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>>     -+        WARN("Patch appears to be a cover letter with leftover placeholder " .
>>     -+             "text '*** BLURB HERE ***'\n$hereline\n");
>>     ++			WARN("Patch appears to be a cover letter with " .
>>     ++						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");
>>      +		}
>>      +
>>       		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
>> 
>>  scripts/checkpatch.pl | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 7026895074..9a8d49f1d8 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1650,6 +1650,20 @@ sub process {
>>  			$non_utf8_charset = 1;
>>  		}
>>  
>> +# Check if this is a cover letter patch produced by git-format-patch
>> +# --cover-letter; It is initialized with subject suffix
>> +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>> +		if ($in_header_lines &&
>> +				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>
>This continuation line is now hugely over-indented - it should
>be aligned just after the '('

It is not, it just uses tabs. Like line 2693 in current master:

https://gitlab.com/qemu-project/qemu/-/blob/11be70677c70fdccd452a3233653949b79e97908/scripts/checkpatch.pl#L2693

I will quote the **QEMU Coding Style** again on whitespace:

> Whitespace
> 
> Of course, the most important aspect in any coding style is whitespace. 
> Crusty old coders who have trouble spotting the glasses on their noses 
> can tell the difference between a tab and eight spaces from a distance 
> of approximately fifteen parsecs. Many a flamewar has been fought and 
> lost on this issue.

> QEMU indents are four spaces. Tabs are never used, except in Makefiles 
> where they have been irreversibly coded into the syntax. Spaces of 
> course are superior to tabs because:
> 
>     You have just one way to specify whitespace, not two. Ambiguity breeds mistakes.
> 
>     The confusion surrounding ‘use tabs to indent, spaces to justify’ is gone.
> 
>     Tab indents push your code to the right, making your screen seriously unbalanced.
> 
>     Tabs will be rendered incorrectly on editors who are misconfigured not to use tab stops of eight positions.
> 
>     Tabs are rendered badly in patches, causing off-by-one errors in almost every line.
> 
>    It is the QEMU coding style.

I think it's better if we leave this discussion here, and accept v1 
which is consistent with the coding style, or this one which is 
consistent with the inconsistency of the tabs and spaces mix of the 
checkpatch.pl source code as a compromise, if it is deemed important.

Thanks,
Manos



>
>> +			WARN("Patch appears to be a cover letter with " .
>> +						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");
>
>As is this
>
>> +		}
>> +
>> +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>> +			WARN("Patch appears to be a cover letter with " .
>> +						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");
>
>And this.
>
>> +		}
>> +
>>  		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
>>  		    $rawline =~ /$NON_ASCII_UTF8/) {
>>  			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
>> 
>> base-commit: 11be70677c70fdccd452a3233653949b79e97908
>> -- 
>> γαῖα πυρί μιχθήτω
>> 
>
>With regards,
>Daniel
>-- 
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>

