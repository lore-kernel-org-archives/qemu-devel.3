Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7DEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Pt-0007Mh-Jw; Tue, 11 Mar 2025 11:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts1Pj-0007Fa-31
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts1Pg-0006zj-Vw
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741706457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SFWcnRpaqXUmaXBblJgSw/v3BPvQtwy3gAeFjoCa1w=;
 b=CbBJgTcZ8nl5zurGOTqsepdtn0CFf5vYMOuNI7lBT6O5iBp9vLtLTPFVStEGIV42YlSJ26
 YUbHsjKjGgl66U8oJr+kCAa6P3I5UP8hqqeIXH0dXDugY9UvWUzW72x+Gumr0jjR7nX5Bz
 H+dAgvNsK3nT9VeD+QuOubRxSkiQNbA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-sYyEdhf7PEOUz8TmzT2ixw-1; Tue, 11 Mar 2025 11:20:55 -0400
X-MC-Unique: sYyEdhf7PEOUz8TmzT2ixw-1
X-Mimecast-MFC-AGG-ID: sYyEdhf7PEOUz8TmzT2ixw_1741706455
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e91d8a7165so36032576d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706455; x=1742311255;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0SFWcnRpaqXUmaXBblJgSw/v3BPvQtwy3gAeFjoCa1w=;
 b=MMcBDj/FJoxoJ2L+IVN1poI8ejieMbwp9yN3aN9eU1US47ZsXFykCq3lZfbaY0byN5
 Lnpm9QOAtSgJr4UnruWwl4CKCN6Vvmx8kYhhNOFdq58KKIKowoRrSAiciB91+BwdGPWK
 66n46TVEJz2IbJuzn1c5TLQjcDuh89DPys5P7hgn+9R0CB+oK/IAqDk7wKIBz4/UnAWb
 mEt4XefRY7QL0oF73yEB1eOIFNUrtSbNo4+x0rHgHTcHjZ6nyd1sWgUJz48YKDQke/AW
 mhxuXykq/HpSMA/wzA0+Fmt0yOtzlYEZIBbpPN6t4NgV6pEBbAVVMOK8YfXJzCK49dQQ
 eY9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXArvT+C1urFwq3Ehwciyjf3AYmghxg9bhFPZWSDhJiDB4GLAPSe5or0eYWDd8pfoFUDYeR6VlQMnF@nongnu.org
X-Gm-Message-State: AOJu0YzqLqkWR9v8nT0lwQ/AR15NEUCYQIstFBDmPA/zzdJ2eND4kBG6
 x+Jib2KmCgrTAYuEfnbESBNRP0wK4jzwuE79jfbN6i4VGdKufia8cibDcx3b8g+HxDLxhVsdypm
 vNezLQEXQedCTiQCNrLmoPpE/ncq0A9vERcsxRxXLfsKxFPThYxtx
X-Gm-Gg: ASbGncs1F/8ztT+MOaZapAVhhvkJ/UiMLoNIXcYwDJwuLD2VvJhTBMm8Vh4Hl57K/Hj
 v9zApFpDHRSqLC8k/ezE31RUqJY+MD4vDdrPrxj56uFEgc3tzOLTNJvDYheUH/FJzzJmFGSYCEX
 xBrpu40S4i501GphGZYOPwSFHX1NVxsbWiqGeZIDMPc08P+rwr+ulpEEi66cNLtOYHir+S7mBiH
 FsIDHqKzr0rY1pBQKBH+20M8yV1vU1BzUVpvR2/NX/LVO202L7eREV4TW1sP11csC5RRTElAzky
 WN9HMoc=
X-Received: by 2002:a05:6214:d43:b0:6e8:8b11:b6cd with SMTP id
 6a1803df08f44-6e90066bc5emr237257496d6.35.1741706454875; 
 Tue, 11 Mar 2025 08:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYuaHUImoNco7dI6UqbbAdn6N/QhGF62yZNaYf8/F6WaBRUosjRpdht6SdbaTbtYlRpm8OGQ==
X-Received: by 2002:a05:6214:d43:b0:6e8:8b11:b6cd with SMTP id
 6a1803df08f44-6e90066bc5emr237257156d6.35.1741706454479; 
 Tue, 11 Mar 2025 08:20:54 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715bab5sm73569746d6.86.2025.03.11.08.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:20:53 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:20:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, farosas@suse.de, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z9BU0gd3BLPhBss2@x1.local>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local> <Z8_wnLIlfhM7bILZ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8_wnLIlfhM7bILZ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 11, 2025 at 08:13:16AM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 10, 2025 at 04:03:26PM -0400, Peter Xu wrote:
> > On Mon, Mar 10, 2025 at 07:48:16PM +0000, Daniel P. Berrangé wrote:
> > > Given this is in public API, the data needs to remain reported accurately
> > > for the whole deprecation period. IOW, the patch to qiochannel needs to
> > > preserve this data too.
> > 
> > :-(
> > 
> > We could potentially mark MigrationStats to be experimental as a whole and
> > declare that in deprecate.rst too, then after two releases, we can randomly
> > add / remove fields as wish without always need to go through the
> > deprecation process, am I right?
> 
> IMHO that would be an abuse of the process and harmful to applications
> and users consuming stats.

Ah I just noticed that's the exact same one we included in
query-migrate.. Then yes, the stable ABI is important here.

So for this specific case, maybe we shouldn't have exposed it in QMP from
the start.

To me, it's a question on whether we could have something experimental and
be exposed to QMP, where we don't need to guarantee a strict stable ABI, or
a very loose ABI (e.g. we can guarantee the command exists, and with
key-value string-integer pairs, nothing else).

Taking the example of downtime reports: there used to be attempts on the
list capturing details of downtime measurements for each migration and
report that via QMP, probably via the stats.  At that time, I was concerned
that whatever we change alone the lines then we risk breaking the ABI
(e.g. we move code within blackout path and it can move contribution of X
from bucket B1 to B2).  At that time the work was not merged.

However, such things (either downtime reports, or some of the stats that
are pretty much not designed for generic users, like this zerocopy success
counter) would still be nice if we can collect them in QMP queries.

Maybe what we need is a new MigrationInfoOptional, to be embeded into
MigrationInfo (or not), marked experimental.  Then in the future whenever
we want to add some new statistics, we could decide whether it should be
part of stable ABI or not.

PS: we have Juraj actively looking at selftests to measure downtime
contributions of live migrations.  Currently we need to leverage
tracepoints and parse the results.  If that sounds reasonable, we could
start with having MigrationInfoOptional and export downtime metrics.

Thanks,

-- 
Peter Xu


