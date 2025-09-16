Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063EECAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 23:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyfOF-0001bR-EZ; Tue, 16 Sep 2025 19:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uyfOD-0001at-Q1
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 19:47:14 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uyfOB-000378-Nh
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 19:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=cFpqqjmyTjkLDa8ig/q/LF4psNpJt77xkFLf9d/EJ9s=; b=hEr2z5Qmuq9VpfP6
 k3o6oME0OIUGGpe0L3yoauS4x4sy3fRUF/27Cj/ElPVR3WxJq4KlLv1CRi+gJBSag42EPalRmhGpy
 qRsnClLGsTGTFRxKrMoK+PFsWUGnIYHwOlhQ9+NTa1V/7ijYK20/plrR34AtZvXNajNcc36V9jzEO
 V2oUljmIgSsk0XN9V8wGMfK7acecAh237F40b8np5DLrJ8JySIlkWBVFV4aeyOG6qXqXv7cemNQr5
 3Ip/htFOXKxwNS/T32A06bhAOB/wdurV8rd0NKRdsPMIeIsNMHLbg/9uB2VGmCqv83y7IA8GpUp1u
 RRPKzcAP6DyHO/Rl+Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uyfO2-00BTvT-0m;
 Tue, 16 Sep 2025 23:47:02 +0000
Date: Tue, 16 Sep 2025 23:47:02 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [CRM114spam]: Re: [PATCH v4 03/27] target/i386/mshv: Add x86
 decoder/emu implementation
Message-ID: <aMn29rg2b7yC7Iu7@gallifrey>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
 <aMmg_K8N1fKGUV4o@gallifrey>
 <DF061F5C-9807-4948-BD62-EC42425C5B9E@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DF061F5C-9807-4948-BD62-EC42425C5B9E@unpredictable.fr>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:37:17 up 142 days,  7:50,  1 user,  load average: 0.06, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Mohamed Mediouni (mohamed@unpredictable.fr) wrote:
> 
> 
> > On 16. Sep 2025, at 19:40, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> > 
> > For example 'x86_is_real' is declared in target/i386/emulate/x86.h
> > and defined in target/i386/hvf/x86.c  (hmm that's a bit weird).
> > So it's probably best to check if what you want already exists,
> > move it into target/i386 somewhere I guess, and everyone shares it.

> Currently there isn’t a backend-agnostic interface for this. 
> It was part of the import of HVF support to qemu from downstream.

Hmm.

> Notably means that the emulate infrastructure isn’t usable by multiple
> backends in the same build. It might be possible to get away without that
> however as HVF is macOS specific, MSHV is Linux-specific and WHPX
> (which is currently using winhvemulator instead of this) is Windows-specific...

It does scare me a bit having 2 different functions with the same name like that;
but hmm OK...

But - x86_is_real() is identical in these cases - the x86_is_protected() is the
implementation dependent bit.
The only bit that seems different is the reading of the register, eg. CR0, so there
could be a:

   x86_read_CR0(CPUState *cpu)
and the x86_is_real and x86_is_paging_mode all be shared (as inline's ???).

But this does all get messy - I mean, even if MSHV is Linux specific, and HVF
is macos specific; it's a shame that the logic behind x86_is_* is open coded
in all of tcg, kvm and copied twice in hvf and mshv.

(I don't understand the structure as to why some stuff needs backend specific
reads and some are in env).

Dave

> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

