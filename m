Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4710A88C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mWM-000103-Hz; Thu, 26 Mar 2026 11:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5mWK-0000zR-5Q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5mWI-0004k3-NL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774538473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfqQ4LWJKUt4YB9XN3BplVPrOCzjn5MqnnVBhBkKaVU=;
 b=IagN5ZWIqpUbOrXTkE/3mmjqiOAStd4qeiBfos3Y7/MEDO0I/8pwuHqg4gDBOjmGKtDFQU
 c5igCAoTgm+sYOuKJpmsJ3CrkudOwdwIEqIcku0p6kHgJFvBYFZxrLXrOEbB/kgi9gnhFR
 66LtapA40QDvrviM+C06cxeDi5F1E10=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-ogCvfvhfMyiNwdZn5xUNqg-1; Thu, 26 Mar 2026 11:21:11 -0400
X-MC-Unique: ogCvfvhfMyiNwdZn5xUNqg-1
X-Mimecast-MFC-AGG-ID: ogCvfvhfMyiNwdZn5xUNqg_1774538471
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899f474fae1so90612986d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774538471; x=1775143271; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TfqQ4LWJKUt4YB9XN3BplVPrOCzjn5MqnnVBhBkKaVU=;
 b=WO1JVuEayKd+ADN6XjUW0jJhc79mkFpDAWy2u2b9e/iQso7KNPNsEhN4MUM+qIgaSW
 OrRSsjpUXn0buEonVTm3dt1EcjqAHH2SgiAzJasFJUpjBxI9JzgSbZUaJbTrlUILNkLK
 k1stuxIdnKK8ZbSnknfKVffPcuYmhY5ZqqC7YnUoGwvMmgryN98rdukrYJN1E8AijgC0
 zuQl29I4V0+Bm3qrIHglywNIGxSpmagBbDA5UbGXBi5O2HzqFXcp93TT2bZvRTTCnvpz
 s72fLD/36ZYg7qTmMXGNNovI64IIMWbKg+HgogQEL7bUr9NkwJuW3aqtBibQuC+dtiqr
 oPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538471; x=1775143271;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfqQ4LWJKUt4YB9XN3BplVPrOCzjn5MqnnVBhBkKaVU=;
 b=C0ePsOnAQdV6MUuZAKIRC0eprGaqM09IOgM26ANBS0h7antElEEdD3FXdLVxkFPKRV
 60J0VTIU6fobyyhy/GWZYWFA8CukKtIKF0GA53Sdn6zTG27f5t0wEs4nKEhrAk/rIaAl
 500P7nuybqO1ntQuVN8NgJkoZoIo2P/7kzDuuQ8ukK2Pyr59f5XNLQSbXf2SGNbhYvym
 erkIPyM0XWMwgF+UyG/QgO+BR6NRRldk0DJx2ho7Sg9Rk1L3LmiqbXcXsUEcT4WZJVof
 NY2UMDAcrPMKR1vnvdt223AiDW5o8/cwl3+K0qUSPTsU1+zrfNuLMVUPwZqpAatnvimV
 EHAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhDDulPyOhmzzECGuqRW3Y5fm1Z8eyQsaUDHihcEuQn1OjZTaJLFHt18lYfi79S878KxrhDYXxlym6@nongnu.org
X-Gm-Message-State: AOJu0Ywoglhqs5k15XH6BtSzybH/dJxN6v9hPBfuyTidHupBDZVyOX/P
 bgJqD8eSzxZGjZhj84KwWX7HDgc0K2hmit33ygpzVwgB3S9uMwZU/GboywuKUU2Sb0KVeZAFGB6
 k9+Xnaj7rk1NoHlcozBwtqzTnmWhIdNeJoeUUGrKkt2I/rL1DXsLRMOjf
X-Gm-Gg: ATEYQzxDUr8HY8q9qAHERAqq2oPRbcOikLz4zIw5WSSdwsd7dHkyOJNZa6dQp7e2ddw
 kEz9sd6pRLubJYvSFPfX4V0/rrs0L+EKgMNYEICNGhJWf7eUPDbdlgdSCWlDAXxV2wvByMPVn86
 x5sU8diQ5ZJDymYxRUQ0oM9Oqfi/3eVxGxAtMffil2JEobPBZR8YRpoPk7C4Mt/T95yyVppIYsm
 CWdxWu0r37CK3G+AvevahQ33w9U1R6mggGygKdLa7KjLfW4LM9g/Zy8ayrv5dpvMjROwJn1pTlo
 IFSZUVVuMnKPynAxIVSPaNZDZnQQT2PS+ksSDr1Bz/aebAp5FN6z+jQn58N0x3oozQt1cAHK4ju
 gdBtsWdHEmFLa2A==
X-Received: by 2002:a05:6214:5c90:b0:89c:50fb:31c0 with SMTP id
 6a1803df08f44-89cdde0b110mr21357986d6.10.1774538470797; 
 Thu, 26 Mar 2026 08:21:10 -0700 (PDT)
X-Received: by 2002:a05:6214:5c90:b0:89c:50fb:31c0 with SMTP id
 6a1803df08f44-89cdde0b110mr21357526d6.10.1774538470286; 
 Thu, 26 Mar 2026 08:21:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd5ab2b13sm24619326d6.49.2026.03.26.08.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 08:21:09 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:21:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH v2 0/3] migration/file: fix type mismatch and NULL deref
 in multifd_file_recv_data
Message-ID: <acVO5HUVb18FlIYf@x1.local>
References: <20260316084618.52-1-junjie.cao@intel.com>
 <20260318140113.434-1-junjie.cao@intel.com>
 <20260324082738.841-1-junjie.cao@intel.com>
 <acJtbvE39JHM4g5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acJtbvE39JHM4g5c@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 10:54:38AM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 24, 2026 at 04:27:38PM +0800, Junjie Cao wrote:
> > Hi Peter, Daniel,
> > 
> > I wanted to follow up on this series.  Looking back, I went
> > straight to adding new public API in io/channel.  I should 
> > have confirmed my approach and whether the Suggested-by
> > tag was appropriate here with you before sending.  Sorry for that.
> > 
> > I see two possible paths and would appreciate your guidance:
> > 
> >   (a) Keep it purely a fix in migration/file.c: add a local
> >       retry loop around qio_channel_pread() in
> >       multifd_file_recv_data(), fix the ssize_t/size_t
> >       mismatch, and use ERRP_GUARD() so error_prepend()
> >       is safe.
> > 
> >   (b) If pread_all() retry helpers are worth having as a
> >       general facility in io/channel, I'm happy to propose
> >       them as a separate RFC so we can discuss the API design
> >       on its own merits.
> > 
> > I'm leaning toward (a) and can send a v3 quickly.
> > Does that sound right?
> 
> Doing (b) is the right approach. We want these helpers in the
> general code, so we don't create technical debt that has to be
> fixed next time something else wants the same APIs.

Sorry for a late response, Junjie.  I agree with Dan.

-- 
Peter Xu


