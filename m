Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8750C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpny-0004Ec-Ri; Sun, 04 Feb 2024 22:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWpnv-0004Ck-Ud
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 22:37:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWpnu-0004ic-6j
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 22:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707104272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmNSOS3emoLQlbXCT+dymukG14BSblVa9L/Ry73vSJM=;
 b=WNUhXkfSveuDdByyGY+Ie9DJy4GbRj4wRqEVhIo0RcPPocMV44/MkcuKgIHWa6ILexmTWT
 +NgMGSiqtLOlvkcGJEkcEoKlIcjTj5IT81HlVwfzEMsgP4PkYm10PR+wASa3P464ZtvB7r
 OeeU7snGmW1evrp0VVZFhjgPbyEWs7g=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-67qoftxMNKydXoUZCwvdkg-1; Sun, 04 Feb 2024 22:37:51 -0500
X-MC-Unique: 67qoftxMNKydXoUZCwvdkg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e029a8a77fso97204b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 19:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707104270; x=1707709070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FmNSOS3emoLQlbXCT+dymukG14BSblVa9L/Ry73vSJM=;
 b=tHTecbHt3R7RAtEfT+ApOACGXJNLUY31QxBVWukVObQWqPZbG8PMYoVbZ7+HH7jaEn
 yGfw4zHTztRgH6UwX5SO0k4enPqBgWudvqYV95dNLx2/GD0WsWf7TCKo8u4lXIAzMc77
 qcCjgtTR5kq4yzpDAiNTidJPPtbd9ZfHhmYr+FP3VPWJDhFf1fklH01Wli7I4mTfpZi2
 +dFb5w39eUQxl8t7kqZ+E2HteSK53Neazx8bpYY8qbMFsRQiHnO4weTUBC7PIfcld+mD
 SqETPSPi4uJjJUbdtzvPw5/wcEPORSAjMliIGrIPtUJSjXInWU/yWpkA3YS9Pu8bE5Aa
 e9Gg==
X-Gm-Message-State: AOJu0Yyuf1+gw3tYapGnpLQ0UEriiOuRUbrkws/6rsUhJaQN5x4JRACt
 V6fqf/tVFErxbMU6JOF6pn+AGWlGzBMh29FCeS7ccBDoIqIujp3iQdUQy1kPg1ijj1C/6Lt3Dqs
 nHJYuA79KxG46zOtyhWA0L2LX68dr6AGwmbiTaO5AVGTxNWqZCRr1
X-Received: by 2002:a17:902:d345:b0:1d5:efd6:20f with SMTP id
 l5-20020a170902d34500b001d5efd6020fmr14031603plk.1.1707104270095; 
 Sun, 04 Feb 2024 19:37:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxfnpXUBR2w55ZGp0SaEQU4ik6JU+z/SHk/yDDFYqevyHTlbfRqSmSUILcNOWusJQteJ9iUQ==
X-Received: by 2002:a17:902:d345:b0:1d5:efd6:20f with SMTP id
 l5-20020a170902d34500b001d5efd6020fmr14031594plk.1.1707104269735; 
 Sun, 04 Feb 2024 19:37:49 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUzi60vgkS/bKgRKHBi8Xvgb6OdGpYdSnilyTwQ0Wa0/KpRGLk99jIWYdQpCb6b5NbuBjuzO8RwX8og4I5VM/Uus24zQWc=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm5248680plc.176.2024.02.04.19.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 19:37:49 -0800 (PST)
Date: Mon, 5 Feb 2024 11:37:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] migration: Fix return-path thread exit
Message-ID: <ZcBYBexsJ7X2yeZm@x1n>
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-3-clg@redhat.com> <8734ubhqr9.fsf@suse.de>
 <d2d0314a-494f-4ace-ba73-e14019fb4fd3@redhat.com>
 <87zfwihpf6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfwihpf6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 02, 2024 at 12:11:09PM -0300, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
> > On 2/2/24 15:42, Fabiano Rosas wrote:
> >> Cédric Le Goater <clg@redhat.com> writes:
> >> 
> >>> In case of error, close_return_path_on_source() can perform a shutdown
> >>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
> >>> 'to_dst_file' is closed before calling close_return_path_on_source()
> >>> and the shutdown fails, leaving the source and destination waiting for
> >>> an event to occur.
> >> 
> >> At close_return_path_on_source, qemu_file_shutdown() and checking
> >> ms->to_dst_file are done under the qemu_file_lock, so how could
> >> migrate_fd_cleanup() have cleared the pointer but the ms->to_dst_file
> >> check have passed?
> >
> > This is not a locking issue, it's much simpler. migrate_fd_cleanup()
> > clears the ms->to_dst_file pointer and closes the QEMUFile and then
> > calls close_return_path_on_source() which then tries to use resources
> > which are not available anymore.
> 
> I'm missing something here. Which resources? I assume you're talking
> about this:
> 
>     WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>         if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>             qemu_file_get_error(ms->to_dst_file)) {
>             qemu_file_shutdown(ms->rp_state.from_dst_file);
>         }
>     }
> 
> How do we get past the 'if (ms->to_dst_file)'?

We don't; migrate_fd_cleanup() will release ms->to_dst_file, then call
close_return_path_on_source(), found that to_dst_file==NULL and then skip
the shutdown().

One other option might be that we do close_return_path_on_source() before
the chunk of releasing to_dst_file.

This "two qemufiles share the same ioc" issue had bitten us before IIRC,
and the only concern of that workaround is we keep postponing resolution of
the real issue, then we keep getting bitten by it..

Maybe we can wait a few days to see if Dan can join the conversation and if
we can reach a consensus on a complete solution.  Otherwise I think we can
still work this around, but maybe that'll require a comment block
explaining the bits after such movement.

Thanks,

-- 
Peter Xu


