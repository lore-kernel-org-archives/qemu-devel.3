Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97858CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkrM-0003Wa-2Y; Wed, 20 May 2026 13:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPkrJ-0003W5-Tg
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPkrI-0007MN-Io
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779298647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syod9bGR6LBM+lDfkkXn5aFBZOGyIvjiNhM8ILGJMWU=;
 b=jFuDXJGcL0juB3kR2IMHzV1i7JdH1QwDmPbEG3PiNNBBqDJvMBHONG49Rm8Kp2JSsGbDIH
 9M5P/CUZzfS6xaehGTpww9wIJcASxivEcILnYT8932ZOUrqzfg1HBWXZVWKoQ8qjuKZMGw
 UODXHHzvU25EjTxnR+eExC7GcSKNbYs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-NC913lm_PXC7_XkB0xKz5w-1; Wed, 20 May 2026 13:37:26 -0400
X-MC-Unique: NC913lm_PXC7_XkB0xKz5w-1
X-Mimecast-MFC-AGG-ID: NC913lm_PXC7_XkB0xKz5w_1779298645
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b3fe2f190bso149771766d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779298645; x=1779903445; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=syod9bGR6LBM+lDfkkXn5aFBZOGyIvjiNhM8ILGJMWU=;
 b=QXsIvrPAO4/idLld6/Mf3vqzri8Epdc68+mgi0dVT/v3TDsbAAnc7qPabvTPHesHyd
 /XmMtrtifb19rJxDGJE/BXqNhzAeY8CH5scwBPemvINyf2FjpuAveC+17t97zK41TU4c
 H9eg4pypaSFMcku29FgKJrneQsXg1WiYQlcijgTbUkvNwpQhuo+ohpNQYlAjFhOMRGZw
 JryjdvS9fQuganR2xQaHYxX3fRuYHgUHyWhc5sJnycrkSMN+XqVmLsEhoLJcq2ifEi69
 J8gCJS4IF+zoZaUiTSQsJjPk+j5AMwWiiw5AvLmW9uxzAdEDQi5ZoicPpfI4PCnIifIH
 NzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298645; x=1779903445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syod9bGR6LBM+lDfkkXn5aFBZOGyIvjiNhM8ILGJMWU=;
 b=X8xjNNuNOk0LbTgSHFv0khzDybKPpW7yqf3IjRICrn4Dy0bNjocpkg8279cropCwc8
 SdL32LEyS4cFJfDWx4nXU1N3xRazdbI10VeLDoFIK0HrTm/2iB+bEZi66rZ+bV6odYdB
 mTxkm1inN7e+L9hHeBFF6iEMrbt/1gYQbUXmYr+ASeOn/Lzk/mDcweUBhptwHgpFLryy
 RyamBehaLyGdq+LOk5/4ZQvj+LrKd75oZmTFO8wUMG6WY7cA2g8mdC8hH7PbF860Qi/e
 i6wH1Jc4DmnUjvDYj3JPJZ82iyBER+5uawkrwJcLvJNeTRf8EAzC9s7WOwPiT8Q3eBNa
 YdPw==
X-Gm-Message-State: AOJu0Yw4OY46QviLbJK4+7JR60sWcKmIBHpPp0NRSMXFcKZu6oNhPyA/
 jWTcgmShmqwvzmX3Km6NJLFxOuh8o6467x0l0EPrEA5W7lGZGzpRx0hY+7VB5+dNRpJl7ytZWjP
 yzqzZHDH0kWOkLKoGF+Sk7SWM3sXruZkQ9zJ/85aG2dhkz3LLWEkcAiiCkNEMjMh3
X-Gm-Gg: Acq92OGgj14EBGJWMvXAliqGdop1gGYtKEnwu5qXsucSXtNXxazDk3/iL/atK26bBFF
 4I74AirSHNmT95JbjF/xcTQVacFYUxmWIIus5g4Z07gCsPN+U75+ki+Iyu9v/byp1gwyGfjPGm/
 O8aglij9+zDQD/Fr90EsGc3Eo48aGsfXkV3MyI6dRfwWSjWJSR7/SaU7U5EIIYPpT52xU1j73Xf
 UZQA7hbtCSHSsbir8BDgSdziXnsL2hygDPqg23QRmrMFciawjgzhslsq3P/rAwwqFf91H+KMUgm
 VEOM8AkVl3oTjb9OqCe8mu7lxNu4x3hOEOi3p18NZNfcGKm/JshrRoWRav2dKoRrsRUemikLrqf
 KqYwLY5tRza0AKXSIVyF+odk0nJ17bO5rWckS8B9oPJlMGLQyiWewcC0TAA==
X-Received: by 2002:a0c:c24e:0:b0:89a:116b:e67d with SMTP id
 6a1803df08f44-8ca0f6b365cmr257959706d6.37.1779298645262; 
 Wed, 20 May 2026 10:37:25 -0700 (PDT)
X-Received: by 2002:a0c:c24e:0:b0:89a:116b:e67d with SMTP id
 6a1803df08f44-8ca0f6b365cmr257959366d6.37.1779298644790; 
 Wed, 20 May 2026 10:37:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca36094f6bsm136234476d6.11.2026.05.20.10.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:37:24 -0700 (PDT)
Date: Wed, 20 May 2026 13:37:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 12/15] tests/qtest/migration: Use defer for
 auto-converge
Message-ID: <ag3xU2x6Fp8wQSdN@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 05, 2026 at 01:09:11PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


