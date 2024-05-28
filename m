Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54673C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrPv-0007YL-3X; Tue, 28 May 2024 03:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBrPs-0007Xp-Uq
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:38:41 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBrPr-0002lX-8I
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716881919; x=1748417919;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=abu0sUee0cafc3kc0rYR7Esah/4YT8PWmQd8qxoclRA=;
 b=Q5a0X/xGWVWN62hsFrPC2UCAVvDUu2OWheF8HzybVNPHKmZExjbGSfYl
 7I2/sD79i9RisCkv+HB2/3wgYJZBVDQRDK802m6NmsMKBnducDTVJnQCf
 vk0WyOw+lKi7n5aivdFkbv6ZVxc2wcC3gYZEd5rkiU4qrhhdZJ+RzwvCS
 OY5rkDQ4srDBVRgcjcDjWpaOn/q31Zh0Mfj2D0pzJ4Nldy9QsOJRIBsSi
 XQdvY7l+C5q8Bz3Oi+RQWLEEkiAQco5azWNNWXCM9wDu66CvPnrLhzU79
 BRD4vj1+wrS+VNuy41OaDkI/pt9AZUIgDxa4Y3m1vb8Zj53Lve0sr/nT+ g==;
X-CSE-ConnectionGUID: ZxEK40ltTUiENYRysHDeSA==
X-CSE-MsgGUID: slIJOV9tTw2xJmOmRAwF2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="35724262"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="35724262"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 00:38:34 -0700
X-CSE-ConnectionGUID: CVlRLBfrQXCK8FN/Fwoe4g==
X-CSE-MsgGUID: l4j3CWuUTsawWcgfwF/VOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="35584999"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 28 May 2024 00:38:32 -0700
Date: Tue, 28 May 2024 15:53:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Message-ID: <ZlWNk46MF5uNa+ZC@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-2-zhao1.liu@intel.com>
 <20240527200504.GB913874@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527200504.GB913874@fedora.redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Stefan,

[snip]

> > diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/simpletrace-rust/.rustfmt.toml
> > new file mode 100644
> > index 000000000000..97a97c24ebfb
> > --- /dev/null
> > +++ b/scripts/simpletrace-rust/.rustfmt.toml
> > @@ -0,0 +1,9 @@
> > +brace_style = "AlwaysNextLine"
> > +comment_width = 80
> > +edition = "2021"
> > +group_imports = "StdExternalCrate"
> > +imports_granularity = "item"
> > +max_width = 80
> > +use_field_init_shorthand = true
> > +use_try_shorthand = true
> > +wrap_comments = true
> 
> There should be QEMU-wide policy. That said, why is it necessary to customize rustfmt?

Indeed, but QEMU's style for Rust is currently undefined, so I'm trying
to add this to make it easier to check the style...I will separate it
out as a style policy proposal.

[snip]

> > +trait Analyzer
> > +{
> 
> The Python version treats this as an API so that users can write trace
> analysis scripts. I see below that you're using non-doc comments. That
> suggests you don't see this as a public API that people can write trace
> analysis scripts against?

Yes, for the initial version, I'm not exposing it for now. It could be
exposed later if needed and then we can support multiple script builds
by defining multiple workspaces in cargo.

Thanks,
Zhao

> > +    /* Called at the start of the trace. */
> > +    fn begin(&self) {}
> > +
> > +    /* Called if no specific method for processing a trace event. */
> > +    fn catchall(
> > +        &mut self,
> > +        rec_args: &[EventArgPayload],
> > +        event: &Event,
> > +        timestamp_ns: u64,
> > +        pid: u32,
> > +        event_id: u64,
> > +    ) -> Result<String>;
> > +
> > +    /* Called at the end of the trace. */
> > +    fn end(&self) {}
> > +
> > +    /*
> > +     * TODO: Support "variable" parameters (i.e. variants of process_event()
> > +     * with different parameters, like **kwargs in python), when we need a
> > +     * simpletrace rust module.
> > +     */
> > +    fn process_event(
> > +        &mut self,
> > +        rec_args: &[EventArgPayload],
> > +        event: &Event,
> > +        event_id: u64,
> > +        timestamp_ns: u64,
> > +        pid: u32,
> > +    ) -> Result<String>
> > +    {
> > +        self.catchall(rec_args, event, timestamp_ns, pid, event_id)
> > +
> > +        /*
> > +         * TODO: Support custom function hooks (like getattr() in python),
> > +         * when we need a simpletrace rust module.
> > +         */
> > +    }
> > +}

