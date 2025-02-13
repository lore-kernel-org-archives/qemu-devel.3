Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D30C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaYm-0003ll-3f; Thu, 13 Feb 2025 09:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiaYf-0003lR-SC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiaYe-0002u1-6W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739458275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHCf/VDEtwcWK+XoBBaCJI+rdzqUpxlQ4pIa04kP6zY=;
 b=FML4v6fJmWstPP6j1iQ1pHsL7hJZ68EpGd4brf5mVZaiYiqN9Y+bL3egB4A9cW5If+If5Q
 lRHcSKJWwVuuKqhyXi7IvV8puhJb3ZPANKaFshDZ+vnCuAHBAGSjSZlACnmk5UfZ1RDIAK
 2NqgqYRmITdAs6RhHNReB/gG95MbR2w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-gpiziuSIN32EMFbUMtfoWQ-1; Thu, 13 Feb 2025 09:51:14 -0500
X-MC-Unique: gpiziuSIN32EMFbUMtfoWQ-1
X-Mimecast-MFC-AGG-ID: gpiziuSIN32EMFbUMtfoWQ
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e4605336b1so22462596d6.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739458274; x=1740063074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHCf/VDEtwcWK+XoBBaCJI+rdzqUpxlQ4pIa04kP6zY=;
 b=dgoepuYFmV5hisEc4E2/4ZrHhCuRxJaU/dZwABFfSjtS9lrPY6oVlh/RbvHQfMWWPo
 6YjRR8hwkFhH5iWFUwqSrL0q1djmMnlQ+cf4rXzJQt07hhpfjMTc8flu5agemNj1StSb
 cHmg0ZN95zkLuEPlrlgT6mYCNB261F7DeU/ZhW8XhK/8yZQ4nf0KBlgDdOZbaFEaGtN+
 lqbPij0Dbj8kLODNXSB474MVixSTL4XzuqufvSAdPgx7xG0RKOr2JMm4jGDYJUJsrowT
 2EaRATZKlpLZ2roefClRagHKosZP5q59h4pWu6x00eS2s7awNHkg0oszFZLTGH8xIvl6
 7lvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxWogDPfTqWjn/Jwg20/sJXz5f4desnnuB4XslzrhzutdrHR+IsSHdujKB/8Xlof/Eno6w7tEtsKZf@nongnu.org
X-Gm-Message-State: AOJu0YymwwTYb2sOSnI1Mv3QwQTVTM5Ex9QGjygcCf4KeGJeOd+JJXLQ
 pPV+havvm3Uea7a72Vf565tBy57SpjJ+boTXVisZUm7NdSN1FlBczbwyUhbwfcGpeKyKEp0cU92
 zV3zRUf6tnwoo6rodJpKktYa/jy0Hc4SIxHzAl7c0GY5Hy32qgtDZ
X-Gm-Gg: ASbGncs4H+zlcwywadIUqpbX1MBNYXNHFNJENulMC9GOfszes8iwBkgxxdz4djt8s9H
 lUaotwoe1p6YkKu8Hih0iWMKDXMsVNarai2+AdQ0r/0BmedR5WjVt96MOf1brpDopqiO/HPa2Va
 fKnr5LhgAco9NVNlXS4/x+qF6je2KeRBB4EAyJsvXR6xQCaHMhQMAgObwLVNqK0cBqMrkTIRE0e
 xeI+jjkfmlgTZS5MIeYagM5F4VdEvivasJWG0/DJD1rFHkFC8nV9lJmELQ=
X-Received: by 2002:a05:622a:992:b0:466:a9e6:6d6b with SMTP id
 d75a77b69052e-471bed12936mr50882671cf.15.1739458273850; 
 Thu, 13 Feb 2025 06:51:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAr/C2xzDPdgcCfjAahPAFBRgDWRLLXYTheId27J6iLWQnqSSX6+jaBLl9JKGpwiL35wYD6Q==
X-Received: by 2002:a05:622a:992:b0:466:a9e6:6d6b with SMTP id
 d75a77b69052e-471bed12936mr50882361cf.15.1739458273546; 
 Thu, 13 Feb 2025 06:51:13 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3afasm8418891cf.62.2025.02.13.06.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:51:12 -0800 (PST)
Date: Thu, 13 Feb 2025 09:51:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Zabka <git@zabka.it>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 0/7] physmem: teach cpu_memory_rw_debug() to write to
 more memory regions
Message-ID: <Z64G3l1XoJa0L25i@x1.local>
References: <20250210084648.33798-1-david@redhat.com>
 <c36fe3a8-9541-4775-a538-91eeb9d6e3a3@zabka.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c36fe3a8-9541-4775-a538-91eeb9d6e3a3@zabka.it>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 13, 2025 at 12:26:42AM +0100, Stefan Zabka wrote:
> Sorry for the delayed engagement, I failed to apply the patch set from the
> mailing list and had to remember that David had published this change set on
> GitHub.
> 
> Tested-by: Stefan Zabka <git@zabka.it>
> 
> This addresses my initial use case of being able to write to a single MMIO
> device. I have not set up a scenario with an interleaving of
> MMIO and RAM/ROM regions to ensure that a single large write is correctly
> handled there.
> 
> Reviewed-by: Stefan Zabka <git@zabka.it>
> 
> I don't know if this counts for anything, but I've read through the entire
> patch series, tried to make sense of it and couldn't spot any issues. It
> should be noted that I am a terrible C programmer and have only written
> basic devices so far.

Thanks, that's always helpful. It's already in a pull, but if I'll need to
respin the pull I'll attach the tags.

-- 
Peter Xu


