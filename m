Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22E606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=faGHcvYn;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o2HpV2V1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVyJG-0006bf-H3; Tue, 24 Nov 2026 16:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVyJE-0006ak-DX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVyJC-000764-Dx
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795556652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5mFMnQfqLqBcsGVBTvptUGU/KClWQ2w069v8ymKNOM=;
 b=faGHcvYnI29CgR8Z26W0qVEl9b9moJXNTC1tKcULPW3SWRX2GGkuBsHRuZsfi12OA5/myA
 ilQ/ahd/Xudaov9/WjAiXSiuaYOJgbhHebKsWdkZv6aNr7cUVNZXogatO+U8yo5nQCTtX/
 KHmKnytdRxufZQKjJq9pHzeCDPNe6Ac=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-lY8akLNePOe64He12hQVVw-1; Tue, 24 Nov 2026 21:44:08 +0000
X-MC-Unique: lY8akLNePOe64He12hQVVw-1
X-Mimecast-MFC-AGG-ID: lY8akLNePOe64He12hQVVw_1795556647
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so919549285a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795556647; x=1796161447; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y5mFMnQfqLqBcsGVBTvptUGU/KClWQ2w069v8ymKNOM=;
 b=o2HpV2V1kyekF9d+8lE7vPU3dai5keF8mxAsjyaqi+nq3Wk3+EybiE1BoXSJfSUUGd
 7DZTXp6NYU9D3PbQmP5TmAlGDVTYDT+1HQ3sxP0Hahepl+n6SvDOuGs5y1N2ZCG/6R8J
 jAA9qrhZ6CovL8F4ZPHGIlXNnK79WPwMGdK4ehdudIHvAyz/YGo2b/a0+pvuNBNCnSim
 rp6wu+s8nrAMq129OjmtjdK97oM/QYWozN++smC7CUpgLFlp8d7d4311pMcV6Dlc92nP
 DTZTj4iXy5O+BSzDQBu99JkVJZghANcAZ6Aj7vw7i7mYd3WtF1wbuFrjuTlH5s5Py6pm
 q7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795556647; x=1796161447;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5mFMnQfqLqBcsGVBTvptUGU/KClWQ2w069v8ymKNOM=;
 b=P8qN6cm25BxgxnKQOX5HOFDVdpr0pJ2siuQ9nM6o7+Ph/+GJuUR8Iv0b6ZnC4lryuZ
 j/5SDUCpoH69OQxZH7vV0p/gdSc/XrsXtPOxsTZrRq774h7/Fp2ZdEqnCxwnHiZ22nBR
 71W5IYRRQTwdkH/RADMsXduKd6IKbip2yKj6YBugshzSQ0aTsnBt2gk16iR0/Xzdb0hG
 /c0hCw7MlLQQgdbJVuChpXJ/mrl2bFA1rtCK2LJpjFUbiuWO/vA1zjZ2D/D7PcA1NtIu
 PdkweQ8XDF/l3VfQYNF4d4lX9KccDZYSFJZR3xRiKwKiYS/EMMAiM6yGPmPb1WFeHRtB
 63tw==
X-Forwarded-Encrypted: i=1;
 AL+hErEh3yEXkJAhAPBaknwSewc9RXqw8OyV64eEVBJo+uooDOyMsehrkpkqhzM2OuPAKaonVoFetnqvSmLG@nongnu.org
X-Gm-Message-State: APuU4Z9UPTQd2PPLkApAgk/jUpSA2vADOyOroXhTp3236ICkd2GwXxhH
 eVZtcnV3Useq/js7/TDhHXeYZ9hvjTTWVtg3eqDIaNxd9vcSTw8ZdVayQmcoNFGgDgC+T+UsARE
 Si2JqloTxwOO15gl3P+5XTfqUMWbCmJtk7Qbo7Pjge7L1TRcWeUc/yU2n
X-Gm-Gg: AZFdTZeNvYetymabhAxquibTJCqOuvYgiGmxwuVz970hmPjQAZGmBAoe2qPbpbrVVZE
 jUpLm4pwKU3OkBEEwaUDu7RTtFg4NDkOGZ/hjkAhIikFf5kan9kdX9gP0pT+zcNOg7LgtiLwMMg
 Ba4qF8vplrACd8QZCuJEHwh+Iqr4OkelgTQ17SSzHefCLxR3H+kKf4CfOXJafcr/pagawxSk0rD
 o3gBAlewNYz/H6WuC/AnfTlPZBc0wcfRy+HlMB0mCwziEOQmIyXmKBDzwbhFAYwknydEnF+NfU7
 w9KAzJG/bXF+EuQcIvd8Mgb84DaLDykMNwydT1MWwOpxcqqsfuCsMi+1S+vP8+kGTN5StelQiBM
 04FocsQWFWJB0L3SyxdlvseRQcc/w8zKVTExCVtr58zBw
X-Received: by 2002:a05:620a:2681:b0:943:faab:aabd with SMTP id
 af79cd13be357-949bab3e45bmr2500254685a.52.1795556647321; 
 Tue, 24 Nov 2026 13:44:07 -0800 (PST)
X-Received: by 2002:a05:620a:2681:b0:943:faab:aabd with SMTP id
 af79cd13be357-949bab3e45bmr2500249685a.52.1795556646681; 
 Tue, 24 Nov 2026 13:44:06 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb427388sm1136330185a.42.2026.11.24.13.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 13:44:05 -0800 (PST)
Date: Tue, 24 Nov 2026 16:44:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
Message-ID: <awYFJAYVWt5HPQLK@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
 <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_WhhhPudTRhCv8WW8=w_ZutWFKKyT=PRaCA4-Q3bVdwQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_WhhhPudTRhCv8WW8=w_ZutWFKKyT=PRaCA4-Q3bVdwQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 09:09:07PM +0000, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 21:05, Peter Xu <peterx@redhat.com> wrote:
> > OTOH, to me it'll be very helpful if we could provide what we want exactly
> > in cover letters and commit logs into AGENTS.md.  It can be either pure
> > formats, styles of expressions, best practices of comments, etc.  But
> > actually I'm not sure either, because IIUC very new models are getting rid
> > of skills people wrote and can do sometimes even better with shorter prompt
> > than complex + long prompts, so maybe we really only want to add the most
> > important prompts when we really want to do so.
> 
> What I want from a cover letter and commit message is the *human*
> intent behind the change. I don't want a robot's summary of the
> code changes. This to me is connected to the older idea of
> "explain why, not what" for commit messages and comments.

So my suspect is some modern AI models already do "explain why, not what"
well.  But yes, I fully understand the concern and share the feeling.

My comment was more about the challenge that we may not really be able to
execute on this one well.  And, IMHO, when we can't identify, we'll need to
fallback to start justify "if this is good cover-letter / commit log" then
we will accept AI generated contents.  Said that, as long as they're in
very good quality and helps QEMU community (also with the hope that it's
not already burnout all maintainers..), IMHO it's fine merging.

Thanks,

-- 
Peter Xu


