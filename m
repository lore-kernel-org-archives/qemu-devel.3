Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE607C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVIo-0006Le-C6; Mon, 26 Feb 2024 02:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reVIn-0006LS-2M
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:21:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reVIl-0000di-EO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708932086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIVo9S4WOuDIzTJRUiOTR8QVXnA1fNLj3NUSkkLJqP0=;
 b=CMA/L8V6SSbNQYEbiU+5zaiz8InHXeZQ4Ewl1m/yZBgeFsu+lA6lRhZMz8KcxOsWMjIwq6
 SrssDiyXv4lpa87x18kNy4gH/MsZYC/ePYcVtWDfKWoc0wz+d4rOsX2VGB7CtqoG3GYYxH
 6TeUujh7gh0DXzSFcWAFjLsYvMHI/Pc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-qioo0LpVPvG9h9v1TTj5jw-1; Mon, 26 Feb 2024 02:21:24 -0500
X-MC-Unique: qioo0LpVPvG9h9v1TTj5jw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e488dfc2dbso1131423a34.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708932084; x=1709536884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIVo9S4WOuDIzTJRUiOTR8QVXnA1fNLj3NUSkkLJqP0=;
 b=AyZPwDJqhEK/0MgTtlp58NsbghyGli1CsEYjr9vtZYFtcMB/oETNZdujlkSBR33H0U
 vIHhdJRNci5/MYVqUI2ArcMsKdbCsDSeGxw7J/r5/X7iwraHn5U+/T0H+qEtSie1wDmc
 7wErGtJNfvxXSBiTnKbMxfg6zYO3lprRALhlmPCyf+m2lVkvHcLvDUdRMkdKC9IiNR0z
 IoRFweX+lztU+cOouUSPY6O70T7FJfW+jYgsdeaFjYsvLVLR/6mgau8jB5XiBMsfHUE1
 3PniNVXkNxZfCDR5iiMW0fMOHlNLidBHhJW9U1/q2hF84jAxpbQDHNOMXXnhuSW1oUTD
 3LYw==
X-Gm-Message-State: AOJu0Yx0zo31oZ5Dl5BeD+2qT5dHB1rcljqdBOeInmHhA2di4HhV0kD3
 Scq15797vgduGLMuOcsJvT9OLgYMwj/l2w3GFzF9v18rEBRLlK6GYbiAQcL3loBQ6GknlBJ/aG3
 daPjtuqVIaSyndwfxlq6f+fDt2yE5KTJO7GcKSKQyorKDIDbN5RTL
X-Received: by 2002:a05:6358:88d:b0:17b:61ad:1585 with SMTP id
 m13-20020a056358088d00b0017b61ad1585mr5253352rwj.3.1708932084105; 
 Sun, 25 Feb 2024 23:21:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOalVLfAVWPfMaa3oFZYGLgjLumaG8fRTcRK6g+hIdcWYtDxS5dkiXlrp0TnqFHOWLJtBxJw==
X-Received: by 2002:a05:6358:88d:b0:17b:61ad:1585 with SMTP id
 m13-20020a056358088d00b0017b61ad1585mr5253340rwj.3.1708932083753; 
 Sun, 25 Feb 2024 23:21:23 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 a7-20020a62d407000000b006e47b5b67d1sm3524966pfh.77.2024.02.25.23.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 23:21:23 -0800 (PST)
Date: Mon, 26 Feb 2024 15:21:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 20/34] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <Zdw7623pJkvVEh9E@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-21-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-21-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Feb 20, 2024 at 07:41:24PM -0300, Fabiano Rosas wrote:
> +int file_send_channel_destroy(QIOChannel *ioc)
> +{
> +    if (ioc) {
> +        qio_channel_close(ioc, NULL);
> +    }
> +    g_free(outgoing_args.fname);
> +    outgoing_args.fname = NULL;

Ah another thing: we may want to have file_cleanup_outgoing_migration()
from the 1st day if possible..

https://lore.kernel.org/all/20240222095301.171137-5-peterx@redhat.com/

The other one was already in my queue, so feel free to rebase to
migration-next directly if before the next pull (I'll remember to push
soon; now it is in -staging).

Thanks,

-- 
Peter Xu


