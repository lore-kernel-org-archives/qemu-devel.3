Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589C2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAhP-00042y-U6; Wed, 14 May 2025 07:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAhF-0003lx-90
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAh7-0007c1-Ed
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9sKC59ON5/JSRSexxBp70teX+HKH8/8gDnZQLckUwPk=;
 b=Cb/pHNFdJ/8CiibI4XiMBOtKm9i71NX5otzbdfbKJb5jgT5ZOQ+3OGvIrLcdhdyfONvrG9
 6xTNN4mT9WlFIvdlDRXVUVc0SXpzkQike+FU5zaMMunQ9+9BHrk3Ij12DukbH26ROUeaRD
 VAlmL10SxAMLe8zUeenZngVbpjrPXa4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-xiaacSQ_PZKSliLKC_pyEQ-1; Wed, 14 May 2025 07:54:36 -0400
X-MC-Unique: xiaacSQ_PZKSliLKC_pyEQ-1
X-Mimecast-MFC-AGG-ID: xiaacSQ_PZKSliLKC_pyEQ_1747223676
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so46485225e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223675; x=1747828475;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sKC59ON5/JSRSexxBp70teX+HKH8/8gDnZQLckUwPk=;
 b=kCGoNzfwKvSOA0ad9+iJOM7fNKurj1z3sVQ4B7Y/xgxoR1ldOn1bsN8s5d4lS413EO
 zHOTJaLMLeH6ACI+QPUPai2TzD5wEkHJiPBPF32s6XoWypKbHBG+sP5t/Uo20J+q4Jvx
 58NonSfn++tZq1n/CkmOXlgwErjpbadgDsQ7CRidKsyaOSw4v+HRTXwsrVcoyPRYLA0z
 JvrGR8nLC0XiRj5L2fknDspKTMiGLDGHzcybUd3M5SYuot4yrgfuQqEIRs8u4r87Zao2
 GF3TilGvWp+z4eLdnpZVV1cRs1uRQUaEoRGowEtfYc+Pkaps4Vg9dUv6I4gx61aBMvk1
 LJEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh2NoYo7nrzFxRIcH4kcBEXEonKstxXB6oSwsBCadbSaENhVVJJtUTr1IEsJGozwL59O2pESNOdLMI@nongnu.org
X-Gm-Message-State: AOJu0YwLgWUa0SdVKlNe7lAtED2n8z9uXm+Bc84UzLcCQ17+6yGVDEah
 YPK5gu4oS+0TOjVAu/ylM9JK/PDVzC3AmOpWAGwnYoJCgDCociIP0qnNcS1sCwoQsJHiZ2jskCu
 O+20GaqmvpXUGTSqvF83WPQLaJ3dkVf7OHAqUukEjwgsIRl0ktdTH
X-Gm-Gg: ASbGncu4zq2Lewgb8FGhoge6RSCTH3yA2G9ZtETqhV4PGtAsamj6rAjoRKwHqyZsv4m
 5hP5RRxwVOkUTdK7tHVvWEhsmJKz058Ju+jfHRjBEE0J9DRHa1T9NhoF3V9ls7H8L9Aw4RQYeaW
 A2hIeE7mU0gRhskCDWeMa9dud5FFzd27H0S9B57txbJObRcz9KTiBa0fACfvstkGpk8xqHdFxyo
 8KW3Q3ZFlfVDTkCBix0wKMSsuMcKMOAw/MFrKLAKYIAtC9avW4IQ5zJlGvEbvOpDutt23sx3IC7
 SfUkWqQKeRis6FViudn8c5iqg9R2OFm+W87wF36ml4PJphV5aw==
X-Received: by 2002:a05:600c:3494:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-442f20b9b46mr28715505e9.4.1747223675620; 
 Wed, 14 May 2025 04:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT6jtsORZ+pZRjLJ4QOwNZArV+ms4wKcGcrd1B9ViKAKUr7AD6WmRfMeYwd60+yZ6IyBe/Tw==
X-Received: by 2002:a05:600c:3494:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-442f20b9b46mr28715235e9.4.1747223675218; 
 Wed, 14 May 2025 04:54:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef8f7sm26160925e9.39.2025.05.14.04.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 04:54:34 -0700 (PDT)
Message-ID: <1fc92c6d-d025-4314-8614-ba084433b399@redhat.com>
Date: Wed, 14 May 2025 13:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] scripts/checkpatch: introduce tracking of file
 start/end
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250512182447.1139105-1-berrange@redhat.com>
 <20250512182447.1139105-4-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512182447.1139105-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/12/25 20:24, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Some checks want to be performed either at the start of a new file
> within a patch, or at the end. This is complicated by the fact that
> the information relevant to the check may be spread across multiple
> lines. It is further complicated by a need to support both git and
> non-git diffs, and special handling for renames where there might
> not be any patch hunks.
> 
> To handle this more sanely, introduce explicit tracking of file
> start/end, taking account of git metadata, and calling a hook
> function at each transition.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 109 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 106 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7675418b0b..b74391e63a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1417,6 +1417,38 @@ sub checkspdx {
>       }
>   }
>   
> +# All three of the methods below take a 'file info' record
> +# which is a hash ref containing
> +#
> +#  'isgit': is this from an enhanced git diff or plain diff
> +#  'linestart': line number of start of file diff
> +#  'lineend': line number of end of file diff
> +#  'filenew': the new filename
> +#  'fileold': the old filename (same as 'new filename' except
> +#             for renames in git diffs)
> +#  'action': one of 'modified' (always) or 'new' or 'deleted' or
> +#            'renamed' (git diffs only)

