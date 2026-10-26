Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC7606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wc6UdTw4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RhhLDKqx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLGL7-0000u4-JL; Mon, 26 Oct 2026 04:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xLGL1-0000sV-J5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xLGKz-0001Np-TV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793004346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yfYrZIeD2gITpIz98Xsd6o/5OxQ4hhdiZ9+RqIo2N8=;
 b=Wc6UdTw4VR70o/2BoXnMV9C470xcegQcl7QLoHjdHs10pe3z3JbN9oV7p6c864yCCUA7g0
 C20GXISY8SuPSX1y3KWI4raCW2cmlw8Cv3l1AcdptLj4GcZGdg0GD4zET+9Tc8uUafl7/p
 e1tRp7iHOQnKq1TDopWkbY4L83vbm+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-vExhaBgFMriuUI0XP-fckg-1; Mon, 26 Oct 2026 04:45:44 -0400
X-MC-Unique: vExhaBgFMriuUI0XP-fckg-1
X-Mimecast-MFC-AGG-ID: vExhaBgFMriuUI0XP-fckg_1793004343
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so1500104f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793004343; x=1793609143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3yfYrZIeD2gITpIz98Xsd6o/5OxQ4hhdiZ9+RqIo2N8=;
 b=RhhLDKqx8HfFFbqbwwJd4YJdHUVGalgqsrvu0GwztO8jp7lqc4fqfz5m9Uca4ESjc8
 WT8eSWNZCP9FfjoEXhLZ9Eg02IgAKnoqiTPbwz1CpTi2EwgwXExjW2+hUqij4xl8NFxv
 ldLnU9pwiCshrGuyIEMTQAC8DFIMu9LSha57cw/rI7tmOk4cigxN+KWE1kuQUzZBo0fD
 3v+QrTjrLu/ksiA0gcYZcyJX2T42qmC+icVyl7tyPIFOV+xKQP1NqRkKMHobfIpwSTa7
 qdzSWaw8fAJKI3V746GgQdwYh9y/BB2n9d+sJ0wP9LtYfxj0QAETEhrzQWPbQmS+u3Ek
 PUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004343; x=1793609143;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3yfYrZIeD2gITpIz98Xsd6o/5OxQ4hhdiZ9+RqIo2N8=;
 b=BSaDIIDBFCPtvVYOuYRnRkaVYEn3m16cmdOrhP7vZk3dfHSqZylxhp7UEKoIIQeyzY
 +RUw6hWyzL68x5dENYv9zPPEkE8m06hWAIuXlVOXLF2ieFADiy88EBc6n7pyu/qWRcVg
 T0Pp+DcBMGenQoJ9vu83hGA7pX7ybzueDMLq0wiRsJmDJdOD/cS9Ivh+5HbV9fqkeUYX
 JhgWTzQLTme7BZT7/Gl0SlDo1vxtOiZI94J+fwzDTL3K48bJfnjYt5Fxxq0WRPzATg4e
 OD7CkB0hpwU2SX4rDRPE0YgF+aDxXxgIfmRE5Od5aInzsN2kjVN09iipBhOVAKPTqcwe
 S28Q==
X-Gm-Message-State: AFq9FYLaFuwM5k+9c8KJjZZdC2jB026KOzG7+ACo+yVIgl1m0gEDXN1O
 OMlylwmXTtHUZocg4Fq/zJ2Pw7kA92DqzCjxhQpKMZa03isE4GjOcr/4+/d08HNran8C4g1RenI
 kyvfJdHQLr3/xbh/UA6U3Sn8lQ/+VcMtIWWaivN6XOedFA57akMByRDy8
X-Gm-Gg: AYBFou1+TKZuU/yHC1HypBoKnKDkPJ6bc4g5OSfI6UNuIdYEla85TwMdg79do17Mqye
 Ifxu44ays8fH2336ee0d1MsI6UXT6dsAzzldbP/czV8HNIF/30QqLOz+vEReLuuIRwglLjXNW4p
 QDVd2gy1DeyLDJFrVCF9bOh0T3laB6UrbxY/jSb+s3noGMUl8IKROXsLUM0e/mRiZ4bOpH5wLne
 shD9A90BIs5zOhideDRbZjG1txs4WGd0ZWCtlxDytKTcucQX6H7aYeyTTcdJ6DZle5EPYliqc53
 jTMPb6dE2mGtECbQtcp+grD6MRxKz0gka5CKJMi9W9qBp/tmiD2C7Daask1OZJNT4dsYh6AGQug
 2JiByMUayv2s/s/+3VDRVSiSWjE7Uwc/6pjZeMKkh
X-Received: by 2002:a5d:64c4:0:b0:48e:2406:57d0 with SMTP id
 ffacd0b85a97d-48e3eb75f9dmr11241971f8f.19.1793004343444; 
 Mon, 26 Oct 2026 01:45:43 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:48e:2406:57d0 with SMTP id
 ffacd0b85a97d-48e3eb75f9dmr11241926f8f.19.1793004342948; 
 Mon, 26 Oct 2026 01:45:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d?
 ([2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e542ed998sm121452f8f.13.2026.10.26.01.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 01:45:42 -0700 (PDT)
Message-ID: <5f3f7b88-317c-486c-a88c-f9df5779cd1b@redhat.com>
Date: Mon, 26 Oct 2026 09:45:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scripts/checkpatch: validate Fixes: tag format and
 commit ancestry
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260806171333.328864-1-clg@redhat.com>
 <CAGxU2F7g2S1hfpp=_u1LkLBE=brkCFvetjtHA669LtihjZANHQ@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAGxU2F7g2S1hfpp=_u1LkLBE=brkCFvetjtHA669LtihjZANHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 10:42, Stefano Garzarella wrote:
> Hi Cédric,
> 
> On Thu, 6 Aug 2026 at 19:15, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Adapt the kernel's checkpatch Fixes: tag validation for QEMU.
>>
>> Add a git_commit_info() helper to resolve commit hashes and validate
>> the Fixes: tag in commit messages. The canonical form is:
>>
>>    Fixes: <12+ chars of sha1> ("<title line>")
>>
>> The check validates capitalization, spacing, hash length, lowercase
>> hex, and quoted title. When the format is wrong and the commit can
>> be resolved, suggest the corrected Fixes: line.
> 
> I had this strange suggestion while checking a patch I just sent[1]
> applied on master (with this commit merged):
> 
> $ ./scripts/checkpatch.pl --branch master..HEAD --codespell
> WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")'
> #19:
>      Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
> 
> total: 0 errors, 1 warnings, 21 lines checked
> 
> Commit bfd67b5941a3 (backends/igvm: fix parameter area entries leak) has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 
> An LLM suggested this and fixed the issue on my side:
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5df266acb1..82f62f6021 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1889,7 +1889,7 @@ sub process {
>   
>                          if ($line !~ /^\s*Fixes:\s+CVE/i) {
>                                  my $tag_case = not ($tag eq "Fixes:");
> -                               my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
> +                               my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
>                                  my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
>                                  my $id_case = not ($orig_commit !~ /[A-F]/);
> 
> Since I don't know perl at all, please check it and feel free to submit
> this change or another ;-)


This is just a regexp and it is correct :) I see Peter fixed it already.

Thanks for the report.

C.


