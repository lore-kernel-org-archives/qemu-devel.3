Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7A8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVVb-0002Sg-IU; Fri, 08 Mar 2024 03:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVVX-0002SA-RD
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVVU-0000aZ-B4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709886186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nerhoR4SPqCxPeGtfxFQB+iKuTID4ofZFmp/M8lw9M8=;
 b=VqgN8q14FtPVJNxykYGslv64+tdiZNHgAT2QRYMhNrRNar873bRKWhu1vFe8Zn3Czq3Gmy
 6TFZjVSHXsRiTVSFgE+EJ5xL8Cyn2ZFQpz6V3lPIIGJtOhDznWeogisyzwmeS3UBeRHf6J
 eYSyOLnNII4FDWFDVcxYWQFh63zyKZo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-Z9yBrcSyM3WRBjqoJrcD-A-1; Fri, 08 Mar 2024 03:23:05 -0500
X-MC-Unique: Z9yBrcSyM3WRBjqoJrcD-A-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1dd63773cf9so2890925ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886184; x=1710490984;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nerhoR4SPqCxPeGtfxFQB+iKuTID4ofZFmp/M8lw9M8=;
 b=agFoRgyUoLqwEmFPOLqFbTM9lFogNc1t+Zbo7ro2X47hXFksqyRPeGf3PKPfp+Er/f
 plgTFUHTOsq4dJCMDDxZdAl9ac7MtiE1WQ1p4QarS7QIM3ALwPfue5QeG2Ky0R165UIg
 PMHqd9IL+lC9/vrsVXBYFMUBIkhxPvbEFwAJBmqFu76UBSrATObAZSBjDRzCHMuVmwA+
 dAJMEieDZbd8ZfUv19nrBxVWHDMm5g4SeKl2PNnTlJ+8R9J/4jXQGji5mtAMl5HgAY83
 iaH0qUDrHaG5lm9t7k1FQFZAxhochWYFsCOPtbCJBtB3MPRmerWC5k7mYGOJUiZkszwh
 VWTw==
X-Gm-Message-State: AOJu0YyG9gUUixUjKFq5fAdd4wSJwIQYF4VPn25aQwFySOTjZWrUu8EH
 +GdVQACgWr8v9bkGmHMsxs9vER4n46kwHt3qlVV06MymKteWAMlRnE5AqN0D05Q+8bRkaH/Fonh
 XzM+UQ0//P77b71wjrDBU2DQydspEgZ27vNWljlz4aSueeMMo/XNi
X-Received: by 2002:a17:902:ab87:b0:1d9:607d:8a26 with SMTP id
 f7-20020a170902ab8700b001d9607d8a26mr1422544plr.6.1709886184422; 
 Fri, 08 Mar 2024 00:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtifd6U7mMV5dH/ROUONXK/ogjq5klcHfWkXh6f8QVH9YrRWILpzZWK0Gktt1m9eMu4PckVg==
X-Received: by 2002:a17:902:ab87:b0:1d9:607d:8a26 with SMTP id
 f7-20020a170902ab8700b001d9607d8a26mr1422525plr.6.1709886184014; 
 Fri, 08 Mar 2024 00:23:04 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j14-20020a170902da8e00b001dc96cb0358sm15744767plx.206.2024.03.08.00.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:23:03 -0800 (PST)
Date: Fri, 8 Mar 2024 16:22:50 +0800
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
Message-ID: <ZerK2iI7FAGuQH1O@x1n>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-2-alex.bennee@linaro.org>
 <ZerA34BH9NNf_K1Y@x1n> <87msr9taac.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msr9taac.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Mar 08, 2024 at 08:09:15AM +0000, Alex Bennée wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Mar 07, 2024 at 06:11:01PM +0000, Alex Bennée wrote:
> >> The kernel-doc script does some pre-processing on structure
> >> definitions before parsing for names. Teach it about QLIST and replace
> >> with simplified structures representing the base type.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> ---
> >>  scripts/kernel-doc | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> >> index 240923d509a..26c47562e79 100755
> >> --- a/scripts/kernel-doc
> >> +++ b/scripts/kernel-doc
> >> @@ -1226,7 +1226,14 @@ sub dump_struct($$) {
> >>  	# replace DECLARE_KFIFO_PTR
> >>  	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
> >>  
> >> -	my $declaration = $members;
> >> +        # QEMU Specific Macros
> >> +
> >> +        # replace QLIST_ENTRY with base type and variable name
> >> +        $members =~ s/QLIST_ENTRY\(([^)]+)\)\s+([^;]+)/$1 \*$2/gos;
> >> +        # replace QLIST_HEAD, optionally capturing an anonymous struct marker, and capture type and variable name
> >> +        $members =~ s/QLIST_HEAD\(\s*,\s*([^)]+)\)\s+([^;]+)/struct { $1 *lh_first; } $2/gos;
> >> +
> >> +        my $declaration = $members;
> >
> > May need a "tabify" here..
> 
> Ugg that file is a mess. Any idea what we should use for perl, tabs or
> spaces? I can update editorconfig.

Indeed.. not perl expert here.

For this one it might be still good to keep the same with the code around
before an attempt to clean it up.

Thanks,

-- 
Peter Xu


