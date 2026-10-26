Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48834606A32E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeLfrSCw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fHWEqd7P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLGG3-00083F-9o; Mon, 26 Oct 2026 04:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xLGFu-00081A-VL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xLGFt-0000pL-8F
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793004030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1CrW8x33z9AhnGp+CokjZAy+LS4ExWINABJaFhGB3fs=;
 b=FeLfrSCwPfaigG4JESCjKXAM7H+khZEw2T7SJWZzh9vFvj/U/VzjFgvcV8pm0pBjLahUu2
 m/thhdab4LihRiqWyxAWS24JeDQXhs66vj8NXRDqHHin6gryCuKo7ovBpURPz77Dq43IZr
 OoG2V6aHKxch9FOzv8VJRrsdaHcDXfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Is83kk5DMC6ZB2q0L0L0bg-1; Mon, 26 Oct 2026 04:40:28 -0400
X-MC-Unique: Is83kk5DMC6ZB2q0L0L0bg-1
X-Mimecast-MFC-AGG-ID: Is83kk5DMC6ZB2q0L0L0bg_1793004027
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a4af69e06fso7955185e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793004027; x=1793608827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1CrW8x33z9AhnGp+CokjZAy+LS4ExWINABJaFhGB3fs=;
 b=fHWEqd7PfE/eIWqmuSqkb5xOexh5OqTeLvbpCYpWljCQPOFakONCkyIYtZqmddXmLM
 g5g47RJr0DssCJ0O34jSiJN1WkLXoDwdlfrBwForCnR1JRkGujSu5f90TI4+pa0FTVD3
 ZP1nQ+dVbk6SlBYHQIzmmvtOpx4tr8uCm2T/PpRS4qsseNPc/aPXGYaTBZ50Br5lQP3j
 PElE+LHa0+9ODvJKx4c6Dde9TJCl9oSsG9dnsTaz9Mzqejn0EZ626/C0whaMQUDk9+1A
 lTwiyIPtTdOp4xx36OQhoO3qLh8BBcTOFBRmyt6BnjSPAhhl5aTuwfBHlAYZ9ll2xWB4
 UGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004027; x=1793608827;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1CrW8x33z9AhnGp+CokjZAy+LS4ExWINABJaFhGB3fs=;
 b=UgwyhfNnslnar4tFdFh16iO1N3MSR9esSosYzbNaaUOfSyS/Be0S89RIrauMVDTjm/
 bk8S2XhDhlRBIEOK48OkOrb4vOrUKM1eY6YjEWsVwPfoeGch0S0bLp9TRceXalD5UX1+
 4Frwcg9Diu+nhr78HW9KzJp90mPILD1Grn5htZy8ovJJjt/ixUeHJ6xozyZc8GUe2i7L
 tw/6NtDHjIzLqZiqDRHKXKiMyuRjgFma7sYw2LG7jgVBYLMGdBbjqifVZ3urhyFSsHnE
 ZCNOTVfIq9Z1rhbV9uNEVQwC9zsiQmqSshfGdZcL4+Hq4xo+fHIOR13Vj39Y0QXrmOfG
 pIHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRC9UwfOxmc4KQxogaWgkdMFwx5xvNwqIN5dWfeRzxU9UY4Yu1d100fL9ZlA4I3Ezz8xFLNYVsLj60@nongnu.org
X-Gm-Message-State: AFq9FYIhXB6F7/6/E1ZxPHG2k026HEPxjIqSOufHPV/IMpTUoAoBDGba
 i7SaVNY8ozWxBxTOYcrF6QdwwXpT8fH533fZioTuMBSpw90OZC+RijrMtP8+dUKY858i2CIpdu6
 ztCctuT+w8Q0Ek/Y8VMLjfCLj4yTSx5BhsAHgzzMgBmIWwjJdAYGs2bkp
