Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95392CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGlnd-0004If-BK; Tue, 13 Oct 2026 19:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGlna-0004IJ-Vv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 19:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGlnZ-0004U5-Ad
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 19:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791933643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ti+WBfKAd3qxk2N2tl59A9czu3js9FhgvWepCCLBWdg=;
 b=OwrgTq6Vc9ZS9AHYdqcM4WvkfYkDF76QFu5mcYiopwSqRQGKgMjARkIJadwdA5K+yU8T4f
 8MKoKRG8UisktsSTmoovaFK6DQZjkbRyWSrV4DcEogI7Qr1sBDZAnUaUHNA6F3/AfrCrVv
 hKWwswlZbFW0c8+UkHF9SpjtLHU4BMY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-CEtE6uYKO92VASYrfRBAeA-1; Tue, 13 Oct 2026 23:20:42 +0000
X-MC-Unique: CEtE6uYKO92VASYrfRBAeA-1
X-Mimecast-MFC-AGG-ID: CEtE6uYKO92VASYrfRBAeA_1791933641
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb93c874bso81291585a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791933641; x=1792538441; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ti+WBfKAd3qxk2N2tl59A9czu3js9FhgvWepCCLBWdg=;
 b=IMnqJ2VAwVHENOr6tomqGFcLPge0p33rMrN7WcKno1EeQTk8Vbfhl+AAR8rUsvBQvk
 /JeFaApkRh1H7yDNlZsJsR2SsktaOcg9wQupkE6f2r2QriGN0TORUraIcoNGzRq5UaE6
 v0wYhuikmkN6ZD3Axj8sJLK2xX7b9R8sfsqXMRcnma3mm3a4znZ5XCMA5U2Hz7TZ/G9E
 u02xirtI641/SCKK7/W8PltDbPL6ZgJuwuw0VaEl1sz7kxkysqhxVv4KC34NL+WNTv0V
 ROG5UNbPL4ve4nq2p4ffK7fdgqD0zrJQXgp/acTPJspFLXQO0czOeYoOI21MgFQ/UH2K
 ohCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791933641; x=1792538441;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ti+WBfKAd3qxk2N2tl59A9czu3js9FhgvWepCCLBWdg=;
 b=BtzVp+BnONBeuORdL+NU/Q/1M0rpdPsCYtbC1ZMstVZL63LVUITSleIZ2ATYhI2MEZ
 scjIhJoVoMUfBkU+rn5ZT92uz6kHIo1qWPGuqzCgGq49BqByEx2HkB9fswg/kF/6rN/X
 rDZxQK4W3DD7/34IqXKXkWX5Q++EiA3MMsj4jxV3fEebIKiXh8vpPKBdCtMLbLgg6odu
 Mh91Xr2kyEDoZNQZINFDVOynlbi5k04c7TswGA+Q0xHiq5NOEiU+ZnsObZ6i8xLXGQ4o
 hxs2j2QTV8rISCgsIVTyK7DsEJPR+gzzRJKN4XzIGVO535C4dvKpqH7EvkfIqmxF9oTs
 TQwA==
X-Gm-Message-State: AFq9FYJQRWFUrROJgDGhQEAVlo8nyiyGSCfTFwLtin8iNR0hYteh1/68
 Wk/RBW6Z2UgOFWd9EXzf+mCU4ZVaVqLSBNX4aLWRowutIRRpt3J3f1WmJ2XxuxpBpz6BZss6GAZ
 hURKjCZRzO4miG09UTF5WbWNP08RDGGfMxlz+u6jPbHyifDTtTagT8rG+
X-Gm-Gg: AYBFou1td1FEsb5N+/m8NRbPu6JrdRDnamREgSFAzt3hmwVL9LZzZVb8AAenRkWGjuR
 cs9QX4CRPPPdqTZt9EHIaQgdNG+kFuYO1gy/EB6Swb8LTon2KCHLQEXAu3+9UWsi/vPJ8MTIp6A
 5mjxrIpcry8DLSpBRXxrvcjKsu5CiKy58MiF91yPB3gr7tblCBK0sD24qX6ZRSMGmNk9Oau3W6c
 q7V6SWt0csqUrF/qkE/x8EIHJAj9ldHRes5WDtgv1OuFerAU26RL7MIdR+QL0jZs/iPfJDP90ah
 tP1YNng0Z/uH3aCjVL7FP+w5fmRSQYIHme3FDL4RtCuaTovqHiMz9rIxdGdqcYKPBYz46RA=
X-Received: by 2002:a05:620a:4455:b0:93e:acdd:b5f7 with SMTP id
 af79cd13be357-93ec13250aemr2087175585a.1.1791933641363; 
 Tue, 13 Oct 2026 16:20:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4455:b0:93e:acdd:b5f7 with SMTP id
 af79cd13be357-93ec13250aemr2087172885a.1.1791933640841; 
 Tue, 13 Oct 2026 16:20:40 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef502497bsm358046085a.17.2026.10.13.16.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 16:20:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 19:20:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, mjt@tls.msk.ru
Subject: Re: [PATCH v2 0/3] releases: build and run any QEMU release easily!
Message-ID: <as68xiVXLzHVdpvV@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
 <as6d-7bwBOyz88hq@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <217d7743-f441-444c-9ea3-7de07bdd3b21@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <217d7743-f441-444c-9ea3-7de07bdd3b21@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 13, 2026 at 02:16:47PM -0700, Pierrick Bouvier wrote:
> Is there something specific you would need for migration purpose that is not
> covered yet?
> 
> If we go in this direction, and decide to host official images somewhere, we
> could even add the wrappers by default for all builds, so everyone could
> have ./build/releases/vX.Y/qemu-* scripts generated by default when typing
> make or ninja.

To me, the build container would already simplify things auto-select the
base image, making the build smooth; I don't have personal use yet for
official images.

I think Fabiano's testing env is better than mine using this similar
approach, it's just that I hardly hit a bug, especially, QEMU bug in the
past, that breaks migration ABI in a way that A<=>B works, B<=>C works, but
A<=>C fails.

Here, if we make A=master, B=release-N-1, C=release-N-2, then the migration
compat test in CI (on whatever migration-test covers... obviously not full
device coverage yet) guarantees A<=>B, and then B<=>C too in previous dev
cycle, and so on.  I expect A<=>C works.

I am assuming the ABI compatibility chains like that until very old qemus
when Fabiano introduced the compat test.  Then I hoped we had good coverage
even without a large matrix of qemu versions to test.

I only need to do a custom build in extremely rare cases.  There, patch 2
should be very helpful already.

So I'll leave that to you all to decide how far we go, or whether we need
to host official images.

Thanks,

-- 
Peter Xu