It would be nice to have some support for 'quilt' patches too. This would
mean being able to match '(---|+++) /dev/null' for new and deleted files.
Anyhow, that's for another series.

> +#  'mode': file mode for new/deleted files (git diffs only)
> +#  'similarity': file similarity when renamed (git diffs only)
> +#  'facts': hash ref for storing any metadata related to checks
> +#
> +
> +# Called at the end of each patch, with the list of
> +# real filenames that were seen in the patch
> +sub process_file_list {
> +	my @fileinfos = @_;
> +}
> +
> +# Called at the start of processing a diff hunk for a file
> +sub process_start_of_file {
> +	my $fileinfo = shift;
> +}
> +
> +# Called at the end of processing a diff hunk for a file
> +sub process_end_of_file {
> +	my $fileinfo = shift;
> +}
> +
>   sub process {
>   	my $filename = shift;
>   
> @@ -1453,7 +1485,10 @@ sub process {
>   	my $realfile = '';
>   	my $realline = 0;
>   	my $realcnt = 0;
> +	my $fileinfo;
> +	my @fileinfolist;
>   	my $here = '';
> +	my $oldhere = '';
>   	my $in_comment = 0;
>   	my $comment_edge = 0;
>   	my $first_line = 0;
> @@ -1591,17 +1626,56 @@ sub process {
>   		$prefix = "$filename:$realline: " if ($emacs && $file);
>   		$prefix = "$filename:$linenr: " if ($emacs && !$file);
>   
> +		$oldhere = $here;
>   		$here = "#$linenr: " if (!$file);
>   		$here = "#$realline: " if ($file);
>   
>   		# extract the filename as it passes
> -		if ($line =~ /^diff --git.*?(\S+)$/) {
> -			$realfile = $1;
> -			$realfile =~ s@^([^/]*)/@@ if (!$file);
> +		if ($line =~ /^diff --git\s+(\S+)\s+(\S+)$/) {
> +			my $fileold = $1;
> +			my $filenew = $2;
> +
> +			if (defined $fileinfo) {
> +				$fileinfo->{lineend} = $oldhere;
> +				process_end_of_file($fileinfo)
> +		        }
> +			$fileold =~ s@^([^/]*)/@@ if (!$file);
> +			$filenew =~ s@^([^/]*)/@@ if (!$file);
> +			$realfile = $filenew;
>   	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
> +
> +			$fileinfo = {
> +				"isgit" => 1,
> +				"githeader" => 1,
> +				"linestart" => $here,
> +				"lineend" => 0,
> +				"fileold" => $fileold,
> +				"filenew" => $filenew,
> +				"action" => "modified",
> +				"mode" => 0,
> +				"similarity" => 0,
> +				"facts" => {},
> +		        };
> +			push @fileinfolist, $fileinfo;
> +		} elsif (defined $fileinfo && $fileinfo->{githeader} &&
> +			 $line =~ /^(new|deleted) (?:file )?mode\s+([0-7]+)$/) {
> +			$fileinfo->{action} = $1;
> +			$fileinfo->{mode} = oct($2);
> +		} elsif (defined $fileinfo && $fileinfo->{githeader} &&
> +			 $line =~ /^similarity index (\d+)%/) {
> +			$fileinfo->{similarity} = int($1);
> +		} elsif (defined $fileinfo && $fileinfo->{githeader} &&
> +			 $line =~ /^rename (from|to) [\w\/\.\-]+\s*$/) {
> +			$fileinfo->{action} = "renamed";
> +			# For a no-change rename, we'll never have any "+++..."
> +			# lines, so trigger actions now
> +			if ($1 eq "to" && $fileinfo->{similarity} == 100)  {
> +				process_start_of_file($fileinfo);
> +			}
>   		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
>   			$realfile = $1;
>   			$realfile =~ s@^([^/]*)/@@ if (!$file);
> +
>   	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
>   
>   			$p1_prefix = $1;
> @@ -1610,6 +1684,30 @@ sub process {
>   				WARN("patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
>   			}
>   
> +			if (defined $fileinfo && !$fileinfo->{isgit}) {
> +				$fileinfo->{lineend} = $oldhere;
> +				process_end_of_file($fileinfo);
> +			}
> +
> +			if (!defined $fileinfo || !$fileinfo->{isgit}) {
> +				$fileinfo = {
> +					"isgit" => 0,
> +					"githeader" => 0,
> +					"linestart" => $here,
> +					"lineend" => 0,
> +					"fileold" => $realfile,
> +					"filenew" => $realfile,
> +					"action" => "modified",
> +					"mode" => 0,
> +					"similarity" => 0,
> +					"facts" => {},
> +			        };
> +				push @fileinfolist, $fileinfo;
> +			} else {
> +				$fileinfo->{githeader} = 0;
> +			}
> +			process_start_of_file($fileinfo);
> +
>   			next;
>   		}
>   
> @@ -3213,6 +3311,11 @@ sub process {
>   		}
>   	}
>   
> +	if (defined $fileinfo) {
> +		process_end_of_file($fileinfo);
> +	}
> +	process_file_list(@fileinfolist);
> +
>   	if ($is_patch && $chk_signoff && $signoff == 0) {
>   		ERROR("Missing Signed-off-by: line(s)\n");
>   	}