X-Gm-Gg: AYBFou1ho/YSspBBQkKkEmp1TD20DxA7nF3Wnu4E6Z2LFo5/4/rn9wCSj3XURBRr0H8
 rRS6WAIo4dwu6vM9gQ6gAqqUd5p2FRmsyeI5DdU66aA9qC95Ic0r8K7xnDuvLW8OaOM/wupaJOV
 DkbXBEnV7WIaR2PjaayQTP/TkBjdZlbI3TQs+S5A+w5NmL0BXv+o8DSvW7UI6qeTk71NQQFDvdO
 1XzXB4Eo4AUOs4AtiUMZsNYWaqzix9HPnP8rdgXj8W3n06dv7KTBabWk0VC/3eEWfngmlF0UHBa
 TYBviXqyPbYfT42jEpXvdCUM8bLv9thki2ZiKVqxdbyWgFAnHdcZ2JILPxmgKrmY7/sLocycbkt
 iN1sltYxiSgBluDC8V+Osjlm323IMAcXw3LE/cXHn
X-Received: by 2002:a05:600c:4f89:b0:4a2:150f:160f with SMTP id
 5b1f17b1804b1-4a35aca4e43mr108844905e9.25.1793004027382; 
 Mon, 26 Oct 2026 01:40:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4f89:b0:4a2:150f:160f with SMTP id
 5b1f17b1804b1-4a35aca4e43mr108844505e9.25.1793004026935; 
 Mon, 26 Oct 2026 01:40:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d?
 ([2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e11bsm215049045e9.1.2026.10.26.01.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 01:40:26 -0700 (PDT)
Message-ID: <45364e55-9ac8-4d34-8a98-71bb9ed57937@redhat.com>
Date: Mon, 26 Oct 2026 09:40:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch.pl: Don't complain about spaces before
 Fixes tags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261023152357.1614817-1-peter.maydell@linaro.org>
 <3cd34f4a-ee45-428e-a4e0-55ed6aadce37@oss.qualcomm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3cd34f4a-ee45-428e-a4e0-55ed6aadce37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 17:59, Philippe Mathieu-Daudé wrote:
> On 23/10/26 17:23, Peter Maydell wrote:
>> The checkpatch.pl script insists that Fixes tags are at the start of
>> each line of its input. Although this is where they ought to be
>> in the commit message, it is not where the script will see them
>> in common usage patterns like
>>
>>    git show <hash> | ./scripts/checkpatch.pl -
>>
>> because 'git show' prefaces each line of the commit message body with
>> four spaces.  Allow spaces before the Fixes tag; this matches how we
>> check for e.g.  Signed-off-by: tags.
>>
>> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
>> Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format and commit ancestry")
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I just ran into this myself today as well so wrote up the patch
>> ---
>>   scripts/checkpatch.pl | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 5df266acb17..82f62f60212 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1889,7 +1889,7 @@ sub process {
>>               if ($line !~ /^\s*Fixes:\s+CVE/i) {
>>                   my $tag_case = not ($tag eq "Fixes:");
>> -                my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
>> +                my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
>>                   my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
>>                   my $id_case = not ($orig_commit !~ /[A-F]/);
> 
> ERROR: line over 90 characters
> #36: FILE: scripts/checkpatch.pl:1882:
> +                my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
> WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 471d4930470a ("target-alpha: Set fpcr_exc_status even for disabled exceptions")'
> #24:
>      Fixes: 471d493047 ("target-alpha: Set fpcr_exc_status even for disabled exceptions")
> 
> $ git log -1 --format='Fixes: %h (\"%s\")%nCc: %aE' 471d493047
> Fixes: 471d4930470 (\"target-alpha: Set fpcr_exc_status even for disabled exceptions\")
> 
> Cédric, what is the format we have to use? (why mine default to 11
> chars and yours to 12?)


12 chars is mentioned in the doc :

docs/devel/submitting-a-patch.rst:add an additional line with "Fixes: <at-least-12-digits-of-SHA-commit-id

Thanks,

C.


