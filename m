Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C5F53D9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2FG8-0004fG-5Z; Mon, 16 Mar 2026 17:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2FG3-0004eu-VL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2FFy-0001yo-FO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773695624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDnjLXiSfCsawK6xlGGH7II18vV+sWm4qRMciFU4+K0=;
 b=Yt5a4E4xtAQ6uRHg/hwd+9zKa2JWsFXBI88HEXBPGeaZPZl26/Hew7Cx39T0dGh9rTMc5x
 qGBdWZqodLnwz/TWXAhRtQhbA6+VQTvDka5YKVm57uOlLNipLy5M1JV5eKLWO4MvCTNGfF
 oC5vtnLf9Kuz4LgPYOS2H6fYogAnC68=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-SzejT2NkOP-fD5COHnQOGw-1; Mon, 16 Mar 2026 17:13:42 -0400
X-MC-Unique: SzejT2NkOP-fD5COHnQOGw-1
X-Mimecast-MFC-AGG-ID: SzejT2NkOP-fD5COHnQOGw_1773695622
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89a0a2afc55so28346106d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 14:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773695622; x=1774300422; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CDnjLXiSfCsawK6xlGGH7II18vV+sWm4qRMciFU4+K0=;
 b=CuFvXiVULx0pc+jZxfGB/E5w08S3rZM1OG7KZ+mMBlikjZJQhhtT2cn5OxMMbuLHIg
 YefNaNNMSwImO+IklFgcX2v2Oq2rNngvpIdQGFndcS5Tx3rnSLf7HemI7XiUGO4a7V5u
 96Sy4xtBzL8IAXhlO2NPphFMIYKru5eIb9KB7lGKlnGNjm9j0iIr5JiynH+t3u+A4F7M
 OlSuxSF2hgqyiujn7zW4MRQWpfLIOW2ulsKsk66KIST2wBwY7reJ/lJXsdcCIQ9gAq09
 rnivYBhvgG704jFzrWyflIZMCLM0ZGNSC+vWJaiydte3s2/W/13tMlf2rH5ibH+6Ej1Z
 sNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773695622; x=1774300422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDnjLXiSfCsawK6xlGGH7II18vV+sWm4qRMciFU4+K0=;
 b=NNjWzlngkntn6mq9RYutshPR9op0u9UyRdK8NLsdfBvAyQ82lBttZ2+u3+JfKDmv7u
 vXdUqjUVwPl7LhbXQgvBuQasOmUW+dtlJy1y4iO2lmT40Kdy9PkaiiNX1UqhOx98SzHu
 Pp9Ji9GcURR8Fx0BCMAoKToOlP25VMpj3ybAUunErIP3lHYMuTkRlIh3fFklrAmaoVQr
 nuCgIBLVDynYCnBmSo3bHrSyzZSNyazsxIeoWPpg03685lnnym2E6/NeWTbSheeiz8PW
 L2STH6A+rUfhioXgQ1zSubBkBKkFNBZI4eq/etYeueMDtgTq5VzYU6VE2c4WMsrgZwYI
 kBBA==
X-Gm-Message-State: AOJu0YymI1joWdfhBQb6vFQipY0wLbRIdqGgl+6HBQ9YeOZJxIvVba5q
 Brlv8q5km99ENJQLHenLwMlhQdnlMIw6zeTzzzMP4kWFMAwbLb4EkP0PXIDLLCMxLJVPdwLCJvD
 hs1XnJqgF75Gi1sIdSdPBjXTlCP6pq72pmoK0fdgJ1Ij0+QZsUatBY6uqE5FoSpFe
X-Gm-Gg: ATEYQzxRsLr2DgFEsWYW0nhkcHrO2O8lQs+cpwthLBfig5a99SXgf1RR9g8lvZhSrpf
 2wEoWoMWGn+IXeTGN6ABCsHuGHNmnKb3l6LXwy/xlPpM0QsLuTU2Uxcn7kpeNC9n9snOO2glN4+
 WwMvxPkHZBbWw5c/IMhvNC289+Bxg3547txlwHOfYjM3B3Tc2QlvXmBJGsxxxxuw19taA0qG/k1
 xADULeXTRD91IK71F6VE/lzXDESNlYXNHoYrbZEVf/MMcoX0avHLE0ssrn9e+SalRkpZSkmbICb
 5oly13h3ffKO+id1mZVOIBxuGMoXi1M0JhLReFZXpwwArn6dmTrJ/PIxwUrQolsJFa2BOTSOI6c
 /o8ZY6Y6zUbs0Tg==
