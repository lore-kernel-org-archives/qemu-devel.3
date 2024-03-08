Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96133C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUqL-0004Ah-1G; Fri, 08 Mar 2024 02:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUqI-0004AQ-Qy
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUqF-0007k5-4D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709883630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csqJNAqhn83u9l+vuEFjQv8D5gH3IMFM6QLRgtzv3B0=;
 b=Uu6Wak62LBnLcm7NWXSeW8r+wuzZLduETmFActkrE/jS4fqSEBeEtCuESTYuMtLNYvVIA0
 QH3ICFZvydpyYdFncKzqG94SUuzRUszK6hw+pt/mvHWM7s2Iar5BVFShG0uDo9RMjTtCN7
 sDeqz9PxpWYVvlX/YbFb6wyzpnMjotk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-TOX9eYfLP5u-G1zH4N4X1Q-1; Fri, 08 Mar 2024 02:40:28 -0500
X-MC-Unique: TOX9eYfLP5u-G1zH4N4X1Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so453285a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709883627; x=1710488427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=csqJNAqhn83u9l+vuEFjQv8D5gH3IMFM6QLRgtzv3B0=;
 b=L6UEUi32POrECd7xQyI/83EVyI/7QYGaOKD/Egk2XV1tDuowDfWu4DBPUGW6yqb/m4
 NcUTOHosHQmLRqbBqgdwoOFTe7HtFoC9izu9rfUJ9BbPjvcz7cUbsVtHvp+APxdjuVzf
 9KjoeCk9DBkRYfw5f/H9C/i3yNgZAfMfGoSdmOPwSpdGdVrQrNH51PBcvgX9xa9I05r2
 IkYPowDDgnRBP3s689n7OQEI6V96npj++7OVARxZUVP/v9L0DVGLhtUNzxGKIiz2KWau
 lnM6/AObTzUOrSSuP6yQPkyoLbmeuVKRcH3HQlDnsLZQK9DWYLsk8/U2qDvOIU21adNr
 0+Rg==
X-Gm-Message-State: AOJu0YxbtOiD3brpXGrY31cYwbzNEV79NJRRcyDRvjDvBajDPofBQVBM
 HRUY6IiHRAZt3/mPaMC/OCI/6KxVr1OaGeJABbTaGHfq62aNaIEqEzB8wjy2a0FNO7P+9n8rUtl
 7wQnZAreAJ9WMVn143Mi1re7PEtLye6VOrf93cpjOfFwwQDNpu25nCoOUjZ2wVo8=
X-Received: by 2002:a05:6a20:6d16:b0:1a1:40a2:23a8 with SMTP id
 fv22-20020a056a206d1600b001a140a223a8mr1147795pzb.4.1709883627145; 
 Thu, 07 Mar 2024 23:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+NjHeoVOHBEsM/fYbOCGlI25hnDy3vXOrQb6s/nwcCgeC2UAmhhK5yV67tjCdLCdagDBHCQ==
X-Received: by 2002:a05:6a20:6d16:b0:1a1:40a2:23a8 with SMTP id
 fv22-20020a056a206d1600b001a140a223a8mr1147784pzb.4.1709883626720; 
 Thu, 07 Mar 2024 23:40:26 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fs12-20020a17090af28c00b0029bbb856fe9sm43168pjb.17.2024.03.07.23.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 23:40:26 -0800 (PST)
Date: Fri, 8 Mar 2024 15:40:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] scripts/kernel-doc: teach kdoc about QLIST_ macros
Message-ID: <ZerA34BH9NNf_K1Y@x1n>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307181105.4081793-2-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 07, 2024 at 06:11:01PM +0000, Alex Bennée wrote:
> The kernel-doc script does some pre-processing on structure
> definitions before parsing for names. Teach it about QLIST and replace
> with simplified structures representing the base type.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/kernel-doc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 240923d509a..26c47562e79 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1226,7 +1226,14 @@ sub dump_struct($$) {
>  	# replace DECLARE_KFIFO_PTR
>  	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
>  
> -	my $declaration = $members;
> +        # QEMU Specific Macros
> +
> +        # replace QLIST_ENTRY with base type and variable name
> +        $members =~ s/QLIST_ENTRY\(([^)]+)\)\s+([^;]+)/$1 \*$2/gos;
> +        # replace QLIST_HEAD, optionally capturing an anonymous struct marker, and capture type and variable name
> +        $members =~ s/QLIST_HEAD\(\s*,\s*([^)]+)\)\s+([^;]+)/struct { $1 *lh_first; } $2/gos;
> +
> +        my $declaration = $members;

May need a "tabify" here..

-- 
Peter Xu


