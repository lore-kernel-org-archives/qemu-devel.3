Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E14C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3kR-0004AD-Dy; Wed, 17 Jul 2024 08:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sU3kP-00043c-KU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sU3kN-0003IQ-T1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721219222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K86ZMpd5K0+2elzuItPBwAI3hALdjVsTtctEQBSOwWI=;
 b=SVbNV88XkRv/8JA404fvejKMxFb4PsnO34w7rXvmTFA28qp+nxPr/uu3aBuCqYmcnxnkVQ
 ZZf3HGPSnTNaSURv2c/gqKPqWG69ebdezECktTmTM7JE/+qgxVrCAN0KMC4dhdNZEr2XSR
 IYkhv8d6La0hnzFVtvMVDJQLyNbLe8I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-anojQxp7MFSAKgHs6PCsjQ-1; Wed, 17 Jul 2024 08:26:59 -0400
X-MC-Unique: anojQxp7MFSAKgHs6PCsjQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a141e44419so969619185a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721219219; x=1721824019;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K86ZMpd5K0+2elzuItPBwAI3hALdjVsTtctEQBSOwWI=;
 b=OJrSNmlgOe7nkptPVS+EPSjL4iQ97R261ms+YIIxSiERDdQbsddfXnLDyYeuP9zj5r
 WaadE+KUnWWE4lZsPspgJUpkHxWkfUoe6L4Dwz1Wgw+driIwEIVHWy5HOW8tvjRNPOXn
 oKqXymc1YZjSqDR5gIMkORzJuFFiX9jMuEIWF+gkY8cTNym0aLRwtSF6hBe6/wmDM1J4
 FbRKFHQ/T6Br3lJ1la08YIu4OYfhe19H8Jw/UzdQjyDjnmA74sst66AphB7yt1/I867x
 +MCYAtUd8XRpgFNqJPPX5tihqomQudc6D2vkHhHa+2HwwIbDZ5oyw3COzH7sKTarkONY
 FOXw==
X-Gm-Message-State: AOJu0YwXRxmo57iAMLN9SGCnBwgac/5C9k8YtnlLEtxuzKN8OSYHrugO
 5xVD5RVE0kiXbtPb+zg6jpAsBjqIOxND64kFNtRei1ynNfRZNFShk8TWG8TPqEAnjC2fO+vEn7e
 8bBZcX9d3BCk2DvkzFQV5LxA7JWtlUXoRJAQwG7BhU34n/PmYJ8Mf
X-Received: by 2002:a05:620a:2606:b0:79d:569a:6997 with SMTP id
 af79cd13be357-7a18750bea9mr125695385a.70.1721219218813; 
 Wed, 17 Jul 2024 05:26:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy1QQXD+mLNdTDOeR0f30oTY8E3ivcme+UmOuGxoNVzH8w7noylJCgOUOdotBU5oxv8/qoaA==
X-Received: by 2002:a05:620a:2606:b0:79d:569a:6997 with SMTP id
 af79cd13be357-7a18750bea9mr125693385a.70.1721219218369; 
 Wed, 17 Jul 2024 05:26:58 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it.
 [82.57.51.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160c6dc8dsm396303585a.110.2024.07.17.05.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 05:26:57 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:26:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com
Subject: Re: [PATCH] scripts/checkpatch: emit a warning if an imported file
 is touched
Message-ID: <nuvayvskkd2dkne66kfdhuuamofe5s5pykteddccwcuifvrmkv@4kzzdakpr7rd>
References: <20240717093752.50595-1-sgarzare@redhat.com>
 <ZpeT-85-AnNidaNC@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpeT-85-AnNidaNC@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 17, 2024 at 10:50:51AM GMT, Daniel P. Berrangé wrote:
>On Wed, Jul 17, 2024 at 11:37:52AM +0200, Stefano Garzarella wrote:
>> If a file imported from Linux is touched, emit a warning and suggest
>> using scripts/update-linux-headers.sh
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index ff373a7083..b0e8266fa2 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1374,6 +1374,7 @@ sub process {
>>  	my $in_header_lines = $file ? 0 : 1;
>>  	my $in_commit_log = 0;		#Scanning lines before patch
>>  	my $reported_maintainer_file = 0;
>> +	my $reported_imported_file = 0;
>>  	my $non_utf8_charset = 0;
>>
>>  	our @report = ();
>> @@ -1673,8 +1674,17 @@ sub process {
>>  # ignore non-hunk lines and lines being removed
>>  		next if (!$hunk_line || $line =~ /^-/);
>>
>> -# ignore files that are being periodically imported from Linux
>> -		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
>> +# ignore files that are being periodically imported from Linux and emit a warning
>> +		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
>> +			if (!$reported_imported_file) {
>> +				$reported_imported_file = 1;
>> +				WARN("added, moved or deleted file(s) " .
>> +				     "imported from Linux, are you using " .
>> +				     "scripts/update-linux-headers.sh?\n" .
>> +				     $herecurr);
>
>This is a good hint, but can we add a further check that is a fatal error,
>if the headers are changed in the same commit as non-header changes. When
>importing headers, they should only ever be in a self-contained patch
>with nothing else touched.

Yep, good point! I'll add that check in v2.

Thanks,
Stefano