X-Received: by 2002:a05:6214:48f:b0:896:f5b1:87b2 with SMTP id
 6a1803df08f44-89a81f5285cmr221197546d6.40.1773695621948; 
 Mon, 16 Mar 2026 14:13:41 -0700 (PDT)
X-Received: by 2002:a05:6214:48f:b0:896:f5b1:87b2 with SMTP id
 6a1803df08f44-89a81f5285cmr221197186d6.40.1773695621463; 
 Mon, 16 Mar 2026 14:13:41 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65bd5842sm123789116d6.11.2026.03.16.14.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:13:41 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:13:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1] migration/savevm: Allow stub VMSDs
Message-ID: <abhyg_wRK4_RmqdO@x1.local>
References: <20260316194759.22672-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316194759.22672-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 16, 2026 at 04:47:59PM -0300, Fabiano Rosas wrote:
> After the referenced commit, empty VMStateDescription objects declared
> as part of stubs have started reaching the vmstate code.
> 
> A valid VMStateDescription must at minimum have a name and either the
> .fields or .unmigratable fields set. Stubs, being empty, have
> none. Code that assumes a non-NULL name field will now cause a
> crash. E.g.
> 
> $ ./build/mips/qemu-system-mipsel -nographic -drive if=none,format=qcow2,file=dummy.qcow2
>     [Type "C-a c" to get the "(qemu)" monitor prompt)]
>     (qemu) savevm foo
> 
>     Backtrace from doing this under gdb:
> 
>       #0  0x0000555555df7d4d in vmsd_can_compress (field=0x5555564f78a0
>       <__compound_literal.3>) at ../../migration/vmstate.c:339
>       #1  0x0000555555df7dbb in vmsd_desc_field_start
>           (vmsd=0x555556431ba0 <vmstate_cpuhp_state>, vmdesc=0x555556918690,
>       field=0x5555564f78a0 <__compound_literal.3>, i=0, max=1) at
>       ../../migration/vmstate.c:362
>       #2  0x0000555555df85a7 in vmstate_save_state_v
>           (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
>       opaque=0x555556c9aac0, vmdesc=0x555556918690, version_id=1,
>       errp=0x7fffffffc948) at ../../migration/vmstate.c:528
>       #3  0x0000555555df8032 in vmstate_save_state
>           (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
>       opaque=0x555556c9aac0, vmdesc_id=0x555556918690, errp=0x7fffffffc948)
>       at ../../migration/vmstate.c:427
>       #4  0x0000555555df8f83 in vmstate_subsection_save
>           (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
>       opaque=0x555556c9aac0, vmdesc=0x555556918690, errp=0x7fffffffc948)
>           at ../../migration/vmstate.c:695
> 
> Due to their very nature, it's better to allow stubs to be
> completely empty instead of forcing any rules. Teach the code to skip
> them.
> 
> Fixes: 7aa563630b ("pc: Start with modern CPU hotplug interface by default")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/savevm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index dd58f2a705..e8d3360877 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -861,6 +861,10 @@ static void vmstate_check(const VMStateDescription *vmsd)
>      const VMStateField *field = vmsd->fields;
>      const VMStateDescription * const *subsection = vmsd->subsections;
>  
> +    if (!vmsd->name) {
> +        return;
> +    }

IIUC this is fine but isn't needed for stubs' use case, because "field" is
checked right below..

> +
>      if (field) {

.. here.

>          while (field->name) {
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
> @@ -897,6 +901,11 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
>  {
>      SaveStateEntry *se;
>  
> +    if (!vmsd->name) {
> +        /* assume it's a stub and ignore */
> +        return 0;
> +    }

Two questions on this one..

(1) when someone adds some new VMSD to device and forgot to attach a name,
    it'll silently ignore that new VMSD.. of course anyone testing this
    will find something strange, but silently ignoring an VMSD when not
    having name does sound like unexpected..

(2) would this fix the above crash?  The problem is the commit got fixed
    used VMSTATE_CPU_HOTPLUG which is an internal vmsd, this one only
    checks the top VMSD (which should have a name here..).  So I'm not sure
    if it'll work..

Is that MIPS board the only one that is broken?  Do we want to make sure
nothing is missed? We can definitely decide to break the migration, but we
can also choose to just revert the needed() back to normal.  It just that
it looks like we don't strongly need to break it.. as I don't see what we
get from breaking it yet.. (say, it's not like we can get rid of some weird
API or legacy function, we need to support needed() anyway..)

> +
>      /* If this triggers, alias support can be dropped for the vmsd. */
>      assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
>  
> -- 
> 2.51.0
> 

-- 
Peter Xu


