Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FC1E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWQf-0003wi-PX; Wed, 08 Jan 2025 08:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVWQc-0003wQ-PV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVWQZ-00031w-RT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736344134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/v4x+aDWVgLA5l1DrINPY/muCp5fNJGuPMLEm7b126c=;
 b=P3HRoZNo2TKM0USIOpRPkmGS675E0fxNsqPemJat0xC/fFNtsiFOfgRmvJScTmm0LFTTAE
 tZ9jdsg8EnhGgwYvTI53PHXtsYFfvuWyWqBomH0AxG0bwbh8NGDCzFJ/yTnT0Gmn/uklZU
 j83fcmq8FSYojbKmSJFWvop6jHENmHs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-uV1tSpr-OXO2f6Dpd1D-Qw-1; Wed, 08 Jan 2025 08:48:53 -0500
X-MC-Unique: uV1tSpr-OXO2f6Dpd1D-Qw-1
X-Mimecast-MFC-AGG-ID: uV1tSpr-OXO2f6Dpd1D-Qw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8f8b9d43aso357489836d6.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 05:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736344133; x=1736948933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v4x+aDWVgLA5l1DrINPY/muCp5fNJGuPMLEm7b126c=;
 b=UnkANz723P1VT+leH5eOcSnIb+KkKSWZoSiEpNZy/eXB7MoXBnVLii7t0DgUFDuwPb
 mPO6hitFcq2pJPfrZqAR9l9LIAo1yyKQoK68ZnxKsVGMMGJrldUmlgbpXhfodQvlBXgJ
 LHG/3NyEXeTiU9Pv6r/Imq0hA//fmO69zuHgVEp//Dut6g+qpax3XJL4tFk6EqeN56wf
 vhdOxzua0kuRUMRrWWsty5GqnQHYwYGfVbdUQd9g3lycJnsdvfhJ6mz99FSVecfHTG31
 nonCWYIA2ws/cRn6fG55MnQhhYHdElBDZ+ufhHo5Mzt2cKs02ZnCv3psOSryN/NNyI7G
 p+iw==
X-Gm-Message-State: AOJu0Yyg0L37yWX8DxpQi58/k+FR3neBHsuAP54O0RWxPTDv1TN65wi5
 irHqcCzgTE0ikJXObMr9Zupj2zQwcoOKfbL3WClpjhhoT0wZUhdVXJfsQls4iT3Wi4gI47gfsNC
 T9OsO6RrF85LKVHsnsYvBGiAWP60bfhYWU5OpUZGdz3tXg/m3elL0
X-Gm-Gg: ASbGncururs3VQ2tv5m1cxWmzUWdGH9oI01DsUhzn2xdBILUVH9QGJ/sBQmElJltcjr
 LKqE72QAxvedjs/TK5GrOvVlZ/TZWdeR4HkiN+n2IcNYC7oyUNgTl/SPV9LMBqLagUzF7w1Q+gs
 DSh1Ei9h7HEb+SpsjfS2FHLQo4gaGhPiJJUUdj1MjCkYOHM0cdInx7cd+DwUd8VKXKojE48LT6B
 XEIpRmfToQaTIRZqg0Z4YHyt3wr7I2+11mMQJxBDCl92Ac+mGMVY/yz4j7Q7t+5szdvWJDceo1R
 2W1cjKk6Ng4/CXT2ZQ==
X-Received: by 2002:a05:620a:460f:b0:7b6:6820:c890 with SMTP id
 af79cd13be357-7bcd975aa22mr348611885a.35.1736344132866; 
 Wed, 08 Jan 2025 05:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWM/Af2Y+lcrKIQGPEScZcdiC2jUuU3WHwKayvbURqeYkdMWIDG3d8go0Z8c/pAXJe303ilw==
X-Received: by 2002:a05:620a:460f:b0:7b6:6820:c890 with SMTP id
 af79cd13be357-7bcd975aa22mr348609185a.35.1736344132415; 
 Wed, 08 Jan 2025 05:48:52 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac479135sm1678645185a.95.2025.01.08.05.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:48:51 -0800 (PST)
Date: Wed, 8 Jan 2025 08:48:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/7] migration: Document the effect of vmstate_info_nullptr
Message-ID: <Z36CQojucUnvonfD@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-4-farosas@suse.de> <Z32bkFa4snLklsbj@x1n>
 <87frlt4eli.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frlt4eli.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 08, 2025 at 10:31:05AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jan 07, 2025 at 04:50:21PM -0300, Fabiano Rosas wrote:
> >> The migration stream lacks magic numbers at some key points. It's easy
> >> to mis-parse data. Unfortunately, the VMS_NULLPTR_MARKER continues
> >> with the trend. A '0' byte is ambiguous and could be interpreted as a
> >> valid 0x30.
> >> 
> >> It is maybe not worth trying to change this while keeping backward
> >> compatibility, so add some words of documentation to clarify.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/vmstate-types.c    | 6 ++++++
> >>  scripts/analyze-migration.py | 9 +++++++++
> >>  2 files changed, 15 insertions(+)
> >> 
> >> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> >> index e83bfccb9e..08ed059f87 100644
> >> --- a/migration/vmstate-types.c
> >> +++ b/migration/vmstate-types.c
> >> @@ -339,6 +339,12 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
> >>  
> >>  const VMStateInfo vmstate_info_nullptr = {
> >>      .name = "uint64",
> >
> > Ouch.. So I overlooked this line and this explains why it didn't go via
> > VMSDFieldGeneric already.
> 
> Yes, actually I overlooked as well that it should match the size of the
> data being handled in the get/put functions.
> 
> My comment below is about NULL -> 0x30 that I think should instead be
> NULL -> 0x3030303030303030 so we have any chance of looking at this and
> identifying it's a NULL pointer. When we write 0x30 it might become
> confusing for people reading the scripts output that their stream has a
> bunch of '0' in the place where pointers should be. If the MAGIC number
> were more identifiable, I could change the script to output (null) or 0x0ULL.

I suppose we can?  If we want, by renaming this from "uint64" to "nullptr",
then add an entry for it in Python's vmsd_field_readers.

> 
> We also don't really have the concept of a pointer, which I suspect
> might be the real reason behind all this mess. So we'll see:
> 
> 0x30
> 0x30
> {
>   .some
>   .struct
>   .here
> }
> 0x30
> 
> So all this patch was trying to do is document this situation somehow.

Yes, more docs makes sense, though just to mention it's nothing better here
to use a full size of pointer: firstly it's not possible I think as 32/64
bits have different size of pointers...

More importantly, we're not sending the pointer but a marker, in this case
the size of the real pointer doesn't really matter, IMHO.  A marker would
make sense in saving some bytes when / if the array is large and sparse.

Said that, let's try above idea, maybe it's optimal as you said the script
can show things like "nullptr" (or any better name, I think that's better
than "null" at least to show it's not a real pointer, otherwise it's weird
to see any pointer in a migration stream..).

> 
> >
> > Instead of below comment, do we still have chance to change this to
> > something like "uint8"?  Then I suppose the script will be able to identify
> > this properly.

-- 
Peter Xu


