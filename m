Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ChzjT5AW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s2Ob7tfN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLhyR-0003Mw-Rw; Tue, 27 Oct 2026 10:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLhyQ-0003Mj-8a
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLhyN-0003fr-Fs
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793110577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jiQwtKbw1+xyNOVPriaLHEKG/t4l6qiVrdStY6KRO/I=;
 b=ChzjT5AWqCtADrjDmHZoR8uwFROYC7mc0CEvW/4d362j5CSnvOIRoSqszCpPFXmNA24p9V
 eNPhemRfCtO3eeHPBwO60j+mxJeoRHo6ay5dGFv07FeRuHaPZGeS05EGv4INtvPVOjOIzi
 xTW0uAabl7seR1c5HELoA4jzR19sOzo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-9gnTWmINNuKEBpZsfjWh6w-1; Tue, 27 Oct 2026 10:16:16 -0400
X-MC-Unique: 9gnTWmINNuKEBpZsfjWh6w-1
X-Mimecast-MFC-AGG-ID: 9gnTWmINNuKEBpZsfjWh6w_1793110575
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c4163a5400eso100845866b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793110575; x=1793715375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jiQwtKbw1+xyNOVPriaLHEKG/t4l6qiVrdStY6KRO/I=;
 b=s2Ob7tfNUp2dRod8UpV4joRCIMNsHwdvUZizT47e3RthvCmpHMY/N3O4vuf0JOqfPg
 4bVuLuyzIUMjUdGnstOOFwTqOYqoT/zfM6pmAwYCknaIPHrJUEDFnIY4qQTocLWUYncz
 VqkBMTIE3+jjE3QvEl9x9BeWVzSCuIofgN0NWcmNe1AnEsPURPOknnpsPXvjTk7NTjTS
 cMMTBRZ09D3Diqu7ge8Nq5vr3ny9285JARk1r5j+dxKL6txasKwcsh0hYMwYpvsyNeqT
 VJ/fsbQdpi86gGIM7CuE+rLGaWHLk8EvNWh4U1pv2+h5AyV0MHIV9Lglle5FV9MR4lr4
 HVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110575; x=1793715375;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiQwtKbw1+xyNOVPriaLHEKG/t4l6qiVrdStY6KRO/I=;
 b=yT1pAfR/7/lWJO6ZcwPJ4aK4upOhIdq8ZQtNwNJzQc/uK7b5JBmNCEneekHAOsmUtW
 NMYy60TDezSPULqIRaSw79ZUfZbI1MogG0KryYkMDRLuHD/ZcDWB0dViMZz9l/jAMgm4
 3kvuXeu3bpLJ3h6K31isJGOrr5UKB9Ep0Fshm2D1GULI5NkyXxg9FzQSLjtNQpMPgjCV
 uh1uPzuDN49T4/z3Sm5/DM/TNGfHkG39nqR3HYrBg32XQJSCpRm61O9bSzXE+rYRYiKv
 /w/BaSYWHV1G+TshEVpdTUsgLxcWRy2ClWWfxWj/XR3jW3Gjgf1zbbOp95P8SyYosObX
 dtuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZTsnTkErZxNq9fZrRXWtrDlf4vuCpiSwzqUXz87wZ1wlrHcgtZlyPMBYuTO7MTPLNmyyluXlnLxGx@nongnu.org
X-Gm-Message-State: AFq9FYKE4nCwEuI6nW1EUlt5nhlpv1IXACeE6EzyFs7BcGlrftkZWVCV
 k+T3RjnEjGGG206aDcQZLclwwxWeJwHG5EggHMbf04uPrTIzo32tPUZLTfj1VfezppVde2oIAR9
 laN/ZrRmtHy/5DqabSk+J4I+8TLsw5KCT+fKOGiE+KLYVZTelwFjMnas9DOLOxrlG
X-Gm-Gg: AYBFou2XKQWdX3fRbpCdkDCxSL4khKyVfudNbt2wazRS4mc84/ck1rRnQgv2apOZzoa
 EqiU5chXC2GTdu5daKN1e5+Mz+SvccVoFgSom5ExZwA9/6U/p+tBbiiMo0cBdtEWbQWCP0SKvDc
 fTuujkU06iCso6F0KBAxfQ0pXHU3q8er2CZWoEoIRJL2Vs3qI/I9qNn6tUPHSD0qrMFWmcqIiS6
 iIK6ln9FNKjHsDLmbGNycryhFM5xqPSFxCAbkTI2Uhk96AKoqMr0Tdc0lP15BO1f5FFYP72Ko0C
 wraCrRNpPe6i1C2U9rUawiTHgTCpObqY3OFkCjkRwJMMctocF2iqnhjiUfCNp4fAZDfUl378v/s
 Iytbe/2zawoGB3Tweies8/4HIbuEH0q86LlPfWbJp7i2K
X-Received: by 2002:a17:907:928c:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c49a7183184mr288432666b.3.1793110574739; 
 Tue, 27 Oct 2026 07:16:14 -0700 (PDT)
X-Received: by 2002:a17:907:928c:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c49a7183184mr288427966b.3.1793110574174; 
 Tue, 27 Oct 2026 07:16:14 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm19903970f8f.26.2026.10.27.07.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 07:16:13 -0700 (PDT)
Message-ID: <9a8e19fb-6733-45e0-8b81-b2878f0e723e@redhat.com>
Date: Tue, 27 Oct 2026 15:16:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/clean_functional_cache: tolerate missing .stamp
 files
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
References: <20261027140305.4027440-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261027140305.4027440-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/2026 15.03, Brian Cain wrote:
> Assets cached before the stamp files were introduced have no
> corresponding .stamp file.  The script already copes with that when
> reading the timestamp, by assuming the QEMU v10.1 release date, which
> makes such assets eligible for removal.
> 
> However, since commit c1bb594fe41, removing the asset also
> unconditionally unlinks its .stamp file.  For these old entries that
> file does not exist, so unlink() raises FileNotFoundError and the
> script aborts after deleting the first such asset, leaving the rest of
> the cache uncleaned and returning an error.
> 
> Pass missing_ok=True so that a missing .stamp file is not an error.
> 
> Fixes: c1bb594fe415 ("scripts/clean_functional_cache: Remove also .stamp files")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   scripts/clean_functional_cache.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
> index 1ff98c7606d..30633069c8f 100755
> --- a/scripts/clean_functional_cache.py
> +++ b/scripts/clean_functional_cache.py
> @@ -44,4 +44,4 @@
>           print(f"Removing {cache_dir}/{file.name}.")
>           file.chmod(stat.S_IWRITE)
>           file.unlink()
> -        stampfile.unlink()
> +        stampfile.unlink(missing_ok=True)

Reviewed-by: Thomas Huth <thuth@redhat.com>


