Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD41C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLnN-0000jE-Ap; Thu, 22 Feb 2024 22:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLnF-0000fx-Ot
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLnC-0008Rk-LQ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708657204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jVPKJQm1hrV+kNWK45Q3SVQ04VeNxJxcXy8FS5ri6o4=;
 b=Gn0bmXi2rZGDgDmRdTVqdasYRauKXwhueIwjLfGFMsZrOWboZvfyVv0kyazoc3ZNdmZSFH
 ql/7RizmImGEPkelUyRrXEWK+EvR3YWkb3/EDWxyXPGoNYjEpqXid0UIORKo6HnhDUUY2I
 tUnHXJjYDYuwvsH+rMjyvH0JBHWt3tI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-jrX50mCeM1eBOt3kvUcEnw-1; Thu, 22 Feb 2024 22:00:00 -0500
X-MC-Unique: jrX50mCeM1eBOt3kvUcEnw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e46611af43so150726a34.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657199; x=1709261999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVPKJQm1hrV+kNWK45Q3SVQ04VeNxJxcXy8FS5ri6o4=;
 b=nRtzw4+9C1jEMV409cD8PxiMfEYFWFq12zQJUhH9e9grt6MSPiVT8v8KI6V5dQ6ZKG
 +f2gzw/x5hwfnssLwD+K2BDNbrVZfpFTB2oSfR+4EkwHs/FFiOuLTY0SBQWW2xrs02Zo
 EX4B0bjBEp6MXhfcoq0XBe2weGKeY7LCz0/L6cBEVRgu/YS00PRsVYSlFi/QNHBfWvNF
 r+kry4q3Er24B3RRTOZ3G1uvxKgIY17rXofUtZGMKdlC6U2lVapS9FyCyI45jBBT5245
 pUD3waE/tER5ChsDzXo1cik20dVjdQu6uI40mJRErj/9hGWfR3bxquISYXKnmuxOgWju
 RDNA==
X-Gm-Message-State: AOJu0YxfqFpbjtkIj4yyZL3oqsEe+pOc7N3YZVPOk6hhTH4EvMDlktXu
 0wOp9hdEvaevNLna5Wz7csdAWD5BGmnYRTRKbroTE+bH98j0WputdicL0iQQgDwZ7IqKdgPpSrm
 BYmE7wccFbOxa3dXuwMBDIPWfeWXFKCA2U5+Ryo0UT06GmS6kw1I2
X-Received: by 2002:a05:6358:708:b0:17b:6b42:8d9e with SMTP id
 e8-20020a056358070800b0017b6b428d9emr742723rwj.0.1708657199505; 
 Thu, 22 Feb 2024 18:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjaN5i/919AIKDcH5ceipY2fqGLDe+P7gKaQV23h/VUDKo/XZte1oZrvKl4Xahz3QqBiv/Yg==
X-Received: by 2002:a05:6358:708:b0:17b:6b42:8d9e with SMTP id
 e8-20020a056358070800b0017b6b428d9emr742714rwj.0.1708657199177; 
 Thu, 22 Feb 2024 18:59:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x26-20020a056a000bda00b006e482a238b7sm5665576pfu.31.2024.02.22.18.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 18:59:58 -0800 (PST)
Date: Fri, 23 Feb 2024 10:59:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 00/34] migration: File based migration with multifd
 and fixed-ram
Message-ID: <ZdgKJgxUqb1DrzRt@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:04PM -0300, Fabiano Rosas wrote:
> Latest numbers
> ==============
> 
> => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
> => host: 128 CPU AMD EPYC 7543 - 2 NVMe disks in RAID0 (8586 MiB/s) - xfs
> => pinned vcpus w/ NUMA shortest distances - average of 3 runs - results
>    from query-migrate
> 
> non-live           | time (ms)   pages/s   mb/s   MB/s
> -------------------+-----------------------------------
> file               |    110512    256258   9549   1193
>   + bg-snapshot    |    245660    119581   4303    537

Is this the one using userfault?  I'm surprised it's much slower when
enabled; logically for a non-live snapshot it should take similar loops
like a normal migration as it should have zero faults, then it should be
similar performance.

> -------------------+-----------------------------------
> fixed-ram          |    157975    216877   6672    834
>   + multifd 8 ch.  |     95922    292178  10982   1372
>      + direct-io   |     23268   1936897  45330   5666
> -------------------------------------------------------
> 
> live               | time (ms)   pages/s   mb/s   MB/s
> -------------------+-----------------------------------
> file               |         -         -      -      - (file grew 4x the VM size)
>   + bg-snapshot    |    357635    141747   2974    371
> -------------------+-----------------------------------
> fixed-ram          |         -         -      -      - (no convergence in 5 min)
>   + multifd 8 ch.  |    230812    497551  14900   1862
>      + direct-io   |     27475   1788025  46736   5842
> -------------------------------------------------------

Also surprised on direct-io too.. that is definitely something tremendous.

-- 
Peter Xu


