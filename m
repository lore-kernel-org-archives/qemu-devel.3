Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD78CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 09:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyoCc-0002uS-2k; Wed, 17 Sep 2025 05:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyoCU-0002pV-Hq
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:11:43 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyoCN-0002EM-FD
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:11:38 -0400
Received: from example.com (unknown [167.220.208.74])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4DA642018E76;
 Wed, 17 Sep 2025 02:11:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DA642018E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758100292;
 bh=DELkqFa+WUEmIjXhdSKy5BFZ62q5Bdfx7UueSqND+i4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kG9RlUbCFWRfkfg8FbR9X187sz9Ac8fQo6gOp05j4Apzy+FsO6O1RfG4PgGUDf7U1
 VaR3HLvKfg8X0V1JMgnIIwJgEj3+/ZOxcXdhNJTMLr8WnryZzw2TQR3XBUjnqSXqBl
 YmIMcQ2PwHqrz82pbsJar/k9DXlTRNOgUHZvxBhM=
Date: Wed, 17 Sep 2025 11:11:24 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
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
Message-ID: <aMp7PL3R+kEUfZH3@example.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
 <aMmg_K8N1fKGUV4o@gallifrey>
 <DF061F5C-9807-4948-BD62-EC42425C5B9E@unpredictable.fr>
 <aMn29rg2b7yC7Iu7@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMn29rg2b7yC7Iu7@gallifrey>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 16, 2025 at 11:47:02PM +0000, Dr. David Alan Gilbert wrote:
> * Mohamed Mediouni (mohamed@unpredictable.fr) wrote:
> > 
> > 
> > > On 16. Sep 2025, at 19:40, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> > > 
> > > For example 'x86_is_real' is declared in target/i386/emulate/x86.h
> > > and defined in target/i386/hvf/x86.c  (hmm that's a bit weird).
> > > So it's probably best to check if what you want already exists,
> > > move it into target/i386 somewhere I guess, and everyone shares it.
> 
> > Currently there isn’t a backend-agnostic interface for this. 
> > It was part of the import of HVF support to qemu from downstream.
> 
> Hmm.
> 
> > Notably means that the emulate infrastructure isn’t usable by multiple
> > backends in the same build. It might be possible to get away without that
> > however as HVF is macOS specific, MSHV is Linux-specific and WHPX
> > (which is currently using winhvemulator instead of this) is Windows-specific...
> 
> It does scare me a bit having 2 different functions with the same name like that;
> but hmm OK...
> 
> But - x86_is_real() is identical in these cases - the x86_is_protected() is the
> implementation dependent bit.
> The only bit that seems different is the reading of the register, eg. CR0, so there
> could be a:
> 
>    x86_read_CR0(CPUState *cpu)
> and the x86_is_real and x86_is_paging_mode all be shared (as inline's ???).
> 
> But this does all get messy - I mean, even if MSHV is Linux specific, and HVF
> is macos specific; it's a shame that the logic behind x86_is_* is open coded
> in all of tcg, kvm and copied twice in hvf and mshv.
> 
> (I don't understand the structure as to why some stuff needs backend specific
> reads and some are in env).
> 
> Dave

Hey Dave,

in preperation for the MSHV patches Wei Liu did rework the HVF x86
emulator code and abstracted it into target/i386/emulate, so we could
use prior art as much as possible. Since HVF had to perform similar
userland decoding/emulation of instruction on MMIO exits that was a
good fit. However, the requirements are not exactly the same.

Thus, in the current approach there is some duplication, like
`x86_is_real()` (which is sort of trivial and arguably could indeed
be inlined), but e.g. `x86_is_paging_mode()` would have different
implementations per accelerator target.

best,

magnus

